Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF87C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3149021773
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442018;
	bh=S81DyfcSyqTgrPgcB8WEsbph6hxCHlDQv/JRvnmwRsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r/Xw0O7J0Wxfy4+0WcGl7AO4zL7WcYr0YnPPgZJ+y6qr66rateqEFgbrAgolxE/So
	 IV9SaMrg2YnfemLuyj8GGCdnGg7wC8LkVqlOOJ1fHZrWMjyn0une5JD2Hoo1371hjt
	 j2jbVmNPQn/Wbpj+X3HgaXypSbkkS0JPlJ0ZYV3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbfFMQGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbfFMIqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:46:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8981B20851;
        Thu, 13 Jun 2019 08:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415560;
        bh=S81DyfcSyqTgrPgcB8WEsbph6hxCHlDQv/JRvnmwRsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jajKXGN+1orB/Sch9V0iKtXrdpQk2I13F96Fxh4YqRLpMzZdTWOos7nfiH50Ycws9
         YSv0IWir1qu93e+r6JSPub7GOvrxdDnC5vKQt0cglkOLRXSaRTl38qpUpJt7/PGqk5
         xr11QpTTqCxB2QKPSZ+DrVN2dV4tRjqJ0VpI41AQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 021/155] mm: page_mkclean vs MADV_DONTNEED race
Date:   Thu, 13 Jun 2019 10:32:13 +0200
Message-Id: <20190613075653.958101764@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 024eee0e83f0df52317be607ca521e0fc572aa07 ]

MADV_DONTNEED is handled with mmap_sem taken in read mode.  We call
page_mkclean without holding mmap_sem.

MADV_DONTNEED implies that pages in the region are unmapped and subsequent
access to the pages in that range is handled as a new page fault.  This
implies that if we don't have parallel access to the region when
MADV_DONTNEED is run we expect those range to be unallocated.

w.r.t page_mkclean() we need to make sure that we don't break the
MADV_DONTNEED semantics.  MADV_DONTNEED check for pmd_none without holding
pmd_lock.  This implies we skip the pmd if we temporarily mark pmd none.
Avoid doing that while marking the page clean.

Keep the sequence same for dax too even though we don't support
MADV_DONTNEED for dax mapping

The bug was noticed by code review and I didn't observe any failures w.r.t
test run.  This is similar to

commit 58ceeb6bec86d9140f9d91d71a710e963523d063
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Thu Apr 13 14:56:26 2017 -0700

    thp: fix MADV_DONTNEED vs. MADV_FREE race

commit ced108037c2aa542b3ed8b7afd1576064ad1362a
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Thu Apr 13 14:56:20 2017 -0700

    thp: fix MADV_DONTNEED vs. numa balancing race

Link: http://lkml.kernel.org/r/20190321040610.14226-1-aneesh.kumar@linux.ibm.com
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc:"Kirill A . Shutemov" <kirill@shutemov.name>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c  | 2 +-
 mm/rmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 83009875308c..f74386293632 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -814,7 +814,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 				goto unlock_pmd;
 
 			flush_cache_page(vma, address, pfn);
-			pmd = pmdp_huge_clear_flush(vma, address, pmdp);
+			pmd = pmdp_invalidate(vma, address, pmdp);
 			pmd = pmd_wrprotect(pmd);
 			pmd = pmd_mkclean(pmd);
 			set_pmd_at(vma->vm_mm, address, pmdp, pmd);
diff --git a/mm/rmap.c b/mm/rmap.c
index b30c7c71d1d9..76c8dfd3ae1c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -928,7 +928,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 				continue;
 
 			flush_cache_page(vma, address, page_to_pfn(page));
-			entry = pmdp_huge_clear_flush(vma, address, pmd);
+			entry = pmdp_invalidate(vma, address, pmd);
 			entry = pmd_wrprotect(entry);
 			entry = pmd_mkclean(entry);
 			set_pmd_at(vma->vm_mm, address, pmd, entry);
-- 
2.20.1



