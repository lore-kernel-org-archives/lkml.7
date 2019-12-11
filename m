Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E049C2D0C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF631222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8/JRcd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfLKTqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:46:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728690AbfLKTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576093600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=3qY336YVhOisKsBhjzpuV+5gUAxhMyqDZ4hKcxoTLL0=;
        b=E8/JRcd7xq3jfRPKHydCfBSTziHvmhFng0tAxXUHe+4hPojOtT2gwS0V3ChQUEhlQkhk59
        tztJu6xXpZGDE/NchJ76NaYbxPrn9z9Ni05HHvwwZDq5q6UGV5ZfjNH6PrvDACHQ8HW/PF
        y7vYaQdncuKToZnsm5P97eUg6xMMAeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-W71ovQ7RPBCGghd1FlsSUA-1; Wed, 11 Dec 2019 14:46:37 -0500
X-MC-Unique: W71ovQ7RPBCGghd1FlsSUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C524D101355C;
        Wed, 11 Dec 2019 19:46:35 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C9995C1C3;
        Wed, 11 Dec 2019 19:46:32 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] hugetlbfs: Disable softIRQ when taking hugetlb_lock
Date:   Wed, 11 Dec 2019 14:46:15 -0500
Message-Id: <20191211194615.18502-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following lockdep splat was observed when a certain hugetlbfs test
was run:

[  612.388273] ================================
[  612.411273] WARNING: inconsistent lock state
[  612.432273] 4.18.0-159.el8.x86_64+debug #1 Tainted: G        W --------- -  -
[  612.469273] --------------------------------
[  612.489273] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[  612.517273] swapper/30/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[  612.541273] ffffffff9acdc038 (hugetlb_lock){+.?.}, at: free_huge_page+0x36f/0xaa0
[  612.576273] {SOFTIRQ-ON-W} state was registered at:
[  612.598273]   lock_acquire+0x14f/0x3b0
[  612.616273]   _raw_spin_lock+0x30/0x70
[  612.634273]   __nr_hugepages_store_common+0x11b/0xb30
[  612.657273]   hugetlb_sysctl_handler_common+0x209/0x2d0
[  612.681273]   proc_sys_call_handler+0x37f/0x450
[  612.703273]   vfs_write+0x157/0x460
[  612.719273]   ksys_write+0xb8/0x170
[  612.736273]   do_syscall_64+0xa5/0x4d0
[  612.753273]   entry_SYSCALL_64_after_hwframe+0x6a/0xdf
[  612.777273] irq event stamp: 691296
[  612.794273] hardirqs last  enabled at (691296): [<ffffffff99bb034b>] _raw_spin_unlock_irqrestore+0x4b/0x60
[  612.839273] hardirqs last disabled at (691295): [<ffffffff99bb0ad2>] _raw_spin_lock_irqsave+0x22/0x81
[  612.882273] softirqs last  enabled at (691284): [<ffffffff97ff0c63>] irq_enter+0xc3/0xe0
[  612.922273] softirqs last disabled at (691285): [<ffffffff97ff0ebe>] irq_exit+0x23e/0x2b0
[  612.962273]
[  612.962273] other info that might help us debug this:
[  612.993273]  Possible unsafe locking scenario:
[  612.993273]
[  613.020273]        CPU0
[  613.031273]        ----
[  613.042273]   lock(hugetlb_lock);
[  613.057273]   <Interrupt>
[  613.069273]     lock(hugetlb_lock);
[  613.085273]
[  613.085273]  *** DEADLOCK ***
      :
[  613.245273] Call Trace:
[  613.256273]  <IRQ>
[  613.265273]  dump_stack+0x9a/0xf0
[  613.281273]  mark_lock+0xd0c/0x12f0
[  613.297273]  ? print_shortest_lock_dependencies+0x80/0x80
[  613.322273]  ? sched_clock_cpu+0x18/0x1e0
[  613.341273]  __lock_acquire+0x146b/0x48c0
[  613.360273]  ? trace_hardirqs_on+0x10/0x10
[  613.379273]  ? trace_hardirqs_on_caller+0x27b/0x580
[  613.401273]  lock_acquire+0x14f/0x3b0
[  613.419273]  ? free_huge_page+0x36f/0xaa0
[  613.440273]  _raw_spin_lock+0x30/0x70
[  613.458273]  ? free_huge_page+0x36f/0xaa0
[  613.477273]  free_huge_page+0x36f/0xaa0
[  613.495273]  bio_check_pages_dirty+0x2fc/0x5c0
[  613.516273]  clone_endio+0x17f/0x670 [dm_mod]
[  613.536273]  ? disable_discard+0x90/0x90 [dm_mod]
[  613.558273]  ? bio_endio+0x4ba/0x930
[  613.575273]  ? blk_account_io_completion+0x400/0x530
[  613.598273]  blk_update_request+0x276/0xe50
[  613.617273]  scsi_end_request+0x7b/0x6a0
[  613.636273]  ? lock_downgrade+0x6f0/0x6f0
[  613.654273]  scsi_io_completion+0x1c6/0x1570
[  613.674273]  ? sd_completed_bytes+0x3a0/0x3a0 [sd_mod]
[  613.698273]  ? scsi_mq_requeue_cmd+0xc0/0xc0
[  613.718273]  blk_done_softirq+0x22e/0x350
[  613.737273]  ? blk_softirq_cpu_dead+0x230/0x230
[  613.758273]  __do_softirq+0x23d/0xad8
[  613.776273]  irq_exit+0x23e/0x2b0
[  613.792273]  do_IRQ+0x11a/0x200
[  613.806273]  common_interrupt+0xf/0xf
[  613.823273]  </IRQ>

Since hugetlb_lock can be taken from both process and softIRQ contexts,
we need to protect the lock from nested locking by disabling softIRQ
using spin_lock_bh() before taking it.

Currently, only free_huge_page() is known to be called from softIRQ
context.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/hugetlb.c | 100 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac65bb5e38ac..5426f59683d9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -59,7 +59,9 @@ static bool __initdata parsed_valid_hugepagesz = true;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
- * free_huge_pages, and surplus_huge_pages.
+ * free_huge_pages, and surplus_huge_pages. These protected data can be
+ * accessed from both process and softIRQ contexts. Therefore, the spinlock
+ * needs to be acquired with softIRQ disabled to prevent nested locking.
  */
 DEFINE_SPINLOCK(hugetlb_lock);
 
@@ -1175,7 +1177,7 @@ void free_huge_page(struct page *page)
 			restore_reserve = true;
 	}
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
@@ -1196,18 +1198,18 @@ void free_huge_page(struct page *page)
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
 	}
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 }
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	set_hugetlb_cgroup(page, NULL);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 }
 
 static void prep_compound_gigantic_page(struct page *page, unsigned int order)
@@ -1438,7 +1440,7 @@ int dissolve_free_huge_page(struct page *page)
 	if (!PageHuge(page))
 		return 0;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	if (!PageHuge(page)) {
 		rc = 0;
 		goto out;
@@ -1466,7 +1468,7 @@ int dissolve_free_huge_page(struct page *page)
 		rc = 0;
 	}
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 	return rc;
 }
 
@@ -1508,16 +1510,16 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
 		goto out_unlock;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	/*
 	 * We could have raced with the pool size change.
 	 * Double check that and simply deallocate the new page
@@ -1527,7 +1529,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		SetPageHugeTemporary(page);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_bh(&hugetlb_lock);
 		put_page(page);
 		return NULL;
 	} else {
@@ -1536,7 +1538,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	}
 
 out_unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 
 	return page;
 }
@@ -1591,10 +1593,10 @@ struct page *alloc_huge_page_node(struct hstate *h, int nid)
 	if (nid != NUMA_NO_NODE)
 		gfp_mask |= __GFP_THISNODE;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0)
 		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 
 	if (!page)
 		page = alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
@@ -1608,17 +1610,17 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
 
 		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
 		if (page) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_bh(&hugetlb_lock);
 			return page;
 		}
 	}
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 
 	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
 }
@@ -1664,7 +1666,7 @@ static int gather_surplus_pages(struct hstate *h, int delta)
 
 	ret = -ENOMEM;
 retry:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
 				NUMA_NO_NODE, NULL);
@@ -1681,7 +1683,7 @@ static int gather_surplus_pages(struct hstate *h, int delta)
 	 * After retaking hugetlb_lock, we need to recalculate 'needed'
 	 * because either resv_huge_pages or free_huge_pages may have changed.
 	 */
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) -
 			(h->free_huge_pages + allocated);
 	if (needed > 0) {
@@ -1719,12 +1721,12 @@ static int gather_surplus_pages(struct hstate *h, int delta)
 		enqueue_huge_page(h, page);
 	}
 free:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 
 	/* Free unnecessary surplus pages to the buddy allocator */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru)
 		put_page(page);
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 
 	return ret;
 }
@@ -1738,7 +1740,7 @@ static int gather_surplus_pages(struct hstate *h, int delta)
  *    the reservation.  As many as unused_resv_pages may be freed.
  *
  * Called with hugetlb_lock held.  However, the lock could be dropped (and
- * reacquired) during calls to cond_resched_lock.  Whenever dropping the lock,
+ * reacquired) around calls to cond_resched().  Whenever dropping the lock,
  * we must make sure nobody else can claim pages we are in the process of
  * freeing.  Do this by ensuring resv_huge_page always is greater than the
  * number of huge pages we plan to free when dropping the lock.
@@ -1775,7 +1777,11 @@ static void return_unused_surplus_pages(struct hstate *h,
 		unused_resv_pages--;
 		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
 			goto out;
-		cond_resched_lock(&hugetlb_lock);
+		if (need_resched()) {
+			spin_unlock_bh(&hugetlb_lock);
+			cond_resched();
+			spin_lock_bh(&hugetlb_lock);
+		}
 	}
 
 out:
@@ -1994,7 +2000,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (ret)
 		goto out_subpool_put;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	/*
 	 * glb_chg is passed to indicate whether or not a page must be taken
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
@@ -2002,7 +2008,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
 	if (!page) {
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_bh(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
 		if (!page)
 			goto out_uncharge_cgroup;
@@ -2010,12 +2016,12 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			SetPagePrivate(page);
 			h->resv_huge_pages--;
 		}
-		spin_lock(&hugetlb_lock);
+		spin_lock_bh(&hugetlb_lock);
 		list_move(&page->lru, &h->hugepage_activelist);
 		/* Fall through */
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 
 	set_page_private(page, (unsigned long)spool);
 
@@ -2269,7 +2275,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	else
 		return -ENOMEM;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 
 	/*
 	 * Check for a node specific request.
@@ -2300,7 +2306,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 */
 	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 		if (count > persistent_huge_pages(h)) {
-			spin_unlock(&hugetlb_lock);
+			spin_unlock_bh(&hugetlb_lock);
 			NODEMASK_FREE(node_alloc_noretry);
 			return -EINVAL;
 		}
@@ -2329,14 +2335,14 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		 * page, free_huge_page will handle it by freeing the page
 		 * and reducing the surplus.
 		 */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_bh(&hugetlb_lock);
 
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
 		ret = alloc_pool_huge_page(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock(&hugetlb_lock);
+		spin_lock_bh(&hugetlb_lock);
 		if (!ret)
 			goto out;
 
@@ -2366,7 +2372,11 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	while (min_count < persistent_huge_pages(h)) {
 		if (!free_pool_huge_page(h, nodes_allowed, 0))
 			break;
-		cond_resched_lock(&hugetlb_lock);
+		if (need_resched()) {
+			spin_unlock_bh(&hugetlb_lock);
+			cond_resched();
+			spin_lock_bh(&hugetlb_lock);
+		}
 	}
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
@@ -2374,7 +2384,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 out:
 	h->max_huge_pages = persistent_huge_pages(h);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 
 	NODEMASK_FREE(node_alloc_noretry);
 
@@ -2528,9 +2538,9 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
 	if (err)
 		return err;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	h->nr_overcommit_huge_pages = input;
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 
 	return count;
 }
@@ -2978,9 +2988,9 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 		goto out;
 
 	if (write) {
-		spin_lock(&hugetlb_lock);
+		spin_lock_bh(&hugetlb_lock);
 		h->nr_overcommit_huge_pages = tmp;
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_bh(&hugetlb_lock);
 	}
 out:
 	return ret;
@@ -3071,7 +3081,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 {
 	int ret = -ENOMEM;
 
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	/*
 	 * When cpuset is configured, it breaks the strict hugetlb page
 	 * reservation as the accounting is done on a global variable. Such
@@ -3104,7 +3114,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 		return_unused_surplus_pages(h, (unsigned long) -delta);
 
 out:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 	return ret;
 }
 
@@ -4970,7 +4980,7 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	bool ret = true;
 
 	VM_BUG_ON_PAGE(!PageHead(page), page);
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	if (!page_huge_active(page) || !get_page_unless_zero(page)) {
 		ret = false;
 		goto unlock;
@@ -4978,17 +4988,17 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
 	clear_page_huge_active(page);
 	list_move_tail(&page->lru, list);
 unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 	return ret;
 }
 
 void putback_active_hugepage(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
-	spin_lock(&hugetlb_lock);
+	spin_lock_bh(&hugetlb_lock);
 	set_page_huge_active(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_bh(&hugetlb_lock);
 	put_page(page);
 }
 
@@ -5016,11 +5026,11 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		SetPageHugeTemporary(oldpage);
 		ClearPageHugeTemporary(newpage);
 
-		spin_lock(&hugetlb_lock);
+		spin_lock_bh(&hugetlb_lock);
 		if (h->surplus_huge_pages_node[old_nid]) {
 			h->surplus_huge_pages_node[old_nid]--;
 			h->surplus_huge_pages_node[new_nid]++;
 		}
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_bh(&hugetlb_lock);
 	}
 }
-- 
2.18.1

