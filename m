Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1590C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBA92081C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rx8+mRDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEAFbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 01:31:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40429 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfEAFbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 01:31:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so7771715plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 22:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hJGfLPSlXzuDQII6G9FALVwQaMMai8r6WJCEuagoSSY=;
        b=rx8+mRDr7uB513B1QlZ0yFUEOHTB5qybmgkFdh2zQUxBqedApwYu+doW87pZNZlL1R
         h6bwD1t33VlUHjxYTjhprLqFCdjQPz9625heZ8btkekZs4ONNhMAh7hK3rlEuTl7iPGx
         aqDA32BmZUtYG+5xR5mhpGF1ma47lmaWiuR1KgMuKn7JLgaO37Yv7YQ2LGN8Y8Q0QZfS
         6oyuvfoihrlR5ZwtZ7/zu0ahqgSLS4wo3z6/MKdeHQPyUB/6p6wczRE6xbX8JcK/uqMv
         K3Ye285PbVKnpB4e63GX/RgD7rFxz5du1Md0JXQQQl3X2meLo/+1z09kaAPvFbLDpLe5
         hkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hJGfLPSlXzuDQII6G9FALVwQaMMai8r6WJCEuagoSSY=;
        b=fphjT/CMb0kQfzfP3xg0CAam5axIxDtgrAbGpr1FI0qQgKhYqGvygzxcxzsgkDvAMf
         xdXOBmzti56zY3EiNb5VShD82wLnzuIq4LUDegysUe9RO92FTK3LocVtw1fzTtaAVzti
         71USUZtuaTBdTUQGeFYy+I5y1u/t0DNbP8oGwoNw+p+hNJHlL6CMJh0MfR2uZdLlnsIi
         uOWMJJkEpG8z8kV1OiaJwoCuP914Ypl0GGkVd7RnBfhHdg8VtF0y+OTQ1KaGYz5EJItS
         p0IhQELyxQk3iPduJUN3OJCaaNgiEIXZtt+J6ahv2iGPNWZkY12XlWcwo8p+LsAYsOK8
         osyQ==
X-Gm-Message-State: APjAAAV/7qzvUbR2EzkWxIgPgFSM4AFvSq+Iq/WWrJ8ndpvb+HsRVrkw
        dLyVTzLlhMaBhpRc67UcBv8=
X-Google-Smtp-Source: APXvYqxoerCH7+5HGdXjF6wwjvKIeawAx6VlCaf7+1k4K+pXX0cyWk4hGTP86fKDCPuMZNTFDxCDBA==
X-Received: by 2002:a17:902:521:: with SMTP id 30mr73353039plf.248.1556688675061;
        Tue, 30 Apr 2019 22:31:15 -0700 (PDT)
Received: from localhost ([2601:640:e:200:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id b14sm47835587pfi.92.2019.04.30.22.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 22:31:13 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yury Norov <ynorov@marvell.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] mm/slub: avoid double string traverse in kmem_cache_flags()
Date:   Tue, 30 Apr 2019 22:31:11 -0700
Message-Id: <20190501053111.7950-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ',' is not found, kmem_cache_flags() calls strlen() to find the end
of line. We can do it in a single pass using strchrnul().

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 mm/slub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4922a0394757..85f90370a293 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1317,9 +1317,7 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 		char *end, *glob;
 		size_t cmplen;
 
-		end = strchr(iter, ',');
-		if (!end)
-			end = iter + strlen(iter);
+		end = strchrnul(iter, ',');
 
 		glob = strnchr(iter, end - iter, '*');
 		if (glob)
-- 
2.17.1

