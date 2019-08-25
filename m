Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B18B2173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ExzvFECv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfHYMRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:17:48 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:38447 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfHYMRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:17:44 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46GYyC0MrHzMK;
        Sun, 25 Aug 2019 14:16:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566735363; bh=gDXuzaQsy05jFmx1JaMN1xelDgVOPOeqv3Tv+dwhC3Y=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ExzvFECvHk3XkEZHQQAIFjtv+q2HSZhPD8FHfTbLCWyo3NfSuP7OlQo2NPSM/hLZF
         Qx2+4eVudsYY1BvPTSm9Wi3CDLTRDhqOrWKj0SsQrMYH77li4uZUtwXOFUwa4NHTSN
         OuIgF3qPoZqJ/70ZOMiPcfNLF/1ydo6tXm0JhKaYY7F8g1H0nXti7SzP0oRnEyiCI5
         BbMoJXWjlvFC7720ec7IY/dOFTonWSFT1yIrYn/STUQl5p5C9vsQhpOOAIzozEH/c7
         Ojv+82i9e9bdxZs6RA6H88XtRGrTMfg3nVPtKgFZ7ZYNKTcsAaLIptdvWs3Aseki4X
         6eAu4O8bgv87A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sun, 25 Aug 2019 14:17:38 +0200
Message-Id: <c82528965635440421f8679a3558e450a1633995.1566734631.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/4] [RFT] ASoC: wm8994: use common FLL code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Piotr Stankiewicz <piotrs@opensource.cirrus.com>,
        Nariman Poushin <npoushin@opensource.cirrus.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nikesh Oswal <nikesh@opensource.cirrus.com>,
        zhong jiang <zhongjiang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework FLL handling to use common code.
This uses polling for now to wait for FLL lock.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 sound/soc/codecs/Kconfig  |   2 +
 sound/soc/codecs/wm8994.c | 281 +++++++++++---------------------------
 sound/soc/codecs/wm8994.h |   4 +-
 3 files changed, 84 insertions(+), 203 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1a680023af7d..1ff6290ce18d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1382,6 +1382,8 @@ config SND_SOC_WM8993
 
 config SND_SOC_WM8994
 	tristate
+	select SND_SOC_WM_FLL
+	select SND_SOC_WM_FLL_EFS
 
 config SND_SOC_WM8995
 	tristate
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index c3d06e8bc54f..d0dbc352303b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2030,101 +2030,57 @@ static const struct snd_soc_dapm_route wm8958_intercon[] = {
 	{ "AIF3ADC Mux", "Mono PCM", "Mono PCM Out Mux" },
 };
 
-/* The size in bits of the FLL divide multiplied by 10
- * to allow rounding later */
-#define FIXED_FLL_SIZE ((1 << 16) * 10)
-
-struct fll_div {
-	u16 outdiv;
-	u16 n;
-	u16 k;
-	u16 lambda;
-	u16 clk_ref_div;
-	u16 fll_fratio;
+static const struct wm_fll_desc wm8994_fll_desc[2] = {
+	/* FLL1 */
+	{
+		.ctl_offset = WM8994_FLL1_CONTROL_1,
+		.int_offset = WM8994_INTERRUPT_RAW_STATUS_2,
+		.int_mask = WM8994_IM_FLL1_LOCK_EINT_MASK,
+		.nco_reg0 = WM8994_FLL1_CONTROL_5,
+		.frc_nco_shift = 6,
+		.nco_reg1 = WM8994_FLL1_CONTROL_5,
+		.frc_nco_val_shift = 7,
+		.clk_ref_map = { FLL_REF_MCLK, FLL_REF_MCLK2, FLL_REF_FSCLK, FLL_REF_BCLK },
+	},
+	/* FLL2 */
+	{
+		.ctl_offset = WM8994_FLL2_CONTROL_1,
+		.int_offset = WM8994_INTERRUPT_RAW_STATUS_2,
+		.int_mask = WM8994_IM_FLL2_LOCK_EINT_MASK,
+		.nco_reg0 = WM8994_FLL2_CONTROL_5,
+		.frc_nco_shift = 6,
+		.nco_reg1 = WM8994_FLL2_CONTROL_5,
+		.frc_nco_val_shift = 7,
+		.clk_ref_map = { FLL_REF_MCLK, FLL_REF_MCLK2, FLL_REF_FSCLK, FLL_REF_BCLK },
+	},
 };
 
-static int wm8994_get_fll_config(struct wm8994 *control, struct fll_div *fll,
-				 int freq_in, int freq_out)
-{
-	u64 Kpart;
-	unsigned int K, Ndiv, Nmod, gcd_fll;
-
-	pr_debug("FLL input=%dHz, output=%dHz\n", freq_in, freq_out);
-
-	/* Scale the input frequency down to <= 13.5MHz */
-	fll->clk_ref_div = 0;
-	while (freq_in > 13500000) {
-		fll->clk_ref_div++;
-		freq_in /= 2;
-
-		if (fll->clk_ref_div > 3)
-			return -EINVAL;
-	}
-	pr_debug("CLK_REF_DIV=%d, Fref=%dHz\n", fll->clk_ref_div, freq_in);
-
-	/* Scale the output to give 90MHz<=Fvco<=100MHz */
-	fll->outdiv = 3;
-	while (freq_out * (fll->outdiv + 1) < 90000000) {
-		fll->outdiv++;
-		if (fll->outdiv > 63)
-			return -EINVAL;
-	}
-	freq_out *= fll->outdiv + 1;
-	pr_debug("OUTDIV=%d, Fvco=%dHz\n", fll->outdiv, freq_out);
-
-	if (freq_in > 1000000) {
-		fll->fll_fratio = 0;
-	} else if (freq_in > 256000) {
-		fll->fll_fratio = 1;
-		freq_in *= 2;
-	} else if (freq_in > 128000) {
-		fll->fll_fratio = 2;
-		freq_in *= 4;
-	} else if (freq_in > 64000) {
-		fll->fll_fratio = 3;
-		freq_in *= 8;
-	} else {
-		fll->fll_fratio = 4;
-		freq_in *= 16;
-	}
-	pr_debug("FLL_FRATIO=%d, Fref=%dHz\n", fll->fll_fratio, freq_in);
-
-	/* Now, calculate N.K */
-	Ndiv = freq_out / freq_in;
-
-	fll->n = Ndiv;
-	Nmod = freq_out % freq_in;
-	pr_debug("Nmod=%d\n", Nmod);
-
-	switch (control->type) {
-	case WM8994:
-		/* Calculate fractional part - scale up so we can round. */
-		Kpart = FIXED_FLL_SIZE * (long long)Nmod;
-
-		do_div(Kpart, freq_in);
-
-		K = Kpart & 0xFFFFFFFF;
-
-		if ((K % 10) >= 5)
-			K += 5;
-
-		/* Move down to proper range now rounding is done */
-		fll->k = K / 10;
-		fll->lambda = 0;
-
-		pr_debug("N=%x K=%x\n", fll->n, fll->k);
-		break;
-
-	default:
-		gcd_fll = gcd(freq_out, freq_in);
-
-		fll->k = (freq_out - (freq_in * fll->n)) / gcd_fll;
-		fll->lambda = freq_in / gcd_fll;
-		
-	}
-
-	return 0;
-}
+static const struct wm_fll_desc wm8958_fll_desc[2] = {
+	/* FLL1 */
+	{
+		.ctl_offset = WM8994_FLL1_CONTROL_1,
+		.int_offset = WM8994_INTERRUPT_RAW_STATUS_2,
+		.int_mask = WM8994_IM_FLL1_LOCK_EINT_MASK,
+		.nco_reg0 = WM8994_FLL1_CONTROL_5,
+		.frc_nco_shift = 6,
+		.nco_reg1 = WM8994_FLL1_CONTROL_5,
+		.frc_nco_val_shift = 7,
+		.efs_offset = WM8958_FLL1_EFS_1,
+		.clk_ref_map = { FLL_REF_MCLK, FLL_REF_MCLK2, FLL_REF_FSCLK, FLL_REF_BCLK },
+	},
+	/* FLL2 */
+	{
+		.ctl_offset = WM8994_FLL2_CONTROL_1,
+		.int_offset = WM8994_INTERRUPT_RAW_STATUS_2,
+		.int_mask = WM8994_IM_FLL2_LOCK_EINT_MASK,
+		.nco_reg0 = WM8994_FLL2_CONTROL_5,
+		.frc_nco_shift = 6,
+		.nco_reg1 = WM8994_FLL2_CONTROL_5,
+		.frc_nco_val_shift = 7,
+		.efs_offset = WM8958_FLL1_EFS_1,
+		.clk_ref_map = { FLL_REF_MCLK, FLL_REF_MCLK2, FLL_REF_FSCLK, FLL_REF_BCLK },
+	},
+};
 
 static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 			  unsigned int freq_in, unsigned int freq_out)
@@ -2132,9 +2088,7 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
 	int reg_offset, ret;
-	struct fll_div fll;
 	u16 reg, clk1, aif_reg, aif_src;
-	unsigned long timeout;
 	bool was_enabled;
 
 	switch (id) {
@@ -2152,9 +2106,6 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 		return -EINVAL;
 	}
 
-	reg = snd_soc_component_read32(component, WM8994_FLL1_CONTROL_1 + reg_offset);
-	was_enabled = reg & WM8994_FLL1_ENA;
-
 	switch (src) {
 	case 0:
 		/* Allow no source specification when stopping */
@@ -2166,10 +2117,12 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 	case WM8994_FLL_SRC_MCLK2:
 	case WM8994_FLL_SRC_LRCLK:
 	case WM8994_FLL_SRC_BCLK:
+		src = wm8994_fll_desc[0].clk_ref_map[src - WM8994_FLL_SRC_MCLK1];
 		break;
 	case WM8994_FLL_SRC_INTERNAL:
 		freq_in = 12000000;
 		freq_out = 12000000;
+		src = FLL_REF_OSC;
 		break;
 	default:
 		return -EINVAL;
@@ -2180,18 +2133,6 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 	    wm8994->fll[id].in == freq_in && wm8994->fll[id].out == freq_out)
 		return 0;
 
-	/* If we're stopping the FLL redo the old config - no
-	 * registers will actually be written but we avoid GCC flow
-	 * analysis bugs spewing warnings.
-	 */
-	if (freq_out)
-		ret = wm8994_get_fll_config(control, &fll, freq_in, freq_out);
-	else
-		ret = wm8994_get_fll_config(control, &fll, wm8994->fll[id].in,
-					    wm8994->fll[id].out);
-	if (ret < 0)
-		return ret;
-
 	/* Make sure that we're not providing SYSCLK right now */
 	clk1 = snd_soc_component_read32(component, WM8994_CLOCKING_1);
 	if (clk1 & WM8994_SYSCLK_SRC)
@@ -2207,9 +2148,11 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 		return -EBUSY;
 	}
 
-	/* We always need to disable the FLL while reconfiguring */
-	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_1 + reg_offset,
-			    WM8994_FLL1_ENA, 0);
+	was_enabled = wm_fll_is_enabled(&wm8994->fll_hw[id]) > 0;
+
+	ret = wm_fll_disable(&wm8994->fll_hw[id]);
+	if (ret)
+		return ret;
 
 	if (wm8994->fll_byp && src == WM8994_FLL_SRC_BCLK &&
 	    freq_in == freq_out && freq_out) {
@@ -2217,46 +2160,21 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 		snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_5 + reg_offset,
 				    WM8958_FLL1_BYP, WM8958_FLL1_BYP);
 		goto out;
+	} else if (wm8994->fll_byp) {
+		snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_5 + reg_offset,
+				    WM8958_FLL1_BYP, 0);
 	}
 
-	reg = (fll.outdiv << WM8994_FLL1_OUTDIV_SHIFT) |
-		(fll.fll_fratio << WM8994_FLL1_FRATIO_SHIFT);
-	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_2 + reg_offset,
-			    WM8994_FLL1_OUTDIV_MASK |
-			    WM8994_FLL1_FRATIO_MASK, reg);
-
-	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_3 + reg_offset,
-			    WM8994_FLL1_K_MASK, fll.k);
-
-	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_4 + reg_offset,
-			    WM8994_FLL1_N_MASK,
-			    fll.n << WM8994_FLL1_N_SHIFT);
-
-	if (fll.lambda) {
-		snd_soc_component_update_bits(component, WM8958_FLL1_EFS_1 + reg_offset,
-				    WM8958_FLL1_LAMBDA_MASK,
-				    fll.lambda);
-		snd_soc_component_update_bits(component, WM8958_FLL1_EFS_2 + reg_offset,
-				    WM8958_FLL1_EFS_ENA, WM8958_FLL1_EFS_ENA);
-	} else {
-		snd_soc_component_update_bits(component, WM8958_FLL1_EFS_2 + reg_offset,
-				    WM8958_FLL1_EFS_ENA, 0);
-	}
-
-	snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_5 + reg_offset,
-			    WM8994_FLL1_FRC_NCO | WM8958_FLL1_BYP |
-			    WM8994_FLL1_REFCLK_DIV_MASK |
-			    WM8994_FLL1_REFCLK_SRC_MASK,
-			    ((src == WM8994_FLL_SRC_INTERNAL)
-			     << WM8994_FLL1_FRC_NCO_SHIFT) |
-			    (fll.clk_ref_div << WM8994_FLL1_REFCLK_DIV_SHIFT) |
-			    (src - 1));
-
-	/* Clear any pending completion from a previous failure */
-	try_wait_for_completion(&wm8994->fll_locked[id]);
-
-	/* Enable (with fractional mode if required) */
 	if (freq_out) {
+		wm8994->fll_hw[id].freq_in = freq_in;
+		ret = wm_fll_set_parent(&wm8994->fll_hw[id], src);
+		if (!ret)
+			ret = wm_fll_set_rate(&wm8994->fll_hw[id], freq_out);
+		if (!ret)
+			ret = wm_fll_enable(&wm8994->fll_hw[id]);
+		if (ret < 0)
+			return ret;
+
 		/* Enable VMID if we need it */
 		if (!was_enabled) {
 			active_reference(component);
@@ -2273,27 +2191,6 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 				break;
 			}
 		}
-
-		reg = WM8994_FLL1_ENA;
-
-		if (fll.k)
-			reg |= WM8994_FLL1_FRAC;
-		if (src == WM8994_FLL_SRC_INTERNAL)
-			reg |= WM8994_FLL1_OSC_ENA;
-
-		snd_soc_component_update_bits(component, WM8994_FLL1_CONTROL_1 + reg_offset,
-				    WM8994_FLL1_ENA | WM8994_FLL1_OSC_ENA |
-				    WM8994_FLL1_FRAC, reg);
-
-		if (wm8994->fll_locked_irq) {
-			timeout = wait_for_completion_timeout(&wm8994->fll_locked[id],
-							      msecs_to_jiffies(10));
-			if (timeout == 0)
-				dev_warn(component->dev,
-					 "Timed out waiting for FLL lock\n");
-		} else {
-			msleep(5);
-		}
 	} else {
 		if (was_enabled) {
 			switch (control->type) {
@@ -2350,15 +2247,6 @@ static int _wm8994_set_fll(struct snd_soc_component *component, int id, int src,
 	return 0;
 }
 
-static irqreturn_t wm8994_fll_locked_irq(int irq, void *data)
-{
-	struct completion *completion = data;
-
-	complete(completion);
-
-	return IRQ_HANDLED;
-}
-
 static int opclk_divs[] = { 10, 20, 30, 40, 55, 60, 80, 120, 160 };
 
 static int wm8994_set_fll(struct snd_soc_dai *dai, int id, int src,
@@ -3992,6 +3880,18 @@ static int wm8994_component_probe(struct snd_soc_component *component)
 
 	snd_soc_component_init_regmap(component, control->regmap);
 
+	for (i = 0; i < ARRAY_SIZE(wm8994->fll_hw); ++i) {
+		wm8994->fll_hw[i].regmap = control->regmap;
+		if (control->type == WM8994)
+			wm8994->fll_hw[i].desc = wm8994_fll_desc;
+		else
+			wm8994->fll_hw[i].desc = wm8958_fll_desc;
+
+		ret = wm_fll_init(&wm8994->fll_hw[i]);
+		if (ret)
+			return ret;
+	}
+
 	wm8994->hubs.component = component;
 
 	mutex_init(&wm8994->accdet_lock);
@@ -4013,9 +3913,6 @@ static int wm8994_component_probe(struct snd_soc_component *component)
 
 	INIT_DELAYED_WORK(&wm8994->mic_complete_work, wm8958_mic_work);
 
-	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
-		init_completion(&wm8994->fll_locked[i]);
-
 	wm8994->micdet_irq = control->pdata.micdet_irq;
 
 	/* By default use idle_bias_off, will override for WM8994 */
@@ -4166,16 +4063,6 @@ static int wm8994_component_probe(struct snd_soc_component *component)
 		break;
 	}
 
-	wm8994->fll_locked_irq = true;
-	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++) {
-		ret = wm8994_request_irq(wm8994->wm8994,
-					 WM8994_IRQ_FLL1_LOCK + i,
-					 wm8994_fll_locked_irq, "FLL lock",
-					 &wm8994->fll_locked[i]);
-		if (ret != 0)
-			wm8994->fll_locked_irq = false;
-	}
-
 	/* Make sure we can read from the GPIOs if they're inputs */
 	pm_runtime_get_sync(component->dev);
 
@@ -4377,9 +4264,6 @@ static int wm8994_component_probe(struct snd_soc_component *component)
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC1_SHRT, wm8994);
 	if (wm8994->micdet_irq)
 		free_irq(wm8994->micdet_irq, wm8994);
-	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
-		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FLL1_LOCK + i,
-				&wm8994->fll_locked[i]);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, component);
@@ -4393,11 +4277,6 @@ static void wm8994_component_remove(struct snd_soc_component *component)
 {
 	struct wm8994_priv *wm8994 = snd_soc_component_get_drvdata(component);
 	struct wm8994 *control = wm8994->wm8994;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
-		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FLL1_LOCK + i,
-				&wm8994->fll_locked[i]);
 
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 1d6f2abe1c11..9c61d95c9053 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 
 #include "wm_hubs.h"
+#include "wm_fll.h"
 
 /* Sources for AIF1/2 SYSCLK - use with set_dai_sysclk() */
 #define WM8994_SYSCLK_MCLK1 1
@@ -80,8 +81,7 @@ struct wm8994_priv {
 	int aifdiv[2];
 	int channels[2];
 	struct wm8994_fll_config fll[2], fll_suspend[2];
-	struct completion fll_locked[2];
-	bool fll_locked_irq;
+	struct wm_fll_data fll_hw[2];
 	bool fll_byp;
 	bool clk_has_run;
 
-- 
2.20.1

