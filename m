Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A0CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A83217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572353841;
	bh=5kuzo0+a2XqeYDtx+LBipdb5kLIv4T7LKCfgfqyk7nc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Yv7ggeSGHSBi+CGuW0DB+G+TkqctkMoxgMOzpu0RO+5LVOkS4MjVrOXpPAfxhp5SM
	 M4pwsCZkSyubIjQsBuAWWQUZT6At+WOw3YVt3JlSfRtdYPGdoshbu2P0/jQEyWOecJ
	 65OmVaWwAjyi0y8IVtWJekX8Ysds3kJZKNhCypd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfJ2M5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:57:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJ2M5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gocwTVPyr9YGkRj8qgx6LZT7QM+fVAHw/mMPk9/2Rwc=; b=Y96UaNxA2UCU
        9sO6W8Ov9V4FnBx+/WSu3KJDQQRGOfbGW7nOkiL0MFX35wrDiR+W0JMclAu6Sp6IkUP2WIF2v5Ldu
        fULf5zb3/tfdR3y9YRGwvmNOovJG/vx9KTD5axFXjzOsN+XjkcxhURE+RfI4sBESxtzVtzT42Gi0F
        oOIM8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iPR3T-0002DH-QF; Tue, 29 Oct 2019 12:56:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1BD202742157; Tue, 29 Oct 2019 12:56:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     alsa-devel@alsa-project.org, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dgreid@chromium.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Takashi Iwai <tiwai@suse.com>, tzungbi@chromium.org
Subject: Applied "ASoC: rockchip_max98090: Add HDMI jack support" to the asoc tree
In-Reply-To: <20191028071930.145899-5-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20191029125659.1BD202742157@ypsilon.sirena.org.uk>
Date:   Tue, 29 Oct 2019 12:56:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip_max98090: Add HDMI jack support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From bf2f64ea6594066081b0d30b128fa4947e83e737 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Mon, 28 Oct 2019 15:19:28 +0800
Subject: [PATCH] ASoC: rockchip_max98090: Add HDMI jack support

In machine driver, create a jack and let hdmi-codec report jack status.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Link: https://lore.kernel.org/r/20191028071930.145899-5-cychiang@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/Kconfig             |  3 ++-
 sound/soc/rockchip/rockchip_max98090.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index b43657e6e655..d610b553ea3b 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -40,9 +40,10 @@ config SND_SOC_ROCKCHIP_MAX98090
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
+	select SND_SOC_HDMI_CODEC
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
-	  boards using the MAX98090 codec, such as Veyron.
+	  boards using the MAX98090 codec and HDMI codec, such as Veyron.
 
 config SND_SOC_ROCKCHIP_RT5645
 	tristate "ASoC support for Rockchip boards using a RT5645/RT5650 codec"
diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 50ef9b8e7ce4..5c2504a465f4 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -12,6 +12,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <sound/core.h>
+#include <sound/hdmi-codec.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -218,6 +219,25 @@ enum {
 	DAILINK_HDMI,
 };
 
+static struct snd_soc_jack rk_hdmi_jack;
+
+static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_component *component = runtime->codec_dai->component;
+	int ret;
+
+	/* enable jack detection */
+	ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &rk_hdmi_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
+		return ret;
+	}
+
+	return hdmi_codec_set_jack_detect(component, &rk_hdmi_jack);
+}
+
 /* max98090 dai_link */
 static struct snd_soc_dai_link rk_max98090_dailinks[] = {
 	{
@@ -237,6 +257,7 @@ static struct snd_soc_dai_link rk_hdmi_dailinks[] = {
 	{
 		.name = "HDMI",
 		.stream_name = "HDMI",
+		.init = rk_hdmi_init,
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
@@ -259,6 +280,7 @@ static struct snd_soc_dai_link rk_max98090_hdmi_dailinks[] = {
 	[DAILINK_HDMI] = {
 		.name = "HDMI",
 		.stream_name = "HDMI",
+		.init = rk_hdmi_init,
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
-- 
2.20.1

