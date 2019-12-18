Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB87C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FA82146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bbqrbWIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLRRYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:24:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfLRRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:24:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so3161669wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nI3wHpadQrFAs/JfgdrJy2gaVNas6wWVbz5bBhEZKws=;
        b=bbqrbWIy171rY+l3dGMJy2f78+t+6Y9QcSsfd9gwoJIz8jkMgkc5lGrDZmVu6xQqL/
         qL5I3Xmb59jIDiBZXrvknewZyAAdkzidKB/cHIdG0tWHiuScNSJTk64Z4CFei93BZQix
         vMS1qnHOU0ScDaSQfYZqVvh33GopiHNU5CaCoA3iLb1xiw8ybBJgosGCFQvGa0icwWcR
         LoU072dWdylTSaklZ8D41kp3gdMzOlVvJ3JIeJVBPn003qO01931s6K7MU4i/3bKmCCl
         8udC3LYY7D5DYl5WbKhSe39rTPZ6Or0Ki8Nn/yH1nQ0LX0AuK1UeNjlqKRxTKYhREuZw
         vAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nI3wHpadQrFAs/JfgdrJy2gaVNas6wWVbz5bBhEZKws=;
        b=i8Dq4SgDGVBrOzFdg8BufNjYejdFqyJAXcFlEXgad0IS5J9fV0i6fh/YTS2XvTOoff
         YJl03YZX0ILpk+glwh3O6qKNfTGCc+gYzJ4Qb8St/OJRY0G+m7UyDOezUz0k0/d+gCsw
         p+MquQFB25GTgQNfW12c1wxTKX0FflZ/TKs85FugTOa3H8GZ0Q+CMpDvgcmut7Y8/a5y
         u5xkQAlf2t1pW0gw+vz/sAF6OdGAEjQkRNbyjWo/Y4Ydt1BnTUPsB/63uoCdz0WFGvie
         Msvox4tYKf1r80j0yHmZMK/d9xWMjhDaqTamS6ZJZctwLyYLc1l3Hc3kWFL+pWSCew0B
         ZcPw==
X-Gm-Message-State: APjAAAV9q8D5yZUxWCx0KUmHdpvOHUF46snKXDSjigK0W3HKYhlinU79
        jyLmJMUqnPlaIT5dvCDImViATg==
X-Google-Smtp-Source: APXvYqyKdYK3rXzKrzwUO5iXVrWIg6dPjJNj4tYZ8+IWgFIrT8fWvTqSm7KF8srCCiQVg2C/hMhqCA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr4345862wru.382.1576689871239;
        Wed, 18 Dec 2019 09:24:31 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 4sm2883231wmg.22.2019.12.18.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:24:30 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 3/4] ASoC: meson: axg-fifo: improve depth handling
Date:   Wed, 18 Dec 2019 18:24:19 +0100
Message-Id: <20191218172420.1199117-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218172420.1199117-1-jbrunet@baylibre.com>
References: <20191218172420.1199117-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the fifo driver parse the fifo depth from DT. Eventually all DT should
have this property. Until it is actually the case, default to 256 bytes if
the property is missing. 256 bytes is the size of the smallest fifo on the
supported SoCs.

On the supported SoC, fifo A is usually bigger than the other ones.  With
depth known, we can improve the usage of the fifo and adapt the setup of
request threshold.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c  | 19 +++++++++++++++++--
 sound/soc/meson/axg-fifo.h  |  1 +
 sound/soc/meson/axg-frddr.c | 13 ++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 4365086c9a31..c2742a02d866 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -132,8 +132,7 @@ int axg_fifo_pcm_hw_params(struct snd_soc_component *component,
 	 * - Half the fifo size
 	 * - Half the period size
 	 */
-	threshold = min(period / 2,
-			(unsigned int)AXG_FIFO_MIN_DEPTH / 2);
+	threshold = min(period / 2, fifo->depth / 2);
 
 	/*
 	 * With the threshold in bytes, register value is:
@@ -320,6 +319,7 @@ int axg_fifo_probe(struct platform_device *pdev)
 	const struct axg_fifo_match_data *data;
 	struct axg_fifo *fifo;
 	void __iomem *regs;
+	int ret;
 
 	data = of_device_get_match_data(dev);
 	if (!data) {
@@ -370,6 +370,21 @@ int axg_fifo_probe(struct platform_device *pdev)
 	if (IS_ERR(fifo->field_threshold))
 		return PTR_ERR(fifo->field_threshold);
 
+	ret = of_property_read_u32(dev->of_node, "amlogic,fifo-depth",
+				   &fifo->depth);
+	if (ret) {
+		/* Error out for anything but a missing property */
+		if (ret != -EINVAL)
+			return ret;
+		/*
+		 * If the property is missing, it might be because of an old
+		 * DT. In such case, assume the smallest known fifo depth
+		 */
+		fifo->depth = 256;
+		dev_warn(dev, "fifo depth not found, assume %u bytes\n",
+			 fifo->depth);
+	}
+
 	return devm_snd_soc_register_component(dev, data->component_drv,
 					       data->dai_drv, 1);
 }
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index c442195ba191..521b54e98fd3 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -68,6 +68,7 @@ struct axg_fifo {
 	struct clk *pclk;
 	struct reset_control *arb;
 	struct regmap_field *field_threshold;
+	unsigned int depth;
 	int irq;
 };
 
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index df104303351f..c3ae8ac30745 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -50,7 +50,7 @@ static int axg_frddr_dai_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
-	unsigned int fifo_depth;
+	unsigned int val;
 	int ret;
 
 	/* Enable pclk to access registers and clock the fifo ip */
@@ -61,15 +61,10 @@ static int axg_frddr_dai_startup(struct snd_pcm_substream *substream,
 	/* Apply single buffer mode to the interface */
 	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_FRDDR_PP_MODE, 0);
 
-	/*
-	 * TODO: We could adapt the fifo depth and the fifo threshold
-	 * depending on the expected memory throughput and lantencies
-	 * For now, we'll just use the same values as the vendor kernel
-	 * Depth and threshold are zero based.
-	 */
-	fifo_depth = AXG_FIFO_MIN_CNT - 1;
+	/* Use all fifo depth */
+	val = (fifo->depth / AXG_FIFO_BURST) - 1;
 	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH_MASK,
-			   CTRL1_FRDDR_DEPTH(fifo_depth));
+			   CTRL1_FRDDR_DEPTH(val));
 
 	return 0;
 }
-- 
2.23.0

