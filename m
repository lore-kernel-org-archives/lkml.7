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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF6C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E744214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzrffdve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfHNGJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42517 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfHNGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id s19so15789125lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUt25DA3nPbOAehIkkx29Wu4YEVb8BWcE2W2re+0NE8=;
        b=QzrffdvexAezMs4qMJYVZcFcbj6IE7U0mJndLRmd/1BqqRNboSoqBX9wbZeQcI5HoE
         w+8XxVS9TsjVcRzUcV/FkR/2dQI39Xd3c1UNtyEml6R/wNofjTIjHWnQHNAd91WMB9D/
         O5NgoQlUDESnv1urOYAvLTImhvggWvHvzR38HBBvz0PzaWlzTyAAVyAlRNTfIut9E95D
         sG6xu/38nnJgWKN0H4gSncltZzd5pJ3r5OYnnK99Hg7sFkRneR5g4QmK2JxTBaWExZeU
         y1kR1L0VrKuQoWAS3Y51l2dWRyd7jzrx+ItAfegoXkmNpoNHZ8qS7L7tM5FB8DTtr7pK
         GnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUt25DA3nPbOAehIkkx29Wu4YEVb8BWcE2W2re+0NE8=;
        b=W1McfQZFRL08mb8N29Q/J3WJ2NkXq5I2vGcIAlKmTy/cn5pWukoP3i6JxCrtwkQos5
         24fx1Z3j29ogP5kcL5MEfgZ7lzoxiCYDFJLN5SjVbZY49AJdFF2+6nF23PkAbAZ69/oL
         UL9D9kTkpmMq90v0LbxrRawfyCtJAMvv/LXRUpD6OPvnIxU2b9c2sasYHYqRZc9SgDrx
         svBazutLHIgNzL+M3fHiZ+blfzVVY2rzR1HlRqrN4qgrVuneHHnT9c0R1tBA5UIYl6LX
         Nr4eRlaKyIreR5GZvgG5e67V83cYqUaR4+A+4FjFa0P24MJpswUNN951rf5RyNISmUWL
         ikWw==
X-Gm-Message-State: APjAAAXcG6JNHdn9wBlh7pD2Z8hL8gvBcHcuUFbijthUqztspEtC9Dn0
        YvH83WonWFkHiBbOq0j1XVI=
X-Google-Smtp-Source: APXvYqw3HfEmEsNcDcX28N02uPXQDKmFFo7Z9ESeDxVgagfChtjL+ghhnK2wlxr9TTWmXx73KB298w==
X-Received: by 2002:ac2:465e:: with SMTP id s30mr25328482lfo.19.1565762959397;
        Tue, 13 Aug 2019 23:09:19 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:18 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 14/15] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
Date:   Wed, 14 Aug 2019 08:08:53 +0200
Message-Id: <20190814060854.26345-15-codekipper@gmail.com>
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

Extend the functionality of the driver to include support of 20 and
24 bits per sample for the earlier SoCs.

Newer SoCs can also handle 32bit samples.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a71969167053..d3c8789f70bb 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -690,6 +690,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 20:
+	case 24:
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1015,6 +1020,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
+#define SUN8I_FORMATS	(SUN4I_FORMATS | \
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1022,14 +1034,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
@@ -1505,6 +1517,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	if (i2s->variant->has_fmt_set_lrck_period) {
+		soc_dai->playback.formats = SUN8I_FORMATS;
+		soc_dai->capture.formats = SUN8I_FORMATS;
+	}
+
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "allwinner,playback-channels", &val)) {
 		if (val >= 2 && val <= 8)
-- 
2.22.0

