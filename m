Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FCC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3CE2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2FZTp02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfHNGJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43334 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfHNGJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so78488565lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ou3x7y4s8p5adLbVD6HKEYQ2kNImM5q4bilXS/ylyGo=;
        b=b2FZTp02TAHqQew35c6kwrKuCTzZoo3W8NqhcIPMlerWaVlqYLkYg7VlVI9gUC/5Lb
         fDQRW6yAa1Yq7q9Dyxn0APRJEK0w2aRzx/5pLZU83Nu0ZVvpfqNYEac7n+zvM9XjvUg3
         mdUJ9mFIq42CoP9BRv8v22FCaPgPzBhLaI4sjjX8sWSY0ITdxMrvKl+LO71NlX+8XTuU
         zfHk5NOwMAurs0Ps4Uk60hws46rQ4Me+gwvud+d0SzYV7zelpS1hnTIMNQAvnIDb0dAV
         /Kaxmqo6nstOyiQ91V8eLhpBaRaIJBacuByzyg+ifpPuoJrgA2vKzCSSMNXIF/XtIN1o
         nEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ou3x7y4s8p5adLbVD6HKEYQ2kNImM5q4bilXS/ylyGo=;
        b=PvC8jIvU0wO8+ZtXed4ilYaXc5nRb+nh/9JAcAf0QB7+ml3ZvuzR61FasNq61frXno
         kw/VY68kogV+j+PsV4yfWqUMZVTC7iaC+E3qNNIKRR0kDNu/nMhV5Ex5BsdjR+lMXLRm
         XFriaKKhPJKEvzwLOxtESBisV9o0/0OmtZCj1BNNx+lqL14Et68ovrfau0Lwvc/vjVy3
         fvCu/JqD6oHsQL3n1WlVFtPd4hF6KYwt7fUCCuq71YHEFjJ+axexa0+2hOsmQDXZ8dhq
         lPtS2jxs0F4vX/tv9r+gvl/qT9DPmcsxEVazzUqrntNUmOmrz5nQFYa/Ya+zjWOTvXcG
         FR0Q==
X-Gm-Message-State: APjAAAUdLXnV8Zudl6T0NXKyY4Lqablf0dCN3uxYDIwpnjeabQbB22PD
        ktFXQuXkxbGvRoXhnYRSEcg=
X-Google-Smtp-Source: APXvYqz3NLXEXAl8L4Kz1xuOk4AcF3nKcG5klKFuG7opqjL8zbsMtc1OeMtjPYhIInZBn0pYUugW+w==
X-Received: by 2002:a19:f603:: with SMTP id x3mr22065770lfe.125.1565762956491;
        Tue, 13 Aug 2019 23:09:16 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:15 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 12/15] ASoC: sun4i-i2s: Add multi-lane functionality
Date:   Wed, 14 Aug 2019 08:08:51 +0200
Message-Id: <20190814060854.26345-13-codekipper@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814060854.26345-1-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

The i2s block supports multi-lane i2s output however this functionality
is only possible in earlier SoCs where the pins are exposed and for
the i2s block used for HDMI audio on the later SoCs.

To enable this functionality, an optional property has been added to
the bindings.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a8d98696fe7c..a020c3b372a8 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -23,7 +23,7 @@
 
 #define SUN4I_I2S_CTRL_REG		0x00
 #define SUN4I_I2S_CTRL_SDO_EN_MASK		GENMASK(11, 8)
-#define SUN4I_I2S_CTRL_SDO_EN(sdo)			BIT(8 + (sdo))
+#define SUN4I_I2S_CTRL_SDO_EN(lines)		(((1 << lines) - 1) << 8)
 #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
 #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
 #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
@@ -614,6 +614,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	int sr, wss, channels;
 	u32 width;
+	int lines;
 
 	channels = params_channels(params);
 	if (channels != 2) {
@@ -622,6 +623,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	lines = (channels + 1) / 2;
+
+	/* Enable the required output lines */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_SDO_EN_MASK,
+			   SUN4I_I2S_CTRL_SDO_EN(lines));
+
 	if (i2s->variant->has_chcfg) {
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
 				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
@@ -1389,9 +1397,10 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
+	struct snd_soc_dai_driver *soc_dai;
 	struct resource *res;
 	void __iomem *regs;
-	int irq, ret;
+	int irq, ret, val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1456,6 +1465,19 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
 	i2s->capture_dma_data.maxburst = 8;
 
+	soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
+			       sizeof(*soc_dai), GFP_KERNEL);
+	if (!soc_dai) {
+		ret = -ENOMEM;
+		goto err_pm_disable;
+	}
+
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "allwinner,playback-channels", &val)) {
+		if (val >= 2 && val <= 8)
+			soc_dai->playback.channels_max = val;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
@@ -1465,7 +1487,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &sun4i_i2s_component,
-					      &sun4i_i2s_dai, 1);
+					      soc_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
-- 
2.22.0

