Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F486C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E35218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gHoA3rLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfGXGx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:53:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfGXGx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jUagJle8tiqkx+fZcCE6Gfny4t7Azmd0YxZDCEv72fs=; b=gHoA3rLxbbBb8a0isoL8eqDuAd
        5No71pHNiivV7f+CSgnKf/BnSlSNK6IHFCeFwtrWSRDbAHPCPDE3FP1zsCfMsYxHtJ90yYDlUxj2K
        HsjlpGb+HBDiw4pJkfZUt0rZPL3rR+vVkgO7MQ7aFVnbJ/dH6yr+BPTKxF7wdx1yMwjk0nxNfGN5a
        MeLw7sIA4cVOQlsewuFjuZ1oKKhb+BnYot7yxvtYabgThfnIv5HDf78+WbsMXOcknLuY5xH2VoJDX
        QIF4jW0Vtaeu3JTdStE89iThn0BlxErxbbHeDGs5EIrl76zsfFj/jdn5E2iKTaq3FlbL16zEG+dDX
        j7FGDjGg==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqB9P-0004Mo-Lp; Wed, 24 Jul 2019 06:53:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mm: comment on VM_FAULT_RETRY semantics in handle_mm_fault
Date:   Wed, 24 Jul 2019 08:52:58 +0200
Message-Id: <20190724065258.16603-8-hch@lst.de>
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

From: Jason Gunthorpe <jgg@mellanox.com>

The magic dropping of mmap_sem when handle_mm_fault returns
VM_FAULT_RETRY is rather subtile.  Add a comment explaining it.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[hch: wrote a changelog]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 16b6731a34db..54b3a4162ae9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -301,8 +301,10 @@ static int hmm_vma_do_fault(struct mm_walk *walk, unsigned long addr,
 	flags |= hmm_vma_walk->block ? 0 : FAULT_FLAG_ALLOW_RETRY;
 	flags |= write_fault ? FAULT_FLAG_WRITE : 0;
 	ret = handle_mm_fault(vma, addr, flags);
-	if (ret & VM_FAULT_RETRY)
+	if (ret & VM_FAULT_RETRY) {
+		/* Note, handle_mm_fault did up_read(&mm->mmap_sem)) */
 		return -EAGAIN;
+	}
 	if (ret & VM_FAULT_ERROR) {
 		*pfn = range->values[HMM_PFN_ERROR];
 		return -EFAULT;
-- 
2.20.1

