Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D5C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45A320885
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKUBWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:22:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:42608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbfKUBW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:22:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 265E9B271;
        Thu, 21 Nov 2019 01:22:26 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de
Cc:     peterz@infradead.org, x86@kernel.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/4] x86/mm, pat: Cleanup some of the local memtype_rb_* calls
Date:   Wed, 20 Nov 2019 17:15:59 -0800
Message-Id: <20191121011601.20611-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121011601.20611-1-dave@stgolabs.net>
References: <20191121011601.20611-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup by both getting rid of passing the rb_root down the helper
calls; there is only one. Secondly rename some of the calls from
memtype_rb_*.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/mm/pat_rbtree.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index c3d119cd155d..d31ca773d4bb 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -52,12 +52,11 @@ enum {
 	MEMTYPE_END_MATCH	= 1
 };
 
-static struct memtype *memtype_match(struct rb_root_cached *root,
-				     u64 start, u64 end, int match_type)
+static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 {
 	struct memtype *match;
 
-	match = memtype_interval_iter_first(root, start, end);
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
 	while (match != NULL && match->start < end) {
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
 		    (match->start == start) && (match->end == end))
@@ -73,10 +72,9 @@ static struct memtype *memtype_match(struct rb_root_cached *root,
 	return NULL; /* Returns NULL if there is no match */
 }
 
-static int memtype_rb_check_conflict(struct rb_root_cached *root,
-				u64 start, u64 end,
-				enum page_cache_mode reqtype,
-				enum page_cache_mode *newtype)
+static int memtype_check_conflict(u64 start, u64 end,
+				  enum page_cache_mode reqtype,
+				  enum page_cache_mode *newtype)
 {
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
@@ -116,8 +114,7 @@ int rbt_memtype_check_insert(struct memtype *new,
 {
 	int err = 0;
 
-	err = memtype_rb_check_conflict(&memtype_rbroot, new->start, new->end,
-					new->type, ret_type);
+	err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
 	if (err)
 		return err;
 
@@ -139,11 +136,9 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 	 * it then checks with END_MATCH, i.e. shrink the size of a node
 	 * from the end for the mremap case.
 	 */
-	data = memtype_match(&memtype_rbroot, start, end,
-			     MEMTYPE_EXACT_MATCH);
+	data = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
 	if (!data) {
-		data = memtype_match(&memtype_rbroot, start, end,
-				     MEMTYPE_END_MATCH);
+		data = memtype_match(start, end, MEMTYPE_END_MATCH);
 		if (!data)
 			return ERR_PTR(-EINVAL);
 	}
-- 
2.16.4

