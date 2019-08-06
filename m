Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E8EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14460216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127955;
	bh=TN/yZ7FjGl5BN0jJpt8bZnFuEvxtK5gvDFA4qWawSi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+piHDyDBhlCnd0M9AQ6uqV6kaZbudlCI8QG3jPXB4WV/hgD0jpwHzHWNxdQ5bhO2
	 m93S7NCJczBe+MhTNXdW+3RLbrPokAGkokQnT5fPv2w1grW4z2KV1Gom6ve7mz+Njl
	 BljtDAWtf8Yh5n7rESRSgK0oqQivliBZt6llpUqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfHFVdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfHFVde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:33:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C973A21743;
        Tue,  6 Aug 2019 21:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127212;
        bh=TN/yZ7FjGl5BN0jJpt8bZnFuEvxtK5gvDFA4qWawSi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IO2DxLoLP2XBTcG6DKhj+LtbEryyetM83hLNmJuHMzuRKI1DKItYI61T3Y9eWyOTY
         /WdZgZ1Jo2dpipEoIzfC557ZT7OgPUEwDvZfoguzUH6oEDsrLLk91pDrEHNz1nronB
         shkGE3xB2I3bz6k9TSoERWwkMIU5rIxQeJSWY5CM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 10/59] mm/hmm: always return EBUSY for invalid ranges in hmm_range_{fault,snapshot}
Date:   Tue,  6 Aug 2019 17:32:30 -0400
Message-Id: <20190806213319.19203-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 2bcbeaefde2f0384d6ad351c151b1a9fe7791a0a ]

We should not have two different error codes for the same
condition. EAGAIN must be reserved for the FAULT_FLAG_ALLOW_RETRY retry
case and signals to the caller that the mmap_sem has been unlocked.

Use EBUSY for the !valid case so that callers can get the locking right.

Link: https://lore.kernel.org/r/20190724065258.16603-2-hch@lst.de
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
[jgg: elaborated commit message]
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/vm/hmm.rst |  2 +-
 mm/hmm.c                 | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 7cdf7282e0229..65b6c1109cc81 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -231,7 +231,7 @@ respect in order to keep things properly synchronized. The usage pattern is::
       ret = hmm_range_snapshot(&range);
       if (ret) {
           up_read(&mm->mmap_sem);
-          if (ret == -EAGAIN) {
+          if (ret == -EBUSY) {
             /*
              * No need to check hmm_range_wait_until_valid() return value
              * on retry we will get proper error with hmm_range_snapshot()
diff --git a/mm/hmm.c b/mm/hmm.c
index 4c405dfbd2b3d..27dd9a8816272 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -995,7 +995,7 @@ EXPORT_SYMBOL(hmm_range_unregister);
  * @range: range
  * Returns: -EINVAL if invalid argument, -ENOMEM out of memory, -EPERM invalid
  *          permission (for instance asking for write and range is read only),
- *          -EAGAIN if you need to retry, -EFAULT invalid (ie either no valid
+ *          -EBUSY if you need to retry, -EFAULT invalid (ie either no valid
  *          vma or it is illegal to access that range), number of valid pages
  *          in range->pfns[] (from range start address).
  *
@@ -1019,7 +1019,7 @@ long hmm_range_snapshot(struct hmm_range *range)
 	do {
 		/* If range is no longer valid force retry. */
 		if (!range->valid)
-			return -EAGAIN;
+			return -EBUSY;
 
 		vma = find_vma(hmm->mm, start);
 		if (vma == NULL || (vma->vm_flags & device_vma))
@@ -1117,10 +1117,8 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 
 	do {
 		/* If range is no longer valid force retry. */
-		if (!range->valid) {
-			up_read(&hmm->mm->mmap_sem);
-			return -EAGAIN;
-		}
+		if (!range->valid)
+			return -EBUSY;
 
 		vma = find_vma(hmm->mm, start);
 		if (vma == NULL || (vma->vm_flags & device_vma))
-- 
2.20.1

