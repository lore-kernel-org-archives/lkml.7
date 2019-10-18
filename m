Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F923CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE28222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPmf9tCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504758AbfJRHvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504713AbfJRHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QO8e7mRWuY5KwaTgHvL34GvY00BplKjP8cDqEP1Ilak=; b=JPmf9tChbT8Td98Y6ylN50BqZu
        UU7dO91/XarLJJvLk/DxsmBPlk+2VwLtiKz1nFjI//8gkF2o98vMMpJpB9vfygzUp4dV18EILwoCi
        GMbCB9gXS3DOqvYhuHMhieON2f4Fwlw7mtBC99TbHytwXDHoy0fxXxISCtIXNgaR0NoDyJckNMMPC
        rxUm0dSQeRkGjVfP0FgDz5/rraun8uWaaOiHzDzOf8cN3aRfMwqthIPYmCHESVPAU30cVUBtYphJn
        0FR3HU0zRSWbSf2oY3h1FPeatQM9s9BxgfKUumLh8kkMYEtF+EWMmsHx+6ooiUzkczxSMf69559n/
        vEtqFnbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2d-0001PF-1J; Fri, 18 Oct 2019 07:51:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6DD53060DE;
        Fri, 18 Oct 2019 09:50:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 469AE2B178110; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.285927442@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 06/16] x86/mm: Remove set_kernel_text_r[ow]()
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the last and only user of these functions gone (ftrace) remove
them as well to avoid ever growing new users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/set_memory.h |    2 --
 arch/x86/mm/init_32.c             |   28 ----------------------------
 arch/x86/mm/init_64.c             |   36 ------------------------------------
 3 files changed, 66 deletions(-)

--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -80,8 +80,6 @@ int set_direct_map_invalid_noflush(struc
 int set_direct_map_default_noflush(struct page *page);
 
 extern int kernel_set_to_readonly;
-void set_kernel_text_rw(void);
-void set_kernel_text_ro(void);
 
 #ifdef CONFIG_X86_64
 static inline int set_mce_nospec(unsigned long pfn)
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -874,34 +874,6 @@ void arch_remove_memory(int nid, u64 sta
 
 int kernel_set_to_readonly __read_mostly;
 
-void set_kernel_text_rw(void)
-{
-	unsigned long start = PFN_ALIGN(_text);
-	unsigned long size = PFN_ALIGN(_etext) - start;
-
-	if (!kernel_set_to_readonly)
-		return;
-
-	pr_debug("Set kernel text: %lx - %lx for read write\n",
-		 start, start+size);
-
-	set_pages_rw(virt_to_page(start), size >> PAGE_SHIFT);
-}
-
-void set_kernel_text_ro(void)
-{
-	unsigned long start = PFN_ALIGN(_text);
-	unsigned long size = PFN_ALIGN(_etext) - start;
-
-	if (!kernel_set_to_readonly)
-		return;
-
-	pr_debug("Set kernel text: %lx - %lx for read only\n",
-		 start, start+size);
-
-	set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
-}
-
 static void mark_nxdata_nx(void)
 {
 	/*
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1260,42 +1260,6 @@ void __init mem_init(void)
 
 int kernel_set_to_readonly;
 
-void set_kernel_text_rw(void)
-{
-	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = PFN_ALIGN(__stop___ex_table);
-
-	if (!kernel_set_to_readonly)
-		return;
-
-	pr_debug("Set kernel text: %lx - %lx for read write\n",
-		 start, end);
-
-	/*
-	 * Make the kernel identity mapping for text RW. Kernel text
-	 * mapping will always be RO. Refer to the comment in
-	 * static_protections() in pageattr.c
-	 */
-	set_memory_rw(start, (end - start) >> PAGE_SHIFT);
-}
-
-void set_kernel_text_ro(void)
-{
-	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = PFN_ALIGN(__stop___ex_table);
-
-	if (!kernel_set_to_readonly)
-		return;
-
-	pr_debug("Set kernel text: %lx - %lx for read only\n",
-		 start, end);
-
-	/*
-	 * Set the kernel identity mapping for text RO.
-	 */
-	set_memory_ro(start, (end - start) >> PAGE_SHIFT);
-}
-
 void mark_rodata_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);


