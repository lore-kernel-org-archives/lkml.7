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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63873C742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B142084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHN+AfMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfGLBoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 21:44:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35606 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfGLBoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:44:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so8222841wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 18:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRWVv8sMYMKYocmhKIjrnQXwGIfPiESQt2vqD2pw6zk=;
        b=kHN+AfMwIfWvbCzX/eK7qSCf1BewVjfqp1d9z24xOKwzQlFs6zfqnjUfdMEXe5atJ6
         mFVYkfz2DQeu2rbqGE80IVOPARF4eVPFnukanQJQUpsfEVqu0MvuyhbFIGKOYded9Krd
         dnWH3LHg6SvxKHDupiaPV+ihCRUGSq7cG1LAwlJtXuwN9pTixn3dTA3eZncHJBfzPFAF
         rAdZa4juu3LFLppzcNdCX42Bjf538euDCiVZtkOX1lyEX2u+ZPS1QddMq5EeiK6DBzzY
         zQQ6VnFqwAVqW1VKpUR4MSq4w6RccOGecw9yFjhY+DEWfbH8Ook1N61qpiAEGKTPnLTq
         sfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRWVv8sMYMKYocmhKIjrnQXwGIfPiESQt2vqD2pw6zk=;
        b=dTuvbgJrnxjvQdDW9Z2GgrdPn8qaf+Xv5EffBKu2R9Qs4cnJpobFhxrW5JzHBavkf6
         GtVocGSRhAqJfIi9O6LMu9PAeiIxguSOV6tW6ZcJqWCKeAptHPh/kxomtktsCKsKPDe0
         O7mWORtMg/gHe352F8oTLdr0rTBeHrzVngQD0uZS1AvjgUJsKwGT7FdetVQeP8m5OsLP
         oOr4+/HNwiEZN2gT4IbrqRNAIDXZpmGnp6w7oWTAbUoqSOckxZnbKQ7kl6JGu93jUzQy
         vTx/KM55DttU8JB3nvyxwrr9tZvaA0pkqQ1+LLxVhr7w5qyVIHiGjuOoeWs1/dWwchkc
         am8w==
X-Gm-Message-State: APjAAAUQSBadRGM8v4d8CLhYUt71BgR7TdwESgxUC88JFnrhR5ZkltQs
        VecSrnRbW5LpA3dg7ybwgfQ=
X-Google-Smtp-Source: APXvYqxW0bEAUwTusv0FyTqBh2bQSqPJE1T0dmhXPjiJpjySvSYlo6VoBdXsoD+zPFlh180GL/mH0Q==
X-Received: by 2002:adf:ce88:: with SMTP id r8mr8254019wrn.42.1562895859848;
        Thu, 11 Jul 2019 18:44:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id y12sm4409747wrm.79.2019.07.11.18.44.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 18:44:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: audio-graph-card: Constify reg in graph_get_dai_id
Date:   Thu, 11 Jul 2019 18:43:57 -0700
Message-Id: <20190712014357.84245-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
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
Link: https://github.com/ClangBuiltLinux/linux/issues/599
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
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

