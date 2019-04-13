Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AB3C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD2F20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUTVgMlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDMKd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42052 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfDMKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so15107167wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5c8vQ9ISPZyNBNsoRAod1ZzFLERbEYp94oYBOVbjZJQ=;
        b=UUTVgMlwoaKaKkAYoUGsn68gpZm94V8gwnbLxQ+XYn5dn/9A/UzQXC/lbDfoer3d0Y
         hYmsu+8ErYz0kZU5ru1xmftsMDyGeTREDaMoPnEAexmLiSFSUTtKSCPWpm6DmluCZbEg
         pZm17scRJikhxJYMgqTV1u66KFZq2M5GuvsnL4nU+x+tnagVyy6Q0M3EHTsCTGS+loxP
         4zyxiSPsjeYO1DRQokrdt7c9VtpglJW7H69+H9fjPnfEtCn43lxMwOPrP06ks5AJE/S1
         eF8rJZI8vEII4eCOuZKv0uIpasdBnLU1u9XNa6wcsa65u9gvDAVT8k6oqzarbLTM009B
         8t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5c8vQ9ISPZyNBNsoRAod1ZzFLERbEYp94oYBOVbjZJQ=;
        b=VmNlgUTDGgGwP/Ghzxyg0uyzIY/Y3PGni9czi6o3v/aWmmrSXf+ZCrNn7WPe/4iUq8
         rC9a97bmiiCl2GuD4JL0aPav47s2tNi9pXm2MS/ziUP0TfkOFLrDex5JFdEevqWykwdk
         ucMaUXezpN0xOezo+28PmH4Mh4wwoIvPUtcjXOExBUD94LSEkyKPxLNoQP+veyihFIA+
         WEMTiHym39C39f61RLPVUpKeK2w7LCEKMXyN94NOMod5jsE76fChbEV43jmxGJZzL70W
         nf1yGkZgQorVAEBPQrMrD1ZLMVM3fxVY/FR+72UIB+SwOWxXQ6k9wrxOiSzEB7InGFCN
         LMog==
X-Gm-Message-State: APjAAAUHw9fUi4xIlF2o1mfroMMbM88AOMfhOkbIlS8Dk7mpHOxfFisu
        0eren6SUhzM6+KaLlzf6aqPm9A==
X-Google-Smtp-Source: APXvYqwqWtUlPKVC5Kl1afzeMy6i+OpIj2Oj/DDMWnhYPdyKbjZ4CfDbMC7sDr+rRlwAmJtKRJzNmA==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr38390910wro.78.1555151599193;
        Sat, 13 Apr 2019 03:33:19 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 11/20] nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
Date:   Sat, 13 Apr 2019 11:32:56 +0100
Message-Id: <20190413103305.9576-12-srinivas.kandagatla@linaro.org>
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

On STM32MP15, OTP area may be read/written by using BSEC (boot, security
and OTP control). BSEC registers set is composed of various regions, among
which control registers and OTP shadow registers.
Secure monitor calls are involved in this process to allow (or deny)
access to the full range of OTP data.
This adds support for reading and writing OTP data using SMC services.
Data content can be aligned on 16-bits or 8-bits. Then take care of it,
since BSEC data is 32-bits wide.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 134 ++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 07e98b53b391..354be526897f 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -6,11 +6,29 @@
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com> for STMicroelectronics.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of_device.h>
 
+/* BSEC secure service access from non-secure */
+#define STM32_SMC_BSEC			0x82001003
+#define STM32_SMC_READ_SHADOW		0x01
+#define STM32_SMC_PROG_OTP		0x02
+#define STM32_SMC_WRITE_SHADOW		0x03
+#define STM32_SMC_READ_OTP		0x04
+
+/* shadow registers offest */
+#define STM32MP15_BSEC_DATA0		0x200
+
+/* 32 (x 32-bits) lower shadow registers */
+#define STM32MP15_BSEC_NUM_LOWER	32
+
+struct stm32_romem_cfg {
+	int size;
+};
+
 struct stm32_romem_priv {
 	void __iomem *base;
 	struct nvmem_config cfg;
@@ -29,8 +47,98 @@ static int stm32_romem_read(void *context, unsigned int offset, void *buf,
 	return 0;
 }
 
+static int stm32_bsec_smc(u8 op, u32 otp, u32 data, u32 *result)
+{
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(STM32_SMC_BSEC, op, otp, data, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return -EIO;
+
+	if (result)
+		*result = (u32)res.a1;
+
+	return 0;
+#else
+	return -ENXIO;
+#endif
+}
+
+static int stm32_bsec_read(void *context, unsigned int offset, void *buf,
+			   size_t bytes)
+{
+	struct stm32_romem_priv *priv = context;
+	struct device *dev = priv->cfg.dev;
+	u32 roffset, rbytes, val;
+	u8 *buf8 = buf, *val8 = (u8 *)&val;
+	int i, j = 0, ret, skip_bytes, size;
+
+	/* Round unaligned access to 32-bits */
+	roffset = rounddown(offset, 4);
+	skip_bytes = offset & 0x3;
+	rbytes = roundup(bytes + skip_bytes, 4);
+
+	if (roffset + rbytes > priv->cfg.size)
+		return -EINVAL;
+
+	for (i = roffset; (i < roffset + rbytes); i += 4) {
+		u32 otp = i >> 2;
+
+		if (otp < STM32MP15_BSEC_NUM_LOWER) {
+			/* read lower data from shadow registers */
+			val = readl_relaxed(
+				priv->base + STM32MP15_BSEC_DATA0 + i);
+		} else {
+			ret = stm32_bsec_smc(STM32_SMC_READ_SHADOW, otp, 0,
+					     &val);
+			if (ret) {
+				dev_err(dev, "Can't read data%d (%d)\n", otp,
+					ret);
+				return ret;
+			}
+		}
+		/* skip first bytes in case of unaligned read */
+		if (skip_bytes)
+			size = min(bytes, (size_t)(4 - skip_bytes));
+		else
+			size = min(bytes, (size_t)4);
+		memcpy(&buf8[j], &val8[skip_bytes], size);
+		bytes -= size;
+		j += size;
+		skip_bytes = 0;
+	}
+
+	return 0;
+}
+
+static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
+			    size_t bytes)
+{
+	struct stm32_romem_priv *priv = context;
+	struct device *dev = priv->cfg.dev;
+	u32 *buf32 = buf;
+	int ret, i;
+
+	/* Allow only writing complete 32-bits aligned words */
+	if ((bytes % 4) || (offset % 4))
+		return -EINVAL;
+
+	for (i = offset; i < offset + bytes; i += 4) {
+		ret = stm32_bsec_smc(STM32_SMC_PROG_OTP, i >> 2, *buf32++,
+				     NULL);
+		if (ret) {
+			dev_err(dev, "Can't write data%d (%d)\n", i >> 2, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int stm32_romem_probe(struct platform_device *pdev)
 {
+	const struct stm32_romem_cfg *cfg;
 	struct device *dev = &pdev->dev;
 	struct stm32_romem_priv *priv;
 	struct resource *res;
@@ -45,21 +153,37 @@ static int stm32_romem_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->cfg.name = "stm32-romem";
-	priv->cfg.read_only = true;
 	priv->cfg.word_size = 1;
 	priv->cfg.stride = 1;
-	priv->cfg.size = resource_size(res);
-	priv->cfg.reg_read = stm32_romem_read;
 	priv->cfg.dev = dev;
 	priv->cfg.priv = priv;
 	priv->cfg.owner = THIS_MODULE;
 
+	cfg = (const struct stm32_romem_cfg *)
+		of_match_device(dev->driver->of_match_table, dev)->data;
+	if (!cfg) {
+		priv->cfg.read_only = true;
+		priv->cfg.size = resource_size(res);
+		priv->cfg.reg_read = stm32_romem_read;
+	} else {
+		priv->cfg.size = cfg->size;
+		priv->cfg.reg_read = stm32_bsec_read;
+		priv->cfg.reg_write = stm32_bsec_write;
+	}
+
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
 }
 
+static const struct stm32_romem_cfg stm32mp15_bsec_cfg = {
+	.size = 384, /* 96 x 32-bits data words */
+};
+
 static const struct of_device_id stm32_romem_of_match[] = {
-	{ .compatible = "st,stm32f4-otp", },
-	{},
+	{ .compatible = "st,stm32f4-otp", }, {
+		.compatible = "st,stm32mp15-bsec",
+		.data = (void *)&stm32mp15_bsec_cfg,
+	}, {
+	},
 };
 MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
 
-- 
2.21.0

