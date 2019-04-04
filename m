Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24902C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDE421741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368947;
	bh=v1JWyMz69OxujyG4U1guruq2csrHE4AjGP5+MWe8xnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XDqyvJMoEKrfkMKfApT262fxIxFUleSmiChQoeACO6pwa5MRi+V2yHVgNGOCdhExd
	 MHZ09nNsBLNwNImLs8pJ69boMn5g6MiohU8OOULJ35qX/W5Kw3Y7ry3CUImipUmZ0m
	 9pB27429c9AzKGQMTHTrQ/TBzqHYWiT0Cs4+hGtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbfDDJJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732742AbfDDJJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2568D214AF;
        Thu,  4 Apr 2019 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368938;
        bh=v1JWyMz69OxujyG4U1guruq2csrHE4AjGP5+MWe8xnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CrEX1P0www3YxqKFoev44Z4mpbwhj1tbVZXDAA5D+LUi5OcWXD45Ep+xMvnqWWGj
         P6wSLZVCQzAYwt3ZgYwFfoMyYLeUtUPsJ815sNDP6YO7PtsZ6kpOB8XYJX5OlnGz2k
         U0751oLV75+qHME31rCFU/c5lsUOQA7eq6ume5s0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Shaohua Li <shli@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 029/246] mm, swap: bounds check swap_info array accesses to avoid NULL derefs
Date:   Thu,  4 Apr 2019 10:45:29 +0200
Message-Id: <20190404084620.119040653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

[ Upstream commit c10d38cc8d3e43f946b6c2bf4602c86791587f30 ]

Dan Carpenter reports a potential NULL dereference in
get_swap_page_of_type:

  Smatch complains that the NULL checks on "si" aren't consistent.  This
  seems like a real bug because we have not ensured that the type is
  valid and so "si" can be NULL.

Add the missing check for NULL, taking care to use a read barrier to
ensure CPU1 observes CPU0's updates in the correct order:

     CPU0                           CPU1
     alloc_swap_info()              if (type >= nr_swapfiles)
       swap_info[type] = p              /* handle invalid entry */
       smp_wmb()                    smp_rmb()
       ++nr_swapfiles               p = swap_info[type]

Without smp_rmb, CPU1 might observe CPU0's write to nr_swapfiles before
CPU0's write to swap_info[type] and read NULL from swap_info[type].

Ying Huang noticed other places in swapfile.c don't order these reads
properly.  Introduce swap_type_to_swap_info to encourage correct usage.

Use READ_ONCE and WRITE_ONCE to follow the Linux Kernel Memory Model
(see tools/memory-model/Documentation/explanation.txt).

This ordering need not be enforced in places where swap_lock is held
(e.g.  si_swapinfo) because swap_lock serializes updates to nr_swapfiles
and the swap_info array.

Link: http://lkml.kernel.org/r/20190131024410.29859-1-daniel.m.jordan@oracle.com
Fixes: ec8acf20afb8 ("swap: add per-partition lock for swapfile")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Shaohua Li <shli@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swapfile.c | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index dbac1d49469d..67f60e051814 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -98,6 +98,15 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
 
 atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
+static struct swap_info_struct *swap_type_to_swap_info(int type)
+{
+	if (type >= READ_ONCE(nr_swapfiles))
+		return NULL;
+
+	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
+	return READ_ONCE(swap_info[type]);
+}
+
 static inline unsigned char swap_count(unsigned char ent)
 {
 	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
@@ -1044,12 +1053,14 @@ noswap:
 /* The only caller of this function is now suspend routine */
 swp_entry_t get_swap_page_of_type(int type)
 {
-	struct swap_info_struct *si;
+	struct swap_info_struct *si = swap_type_to_swap_info(type);
 	pgoff_t offset;
 
-	si = swap_info[type];
+	if (!si)
+		goto fail;
+
 	spin_lock(&si->lock);
-	if (si && (si->flags & SWP_WRITEOK)) {
+	if (si->flags & SWP_WRITEOK) {
 		atomic_long_dec(&nr_swap_pages);
 		/* This is called for allocating swap entry, not cache */
 		offset = scan_swap_map(si, 1);
@@ -1060,6 +1071,7 @@ swp_entry_t get_swap_page_of_type(int type)
 		atomic_long_inc(&nr_swap_pages);
 	}
 	spin_unlock(&si->lock);
+fail:
 	return (swp_entry_t) {0};
 }
 
@@ -1071,9 +1083,9 @@ static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
 	if (!entry.val)
 		goto out;
 	type = swp_type(entry);
-	if (type >= nr_swapfiles)
+	p = swap_type_to_swap_info(type);
+	if (!p)
 		goto bad_nofile;
-	p = swap_info[type];
 	if (!(p->flags & SWP_USED))
 		goto bad_device;
 	offset = swp_offset(entry);
@@ -1697,10 +1709,9 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
 sector_t swapdev_block(int type, pgoff_t offset)
 {
 	struct block_device *bdev;
+	struct swap_info_struct *si = swap_type_to_swap_info(type);
 
-	if ((unsigned int)type >= nr_swapfiles)
-		return 0;
-	if (!(swap_info[type]->flags & SWP_WRITEOK))
+	if (!si || !(si->flags & SWP_WRITEOK))
 		return 0;
 	return map_swap_entry(swp_entry(type, offset), &bdev);
 }
@@ -2258,7 +2269,7 @@ static sector_t map_swap_entry(swp_entry_t entry, struct block_device **bdev)
 	struct swap_extent *se;
 	pgoff_t offset;
 
-	sis = swap_info[swp_type(entry)];
+	sis = swp_swap_info(entry);
 	*bdev = sis->bdev;
 
 	offset = swp_offset(entry);
@@ -2700,9 +2711,7 @@ static void *swap_start(struct seq_file *swap, loff_t *pos)
 	if (!l)
 		return SEQ_START_TOKEN;
 
-	for (type = 0; type < nr_swapfiles; type++) {
-		smp_rmb();	/* read nr_swapfiles before swap_info[type] */
-		si = swap_info[type];
+	for (type = 0; (si = swap_type_to_swap_info(type)); type++) {
 		if (!(si->flags & SWP_USED) || !si->swap_map)
 			continue;
 		if (!--l)
@@ -2722,9 +2731,7 @@ static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 	else
 		type = si->type + 1;
 
-	for (; type < nr_swapfiles; type++) {
-		smp_rmb();	/* read nr_swapfiles before swap_info[type] */
-		si = swap_info[type];
+	for (; (si = swap_type_to_swap_info(type)); type++) {
 		if (!(si->flags & SWP_USED) || !si->swap_map)
 			continue;
 		++*pos;
@@ -2831,14 +2838,14 @@ static struct swap_info_struct *alloc_swap_info(void)
 	}
 	if (type >= nr_swapfiles) {
 		p->type = type;
-		swap_info[type] = p;
+		WRITE_ONCE(swap_info[type], p);
 		/*
 		 * Write swap_info[type] before nr_swapfiles, in case a
 		 * racing procfs swap_start() or swap_next() is reading them.
 		 * (We never shrink nr_swapfiles, we never free this entry.)
 		 */
 		smp_wmb();
-		nr_swapfiles++;
+		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
 	} else {
 		kvfree(p);
 		p = swap_info[type];
@@ -3358,7 +3365,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 {
 	struct swap_info_struct *p;
 	struct swap_cluster_info *ci;
-	unsigned long offset, type;
+	unsigned long offset;
 	unsigned char count;
 	unsigned char has_cache;
 	int err = -EINVAL;
@@ -3366,10 +3373,10 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	if (non_swap_entry(entry))
 		goto out;
 
-	type = swp_type(entry);
-	if (type >= nr_swapfiles)
+	p = swp_swap_info(entry);
+	if (!p)
 		goto bad_file;
-	p = swap_info[type];
+
 	offset = swp_offset(entry);
 	if (unlikely(offset >= p->max))
 		goto out;
@@ -3466,7 +3473,7 @@ int swapcache_prepare(swp_entry_t entry)
 
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 {
-	return swap_info[swp_type(entry)];
+	return swap_type_to_swap_info(swp_type(entry));
 }
 
 struct swap_info_struct *page_swap_info(struct page *page)
-- 
2.19.1



