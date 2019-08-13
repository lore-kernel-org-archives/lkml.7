Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F77C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E07420840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jzWEnGhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfHMJCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:02:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfHMJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rwawfSmb1AGqD9EUztZX7iOxqE00kp2qBT1NnM3L8EE=; b=jzWEnGhDyuUs/Xztk9bAldlrCL
        TT3mbvpcwRiez6Qr/bfQeAGr6GiGDLEBOwvYOEaE4tny/QgYmRlRrDlPiiWWUa+zdQrwGVr225os4
        6bHBUFMCKS2vSEmeUSChZ2NcL+x4kce8ziOHKiohPsIrO+0HYfmSdbYZBDMwxjnk8cxJN7Cy0ZTUY
        7gg3iE8TcwZ0UXy20KD78ob+8B+O9eCPP9Zqwk/uR6PRYBJyWj+U/iqLA52F2QhYJgg3xaBZ11Gas
        gHa8cqEgZGhp5Cm52y694WTFleZFyUdQuRiW2Wug8k5dAHjacmQVfLHEGH+IjLYwVUVCYCmiMQ9Nj
        /wrh+0vg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxSgw-0006a0-L3; Tue, 13 Aug 2019 09:02:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] x86: remove the unused set_pages_array_wt function
Date:   Tue, 13 Aug 2019 11:01:46 +0200
Message-Id: <20190813090146.26377-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813090146.26377-1-hch@lst.de>
References: <20190813090146.26377-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

