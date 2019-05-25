Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C9C28CBF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 13:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C68B20449
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lJyfeDa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfEYNcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 09:32:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfEYNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 09:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0pMukIaJ8IjZEEoYFUSUOe32+fVx4NLHIFSad+NCaKI=; b=lJyfeDa/YDCTdpFVkfHBGq8IPd
        /nl3QEsbTzzUQGQAoHja/tQNWt/c587n2t3nMBjqiKS2T6e24vAAQ9+I2lko6f5sI1QWYbHfeDzdl
        bpRdyp6ulACoaIIuUT7IPCUniqdZ9Gf2sY1Jk8e9pODZh5nJUMjAekc1GM8TxVR7zlqRROMipzip+
        v3q5bqcN6EozJkKXJTV7MJORiGsUY9M1ZIqirrQ66xlF+aW2VCEBkbkQzU6TTbLQIl+KtExbl1wQm
        WeOOfyBBx6X5lwzo6ELMqr4uAvq+0eV/niwxNrXILjr8+zVAE7RBVK9iAb88ay3eouL4p/6Sd9I08
        gUvF8Jqw==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUWmS-0006Y2-U1; Sat, 25 May 2019 13:32:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sh: add a missing pud_page definition
Date:   Sat, 25 May 2019 15:31:59 +0200
Message-Id: <20190525133203.25853-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525133203.25853-1-hch@lst.de>
References: <20190525133203.25853-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sh oddly enough had pud_page_vaddr, but not pud_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/pgtable-3level.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index 7d8587eb65ff..8ff6fb6b4d19 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -37,6 +37,7 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	return pud_val(pud);
 }
+#define pud_page(pud)		virt_to_page((void *)pud_page_vaddr(pud))
 
 #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
-- 
2.20.1

