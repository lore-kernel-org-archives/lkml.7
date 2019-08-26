Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0191CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C922B22CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uhVLElhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfHZH4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:56:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfHZH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zget+pCt3umZfUG0WCmLYNL/w5Iqr6eWEgyqZS72DgQ=; b=uhVLElhVIYFnlVn7s7+KZyw8Zf
        /VgasgYE1A6v8vFUq+M3qOjCcGDYUcpTFPIT2Z1g+lRXlD1X5DImPoCFTO4J3Xbm3XxsSd4VCU87m
        +zD8WDOnHru4Cc4IPuoCCLSqGZnjT3woZCEv/c1BIeCO3GuW/aHpHEjnK+ZOS6S73o+HN2tD5Ksjn
        nNZQwgl/gYTO8oLUHxMtLBVU3OCdmmHUVt3gBNzjrGUcXPhrtNn8nJDrFpxr2UKUn3K/htWGsIyaR
        6npoBG55CxMzy/U+5kAtmuuwD49jWi4W0XvQOSKNbbI+qees+WGG/DJ8+0teX54H4MEfze9HZt9jH
        emwI3NuQ==;
Received: from [2001:4bb8:180:3f4c:c944:137d:e92e:5fab] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i29rG-0000TN-2a; Mon, 26 Aug 2019 07:56:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] x86: remove set_pages_x and set_pages_nx
Date:   Mon, 26 Aug 2019 09:55:56 +0200
Message-Id: <20190826075558.8125-4-hch@lst.de>
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

These wrappers don't provide a real benefit over just using
set_memory_x and set_memory_nx.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/set_memory.h  |  2 --
 arch/x86/kernel/machine_kexec_32.c |  4 ++--
 arch/x86/mm/init_32.c              |  2 +-
 arch/x86/mm/pageattr.c             | 16 ----------------
 4 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 899ec9ae7cff..fd549c3ebb17 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -75,8 +75,6 @@ int set_pages_array_wb(struct page **pages, int addrinarray);
 
 int set_pages_uc(struct page *page, int numpages);
 int set_pages_wb(struct page *page, int numpages);
-int set_pages_x(struct page *page, int numpages);
-int set_pages_nx(struct page *page, int numpages);
 int set_pages_ro(struct page *page, int numpages);
 int set_pages_rw(struct page *page, int numpages);
 
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 77854b192fef..7b45e8daad22 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -148,7 +148,7 @@ int machine_kexec_prepare(struct kimage *image)
 {
 	int error;
 
-	set_pages_x(image->control_code_page, 1);
+	set_memory_x((unsigned long)page_address(image->control_code_page), 1);
 	error = machine_kexec_alloc_page_tables(image);
 	if (error)
 		return error;
@@ -162,7 +162,7 @@ int machine_kexec_prepare(struct kimage *image)
  */
 void machine_kexec_cleanup(struct kimage *image)
 {
-	set_pages_nx(image->control_code_page, 1);
+	set_memory_nx((unsigned long)page_address(image->control_code_page), 1);
 	machine_kexec_free_page_tables(image);
 }
 
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 4068abb9427f..930edeb41ec3 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -916,7 +916,7 @@ static void mark_nxdata_nx(void)
 
 	if (__supported_pte_mask & _PAGE_NX)
 		printk(KERN_INFO "NX-protecting the kernel data: %luk\n", size >> 10);
-	set_pages_nx(virt_to_page(start), size >> PAGE_SHIFT);
+	set_memory_nx(start, size >> PAGE_SHIFT);
 }
 
 void mark_rodata_ro(void)
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 3be5d22c005a..0e39b344556d 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2103,22 +2103,6 @@ int set_pages_array_wb(struct page **pages, int numpages)
 }
 EXPORT_SYMBOL(set_pages_array_wb);
 
-int set_pages_x(struct page *page, int numpages)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	return set_memory_x(addr, numpages);
-}
-EXPORT_SYMBOL(set_pages_x);
-
-int set_pages_nx(struct page *page, int numpages)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	return set_memory_nx(addr, numpages);
-}
-EXPORT_SYMBOL(set_pages_nx);
-
 int set_pages_ro(struct page *page, int numpages)
 {
 	unsigned long addr = (unsigned long)page_address(page);
-- 
2.20.1

