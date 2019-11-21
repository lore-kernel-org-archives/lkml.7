Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C289EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DBC2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKULKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:10:46 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:37584 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKULKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:10:46 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 8FB4F3C057F;
        Thu, 21 Nov 2019 12:10:43 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ppSTeXKvVKHo; Thu, 21 Nov 2019 12:10:38 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 164CA3C0022;
        Thu, 21 Nov 2019 12:10:38 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 21 Nov
 2019 12:10:37 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nilkanth Ahirrao <external.anilkanth@jp.adit-jv.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH v2] ASoC: rsnd: fix DALIGN register for SSIU
Date:   Thu, 21 Nov 2019 12:10:23 +0100
Message-ID: <20191121111023.10976-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>

The current driver only sets 0x76543210 and 0x67452301 for DALIGN.
This doesn’t work well for TDM split and ex-split mode for all SSIU.
This patch programs the DALIGN registers based on the SSIU number.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jiada Wang <jiada_wang@mentor.com>
Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Fixes: a914e44693d41b ("ASoC: rsnd: more clear rsnd_get_dalign() for DALIGN")
Signed-off-by: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v2:
 - Follow Kuninori Morimoto's suggestion to reuse dalign_values[0][x]
 - Simplify the code based on Andrew Gabbasov's review finding
v1:
 - https://patchwork.kernel.org/patch/11249769/
---
 sound/soc/sh/rcar/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index e9596c2096cd..a6c1cf987e6e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -376,6 +376,17 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
  */
 u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 {
+	static const u32 dalign_values[8][2] = {
+		{0x76543210, 0x67452301},
+		{0x00000032, 0x00000023},
+		{0x00007654, 0x00006745},
+		{0x00000076, 0x00000067},
+		{0xfedcba98, 0xefcdab89},
+		{0x000000ba, 0x000000ab},
+		{0x0000fedc, 0x0000efcd},
+		{0x000000fe, 0x000000ef},
+	};
+	int id = 0, inv;
 	struct rsnd_mod *ssiu = rsnd_io_to_mod_ssiu(io);
 	struct rsnd_mod *target;
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
@@ -411,13 +422,18 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 		target = cmd ? cmd : ssiu;
 	}
 
+	if (mod == ssiu)
+		id = rsnd_mod_id_sub(mod);
+
 	/* Non target mod or non 16bit needs normal DALIGN */
 	if ((snd_pcm_format_width(runtime->format) != 16) ||
 	    (mod != target))
-		return 0x76543210;
+		inv = 0;
 	/* Target mod needs inverted DALIGN when 16bit */
 	else
-		return 0x67452301;
+		inv = 1;
+
+	return dalign_values[id][inv];
 }
 
 u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod)
-- 
2.24.0

