Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59070C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1861D2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlzGsSGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfDMKeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:34:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36138 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDMKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so15172444wrd.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZCyvxSqtHZuTKU0YyR6pxILemoezqOlmpXqetBXKH4=;
        b=BlzGsSGChFoHqRHyIoeGcynhhyi0mAbnxBCWbHt5h37j29mm6R6CL7+qQKyxovQF3b
         ry6BSYxWAWRnaHHwfffgq2JijUAzr2KeMgsthhoPszprNY07VZF8FuCZLx1r9siFH/Uh
         ihpyqQ0sNkaBcVd++7Ns8udda70xEVyh8T0QDQkqHAmjA50G/0lNJLbByhEHj7jVccYk
         DiTvmnF6fwVXAfJzHc2srjpvsgSZOP3iXh75hA1FiEpkEPAYT5T8c4chBbEej1LTcRKD
         zgtgqyQcY/khvx3jbJMOrtMkj6DZ91R6GB3LvbS4sP/TN4+JN6ieijHIZbUQaoyCKsAw
         TzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZCyvxSqtHZuTKU0YyR6pxILemoezqOlmpXqetBXKH4=;
        b=kHfZrf8cPVnVc7eDlgZ4dK6ALorfharJWGGthtesu835pFsuCfkvX9si9LRrDx7OCx
         MjaD9NGijNeUjb5TftQrBzmp7w9A/JHTwrUMv+5b83lZrHwt/N2o32VGB25wmcTF74qn
         SJ86KAL9hPxB9IcaOutRoduKZXlT1uGs3Oo0stIGArmJpYs1fP8LbAqqsrOZ424C7WOu
         /4D3m8n4qoY945Lu3oKw7ukWesPIc8QBuCvOKYF/i9hohooCcxK6lAt2P9NWRPwolij8
         xnzR2ho2W7DM+59HbftzFTAeyPfeghjrHX+NnyYw8Cn0/RMStyHEeJNR+rfKMbNypP8D
         cTSQ==
X-Gm-Message-State: APjAAAWWtebzzcS9YlVJYV3BYiPJKOMI//SJX0GEczyU6b87h+CF/ikX
        1BoxQ2h2JbSsLF3JZeGaS1hMyQ==
X-Google-Smtp-Source: APXvYqz5hohkS76jfEg4oqDz2sQjBYeJMy2TC72CmHoVVlfhuatUckA1bWiOIraup9gZXSmlVyrngw==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr40994123wrq.224.1555151598276;
        Sat, 13 Apr 2019 03:33:18 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 10/20] nvmem: Add driver for STM32 factory-programmed read only mem
Date:   Sat, 13 Apr 2019 11:32:55 +0100
Message-Id: <20190413103305.9576-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Add a read only nvmem driver for STM32 factory-programmed memory area
(on-chip non-volatile storage).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig       | 10 +++++
 drivers/nvmem/Makefile      |  2 +
 drivers/nvmem/stm32-romem.c | 78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/nvmem/stm32-romem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 9e1d83643e9c..a90e9a1ebe55 100644
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
index 2ece8ffffdda..4c7ba12a7005 100644
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
index 000000000000..07e98b53b391
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
2.21.0

