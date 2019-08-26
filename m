Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B073CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CF92173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UnuXcMwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfHZH4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:56:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfHZH4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SYmiLbGTOl0WdS0M617/9YQ43Zcpg//4hAdKFxpT+xk=; b=UnuXcMwlAsFZefl4Q8syz+TMle
        R1095IAR00Wlm97ZyyAP1L2Nx1N66a54MEAXotU+beyhz/QMJovzkGNocre6P81ncK7YKSNuGwCw7
        1kkuirnu9ikL2MDaLBGOLf2IMeZmQ8nISQYCRaChPwkCH4pgwiD8l8PD/c+XGY5VTh+ybjUjA2o0u
        q1x1exsrsdWVYzNAluwUWWVOSLrNNiYhuQGmIv/Fqr+81S05qU4F4DQmJ6A07oRLz3D6MI+ZiZn+8
        OaO7CECOJGu9jhEwxeAiwrfkoD5fdq8beCgZ/ivegnttLRR2t71xxEzDT/2vIWI6RTHdfKiS+x+At
        c/HBSS9g==;
Received: from [2001:4bb8:180:3f4c:c944:137d:e92e:5fab] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i29rM-0000ad-VF; Mon, 26 Aug 2019 07:56:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] x86: remove the unused set_pages_array_wt function
Date:   Mon, 26 Aug 2019 09:55:58 +0200
Message-Id: <20190826075558.8125-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826075558.8125-1-hch@lst.de>
References: <20190826075558.8125-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/set_memory.h | 1 -
 arch/x86/mm/pageattr.c            | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 2ee8e469dcf5..cff5e07c1e19 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -49,7 +49,6 @@ int set_memory_np_noalias(unsigned long addr, int numpages);
 
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
-int set_pages_array_wt(struct page **pages, int addrinarray);
 int set_pages_array_wb(struct page **pages, int addrinarray);
 
 /*
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 9acd568c4faa..255c90d6aaa7 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2047,12 +2047,6 @@ int set_pages_array_wc(struct page **pages, int numpages)
 }
 EXPORT_SYMBOL(set_pages_array_wc);
 
-int set_pages_array_wt(struct page **pages, int numpages)
-{
-	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WT);
-}
-EXPORT_SYMBOL_GPL(set_pages_array_wt);
-
 int set_pages_wb(struct page *page, int numpages)
 {
 	unsigned long addr = (unsigned long)page_address(page);
-- 
2.20.1

