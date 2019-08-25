Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F5C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DC321744
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="AUtdOu+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfHYMRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:17:42 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:15893 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbfHYMRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:17:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46GYyB0Qd1zM6;
        Sun, 25 Aug 2019 14:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566735362; bh=Al1lbbPw+zZcMOPjHh4luaJeNVrX1Hy7lFV9zPv3gns=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=AUtdOu+12L8K334By+FEnF5Sz8vjG/7tlzwrridx/BYCNe1nDD8qbDIXTCIGlTHC4
         JJY9OdYg474V+1OT1P4kqrH9WlT1AmltPhjkpH3AXlibgJ8P8sgJGFwfVYbERr0p6z
         1H0w93OxlvbHTrC9Z2AhilyUgS4AJMiBFBd4YE88ir9xv/IOUdzaTsZMENESU379Vn
         UBLu9T3+5CY97OzHZxoBOvux0csC2S7TpFv56DfdeRKaOirB0qhBgsbUnZPXLeiDuT
         J25VmB+hOeat6/A0o8USeCMQ6+TjfUl0N3DIgaMPHTQVv/RkcnVLVlVzr1EycZ86bQ
         zK90APevAdooQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sun, 25 Aug 2019 14:17:37 +0200
Message-Id: <0b92f741a4c382cb8d50c1aebfa9da15d7e470ae.1566734631.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/4] ASoC: wm8904: automatically choose clock source
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        zhong jiang <zhongjiang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Nariman Poushin <npoushin@opensource.cirrus.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nikesh Oswal <nikesh@opensource.cirrus.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Piotr Stankiewicz <piotrs@opensource.cirrus.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Choose clock source automatically if not provided. This will be the case
with eg. audio-graph-card.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 sound/soc/codecs/wm8904.c | 42 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index c9318fe34f91..946315d4cecf 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -367,15 +367,34 @@ static int wm8904_enable_sysclk(struct wm8904_priv *priv)
 	return err;
 }
 
+static int wm8904_bump_fll_sysclk(unsigned int *rate);
+
 static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 			     unsigned int rate, int dir)
 {
 	struct snd_soc_component *component = dai->component;
 	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	unsigned int clock0, clock2;
-	int err;
+	int err, do_div = false;
 
 	switch (clk_id) {
+	case 0:
+		if (rate == clk_round_rate(wm8904->mclk, rate)) {
+			clk_id = WM8904_CLK_MCLK;
+		} else if (rate * 2 == clk_round_rate(wm8904->mclk, rate * 2)) {
+			rate *= 2;
+			clk_id = WM8904_CLK_MCLK;
+			do_div = true;
+		} else {
+			clk_id = WM8904_CLK_FLL;
+			err = wm8904_bump_fll_sysclk(&rate);
+			if (err) {
+				dev_dbg(component->dev, "Can't match %u over FLL 1406250 Hz minimum\n", rate);
+				return err;
+			}
+		}
+		break;
+
 	case WM8904_CLK_MCLK:
 	case WM8904_CLK_FLL:
 		break;
@@ -421,7 +440,9 @@ static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	}
 
 	/* SYSCLK shouldn't be over 13.5MHz */
-	if (rate > 13500000) {
+	if (rate > 13500000)
+		do_div = true;
+	if (do_div) {
 		clock0 = WM8904_MCLK_DIV;
 		wm8904->sysclk_rate = rate / 2;
 	} else {
@@ -1350,6 +1371,23 @@ static struct {
 	{ 480, 20 },
 };
 
+static int wm8904_bump_fll_sysclk(unsigned int *rate)
+{
+	int i;
+
+	/* bump SYSCLK rate if below minimal FLL output */
+
+	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
+		if (*rate * bclk_divs[i].div >= 1406250 * 10)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(bclk_divs))
+		return -ERANGE;
+
+	*rate = (*rate * bclk_divs[i].div) / 10;
+	return 0;
+}
 
 static int wm8904_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
-- 
2.20.1

