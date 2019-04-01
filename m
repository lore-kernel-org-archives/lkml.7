Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A920880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfDAXIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:08:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:54320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbfDAXIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:08:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AC9DAFFA;
        Mon,  1 Apr 2019 23:08:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue, 02 Apr 2019 10:07:45 +1100
Subject: [PATCH 1/4] rhashtable: use cmpxchg() in nested_table_alloc()
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155416006508.9540.3368212864327714370.stgit@noble.brown>
In-Reply-To: <155416000985.9540.14182958463813560577.stgit@noble.brown>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nested_table_alloc() relies on the fact that there is
at most one spinlock allocated for every slot in the top
level nested table, so it is not possible for two threads
to try to allocate the same table at the same time.

This assumption is a little fragile (it is not explicit) and is
unnecessary as cmpxchg() can be used instead.

A future patch will replace the spinlocks by per-bucket bitlocks,
and then we won't be able to protect the slot pointer with a spinlock.

So replace rcu_assign_pointer() with cmpxchg() - which has equivalent
barrier properties.
If it the cmp fails, free the table that was just allocated.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 811d51b7cb86..6c4f5c8e9baa 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -131,9 +131,11 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 			INIT_RHT_NULLS_HEAD(ntbl[i].bucket);
 	}
 
-	rcu_assign_pointer(*prev, ntbl);
-
-	return ntbl;
+	if (cmpxchg(prev, NULL, ntbl) == NULL)
+		return ntbl;
+	/* Raced with another thread. */
+	kfree(ntbl);
+	return rcu_dereference(*prev);
 }
 
 static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,


