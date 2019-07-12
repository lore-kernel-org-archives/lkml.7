Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D268C742A1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE072084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uk1BXR95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfGLBrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 21:47:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33367 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfGLBrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:47:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so8256942wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSFGt+Q1og6AA+SdNnXRjxSfv/MJFeGddK8TCtYrMOg=;
        b=uk1BXR95kMsdF9sHBlyG55rS2E1xeWRMYuIBC5lVMxQgjAcvzJIMynUBe3wm/zfSQD
         OC66fX/RzQlpJ44bj9120Ft2Tap9PgBHxgB/NX0Fjq0IvZe7WVXJzc4YskygtPm8UctJ
         QfmADfQxwVc1xW/vqRuRDxe0QO/w9RGgZBVyjvkTiBspm9mRMrBtPxuu5oTWyoVhIBnF
         TQauhcIgrgyVBirznKq2EzRvhq+2+0wZn+Bmu7JKfx2fhfT2m3CaVQwquawx60O3Iwk7
         IFye7kfK9w42vtwfGEwwfOo+oPGAGMPLrlxD8Ur60/Kwisr53dIEpOJnQ8OZlKpr1yPK
         Dt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSFGt+Q1og6AA+SdNnXRjxSfv/MJFeGddK8TCtYrMOg=;
        b=jXlfGIOTvHnIsuf5Z/LlIYZeQNYoyMx36CpW8z3TR5366WQvormRRNtD+9jfgcgmwO
         YT2DW8YzOFN0pwqMb70Kz9sau5XNwXeoRQyWq+wpK1i52GHSWaI0sO1EjCcrjKEJ7T6P
         0YG325ephB5SUkJvaRRXT4OPjb2oEhxCzdQwo7agM3Xt+qo43iAwKxPkY6+VeY5y32Kv
         JCLWRQqOe7U7Vt0K6pM/pGHjtb6aSGLBEJW/b1ZAclroriIBd/gKbjuOtpW28j+G5T06
         PeBWd3tZ/kelq/o7JJ5GRLo4A5nwdoPkcdoYUSY1FgMfq5K88XTsJWpTBGNas7O6aEcQ
         ycUQ==
X-Gm-Message-State: APjAAAXt6LhcqOsG9Jal0nMiNYQH0fn6MTi8Oa2oMd6cYPKm9+POZ/8f
        10R0rbpJhNwSn+dXb3HAU3s=
X-Google-Smtp-Source: APXvYqws0ImOdE7ZSUr6OyBuf5RgiTHk1I5zYJ43oxLwLXzH9OoHbxuh7mnT0trEjl87OLL0XXHcPA==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr7958812wru.179.1562896028018;
        Thu, 11 Jul 2019 18:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id v15sm5904425wru.61.2019.07.11.18.47.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 18:47:07 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] ASoC: audio-graph-card: Constify reg in graph_get_dai_id
Date:   Thu, 11 Jul 2019 18:45:55 -0700
Message-Id: <20190712014554.62465-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712014357.84245-1-natechancellor@gmail.com>
References: <20190712014357.84245-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang errors:

sound/soc/generic/audio-graph-card.c:87:7: error: assigning to 'u32 *'
(aka 'unsigned int *') from 'const void *' discards qualifiers
[-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                reg = of_get_property(node, "reg", NULL);
                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Move the declaration up a bit to keep the reverse christmas tree look.

Fixes: c152f8491a8d ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
Link: https://github.com/ClangBuiltLinux/linux/issues/600
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Update link in commit message (sorry, I create the commit message and
  send the patch first then create the issue and I forgot to check the
  closed ones for the correct number)

 sound/soc/generic/audio-graph-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index c8abb86afefa..c0d262a2ce2c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -62,8 +62,8 @@ static int graph_get_dai_id(struct device_node *ep)
 	struct device_node *node;
 	struct device_node *endpoint;
 	struct of_endpoint info;
+	const u32 *reg;
 	int i, id;
-	u32 *reg;
 	int ret;
 
 	/* use driver specified DAI ID if exist */
-- 
2.22.0

