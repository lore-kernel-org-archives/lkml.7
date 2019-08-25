Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA5CC41514
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD3F2173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="aHZ8nXmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfHYMRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:17:43 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:52351 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfHYMRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:17:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46GYy85L4VzLD;
        Sun, 25 Aug 2019 14:16:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566735361; bh=rDZuxcNd59H8gsxv7pZ5ojvh+ApU8FWsC3eT0ah44MY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=aHZ8nXmpunGy9FLEowbXz/PAW/e5iDsED9x1HEbD97b6bel7649iDfFQnJJcLb1ZU
         z5bHwUAAPOYMVRbvzHSYTDYWk0X429IDIqiP1eIRMuSeMUwGP9lXl8n9RPsOq4ZLOn
         L7Dyg6MRzAIpjMHFLPXP9fLn88ATLwYhNl5FxCSYuTlvEBUP6HjLQfdBU6EuLT0xrt
         JmBSOM7DBR1IFYvhoQnhWYGxaMZKDnjkEBN9YFpldGPpbk+L1U/7jhqpN6ilGZ39Te
         eJhjbx8UBQilNkiFzwHe+vzU15AioWg/EF+p/z/EPIUwzPMOAAUB8XzFdQl4UOuDFl
         +anADmLqIGEBQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sun, 25 Aug 2019 14:17:35 +0200
Message-Id: <1136f2dcc822821afda9f9533f40637647929bdf.1566734630.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/4] ASoC: wm8904: use common FLL code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Piotr Stankiewicz <piotrs@opensource.cirrus.com>,
        Nikesh Oswal <nikesh@opensource.cirrus.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Nariman Poushin <npoushin@opensource.cirrus.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework FLL handling to use common code introduced earlier.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 sound/soc/atmel/atmel_wm8904.c |  11 +-
 sound/soc/codecs/Kconfig       |   1 +
 sound/soc/codecs/wm8904.c      | 476 ++++++++++-----------------------
 sound/soc/codecs/wm8904.h      |   5 -
 4 files changed, 140 insertions(+), 353 deletions(-)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index 776b27d3686e..b77ea2495efe 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -30,20 +30,11 @@ static int atmel_asoc_wm8904_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_pll(codec_dai, WM8904_FLL_MCLK, WM8904_FLL_MCLK,
-		32768, params_rate(params) * 256);
-	if (ret < 0) {
-		pr_err("%s - failed to set wm8904 codec PLL.", __func__);
-		return ret;
-	}
-
 	/*
 	 * As here wm8904 use FLL output as its system clock
-	 * so calling set_sysclk won't care freq parameter
-	 * then we pass 0
 	 */
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8904_CLK_FLL,
-			0, SND_SOC_CLOCK_IN);
+			params_rate(params) * 256, SND_SOC_CLOCK_IN);
 	if (ret < 0) {
 		pr_err("%s -failed to set wm8904 SYSCLK\n", __func__);
 		return ret;
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 04086acf6d93..1a680023af7d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1331,6 +1331,7 @@ config SND_SOC_WM8903
 config SND_SOC_WM8904
 	tristate "Wolfson Microelectronics WM8904 CODEC"
 	depends on I2C
+	select SND_SOC_WM_FLL
 
 config SND_SOC_WM8940
         tristate
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index bcb3c9d5abf0..c9318fe34f91 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -24,6 +24,7 @@
 #include <sound/tlv.h>
 #include <sound/wm8904.h>
 
+#include "wm_fll.h"
 #include "wm8904.h"
 
 enum wm8904_type {
@@ -66,12 +67,8 @@ struct wm8904_priv {
 	int retune_mobile_cfg;
 	struct soc_enum retune_mobile_enum;
 
-	/* FLL setup */
-	int fll_src;
-	int fll_fref;
-	int fll_fout;
-
 	/* Clocking configuration */
+	struct wm_fll_data fll;
 	unsigned int mclk_rate;
 	int sysclk_src;
 	unsigned int sysclk_rate;
@@ -311,35 +308,111 @@ static bool wm8904_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8904_configure_clocking(struct snd_soc_component *component)
+static void wm8904_unprepare_sysclk(struct wm8904_priv *priv)
 {
+	switch (priv->sysclk_src) {
+	case WM8904_CLK_MCLK:
+		clk_disable_unprepare(priv->mclk);
+		break;
+
+	case WM8904_CLK_FLL:
+		wm_fll_disable(&priv->fll);
+		break;
+	}
+}
+
+static int wm8904_prepare_sysclk(struct wm8904_priv *priv)
+{
+	int err;
+
+	switch (priv->sysclk_src) {
+	case WM8904_CLK_MCLK:
+		err = clk_set_rate(priv->mclk, priv->mclk_rate);
+		if (!err)
+			err = clk_prepare_enable(priv->mclk);
+		break;
+
+	case WM8904_CLK_FLL:
+		err = wm_fll_enable(&priv->fll);
+		break;
+
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+static void wm8904_disable_sysclk(struct wm8904_priv *priv)
+{
+	regmap_update_bits(priv->regmap, WM8904_CLOCK_RATES_2,
+			   WM8904_CLK_SYS_ENA, 0);
+	wm8904_unprepare_sysclk(priv);
+}
+
+static int wm8904_enable_sysclk(struct wm8904_priv *priv)
+{
+	int err;
+
+	err = wm8904_prepare_sysclk(priv);
+	if (err < 0)
+		return err;
+
+	err = regmap_update_bits(priv->regmap, WM8904_CLOCK_RATES_2,
+				 WM8904_CLK_SYS_ENA_MASK, WM8904_CLK_SYS_ENA);
+	if (err < 0)
+		wm8904_unprepare_sysclk(priv);
+
+	return err;
+}
+
+static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+			     unsigned int rate, int dir)
+{
+	struct snd_soc_component *component = dai->component;
 	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
-	unsigned int clock0, clock2, rate;
+	unsigned int clock0, clock2;
+	int err;
+
+	switch (clk_id) {
+	case WM8904_CLK_MCLK:
+	case WM8904_CLK_FLL:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (clk_id == wm8904->sysclk_src && rate == wm8904->mclk_rate)
+		return 0;
+
+	dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, rate);
 
 	/* Gate the clock while we're updating to avoid misclocking */
 	clock2 = snd_soc_component_read32(component, WM8904_CLOCK_RATES_2);
-	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
-			    WM8904_SYSCLK_SRC, 0);
+	wm8904_disable_sysclk(wm8904);
+
+	wm8904->sysclk_src = clk_id;
+	wm8904->mclk_rate = rate;
 
-	/* This should be done on init() for bypass paths */
 	switch (wm8904->sysclk_src) {
 	case WM8904_CLK_MCLK:
-		dev_dbg(component->dev, "Using %dHz MCLK\n", wm8904->mclk_rate);
+		dev_dbg(component->dev, "Using %dHz MCLK\n", rate);
 
 		clock2 &= ~WM8904_SYSCLK_SRC;
-		rate = wm8904->mclk_rate;
-
-		/* Ensure the FLL is stopped */
-		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-				    WM8904_FLL_OSC_ENA | WM8904_FLL_ENA, 0);
 		break;
 
 	case WM8904_CLK_FLL:
-		dev_dbg(component->dev, "Using %dHz FLL clock\n",
-			wm8904->fll_fout);
+		err = wm_fll_set_rate(&wm8904->fll, rate);
+		if (err < 0) {
+			dev_err(component->dev, "Failed to set FLL rate: %d\n", err);
+			return err;
+		}
+
+		dev_dbg(component->dev, "Using %dHz FLL clock\n", rate);
 
 		clock2 |= WM8904_SYSCLK_SRC;
-		rate = wm8904->fll_fout;
 		break;
 
 	default:
@@ -356,11 +429,18 @@ static int wm8904_configure_clocking(struct snd_soc_component *component)
 		wm8904->sysclk_rate = rate;
 	}
 
-	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_0, WM8904_MCLK_DIV,
-			    clock0);
-
+	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_0,
+				      WM8904_MCLK_DIV, clock0);
 	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
-			    WM8904_CLK_SYS_ENA | WM8904_SYSCLK_SRC, clock2);
+				      WM8904_SYSCLK_SRC, clock2);
+
+	if (clock2 & WM8904_CLK_SYS_ENA) {
+		err = wm8904_enable_sysclk(wm8904);
+		if (err < 0) {
+			dev_err(component->dev, "Failed to reenable CLK_SYS: %d\n", err);
+			return err;
+		}
+	}
 
 	dev_dbg(component->dev, "CLK_SYS is %dHz\n", wm8904->sysclk_rate);
 
@@ -655,33 +735,21 @@ static int sysclk_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
+	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		/* If we're using the FLL then we only start it when
-		 * required; we assume that the configuration has been
-		 * done previously and all we need to do is kick it
-		 * off.
-		 */
-		switch (wm8904->sysclk_src) {
-		case WM8904_CLK_FLL:
-			snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-					    WM8904_FLL_OSC_ENA,
-					    WM8904_FLL_OSC_ENA);
-
-			snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-					    WM8904_FLL_ENA,
-					    WM8904_FLL_ENA);
-			break;
-
-		default:
-			break;
-		}
+		ret = wm8904_prepare_sysclk(wm8904);
+		if (ret)
+			dev_err(component->dev,
+				"Failed to prepare SYSCLK: %d\n", ret);
+		else
+			dev_dbg(component->dev, "SYSCLK on\n");
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-				    WM8904_FLL_OSC_ENA | WM8904_FLL_ENA, 0);
+		wm8904_unprepare_sysclk(wm8904);
+		dev_dbg(component->dev, "SYSCLK off\n");
 		break;
 	}
 
@@ -1289,7 +1357,7 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
-	int ret, i, best, best_val, cur_val;
+	int i, best, best_val, cur_val;
 	unsigned int aif1 = 0;
 	unsigned int aif2 = 0;
 	unsigned int aif3 = 0;
@@ -1324,13 +1392,8 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-
 	dev_dbg(component->dev, "Target BCLK is %dHz\n", wm8904->bclk);
 
-	ret = wm8904_configure_clocking(component);
-	if (ret != 0)
-		return ret;
-
 	/* Select nearest CLK_SYS_RATE */
 	best = 0;
 	best_val = abs((wm8904->sysclk_rate / clk_sys_rates[0].ratio)
@@ -1382,8 +1445,8 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 	wm8904->bclk = (wm8904->sysclk_rate * 10) / bclk_divs[best].div;
-	dev_dbg(component->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
-		bclk_divs[best].div, wm8904->bclk);
+	dev_dbg(component->dev, "Selected BCLK_DIV of %d.%d for %dHz BCLK\n",
+		bclk_divs[best].div / 10, bclk_divs[best].div % 10,  wm8904->bclk);
 	aif2 |= bclk_divs[best].bclk_div;
 
 	/* LRCLK is a simple fraction of BCLK */
@@ -1410,34 +1473,6 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
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
@@ -1577,253 +1612,6 @@ static int wm8904_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	return 0;
 }
 
-struct _fll_div {
-	u16 fll_fratio;
-	u16 fll_outdiv;
-	u16 fll_clk_ref_div;
-	u16 n;
-	u16 k;
-};
-
-/* The size in bits of the FLL divide multiplied by 10
- * to allow rounding later */
-#define FIXED_FLL_SIZE ((1 << 16) * 10)
-
-static struct {
-	unsigned int min;
-	unsigned int max;
-	u16 fll_fratio;
-	int ratio;
-} fll_fratios[] = {
-	{       0,    64000, 4, 16 },
-	{   64000,   128000, 3,  8 },
-	{  128000,   256000, 2,  4 },
-	{  256000,  1000000, 1,  2 },
-	{ 1000000, 13500000, 0,  1 },
-};
-
-static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
-		       unsigned int Fout)
-{
-	u64 Kpart;
-	unsigned int K, Ndiv, Nmod, target;
-	unsigned int div;
-	int i;
-
-	/* Fref must be <=13.5MHz */
-	div = 1;
-	fll_div->fll_clk_ref_div = 0;
-	while ((Fref / div) > 13500000) {
-		div *= 2;
-		fll_div->fll_clk_ref_div++;
-
-		if (div > 8) {
-			pr_err("Can't scale %dMHz input down to <=13.5MHz\n",
-			       Fref);
-			return -EINVAL;
-		}
-	}
-
-	pr_debug("Fref=%u Fout=%u\n", Fref, Fout);
-
-	/* Apply the division for our remaining calculations */
-	Fref /= div;
-
-	/* Fvco should be 90-100MHz; don't check the upper bound */
-	div = 4;
-	while (Fout * div < 90000000) {
-		div++;
-		if (div > 64) {
-			pr_err("Unable to find FLL_OUTDIV for Fout=%uHz\n",
-			       Fout);
-			return -EINVAL;
-		}
-	}
-	target = Fout * div;
-	fll_div->fll_outdiv = div - 1;
-
-	pr_debug("Fvco=%dHz\n", target);
-
-	/* Find an appropriate FLL_FRATIO and factor it out of the target */
-	for (i = 0; i < ARRAY_SIZE(fll_fratios); i++) {
-		if (fll_fratios[i].min <= Fref && Fref <= fll_fratios[i].max) {
-			fll_div->fll_fratio = fll_fratios[i].fll_fratio;
-			target /= fll_fratios[i].ratio;
-			break;
-		}
-	}
-	if (i == ARRAY_SIZE(fll_fratios)) {
-		pr_err("Unable to find FLL_FRATIO for Fref=%uHz\n", Fref);
-		return -EINVAL;
-	}
-
-	/* Now, calculate N.K */
-	Ndiv = target / Fref;
-
-	fll_div->n = Ndiv;
-	Nmod = target % Fref;
-	pr_debug("Nmod=%d\n", Nmod);
-
-	/* Calculate fractional part - scale up so we can round. */
-	Kpart = FIXED_FLL_SIZE * (long long)Nmod;
-
-	do_div(Kpart, Fref);
-
-	K = Kpart & 0xFFFFFFFF;
-
-	if ((K % 10) >= 5)
-		K += 5;
-
-	/* Move down to proper range now rounding is done */
-	fll_div->k = K / 10;
-
-	pr_debug("N=%x K=%x FLL_FRATIO=%x FLL_OUTDIV=%x FLL_CLK_REF_DIV=%x\n",
-		 fll_div->n, fll_div->k,
-		 fll_div->fll_fratio, fll_div->fll_outdiv,
-		 fll_div->fll_clk_ref_div);
-
-	return 0;
-}
-
-static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
-			  unsigned int Fref, unsigned int Fout)
-{
-	struct snd_soc_component *component = dai->component;
-	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
-	struct _fll_div fll_div;
-	int ret, val;
-	int clock2, fll1;
-
-	/* Any change? */
-	if (source == wm8904->fll_src && Fref == wm8904->fll_fref &&
-	    Fout == wm8904->fll_fout)
-		return 0;
-
-	clock2 = snd_soc_component_read32(component, WM8904_CLOCK_RATES_2);
-
-	if (Fout == 0) {
-		dev_dbg(component->dev, "FLL disabled\n");
-
-		wm8904->fll_fref = 0;
-		wm8904->fll_fout = 0;
-
-		/* Gate SYSCLK to avoid glitches */
-		snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
-				    WM8904_CLK_SYS_ENA, 0);
-
-		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-				    WM8904_FLL_OSC_ENA | WM8904_FLL_ENA, 0);
-
-		goto out;
-	}
-
-	/* Validate the FLL ID */
-	switch (source) {
-	case WM8904_FLL_MCLK:
-	case WM8904_FLL_LRCLK:
-	case WM8904_FLL_BCLK:
-		ret = fll_factors(&fll_div, Fref, Fout);
-		if (ret != 0)
-			return ret;
-		break;
-
-	case WM8904_FLL_FREE_RUNNING:
-		dev_dbg(component->dev, "Using free running FLL\n");
-		/* Force 12MHz and output/4 for now */
-		Fout = 12000000;
-		Fref = 12000000;
-
-		memset(&fll_div, 0, sizeof(fll_div));
-		fll_div.fll_outdiv = 3;
-		break;
-
-	default:
-		dev_err(component->dev, "Unknown FLL ID %d\n", fll_id);
-		return -EINVAL;
-	}
-
-	/* Save current state then disable the FLL and SYSCLK to avoid
-	 * misclocking */
-	fll1 = snd_soc_component_read32(component, WM8904_FLL_CONTROL_1);
-	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
-			    WM8904_CLK_SYS_ENA, 0);
-	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-			    WM8904_FLL_OSC_ENA | WM8904_FLL_ENA, 0);
-
-	/* Unlock forced oscilator control to switch it on/off */
-	snd_soc_component_update_bits(component, WM8904_CONTROL_INTERFACE_TEST_1,
-			    WM8904_USER_KEY, WM8904_USER_KEY);
-
-	if (fll_id == WM8904_FLL_FREE_RUNNING) {
-		val = WM8904_FLL_FRC_NCO;
-	} else {
-		val = 0;
-	}
-
-	snd_soc_component_update_bits(component, WM8904_FLL_NCO_TEST_1, WM8904_FLL_FRC_NCO,
-			    val);
-	snd_soc_component_update_bits(component, WM8904_CONTROL_INTERFACE_TEST_1,
-			    WM8904_USER_KEY, 0);
-
-	switch (fll_id) {
-	case WM8904_FLL_MCLK:
-		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_5,
-				    WM8904_FLL_CLK_REF_SRC_MASK, 0);
-		break;
-
-	case WM8904_FLL_LRCLK:
-		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_5,
-				    WM8904_FLL_CLK_REF_SRC_MASK, 1);
-		break;
-
-	case WM8904_FLL_BCLK:
-		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_5,
-				    WM8904_FLL_CLK_REF_SRC_MASK, 2);
-		break;
-	}
-
-	if (fll_div.k)
-		val = WM8904_FLL_FRACN_ENA;
-	else
-		val = 0;
-	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-			    WM8904_FLL_FRACN_ENA, val);
-
-	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_2,
-			    WM8904_FLL_OUTDIV_MASK | WM8904_FLL_FRATIO_MASK,
-			    (fll_div.fll_outdiv << WM8904_FLL_OUTDIV_SHIFT) |
-			    (fll_div.fll_fratio << WM8904_FLL_FRATIO_SHIFT));
-
-	snd_soc_component_write(component, WM8904_FLL_CONTROL_3, fll_div.k);
-
-	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_4, WM8904_FLL_N_MASK,
-			    fll_div.n << WM8904_FLL_N_SHIFT);
-
-	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_5,
-			    WM8904_FLL_CLK_REF_DIV_MASK,
-			    fll_div.fll_clk_ref_div 
-			    << WM8904_FLL_CLK_REF_DIV_SHIFT);
-
-	dev_dbg(component->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
-
-	wm8904->fll_fref = Fref;
-	wm8904->fll_fout = Fout;
-	wm8904->fll_src = source;
-
-	/* Enable the FLL if it was previously active */
-	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-			    WM8904_FLL_OSC_ENA, fll1);
-	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
-			    WM8904_FLL_ENA, fll1);
-
-out:
-	/* Reenable SYSCLK if it was previously active */
-	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
-			    WM8904_CLK_SYS_ENA, clock2);
-
-	return 0;
-}
-
 static int wm8904_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_component *component = codec_dai->component;
@@ -1871,15 +1659,6 @@ static int wm8904_set_bias_level(struct snd_soc_component *component,
 				return ret;
 			}
 
-			ret = clk_prepare_enable(wm8904->mclk);
-			if (ret) {
-				dev_err(component->dev,
-					"Failed to enable MCLK: %d\n", ret);
-				regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies),
-						       wm8904->supplies);
-				return ret;
-			}
-
 			regcache_cache_only(wm8904->regmap, false);
 			regcache_sync(wm8904->regmap);
 
@@ -1922,7 +1701,6 @@ static int wm8904_set_bias_level(struct snd_soc_component *component,
 
 		regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies),
 				       wm8904->supplies);
-		clk_disable_unprepare(wm8904->mclk);
 		break;
 	}
 	return 0;
@@ -1937,7 +1715,6 @@ static const struct snd_soc_dai_ops wm8904_dai_ops = {
 	.set_sysclk = wm8904_set_sysclk,
 	.set_fmt = wm8904_set_fmt,
 	.set_tdm_slot = wm8904_set_tdm_slot,
-	.set_pll = wm8904_set_fll,
 	.hw_params = wm8904_hw_params,
 	.digital_mute = wm8904_digital_mute,
 };
@@ -2123,6 +1900,15 @@ static const struct regmap_config wm8904_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8904_reg_defaults),
 };
 
+static const struct wm_fll_desc wm8904_fll_desc = {
+	.ctl_offset = WM8904_FLL_CONTROL_1,
+	.int_offset = WM8904_INTERRUPT_STATUS,
+	.int_mask = WM8904_FLL_LOCK_EINT_MASK,
+	.nco_reg0 = WM8904_FLL_NCO_TEST_0,
+	.nco_reg1 = WM8904_FLL_NCO_TEST_1,
+	.clk_ref_map = { FLL_REF_MCLK, FLL_REF_BCLK, FLL_REF_FSCLK, /* reserved */ 0 },
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id wm8904_of_match[] = {
 	{
@@ -2165,6 +1951,19 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	wm8904->fll.regmap = wm8904->regmap;
+	wm8904->fll.desc = &wm8904_fll_desc;
+	ret = wm_fll_init_with_clk(&wm8904->fll);
+	if (ret)
+		return ret;
+
+	ret = wm_fll_set_parent(&wm8904->fll, FLL_REF_MCLK);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to select MCLK as FLL input: %d\n",
+			ret);
+		return ret;
+	}
+
 	if (i2c->dev.of_node) {
 		const struct of_device_id *match;
 
@@ -2276,6 +2075,7 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 			    WM8904_POBCTRL, 0);
 
 	/* Can leave the device powered off until we need it */
+	wm8904_disable_sysclk(wm8904);
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
 
diff --git a/sound/soc/codecs/wm8904.h b/sound/soc/codecs/wm8904.h
index c1bca52f9927..60af09e0bb15 100644
--- a/sound/soc/codecs/wm8904.h
+++ b/sound/soc/codecs/wm8904.h
@@ -13,11 +13,6 @@
 #define WM8904_CLK_MCLK 1
 #define WM8904_CLK_FLL  2
 
-#define WM8904_FLL_MCLK          1
-#define WM8904_FLL_BCLK          2
-#define WM8904_FLL_LRCLK         3
-#define WM8904_FLL_FREE_RUNNING  4
-
 /*
  * Register values.
  */
-- 
2.20.1

