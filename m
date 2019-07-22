Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DCC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409712147A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfGVHYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:24:33 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:52984 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfGVHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:24:32 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hpSg5-0002HT-0Y from Jiada_Wang@mentor.com ; Mon, 22 Jul 2019 00:24:09 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 22 Jul 2019 00:24:05 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <twischer@de.adit-jv.com>, <jiada_wang@mentor.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] ASoC: rsnd: Allow reconfiguration of clock rate
Date:   Mon, 22 Jul 2019 16:24:02 +0900
Message-ID: <20190722072403.11008-3-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190722072403.11008-1-jiada_wang@mentor.com>
References: <20190722072403.11008-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

Currently after clock rate is started in .prepare reconfiguration
of clock rate is not allowed, unless the stream is stopped.

But there is use case in Gstreamer ALSA sink, in case of changed caps
Gsreatmer reconfigs and it calls snd_pcm_hw_free() before snd_pcm_prepre().
See gstreamer1.0-plugins-base/
gst-libs/gst/audio/gstaudiobasesink.c: gst_audio_base_sink_setcaps():
- gst_audio_ring_buffer_release()
- gst_audio_sink_ring_buffer_release()
- gst_alsasink_unprepare()
- snd_pcm_hw_free()
is called before
- gst_audio_ring_buffer_acquire()
- gst_audio_sink_ring_buffer_acquire()
- gst_alsasink_prepare()
- set_hwparams()
- snd_pcm_hw_params()
- snd_pcm_prepare()

The issue mentioned in this commit can be reproduced with the following
aplay patch:

    >diff --git a/aplay/aplay.c b/aplay/aplay.c
    >@@ -2760,6 +2760,8 @@ static void playback_go(int fd, size_t loaded,
    >      header(rtype, name);
    >      set_params();
    >+     hwparams.rate = (hwparams.rate == 48000) ? 44100 : 48000;
    >+     set_params();
    >
    >      while (loaded > chunk_bytes && written < count && !in_aborting)
    >      {
    >              if (pcm_write(audiobuf + written, chunk_size) <= 0)

$ aplay -Dplughw:0,0,0 -c8 -fS24_LE -r48000 /dev/zero
rcar_sound ec500000.sound: SSI parent/child should use same rate
rcar_sound ec500000.sound: ssi[3] : prepare error -22
rcar_sound ec500000.sound: ASoC: cpu DAI prepare error: -22
rsnd_link0: ASoC: prepare FE rsnd_link0 failed

this patch address the issue by stop clock in .hw_free,
to allow reconfiguration of clock rate without stop of the stream.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssi.c | 53 +++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f6a7466622ea..f43937d2c588 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -286,7 +286,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
-	if (ssi->usrcnt > 0) {
+	if (ssi->rate) {
 		if (ssi->rate != rate) {
 			dev_err(dev, "SSI parent/child should use same rate\n");
 			return -EINVAL;
@@ -471,13 +471,9 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-
 	if (!rsnd_ssi_is_run_mods(mod, io))
 		return 0;
 
-	ssi->usrcnt++;
-
 	rsnd_mod_power_on(mod);
 
 	rsnd_ssi_config_init(mod, io);
@@ -505,18 +501,8 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 		return -EIO;
 	}
 
-	rsnd_ssi_master_clk_stop(mod, io);
-
 	rsnd_mod_power_off(mod);
 
-	ssi->usrcnt--;
-
-	if (!ssi->usrcnt) {
-		ssi->cr_own	= 0;
-		ssi->cr_mode	= 0;
-		ssi->wsr	= 0;
-	}
-
 	return 0;
 }
 
@@ -525,6 +511,7 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
 			      struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 	unsigned int fmt_width = snd_pcm_format_width(params_format(params));
 
@@ -536,6 +523,11 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
 		return -EINVAL;
 	}
 
+	if (!rsnd_ssi_is_run_mods(mod, io))
+		return 0;
+
+	ssi->usrcnt++;
+
 	return 0;
 }
 
@@ -913,6 +905,35 @@ static int rsnd_ssi_prepare(struct rsnd_mod *mod,
 	return rsnd_ssi_master_clk_start(mod, io);
 }
 
+static int rsnd_ssi_hw_free(struct rsnd_mod *mod, struct rsnd_dai_stream *io,
+			    struct snd_pcm_substream *substream)
+{
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+
+	if (!rsnd_ssi_is_run_mods(mod, io))
+		return 0;
+
+	if (!ssi->usrcnt) {
+		struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+		struct device *dev = rsnd_priv_to_dev(priv);
+
+		dev_err(dev, "%s usrcnt error\n", rsnd_mod_name(mod));
+		return -EIO;
+	}
+
+	rsnd_ssi_master_clk_stop(mod, io);
+
+	ssi->usrcnt--;
+
+	if (!ssi->usrcnt) {
+		ssi->cr_own	= 0;
+		ssi->cr_mode	= 0;
+		ssi->wsr	= 0;
+	}
+
+	return 0;
+}
+
 static struct rsnd_mod_ops rsnd_ssi_pio_ops = {
 	.name		= SSI_NAME,
 	.probe		= rsnd_ssi_common_probe,
@@ -926,6 +947,7 @@ static struct rsnd_mod_ops rsnd_ssi_pio_ops = {
 	.pcm_new	= rsnd_ssi_pcm_new,
 	.hw_params	= rsnd_ssi_hw_params,
 	.prepare	= rsnd_ssi_prepare,
+	.hw_free	= rsnd_ssi_hw_free,
 	.get_status	= rsnd_ssi_get_status,
 };
 
@@ -1012,6 +1034,7 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
 	.pcm_new	= rsnd_ssi_pcm_new,
 	.fallback	= rsnd_ssi_fallback,
 	.hw_params	= rsnd_ssi_hw_params,
+	.hw_free	= rsnd_ssi_hw_free,
 	.prepare	= rsnd_ssi_prepare,
 	.get_status	= rsnd_ssi_get_status,
 };
-- 
2.19.2

