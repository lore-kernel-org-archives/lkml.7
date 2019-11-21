Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC17C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F95A20692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKUQm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:42:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKUQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:42:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpXR-0000LT-Oq; Thu, 21 Nov 2019 17:42:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 67C311C1A37;
        Thu, 21 Nov 2019 17:42:37 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:42:37 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Drop the rbt_ prefix from external memtype calls
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bp@alien8.de,
        dave@stgolabs.net, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121011601.20611-4-dave@stgolabs.net>
References: <20191121011601.20611-4-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157435455726.21853.17025797802870973927.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     010ca1041da3d0384fbcbaf4e4f92203c8ea9b7b
Gitweb:        https://git.kernel.org/tip/010ca1041da3d0384fbcbaf4e4f92203c8ea9b7b
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Wed, 20 Nov 2019 17:16:00 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 17:37:31 +01:00

x86/mm/pat: Drop the rbt_ prefix from external memtype calls

Drop the rbt_memtype_*() call rbt_ prefix, as we no longer use
an rbtree directly.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: bp@alien8.de
Cc: dave@stgolabs.net
Link: https://lkml.kernel.org/r/20191121011601.20611-4-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat.c          |  8 ++++----
 arch/x86/mm/pat_internal.h | 20 ++++++++++----------
 arch/x86/mm/pat_rbtree.c   | 12 ++++++------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index d9fbd4f..2d758e1 100644
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
index eeb5cae..79a0668 100644
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
index d31ca77..47a1bf3 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -109,8 +109,8 @@ failure:
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
