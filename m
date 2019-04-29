Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91B0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1522087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6XXwcfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfD2LxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:53:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2LxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IENXPLnoXusqcRveMX69IYLx+6Bv7CG1f5ec/sjff1M=; b=k6XXwcfvJKs14QwpAHSnhoBW1
        aGO/aRuD5TOGfyMDr8h4Gz3KEDQSvMqK5Ou5K7tbhNbbm3Fu8Gw8ReZKCvFO+T5GkW6pxcc8Xsvzq
        oJDgGrUwFKgqhnnvQnYtZ6XYZWqLPriWNF2duXpV9kKGaTMIBgL4DGcT4g7ubCt3/36Mu9ARTJD3u
        5TVaTYYoY2PYA/6sOnpqcX0hrs9x4dfGDO+HjAy96Qh24Oz5EDZ5P8F+qKoQtRM9TFqPzkhAMmA3Y
        YVbE90qYMrBuE+IZGRIuO2J0scJaDnpWY7e52ma0NV7iSUpghZp906mXESIg118fB+0t6CMv4hwY4
        pgnNHxB2g==;
Received: from 65-114-90-19.dia.static.qwest.net ([65.114.90.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hL4qS-0008Fg-NM; Mon, 29 Apr 2019 11:53:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     mpe@ellerman.id.au
Cc:     aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove the __kernel_io_end export
Date:   Mon, 29 Apr 2019 06:52:41 -0500
Message-Id: <20190429115241.12621-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This export was added in this merge window, but without any actual
user, or justification for a modular user.

Fixes: a35a3c6f6065 ("powerpc/mm/hash64: Add a variable to track the end of IO mapping")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/mm/pgtable_64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 72f58c076e26..1fddc81cc682 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -96,7 +96,6 @@ unsigned long __vmalloc_end;
 EXPORT_SYMBOL(__vmalloc_end);
 unsigned long __kernel_io_start;
 EXPORT_SYMBOL(__kernel_io_start);
-unsigned long __kernel_io_end;
 EXPORT_SYMBOL(__kernel_io_end);
 struct page *vmemmap;
 EXPORT_SYMBOL(vmemmap);
-- 
2.20.1

