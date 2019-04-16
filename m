Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FC7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2F52073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KMLq8vBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfDPIDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:03:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDPIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TW8PGBx7kunZJN2Y1HJoHs2KrbhzullLyGfZjeeHZdA=; b=KMLq8vBC2cp3ng50OTZORdsI22
        x6drZIuzUTj1OQU5IHmc12LWrtXTK7r1HVw3hEP8GVvsQeDyNn3dpVd9cxebIUDrmIsnras6G8cOX
        63x52qmjEMsYFp3FhmJvDsDjVLOh4bqBrEavGkjL0M/GTVO2uPo0ziTR2c7Ebfxlpxih9Z1mSOdTX
        j/1paH1dKN28B1MG+up5Yur/5q3CaQWl4JrzrT1Ll2eHCRZIzzOVsWQ6mc5A4HNBJWWXu6qle7QE/
        NH3Lkb3dBrR8axBjHCIxXBrSC6Qb5PcAD6/1gK36+MhC4aDFqwrJazZd5MHKmumEJSvDKs75k5uws
        uKIGYwzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGJ47-0000mC-9E; Tue, 16 Apr 2019 08:03:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED591981E5B; Tue, 16 Apr 2019 10:03:35 +0200 (CEST)
Date:   Tue, 16 Apr 2019 10:03:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] x86/tlb: Revert: Align TLB invalidation info
Message-ID: <20190416080335.GM7905@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It was found that under some .config options (notably L1_CACHE_SHIFT=7)
and compiler combinations this on-stack alignment leads to a 320 byte
stack usage, which then triggers a KASAN stack warning elsewhere.

Using 320 bytes of stack space for a 40 byte structure is ludicrous and
clearly not right.

Fixes: 515ab7c41306 ("x86/mm: Align TLB invalidation info")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
Index: linux-2.6/arch/x86/mm/tlb.c
===================================================================
--- linux-2.6.orig/arch/x86/mm/tlb.c
+++ linux-2.6/arch/x86/mm/tlb.c
@@ -728,7 +728,7 @@ void flush_tlb_mm_range(struct mm_struct
 {
 	int cpu;
 
-	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
+	struct flush_tlb_info info = {
 		.mm = mm,
 		.stride_shift = stride_shift,
 		.freed_tables = freed_tables,
