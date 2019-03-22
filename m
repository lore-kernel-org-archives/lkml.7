Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5CF2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254248;
	bh=PApZfJDoDN0Kb8HX37cb/HsWT75/PpcGFwzqLLUxH7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V28VFgK85ZjXwUbMvxJlMXH01Z7RVay5GlMN8RaKDq3Bsgr7WL3jv8pNFmbcfL/ci
	 zZ+H4FU0YJOZQ9/GRQ+JVdndo0emLV5uS79UWiIKKuwOpsPDj7H9SELWwAUR8qqx94
	 wh7jhmw+Zxg+PymVGN9CCdaO/Fi9Vc2qeJEkJRi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfCVLaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbfCVLam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D09221917;
        Fri, 22 Mar 2019 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254241;
        bh=PApZfJDoDN0Kb8HX37cb/HsWT75/PpcGFwzqLLUxH7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/znf4Zk7I52nu71eWlbZLkajCZozfHeaGqrlt8nEuTyknI8xPGXLahdtVJB5/lG1
         cLArIRlweSf0h95rEEoh6JNmE7E3jtuiJ8amOtjmx8iG45Y7f/8vf2FAUIf5fXZBxH
         cBoQVzDDcI2U4BSsb4AOC1E8+wPwVpuNkVmLhAqA=
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
Subject: [PATCH 4.4 075/230] hugetlbfs: fix races and page leaks during migration
Date:   Fri, 22 Mar 2019 12:13:33 +0100
Message-Id: <20190322111241.919802903@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 mm/hugetlb.c         |   14 ++++++++++++--
 mm/migrate.c         |   11 +++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -869,6 +869,18 @@ static int hugetlbfs_migrate_page(struct
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
 	migrate_page_copy(newpage, page);
 
 	return MIGRATEPAGE_SUCCESS;
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3472,7 +3472,6 @@ retry_avoidcopy:
 	copy_user_huge_page(new_page, old_page, address, vma,
 			    pages_per_huge_page(h));
 	__SetPageUptodate(new_page);
-	set_page_huge_active(new_page);
 
 	mmun_start = address & huge_page_mask(h);
 	mmun_end = mmun_start + huge_page_size(h);
@@ -3494,6 +3493,7 @@ retry_avoidcopy:
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page);
 		hugepage_add_new_anon_rmap(new_page, vma, address);
+		set_page_huge_active(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -3575,6 +3575,7 @@ static int hugetlb_no_page(struct mm_str
 	struct page *page;
 	pte_t new_pte;
 	spinlock_t *ptl;
+	bool new_page = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -3608,7 +3609,7 @@ retry:
 		}
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		set_page_huge_active(page);
+		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = huge_add_to_page_cache(page, mapping, idx);
@@ -3680,6 +3681,15 @@ retry:
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
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1056,6 +1056,16 @@ static int unmap_and_move_huge_page(new_
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
 
@@ -1086,6 +1096,7 @@ put_anon:
 		put_new_page = NULL;
 	}
 
+out_unlock:
 	unlock_page(hpage);
 out:
 	if (rc != -EAGAIN)


