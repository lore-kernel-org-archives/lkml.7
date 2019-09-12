Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8A8C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1943A2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfILGcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 02:32:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:24030 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfILGcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:32:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 23:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="175872277"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2019 23:31:53 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz,
        yang.shi@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/mmap.c: remove a never trigger warning in __vma_adjust()
Date:   Thu, 12 Sep 2019 14:31:26 +0800
Message-Id: <20190912063126.13250-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper level of "if" makes sure (end >= next->vm_end), which means
there are only two possibilities:

   1) end == next->vm_end
   2) end > next->vm_end

remove_next is assigned to be (1 + end > next->vm_end). This means if
remove_next is 1, end must equal to next->vm_end.

The VM_WARN_ON will never trigger.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 907939690a30..18ef68f00f51 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -738,8 +738,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 				remove_next = 1 + (end > next->vm_end);
 				VM_WARN_ON(remove_next == 2 &&
 					   end != next->vm_next->vm_end);
-				VM_WARN_ON(remove_next == 1 &&
-					   end != next->vm_end);
 				/* trim end to next, for case 6 first pass */
 				end = next->vm_end;
 			}
-- 
2.17.1

