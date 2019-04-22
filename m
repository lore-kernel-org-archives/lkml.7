Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB13AC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CA220685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfDVWZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:25:04 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46048 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727336AbfDVWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:25:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TQ.RLKx_1555971893;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TQ.RLKx_1555971893)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Apr 2019 06:25:00 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, vbabka@suse.cz, rientjes@google.com,
        kirill@shutemov.name, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: fix false negative of shmem vma's THP eligibility
Date:   Tue, 23 Apr 2019 06:24:53 +0800
Message-Id: <1555971893-52276-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each
vma") introduced THPeligible bit for processes' smaps. But, when checking
the eligibility for shmem vma, __transparent_hugepage_enabled() is
called to override the result from shmem_huge_enabled().  It may result
in the anonymous vma's THP flag override shmem's.  For example, running a
simple test which create THP for shmem, but with anonymous THP disabled,
when reading the process's smaps, it may show:

7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
Size:               4096 kB
...
[snip]
...
ShmemPmdMapped:     4096 kB
...
[snip]
...
THPeligible:    0

And, /proc/meminfo does show THP allocated and PMD mapped too:

ShmemHugePages:     4096 kB
ShmemPmdMapped:     4096 kB

This doesn't make too much sense.  The anonymous THP flag should not
intervene shmem THP.  Calling shmem_huge_enabled() with checking
MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
dax vma check since we already checked if the vma is shmem already.

Fixes: 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each vma")
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/huge_memory.c | 4 ++--
 mm/shmem.c       | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 165ea46..5881e82 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -67,8 +67,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	if (vma_is_anonymous(vma))
 		return __transparent_hugepage_enabled(vma);
-	if (vma_is_shmem(vma) && shmem_huge_enabled(vma))
-		return __transparent_hugepage_enabled(vma);
+	if (vma_is_shmem(vma))
+		return shmem_huge_enabled(vma);
 
 	return false;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 2275a0f..be15e9b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3873,6 +3873,8 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 	loff_t i_size;
 	pgoff_t off;
 
+	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		return false;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		return true;
 	if (shmem_huge == SHMEM_HUGE_DENY)
-- 
1.8.3.1

