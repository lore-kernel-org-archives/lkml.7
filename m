Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A49C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82495218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257544;
	bh=BfWoab1GxUKbYRVoo6RMhS0zjKSq+2dF9hH500xPp9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rYz8EHsNnfLur2mJ3nc6ayTZqITt8HzMuHaaUrDPmapVhYwiP7Lml+DeXZO8FZnuP
	 mc6c+y5bgXHeK04ze4uolwNWIys83SEG1051jQMeLx3QFPoCWcz6oQFFzM278nwXux
	 4m+3bfex95RgxTFClnsVC+aFMaQOkeFwd/GV+pRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbfCVMZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391159AbfCVMXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 399AE2054F;
        Fri, 22 Mar 2019 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257425;
        bh=BfWoab1GxUKbYRVoo6RMhS0zjKSq+2dF9hH500xPp9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHlLo9BE7s5JuvXWRB5QUZ7z5sEuEELKV3WwHhNIi81/PfXkvXteP+U14vS/Xa6wS
         hwQdsspneAox8sNiV6huyIpTCbkCKX7l8sdytPRJ3OagBXbsCLzkxksoY5Rlsfj8Bn
         DLhb3lk+g/AAv2Tz4kHX+Vj0iWqYBj7lSFNEEbcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui.linux@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.0 195/238] bcache: treat stale && dirty keys as bad keys
Date:   Fri, 22 Mar 2019 12:16:54 +0100
Message-Id: <20190322111309.699373791@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui.linux@gmail.com>

commit 58ac323084ebf44f8470eeb8b82660f9d0ee3689 upstream.

Stale && dirty keys can be produced in the follow way:
After writeback in write_dirty_finish(), dirty keys k1 will
replace by clean keys k2
==>ret = bch_btree_insert(dc->disk.c, &keys, NULL, &w->key);
==>btree_insert_fn(struct btree_op *b_op, struct btree *b)
==>static int bch_btree_insert_node(struct btree *b,
       struct btree_op *op,
       struct keylist *insert_keys,
       atomic_t *journal_ref,
Then two steps:
A) update k1 to k2 in btree node memory;
   bch_btree_insert_keys(b, op, insert_keys, replace_key)
B) Write the bset(contains k2) to cache disk by a 30s delay work
   bch_btree_leaf_dirty(b, journal_ref).
But before the 30s delay work write the bset to cache device,
these things happened:
A) GC works, and reclaim the bucket k2 point to;
B) Allocator works, and invalidate the bucket k2 point to,
   and increase the gen of the bucket, and place it into free_inc
   fifo;
C) Until now, the 30s delay work still does not finish work,
   so in the disk, the key still is k1, it is dirty and stale
   (its gen is smaller than the gen of the bucket). and then the
   machine power off suddenly happens;
D) When the machine power on again, after the btree reconstruction,
   the stale dirty key appear.

In bch_extent_bad(), when expensive_debug_checks is off, it would
treat the dirty key as good even it is stale keys, and it would
cause bellow probelms:
A) In read_dirty() it would cause machine crash:
   BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
B) It could be worse when reads hits stale dirty keys, it would
   read old incorrect data.

This patch tolerate the existence of these stale && dirty keys,
and treat them as bad key in bch_extent_bad().

(Coly Li: fix indent which was modified by sender's email client)

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/extents.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -538,6 +538,7 @@ static bool bch_extent_bad(struct btree_
 {
 	struct btree *b = container_of(bk, struct btree, keys);
 	unsigned int i, stale;
+	char buf[80];
 
 	if (!KEY_PTRS(k) ||
 	    bch_extent_invalid(bk, k))
@@ -547,19 +548,19 @@ static bool bch_extent_bad(struct btree_
 		if (!ptr_available(b->c, k, i))
 			return true;
 
-	if (!expensive_debug_checks(b->c) && KEY_DIRTY(k))
-		return false;
-
 	for (i = 0; i < KEY_PTRS(k); i++) {
 		stale = ptr_stale(b->c, k, i);
 
+		if (stale && KEY_DIRTY(k)) {
+			bch_extent_to_text(buf, sizeof(buf), k);
+			pr_info("stale dirty pointer, stale %u, key: %s",
+				stale, buf);
+		}
+
 		btree_bug_on(stale > BUCKET_GC_GEN_MAX, b,
 			     "key too stale: %i, need_gc %u",
 			     stale, b->c->need_gc);
 
-		btree_bug_on(stale && KEY_DIRTY(k) && KEY_SIZE(k),
-			     b, "stale dirty pointer");
-
 		if (stale)
 			return true;
 


