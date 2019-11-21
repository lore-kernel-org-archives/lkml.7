Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4954C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34B520885
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKUBWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:22:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:42624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbfKUBW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:22:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0091B272;
        Thu, 21 Nov 2019 01:22:27 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de
Cc:     peterz@infradead.org, x86@kernel.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/4] x86/mm, pat: Drop rbt prefix from external memtype calls
Date:   Wed, 20 Nov 2019 17:16:00 -0800
Message-Id: <20191121011601.20611-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121011601.20611-1-dave@stgolabs.net>
References: <20191121011601.20611-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the rbt_memtype_* calls (those used by pat.c) as we
no longer use an rbtree directly.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/mm/pat.c          |  8 ++++----
 arch/x86/mm/pat_internal.h | 20 ++++++++++----------
 arch/x86/mm/pat_rbtree.c   | 12 ++++++------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index d9fbd4f69920..2d758e19ef22 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -603,7 +603,7 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 	spin_lock(&memtype_lock);
 
-	err = rbt_memtype_check_insert(new, new_type);
+	err = memtype_check_insert(new, new_type);
 	if (err) {
 		pr_info("x86/PAT: reserve_memtype failed [mem %#010Lx-%#010Lx], track %s, req %s\n",
 			start, end - 1,
@@ -650,7 +650,7 @@ int free_memtype(u64 start, u64 end)
 	}
 
 	spin_lock(&memtype_lock);
-	entry = rbt_memtype_erase(start, end);
+	entry = memtype_erase(start, end);
 	spin_unlock(&memtype_lock);
 
 	if (IS_ERR(entry)) {
@@ -693,7 +693,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 
 	spin_lock(&memtype_lock);
 
-	entry = rbt_memtype_lookup(paddr);
+	entry = memtype_lookup(paddr);
 	if (entry != NULL)
 		rettype = entry->type;
 	else
@@ -1109,7 +1109,7 @@ static struct memtype *memtype_get_idx(loff_t pos)
 		return NULL;
 
 	spin_lock(&memtype_lock);
-	ret = rbt_memtype_copy_nth_element(print_entry, pos);
+	ret = memtype_copy_nth_element(print_entry, pos);
 	spin_unlock(&memtype_lock);
 
 	if (!ret) {
diff --git a/arch/x86/mm/pat_internal.h b/arch/x86/mm/pat_internal.h
index eeb5caeb089b..79a06684349e 100644
--- a/arch/x86/mm/pat_internal.h
+++ b/arch/x86/mm/pat_internal.h
@@ -29,20 +29,20 @@ static inline char *cattr_name(enum page_cache_mode pcm)
 }
 
 #ifdef CONFIG_X86_PAT
-extern int rbt_memtype_check_insert(struct memtype *new,
-					enum page_cache_mode *new_type);
-extern struct memtype *rbt_memtype_erase(u64 start, u64 end);
-extern struct memtype *rbt_memtype_lookup(u64 addr);
-extern int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos);
+extern int memtype_check_insert(struct memtype *new,
+				enum page_cache_mode *new_type);
+extern struct memtype *memtype_erase(u64 start, u64 end);
+extern struct memtype *memtype_lookup(u64 addr);
+extern int memtype_copy_nth_element(struct memtype *out, loff_t pos);
 #else
-static inline int rbt_memtype_check_insert(struct memtype *new,
-					enum page_cache_mode *new_type)
+static inline int memtype_check_insert(struct memtype *new,
+				       enum page_cache_mode *new_type)
 { return 0; }
-static inline struct memtype *rbt_memtype_erase(u64 start, u64 end)
+static inline struct memtype *memtype_erase(u64 start, u64 end)
 { return NULL; }
-static inline struct memtype *rbt_memtype_lookup(u64 addr)
+static inline struct memtype *memtype_lookup(u64 addr)
 { return NULL; }
-static inline int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos)
+static inline int memtype_copy_nth_element(struct memtype *out, loff_t pos)
 { return 0; }
 #endif
 
diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index d31ca773d4bb..47a1bf30748f 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -109,8 +109,8 @@ static int memtype_check_conflict(u64 start, u64 end,
 	return -EBUSY;
 }
 
-int rbt_memtype_check_insert(struct memtype *new,
-			     enum page_cache_mode *ret_type)
+int memtype_check_insert(struct memtype *new,
+			 enum page_cache_mode *ret_type)
 {
 	int err = 0;
 
@@ -125,13 +125,13 @@ int rbt_memtype_check_insert(struct memtype *new,
 	return 0;
 }
 
-struct memtype *rbt_memtype_erase(u64 start, u64 end)
+struct memtype *memtype_erase(u64 start, u64 end)
 {
 	struct memtype *data;
 
 	/*
 	 * Since the memtype_rbroot tree allows overlapping ranges,
-	 * rbt_memtype_erase() checks with EXACT_MATCH first, i.e. free
+	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
 	 * a whole node for the munmap case.  If no such entry is found,
 	 * it then checks with END_MATCH, i.e. shrink the size of a node
 	 * from the end for the mremap case.
@@ -157,14 +157,14 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 	return data;
 }
 
-struct memtype *rbt_memtype_lookup(u64 addr)
+struct memtype *memtype_lookup(u64 addr)
 {
 	return memtype_interval_iter_first(&memtype_rbroot, addr,
 					   addr + PAGE_SIZE);
 }
 
 #if defined(CONFIG_DEBUG_FS)
-int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos)
+int memtype_copy_nth_element(struct memtype *out, loff_t pos)
 {
 	struct memtype *match;
 	int i = 1;
-- 
2.16.4

