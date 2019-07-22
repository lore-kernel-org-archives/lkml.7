Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB04C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CE22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfGVHYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:24:15 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:52996 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfGVHYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:24:14 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hpSg8-0002I2-Jx from Jiada_Wang@mentor.com ; Mon, 22 Jul 2019 00:24:12 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 22 Jul 2019 00:24:09 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <twischer@de.adit-jv.com>, <jiada_wang@mentor.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] ASoC: rsnd: call .hw_{params,free} in pair for same stream
Date:   Mon, 22 Jul 2019 16:24:03 +0900
Message-ID: <20190722072403.11008-4-jiada_wang@mentor.com>
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

Currently usrcnt is {in,de}cremented in .hw_{params,free} callbacks,
but .hw_free may be called multiple times without calling .hw_params.
this causes the usrcnt be decremented wrongly.

This patch allows .hw_{params,free} to be called only in pairs for
the same stream which balances the {in,de}crement of usrcnt.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/soc/sh/rcar/core.c |  6 ++++--
 sound/soc/sh/rcar/rsnd.h | 24 ++++++++++++++++++++++--
 sound/soc/sh/rcar/ssi.c  |  8 ++++++--
 sound/soc/sh/rcar/ssiu.c |  3 ++-
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index bda5b958d0dc..b9330bdadbd3 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -172,7 +172,8 @@ char *rsnd_mod_name(struct rsnd_mod *mod)
 
 u32 *rsnd_mod_get_status(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
-			 enum rsnd_mod_type type)
+			 enum rsnd_mod_type type,
+			 int flag)
 {
 	return &mod->status;
 }
@@ -548,7 +549,8 @@ static int rsnd_status_update(u32 *status,
 	enum rsnd_mod_type *types = rsnd_mod_sequence[is_play];		\
 	for_each_rsnd_mod_arrays(i, mod, io, types, RSND_MOD_MAX) {	\
 		int tmp = 0;						\
-		u32 *status = mod->ops->get_status(mod, io, types[i]);	\
+		u32 *status = mod->ops->get_status(mod, io, types[i],	\
+						__rsnd_mod_flag_##fn);	\
 		int func_call = rsnd_status_update(status,		\
 						__rsnd_mod_shift_##fn,	\
 						__rsnd_mod_add_##fn,	\
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ea6cbaa9743e..b4e3e9289f8a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -238,6 +238,7 @@ enum rsnd_reg {
 #define SSI9_BUSIF_DALIGN(i)	(SSI9_BUSIF0_DALIGN + (i))
 #define SSI_SYS_STATUS(i)	(SSI_SYS_STATUS0 + (i))
 
+#define RSND_STATUS_ON_IO	BIT(0)
 
 struct rsnd_priv;
 struct rsnd_mod;
@@ -332,7 +333,8 @@ struct rsnd_mod_ops {
 		       struct snd_pcm_substream *substream);
 	u32 *(*get_status)(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
-			   enum rsnd_mod_type type);
+			   enum rsnd_mod_type type,
+			   int flag);
 	int (*id)(struct rsnd_mod *mod);
 	int (*id_sub)(struct rsnd_mod *mod);
 	int (*id_cmd)(struct rsnd_mod *mod);
@@ -379,6 +381,22 @@ struct rsnd_mod {
 #define __rsnd_mod_shift_prepare	28 /* always called */
 #define __rsnd_mod_shift_cleanup	28 /* always called */
 
+#define __rsnd_mod_flag_init		0
+#define __rsnd_mod_flag_quit		0
+#define __rsnd_mod_flag_start		0
+#define __rsnd_mod_flag_stop		0
+#define __rsnd_mod_flag_hw_params	RSND_STATUS_ON_IO
+#define __rsnd_mod_flag_hw_free		RSND_STATUS_ON_IO
+#define __rsnd_mod_flag_probe		0
+#define __rsnd_mod_flag_remove		0
+#define __rsnd_mod_flag_irq		0
+#define __rsnd_mod_flag_pcm_new		0
+#define __rsnd_mod_flag_fallback	0
+#define __rsnd_mod_flag_pointer		0
+#define __rsnd_mod_flag_prepare		0
+#define __rsnd_mod_flag_cleanup		0
+#define __rsnd_mod_flag_set_fmt		0
+
 #define __rsnd_mod_add_probe		0
 #define __rsnd_mod_add_remove		0
 #define __rsnd_mod_add_prepare		0
@@ -428,7 +446,8 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 					 struct rsnd_dai_stream *io));
 u32 *rsnd_mod_get_status(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
-			 enum rsnd_mod_type type);
+			 enum rsnd_mod_type type,
+			 int flag);
 int rsnd_mod_id(struct rsnd_mod *mod);
 int rsnd_mod_id_raw(struct rsnd_mod *mod);
 int rsnd_mod_id_sub(struct rsnd_mod *mod);
@@ -496,6 +515,7 @@ struct rsnd_dai_stream {
 	u32 converted_rate;      /* converted sampling rate */
 	int converted_chan;      /* converted channels */
 	u32 parent_ssi_status;
+	u32 status;
 	u32 flags;
 };
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f43937d2c588..89b4029b290b 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -681,7 +681,8 @@ static irqreturn_t rsnd_ssi_interrupt(int irq, void *data)
 
 static u32 *rsnd_ssi_get_status(struct rsnd_mod *mod,
 				struct rsnd_dai_stream *io,
-				enum rsnd_mod_type type)
+				enum rsnd_mod_type type,
+				int flag)
 {
 	/*
 	 * SSIP (= SSI parent) needs to be special, otherwise,
@@ -711,7 +712,10 @@ static u32 *rsnd_ssi_get_status(struct rsnd_mod *mod,
 	if (type == RSND_MOD_SSIP)
 		return &io->parent_ssi_status;
 
-	return rsnd_mod_get_status(mod, io, type);
+	if (flag && RSND_STATUS_ON_IO)
+		return &io->status;
+
+	return rsnd_mod_get_status(mod, io, type, flag);
 }
 
 /*
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index f35d88211887..45e4cd84fbc4 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -47,7 +47,8 @@ static const int gen3_id[] = { 0, 8, 16, 24, 32, 40, 41, 42, 43, 44 };
 
 static u32 *rsnd_ssiu_get_status(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io,
-				 enum rsnd_mod_type type)
+				 enum rsnd_mod_type type,
+				 int flag)
 {
 	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
 	int busif = rsnd_mod_id_sub(mod);
-- 
2.19.2

