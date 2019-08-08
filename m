Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A27C32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33F321874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C8WU+shx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbfHHPm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:42:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390136AbfHHPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qoYaUeTX6kw3ANFQpuUtmmKlzLoKmX03PXm3Ah6Uf/k=; b=C8WU+shxCqtJgFK4W6BVr72MB4
        iqFJN4NcAE8VQCLTnWdSOTVjPgbU+yGpNkh3/1SYrjyHGc/dOcepyoxjMsjFakuzNs7fR3+c8ZgZ7
        s+P/mhbtZPHz1buQd4VQxo9vp4So9TcFHvNecibB59+tmPvBkrmhP7o+merNfhTzJy0xFUS0Box6t
        SiUSG909IQyiE9Z3NBipjp1FH82pFfvw4EJBFxqxwBjNq0rYllcA9o+dmcX3AOfMFla7sCFN03x0u
        KGv0FNiNyq3iTXP6OhQRnVk7JRNCaAn5QVUOjR96C6/nXuFik+y/b+rmpg62AgATdN3XakZhmJOqs
        LFoIdkVA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkZ0-0008VE-O8; Thu, 08 Aug 2019 15:42:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pagewalk: use lockdep_assert_held for locking validation
Date:   Thu,  8 Aug 2019 18:42:40 +0300
Message-Id: <20190808154240.9384-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808154240.9384-1-hch@lst.de>
References: <20190808154240.9384-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use lockdep to check for held locks instead of using home grown
asserts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/pagewalk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 28510fc0dde1..9ec1885ceed7 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -319,7 +319,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	if (!walk.mm)
 		return -EINVAL;
 
-	VM_BUG_ON_MM(!rwsem_is_locked(&walk.mm->mmap_sem), walk.mm);
+	lockdep_assert_held(&walk.mm->mmap_sem);
 
 	vma = find_vma(walk.mm, start);
 	do {
@@ -369,7 +369,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 	if (!walk.mm)
 		return -EINVAL;
 
-	VM_BUG_ON(!rwsem_is_locked(&vma->vm_mm->mmap_sem));
+	lockdep_assert_held(&walk.mm->mmap_sem);
 
 	err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
 	if (err > 0)
-- 
2.20.1

