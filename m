Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4CFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C035922CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsrgTbga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfICQFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:05:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46907 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:05:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so3199565pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDjYh1SsltbOsBEB420dFALj+pbpv/F7VefYy840/EY=;
        b=GsrgTbgaFBhQFrgMq1YXV4RcR8zjQ92lvCgtyccS3iRm7gcJ5k1MEg9O6oXgHMo1uw
         GjDU6QjiPGgWmOnRQawMZ0TDo+gQ4THlJHPVk9GT/RLACj4Q7n+i6nIKI3WTzBlmBorM
         Oaeizkzy5iXh5H/4je9rGcysSeMPbIY76OHNUfmoPxnj8ypctXVBadQ7ZvKK5cb6uFgL
         UBAr3eR8Ub+H5/3P+4O/KzsjzvkQwLTTYI7uocFkQ6ZEUiVLYY00fYEK2pcRNZHkflf6
         cH2mY/iB0eqUuBnGejO+Urv3EfLgYnwLRot8i4xUkb3sG5+yRbVpbDH1W4O+gFwQ0ML/
         GCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDjYh1SsltbOsBEB420dFALj+pbpv/F7VefYy840/EY=;
        b=Gwyf29IIB8ls9FydS/lhvqqhP3/0LwsF5h3F746bz9H1skJHn8h6rKfp6ZpeENLcJN
         WH+u27YZR8chzhhqfdVCM6fcPBL/0w5KBEie6bQK88aPa0yQEjjrlSGvpCzrmiy/Q8QS
         AkoP6P56Rb2WZnvUl/Ydck4kIQMu4S2/PnWQUH/0hsZ43NjNFpIRqSaqNYWqWw1af7Ox
         zRuQNaEZywIUNeHfyufxBDDWPHJd3/qT3xAB3qAzW9d6oyZBL4OhDFr9TAdSNb9Wrg4b
         dkH7PS8ffrrKpLzO3XvSCkwP9J1Bbicinsigdbqq7UjsKxTdyr6TgN+ihDhRMFGS6yfA
         1Lgw==
X-Gm-Message-State: APjAAAUP+dlJeP5YbZJO4jUq8k1E2gqRMcBLfAiZCnwucanRKHGufZ3o
        rtYpU3OkxOK0fnxU48MRk7g=
X-Google-Smtp-Source: APXvYqw+wcwd1Q5ELGsyNrHdLhIs738zYiU66KGwfojkb+IX0BJdf35/4VhaGx1L9wzKEkW3Xtki6A==
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr30382871pgl.270.1567526750106;
        Tue, 03 Sep 2019 09:05:50 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id t11sm18501567pgb.33.2019.09.03.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 09:05:49 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 2/5] mm, slab_common: Remove unused kmalloc_cache_name()
Date:   Wed,  4 Sep 2019 00:04:27 +0800
Message-Id: <20190903160430.1368-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903160430.1368-1-lpf.vector@gmail.com>
References: <20190903160430.1368-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the name of kmalloc can be obtained from kmalloc_info[],
remove the kmalloc_cache_name() that is no longer used.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/slab_common.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7bd88cc09987..002e16673581 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1191,21 +1191,6 @@ void __init setup_kmalloc_cache_index_table(void)
 	}
 }
 
-static const char *
-kmalloc_cache_name(const char *prefix, unsigned int size)
-{
-
-	static const char units[3] = "\0kM";
-	int idx = 0;
-
-	while (size >= 1024 && (size % 1024 == 0)) {
-		size /= 1024;
-		idx++;
-	}
-
-	return kasprintf(GFP_NOWAIT, "%s-%u%c", prefix, size, units[idx]);
-}
-
 static void __init
 new_kmalloc_cache(int idx, int type, slab_flags_t flags)
 {
-- 
2.21.0

