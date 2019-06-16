Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F350C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771B2208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="gh6LmzXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfFPXPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:15:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45155 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfFPXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:15:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so4589979pfq.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6s43FoFGk1a0lzCjrcjOypwF7oZWJqI5fW9U/cGkrQ=;
        b=gh6LmzXLeXfnxxQNn15D7PEEGjZHXVOAh6pjmCTfac7zk6xjN7oYV5g6z2KUz2AG8a
         0sqjwzkrH/Lu/SRrpKVqlK30hNtORG52paEMlxfgKvGRDoIy6SSRvP/Hh7Po7moowL9j
         /xwphgXKkcBw6jcKOukF03Hp4YO+w07s7b9HOJkEg9Oo/GX84WajneW2sNGyQ2IBfp6x
         MiCQyHy/3TAS7XaxpSz+lbT5LBg5I0q05RB2FlUrrjXdpEUSNXbgwx/64DuteKGeZnIl
         p649thLLjnB3U0Qn2CooH70GPYG63yKd6xrIrXyn66PsdP8JDeuLkzZMg/Xg7oi9wKco
         QCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6s43FoFGk1a0lzCjrcjOypwF7oZWJqI5fW9U/cGkrQ=;
        b=b0ye1tIFu4Q1xfMtYk9SiIJw/yXs2IM/GZHPkPQgpUFEgDldWIAhe0S2ymIi0z66kS
         xQ+kNQ4jhzV5hmeEv4QQzY4RRCVUVtBw+yC42fwBJByQrg9SMshhJqF7jUXQB3dZ65oU
         FseYdzKJMgMMeAa4w3TSKi3xGCCfDaCjk2dpXj1F0TPT0KyWijTtTrgHBpum+iEvogCL
         rWar2W6IxvHsMf1pryf+aqV8jKB2az5sBWxnYwrvk9k2Y2YwQs4mJDhwmhvMB3BpwX9I
         FVI74WlUkwSjjcZ0GWT9pSixJQoBDJp00j5OBDKOkvXKVb3pJ5Ot1NmbTfnXQ1VVhH+9
         y4gw==
X-Gm-Message-State: APjAAAVBrJ02OayTm2EmoHynXr9xvMU6/KU955A8Xr9tArrn9AC+7FSy
        MCBWc7msoXjpuVfCTVUSfHRteiIAzmtOuEeJ
X-Google-Smtp-Source: APXvYqz+hgr1xnFhDWLE2nNx94+8/zH+iIcchdfdn0eXOBf+KMdK8dn5FigOxZDuEdAmalDFmv2TPw==
X-Received: by 2002:a62:1456:: with SMTP id 83mr59232399pfu.228.1560726902615;
        Sun, 16 Jun 2019 16:15:02 -0700 (PDT)
Received: from localhost ([2601:647:5180:35d7::cf52])
        by smtp.gmail.com with ESMTPSA id a21sm7682381pjh.10.2019.06.16.16.15.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 16:15:02 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        elftoolchain-developers@lists.sourceforge.net
Subject: [PATCH 2/2] objtool: Use Elf_Scn typedef instead of assuming tag name
Date:   Sun, 16 Jun 2019 16:15:00 -0700
Message-Id: <20190616231500.8572-2-mforney@mforney.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190616231500.8572-1-mforney@mforney.org>
References: <20190616231500.8572-1-mforney@mforney.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libelf implementation might use a different tag name, and the
Elf_Scn typedef is already used throughout the rest of objtool.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4116f564a0b0..a4258d80d4ce 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -463,7 +463,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
-	struct Elf_Scn *s;
+	Elf_Scn *s;
 	Elf_Data *data;
 
 	sec = malloc(sizeof(*sec));
-- 
2.20.1

