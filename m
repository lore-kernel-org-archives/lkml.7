Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A516C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B5F2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfHMWqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 18:46:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfHMWqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:46:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51825AD20;
        Tue, 13 Aug 2019 22:46:36 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     walken@google.com, peterz@infradead.org, akpm@linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/3] x86,mm/pat: Cleanup some of the local memtype_rb_* calls
Date:   Tue, 13 Aug 2019 15:46:19 -0700
Message-Id: <20190813224620.31005-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190813224620.31005-1-dave@stgolabs.net>
References: <20190813224620.31005-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup by both getting rid of passing the rb_root down the helper
calls; there is only one. Secondly rename some of the calls from
memtype_rb_ to memtype_interval_.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/mm/pat_rbtree.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index 1be4d1856a9b..c87fa0e402db 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -55,12 +55,11 @@ static int is_node_overlap(struct memtype *node, u64 start, u64 end)
 	return 1;
 }
 
-static struct memtype *memtype_rb_lowest_match(struct rb_root_cached *root,
-						u64 start, u64 end)
+static struct memtype *memtype_interval_lowest_match(u64 start, u64 end)
 {
 	struct memtype *node;
 
-	node = memtype_interval_iter_first(root, start, end);
+	node = memtype_interval_iter_first(&memtype_rbroot, start, end);
 	while (node) {
 		if (is_node_overlap(node, start, end))
 			return node;
@@ -76,12 +75,12 @@ enum {
 	MEMTYPE_END_MATCH	= 1
 };
 
-static struct memtype *memtype_rb_match(struct rb_root_cached *root,
-					u64 start, u64 end, int match_type)
+static struct memtype *memtype_interval_match(u64 start, u64 end,
+					      int match_type)
 {
 	struct memtype *match;
 
-	match = memtype_rb_lowest_match(root, start, end);
+	match = memtype_interval_lowest_match(start, end);
 
 	while (match != NULL && match->start < end) {
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
@@ -98,15 +97,14 @@ static struct memtype *memtype_rb_match(struct rb_root_cached *root,
 	return NULL; /* Returns NULL if there is no match */
 }
 
-static int memtype_rb_check_conflict(struct rb_root_cached *root,
-				      u64 start, u64 end,
-				      enum page_cache_mode reqtype,
-				      enum page_cache_mode *newtype)
+static int memtype_interval_check_conflict(u64 start, u64 end,
+					   enum page_cache_mode reqtype,
+					   enum page_cache_mode *newtype)
 {
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
 
-	match = memtype_rb_lowest_match(root, start, end);
+	match = memtype_interval_lowest_match(start, end);
 	if (match == NULL)
 		goto success;
 
@@ -146,9 +144,8 @@ int rbt_memtype_check_insert(struct memtype *new,
 {
 	int err;
 
-	err =  memtype_rb_check_conflict(&memtype_rbroot,
-					 new->start, new->end,
-					 new->type, ret_type);
+	err =  memtype_interval_check_conflict(new->start, new->end,
+					       new->type, ret_type);
 	if (err)
 		return err;
 
@@ -170,11 +167,9 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 	 * it then checks with END_MATCH, i.e. shrink the size of a node
 	 * from the end for the mremap case.
 	 */
-	data = memtype_rb_match(&memtype_rbroot, start, end,
-				MEMTYPE_EXACT_MATCH);
+	data = memtype_interval_match(start, end, MEMTYPE_EXACT_MATCH);
 	if (!data) {
-		data = memtype_rb_match(&memtype_rbroot, start, end,
-					MEMTYPE_END_MATCH);
+		data = memtype_interval_match(start, end, MEMTYPE_END_MATCH);
 		if (!data)
 			return ERR_PTR(-EINVAL);
 	}
@@ -196,7 +191,7 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 
 struct memtype *rbt_memtype_lookup(u64 addr)
 {
-	return memtype_rb_lowest_match(&memtype_rbroot, addr, addr + PAGE_SIZE);
+	return memtype_interval_lowest_match(addr, addr + PAGE_SIZE);
 }
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.16.4

