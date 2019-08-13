Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCCDC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ABB20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="an3Pfxnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfHMJCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:02:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfHMJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lqdoWtcd1AW3aKCuxfQXwAPBONWCZOJVZdepAPW+mjA=; b=an3PfxnvMUpkrphEgHvLOHO+/U
        j+vPcPCJx6n+RX8FDfr8Y0CAR1H7FpWdVpkpYjro2ri/JDj0cb2k3kWMHeIQt6rY0hqTE6o5LUPBJ
        z8Fao/kzAOoMxOisLZ4OMs9ON/T+s2ptqzc+9J2mNQTvYqAjwMFSB4pPW38AZ5upgbiJ8e4u9RJK0
        r0oXDCEv0bHbOveIds3srhIwhMROjix63OgiFVKH8gXYY67GGjwAR3YCtGyfWY0j0rwwRtflaFFzG
        iXeg9uGttWkVam1RuUnGVZ6ZaNqHDc4S5VpL1zB4EuzBFpjeipm26+YaEFfcMyxXEvftwHZFjLo7A
        q6/P55og==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxSgo-0006S8-Fv; Tue, 13 Aug 2019 09:01:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] x86: remove the unused set_memory_array_* functions
Date:   Tue, 13 Aug 2019 11:01:43 +0200
Message-Id: <20190813090146.26377-4-hch@lst.de>
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
 arch/x86/include/asm/set_memory.h |  5 ---
 arch/x86/mm/pageattr.c            | 75 -------------------------------
 2 files changed, 80 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ae7b909dc242..899ec9ae7cff 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -48,11 +48,6 @@ int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 int set_memory_np_noalias(unsigned long addr, int numpages);
 
-int set_memory_array_uc(unsigned long *addr, int addrinarray);
-int set_memory_array_wc(unsigned long *addr, int addrinarray);
-int set_memory_array_wt(unsigned long *addr, int addrinarray);
-int set_memory_array_wb(unsigned long *addr, int addrinarray);
-
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
 int set_pages_array_wt(struct page **pages, int addrinarray);
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index a02ca8986299..3be5d22c005a 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1809,63 +1809,6 @@ int set_memory_uc(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_uc);
 
-static int _set_memory_array(unsigned long *addr, int numpages,
-		enum page_cache_mode new_type)
-{
-	enum page_cache_mode set_type;
-	int i, j;
-	int ret;
-
-	for (i = 0; i < numpages; i++) {
-		ret = reserve_memtype(__pa(addr[i]), __pa(addr[i]) + PAGE_SIZE,
-					new_type, NULL);
-		if (ret)
-			goto out_free;
-	}
-
-	/* If WC, set to UC- first and then WC */
-	set_type = (new_type == _PAGE_CACHE_MODE_WC) ?
-				_PAGE_CACHE_MODE_UC_MINUS : new_type;
-
-	ret = change_page_attr_set(addr, numpages,
-				   cachemode2pgprot(set_type), 1);
-
-	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
-		ret = change_page_attr_set_clr(addr, numpages,
-					       cachemode2pgprot(
-						_PAGE_CACHE_MODE_WC),
-					       __pgprot(_PAGE_CACHE_MASK),
-					       0, CPA_ARRAY, NULL);
-	if (ret)
-		goto out_free;
-
-	return 0;
-
-out_free:
-	for (j = 0; j < i; j++)
-		free_memtype(__pa(addr[j]), __pa(addr[j]) + PAGE_SIZE);
-
-	return ret;
-}
-
-int set_memory_array_uc(unsigned long *addr, int numpages)
-{
-	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_UC_MINUS);
-}
-EXPORT_SYMBOL(set_memory_array_uc);
-
-int set_memory_array_wc(unsigned long *addr, int numpages)
-{
-	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_WC);
-}
-EXPORT_SYMBOL(set_memory_array_wc);
-
-int set_memory_array_wt(unsigned long *addr, int numpages)
-{
-	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_WT);
-}
-EXPORT_SYMBOL_GPL(set_memory_array_wt);
-
 int _set_memory_wc(unsigned long addr, int numpages)
 {
 	int ret;
@@ -1942,24 +1885,6 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
-int set_memory_array_wb(unsigned long *addr, int numpages)
-{
-	int i;
-	int ret;
-
-	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-	ret = change_page_attr_clear(addr, numpages,
-				      __pgprot(_PAGE_CACHE_MASK), 1);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < numpages; i++)
-		free_memtype(__pa(addr[i]), __pa(addr[i]) + PAGE_SIZE);
-
-	return 0;
-}
-EXPORT_SYMBOL(set_memory_array_wb);
-
 int set_memory_x(unsigned long addr, int numpages)
 {
 	if (!(__supported_pte_mask & _PAGE_NX))
-- 
2.20.1

