Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25759C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AA6206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tPLKCpRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfGAPS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:18:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfGAPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W24hVTkWBqif5TpM38UrHl82eo9rhQffmi/qNIa3KQw=; b=tPLKCpRQPwcfjNA8YQTbRBgjwB
        cTeldU53kGIZcXI4ZC+66G3bZsYi+NAOgC4hOnQDtHKBLPmjwM+rCM6k4MLq2saC76pV36iLBv82D
        7f8KK3JXNsZf4LqhlioGjqhdX7pQYdEm/6TVxvutgT8sqqkerg+ArxXH8RLmHVoobF5EWszZys7o+
        HvdKHl/gFGLrYBfl+57ncL82vSfHXvjNgMvVtore1OcJU2Z5i7SW8B083w3nloAyxPCd2IvOHGq1p
        +tdLt6vxN7p94V4K+zYQ3ireYu6T2Z2UCjgCJlAQhL731e0VNjeSx3YWFQa+mS//b6h2QwnVnPcbd
        +3WxPSsw==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhy4h-0003zX-TP; Mon, 01 Jul 2019 15:18:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sh: stub out pud_page
Date:   Mon,  1 Jul 2019 17:18:17 +0200
Message-Id: <20190701151818.32227-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701151818.32227-1-hch@lst.de>
References: <20190701151818.32227-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There wasn't any actual need to add a real pud_page, as pud_huge
always returns false on sh.  Just stub it out to fix the sh3
compile failure.

Fixes: 937b4e1d6471 ("sh: add the missing pud_page definition")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/pgtable-3level.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index 3c7ff20f3f94..779260b721ca 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -37,7 +37,9 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	return pud_val(pud);
 }
-#define pud_page(pud)		pfn_to_page(pud_pfn(pud))
+
+/* only used by the stubbed out hugetlb gup code, should never be called */
+#define pud_page(pud)		NULL
 
 #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
-- 
2.20.1

