Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13AC76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905CE22389
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfGVHYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:24:09 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:52967 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfGVHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:24:09 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hpSg1-0002GW-GZ from Jiada_Wang@mentor.com ; Mon, 22 Jul 2019 00:24:05 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 22 Jul 2019 00:24:02 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <twischer@de.adit-jv.com>, <jiada_wang@mentor.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] ASoC: rsnd: Support hw_free() callback at DAI level
Date:   Mon, 22 Jul 2019 16:24:01 +0900
Message-ID: <20190722072403.11008-2-jiada_wang@mentor.com>
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

This patch provides the needed infrastructure to support calling hw_free()
at the DAI level. This is for example required to free resources allocated
in hw_params() callback.

The modification of __rsnd_mod_add_hw_params does not have any side
effects because rsnd_mod_ops::hw_params callback is not used by anyone
until now.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/core.c | 16 +++++++++++++++-
 sound/soc/sh/rcar/rsnd.h | 12 +++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 56e8dae9a15c..bda5b958d0dc 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1421,6 +1421,20 @@ static int rsnd_hw_params(struct snd_pcm_substream *substream,
 					params_buffer_bytes(hw_params));
 }
 
+static int rsnd_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_dai *dai = rsnd_substream_to_dai(substream);
+	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
+	int ret;
+
+	ret = rsnd_dai_call(hw_free, io, substream);
+	if (ret)
+		return ret;
+
+	return snd_pcm_lib_free_pages(substream);
+}
+
 static snd_pcm_uframes_t rsnd_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_dai *dai = rsnd_substream_to_dai(substream);
@@ -1436,7 +1450,7 @@ static snd_pcm_uframes_t rsnd_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops rsnd_pcm_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= rsnd_hw_params,
-	.hw_free	= snd_pcm_lib_free_pages,
+	.hw_free	= rsnd_hw_free,
 	.pointer	= rsnd_pointer,
 };
 
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 7727add3eb1a..ea6cbaa9743e 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -327,6 +327,9 @@ struct rsnd_mod_ops {
 	int (*cleanup)(struct rsnd_mod *mod,
 		       struct rsnd_dai_stream *io,
 		       struct rsnd_priv *priv);
+	int (*hw_free)(struct rsnd_mod *mod,
+		       struct rsnd_dai_stream *io,
+		       struct snd_pcm_substream *substream);
 	u32 *(*get_status)(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   enum rsnd_mod_type type);
@@ -351,12 +354,12 @@ struct rsnd_mod {
  *
  * B	0: init		1: quit
  * C	0: start	1: stop
+ * D	0: hw_params	1: hw_free
  *
  * H is always called (see __rsnd_mod_call)
  * H	0: probe	1: remove
  * H	0: pcm_new
  * H	0: fallback
- * H	0: hw_params
  * H	0: pointer
  * H	0: prepare
  * H	0: cleanup
@@ -365,12 +368,13 @@ struct rsnd_mod {
 #define __rsnd_mod_shift_quit		4
 #define __rsnd_mod_shift_start		8
 #define __rsnd_mod_shift_stop		8
+#define __rsnd_mod_shift_hw_params	12
+#define __rsnd_mod_shift_hw_free	12
 #define __rsnd_mod_shift_probe		28 /* always called */
 #define __rsnd_mod_shift_remove		28 /* always called */
 #define __rsnd_mod_shift_irq		28 /* always called */
 #define __rsnd_mod_shift_pcm_new	28 /* always called */
 #define __rsnd_mod_shift_fallback	28 /* always called */
-#define __rsnd_mod_shift_hw_params	28 /* always called */
 #define __rsnd_mod_shift_pointer	28 /* always called */
 #define __rsnd_mod_shift_prepare	28 /* always called */
 #define __rsnd_mod_shift_cleanup	28 /* always called */
@@ -383,10 +387,11 @@ struct rsnd_mod {
 #define __rsnd_mod_add_quit		-1
 #define __rsnd_mod_add_start		 1
 #define __rsnd_mod_add_stop		-1
+#define __rsnd_mod_add_hw_params	1
+#define __rsnd_mod_add_hw_free		-1
 #define __rsnd_mod_add_irq		0
 #define __rsnd_mod_add_pcm_new		0
 #define __rsnd_mod_add_fallback		0
-#define __rsnd_mod_add_hw_params	0
 #define __rsnd_mod_add_pointer		0
 
 #define __rsnd_mod_call_probe		0
@@ -402,6 +407,7 @@ struct rsnd_mod {
 #define __rsnd_mod_call_fallback	0
 #define __rsnd_mod_call_hw_params	0
 #define __rsnd_mod_call_pointer		0
+#define __rsnd_mod_call_hw_free		1
 
 #define rsnd_mod_to_priv(mod)	((mod)->priv)
 #define rsnd_mod_power_on(mod)	clk_enable((mod)->clk)
-- 
2.19.2

