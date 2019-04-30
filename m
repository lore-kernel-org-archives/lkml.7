Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7B720675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wIbco+ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfD3LWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:22:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfD3LWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:22:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBLOdF1347765
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:21:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBLOdF1347765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623285;
        bh=MXsBRDRKJauN6z5k6R/bDOZGULB2Ad+70N9h6P0ENtM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wIbco+kaQEDNXehFk4GA8CAk2aOIV243zICGlYMC2RNLL3oYzybyEKRpqJv1/uYmI
         s5wmqxv/JbdeCxyuOj4TkvLRaXFPy+4XJFOHy/j1zTupASaYNktOYkJgsCbYjaZGDB
         Q9o+s9+fTMz3lUbojDi43QnrFR3y/66WOOXx48bFUG7NAXj/lOiu89NbN7OGSj3hpT
         2YxT0eIrwjRgQO8onIu0AFuQc+odnovb3Nd8CgEJEj0muP3+aiA5cmiUUT8mzdjUYZ
         8cYPh8vgEkWnvfmPq4mKYGs+5sUmaSH1+NOrtnBvEBbGLva/TLHPtqFiqE5EfH7f6p
         M3Dai51YDslBw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBLNMb1347762;
        Tue, 30 Apr 2019 04:21:23 -0700
Date:   Tue, 30 Apr 2019 04:21:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-3c0dab44e22782359a0a706cbce72de99a22aa75@git.kernel.org>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, akpm@linux-foundation.org,
        linux_dti@icloud.com, dave.hansen@linux.intel.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        rick.p.edgecombe@intel.com, will.deacon@arm.com,
        rostedt@goodmis.org, namit@vmware.com, deneen.t.dock@intel.com,
        kristen@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com, riel@surriel.com
Reply-To: kernel-hardening@lists.openwall.com,
          linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
          ard.biesheuvel@linaro.org, linux_dti@icloud.com,
          akpm@linux-foundation.org, dave.hansen@linux.intel.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          will.deacon@arm.com, rick.p.edgecombe@intel.com,
          rostedt@goodmis.org, namit@vmware.com, deneen.t.dock@intel.com,
          mingo@kernel.org, peterz@infradead.org, kristen@linux.intel.com,
          riel@surriel.com, hpa@zytor.com
In-Reply-To: <20190426001143.4983-10-namit@vmware.com>
References: <20190426001143.4983-10-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/ftrace: Set trampoline pages as executable
Git-Commit-ID: 3c0dab44e22782359a0a706cbce72de99a22aa75
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3c0dab44e22782359a0a706cbce72de99a22aa75
Gitweb:     https://git.kernel.org/tip/3c0dab44e22782359a0a706cbce72de99a22aa75
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:29 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:53 +0200

x86/ftrace: Set trampoline pages as executable

Since alloc_module() will not set the pages as executable soon, set
ftrace trampoline pages as executable after they are allocated.

For the time being, do not change ftrace to use the text_poke()
interface. As a result, ftrace still breaks W^X.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-10-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/ftrace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index ef49517f6bb2..53ba1aa3a01f 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -730,6 +730,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long end_offset;
 	unsigned long op_offset;
 	unsigned long offset;
+	unsigned long npages;
 	unsigned long size;
 	unsigned long retq;
 	unsigned long *ptr;
@@ -762,6 +763,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		return 0;
 
 	*tramp_size = size + RET_SIZE + sizeof(void *);
+	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
 	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
@@ -806,6 +808,12 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
+	/*
+	 * Module allocation needs to be completed by making the page
+	 * executable. The page is still writable, which is a security hazard,
+	 * but anyhow ftrace breaks W^X completely.
+	 */
+	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
 	tramp_free(trampoline, *tramp_size);
