Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD7CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF29020704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452530;
	bh=2oWcL0J8kqtwJ//O+ZfY6OpSQoHqZzVYa1ZXeSbCij8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=DOVW76UfpTwj4RHhevCzIVkSp/lX06BmYaGDBVH9T44wIgoB6Nx0HbeH+YfjcbJdQ
	 Qr6nDiE+Pz+ciwZEkwSXbe2bHMNUawAXHwqzxIXvCYpWcCBponrU3jYqYWPx3zZYWR
	 Ouh5wrM+Z8/oUihvrENGF8c4km6eFHUi7b+wGx5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfKVTz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:55:29 -0500
Received: from foss.arm.com ([217.140.110.172]:52134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfKVTz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:55:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF12D1045;
        Fri, 22 Nov 2019 11:55:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B35C3F6C4;
        Fri, 22 Nov 2019 11:55:28 -0800 (PST)
Date:   Fri, 22 Nov 2019 19:55:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Cc:     alsa-devel@alsa-project.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiada Wang <jiada_wang@mentor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Nilkanth Ahirrao <external.anilkanth@jp.adit-jv.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rsnd: fix DALIGN register for SSIU" to the asoc tree
In-Reply-To: <20191121111023.10976-1-erosca@de.adit-jv.com>
Message-Id: <applied-20191121111023.10976-1-erosca@de.adit-jv.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: fix DALIGN register for SSIU

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From ef8e14794308a428b194f8b06ad9ae06b43466e4 Mon Sep 17 00:00:00 2001
From: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Date: Thu, 21 Nov 2019 12:10:23 +0100
Subject: [PATCH] ASoC: rsnd: fix DALIGN register for SSIU
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current driver only sets 0x76543210 and 0x67452301 for DALIGN.
This doesn’t work well for TDM split and ex-split mode for all SSIU.
This patch programs the DALIGN registers based on the SSIU number.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jiada Wang <jiada_wang@mentor.com>
Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Fixes: a914e44693d41b ("ASoC: rsnd: more clear rsnd_get_dalign() for DALIGN")
Signed-off-by: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20191121111023.10976-1-erosca@de.adit-jv.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

