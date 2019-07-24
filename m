Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98134C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020E20644
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PTpmJ/2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfGXGxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:53:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGXGxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DSjx3V8seGjWbwtcA9zyGdO2uw7ke18fmJwoWmqMVnM=; b=PTpmJ/2qJ58v0Yn7xWag2yZ4ef
        VhRhiyB0VamFSm/AzvXGbwI1J1iNXfwAIOx9CqQeqJG+6qoNH24LLcL8LRkeL0GGTNRFSff85NWoz
        xBcuEzvSyLoJpa2SwhN9ePQsgmeTvYsFJwH61I34/01jbQSmoVRmNu0Dqvyu8LxE/c6XLsw0PIDgs
        EsRCpWtRTg/GzpZPGrSl3fkLoByjtS8UwgWbA+pnyBgqRQHBBjASyZ2gZHwMeRF9rLwoYxcrFzbqs
        LBOcdZ/AW4DSb5YW36uQh7jbcNN5xQ7CSV6LHqd+GuCw3/ziT1lLD7n4rUIezcKRBCUNNWstdC55d
        yxqUSZjw==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqB97-0004IF-4l; Wed, 24 Jul 2019 06:53:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 1/7] mm: always return EBUSY for invalid ranges in hmm_range_{fault,snapshot}
Date:   Wed, 24 Jul 2019 08:52:52 +0200
Message-Id: <20190724065258.16603-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724065258.16603-1-hch@lst.de>
References: <20190724065258.16603-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not have two different error codes for the same condition.  In
addition this really complicates the code due to the special handling of
EAGAIN that drops the mmap_sem due to the FAULT_FLAG_ALLOW_RETRY logic
in the core vm.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 Documentation/vm/hmm.rst |  2 +-
 mm/hmm.c                 | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 7d90964abbb0..710ce1c701bf 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -237,7 +237,7 @@ The usage pattern is::
       ret = hmm_range_snapshot(&range);
       if (ret) {
           up_read(&mm->mmap_sem);
-          if (ret == -EAGAIN) {
+          if (ret == -EBUSY) {
             /*
              * No need to check hmm_range_wait_until_valid() return value
              * on retry we will get proper error with hmm_range_snapshot()
diff --git a/mm/hmm.c b/mm/hmm.c
index e1eedef129cf..16b6731a34db 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -946,7 +946,7 @@ EXPORT_SYMBOL(hmm_range_unregister);
  * @range: range
  * Return: -EINVAL if invalid argument, -ENOMEM out of memory, -EPERM invalid
  *          permission (for instance asking for write and range is read only),
- *          -EAGAIN if you need to retry, -EFAULT invalid (ie either no valid
+ *          -EBUSY if you need to retry, -EFAULT invalid (ie either no valid
  *          vma or it is illegal to access that range), number of valid pages
  *          in range->pfns[] (from range start address).
  *
@@ -967,7 +967,7 @@ long hmm_range_snapshot(struct hmm_range *range)
 	do {
 		/* If range is no longer valid force retry. */
 		if (!range->valid)
-			return -EAGAIN;
+			return -EBUSY;
 
 		vma = find_vma(hmm->mm, start);
 		if (vma == NULL || (vma->vm_flags & device_vma))
@@ -1062,10 +1062,8 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 
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

