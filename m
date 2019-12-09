Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DFCC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272102080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/M9RkzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLIQCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:02:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42624 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbfLIQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575907337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=G0wsgIMIPlT7fgg5CfzViWGKWyRiLFZ+Z+F8U8LummQ=;
        b=a/M9RkzPMdcqvNzxcCangDZRRFzfEPwzokF4ATILz1dZPNA7gp4Y0IjYFi3OOKV5iSfbP/
        0Rr2IxhfLahfu5u96LxAv7PF9pFFlJkbuToR1ZPDW28qpD1FpfDPKfwBEfFERWOvkgEhGp
        w5wfICwoPQbVOKq5mRJSVD3GJgS0x1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-eohw8rDxMEaR1Y3IxjRoVg-1; Mon, 09 Dec 2019 11:02:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D08018557EB;
        Mon,  9 Dec 2019 16:02:12 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3FEC5DA2C;
        Mon,  9 Dec 2019 16:02:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] hugetlbfs: Disable IRQ when taking hugetlb_lock in set_max_huge_pages()
Date:   Mon,  9 Dec 2019 11:01:50 -0500
Message-Id: <20191209160150.18064-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: eohw8rDxMEaR1Y3IxjRoVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following lockdep splat was observed in some test runs:

[  612.388273] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  612.411273] WARNING: inconsistent lock state
[  612.432273] 4.18.0-159.el8.x86_64+debug #1 Tainted: G        W ---------=
 -  -
[  612.469273] --------------------------------
[  612.489273] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[  612.517273] swapper/30/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[  612.541273] ffffffff9acdc038 (hugetlb_lock){+.?.}, at: free_huge_page+0x=
36f/0xaa0
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
[  612.794273] hardirqs last  enabled at (691296): [<ffffffff99bb034b>] _ra=
w_spin_unlock_irqrestore+0x4b/0x60
[  612.839273] hardirqs last disabled at (691295): [<ffffffff99bb0ad2>] _ra=
w_spin_lock_irqsave+0x22/0x81
[  612.882273] softirqs last  enabled at (691284): [<ffffffff97ff0c63>] irq=
_enter+0xc3/0xe0
[  612.922273] softirqs last disabled at (691285): [<ffffffff97ff0ebe>] irq=
_exit+0x23e/0x2b0
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

Since hugetlb_lock can be taken from both process and IRQ contexts, we
need to protect the lock from nested locking by disabling IRQ before
taking it.  So for functions that are only called from the process
context, the spin_lock_irq()/spin_unlock_irq() pair is used. For
functions that may be called from both process and IRQ contexts, the
spin_lock_irqsave()/spin_unlock_irqrestore() pair is used.

For now, I am assuming that only free_huge_page() will be called from
IRQ context.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/hugetlb.c | 116 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 45 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac65bb5e38ac..f86788d384f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -59,7 +59,9 @@ static bool __initdata parsed_valid_hugepagesz =3D true;
=20
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pa=
ges,
- * free_huge_pages, and surplus_huge_pages.
+ * free_huge_pages, and surplus_huge_pages. These protected data can be
+ * accessed from both process and IRQ contexts. Therefore, the spinlock ne=
eds
+ * to be protected with IRQ disabled to prevent nested locking.
  */
 DEFINE_SPINLOCK(hugetlb_lock);
=20
@@ -70,6 +72,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
 static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
=20
+/*
+ * Check to make sure that IRQ is enabled before calling spin_lock_irq()
+ * so that after a matching spin_unlock_irq() the system won't be in an
+ * incorrect state.
+ */
+static __always_inline void spin_lock_irq_check(spinlock_t *lock)
+{
+=09lockdep_assert_irqs_enabled();
+=09spin_lock_irq(lock);
+}
+#ifdef spin_lock_irq
+#undef spin_lock_irq
+#endif
+#define spin_lock_irq(lock)=09spin_lock_irq_check(lock)
+
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
=20
@@ -1147,6 +1164,7 @@ void free_huge_page(struct page *page)
 =09struct hugepage_subpool *spool =3D
 =09=09(struct hugepage_subpool *)page_private(page);
 =09bool restore_reserve;
+=09unsigned long flags;
=20
 =09VM_BUG_ON_PAGE(page_count(page), page);
 =09VM_BUG_ON_PAGE(page_mapcount(page), page);
@@ -1175,7 +1193,7 @@ void free_huge_page(struct page *page)
 =09=09=09restore_reserve =3D true;
 =09}
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irqsave(&hugetlb_lock, flags);
 =09clear_page_huge_active(page);
 =09hugetlb_cgroup_uncharge_page(hstate_index(h),
 =09=09=09=09     pages_per_huge_page(h), page);
@@ -1196,18 +1214,18 @@ void free_huge_page(struct page *page)
 =09=09arch_clear_hugepage_flags(page);
 =09=09enqueue_huge_page(h, page);
 =09}
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irqrestore(&hugetlb_lock, flags);
 }
=20
 static void prep_new_huge_page(struct hstate *h, struct page *page, int ni=
d)
 {
 =09INIT_LIST_HEAD(&page->lru);
 =09set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09set_hugetlb_cgroup(page, NULL);
 =09h->nr_huge_pages++;
 =09h->nr_huge_pages_node[nid]++;
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
 }
=20
 static void prep_compound_gigantic_page(struct page *page, unsigned int or=
der)
@@ -1438,7 +1456,7 @@ int dissolve_free_huge_page(struct page *page)
 =09if (!PageHuge(page))
 =09=09return 0;
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09if (!PageHuge(page)) {
 =09=09rc =3D 0;
 =09=09goto out;
@@ -1466,7 +1484,7 @@ int dissolve_free_huge_page(struct page *page)
 =09=09rc =3D 0;
 =09}
 out:
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
 =09return rc;
 }
=20
@@ -1508,16 +1526,16 @@ static struct page *alloc_surplus_huge_page(struct =
hstate *h, gfp_t gfp_mask,
 =09if (hstate_is_gigantic(h))
 =09=09return NULL;
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09if (h->surplus_huge_pages >=3D h->nr_overcommit_huge_pages)
 =09=09goto out_unlock;
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
=20
 =09page =3D alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 =09if (!page)
 =09=09return NULL;
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09/*
 =09 * We could have raced with the pool size change.
 =09 * Double check that and simply deallocate the new page
@@ -1527,7 +1545,7 @@ static struct page *alloc_surplus_huge_page(struct hs=
tate *h, gfp_t gfp_mask,
 =09 */
 =09if (h->surplus_huge_pages >=3D h->nr_overcommit_huge_pages) {
 =09=09SetPageHugeTemporary(page);
-=09=09spin_unlock(&hugetlb_lock);
+=09=09spin_unlock_irq(&hugetlb_lock);
 =09=09put_page(page);
 =09=09return NULL;
 =09} else {
@@ -1536,7 +1554,7 @@ static struct page *alloc_surplus_huge_page(struct hs=
tate *h, gfp_t gfp_mask,
 =09}
=20
 out_unlock:
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
=20
 =09return page;
 }
@@ -1591,10 +1609,10 @@ struct page *alloc_huge_page_node(struct hstate *h,=
 int nid)
 =09if (nid !=3D NUMA_NO_NODE)
 =09=09gfp_mask |=3D __GFP_THISNODE;
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09if (h->free_huge_pages - h->resv_huge_pages > 0)
 =09=09page =3D dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
=20
 =09if (!page)
 =09=09page =3D alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
@@ -1608,17 +1626,17 @@ struct page *alloc_huge_page_nodemask(struct hstate=
 *h, int preferred_nid,
 {
 =09gfp_t gfp_mask =3D htlb_alloc_mask(h);
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09if (h->free_huge_pages - h->resv_huge_pages > 0) {
 =09=09struct page *page;
=20
 =09=09page =3D dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmas=
k);
 =09=09if (page) {
-=09=09=09spin_unlock(&hugetlb_lock);
+=09=09=09spin_unlock_irq(&hugetlb_lock);
 =09=09=09return page;
 =09=09}
 =09}
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
=20
 =09return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
 }
@@ -1664,7 +1682,7 @@ static int gather_surplus_pages(struct hstate *h, int=
 delta)
=20
 =09ret =3D -ENOMEM;
 retry:
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
 =09for (i =3D 0; i < needed; i++) {
 =09=09page =3D alloc_surplus_huge_page(h, htlb_alloc_mask(h),
 =09=09=09=09NUMA_NO_NODE, NULL);
@@ -1681,7 +1699,7 @@ static int gather_surplus_pages(struct hstate *h, int=
 delta)
 =09 * After retaking hugetlb_lock, we need to recalculate 'needed'
 =09 * because either resv_huge_pages or free_huge_pages may have changed.
 =09 */
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09needed =3D (h->resv_huge_pages + delta) -
 =09=09=09(h->free_huge_pages + allocated);
 =09if (needed > 0) {
@@ -1719,12 +1737,12 @@ static int gather_surplus_pages(struct hstate *h, i=
nt delta)
 =09=09enqueue_huge_page(h, page);
 =09}
 free:
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
=20
 =09/* Free unnecessary surplus pages to the buddy allocator */
 =09list_for_each_entry_safe(page, tmp, &surplus_list, lru)
 =09=09put_page(page);
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
=20
 =09return ret;
 }
@@ -1738,7 +1756,7 @@ static int gather_surplus_pages(struct hstate *h, int=
 delta)
  *    the reservation.  As many as unused_resv_pages may be freed.
  *
  * Called with hugetlb_lock held.  However, the lock could be dropped (and
- * reacquired) during calls to cond_resched_lock.  Whenever dropping the l=
ock,
+ * reacquired) around calls to cond_resched().  Whenever dropping the lock=
,
  * we must make sure nobody else can claim pages we are in the process of
  * freeing.  Do this by ensuring resv_huge_page always is greater than the
  * number of huge pages we plan to free when dropping the lock.
@@ -1775,7 +1793,11 @@ static void return_unused_surplus_pages(struct hstat=
e *h,
 =09=09unused_resv_pages--;
 =09=09if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
 =09=09=09goto out;
-=09=09cond_resched_lock(&hugetlb_lock);
+=09=09if (need_resched()) {
+=09=09=09spin_unlock_irq(&hugetlb_lock);
+=09=09=09cond_resched();
+=09=09=09spin_lock_irq(&hugetlb_lock);
+=09=09}
 =09}
=20
 out:
@@ -1994,7 +2016,7 @@ struct page *alloc_huge_page(struct vm_area_struct *v=
ma,
 =09if (ret)
 =09=09goto out_subpool_put;
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09/*
 =09 * glb_chg is passed to indicate whether or not a page must be taken
 =09 * from the global free pool (global change).  gbl_chg =3D=3D 0 indicat=
es
@@ -2002,7 +2024,7 @@ struct page *alloc_huge_page(struct vm_area_struct *v=
ma,
 =09 */
 =09page =3D dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
 =09if (!page) {
-=09=09spin_unlock(&hugetlb_lock);
+=09=09spin_unlock_irq(&hugetlb_lock);
 =09=09page =3D alloc_buddy_huge_page_with_mpol(h, vma, addr);
 =09=09if (!page)
 =09=09=09goto out_uncharge_cgroup;
@@ -2010,12 +2032,12 @@ struct page *alloc_huge_page(struct vm_area_struct =
*vma,
 =09=09=09SetPagePrivate(page);
 =09=09=09h->resv_huge_pages--;
 =09=09}
-=09=09spin_lock(&hugetlb_lock);
+=09=09spin_lock_irq(&hugetlb_lock);
 =09=09list_move(&page->lru, &h->hugepage_activelist);
 =09=09/* Fall through */
 =09}
 =09hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
=20
 =09set_page_private(page, (unsigned long)spool);
=20
@@ -2269,7 +2291,7 @@ static int set_max_huge_pages(struct hstate *h, unsig=
ned long count, int nid,
 =09else
 =09=09return -ENOMEM;
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
=20
 =09/*
 =09 * Check for a node specific request.
@@ -2300,7 +2322,7 @@ static int set_max_huge_pages(struct hstate *h, unsig=
ned long count, int nid,
 =09 */
 =09if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
 =09=09if (count > persistent_huge_pages(h)) {
-=09=09=09spin_unlock(&hugetlb_lock);
+=09=09=09spin_unlock_irq(&hugetlb_lock);
 =09=09=09NODEMASK_FREE(node_alloc_noretry);
 =09=09=09return -EINVAL;
 =09=09}
@@ -2329,14 +2351,14 @@ static int set_max_huge_pages(struct hstate *h, uns=
igned long count, int nid,
 =09=09 * page, free_huge_page will handle it by freeing the page
 =09=09 * and reducing the surplus.
 =09=09 */
-=09=09spin_unlock(&hugetlb_lock);
+=09=09spin_unlock_irq(&hugetlb_lock);
=20
 =09=09/* yield cpu to avoid soft lockup */
 =09=09cond_resched();
=20
 =09=09ret =3D alloc_pool_huge_page(h, nodes_allowed,
 =09=09=09=09=09=09node_alloc_noretry);
-=09=09spin_lock(&hugetlb_lock);
+=09=09spin_lock_irq(&hugetlb_lock);
 =09=09if (!ret)
 =09=09=09goto out;
=20
@@ -2366,7 +2388,11 @@ static int set_max_huge_pages(struct hstate *h, unsi=
gned long count, int nid,
 =09while (min_count < persistent_huge_pages(h)) {
 =09=09if (!free_pool_huge_page(h, nodes_allowed, 0))
 =09=09=09break;
-=09=09cond_resched_lock(&hugetlb_lock);
+=09=09if (need_resched()) {
+=09=09=09spin_unlock_irq(&hugetlb_lock);
+=09=09=09cond_resched();
+=09=09=09spin_lock_irq(&hugetlb_lock);
+=09=09}
 =09}
 =09while (count < persistent_huge_pages(h)) {
 =09=09if (!adjust_pool_surplus(h, nodes_allowed, 1))
@@ -2374,7 +2400,7 @@ static int set_max_huge_pages(struct hstate *h, unsig=
ned long count, int nid,
 =09}
 out:
 =09h->max_huge_pages =3D persistent_huge_pages(h);
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
=20
 =09NODEMASK_FREE(node_alloc_noretry);
=20
@@ -2528,9 +2554,9 @@ static ssize_t nr_overcommit_hugepages_store(struct k=
object *kobj,
 =09if (err)
 =09=09return err;
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09h->nr_overcommit_huge_pages =3D input;
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
=20
 =09return count;
 }
@@ -2978,9 +3004,9 @@ int hugetlb_overcommit_handler(struct ctl_table *tabl=
e, int write,
 =09=09goto out;
=20
 =09if (write) {
-=09=09spin_lock(&hugetlb_lock);
+=09=09spin_lock_irq(&hugetlb_lock);
 =09=09h->nr_overcommit_huge_pages =3D tmp;
-=09=09spin_unlock(&hugetlb_lock);
+=09=09spin_unlock_irq(&hugetlb_lock);
 =09}
 out:
 =09return ret;
@@ -3071,7 +3097,7 @@ static int hugetlb_acct_memory(struct hstate *h, long=
 delta)
 {
 =09int ret =3D -ENOMEM;
=20
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09/*
 =09 * When cpuset is configured, it breaks the strict hugetlb page
 =09 * reservation as the accounting is done on a global variable. Such
@@ -3104,7 +3130,7 @@ static int hugetlb_acct_memory(struct hstate *h, long=
 delta)
 =09=09return_unused_surplus_pages(h, (unsigned long) -delta);
=20
 out:
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
 =09return ret;
 }
=20
@@ -4970,7 +4996,7 @@ bool isolate_huge_page(struct page *page, struct list=
_head *list)
 =09bool ret =3D true;
=20
 =09VM_BUG_ON_PAGE(!PageHead(page), page);
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09if (!page_huge_active(page) || !get_page_unless_zero(page)) {
 =09=09ret =3D false;
 =09=09goto unlock;
@@ -4978,17 +5004,17 @@ bool isolate_huge_page(struct page *page, struct li=
st_head *list)
 =09clear_page_huge_active(page);
 =09list_move_tail(&page->lru, list);
 unlock:
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
 =09return ret;
 }
=20
 void putback_active_hugepage(struct page *page)
 {
 =09VM_BUG_ON_PAGE(!PageHead(page), page);
-=09spin_lock(&hugetlb_lock);
+=09spin_lock_irq(&hugetlb_lock);
 =09set_page_huge_active(page);
 =09list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
-=09spin_unlock(&hugetlb_lock);
+=09spin_unlock_irq(&hugetlb_lock);
 =09put_page(page);
 }
=20
@@ -5016,11 +5042,11 @@ void move_hugetlb_state(struct page *oldpage, struc=
t page *newpage, int reason)
 =09=09SetPageHugeTemporary(oldpage);
 =09=09ClearPageHugeTemporary(newpage);
=20
-=09=09spin_lock(&hugetlb_lock);
+=09=09spin_lock_irq(&hugetlb_lock);
 =09=09if (h->surplus_huge_pages_node[old_nid]) {
 =09=09=09h->surplus_huge_pages_node[old_nid]--;
 =09=09=09h->surplus_huge_pages_node[new_nid]++;
 =09=09}
-=09=09spin_unlock(&hugetlb_lock);
+=09=09spin_unlock_irq(&hugetlb_lock);
 =09}
 }
--=20
2.18.1

