Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47FBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27E72071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfLBWFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:05:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:49136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbfLBWFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:05:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9492B2ED;
        Mon,  2 Dec 2019 22:05:45 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     Cheng-Yu Lee <cylee12@realtek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [RFC 2/5] hwspinlock: Add Realtek RTD1195 SB2
Date:   Mon,  2 Dec 2019 23:05:32 +0100
Message-Id: <20191202220535.6208-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202220535.6208-1-afaerber@suse.de>
References: <20191202220535.6208-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a driver for hardware semaphores found in RTD1195 SoC.
It allows for both per-register instances (SB2_HD_SEM) as well as
contiguous register ranges (SB2_HD_SEM_NEW[0-7]).

While these registers are part of the SB2 syscon, this implementation
does not use syscon, to allow assigning one as SB2 syscon's hwlock.

Cc: Cheng-Yu Lee <cylee12@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/hwspinlock/Kconfig           |  11 ++++
 drivers/hwspinlock/Makefile          |   1 +
 drivers/hwspinlock/rtd1195_sb2_sem.c | 101 +++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/hwspinlock/rtd1195_sb2_sem.c

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 37740e992cfa..9c26c436d399 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -28,6 +28,17 @@ config HWSPINLOCK_QCOM
 
 	  If unsure, say N.
 
+config HWSPINLOCK_RTD1195_SB2
+	tristate "Realtek RTD1195 SB2 Hardware Spinlock device"
+	depends on HWSPINLOCK
+	depends on ARCH_REALTEK || COMPILE_TEST
+	default ARCH_REALTEK
+	help
+	  Say y here to support the Realtek Hardware Semaphore functionality,
+	  found on the RTD1195 and later SoC families.
+
+	  If unsure, say N.
+
 config HWSPINLOCK_SIRF
 	tristate "SIRF Hardware Spinlock device"
 	depends on HWSPINLOCK
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index ed053e3f02be..d5bd59412468 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_HWSPINLOCK)		+= hwspinlock_core.o
 obj-$(CONFIG_HWSPINLOCK_OMAP)		+= omap_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
+obj-$(CONFIG_HWSPINLOCK_RTD1195_SB2)	+= rtd1195_sb2_sem.o
 obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
diff --git a/drivers/hwspinlock/rtd1195_sb2_sem.c b/drivers/hwspinlock/rtd1195_sb2_sem.c
new file mode 100644
index 000000000000..ae925d057874
--- /dev/null
+++ b/drivers/hwspinlock/rtd1195_sb2_sem.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RTD1195 SB2 hardware semaphore
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+#include <linux/bitops.h>
+#include <linux/hwspinlock.h>
+#include <linux/idr.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include "hwspinlock_internal.h"
+
+struct rtd1195_sb2_sem {
+	struct platform_device *pdev;
+	void __iomem *base;
+	int base_id;
+	struct hwspinlock_device lockdev;
+};
+
+static DEFINE_IDR(rtd1195_sb2_sem_idr);
+
+static int rtd1195_sb2_sem_trylock(struct hwspinlock *lock)
+{
+	void __iomem *reg = (void __iomem *)lock->priv;
+
+	return readl_relaxed(reg) & BIT(0);
+}
+
+static void rtd1195_sb2_sem_unlock(struct hwspinlock *lock)
+{
+	void __iomem *reg = (void __iomem *)lock->priv;
+
+	writel_relaxed(0, reg);
+}
+
+static const struct hwspinlock_ops rtd1195_sb2_sem_hwspinlock_ops = {
+	.trylock	= rtd1195_sb2_sem_trylock,
+	.unlock		= rtd1195_sb2_sem_unlock,
+};
+
+static int rtd1195_sb2_sem_probe(struct platform_device *pdev)
+{
+	struct rtd1195_sb2_sem *sem;
+	struct hwspinlock *lock;
+	struct resource *res;
+	int i, num;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	num = resource_size(res) / 4;
+
+	sem = devm_kzalloc(&pdev->dev, sizeof(*sem) + num * sizeof(*lock),
+			   GFP_KERNEL);
+	if (!sem)
+		return -ENOMEM;
+
+	sem->pdev = pdev;
+
+	sem->base = of_iomap(pdev->dev.of_node, 0);
+	if (!sem->base)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		lock = &sem->lockdev.lock[i];
+		lock->priv = sem->base + i * 4;
+	}
+
+	platform_set_drvdata(pdev, sem);
+
+	sem->base_id = idr_alloc(&rtd1195_sb2_sem_idr, sem, 0, 0, GFP_KERNEL);
+
+	return devm_hwspin_lock_register(&pdev->dev, &sem->lockdev,
+		&rtd1195_sb2_sem_hwspinlock_ops, sem->base_id, num);
+}
+
+static const struct of_device_id rtd1195_sb2_sem_dt_ids[] = {
+	{ .compatible = "realtek,rtd1195-sb2-sem" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rtd1195_sb2_sem_dt_ids);
+
+static struct platform_driver rtd1195_sb2_sem_platform_driver = {
+	.driver = {
+		.name = "rtd1195-sb2-sem",
+		.of_match_table = rtd1195_sb2_sem_dt_ids,
+	},
+	.probe = rtd1195_sb2_sem_probe,
+};
+module_platform_driver(rtd1195_sb2_sem_platform_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hardware spinlock driver for Realtek RTD1195 SB2");
+MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");
-- 
2.16.4

