Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C3DC10F0D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD8720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="ddaiOm1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCDW30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:29:26 -0500
Received: from tomli.me ([153.92.126.73]:44168 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfCDW3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:29:25 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 9abce6f4;
        Mon, 4 Mar 2019 22:29:22 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Mar 2019 22:29:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=kieGshjoAXm2sPzM8x4a4gyWiyfT4mzaoi/5S4qitWg=; b=ddaiOm1IAI/ZpgQMqEvdX01fYo2V93deLEC5x18Ev7c6sKI5DdfnW/BBmrxMvFOfmsAWWpnYRlvDUsCICEknljgeeCL9M4ZqbPCRB0UV74YDGzd7TxOpsmukRQfKvmeTFnZR4MNGJcYWKKCfczDPM3P5MfrOskQmBdvkV1z46ePr35sIt97YMAdFmvSh+u9kjwfv3H4OYmcKAEa7cqwYsf6jozWXi8c19bVzo2pXUkcpe9H7YNmfMJeIOOhDNxt0HHfvqq9yQEQjIieCSPg0/vJfT6wS7HosBZwS1ciKdFbKOnuuca0IbmjOKirSdSL7esyy0cOMFUBkcueC014Xaw==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] mips: loongson64: register per-board platform drivers for lemote-2f
Date:   Tue,  5 Mar 2019 06:28:46 +0800
Message-Id: <20190304222848.25037-6-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304222848.25037-1-tomli@tomli.me>
References: <20190304222848.25037-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, common/platform.c registers the Loongson 2F cpufreq driver
during boot time for all boards. To support platform drivers for Lemote
Yeeloong laptops, we need to register more drivers.

First, we add support for per-board platform drivers. Just like how IRQ,
DMA, or reset logic is implemented for each board, we introduces a call
of mach_platform_init() in common/platform.c, to allow each board to have
its own platform.c to register platform drivers.

Then, we implement lemote-2f/platform.c to register the MFD driver for
Yeeloong laptops.

So far, only one board, lemote-f2, is using this facility, so we hardcode
the call of mach_platform_init() in common/platform.c as a ifdef for now.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 .../include/asm/mach-loongson64/loongson.h    |  3 ++
 arch/mips/loongson64/common/platform.c        | 15 ++++++
 arch/mips/loongson64/lemote-2f/Makefile       |  2 +-
 arch/mips/loongson64/lemote-2f/platform.c     | 47 +++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/loongson64/lemote-2f/platform.c

diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index b6870fec0f99..0ea43479d9f8 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -23,6 +23,9 @@ extern void bonito_irq_init(void);
 extern void mach_prepare_reboot(void);
 extern void mach_prepare_shutdown(void);
 
+/* machine-specific platform driver registration */
+extern int mach_platform_init(void) __init;
+
 /* environment arguments from bootloader */
 extern u32 cpu_clock_freq;
 extern u32 memsize, highmemsize;
diff --git a/arch/mips/loongson64/common/platform.c b/arch/mips/loongson64/common/platform.c
index 0ed38321a9a2..f8a205bae5da 100644
--- a/arch/mips/loongson64/common/platform.c
+++ b/arch/mips/loongson64/common/platform.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/smp.h>
 #include <linux/platform_device.h>
+#include <loongson.h>
 
 static struct platform_device loongson2_cpufreq_device = {
 	.name = "loongson2_cpufreq",
@@ -29,3 +30,17 @@ static int __init loongson2_cpufreq_init(void)
 }
 
 arch_initcall(loongson2_cpufreq_init);
+
+/*
+ * Currently, only LEMOTE_MACH2F implements mach_platform_init();
+ * Fuloong-2E or Loongson3 does not have platform drivers to register
+ * at here yet.
+ */
+#ifdef CONFIG_LEMOTE_MACH2F
+static int __init loongson2_platform_init(void)
+{
+	return mach_platform_init();
+}
+
+device_initcall(loongson2_platform_init);
+#endif
diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
index ac97f14ea2b7..2b18752424ee 100644
--- a/arch/mips/loongson64/lemote-2f/Makefile
+++ b/arch/mips/loongson64/lemote-2f/Makefile
@@ -2,7 +2,7 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += clock.o machtype.o irq.o reset.o dma.o
+obj-y += clock.o machtype.o irq.o reset.o dma.o platform.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson64/lemote-2f/platform.c b/arch/mips/loongson64/lemote-2f/platform.c
new file mode 100644
index 000000000000..c8a8c597e384
--- /dev/null
+++ b/arch/mips/loongson64/lemote-2f/platform.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
+ *
+ * Copyright (C) 2019 Yifeng Li
+ * Author: Yifeng Li <tomli@tomli.me>
+ */
+
+#include <asm/bootinfo.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/yeeloong_kb3310b.h>
+
+static struct kb3310b_chip yeeloong_ec_info;
+
+static struct platform_device yeeloong_ec_device = {
+	.name = "yeeloong_kb3310b",
+	.id = -1,
+	.dev = {
+		.platform_data = &yeeloong_ec_info,
+	},
+};
+
+int __init mach_platform_init(void)
+{
+	/*
+	 * arcs_cmdline is __initdata, which will be freed after boot and cannot
+	 * be used. We extract the EC version string from it, and pass it to
+	 * yeeloong-kb3310b driver as platform data.
+	 */
+	static const char token[] = "EC_VER=";
+	char *p;
+
+	p = strstr(arcs_cmdline, token);
+	if (!p)
+		memset(yeeloong_ec_info.version, 0, KB3310B_VERSION_LEN);
+	else {
+		p += ARRAY_SIZE(token) - 1;
+		strncpy(yeeloong_ec_info.version, p, KB3310B_VERSION_LEN);
+		p = strstr(yeeloong_ec_info.version, " ");
+		if (p)
+			*p = '\0';
+	}
+
+	return platform_device_register(&yeeloong_ec_device);
+}
-- 
2.20.1

