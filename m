Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB67C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87D421897
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="WPRi+wrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfHXU07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:26:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:64738 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfHXU05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:26:57 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46G8sB1SjrzMK;
        Sat, 24 Aug 2019 22:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566678318; bh=b1ek30lBM19VEowKiuxbPntDd/KyiOI+RsIayDlIPSE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=WPRi+wrljlChgomDgenPw6WjWkEF0QUrfddbn+HpD7+Pxi0P2uXrDhHSKF9RmF1E/
         10gIljWH0OQ6hlS1wNejS1saBAm9usZSC7dFBpHeuanU0Qil8UQlw3iYVj8dwqI3SD
         b+OS4I51FygKAjXBc//QSIpUZydf+JxjnWGDAPhJWaX9ZjFJQuCW56YvIbDAwFbVQ5
         TOrb6zyh1+/QUJOn9riWoIU3WCiSoJD0KGb/gXuzC57dxe3yqsV1UV69lfM7q9gtfj
         JpWq17xMvVdA7LAJZAiXtgcPH1JbT5IjI8twDNJNYbrsv1Wc44Xq//4x9cwA6ycW2m
         k6u8H2xSASNtA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Sat, 24 Aug 2019 22:26:53 +0200
Message-Id: <f5949b0326fdcdca072f3ed03f77de9e207631cd.1566677788.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/6] ASoC: atmel_ssc_dai: rework DAI format configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chas Williams <3chas3@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh-dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework DAI format calculation in preparation for adding more formats
later. As a side-effect this enables all CBM/CBS x CFM/CFS combinations
for supported formats. (Note: the additional modes are not tested.)

Note: this changes FSEDGE to POSITIVE for I2S CBM_CFS mode as the TXSYN
interrupt is not used anyway.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
 v2: added note about extended modes' status
     incorporated common FS (LRCLK) configuration

---
 sound/soc/atmel/atmel_ssc_dai.c | 286 +++++++++-----------------------
 1 file changed, 80 insertions(+), 206 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 6f89483ac88c..7dc6ec9b8c7a 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -471,7 +471,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	int dir, channels, bits;
 	u32 tfmr, rfmr, tcmr, rcmr;
 	int ret;
-	int fslen, fslen_ext;
+	int fslen, fslen_ext, fs_osync, fs_edge;
 	u32 cmr_div;
 	u32 tcmr_period;
 	u32 rcmr_period;
@@ -558,226 +558,36 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	/*
 	 * Compute SSC register settings.
 	 */
-	switch (ssc_p->daifmt
-		& (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
 
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
-		/*
-		 * I2S format, SSC provides BCLK and LRC clocks.
-		 *
-		 * The SSC transmit and receive clocks are generated
-		 * from the MCK divider, and the BCLK signal
-		 * is output on the SSC TK line.
-		 */
-
-		if (bits > 16 && !ssc->pdata->has_fslen_ext) {
-			dev_err(dai->dev,
-				"sample size %d is too large for SSC device\n",
-				bits);
-			return -EINVAL;
-		}
-
-		fslen_ext = (bits - 1) / 16;
-		fslen = (bits - 1) % 16;
-
-		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
-			| SSC_BF(RCMR_STTDLY, START_DELAY)
-			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
-
-		rfmr =    SSC_BF(RFMR_FSLEN_EXT, fslen_ext)
-			| SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(RFMR_FSLEN, fslen)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
-
-		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
-			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
-			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
-
-		tfmr =    SSC_BF(TFMR_FSLEN_EXT, fslen_ext)
-			| SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(TFMR_FSLEN, fslen)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
-		break;
-
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
-		/* I2S format, CODEC supplies BCLK and LRC clocks. */
-		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
-			| SSC_BF(RCMR_STTDLY, START_DELAY)
-			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_PIN : SSC_CKS_CLOCK);
-
-		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_NONE)
-			| SSC_BF(RFMR_FSLEN, 0)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
-
-		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
-			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_CLOCK : SSC_CKS_PIN);
+	fslen_ext = (bits - 1) / 16;
+	fslen = (bits - 1) % 16;
 
-		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_NONE)
-			| SSC_BF(TFMR_FSLEN, 0)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
-		break;
-
-	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFS:
-		/* I2S format, CODEC supplies BCLK, SSC supplies LRCLK. */
-		if (bits > 16 && !ssc->pdata->has_fslen_ext) {
-			dev_err(dai->dev,
-				"sample size %d is too large for SSC device\n",
-				bits);
-			return -EINVAL;
-		}
-
-		fslen_ext = (bits - 1) / 16;
-		fslen = (bits - 1) % 16;
-
-		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
-			| SSC_BF(RCMR_STTDLY, START_DELAY)
-			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_PIN : SSC_CKS_CLOCK);
-
-		rfmr =    SSC_BF(RFMR_FSLEN_EXT, fslen_ext)
-			| SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(RFMR_FSLEN, fslen)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
-
-		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
-			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_CLOCK : SSC_CKS_PIN);
-
-		tfmr =    SSC_BF(TFMR_FSLEN_EXT, fslen_ext)
-			| SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_NEGATIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE)
-			| SSC_BF(TFMR_FSLEN, fslen)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
-		break;
-
-	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
-		/*
-		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
-		 *
-		 * The SSC transmit and receive clocks are generated from the
-		 * MCK divider, and the BCLK signal is output
-		 * on the SSC TK line.
-		 */
-		rcmr =	  SSC_BF(RCMR_PERIOD, rcmr_period)
-			| SSC_BF(RCMR_STTDLY, 1)
-			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
+	switch (ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 
-		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_POSITIVE)
-			| SSC_BF(RFMR_FSLEN, 0)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
+	case SND_SOC_DAIFMT_I2S:
+		fs_osync = SSC_FSOS_NEGATIVE;
+		fs_edge = SSC_START_FALLING_RF;
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, tcmr_period)
-			| SSC_BF(TCMR_STTDLY, 1)
-			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
-			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
+		rcmr =	  SSC_BF(RCMR_STTDLY, 1);
+		tcmr =	  SSC_BF(TCMR_STTDLY, 1);
 
-		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_POSITIVE)
-			| SSC_BF(TFMR_FSLEN, 0)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
 		break;
 
-	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_DSP_A:
 		/*
-		 * DSP/PCM Mode A format, CODEC supplies BCLK and LRC clocks.
+		 * DSP/PCM Mode A format
 		 *
 		 * Data is transferred on first BCLK after LRC pulse rising
 		 * edge.If stereo, the right channel data is contiguous with
 		 * the left channel data.
 		 */
-		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
-			| SSC_BF(RCMR_STTDLY, START_DELAY)
-			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
-			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_PIN : SSC_CKS_CLOCK);
+		fs_osync = SSC_FSOS_POSITIVE;
+		fs_edge = SSC_START_RISING_RF;
+		fslen = fslen_ext = 0;
 
-		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(RFMR_FSOS, SSC_FSOS_NONE)
-			| SSC_BF(RFMR_FSLEN, 0)
-			| SSC_BF(RFMR_DATNB, (channels - 1))
-			| SSC_BIT(RFMR_MSBF)
-			| SSC_BF(RFMR_LOOP, 0)
-			| SSC_BF(RFMR_DATLEN, (bits - 1));
+		rcmr =	  SSC_BF(RCMR_STTDLY, 1);
+		tcmr =	  SSC_BF(TCMR_STTDLY, 1);
 
-		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
-			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
-			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
-			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
-					   SSC_CKS_CLOCK : SSC_CKS_PIN);
-
-		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
-			| SSC_BF(TFMR_FSDEN, 0)
-			| SSC_BF(TFMR_FSOS, SSC_FSOS_NONE)
-			| SSC_BF(TFMR_FSLEN, 0)
-			| SSC_BF(TFMR_DATNB, (channels - 1))
-			| SSC_BIT(TFMR_MSBF)
-			| SSC_BF(TFMR_DATDEF, 0)
-			| SSC_BF(TFMR_DATLEN, (bits - 1));
 		break;
 
 	default:
@@ -785,6 +595,70 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 			ssc_p->daifmt);
 		return -EINVAL;
 	}
+
+	if (!atmel_ssc_cfs(ssc_p)) {
+		fslen = fslen_ext = 0;
+		rcmr_period = tcmr_period = 0;
+		fs_osync = SSC_FSOS_NONE;
+	}
+
+	rcmr |=	  SSC_BF(RCMR_START, fs_edge);
+	tcmr |=	  SSC_BF(TCMR_START, fs_edge);
+
+	if (atmel_ssc_cbs(ssc_p)) {
+		/*
+		 * SSC provides BCLK
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output
+		 * on the SSC TK line.
+		 */
+		rcmr |=	  SSC_BF(RCMR_CKS, SSC_CKS_DIV)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE);
+
+		tcmr |=	  SSC_BF(TCMR_CKS, SSC_CKS_DIV)
+			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS);
+	} else {
+		rcmr |=	  SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
+					SSC_CKS_PIN : SSC_CKS_CLOCK)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE);
+
+		tcmr |=	  SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
+					SSC_CKS_CLOCK : SSC_CKS_PIN)
+			| SSC_BF(TCMR_CKO, SSC_CKO_NONE);
+	}
+
+	rcmr |=	  SSC_BF(RCMR_PERIOD, rcmr_period)
+		| SSC_BF(RCMR_CKI, SSC_CKI_RISING);
+
+	tcmr |=   SSC_BF(TCMR_PERIOD, tcmr_period)
+		| SSC_BF(TCMR_CKI, SSC_CKI_FALLING);
+
+	rfmr =    SSC_BF(RFMR_FSLEN_EXT, fslen_ext)
+		| SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+		| SSC_BF(RFMR_FSOS, fs_osync)
+		| SSC_BF(RFMR_FSLEN, fslen)
+		| SSC_BF(RFMR_DATNB, (channels - 1))
+		| SSC_BIT(RFMR_MSBF)
+		| SSC_BF(RFMR_LOOP, 0)
+		| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+	tfmr =    SSC_BF(TFMR_FSLEN_EXT, fslen_ext)
+		| SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+		| SSC_BF(TFMR_FSDEN, 0)
+		| SSC_BF(TFMR_FSOS, fs_osync)
+		| SSC_BF(TFMR_FSLEN, fslen)
+		| SSC_BF(TFMR_DATNB, (channels - 1))
+		| SSC_BIT(TFMR_MSBF)
+		| SSC_BF(TFMR_DATDEF, 0)
+		| SSC_BF(TFMR_DATLEN, (bits - 1));
+
+	if (fslen_ext && !ssc->pdata->has_fslen_ext) {
+		dev_err(dai->dev, "sample size %d is too large for SSC device\n",
+			bits);
+		return -EINVAL;
+	}
+
 	pr_debug("atmel_ssc_hw_params: "
 			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
 			rcmr, rfmr, tcmr, tfmr);
-- 
2.20.1

