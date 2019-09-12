Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3CFC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6242084D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfILVbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:31:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:38897 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbfILVbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:31:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 14:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="176092119"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 12 Sep 2019 14:31:41 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/3] fs/userfaultfd.c: remove a redundant check on end
Date:   Fri, 13 Sep 2019 05:31:08 +0800
Message-Id: <20190912213110.3691-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the ending vma, there is a check to make sure the end is huge page
aligned.

The *if* check makes sure vm_start < end <= vm_end. While the first half
is not necessary, because the *for* clause makes sure vm_start < end.

This patch just removes it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 fs/userfaultfd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 653d8f7c453c..9ce09ac619a2 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1402,8 +1402,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * If this vma contains ending address, and huge pages
 		 * check alignment.
 		 */
-		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end &&
-		    end > cur->vm_start) {
+		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end) {
 			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
 
 			ret = -EINVAL;
-- 
2.17.1

