Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B9AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786ED215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nfiK4W2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfD2Sis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:38:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfD2Sir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:38:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIbf101027990
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:37:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIbf101027990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563062;
        bh=1SHLuuQfds0mGex1OZdTijSPXcEYvkDHcvAPyq943u0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nfiK4W2p8Ymj9TeDG5QKbEKulUduXGVb42q2XtEFyhZIfRr3A+GlbYH8jNVhWzNZA
         /ndUu+ywMb2iAENMNrhUnEAFACyO7V5DZ1V9Qtin3bOxxjR0/vCLzjlSkN0sfgt6Bn
         MjHctneEpyzDVtiNbgOvAtbYxWacOvavdDwHZuGr7uQRJbjM5NWJ+bP2HIPBrY7uiN
         +Ph71V53diBjZyERYPEmwiuGXKf5jriAxztvKINfsKBp1JHAJaQxzcvXNApB6cStjE
         pM9+pYLwhHwO2T+SW3xwTST/3MWcVWobZ8qIQs8YFfr/PYTar9j1rYp2nIYmGYgWG0
         6H24SaUsmslfA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIbe0c1027987;
        Mon, 29 Apr 2019 11:37:40 -0700
Date:   Mon, 29 Apr 2019 11:37:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-af52bf6b92f7d8783c1e712cad6ef7d37cd773b2@git.kernel.org>
Cc:     agk@redhat.com, tglx@linutronix.de, penberg@kernel.org,
        jthumshirn@suse.de, jpoimboe@redhat.com, dsterba@suse.com,
        snitzer@redhat.com, glider@google.com, rodrigo.vivi@intel.com,
        mbenes@suse.cz, akpm@linux-foundation.org, robin.murphy@arm.com,
        rppt@linux.vnet.ibm.com, adobriyan@gmail.com, clm@fb.com,
        rostedt@goodmis.org, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, josef@toxicpanda.com,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        jani.nikula@linux.intel.com, catalin.marinas@arm.com,
        m.szyprowski@samsung.com, cl@linux.com, dvyukov@google.com,
        hch@lst.de, mingo@kernel.org, aryabinin@virtuozzo.com,
        daniel@ffwll.ch, luto@kernel.org, tom.zanussi@linux.intel.com,
        rientjes@google.com, hpa@zytor.com, akinobu.mita@gmail.com
Reply-To: maarten.lankhorst@linux.intel.com, josef@toxicpanda.com,
          joonas.lahtinen@linux.intel.com, airlied@linux.ie,
          jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
          cl@linux.com, dvyukov@google.com, hch@lst.de, mingo@kernel.org,
          m.szyprowski@samsung.com, catalin.marinas@arm.com,
          rientjes@google.com, hpa@zytor.com, akinobu.mita@gmail.com,
          aryabinin@virtuozzo.com, daniel@ffwll.ch,
          tom.zanussi@linux.intel.com, luto@kernel.org, agk@redhat.com,
          glider@google.com, rodrigo.vivi@intel.com, penberg@kernel.org,
          tglx@linutronix.de, jpoimboe@redhat.com, jthumshirn@suse.de,
          snitzer@redhat.com, dsterba@suse.com, akpm@linux-foundation.org,
          mbenes@suse.cz, clm@fb.com, rostedt@goodmis.org,
          robin.murphy@arm.com, rppt@linux.vnet.ibm.com,
          adobriyan@gmail.com
In-Reply-To: <20190425094802.067210525@linutronix.de>
References: <20190425094802.067210525@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] mm/page_owner: Simplify stack trace handling
Git-Commit-ID: af52bf6b92f7d8783c1e712cad6ef7d37cd773b2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  af52bf6b92f7d8783c1e712cad6ef7d37cd773b2
Gitweb:     https://git.kernel.org/tip/af52bf6b92f7d8783c1e712cad6ef7d37cd773b2
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:03 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:50 +0200

mm/page_owner: Simplify stack trace handling

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

The original code in all printing functions is really wrong. It allocates a
storage array on stack which is unused because depot_fetch_stack() does not
store anything in it. It overwrites the entries pointer in the stack_trace
struct so it points to the depot storage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-mm@kvack.org
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094802.067210525@linutronix.de

---
 mm/page_owner.c | 79 ++++++++++++++++++++-------------------------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index df277e6bc3c6..addcbb2ae4e4 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -58,15 +58,10 @@ static bool need_page_owner(void)
 static __always_inline depot_stack_handle_t create_dummy_stack(void)
 {
 	unsigned long entries[4];
-	struct stack_trace dummy;
+	unsigned int nr_entries;
 
-	dummy.nr_entries = 0;
-	dummy.max_entries = ARRAY_SIZE(entries);
-	dummy.entries = &entries[0];
-	dummy.skip = 0;
-
-	save_stack_trace(&dummy);
-	return depot_save_stack(&dummy, GFP_KERNEL);
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	return stack_depot_save(entries, nr_entries, GFP_KERNEL);
 }
 
 static noinline void register_dummy_stack(void)
@@ -120,46 +115,39 @@ void __reset_page_owner(struct page *page, unsigned int order)
 	}
 }
 
-static inline bool check_recursive_alloc(struct stack_trace *trace,
-					unsigned long ip)
+static inline bool check_recursive_alloc(unsigned long *entries,
+					 unsigned int nr_entries,
+					 unsigned long ip)
 {
-	int i;
-
-	if (!trace->nr_entries)
-		return false;
+	unsigned int i;
 
-	for (i = 0; i < trace->nr_entries; i++) {
-		if (trace->entries[i] == ip)
+	for (i = 0; i < nr_entries; i++) {
+		if (entries[i] == ip)
 			return true;
 	}
-
 	return false;
 }
 
 static noinline depot_stack_handle_t save_stack(gfp_t flags)
 {
 	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.entries = entries,
-		.max_entries = PAGE_OWNER_STACK_DEPTH,
-		.skip = 2
-	};
 	depot_stack_handle_t handle;
+	unsigned int nr_entries;
 
-	save_stack_trace(&trace);
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
 
 	/*
-	 * We need to check recursion here because our request to stackdepot
-	 * could trigger memory allocation to save new entry. New memory
-	 * allocation would reach here and call depot_save_stack() again
-	 * if we don't catch it. There is still not enough memory in stackdepot
-	 * so it would try to allocate memory again and loop forever.
+	 * We need to check recursion here because our request to
+	 * stackdepot could trigger memory allocation to save new
+	 * entry. New memory allocation would reach here and call
+	 * stack_depot_save_entries() again if we don't catch it. There is
+	 * still not enough memory in stackdepot so it would try to
+	 * allocate memory again and loop forever.
 	 */
-	if (check_recursive_alloc(&trace, _RET_IP_))
+	if (check_recursive_alloc(entries, nr_entries, _RET_IP_))
 		return dummy_handle;
 
-	handle = depot_save_stack(&trace, flags);
+	handle = stack_depot_save(entries, nr_entries, flags);
 	if (!handle)
 		handle = failure_handle;
 
@@ -337,16 +325,10 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		struct page *page, struct page_owner *page_owner,
 		depot_stack_handle_t handle)
 {
-	int ret;
-	int pageblock_mt, page_mt;
+	int ret, pageblock_mt, page_mt;
+	unsigned long *entries;
+	unsigned int nr_entries;
 	char *kbuf;
-	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.entries = entries,
-		.max_entries = PAGE_OWNER_STACK_DEPTH,
-		.skip = 0
-	};
 
 	count = min_t(size_t, count, PAGE_SIZE);
 	kbuf = kmalloc(count, GFP_KERNEL);
@@ -375,8 +357,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	if (ret >= count)
 		goto err;
 
-	depot_fetch_stack(handle, &trace);
-	ret += snprint_stack_trace(kbuf + ret, count - ret, &trace, 0);
+	nr_entries = stack_depot_fetch(handle, &entries);
+	ret += stack_trace_snprint(kbuf + ret, count - ret, entries, nr_entries, 0);
 	if (ret >= count)
 		goto err;
 
@@ -407,14 +389,9 @@ void __dump_page_owner(struct page *page)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
-	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.entries = entries,
-		.max_entries = PAGE_OWNER_STACK_DEPTH,
-		.skip = 0
-	};
 	depot_stack_handle_t handle;
+	unsigned long *entries;
+	unsigned int nr_entries;
 	gfp_t gfp_mask;
 	int mt;
 
@@ -438,10 +415,10 @@ void __dump_page_owner(struct page *page)
 		return;
 	}
 
-	depot_fetch_stack(handle, &trace);
+	nr_entries = stack_depot_fetch(handle, &entries);
 	pr_alert("page allocated via order %u, migratetype %s, gfp_mask %#x(%pGg)\n",
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask);
-	print_stack_trace(&trace, 0);
+	stack_trace_print(entries, nr_entries, 0);
 
 	if (page_owner->last_migrate_reason != -1)
 		pr_alert("page has been migrated, last migrate reason: %s\n",
