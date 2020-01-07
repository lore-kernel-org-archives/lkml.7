Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D142C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 04:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3B0207FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 04:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Mgcr1Jwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgAGEPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:15:15 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11395 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgAGEOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 23:14:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14057a0000>; Mon, 06 Jan 2020 20:13:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Jan 2020 20:14:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Jan 2020 20:14:34 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 04:14:33 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 7 Jan 2020 04:14:33 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.88]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1405a90000>; Mon, 06 Jan 2020 20:14:33 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 12/19] ASoC: tegra: Add audio mclk configuration
Date:   Mon, 6 Jan 2020 20:14:11 -0800
Message-ID: <1578370458-3686-13-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578370458-3686-1-git-send-email-skomatineni@nvidia.com>
References: <1578370458-3686-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578370427; bh=UUx3YS8Ai9//FBcYDn5ZNXy0bzVG/B3iP6VBxkFTyaE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Mgcr1JwyzYBkKrtwLhPShqsqgRKCZHnbtsxonT2bsjYoKquo1lYBg/7S3te3evqJe
         sDNLTIoXJHGuB4/8x4LFkt522qk+mK1KaKLTtzFe70t8+2nlX2Y3nynw+FBpy3paiL
         IAz4kb1ax+LH/gNXDS4g5qGd9Tnma51QhC9IU5wzYpwP2a5b7jEdhngMGlx207a4rr
         rKlnhBQbeXhmAnE9juEsyHu4fzr1fO6sKTp6r0uJueM2XBHFzDZNQDTHV9cDYB2BVg
         4bsyhJrTjH/hRaDGyYaJY4dU+taYNIxyaEz8FYIoN0P/ZH4sbCnhFpCvYg59AKdvlY
         67UzUXhIjWx1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
through Tegra210 and currently Tegra clock driver does the initial parent
configuration for audio mclk and keeps it enabled by default.

With the move of PMC clocks from clock driver into pmc driver,
audio clocks parent configuration can be specified through the device tree
using assigned-clock-parents property and audio mclk control should be
taken care by the audio driver.

This patch has implementation for parent configuration when default parent
configuration is not specified in the device tree and controls audio mclk
enable and disable during machine startup and shutdown.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 sound/soc/tegra/tegra_alc5632.c    | 21 ++++++++++
 sound/soc/tegra/tegra_asoc_utils.c | 84 ++++++++++++++++++++++++--------------
 sound/soc/tegra/tegra_asoc_utils.h |  2 +
 sound/soc/tegra/tegra_max98090.c   | 21 ++++++++++
 sound/soc/tegra/tegra_rt5640.c     | 21 ++++++++++
 sound/soc/tegra/tegra_rt5677.c     | 21 ++++++++++
 sound/soc/tegra/tegra_sgtl5000.c   | 21 ++++++++++
 sound/soc/tegra/tegra_wm8753.c     | 21 ++++++++++
 sound/soc/tegra/tegra_wm8903.c     | 21 ++++++++++
 sound/soc/tegra/trimslice.c        | 21 ++++++++++
 10 files changed, 224 insertions(+), 30 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 50a6d2ff4442..0fd10023f7a6 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -62,8 +62,29 @@ static int tegra_alc5632_asoc_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int tegra_alc5632_asoc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = tegra_asoc_utils_clk_enable(&machine->util_data);
+
+	return ret;
+}
+
+static void tegra_alc5632_asoc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(rtd->card);
+
+	tegra_asoc_utils_clk_disable(&machine->util_data);
+}
+
 static const struct snd_soc_ops tegra_alc5632_asoc_ops = {
+	.startup = tegra_alc5632_asoc_startup,
 	.hw_params = tegra_alc5632_asoc_hw_params,
+	.shutdown = tegra_alc5632_asoc_shutdown,
 };
 
 static struct snd_soc_jack tegra_alc5632_hs_jack;
diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index 0d2271952555..2886ae9f5a16 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -60,8 +60,6 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 	data->set_mclk = 0;
 
 	clk_disable_unprepare(data->clk_cdev1);
-	clk_disable_unprepare(data->clk_pll_a_out0);
-	clk_disable_unprepare(data->clk_pll_a);
 
 	err = clk_set_rate(data->clk_pll_a, new_baseclock);
 	if (err) {
@@ -77,18 +75,6 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 
 	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
 
-	err = clk_prepare_enable(data->clk_pll_a);
-	if (err) {
-		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
-		return err;
-	}
-
-	err = clk_prepare_enable(data->clk_pll_a_out0);
-	if (err) {
-		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
-		return err;
-	}
-
 	err = clk_prepare_enable(data->clk_cdev1);
 	if (err) {
 		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
@@ -109,8 +95,6 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
 	int err;
 
 	clk_disable_unprepare(data->clk_cdev1);
-	clk_disable_unprepare(data->clk_pll_a_out0);
-	clk_disable_unprepare(data->clk_pll_a);
 
 	/*
 	 * AC97 rate is fixed at 24.576MHz and is used for both the host
@@ -130,17 +114,27 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
 
 	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
 
-	err = clk_prepare_enable(data->clk_pll_a);
+	err = clk_prepare_enable(data->clk_cdev1);
 	if (err) {
-		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
+		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
 		return err;
 	}
 
-	err = clk_prepare_enable(data->clk_pll_a_out0);
-	if (err) {
-		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
-		return err;
-	}
+	data->set_baseclock = pll_rate;
+	data->set_mclk = ac97_rate;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
+
+void tegra_asoc_utils_clk_disable(struct tegra_asoc_utils_data *data)
+{
+	clk_disable_unprepare(data->clk_cdev1);
+}
+
+int tegra_asoc_utils_clk_enable(struct tegra_asoc_utils_data *data)
+{
+	int err;
 
 	err = clk_prepare_enable(data->clk_cdev1);
 	if (err) {
@@ -148,16 +142,13 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
 		return err;
 	}
 
-	data->set_baseclock = pll_rate;
-	data->set_mclk = ac97_rate;
-
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
 
 int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 			  struct device *dev)
 {
+	struct clk *clk_out_1, *clk_extern1;
 	int ret;
 
 	data->dev = dev;
@@ -193,9 +184,42 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 		return PTR_ERR(data->clk_cdev1);
 	}
 
-	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
-	if (ret)
-		return ret;
+	/*
+	 * If clock parents are not set in DT, configure here to use clk_out_1
+	 * as mclk and extern1 as parent for Tegra30 and higher.
+	 */
+	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &&
+	    data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
+		dev_err(data->dev,
+			"Configuring clocks for a legacy device-tree\n");
+		clk_extern1 = devm_clk_get(dev, "extern1");
+		if (IS_ERR(clk_extern1)) {
+			dev_err(data->dev, "Can't retrieve clk extern1\n");
+			return PTR_ERR(clk_extern1);
+		}
+
+		ret = clk_set_parent(clk_extern1, data->clk_pll_a_out0);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"Set parent failed for clk extern1\n");
+			return ret;
+		}
+
+		clk_out_1 = devm_clk_get(dev, "clk_out_1");
+		if (IS_ERR(clk_out_1)) {
+			dev_err(data->dev, "Can't retrieve clk clk_out_1\n");
+			return PTR_ERR(clk_out_1);
+		}
+
+		ret = clk_set_parent(clk_out_1, clk_extern1);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"Set parent failed for clk_out_1\n");
+			return ret;
+		}
+
+		data->clk_cdev1 = clk_out_1;
+	}
 
 	return 0;
 }
diff --git a/sound/soc/tegra/tegra_asoc_utils.h b/sound/soc/tegra/tegra_asoc_utils.h
index a34439587d59..6db93009a317 100644
--- a/sound/soc/tegra/tegra_asoc_utils.h
+++ b/sound/soc/tegra/tegra_asoc_utils.h
@@ -34,5 +34,7 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data);
 int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 			  struct device *dev);
+int tegra_asoc_utils_clk_enable(struct tegra_asoc_utils_data *data);
+void tegra_asoc_utils_clk_disable(struct tegra_asoc_utils_data *data);
 
 #endif
diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98090.c
index f554a3d4571f..98d1ff49074b 100644
--- a/sound/soc/tegra/tegra_max98090.c
+++ b/sound/soc/tegra/tegra_max98090.c
@@ -82,8 +82,29 @@ static int tegra_max98090_asoc_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int tegra_max98090_asoc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = tegra_asoc_utils_clk_enable(&machine->util_data);
+
+	return ret;
+}
+
+static void tegra_max98090_asoc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(rtd->card);
+
+	tegra_asoc_utils_clk_disable(&machine->util_data);
+}
+
 static const struct snd_soc_ops tegra_max98090_ops = {
+	.startup = tegra_max98090_asoc_startup,
 	.hw_params = tegra_max98090_asoc_hw_params,
+	.shutdown = tegra_max98090_asoc_shutdown,
 };
 
 static struct snd_soc_jack tegra_max98090_hp_jack;
diff --git a/sound/soc/tegra/tegra_rt5640.c b/sound/soc/tegra/tegra_rt5640.c
index 5c695dfea009..8705b1a32a14 100644
--- a/sound/soc/tegra/tegra_rt5640.c
+++ b/sound/soc/tegra/tegra_rt5640.c
@@ -65,8 +65,29 @@ static int tegra_rt5640_asoc_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int tegra_rt5640_asoc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = tegra_asoc_utils_clk_enable(&machine->util_data);
+
+	return ret;
+}
+
+static void tegra_rt5640_asoc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(rtd->card);
+
+	tegra_asoc_utils_clk_disable(&machine->util_data);
+}
+
 static const struct snd_soc_ops tegra_rt5640_ops = {
+	.startup = tegra_rt5640_asoc_startup,
 	.hw_params = tegra_rt5640_asoc_hw_params,
+	.shutdown = tegra_rt5640_asoc_shutdown,
 };
 
 static struct snd_soc_jack tegra_rt5640_hp_jack;
diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
index fb86f76728b3..a44b5ddc33ee 100644
--- a/sound/soc/tegra/tegra_rt5677.c
+++ b/sound/soc/tegra/tegra_rt5677.c
@@ -82,8 +82,29 @@ static int tegra_rt5677_event_hp(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int tegra_rt5677_asoc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = tegra_asoc_utils_clk_enable(&machine->util_data);
+
+	return ret;
+}
+
+static void tegra_rt5677_asoc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(rtd->card);
+
+	tegra_asoc_utils_clk_disable(&machine->util_data);
+}
+
 static const struct snd_soc_ops tegra_rt5677_ops = {
+	.startup = tegra_rt5677_asoc_startup,
 	.hw_params = tegra_rt5677_asoc_hw_params,
+	.shutdown = tegra_rt5677_asoc_shutdown,
 };
 
 static struct snd_soc_jack tegra_rt5677_hp_jack;
diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5000.c
index 586f56f435f4..f3317dd4a79f 100644
--- a/sound/soc/tegra/tegra_sgtl5000.c
+++ b/sound/soc/tegra/tegra_sgtl5000.c
@@ -71,8 +71,29 @@ static int tegra_sgtl5000_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int tegra_sgtl5000_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_sgtl5000 *machine = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = tegra_asoc_utils_clk_enable(&machine->util_data);
+
+	return ret;
+}
+
+static void tegra_sgtl5000_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_sgtl5000 *machine = snd_soc_card_get_drvdata(rtd->card);
+
+	tegra_asoc_utils_clk_disable(&machine->util_data);
+}
+
 static const struct snd_soc_ops tegra_sgtl5000_ops = {
+	.startup = tegra_sgtl5000_startup,
 	.hw_params = tegra_sgtl5000_hw_params,
+	.shutdown = tegra_sgtl5000_shutdown,
 };
 
 static const struct snd_soc_dapm_widget tegra_sgtl5000_dapm_widgets[] = {
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index f76cfdc963ed..f4a000ec7506 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -75,8 +75,29 @@ static int tegra_wm8753_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int tegra_wm8753_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_wm8753 *machine = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = tegra_asoc_utils_clk_enable(&machine->util_data);
+
+	return ret;
+}
+
+static void tegra_wm8753_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_wm8753 *machine = snd_soc_card_get_drvdata(rtd->card);
+
+	tegra_asoc_utils_clk_disable(&machine->util_data);
+}
+
 static const struct snd_soc_ops tegra_wm8753_ops = {
+	.startup = tegra_wm8753_startup,
 	.hw_params = tegra_wm8753_hw_params,
+	.shutdown = tegra_wm8753_shutdown,
 };
 
 static const struct snd_soc_dapm_widget tegra_wm8753_dapm_widgets[] = {
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index f5f78c3512cd..7b5cd1653821 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -82,8 +82,29 @@ static int tegra_wm8903_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int tegra_wm8903_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = tegra_asoc_utils_clk_enable(&machine->util_data);
+
+	return ret;
+}
+
+static void tegra_wm8903_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(rtd->card);
+
+	tegra_asoc_utils_clk_disable(&machine->util_data);
+}
+
 static const struct snd_soc_ops tegra_wm8903_ops = {
+	.startup = tegra_wm8903_startup,
 	.hw_params = tegra_wm8903_hw_params,
+	.shutdown = tegra_wm8903_shutdown,
 };
 
 static struct snd_soc_jack tegra_wm8903_hp_jack;
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index e51c67092c8f..4b703734904f 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -60,8 +60,29 @@ static int trimslice_asoc_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int trimslice_asoc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_trimslice *machine = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = tegra_asoc_utils_clk_enable(&machine->util_data);
+
+	return ret;
+}
+
+static void trimslice_asoc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tegra_trimslice *machine = snd_soc_card_get_drvdata(rtd->card);
+
+	tegra_asoc_utils_clk_disable(&machine->util_data);
+}
+
 static const struct snd_soc_ops trimslice_asoc_ops = {
+	.startup = trimslice_asoc_startup,
 	.hw_params = trimslice_asoc_hw_params,
+	.shutdown = trimslice_asoc_shutdown,
 };
 
 static const struct snd_soc_dapm_widget trimslice_dapm_widgets[] = {
-- 
2.7.4

