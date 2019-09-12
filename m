Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2980FC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34D020856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfILViN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:38:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:29755 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbfILViM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:38:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 14:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="179487176"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2019 14:31:43 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/3] fs/userfaultfd.c: reorder the if check to reduce some computation
Date:   Fri, 13 Sep 2019 05:31:09 +0800
Message-Id: <20190912213110.3691-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912213110.3691-1-richardw.yang@linux.intel.com>
References: <20190912213110.3691-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are several condition check in *if* clause, the check will
stop at the first false one.

Since the for loop iterates vma list, we are sure only the last vma
meets the condition "end <= vm_end". Reorder the check sequence to
reduce some computation.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 9ce09ac619a2..70c0e0ef01d7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1402,7 +1402,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * If this vma contains ending address, and huge pages
 		 * check alignment.
 		 */
-		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end) {
+		if (end <= cur->vm_end && is_vm_hugetlb_page(cur)) {
 			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
 
 			ret = -EINVAL;
-- 
2.17.1

