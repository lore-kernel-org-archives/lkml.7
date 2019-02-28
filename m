Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580B6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CAC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfB1KVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:21:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12149 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732422AbfB1KVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:21:50 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SADefH026455;
        Thu, 28 Feb 2019 11:20:07 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6d4spx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:20:07 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 77CE443;
        Thu, 28 Feb 2019 10:20:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58F0B2C4A;
        Thu, 28 Feb 2019 10:20:05 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb 2019 11:20:04
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <lionel.debieve@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] nvmem: Add driver for STM32 factory-programmed read only mem
Date:   Thu, 28 Feb 2019 11:19:52 +0100
Message-ID: <1551349196-8956-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
References: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a read only nvmem driver for STM32 factory-programmed memory area
(on-chip non-volatile storage).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- update "st,stm32f4-otp" compatible as discussed with Rob
---
 drivers/nvmem/Kconfig       | 10 ++++++
 drivers/nvmem/Makefile      |  2 ++
 drivers/nvmem/stm32-romem.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/nvmem/stm32-romem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470e..f398b18 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -113,6 +113,16 @@ config NVMEM_BCM_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-bcm-ocotp.
 
+config NVMEM_STM32_ROMEM
+	tristate "STMicroelectronics STM32 factory-programmed memory support"
+	depends on ARCH_STM32 || COMPILE_TEST
+	help
+	  Say y here to enable read-only access for STMicroelectronics STM32
+	  factory-programmed memory area.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-stm32-romem.
+
 config NVMEM_SUNXI_SID
 	tristate "Allwinner SoCs SID support"
 	depends on ARCH_SUNXI
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4e8c616..e85c946 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -26,6 +26,8 @@ nvmem_qfprom-y			:= qfprom.o
 obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y		:= rockchip-efuse.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
+nvmem_stm32_romem-y 		:= stm32-romem.o
+obj-$(CONFIG_NVMEM_STM32_ROMEM) += nvmem_stm32_romem.o
 nvmem_sunxi_sid-y		:= sunxi_sid.o
 obj-$(CONFIG_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
 nvmem-uniphier-efuse-y		:= uniphier-efuse.o
diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
new file mode 100644
index 0000000..07e98b5
--- /dev/null
+++ b/drivers/nvmem/stm32-romem.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STM32 Factory-programmed memory read access driver
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com> for STMicroelectronics.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+
+struct stm32_romem_priv {
+	void __iomem *base;
+	struct nvmem_config cfg;
+};
+
+static int stm32_romem_read(void *context, unsigned int offset, void *buf,
+			    size_t bytes)
+{
+	struct stm32_romem_priv *priv = context;
+	u8 *buf8 = buf;
+	int i;
+
+	for (i = offset; i < offset + bytes; i++)
+		*buf8++ = readb_relaxed(priv->base + i);
+
+	return 0;
+}
+
+static int stm32_romem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_romem_priv *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->cfg.name = "stm32-romem";
+	priv->cfg.read_only = true;
+	priv->cfg.word_size = 1;
+	priv->cfg.stride = 1;
+	priv->cfg.size = resource_size(res);
+	priv->cfg.reg_read = stm32_romem_read;
+	priv->cfg.dev = dev;
+	priv->cfg.priv = priv;
+	priv->cfg.owner = THIS_MODULE;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
+}
+
+static const struct of_device_id stm32_romem_of_match[] = {
+	{ .compatible = "st,stm32f4-otp", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
+
+static struct platform_driver stm32_romem_driver = {
+	.probe = stm32_romem_probe,
+	.driver = {
+		.name = "stm32-romem",
+		.of_match_table = of_match_ptr(stm32_romem_of_match),
+	},
+};
+module_platform_driver(stm32_romem_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 RO-MEM");
+MODULE_ALIAS("platform:nvmem-stm32-romem");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

