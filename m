Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCDEC76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA22199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TXUpZd6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfGVJoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:44:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfGVJoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=urPxkwOym5lxnAAUEUOneOxI40UkREYaiMYiFYZBiIs=; b=TXUpZd6L0YbxCncr1sT24mkFmX
        KdB/rJzomvHFe2vcYwtDiUWfXEb1N01spG6VnZkFRqZff6JTTSyVg6e2XYqqfAEPSFbxcPRWZvq7C
        X2Qor61E/+M2izt/dhGwdlhTh/mx4lUGDG9IFMT3BJGDUGZYpplivXhqVFZhj1Yts7FzlI5fZ0EuQ
        HPaB2GbWNvXyIHipogv1Dam/RNzkNllIiqYX3fN8H+EielY8T5BUPYFjBqVtiWN7qpDT6hCZdSE5Z
        e0YIgF2g0ItU/oWpaJMr+Lj/9moAJg5bcrft1jtgZcH8pGR341dRszQE/TWWzSWibmPDL0j4K+oQ3
        g/VnYbfw==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUru-0001rb-RN; Mon, 22 Jul 2019 09:44:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 1/6] mm: always return EBUSY for invalid ranges in hmm_range_{fault,snapshot}
Date:   Mon, 22 Jul 2019 11:44:21 +0200
Message-Id: <20190722094426.18563-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722094426.18563-1-hch@lst.de>
References: <20190722094426.18563-1-hch@lst.de>
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

