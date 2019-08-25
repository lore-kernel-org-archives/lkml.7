Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88681C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493F52173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="irfSnMJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfHYMRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:17:40 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:38252 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfHYMRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:17:40 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46GYy71S6PzGc;
        Sun, 25 Aug 2019 14:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566735359; bh=k+g04bWs/AHBWvnKGZhPer08vaUiFby8g4I+oyqQ/wY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=irfSnMJAOAER/QWDpwp7wQXGS6mqwx60utJ7u9ZY6KZwa4MlsnZ6HtBWms9ix07Ai
         UIcKo1bIHG0XqkfaC7bR7apydNwN97XrQjq3ZxIpQdMQmiejRq4KmU6Cl97ZmMxmpb
         jCmtW6g0bIHN/AIOEDUUAr0UKL2+bWFDu7k8UBf1Ho/6qzA0+ILm1G8hPeruXP8uUN
         MOeFLdTPrcKItyKSyAxUaowCpm2dEg98Pp4KoDDTNR7bxrqe14BR8fj4xN3tEj1/H9
         +hzivkflgS33qh0Qn/S7MotZdftK2C4cAkl4kdPbBKm3YRCdo7RWaLtEGGlPuYq/BV
         3jYRDgbttLzfw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sun, 25 Aug 2019 14:17:34 +0200
Message-Id: <c1f9bf5e6ead46e4e2d3a11b10d435661f35c8a3.1566734630.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/4] ASoC: wm_fll: extract common code for Wolfson FLLs
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Randy Dunlap <rdunlap@infradead.org>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nariman Poushin <npoushin@opensource.cirrus.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nikesh Oswal <nikesh@opensource.cirrus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new implementation for FLLs as contained in WM8904, WM8994 and a few
other Cirrus Logic (formerly Wolfson) codecs. Patches using this common
code follow.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 sound/soc/codecs/Kconfig  |   6 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/wm_fll.c | 518 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_fll.h |  60 +++++
 4 files changed, 586 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9f89a5346299..04086acf6d93 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -281,6 +281,12 @@ config SND_SOC_ARIZONA
 	default m if SND_SOC_WM8997=m
 	default m if SND_SOC_WM8998=m
 
+config SND_SOC_WM_FLL
+	tristate
+
+config SND_SOC_WM_FLL_EFS
+	bool
+
 config SND_SOC_WM_HUBS
 	tristate
 	default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5b4bb8cf4325..22704fbb7497 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -269,6 +269,7 @@ snd-soc-wm9090-objs := wm9090.o
 snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
+snd-soc-wm-fll-objs := wm_fll.o
 snd-soc-wm-hubs-objs := wm_hubs.o
 snd-soc-zx-aud96p22-objs := zx_aud96p22.o
 # Amp
@@ -549,6 +550,7 @@ obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
+obj-$(CONFIG_SND_SOC_WM_FLL)	+= snd-soc-wm-fll.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 obj-$(CONFIG_SND_SOC_ZX_AUD96P22) += snd-soc-zx-aud96p22.o
 
diff --git a/sound/soc/codecs/wm_fll.c b/sound/soc/codecs/wm_fll.c
new file mode 100644
index 000000000000..0d8217287030
--- /dev/null
+++ b/sound/soc/codecs/wm_fll.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * wm_fll.c  --  WM89xx FLL support
+ *
+ * Copyright 2019 Michał Mirosław
+ *
+ * WM can generate its clock directly from MCLK, from
+ * internal FLL synchronizing to one of hw frame clocks
+ * or from FLL's VCO in free-running mode
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/gcd.h>
+#include <linux/kernel.h>
+
+#include "wm_fll.h"
+
+/* FLL Control 1 */
+#define WM_FLL_CONTROL_1	(hw->desc->ctl_offset + 0)
+#define WM_FLL_FRACN_ENA		BIT(2)
+#define WM_FLL_OSC_ENA			BIT(1)
+#define WM_FLL_ENA			BIT(0)
+
+/* FLL Control 2 */
+#define WM_FLL_CONTROL_2	(hw->desc->ctl_offset + 1)
+#define WM_FLL_OUTDIV			GENMASK(13, 8)
+#define WM_FLL_CTRL_RATE		GENMASK(6, 4)
+#define WM_FLL_FRATIO			GENMASK(2, 0)
+
+/* FLL Control 3 */
+#define WM_FLL_CONTROL_3	(hw->desc->ctl_offset + 2)
+#define WM_FLL_K			GENMASK(15, 0)
+
+/* FLL Control 4 */
+#define WM_FLL_CONTROL_4	(hw->desc->ctl_offset + 3)
+#define WM_FLL_N			GENMASK(14, 5)
+#define WM_FLL_GAIN			GENMASK(3, 0)
+
+/* FLL Control 5 */
+#define WM_FLL_CONTROL_5	(hw->desc->ctl_offset + 4)
+#define WM_FLL_CLK_REF_DIV		GENMASK(4, 3)
+#define WM_FLL_CLK_REF_SRC		GENMASK(1, 0)
+
+/* Interrupt Status */
+#define WM_INTERRUPT_STATUS	(hw->desc->int_offset + 0)
+
+/* FLL NCO Test 0 (part of FLL Control 5 on some chips) */
+#define WM_FLL_NCO_TEST_0	(hw->desc->nco_reg0)
+#define WM_FLL_FRC_NCO			BIT(0)
+
+/* FLL NCO Test 1 (part of FLL Control 5 on some chips) */
+#define WM_FLL_NCO_TEST_1	(hw->desc->nco_reg1)
+#define WM_FLL_FRC_NCO_VAL		GENMASK(5, 0)
+
+/* FLL EFS 1 (chips with N+THETA/LAMBDA instead of N.K multiplier) */
+#define WM_FLL_EFS_1		(hw->desc->efs_offset + 0)
+#define WM_FLL_LAMBDA			GENMASK(15, 0)
+
+/* FLL EFS 2 (chips with N+THETA/LAMBDA instead of N.K multiplier) */
+#define WM_FLL_EFS_2		(hw->desc->efs_offset + 1)
+#define WM_FLL_EFS_ENA			BIT(0)
+
+
+/* feature tests */
+#define WM_FLL_USES_EFS(hw)	(IS_ENABLED(CONFIG_SND_SOC_WM_FLL_EFS) && hw->desc->efs_offset)
+
+
+static bool wm_fll_in_free_running_mode(struct wm_fll_data *hw)
+{
+	unsigned int val;
+
+	if (!hw->desc->nco_reg0)
+		return false;
+	if (regmap_read(hw->regmap, WM_FLL_NCO_TEST_0, &val) < 0)
+		return false;
+
+	val >>= hw->desc->frc_nco_shift;
+	return FIELD_GET(WM_FLL_FRC_NCO, val);
+}
+
+static int wm_fll_set_free_running_mode(struct wm_fll_data *hw, bool enable)
+{
+	unsigned int val, mask;
+	int err;
+
+	if (!hw->desc->nco_reg0)
+		return enable ? -EINVAL : 0;
+
+	if (enable) {
+		/* set osc freq (approx 96MHz) */
+		val = FIELD_PREP(WM_FLL_FRC_NCO_VAL, 0x19);
+		mask = WM_FLL_FRC_NCO_VAL;
+
+		val <<= hw->desc->frc_nco_val_shift;
+		mask <<= hw->desc->frc_nco_val_shift;
+
+		err = regmap_update_bits(hw->regmap, WM_FLL_NCO_TEST_1,
+					 mask, val);
+		if (err)
+			return err;
+	}
+
+	/* set free-running mode */
+	val = FIELD_PREP(WM_FLL_FRC_NCO, enable);
+	mask = WM_FLL_FRC_NCO;
+
+	val <<= hw->desc->frc_nco_shift;
+	mask <<= hw->desc->frc_nco_shift;
+
+	return regmap_update_bits(hw->regmap, WM_FLL_NCO_TEST_0,
+				  mask, val);
+}
+
+static int wm_fll_get_parent(struct wm_fll_data *hw)
+{
+	unsigned int val;
+	int err;
+
+	/* free-running mode? */
+	if (wm_fll_in_free_running_mode(hw))
+		return FLL_REF_OSC;
+
+	err = regmap_read(hw->regmap, WM_FLL_CONTROL_5, &val);
+	if (err < 0)
+		return err;
+
+	val = FIELD_GET(WM_FLL_CLK_REF_SRC, val);
+	return hw->desc->clk_ref_map[val];
+}
+
+/**
+ * wm_fll_set_parent() - Change FLL clock source
+ *
+ * @hw: FLL hardware info
+ * @index: FLL source clock id
+ *
+ * Configures FLL for using @index clock as input.
+ *
+ * Return 0 if successful, error code if not.
+ */
+int wm_fll_set_parent(struct wm_fll_data *hw, enum wm_fll_ref_source index)
+{
+	unsigned int ref;
+	bool osc_en;
+	int err;
+
+	osc_en = index == FLL_REF_OSC;
+	err = wm_fll_set_free_running_mode(hw, osc_en);
+	if (osc_en || err)
+		return err;
+
+	err = -EINVAL;
+	for (ref = 0; ref < ARRAY_SIZE(hw->desc->clk_ref_map); ++ref) {
+		if (hw->desc->clk_ref_map[ref] != index)
+			continue;
+
+		err = 0;
+		break;
+	}
+	if (err < 0)
+		return err;
+
+	/* set FLL reference input */
+	ref = FIELD_PREP(WM_FLL_CLK_REF_SRC, ref);
+	err = regmap_update_bits(hw->regmap, WM_FLL_CONTROL_5,
+				 WM_FLL_CLK_REF_SRC, ref);
+	return err;
+}
+EXPORT_SYMBOL_GPL(wm_fll_set_parent);
+
+/**
+ * wm_fll_enable() - Enable FLL
+ *
+ * @hw: initialized FLL hardware info
+ *
+ * Requests source clock and starts the FLL.
+ * Waits for lock before returning.
+ *
+ * Return 0 if successful, error code if not.
+ */
+int wm_fll_enable(struct wm_fll_data *hw)
+{
+	unsigned int val;
+	int clk_src;
+	int err, retry;
+
+	err = clk_src = wm_fll_get_parent(hw);
+	if (err < 0)
+		return err;
+
+	if (clk_src == FLL_REF_MCLK) {
+		err = clk_prepare_enable(hw->mclk);
+		if (err < 0)
+			return err;
+	}
+
+	err = regmap_update_bits(hw->regmap, WM_FLL_CONTROL_1,
+				 WM_FLL_OSC_ENA, WM_FLL_OSC_ENA);
+	if (err < 0)
+		goto err_out;
+
+	err = regmap_write(hw->regmap, WM_INTERRUPT_STATUS,
+			   hw->desc->int_mask);
+	if (err < 0)
+		goto err_out;
+
+	err = regmap_update_bits(hw->regmap, WM_FLL_CONTROL_1,
+				 WM_FLL_ENA, WM_FLL_ENA);
+	if (err)
+		goto err_out;
+
+	if (clk_src == FLL_REF_OSC) {
+		usleep_range(150, 250);
+		return 0;
+	}
+
+	for (retry = 3; retry; --retry) {
+		msleep(1);
+		err = regmap_read(hw->regmap, WM_INTERRUPT_STATUS, &val);
+		if (err < 0)
+			goto err_out;
+
+		if (val & hw->desc->int_mask)
+			break;
+	}
+
+	/* it seems that FLL_LOCK might never be asserted */
+	/* eg. WM8904's FLL doesn't, but works anyway */
+	return 0;
+
+err_out:
+	wm_fll_disable(hw);
+
+	if (clk_src == FLL_REF_MCLK)
+		clk_disable_unprepare(hw->mclk);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(wm_fll_enable);
+
+/**
+ * wm_fll_disable() - Disable FLL
+ *
+ * @hw: initialized FLL hardware info
+ *
+ * Return 0 if successful, error code if not.
+ */
+int wm_fll_disable(struct wm_fll_data *hw)
+{
+	return regmap_update_bits(hw->regmap, WM_FLL_CONTROL_1,
+				  WM_FLL_ENA|WM_FLL_OSC_ENA,
+				  0);
+}
+EXPORT_SYMBOL_GPL(wm_fll_disable);
+
+/**
+ * wm_fll_is_enabled() - Check whether FLL is enabled
+ *
+ * @hw: initialized FLL hardware info
+ *
+ * Returns 0 if disabled, 1 if enabled, or negative error code.
+ */
+int wm_fll_is_enabled(struct wm_fll_data *hw)
+{
+	unsigned int val;
+	int err;
+
+	err = regmap_read(hw->regmap, WM_FLL_CONTROL_1, &val);
+	if (err < 0)
+		return err;
+
+	return FIELD_GET(WM_FLL_ENA, val);
+}
+EXPORT_SYMBOL_GPL(wm_fll_is_enabled);
+
+static unsigned int wm_fll_apply_refdiv(unsigned long *parent_rate)
+{
+	unsigned int refdiv;
+
+	/* FLL input divider; should ensure Fin <= 13.5MHz */
+
+	refdiv = DIV_ROUND_UP(*parent_rate, 13500000);
+	refdiv = order_base_2(refdiv);
+	if (refdiv > 3)
+		refdiv = 3;
+
+	*parent_rate >>= refdiv;
+
+	return refdiv;
+}
+
+static unsigned int wm_fll_apply_fratio(unsigned long *parent_rate)
+{
+	unsigned int fratio;
+
+	/* FLL comparator divider; efectively Fin multiplier */
+	/* as tabularized in WM datasheet */
+
+	if (*parent_rate >= 256000)
+		fratio = *parent_rate < 1024000;
+	else if (*parent_rate >= 64000)
+		fratio = 2 + (*parent_rate < 128000);
+	else
+		fratio = 4;
+
+	*parent_rate <<= fratio;
+
+	return fratio;
+}
+
+static unsigned int wm_fll_apply_outdiv_rev(unsigned long *rate)
+{
+	unsigned int div;
+
+	/* Fvco -> Fout divider; target: 90 <= Fvco <= 100 MHz */
+
+	div = DIV_ROUND_UP(90000000, *rate);
+	if (div > 64) {
+		*rate = 90000000;
+		return 64;
+	}
+
+	if (div < 4)
+		div = 4;
+
+	*rate *= div;
+	return div;
+}
+
+static unsigned long wm_fll_apply_frac(struct wm_fll_data *hw,
+	unsigned long rate_in, unsigned long *rate_out,
+	unsigned int *kdiv_out)
+{
+	unsigned long long freq;
+	unsigned long rate = *rate_out;
+	unsigned int kdiv = 0x10000;
+
+	if (WM_FLL_USES_EFS(hw)) {
+		unsigned int cd, num;
+
+		cd = gcd(rate, rate_in);
+		freq = rate / rate_in;
+		num = rate - freq * rate_in;
+		num /= cd;
+		kdiv = rate_in / cd;
+
+		rate = freq * rate_in + num * rate_in / kdiv;
+		freq = (freq << 16) | num;
+	} else {
+		freq = (unsigned long long)rate << 16;
+		freq += rate_in / 2;
+		do_div(freq, rate_in);
+
+		rate = (freq * rate_in) >> 16;
+	}
+
+	*rate_out = rate;
+	*kdiv_out = kdiv;
+	return freq;
+}
+
+/**
+ * wm_fll_set_rate() - Configures FLL for specified bitrate
+ *
+ * @hw: initialized FLL hardware info
+ * @rate: bitrate to configure for
+ *
+ * Return 0 if successful, error code if not. FLL must be disabled
+ * on entry.
+ */
+int wm_fll_set_rate(struct wm_fll_data *hw, unsigned long rate)
+{
+	unsigned long freq, mclk_rate;
+	unsigned int val, mask, refdiv, outdiv, fratio, kdiv;
+	int err;
+
+	err = wm_fll_is_enabled(hw);
+	if (err < 0)
+		return err;
+	if (err > 0)
+		return -EBUSY;
+
+	err = wm_fll_get_parent(hw);
+	if (err < 0)
+		return err;
+
+	if (err != FLL_REF_OSC) {
+		unsigned long parent_rate;
+
+		if (hw->mclk)
+			hw->freq_in = clk_get_rate(hw->mclk);
+
+		parent_rate = mclk_rate = hw->freq_in;
+		refdiv = wm_fll_apply_refdiv(&parent_rate);
+		fratio = wm_fll_apply_fratio(&parent_rate);
+		outdiv = wm_fll_apply_outdiv_rev(&rate);
+		freq = wm_fll_apply_frac(hw, parent_rate, &rate, &kdiv);
+	} else {
+		unsigned long vco_rate = 96000000;
+
+		mclk_rate = 0;
+		fratio = refdiv = 0;
+		rate = DIV_ROUND_CLOSEST(vco_rate, rate);
+		outdiv = clamp_t(unsigned long, rate, 4, 64);
+		freq = 0x177 << 16;
+		kdiv = 0;
+
+		rate = vco_rate;
+	}
+
+	/* configure */
+
+	dev_dbg(regmap_get_device(hw->regmap),
+		"configuring FLL for %luHz -> %luHz -> %luHz\n",
+		mclk_rate, rate, rate / outdiv);
+	dev_dbg(regmap_get_device(hw->regmap),
+		"FLL settings: N=%lu K=%lu/%u FRATIO=%u OUTDIV=%u REF_DIV=%u\n",
+		freq >> 16, freq & 0xFFFF, kdiv, fratio, outdiv, refdiv);
+
+	val = FIELD_PREP(WM_FLL_CLK_REF_DIV, refdiv);
+	err = regmap_update_bits(hw->regmap, WM_FLL_CONTROL_5,
+				 WM_FLL_CLK_REF_DIV, val);
+	if (err < 0)
+		return err;
+
+	val = FIELD_PREP(WM_FLL_OUTDIV, outdiv - 1) |
+	      FIELD_PREP(WM_FLL_FRATIO, fratio);
+	mask = WM_FLL_OUTDIV | WM_FLL_FRATIO;
+	err = regmap_update_bits(hw->regmap, WM_FLL_CONTROL_2, mask, val);
+	if (err < 0)
+		return err;
+
+	err = regmap_write(hw->regmap, WM_FLL_CONTROL_3, (uint16_t)freq);
+	if (err < 0)
+		return err;
+
+	if (WM_FLL_USES_EFS(hw)) {
+		val = FIELD_PREP(WM_FLL_EFS_ENA, !!(uint16_t)freq);
+		err = regmap_update_bits(hw->regmap, WM_FLL_EFS_2,
+					 WM_FLL_EFS_ENA, val);
+		if (err < 0)
+			return err;
+
+		val = FIELD_PREP(WM_FLL_LAMBDA, kdiv);
+		err = regmap_update_bits(hw->regmap, WM_FLL_EFS_1,
+					 WM_FLL_LAMBDA, val);
+	} else {
+		val = FIELD_PREP(WM_FLL_FRACN_ENA, !!(uint16_t)freq);
+		err = regmap_update_bits(hw->regmap, WM_FLL_CONTROL_1,
+					 WM_FLL_FRACN_ENA, val);
+	}
+	if (err < 0)
+		return err;
+
+	val = FIELD_PREP(WM_FLL_N, freq >> 16);
+	err = regmap_update_bits(hw->regmap, WM_FLL_CONTROL_4,
+				 WM_FLL_N, val);
+	return err;
+}
+EXPORT_SYMBOL_GPL(wm_fll_set_rate);
+
+/**
+ * wm_fll_init() - Initialize FLL
+ *
+ * @hw: FLL hardware info
+ *
+ * Checks and initializes FLL structure.
+ * Requires hw->desc and hw->regmap to be filled in by caller.
+ *
+ * Return 0 if successful, negative error code if not.
+ * A message is logged on error.
+ */
+int wm_fll_init(struct wm_fll_data *hw)
+{
+	if (!IS_ENABLED(CONFIG_SND_SOC_WM_FLL_EFS) && hw->desc->efs_offset) {
+		struct device *dev = regmap_get_device(hw->regmap);
+
+		dev_err(dev, "FLL EFS support not compiled in\n");
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_fll_init);
+
+/**
+ * wm_fll_init_with_clk() - Initialize FLL
+ *
+ * @hw: FLL hardware info
+ *
+ * Checks and initializes FLL described in @hw, and requests MCLK input clock.
+ * Requires hw->desc and hw->regmap to be filled in by caller.
+ *
+ * Return 0 if successful, negative error code if not.
+ * A message is logged on error.
+ */
+int wm_fll_init_with_clk(struct wm_fll_data *hw)
+{
+	struct device *dev = regmap_get_device(hw->regmap);
+	int err;
+
+	err = wm_fll_init(hw);
+	if (err)
+		return err;
+
+	hw->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(hw->mclk)) {
+		err = PTR_ERR(hw->mclk);
+		dev_err(dev, "Failed to get MCLK for FLL @0x%x: %d\n",
+			hw->desc->ctl_offset, err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_fll_init_with_clk);
diff --git a/sound/soc/codecs/wm_fll.h b/sound/soc/codecs/wm_fll.h
new file mode 100644
index 000000000000..8519a8691397
--- /dev/null
+++ b/sound/soc/codecs/wm_fll.h
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * wm_fll.h  --  FLL support for Wolfson codecs
+ *
+ * Copyright 2019 Michał Mirosław
+ */
+
+#ifndef _WM_FLL_H
+#define _WM_FLL_H
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+enum wm_fll_ref_source
+{
+	FLL_REF_MCLK = 1,
+	FLL_REF_MCLK2,
+	FLL_REF_BCLK,
+	FLL_REF_FSCLK,
+	FLL_REF_OSC,
+};
+
+/**
+ * struct wm_fll_desc - FLL variant description
+ *
+ * @offset: FLL control register block offset
+ * @clk_ref_map: FLL_REF_* assignment for each of FLL.REF_SRC field value
+ */
+struct wm_fll_desc
+{
+	uint16_t	 ctl_offset;
+	uint16_t	 int_offset;
+	uint16_t	 int_mask;
+	uint16_t	 nco_reg0;
+	uint16_t	 nco_reg1;
+	uint8_t		 frc_nco_shift;
+	uint8_t		 frc_nco_val_shift;
+	uint16_t	 efs_offset;
+	uint8_t		 clk_ref_map[4];
+};
+
+struct wm_fll_data
+{
+	const struct wm_fll_desc	*desc;
+	struct regmap			*regmap;
+	unsigned long			 freq_in;
+
+	struct clk			*mclk;
+};
+
+int wm_fll_init(struct wm_fll_data *hw);
+int wm_fll_init_with_clk(struct wm_fll_data *hw);
+int wm_fll_is_enabled(struct wm_fll_data *hw);
+int wm_fll_enable(struct wm_fll_data *hw);
+int wm_fll_disable(struct wm_fll_data *hw);
+int wm_fll_set_parent(struct wm_fll_data *hw, enum wm_fll_ref_source index);
+int wm_fll_set_rate(struct wm_fll_data *hw, unsigned long rate);
+
+#endif /* _WM_FLL_H */
-- 
2.20.1

