Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF59620836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688288;
	bh=Dc4UR5uurJutB3hgFpbHcaeFw8XIZEiiGVPRTEpLfyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+D/GsiOLSKGikhy0NDZNnF9ZsbyBuEsgAxYv7T3ek1aaH2frDkqXr94KvpbZoxBZ
	 VjoZ9HpjLb/5YEloBdc8XWpHsmEUniO/wM/qtd6wbkE/ZOw1lAMUArbcUQqvnYWjLH
	 AyQflPLXoBl5sthiY+U26vR2QZ/zMyDyiSblKAUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfCDIb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbfCDIbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:31:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2203208E4;
        Mon,  4 Mar 2019 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688282;
        bh=Dc4UR5uurJutB3hgFpbHcaeFw8XIZEiiGVPRTEpLfyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PtRWveKUFWJMnyBisFL3Owg/60qTwJgzkTrEHO0E2LuT5n8ddyh8XCba17WfjlUUE
         GalqDBE6BXhy75C0WHIfW8ubdA/Jy//eCokKPM0832raUhUhiEqC2dQ6KJWsrX8KHt
         DSqr2x+rLRlmhPMBn531KqvzMvCxDmwfdFGN5YA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 74/78] hugetlbfs: fix races and page leaks during migration
Date:   Mon,  4 Mar 2019 09:22:57 +0100
Message-Id: <20190304081628.904521362@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit cb6acd01e2e43fd8bad11155752b7699c3d0fb76 upstream.

hugetlb pages should only be migrated if they are 'active'.  The
routines set/clear_page_huge_active() modify the active state of hugetlb
pages.

When a new hugetlb page is allocated at fault time, set_page_huge_active
is called before the page is locked.  Therefore, another thread could
race and migrate the page while it is being added to page table by the
fault code.  This race is somewhat hard to trigger, but can be seen by
strategically adding udelay to simulate worst case scheduling behavior.
Depending on 'how' the code races, various BUG()s could be triggered.

To address this issue, simply delay the set_page_huge_active call until
after the page is successfully added to the page table.

Hugetlb pages can also be leaked at migration time if the pages are
associated with a file in an explicitly mounted hugetlbfs filesystem.
For example, consider a two node system with 4GB worth of huge pages
available.  A program mmaps a 2G file in a hugetlbfs filesystem.  It
then migrates the pages associated with the file from one node to
another.  When the program exits, huge page counts are as follows:

  node0
  1024    free_hugepages
  1024    nr_hugepages

  node1
  0       free_hugepages
  1024    nr_hugepages

  Filesystem                         Size  Used Avail Use% Mounted on
  nodev                              4.0G  2.0G  2.0G  50% /var/opt/hugepool

That is as expected.  2G of huge pages are taken from the free_hugepages
counts, and 2G is the size of the file in the explicitly mounted
filesystem.  If the file is then removed, the counts become:

  node0
  1024    free_hugepages
  1024    nr_hugepages

  node1
  1024    free_hugepages
  1024    nr_hugepages

  Filesystem                         Size  Used Avail Use% Mounted on
  nodev                              4.0G  2.0G  2.0G  50% /var/opt/hugepool

Note that the filesystem still shows 2G of pages used, while there
actually are no huge pages in use.  The only way to 'fix' the filesystem
accounting is to unmount the filesystem

If a hugetlb page is associated with an explicitly mounted filesystem,
this information in contained in the page_private field.  At migration
time, this information is not preserved.  To fix, simply transfer
page_private from old to new page at migration time if necessary.

There is a related race with removing a huge page from a file and
migration.  When a huge page is removed from the pagecache, the
page_mapping() field is cleared, yet page_private remains set until the
page is actually freed by free_huge_page().  A page could be migrated
while in this state.  However, since page_mapping() is not set the
hugetlbfs specific routine to transfer page_private is not called and we
leak the page count in the filesystem.

To fix that, check for this condition before migrating a huge page.  If
the condition is detected, return EBUSY for the page.

Link: http://lkml.kernel.org/r/74510272-7319-7372-9ea6-ec914734c179@oracle.com
Link: http://lkml.kernel.org/r/20190212221400.3512-1-mike.kravetz@oracle.com
Fixes: bcc54222309c ("mm: hugetlb: introduce page_huge_active")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: <stable@vger.kernel.org>
[mike.kravetz@oracle.com: v2]
  Link: http://lkml.kernel.org/r/7534d322-d782-8ac6-1c8d-a8dc380eb3ab@oracle.com
[mike.kravetz@oracle.com: update comment and changelog]
  Link: http://lkml.kernel.org/r/420bcfd6-158b-38e4-98da-26d0cd85bd01@oracle.com
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/hugetlbfs/inode.c |   12 ++++++++++++
 mm/hugetlb.c         |   16 +++++++++++++---
 mm/migrate.c         |   11 +++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -859,6 +859,18 @@ static int hugetlbfs_migrate_page(struct
 	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
+
+	/*
+	 * page_private is subpool pointer in hugetlb pages.  Transfer to
+	 * new page.  PagePrivate is not associated with page_private for
+	 * hugetlb pages and can not be set here as only page_huge_active
+	 * pages can be migrated.
+	 */
+	if (page_private(page)) {
+		set_page_private(newpage, page_private(page));
+		set_page_private(page, 0);
+	}
+
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
 	else
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3624,7 +3624,6 @@ retry_avoidcopy:
 	copy_user_huge_page(new_page, old_page, address, vma,
 			    pages_per_huge_page(h));
 	__SetPageUptodate(new_page);
-	set_page_huge_active(new_page);
 
 	mmun_start = haddr;
 	mmun_end = mmun_start + huge_page_size(h);
@@ -3646,6 +3645,7 @@ retry_avoidcopy:
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
+		set_page_huge_active(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -3730,6 +3730,7 @@ static vm_fault_t hugetlb_no_page(struct
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
+	bool new_page = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -3791,7 +3792,7 @@ retry:
 		}
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		set_page_huge_active(page);
+		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = huge_add_to_page_cache(page, mapping, idx);
@@ -3862,6 +3863,15 @@ retry:
 	}
 
 	spin_unlock(ptl);
+
+	/*
+	 * Only make newly allocated pages active.  Existing pages found
+	 * in the pagecache could be !page_huge_active() if they have been
+	 * isolated for migration.
+	 */
+	if (new_page)
+		set_page_huge_active(page);
+
 	unlock_page(page);
 out:
 	return ret;
@@ -4096,7 +4106,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_s
 	 * the set_pte_at() write.
 	 */
 	__SetPageUptodate(page);
-	set_page_huge_active(page);
 
 	mapping = dst_vma->vm_file->f_mapping;
 	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
@@ -4164,6 +4173,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_s
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
+	set_page_huge_active(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1303,6 +1303,16 @@ static int unmap_and_move_huge_page(new_
 		lock_page(hpage);
 	}
 
+	/*
+	 * Check for pages which are in the process of being freed.  Without
+	 * page_mapping() set, hugetlbfs specific move page routine will not
+	 * be called and we could leak usage counts for subpools.
+	 */
+	if (page_private(hpage) && !page_mapping(hpage)) {
+		rc = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (PageAnon(hpage))
 		anon_vma = page_get_anon_vma(hpage);
 
@@ -1333,6 +1343,7 @@ put_anon:
 		put_new_page = NULL;
 	}
 
+out_unlock:
 	unlock_page(hpage);
 out:
 	if (rc != -EAGAIN)


