Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6FBC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514512067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfDYXWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:22:23 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52735 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbfDYXWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:22:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TQFDOB0_1556234531;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TQFDOB0_1556234531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Apr 2019 07:22:18 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     josef@toxicpanda.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: filemap: correct the comment about VM_FAULT_RETRY
Date:   Fri, 26 Apr 2019 07:22:11 +0800
Message-Id: <1556234531-108228-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking
operations") changed when mmap_sem is dropped during filemap page fault
and when returning VM_FAULT_RETRY.

Correct the comment to reflect the change.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/filemap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d78f577..f0d6250 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2545,10 +2545,8 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
  *
  * vma->vm_mm->mmap_sem must be held on entry.
  *
- * If our return value has VM_FAULT_RETRY set, it's because
- * lock_page_or_retry() returned 0.
- * The mmap_sem has usually been released in this case.
- * See __lock_page_or_retry() for the exception.
+ * If our return value has VM_FAULT_RETRY set, it's because the mmap_sem
+ * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
  *
  * If our return value does not have VM_FAULT_RETRY set, the mmap_sem
  * has not been released.
-- 
1.8.3.1

