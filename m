Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A060C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10C120B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BnCU6qOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfHEJM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:12:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfHEJMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MC0YAzXDv4UW9aVepSWPET61pXC/qRZc/Q3SPMyp+PQ=; b=BnCU6qOapxKxAiOYshoyO0Pn42
        xqlgYlEAswW2CCDXcDvEHUmDLhQqCFIi0ELw0LxvatqpGEl0+HtpTMhstvk64Klhas3C3RpR3GbAk
        p0Er1aGH/ojYTgIUNRrXmwx72gkxjm7RMwmzzAgppKLW8ExOnTd4fpidg3bXjozKpuPrBgHQMC3Iy
        mgrTFGLaU+oqCIKb+dP1XcMbBmewkR7ra/p6CUfZub0a/0/rOmi0OHjyzvoE/9oOiXk1ACJ6/Y84m
        Fb8ST6DCMzHeeEtysG9MTm0XswA0C3NrSu293IgfRJ+QVYPrtqQVmoM6HXC+UBf+cZfGTuR9r6eTU
        ZpksCIGg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huZ2P-00052F-37; Mon, 05 Aug 2019 09:12:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] m68knommu: add a pgprot_noncached stub
Date:   Mon,  5 Aug 2019 12:11:57 +0300
Message-Id: <20190805091159.7826-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805091159.7826-1-hch@lst.de>
References: <20190805091159.7826-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a pgprot_noncached like all the other nommu ports so that
common code can rely on it being able to be present.  Note that this is
generally code that is not actually run on nommu, but at least we can
avoid nasty ifdefs by having a stub.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/include/asm/pgtable_no.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index fc3a96c77bd8..06194c7ba151 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -29,6 +29,8 @@
 #define PAGE_READONLY	__pgprot(0)
 #define PAGE_KERNEL	__pgprot(0)
 
+#define pgprot_noncached(prot)   (prot)
+
 extern void paging_init(void);
 #define swapper_pg_dir ((pgd_t *) 0)
 
-- 
2.20.1

