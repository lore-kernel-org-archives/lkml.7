Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C627C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275502070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfHFITK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:19:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:35535 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbfHFITJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:19:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 01:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,352,1559545200"; 
   d="scan'208";a="176561599"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2019 01:11:48 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/mmap.c: refine data locality of find_vma_prev
Date:   Tue,  6 Aug 2019 16:11:23 +0800
Message-Id: <20190806081123.22334-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When addr is out of the range of the whole rb_tree, pprev will points to
the biggest node. find_vma_prev gets is by going through the right most
node of the tree.

Since only the last node is the one it is looking for, it is not
necessary to assign pprev to those middle stage nodes. By assigning
pprev to the last node directly, it tries to improve the function
locality a little.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/mmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..284bc7e51f9c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2271,11 +2271,10 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
 		*pprev = vma->vm_prev;
 	} else {
 		struct rb_node *rb_node = mm->mm_rb.rb_node;
-		*pprev = NULL;
-		while (rb_node) {
-			*pprev = rb_entry(rb_node, struct vm_area_struct, vm_rb);
+		while (rb_node && rb_node->rb_right)
 			rb_node = rb_node->rb_right;
-		}
+		*pprev = rb_node ? NULL
+			 : rb_entry(rb_node, struct vm_area_struct, vm_rb);
 	}
 	return vma;
 }
-- 
2.17.1

