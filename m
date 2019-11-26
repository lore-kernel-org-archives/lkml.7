Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35079C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C302071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 07:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IDpsxu5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKZHyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 02:54:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34757 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKZHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 02:54:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so8765766pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 23:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYZPHR0XrSUhALfClmZ9OBm8nT/qbgSchvFq1xCdm+s=;
        b=IDpsxu5vGx4jOJfXXC16eWB2IIc2WC2nO4G1IsmUgGSuecBLKNb9rzwJLACtBkLdRa
         F3/fWHWDfzjQBOPW9scgJ28T2pjC5zRQGrzPqEQ4mlKmzN68ANQs1UW61qDqHO6CiN54
         58/cS+NWnR2vnapXyZbdvA9iZGOPp7vs2lBoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYZPHR0XrSUhALfClmZ9OBm8nT/qbgSchvFq1xCdm+s=;
        b=QPdlPcGfs+jVfgQDyqpWO1iqk/CTvDg9xf3Dhy3mnJLjgCByXDPh8HOYiHnNJUQGeI
         snU6ecF5HlrG92kpu3PXRZWwefeYv4g002S46gnSMBEFSFMIIyKh34RjctQpT4+SW5ov
         asiFi9n6kCIcTp67VmeIBjVhJmrXSN3iXEqBx7hsIJuHj/9/hcbpqVEpCvlI/M6RR6WS
         kXVGJRjY0g4z0DbvPjYJKBFyRK/W7UyierJZKWUWEz8weH1DpnfGBHTIC/h7RcTt6eaH
         2ObXH48nnGxHDkCqMH7g3zwqcvGnMM/xZ7ylwn7IOeFqBAnO1U8zYX9dzfVYiVeQRW0v
         RQow==
X-Gm-Message-State: APjAAAVjGO6kQtKr92PKb8y2TrhZhJLgRCpqZbuJHIz4ev/B+XAsTkJY
        OPK5Je7F5i9e9yGsqvWVufR5JeevICs=
X-Google-Smtp-Source: APXvYqzg7jEx4NjEC6bym4272COb52LPGhJXuKp86gB3AyuTw96/R/XRdfPf+Zyhj/X+X1RODQ4Ywg==
X-Received: by 2002:a65:4c48:: with SMTP id l8mr36429991pgr.195.1574754870389;
        Mon, 25 Nov 2019 23:54:30 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id w26sm11539748pfj.123.2019.11.25.23.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 23:54:29 -0800 (PST)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Agrawal Akshu <Akshu.Agrawal@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: AMD: Enable clk in startup intead of hw_params
Date:   Tue, 26 Nov 2019 15:54:24 +0800
Message-Id: <20191126075424.80668-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some usages only call startup and shutdown without setting hw_params
(e.g. arecord --dump-hw-params). If we don't enable clk in startup, it
will cause ref count error because the clk will be disabled in shutdown.
For this reason, we should move enabling clk from hw_params to startup.

In addition, the hw_params is fixed in this driver(48000 rate, 2
channels, S16_LE format) so we don't need to change the clk rate after
the hw_params is set.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 46 +++++++++-------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index f4ee6798154af5..7a5621e5e2330d 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -96,14 +96,19 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int da7219_clk_enable(struct snd_pcm_substream *substream,
-			     int wclk_rate, int bclk_rate)
+static int da7219_clk_enable(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
-	clk_set_rate(da7219_dai_wclk, wclk_rate);
-	clk_set_rate(da7219_dai_bclk, bclk_rate);
+	/*
+	 * Set wclk to 48000 because the rate constraint of this driver is
+	 * 48000. ADAU7002 spec: "The ADAU7002 requires a BCLK rate that is
+	 * minimum of 64x the LRCLK sample rate." DA7219 is the only clk
+	 * source so for all codecs we have to limit bclk to 64X lrclk.
+	 */
+	clk_set_rate(da7219_dai_wclk, 48000);
+	clk_set_rate(da7219_dai_bclk, 48000 * 64);
 	ret = clk_prepare_enable(da7219_dai_bclk);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't enable master clock %d\n", ret);
@@ -156,7 +161,7 @@ static int cz_da7219_play_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->play_i2s_instance = I2S_SP_INSTANCE;
-	return 0;
+	return da7219_clk_enable(substream);
 }
 
 static int cz_da7219_cap_startup(struct snd_pcm_substream *substream)
@@ -178,7 +183,7 @@ static int cz_da7219_cap_startup(struct snd_pcm_substream *substream)
 
 	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL1;
-	return 0;
+	return da7219_clk_enable(substream);
 }
 
 static int cz_max_startup(struct snd_pcm_substream *substream)
@@ -199,7 +204,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->play_i2s_instance = I2S_BT_INSTANCE;
-	return 0;
+	return da7219_clk_enable(substream);
 }
 
 static int cz_dmic0_startup(struct snd_pcm_substream *substream)
@@ -220,7 +225,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->cap_i2s_instance = I2S_BT_INSTANCE;
-	return 0;
+	return da7219_clk_enable(substream);
 }
 
 static int cz_dmic1_startup(struct snd_pcm_substream *substream)
@@ -242,25 +247,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 
 	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL0;
-	return 0;
-}
-
-static int cz_da7219_params(struct snd_pcm_substream *substream,
-				      struct snd_pcm_hw_params *params)
-{
-	int wclk, bclk;
-
-	wclk = params_rate(params);
-	bclk = wclk * params_channels(params) *
-		snd_pcm_format_width(params_format(params));
-	/* ADAU7002 spec: "The ADAU7002 requires a BCLK rate
-	 * that is minimum of 64x the LRCLK sample rate."
-	 * DA7219 is the only clk source so for all codecs
-	 * we have to limit bclk to 64X lrclk.
-	 */
-	if (bclk < (wclk * 64))
-		bclk = wclk * 64;
-	return da7219_clk_enable(substream, wclk, bclk);
+	return da7219_clk_enable(substream);
 }
 
 static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
@@ -271,31 +258,26 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 static const struct snd_soc_ops cz_da7219_play_ops = {
 	.startup = cz_da7219_play_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 static const struct snd_soc_ops cz_da7219_cap_ops = {
 	.startup = cz_da7219_cap_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 static const struct snd_soc_ops cz_max_play_ops = {
 	.startup = cz_max_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 static const struct snd_soc_ops cz_dmic0_cap_ops = {
 	.startup = cz_dmic0_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 static const struct snd_soc_ops cz_dmic1_cap_ops = {
 	.startup = cz_dmic1_startup,
 	.shutdown = cz_da7219_shutdown,
-	.hw_params = cz_da7219_params,
 };
 
 SND_SOC_DAILINK_DEF(designware1,
-- 
2.24.0.432.g9d3f5f5b63-goog

