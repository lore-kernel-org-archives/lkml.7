Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F72C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F15208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dSdMsLxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfG3SQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37628 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbfG3SQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so30258362pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRqCFAxifH/ug/A0a61c3URseCbKgugL8/V+JWSDXWc=;
        b=dSdMsLxhtjdnUc/E1X3sIDiFSqqj30TPIBNLUv+AsMqKeXPoEstOWsFACiaHulZL8T
         C5vIzUN0UBJgPopKccp76t9M6WhGDUwlcBYqHQH73znw9KRwtevaxHac1HFS0Az4La1e
         1JYkpOsJAdhBXcKCwDASTLQ+QUxOcWFRB2S54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRqCFAxifH/ug/A0a61c3URseCbKgugL8/V+JWSDXWc=;
        b=d9z8KCQZFAANuH+fssYEHj3bGJlGArsMe9bNvQGJqYOInq3ajrLB84yXbmK9teZxv8
         vBaVJVTK3gOy2OwS49YUnulYRSOY0nv4EfIy2kqACe6B9A3lahqLmii2L7M4ZPWTi1sp
         cK5VJOFuAq6ZweBESKrm7oXqtaKY6b6RMB0Vsq56G/U+xFIbCBB4MlOyoxw+dq01y3lh
         owILFpi+XziMoZEWFHK9/vBX59c2lxTj7qtWZ/J+V2HMgrmGD0XikVyaTj50Sx2ieFPx
         YlhHWtBXSB8ITMS04e+1Uhbf/Scr669wk2dfmJSlEZC+D5H+HkEFRHM1khwxbaDIUjUw
         ClSw==
X-Gm-Message-State: APjAAAXUDG2Eo/cQPqYlsbCNYhUGc4hYYMVXnRjf8vymYax/jAeI9459
        CbrxGrqAUZLksXJsR3BVjwpZr+Nms8avmQ==
X-Google-Smtp-Source: APXvYqyYJGVsWZFbAToPxdlPnoGFJzqBHsnz11HygfcVsmCeaRg9bkPUbALPR/uSZfh0U8Tn74Khxw==
X-Received: by 2002:a63:3009:: with SMTP id w9mr36521544pgw.260.1564510599392;
        Tue, 30 Jul 2019 11:16:39 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 49/57] ASoC: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:49 -0700
Message-Id: <20190730181557.90391-50-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 sound/soc/atmel/atmel-classd.c             |  7 ++-----
 sound/soc/atmel/atmel-pdmic.c              |  7 ++-----
 sound/soc/bcm/cygnus-ssp.c                 |  7 ++-----
 sound/soc/codecs/msm8916-wcd-analog.c      | 12 +++---------
 sound/soc/codecs/twl6040.c                 |  4 +---
 sound/soc/fsl/fsl_asrc.c                   |  4 +---
 sound/soc/fsl/fsl_esai.c                   |  4 +---
 sound/soc/fsl/fsl_sai.c                    |  4 +---
 sound/soc/fsl/fsl_spdif.c                  |  4 +---
 sound/soc/fsl/fsl_ssi.c                    |  4 +---
 sound/soc/fsl/imx-ssi.c                    |  4 +---
 sound/soc/kirkwood/kirkwood-i2s.c          |  4 +---
 sound/soc/mediatek/common/mtk-btcvsd.c     |  4 +---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c |  4 +---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c |  4 +---
 sound/soc/mxs/mxs-saif.c                   |  8 ++------
 sound/soc/qcom/lpass-platform.c            |  5 +----
 sound/soc/sof/intel/bdw.c                  |  5 +----
 sound/soc/sof/intel/byt.c                  |  5 +----
 sound/soc/sprd/sprd-mcdt.c                 |  4 +---
 sound/soc/sti/sti_uniperif.c               |  4 +---
 sound/soc/stm/stm32_i2s.c                  |  5 +----
 sound/soc/stm/stm32_sai.c                  |  4 +---
 sound/soc/stm/stm32_spdifrx.c              |  4 +---
 sound/soc/sunxi/sun4i-i2s.c                |  4 +---
 sound/soc/uniphier/aio-dma.c               |  4 +---
 sound/soc/xilinx/xlnx_formatter_pcm.c      |  2 --
 sound/soc/xtensa/xtfpga-i2s.c              |  1 -
 28 files changed, 32 insertions(+), 100 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 0f2c574f27f1..e98601eccfa3 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -571,11 +571,8 @@ static int atmel_classd_probe(struct platform_device *pdev)
 	dd->pdata = pdata;
 
 	dd->irq = platform_get_irq(pdev, 0);
-	if (dd->irq < 0) {
-		ret = dd->irq;
-		dev_err(dev, "failed to could not get irq: %d\n", ret);
-		return ret;
-	}
+	if (dd->irq < 0)
+		return dd->irq;
 
 	dd->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(dd->pclk)) {
diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index e09c28349e0d..04ec6f0af179 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -612,11 +612,8 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	dd->dev = dev;
 
 	dd->irq = platform_get_irq(pdev, 0);
-	if (dd->irq < 0) {
-		ret = dd->irq;
-		dev_err(dev, "failed to get irq: %d\n", ret);
-		return ret;
-	}
+	if (dd->irq < 0)
+		return dd->irq;
 
 	dd->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(dd->pclk)) {
diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index b7c358b48d8d..2f9357d7da96 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1342,11 +1342,8 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	}
 
 	cygaud->irq_num = platform_get_irq(pdev, 0);
-	if (cygaud->irq_num <= 0) {
-		dev_err(dev, "platform_get_irq failed\n");
-		err = cygaud->irq_num;
-		return err;
-	}
+	if (cygaud->irq_num <= 0)
+		return cygaud->irq_num;
 
 	err = audio_clk_init(pdev, cygaud);
 	if (err) {
diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 368b6c09474b..667e9f73aba3 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1185,10 +1185,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_byname(pdev, "mbhc_switch_int");
-	if (irq < 0) {
-		dev_err(dev, "failed to get mbhc switch irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 			       pm8916_mbhc_switch_irq_handler,
@@ -1200,10 +1198,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 
 	if (priv->mbhc_btn_enabled) {
 		irq = platform_get_irq_byname(pdev, "mbhc_but_press_det");
-		if (irq < 0) {
-			dev_err(dev, "failed to get button press irq\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				       mbhc_btn_press_irq_handler,
@@ -1214,10 +1210,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			dev_err(dev, "cannot request mbhc button press irq\n");
 
 		irq = platform_get_irq_byname(pdev, "mbhc_but_rel_det");
-		if (irq < 0) {
-			dev_err(dev, "failed to get button release irq\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				       mbhc_btn_release_irq_handler,
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 472c2fff34a8..f34637afee51 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1108,10 +1108,8 @@ static int twl6040_probe(struct snd_soc_component *component)
 	priv->component = component;
 
 	priv->plug_irq = platform_get_irq(pdev, 0);
-	if (priv->plug_irq < 0) {
-		dev_err(component->dev, "invalid irq: %d\n", priv->plug_irq);
+	if (priv->plug_irq < 0)
 		return priv->plug_irq;
-	}
 
 	INIT_DELAYED_WORK(&priv->hs_jack.work, twl6040_accessory_work);
 
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index cbbf6257f08a..cfa40ef6b1ca 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -885,10 +885,8 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
 			       dev_name(&pdev->dev), asrc_priv);
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 10d2210c91ef..19524ca9b4f1 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -824,10 +824,8 @@ static int fsl_esai_probe(struct platform_device *pdev)
 				PTR_ERR(esai_priv->spbaclk));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, esai_isr, 0,
 			       esai_priv->name, esai_priv);
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d58cc3ae90d8..6faf222add2b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -832,10 +832,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, 0, np->name, sai);
 	if (ret) {
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 4842e6df9a2d..7858a5499ac5 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1248,10 +1248,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
 			       dev_name(&pdev->dev), spdif_priv);
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fa862af25c1a..b0a6fead1a6a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1510,10 +1510,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->irq = platform_get_irq(pdev, 0);
-	if (ssi->irq < 0) {
-		dev_err(dev, "no irq for node %s\n", pdev->name);
+	if (ssi->irq < 0)
 		return ssi->irq;
-	}
 
 	/* Set software limitations for synchronous mode except AC97 */
 	if (ssi->synchronous && !fsl_ssi_is_ac97(ssi)) {
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 9038b61317be..42031ba7da31 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -520,10 +520,8 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->irq = platform_get_irq(pdev, 0);
-	if (ssi->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", ssi->irq);
+	if (ssi->irq < 0)
 		return ssi->irq;
-	}
 
 	ssi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssi->clk)) {
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 3446a113f482..bf9aa58b31c6 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -539,10 +539,8 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->io);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed: %d\n", priv->irq);
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	if (np) {
 		priv->burst = 128;		/* might be 32 or 128 */
diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index c7a81c4be068..d00608c73c6e 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -1335,10 +1335,8 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 
 	/* irq */
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id <= 0) {
-		dev_err(dev, "%pOFn no irq found\n", dev->of_node);
+	if (irq_id <= 0)
 		return irq_id < 0 ? irq_id : -ENXIO;
-	}
 
 	ret = devm_request_irq(dev, irq_id, mtk_btcvsd_snd_irq_handler,
 			       IRQF_TRIGGER_LOW, "BTCVSD_ISR_Handle",
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 7064a9fd6f74..9af76ae315a5 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1342,10 +1342,8 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	irq_id = platform_get_irq_byname(pdev, "asys");
-	if (irq_id < 0) {
-		dev_err(dev, "unable to get ASYS IRQ\n");
+	if (irq_id < 0)
 		return irq_id;
-	}
 
 	ret = devm_request_irq(dev, irq_id, mt2701_asys_isr,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 0382896c162e..2d45d44ee97b 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1075,10 +1075,8 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->dev = &pdev->dev;
 
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id <= 0) {
-		dev_err(afe->dev, "np %pOFn no irq\n", afe->dev->of_node);
+	if (irq_id <= 0)
 		return irq_id < 0 ? irq_id : -ENXIO;
-	}
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
 	if (ret) {
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 269b6d6df250..ccfec47f63e8 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -793,12 +793,8 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		return PTR_ERR(saif->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		dev_err(&pdev->dev, "failed to get irq resource: %d\n",
-			ret);
-		return ret;
-	}
+	if (irq < 0)
+		return irq;
 
 	saif->dev = &pdev->dev;
 	ret = devm_request_irq(&pdev->dev, irq, mxs_saif_irq, 0,
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index cf7a299f4547..4c745baa39f7 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -564,11 +564,8 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 	int ret;
 
 	drvdata->lpaif_irq = platform_get_irq_byname(pdev, "lpass-irq-lpaif");
-	if (drvdata->lpaif_irq < 0) {
-		dev_err(&pdev->dev, "error getting irq handle: %d\n",
-			drvdata->lpaif_irq);
+	if (drvdata->lpaif_irq < 0)
 		return -ENODEV;
-	}
 
 	/* ensure audio hardware is disabled */
 	ret = regmap_write(drvdata->lpaif_map,
diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 70d524ef9bc0..4bb9636da990 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -613,11 +613,8 @@ static int bdw_probe(struct snd_sof_dev *sdev)
 
 	/* register our IRQ */
 	sdev->ipc_irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
-	if (sdev->ipc_irq < 0) {
-		dev_err(sdev->dev, "error: failed to get IRQ at index %d\n",
-			desc->irqindex_host_ipc);
+	if (sdev->ipc_irq < 0)
 		return sdev->ipc_irq;
-	}
 
 	dev_dbg(sdev->dev, "using IRQ %d\n", sdev->ipc_irq);
 	ret = devm_request_threaded_irq(sdev->dev, sdev->ipc_irq,
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 107d711efc3f..000d576f6a8d 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -728,11 +728,8 @@ static int byt_acpi_probe(struct snd_sof_dev *sdev)
 irq:
 	/* register our IRQ */
 	sdev->ipc_irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
-	if (sdev->ipc_irq < 0) {
-		dev_err(sdev->dev, "error: failed to get IRQ at index %d\n",
-			desc->irqindex_host_ipc);
+	if (sdev->ipc_irq < 0)
 		return sdev->ipc_irq;
-	}
 
 	dev_dbg(sdev->dev, "using IRQ %d\n", sdev->ipc_irq);
 	ret = devm_request_threaded_irq(sdev->dev, sdev->ipc_irq,
diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index 7448015a4935..f439e5503a3c 100644
--- a/sound/soc/sprd/sprd-mcdt.c
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -959,10 +959,8 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mcdt);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get MCDT interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sprd_mcdt_irq_handler,
 			       0, "sprd-mcdt", mcdt);
diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 645bcbe91601..ee4a0151e63e 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -426,10 +426,8 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 				     UNIPERIF_FIFO_DATA_OFFSET(uni);
 
 	uni->irq = platform_get_irq(priv->pdev, 0);
-	if (uni->irq < 0) {
-		dev_err(dev, "Failed to get IRQ resource\n");
+	if (uni->irq < 0)
 		return -ENXIO;
-	}
 
 	uni->type = dev_data->type;
 
diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index ba6452dab69b..3e7226a53e53 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -855,11 +855,8 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	/* Get irqs */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, IRQF_ONESHOT,
 			       dev_name(&pdev->dev), i2s);
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 63f68e663676..1c4cc1ca1eaa 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -195,10 +195,8 @@ static int stm32_sai_probe(struct platform_device *pdev)
 
 	/* init irqs */
 	sai->irq = platform_get_irq(pdev, 0);
-	if (sai->irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (sai->irq < 0)
 		return sai->irq;
-	}
 
 	/* reset */
 	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index ee71b898897b..cd4b235fce57 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -909,10 +909,8 @@ static int stm32_spdifrx_parse_of(struct platform_device *pdev,
 	}
 
 	spdifrx->irq = platform_get_irq(pdev, 0);
-	if (spdifrx->irq < 0) {
-		dev_err(&pdev->dev, "No irq for node %s\n", pdev->name);
+	if (spdifrx->irq < 0)
 		return spdifrx->irq;
-	}
 
 	return 0;
 }
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9b2232908b65..d97d694c48df 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1087,10 +1087,8 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Can't retrieve our interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	i2s->variant = of_device_get_match_data(&pdev->dev);
 	if (!i2s->variant) {
diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index fa001d3c1a88..2261655be10d 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -291,10 +291,8 @@ int uniphier_aiodma_soc_register_platform(struct platform_device *pdev)
 		return PTR_ERR(chip->regmap);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Could not get irq.\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, aiodma_irq,
 			       IRQF_SHARED, dev_name(dev), pdev);
diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index dc8721f4f56b..48970efe7838 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -613,7 +613,6 @@ static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
 		aud_drv_data->mm2s_irq = platform_get_irq_byname(pdev,
 								 "irq_mm2s");
 		if (aud_drv_data->mm2s_irq < 0) {
-			dev_err(dev, "xlnx audio mm2s irq resource failed\n");
 			ret = aud_drv_data->mm2s_irq;
 			goto clk_err;
 		}
@@ -640,7 +639,6 @@ static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
 		aud_drv_data->s2mm_irq = platform_get_irq_byname(pdev,
 								 "irq_s2mm");
 		if (aud_drv_data->s2mm_irq < 0) {
-			dev_err(dev, "xlnx audio s2mm irq resource failed\n");
 			ret = aud_drv_data->s2mm_irq;
 			goto clk_err;
 		}
diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 9ce2c75186b9..e635bf08d935 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -572,7 +572,6 @@ static int xtfpga_i2s_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		err = irq;
 		goto err;
 	}
-- 
Sent by a computer through tubes

