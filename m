Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1401C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EA120835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kj+a9JEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfD3S2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:28:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfD3S2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cyKJjVA2Cr8WCry47+rheDa1iIA4vvvEFATneZj3baQ=; b=Kj+a9JEtHb2JRJdjRCUovQa9x
        ifwHmX+AMEvLWdnYaa0wOP/BH/d4KbQPcso5WTGaMGOBS/O+CTUws+LaIMARhIDqHsgMbDMt1YOJY
        0AmDdNUUU4rpwk46OSJYWc3G24F1YjcYkUEiVfIBPLl4e3abxgj2BEQKkzdmblmEhQrGIkN3YNINC
        6IcwhFMKntDocHBbxFiHFFJFHLQctcU2164fIrYfzosiwhv8rZ06yqL3n/3FA4wNtKF97JhylKR5f
        6AGSsLzoZ5Aa6Vv7t7j3w3hDTo+h/OF0lm1MHrBrjOHWlWBpV6EoDrlEodpN7bLywvOgAivxymybd
        MMA6/VkbA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLXUF-0004So-GU; Tue, 30 Apr 2019 18:28:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     mpe@ellerman.id.au, aneesh.kumar@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc: remove the __kernel_io_end export
Date:   Tue, 30 Apr 2019 14:27:39 -0400
Message-Id: <20190430182739.21961-1-hch@lst.de>
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

Chanes since v1:

 - actually compiles now..

 arch/powerpc/mm/pgtable_64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 72f58c076e26..dd610dab98e0 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -97,7 +97,6 @@ EXPORT_SYMBOL(__vmalloc_end);
 unsigned long __kernel_io_start;
 EXPORT_SYMBOL(__kernel_io_start);
 unsigned long __kernel_io_end;
-EXPORT_SYMBOL(__kernel_io_end);
 struct page *vmemmap;
 EXPORT_SYMBOL(vmemmap);
 unsigned long __pte_frag_nr;
-- 
2.20.1

