Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E45C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAF6214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="jrvjIlQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKGXQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:16:20 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:45281 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKGXQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:16:20 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1652E23E23;
        Fri,  8 Nov 2019 00:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1573168576;
        bh=3QkA7fpgg84g1/OjnwpVpOMBMUXMQKKIxrO3kIEdhKM=;
        h=From:To:Cc:Subject:Date:From;
        b=jrvjIlQwgiKG2vNPYy4NoV61k6XP/VM39t578SoTDO4Rut4Zns+IhCirGvlk7yYk7
         k05I346rQTqeApSM1RWfhkwf1aqE11kx0naQKHf6LBoo9XJ4kx5s6qIjn4gtkByCxv
         9+AKh23qR8Xk5j2J/64s8D+vwcnN3+mCT/Vc0Q0c=
From:   Michael Walle <michael@walle.cc>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] ASoC: wm8904: configure sysclk/FLL automatically
Date:   Fri,  8 Nov 2019 00:15:48 +0100
Message-Id: <20191107231548.17454-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new mode WM8904_CLK_AUTO which automatically enables the FLL
if a frequency different than the MCLK is set.

These additions make the codec work with the simple-card driver in
general and especially in systems where the MCLK doesn't match the
requested clock.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Unfortunately, I had to move wm8904_sys_sysclk() below wm8904_set_fll(). So
that makes this patch a bit ugly. The added part is the WM8904_CLK_AUTO
branch.

 sound/soc/codecs/wm8904.c | 72 ++++++++++++++++++++++++---------------
 sound/soc/codecs/wm8904.h |  1 +
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index bcb3c9d5abf0..2dd7addfd1a8 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1410,34 +1410,6 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-
-static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
-			     unsigned int freq, int dir)
-{
-	struct snd_soc_component *component = dai->component;
-	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
-
-	switch (clk_id) {
-	case WM8904_CLK_MCLK:
-		priv->sysclk_src = clk_id;
-		priv->mclk_rate = freq;
-		break;
-
-	case WM8904_CLK_FLL:
-		priv->sysclk_src = clk_id;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, freq);
-
-	wm8904_configure_clocking(component);
-
-	return 0;
-}
-
 static int wm8904_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
@@ -1824,6 +1796,50 @@ static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 	return 0;
 }
 
+static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+			     unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
+	unsigned long mclk_freq;
+	int ret;
+
+	switch (clk_id) {
+	case WM8904_CLK_AUTO:
+		mclk_freq = clk_get_rate(priv->mclk);
+		/* enable FLL if a different sysclk is desired */
+		if (mclk_freq != freq) {
+			priv->sysclk_src = WM8904_CLK_FLL;
+			ret = wm8904_set_fll(dai, WM8904_FLL_MCLK,
+					     WM8904_FLL_MCLK,
+					     clk_get_rate(priv->mclk), freq);
+			if (ret)
+				return ret;
+			break;
+		}
+		clk_id = WM8904_CLK_MCLK;
+		/* fallthrough */
+
+	case WM8904_CLK_MCLK:
+		priv->sysclk_src = clk_id;
+		priv->mclk_rate = freq;
+		break;
+
+	case WM8904_CLK_FLL:
+		priv->sysclk_src = clk_id;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, freq);
+
+	wm8904_configure_clocking(component);
+
+	return 0;
+}
+
 static int wm8904_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_component *component = codec_dai->component;
diff --git a/sound/soc/codecs/wm8904.h b/sound/soc/codecs/wm8904.h
index c1bca52f9927..de6340446b1f 100644
--- a/sound/soc/codecs/wm8904.h
+++ b/sound/soc/codecs/wm8904.h
@@ -10,6 +10,7 @@
 #ifndef _WM8904_H
 #define _WM8904_H
 
+#define WM8904_CLK_AUTO 0
 #define WM8904_CLK_MCLK 1
 #define WM8904_CLK_FLL  2
 
-- 
2.20.1

