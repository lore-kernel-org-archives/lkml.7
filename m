Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF26C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1D121D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFipmywM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfJGLZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58230 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfJGLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QO8e7mRWuY5KwaTgHvL34GvY00BplKjP8cDqEP1Ilak=; b=IFipmywM9cQhZo8aqG1HiYdiUr
        InNnf9nA9+qO4sDoZKzmRCu0mzzzKUk0OkFtogTxWQna7xUzogbvNjn42of5oqOzVL2eq2Hm+QMqz
        cC0nz6mOcEv3fmuSfJQ4u1hEpLVrAHfq0yB+xt+9wLTgzJLNeJO7PWzir6i1NTTnP7PU5cle0GIzO
        dgG9TmBnIrN63TzsS2dU2lR0O1CVuLfyQOVs9cKSTqmC5PYFKS+ACGg/Xmd3PNe7qmcSxV7j4HOVc
        DX80RFWZyhweo/2qQ7J02xLdo33mGsNzUWHOvkjy2m5dtPCAkGh4+AiWo20YOyrgbXgDxVkixd++M
        mb61QWoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6v-0002B0-AI; Mon, 07 Oct 2019 11:23:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E23793062B5;
        Mon,  7 Oct 2019 13:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 804D720244FAD; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007081945.16603540.3@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:17:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v3 6/6] x86/mm: Remove set_kernel_text_r[ow]()
References: <20191007081716.07616230.8@infradead.org>
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


