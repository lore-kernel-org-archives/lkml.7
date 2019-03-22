Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE2F21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256413;
	bh=KFAqTpcknOIisZYWNJVXFD74VGXUmxezrUDFr32ASZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U+Zc4shZKN9FiXs6np6qcUdjTN3ylOmm/X00XsRw0TlYSwE6NiQRK9vvTzjYjeZl/
	 xtqFa9864VH2ox9iWrEH4FylSBQ1J09qf1eInVclAh5Se3WOI9+c0noHkeE7943Xo6
	 fzjPQR1LFlTD0V3FI++UQ8ztpI/wqoWPvfCVLZJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbfCVMGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbfCVMGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:06:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 769912082C;
        Fri, 22 Mar 2019 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256409;
        bh=KFAqTpcknOIisZYWNJVXFD74VGXUmxezrUDFr32ASZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLwXvHG5UHFmTdWbjyKN+j5V3kothUsO8nfxVTE3ufQHJ3gyy9EhsAa09caoDDDah
         4Vg83NopIZvOR6Bf+FB2UYWYCuNtnXNyG02oUgRB3F+X4pr9itAMP62hbeIgXjjlZv
         7jLp3VMx93eV90jCIxBiIQ9C3apQPZWoEbJskHgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 202/280] mm/memory.c: do_fault: avoid usage of stale vm_area_struct
Date:   Fri, 22 Mar 2019 12:15:55 +0100
Message-Id: <20190322111330.947117233@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Jan Stancek <jstancek@redhat.com>

commit fc8efd2ddfed3f343c11b693e87140ff358d7ff5 upstream.

LTP testcase mtest06 [1] can trigger a crash on s390x running 5.0.0-rc8.
This is a stress test, where one thread mmaps/writes/munmaps memory area
and other thread is trying to read from it:

  CPU: 0 PID: 2611 Comm: mmap1 Not tainted 5.0.0-rc8+ #51
  Hardware name: IBM 2964 N63 400 (z/VM 6.4.0)
  Krnl PSW : 0404e00180000000 00000000001ac8d8 (__lock_acquire+0x7/0x7a8)
  Call Trace:
  ([<0000000000000000>]           (null))
   [<00000000001adae4>] lock_acquire+0xec/0x258
   [<000000000080d1ac>] _raw_spin_lock_bh+0x5c/0x98
   [<000000000012a780>] page_table_free+0x48/0x1a8
   [<00000000002f6e54>] do_fault+0xdc/0x670
   [<00000000002fadae>] __handle_mm_fault+0x416/0x5f0
   [<00000000002fb138>] handle_mm_fault+0x1b0/0x320
   [<00000000001248cc>] do_dat_exception+0x19c/0x2c8
   [<000000000080e5ee>] pgm_check_handler+0x19e/0x200

page_table_free() is called with NULL mm parameter, but because "0" is a
valid address on s390 (see S390_lowcore), it keeps going until it
eventually crashes in lockdep's lock_acquire.  This crash is
reproducible at least since 4.14.

Problem is that "vmf->vma" used in do_fault() can become stale.  Because
mmap_sem may be released, other threads can come in, call munmap() and
cause "vma" be returned to kmem cache, and get zeroed/re-initialized and
re-used:

handle_mm_fault                           |
  __handle_mm_fault                       |
    do_fault                              |
      vma = vmf->vma                      |
      do_read_fault                       |
        __do_fault                        |
          vma->vm_ops->fault(vmf);        |
            mmap_sem is released          |
                                          |
                                          | do_munmap()
                                          |   remove_vma_list()
                                          |     remove_vma()
                                          |       vm_area_free()
                                          |         # vma is released
                                          | ...
                                          | # same vma is allocated
                                          | # from kmem cache
                                          | do_mmap()
                                          |   vm_area_alloc()
                                          |     memset(vma, 0, ...)
                                          |
      pte_free(vma->vm_mm, ...);          |
        page_table_free                   |
          spin_lock_bh(&mm->context.lock);|
            <crash>                       |

Cache mm_struct to avoid using potentially stale "vma".

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/mtest06/mmap1.c

Link: http://lkml.kernel.org/r/5b3fdf19e2a5be460a384b936f5b56e13733f1b8.1551595137.git.jstancek@redhat.com
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Acked-by: Rafael Aquini <aquini@redhat.com>
Reviewed-by: Minchan Kim <minchan@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3762,10 +3762,13 @@ static vm_fault_t do_shared_fault(struct
  * but allow concurrent faults).
  * The mmap_sem may have been released depending on flags and our
  * return value.  See filemap_fault() and __lock_page_or_retry().
+ * If mmap_sem is released, vma may become invalid (for example
+ * by other thread calling munmap()).
  */
 static vm_fault_t do_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
 	/*
@@ -3806,7 +3809,7 @@ static vm_fault_t do_fault(struct vm_fau
 
 	/* preallocated pagetable is unused: free it */
 	if (vmf->prealloc_pte) {
-		pte_free(vma->vm_mm, vmf->prealloc_pte);
+		pte_free(vm_mm, vmf->prealloc_pte);
 		vmf->prealloc_pte = NULL;
 	}
 	return ret;


