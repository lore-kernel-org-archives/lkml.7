Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32934C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDAC22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfH1GGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:06:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:22063 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfH1GGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:06:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 23:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="185518935"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2019 23:06:42 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [RESEND [PATCH] 2/2] mm/mmap.c: unlink vma before rb_erase
Date:   Wed, 28 Aug 2019 14:06:14 +0800
Message-Id: <20190828060614.19535-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828060614.19535-1-richardw.yang@linux.intel.com>
References: <20190828060614.19535-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current sequence to remove a vma is:

  vma_rb_erase_ignore()
  __vma_unlink_list()
  vma_gap_update()

This may do some extra subtree_gap propagation due the vma is unlink
from list after rb_erase.

For example, we have a tree:

                    a
                    [0x9000, 0x10000]
                /            \
            b                 c
            [0x8000, 0x9000]  [0x10000, 0x11000]
         /
        d
        [0x6000, 0x7000]

The gap for each node is:

  a's gap = 0x6000
  b's gap = 0x6000
  c's gap = 0x0
  d's gap = 0x6000

Now we want to remove node d. Since we don't unlink d from link when
doing rb_erase, b's gap would still be computed to 0x1000. This leads to
the vma_gap_update() after list unlink would recompute b and a's gap.

For this case, by unlink the list before rb_erase, we would have one
time less of vma_compute_subtree_gap.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 672ad7dc6b3c..907939690a30 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -678,8 +678,8 @@ static __always_inline void __vma_unlink_common(struct mm_struct *mm,
 						struct vm_area_struct *vma,
 						struct vm_area_struct *ignore)
 {
-	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
 	__vma_unlink_list(mm, vma);
+	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
 	/* Kill the cache */
 	vmacache_invalidate(mm);
 }
-- 
2.17.1

