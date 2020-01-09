Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357A7C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC02820678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1afjnZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgAIKkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:40:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33031 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgAIKke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:40:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so6902355wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7p1achi3hv+MDEzAZ+6DTDGP2HgpFNN2VjeZ6HMxR0=;
        b=v1afjnZOpS/DEoKekXnl8DPdIbSDxVYgF9wFwKqvI0WK08Y8p2rmYBLX5eFfjCRRwx
         WbEgabZxPCS6KcA6tHoChqDOT8POsslLDg0GpCH7DPIw5QOMOV4YxFTsI9uDxcoqDCee
         uKNrupbUxB9YL72V8lJi1Oh3eH2P5ZLEFkFAq7V4DwvCz3uUKwGlCZhdvISc4jxNP2Gz
         w4tXIKA+gsd1Y5Vp9MfNvazkiUx6y2Z8wrIFRN4S3nZZ0edsMc8BbkLbwEZ9OwX4j3sh
         i7Cfp6EThTGfSwJmqwbCDqH9z6Iz127nQHiS+gmWpIZwTdXurvv4a2gpGuUv/ejQ8J4F
         TMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7p1achi3hv+MDEzAZ+6DTDGP2HgpFNN2VjeZ6HMxR0=;
        b=IYl7snGLv2O4UwHEfA0PcRqH/d1erlhkXHl3i+KLxyrFM3BdjVwoRnwZADRTz+nu/M
         xUhqG/UKLAG9WVwG0QK/pUcS3gEumAAl4fsZOFWJ1u15DVCh/xJ1Zq+WQEEHNkpB2zfJ
         ah0IAYQSjZHJURwFIKqH4V1ZGEea1DWNzGxiYtcKMLGMuCsShGhcPd3+KZo+8eXQHX4t
         F5X2i4URc0mvha+YB/O3jYQegZdMsUSIguIi15mZBeRFkAZJAZsye4/ufdba3nXh+ZUN
         n1SAdg+7PK3oixZsK4cyFuG3bjm7/vSiBK8JMOHTEmHJGEqqbo+ecUAF0yN1Jiftpbh/
         80tw==
X-Gm-Message-State: APjAAAW/bxDBZQGSTbME3HPVwhHyQpkjtlmVay/f2D70H43BzGDibcCX
        Y70Ks861sCxgDcBZdhJT+fWwIw==
X-Google-Smtp-Source: APXvYqwG10sYGPAHsUfH85HektNLcxThGnk5TrKTVPFGSlr7hhOAZv5Xc87xCT7r9S4rg6j+D7Rnww==
X-Received: by 2002:a5d:4045:: with SMTP id w5mr9500114wrp.59.1578566431797;
        Thu, 09 Jan 2020 02:40:31 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b10sm7858576wrt.90.2020.01.09.02.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:40:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] nvmem: imx: ocotp: introduce ocotp_ctrl_reg
Date:   Thu,  9 Jan 2020 10:40:16 +0000
Message-Id: <20200109104017.6249-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
References: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce ocotp_ctrl_reg to include the low 16bits mask of CTRL
register.

i.MX chips will have different layout of the low 16bits of CTRL
register, so use ocotp_ctrl_reg will make it clean to add new
chip support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 79 ++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index fc40555ca4cd..4ba9cc8f76df 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -44,6 +44,14 @@
 #define IMX_OCOTP_BM_CTRL_ERROR		0x00000200
 #define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
 
+#define IMX_OCOTP_BM_CTRL_DEFAULT				\
+	{							\
+		.bm_addr = IMX_OCOTP_BM_CTRL_ADDR,		\
+		.bm_busy = IMX_OCOTP_BM_CTRL_BUSY,		\
+		.bm_error = IMX_OCOTP_BM_CTRL_ERROR,		\
+		.bm_rel_shadows = IMX_OCOTP_BM_CTRL_REL_SHADOWS,\
+	}
+
 #define TIMING_STROBE_PROG_US		10	/* Min time to blow a fuse */
 #define TIMING_STROBE_READ_NS		37	/* Min time before read */
 #define TIMING_RELAX_NS			17
@@ -62,18 +70,31 @@ struct ocotp_priv {
 	struct nvmem_config *config;
 };
 
+struct ocotp_ctrl_reg {
+	u32 bm_addr;
+	u32 bm_busy;
+	u32 bm_error;
+	u32 bm_rel_shadows;
+};
+
 struct ocotp_params {
 	unsigned int nregs;
 	unsigned int bank_address_words;
 	void (*set_timing)(struct ocotp_priv *priv);
+	struct ocotp_ctrl_reg ctrl;
 };
 
-static int imx_ocotp_wait_for_busy(void __iomem *base, u32 flags)
+static int imx_ocotp_wait_for_busy(struct ocotp_priv *priv, u32 flags)
 {
 	int count;
 	u32 c, mask;
+	u32 bm_ctrl_busy, bm_ctrl_error;
+	void __iomem *base = priv->base;
 
-	mask = IMX_OCOTP_BM_CTRL_BUSY | IMX_OCOTP_BM_CTRL_ERROR | flags;
+	bm_ctrl_busy = priv->params->ctrl.bm_busy;
+	bm_ctrl_error = priv->params->ctrl.bm_error;
+
+	mask = bm_ctrl_busy | bm_ctrl_error | flags;
 
 	for (count = 10000; count >= 0; count--) {
 		c = readl(base + IMX_OCOTP_ADDR_CTRL);
@@ -97,7 +118,7 @@ static int imx_ocotp_wait_for_busy(void __iomem *base, u32 flags)
 		 * - A read is performed to from a fuse word which has been read
 		 *   locked.
 		 */
-		if (c & IMX_OCOTP_BM_CTRL_ERROR)
+		if (c & bm_ctrl_error)
 			return -EPERM;
 		return -ETIMEDOUT;
 	}
@@ -105,15 +126,18 @@ static int imx_ocotp_wait_for_busy(void __iomem *base, u32 flags)
 	return 0;
 }
 
-static void imx_ocotp_clr_err_if_set(void __iomem *base)
+static void imx_ocotp_clr_err_if_set(struct ocotp_priv *priv)
 {
-	u32 c;
+	u32 c, bm_ctrl_error;
+	void __iomem *base = priv->base;
+
+	bm_ctrl_error = priv->params->ctrl.bm_error;
 
 	c = readl(base + IMX_OCOTP_ADDR_CTRL);
-	if (!(c & IMX_OCOTP_BM_CTRL_ERROR))
+	if (!(c & bm_ctrl_error))
 		return;
 
-	writel(IMX_OCOTP_BM_CTRL_ERROR, base + IMX_OCOTP_ADDR_CTRL_CLR);
+	writel(bm_ctrl_error, base + IMX_OCOTP_ADDR_CTRL_CLR);
 }
 
 static int imx_ocotp_read(void *context, unsigned int offset,
@@ -140,7 +164,7 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 		return ret;
 	}
 
-	ret = imx_ocotp_wait_for_busy(priv->base, 0);
+	ret = imx_ocotp_wait_for_busy(priv, 0);
 	if (ret < 0) {
 		dev_err(priv->dev, "timeout during read setup\n");
 		goto read_end;
@@ -157,7 +181,7 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 		 * issued
 		 */
 		if (*(buf - 1) == IMX_OCOTP_READ_LOCKED_VAL)
-			imx_ocotp_clr_err_if_set(priv->base);
+			imx_ocotp_clr_err_if_set(priv);
 	}
 	ret = 0;
 
@@ -274,7 +298,7 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	 * write or reload must be completed before a write access can be
 	 * requested.
 	 */
-	ret = imx_ocotp_wait_for_busy(priv->base, 0);
+	ret = imx_ocotp_wait_for_busy(priv, 0);
 	if (ret < 0) {
 		dev_err(priv->dev, "timeout during timing setup\n");
 		goto write_end;
@@ -306,8 +330,8 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	}
 
 	ctrl = readl(priv->base + IMX_OCOTP_ADDR_CTRL);
-	ctrl &= ~IMX_OCOTP_BM_CTRL_ADDR;
-	ctrl |= waddr & IMX_OCOTP_BM_CTRL_ADDR;
+	ctrl &= ~priv->params->ctrl.bm_addr;
+	ctrl |= waddr & priv->params->ctrl.bm_addr;
 	ctrl |= IMX_OCOTP_WR_UNLOCK;
 
 	writel(ctrl, priv->base + IMX_OCOTP_ADDR_CTRL);
@@ -374,11 +398,11 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	 * be set. It must be cleared by software before any new write access
 	 * can be issued.
 	 */
-	ret = imx_ocotp_wait_for_busy(priv->base, 0);
+	ret = imx_ocotp_wait_for_busy(priv, 0);
 	if (ret < 0) {
 		if (ret == -EPERM) {
 			dev_err(priv->dev, "failed write to locked region");
-			imx_ocotp_clr_err_if_set(priv->base);
+			imx_ocotp_clr_err_if_set(priv);
 		} else {
 			dev_err(priv->dev, "timeout during data write\n");
 		}
@@ -394,10 +418,10 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	udelay(2);
 
 	/* reload all shadow registers */
-	writel(IMX_OCOTP_BM_CTRL_REL_SHADOWS,
+	writel(priv->params->ctrl.bm_rel_shadows,
 	       priv->base + IMX_OCOTP_ADDR_CTRL_SET);
-	ret = imx_ocotp_wait_for_busy(priv->base,
-				      IMX_OCOTP_BM_CTRL_REL_SHADOWS);
+	ret = imx_ocotp_wait_for_busy(priv,
+				      priv->params->ctrl.bm_rel_shadows);
 	if (ret < 0) {
 		dev_err(priv->dev, "timeout during shadow register reload\n");
 		goto write_end;
@@ -424,65 +448,76 @@ static const struct ocotp_params imx6q_params = {
 	.nregs = 128,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx6sl_params = {
 	.nregs = 64,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx6sll_params = {
 	.nregs = 128,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx6sx_params = {
 	.nregs = 128,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx6ul_params = {
 	.nregs = 128,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx6ull_params = {
 	.nregs = 64,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx7d_params = {
 	.nregs = 64,
 	.bank_address_words = 4,
 	.set_timing = imx_ocotp_set_imx7_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx7ulp_params = {
 	.nregs = 256,
 	.bank_address_words = 0,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx8mq_params = {
 	.nregs = 256,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx8mm_params = {
 	.nregs = 256,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct ocotp_params imx8mn_params = {
 	.nregs = 256,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
+	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
 };
 
 static const struct of_device_id imx_ocotp_dt_ids[] = {
@@ -521,17 +556,17 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	clk_prepare_enable(priv->clk);
-	imx_ocotp_clr_err_if_set(priv->base);
-	clk_disable_unprepare(priv->clk);
-
 	priv->params = of_device_get_match_data(&pdev->dev);
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
 	priv->config = &imx_ocotp_nvmem_config;
-	nvmem = devm_nvmem_register(dev, &imx_ocotp_nvmem_config);
 
+	clk_prepare_enable(priv->clk);
+	imx_ocotp_clr_err_if_set(priv);
+	clk_disable_unprepare(priv->clk);
+
+	nvmem = devm_nvmem_register(dev, &imx_ocotp_nvmem_config);
 
 	return PTR_ERR_OR_ZERO(nvmem);
 }
-- 
2.21.0

