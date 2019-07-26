Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D91C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA45C20657
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtD5zDDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfGZWsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:48:23 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47780 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfGZWsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:48:22 -0400
Received: by mail-pg1-f201.google.com with SMTP id l11so12520132pgc.14
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xXWX2VUvhlaSP3eFpOp6jubimcyekuwmKjKZ/Jue+2A=;
        b=UtD5zDDr3YWz08bCCB2rTH85HPonmpnywBjnkC+40TBxVdPSBkrdoJlfpcs3WjPJFz
         qzKCOlMiIkiyh0GnDIb4ufsrPNJH+6YElA+I+DAmT3BhzA7Cmm9gp250MTYPkN6Ojpgj
         Xt8gaKcUKddO+Jht4XR0TQYI5xAqZq8OzHw6rPl5iRysirTvroBgDGP+nZ3xPEukFUbY
         4RkcC8U3MNMoZOja3xOtQkm3b+qq+805SQozYU12Va/qJHk42NnDgNt2CvtQTCBqGNSh
         XMLSKVnibq91UNt6XUzmWQDgQtOKqKqP11a2Zd8Jm4pqJFsK7gP9Xwf9UHSkCsRGA7TD
         5gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xXWX2VUvhlaSP3eFpOp6jubimcyekuwmKjKZ/Jue+2A=;
        b=rJKwBnwe6Jfl3++wK+YsV1rLyIKpWWKfEUkyxiQJAzEf96KvntZsgps6o08d/V30mO
         ZQfSd7xV/x7zuKlQ3tnJSD2yrqxgTdTWxcUiEmxq+JgCuCVIoh+tUygIBM1+vBgrDRX1
         nNx1JOv+U5zaYGXNmS20/ObFy7Jscl6Xd3kQTxbGlz4/ZpNSjbSu0nsBhkjZO05eVVUv
         tztJbAOaIWkiIdxZ5O5WaxdK2ChkuHFGyfRTjBJKkuKzSUf0aQ6ityL9myg1W5xh4SxJ
         JQQzvaNC4K2j/xOAZG8nhk1uR/A0hKNJiFbkySpoJqlyE7nTW1kCdC8yrbzpJVL+Yzep
         5ixA==
X-Gm-Message-State: APjAAAWNameBX7pQxQd7xke+yM4OLlrclWtKg9iYIZbV5h8DBXeO1uKq
        0/ncszW0dwK5K5AjePnQ1x7wguD5N4X1Lonb
X-Google-Smtp-Source: APXvYqwgia3+whqx87wT3bznlRIKzs5psESC65iyZd4wex6/4W5aVuLVvjvBesKSfs8+uxfSH8qVoS5Vsfbb2O1C
X-Received: by 2002:a65:49cc:: with SMTP id t12mr87423288pgs.83.1564181301373;
 Fri, 26 Jul 2019 15:48:21 -0700 (PDT)
Date:   Fri, 26 Jul 2019 15:48:10 -0700
In-Reply-To: <20190726224810.79660-1-henryburns@google.com>
Message-Id: <20190726224810.79660-2-henryburns@google.com>
Mime-Version: 1.0
References: <20190726224810.79660-1-henryburns@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH] mm/z3fold.c: Fix z3fold_destroy_pool() race condition
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Vul <vitaly.vul@sony.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constraint from the zpool use of z3fold_destroy_pool() is there are no
outstanding handles to memory (so no active allocations), but it is possible
for there to be outstanding work on either of the two wqs in the pool.

Calling z3fold_deregister_migration() before the workqueues are drained
means that there can be allocated pages referencing a freed inode,
causing any thread in compaction to be able to trip over the bad
pointer in PageMovable().

Fixes: 1f862989b04a ("mm/z3fold.c: support page migration")

Signed-off-by: Henry Burns <henryburns@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/z3fold.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 43de92f52961..ed19d98c9dcd 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -817,16 +817,19 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 static void z3fold_destroy_pool(struct z3fold_pool *pool)
 {
 	kmem_cache_destroy(pool->c_handle);
-	z3fold_unregister_migration(pool);
 
 	/*
 	 * We need to destroy pool->compact_wq before pool->release_wq,
 	 * as any pending work on pool->compact_wq will call
 	 * queue_work(pool->release_wq, &pool->work).
+	 *
+	 * There are still outstanding pages until both workqueues are drained,
+	 * so we cannot unregister migration until then.
 	 */
 
 	destroy_workqueue(pool->compact_wq);
 	destroy_workqueue(pool->release_wq);
+	z3fold_unregister_migration(pool);
 	kfree(pool);
 }
 
-- 
2.22.0.709.g102302147b-goog

