Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5449EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C1020840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C15qqr+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfHMJCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:02:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfHMJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FUlJEy6CBiJvhG3pjK4RPkIerKB4OM0ZbOePf3wNMQ0=; b=C15qqr+SrNMwi3adZ8J1uRciNM
        QexaR7UkgwwAANWoqB2VZgbERqNDSfsvFWKM8CuZMtwUHkM7faKSr6DE8Dgyv25U9A2AJdjjSRDI0
        u0H+D7v3/4SURGWFYpYv9Vg9QKVJd8Ii8cEu6u+bbixHG8sTnHpXHXAGq23kge3KfOXqZvJpaK0mH
        NnQT3rcKTKDhTXu07FyEI9oB+4VxQ92T52P87JP22XaBPLIOs0BUTBbOEN/5Dl41W6gtUppoguHEu
        etgZj2m94qJ3p3+rW/0/m2fL4iftysRZU8yzsfu82KlniGOKSpMp0gw5G0BeeHFE+NmssWwyx3qIC
        lxGNDvtQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxSgr-0006Um-1T; Tue, 13 Aug 2019 09:02:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] x86: remove set_memory_x and set_memory_nx
Date:   Tue, 13 Aug 2019 11:01:44 +0200
Message-Id: <20190813090146.26377-5-hch@lst.de>
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

These wrappers don't provide a real benefit over just using
set_memory_x and set_memory_nx.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

