Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEFC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48B7217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MP9XJpD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfDWQbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:31:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfDWQbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uHFTnl4vUjrNVYTFv2dDUy+7np+VKavI9He7Ga2MW2s=; b=MP9XJpD/YDBzhAaWL4T3dWWcc1
        TPxn0IQP5ZtDi7WPcFcZFv5WwFUYahtTpxT7289UxxSBI6l9Iyl42Rm/9e0rs+uU1YymrfyH7z8Yv
        NsLEbkTbBin707y0toERTo5+I8BXuxN5I1F3MngkS/0XGC5v7INfjyC123nBirBr9tWBioJxo62Kx
        I5J4brPLZcirfF5tz/mK1mZ2tLW9W3zahmqrPCcW/NwijeAlhd35+cDe/EZYDBbjj3x74hnwcO6rn
        b23U81AyYKrUKyH4iCm73SUQP3/R2dtNDUQ0NepM7wB5qeXZvMzA32LMBhPpbh32ZKA/7aihMAnhQ
        tHbZ915g==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIyKQ-00042x-E8; Tue, 23 Apr 2019 16:31:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: stub out all of swapops.h for !CONFIG_MMU
Date:   Tue, 23 Apr 2019 18:30:59 +0200
Message-Id: <20190423163059.8820-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423163059.8820-1-hch@lst.de>
References: <20190423163059.8820-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole header file deals with swap entries and PTEs, none of which
can exist for nommu builds.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swapops.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 4d961668e5fc..b02922556846 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -6,6 +6,8 @@
 #include <linux/bug.h>
 #include <linux/mm_types.h>
 
+#ifdef CONFIG_MMU
+
 /*
  * swapcache pages are stored in the swapper_space radix tree.  We want to
  * get good packing density in that tree, so the index should be dense in
@@ -50,13 +52,11 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-#ifdef CONFIG_MMU
 /* check whether a pte points to a swap entry */
 static inline int is_swap_pte(pte_t pte)
 {
 	return !pte_none(pte) && !pte_present(pte);
 }
-#endif
 
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
@@ -375,4 +375,5 @@ static inline int non_swap_entry(swp_entry_t entry)
 }
 #endif
 
+#endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
-- 
2.20.1

