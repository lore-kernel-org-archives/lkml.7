Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE1C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EA020838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCBST5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:19:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfCBST4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:19:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65E373092665;
        Sat,  2 Mar 2019 18:19:56 +0000 (UTC)
Received: from dustball.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23FA8600C8;
        Sat,  2 Mar 2019 18:19:49 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        peterz@infradead.org, riel@surriel.com, mhocko@suse.com,
        ying.huang@intel.com, jrdr.linux@gmail.com, jglisse@redhat.com,
        aneesh.kumar@linux.ibm.com, david@redhat.com, aarcange@redhat.com,
        raquini@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, jstancek@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/memory.c: do_fault: avoid usage of stale vm_area_struct
Date:   Sat,  2 Mar 2019 19:19:39 +0100
Message-Id: <a5234d11b8cc158352a2f97fc33aa9ad90bb287b.1551550112.git.jstancek@redhat.com>
In-Reply-To: <20190302171043.GP11592@bombadil.infradead.org>
References: <20190302171043.GP11592@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 02 Mar 2019 18:19:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

page_table_free() is called with NULL mm parameter, but because
"0" is a valid address on s390 (see S390_lowcore), it keeps
going until it eventually crashes in lockdep's lock_acquire.
This crash is reproducible at least since 4.14.

Problem is that "vmf->vma" used in do_fault() can become stale.
Because mmap_sem may be released, other threads can come in,
call munmap() and cause "vma" be returned to kmem cache, and
get zeroed/re-initialized and re-used:

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

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 mm/memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index e11ca9dd823f..6c1afc1ece50 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3517,10 +3517,13 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
  * but allow concurrent faults).
  * The mmap_sem may have been released depending on flags and our
  * return value.  See filemap_fault() and __lock_page_or_retry().
+ * If mmap_sem is released, vma may become invalid (for example
+ * by other thread calling munmap()).
  */
 static vm_fault_t do_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *vm_mm = READ_ONCE(vma->vm_mm);
 	vm_fault_t ret;
 
 	/*
@@ -3561,7 +3564,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 
 	/* preallocated pagetable is unused: free it */
 	if (vmf->prealloc_pte) {
-		pte_free(vma->vm_mm, vmf->prealloc_pte);
+		pte_free(vm_mm, vmf->prealloc_pte);
 		vmf->prealloc_pte = NULL;
 	}
 	return ret;
-- 
1.8.3.1

