Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABEAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974F221707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CffJBua1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfD3L3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:29:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57855 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfD3L3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:29:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBSFGg1350429
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:28:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBSFGg1350429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623696;
        bh=oDZ5KraJL4KgMsljNN1FiEACozdkKt3NmYXo5R8ae7E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CffJBua1JSJ8mVi7LKwDnpfEYh6QNMhQfKneGTrlzQp0Rb9IlvNqQf5fJFiYNS8q9
         lW1HIUAy5Rk+hiodiNjbzRdgfcT18dZbbgkZCuXCGZqdTMRoaPVz+U+osBbXtq+kvC
         grpd1WKaEk1Fc810E/b0zbvF4/b877LJt5BACwlkN7q3979fQ6ykeDzR9wWN9GbTZo
         THfnHkXbH9dazeu+EJsDNwmijsn46P9tPbSnmfAkMt/CtS00otuNy2pYH3/RJJHTC6
         kS0Ed70289R+tyjj6vUe7T6vACuNiUfi9rJ8eJByxhy83kZB5ZnXpMccVvg3u5WM4/
         qihrHt3rt9rdA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBSDm31350426;
        Tue, 30 Apr 2019 04:28:13 -0700
Date:   Tue, 30 Apr 2019 04:28:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rick Edgecombe <tipbot@zytor.com>
Message-ID: <tip-7fdfe1e40b225b1d163f9afed2fa3f04442dbaad@git.kernel.org>
Cc:     hpa@zytor.com, bp@alien8.de, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, akpm@linux-foundation.org,
        nadav.amit@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        rostedt@goodmis.org, linux_dti@icloud.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com, ard.biesheuvel@linaro.org,
        kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        riel@surriel.com, deneen.t.dock@intel.com, luto@kernel.org
Reply-To: linux_dti@icloud.com, dave.hansen@linux.intel.com,
          rostedt@goodmis.org, linux-kernel@vger.kernel.org,
          rick.p.edgecombe@intel.com, ard.biesheuvel@linaro.org,
          kristen@linux.intel.com, kernel-hardening@lists.openwall.com,
          deneen.t.dock@intel.com, luto@kernel.org, riel@surriel.com,
          bp@alien8.de, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          nadav.amit@gmail.com, will.deacon@arm.com,
          akpm@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20190426001143.4983-20-namit@vmware.com>
References: <20190426001143.4983-20-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/ftrace: Use vmalloc special flag
Git-Commit-ID: 7fdfe1e40b225b1d163f9afed2fa3f04442dbaad
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

Commit-ID:  7fdfe1e40b225b1d163f9afed2fa3f04442dbaad
Gitweb:     https://git.kernel.org/tip/7fdfe1e40b225b1d163f9afed2fa3f04442dbaad
Author:     Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate: Thu, 25 Apr 2019 17:11:39 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:38:00 +0200

x86/ftrace: Use vmalloc special flag

Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
permissioned memory in vmalloc and remove places where memory was set NX
and RW before freeing which is no longer needed.

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-20-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/ftrace.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 53ba1aa3a01f..0caf8122d680 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -678,12 +678,8 @@ static inline void *alloc_tramp(unsigned long size)
 {
 	return module_alloc(size);
 }
-static inline void tramp_free(void *tramp, int size)
+static inline void tramp_free(void *tramp)
 {
-	int npages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-	set_memory_nx((unsigned long)tramp, npages);
-	set_memory_rw((unsigned long)tramp, npages);
 	module_memfree(tramp);
 }
 #else
@@ -692,7 +688,7 @@ static inline void *alloc_tramp(unsigned long size)
 {
 	return NULL;
 }
-static inline void tramp_free(void *tramp, int size) { }
+static inline void tramp_free(void *tramp) { }
 #endif
 
 /* Defined as markers to the end of the ftrace default trampolines */
@@ -808,6 +804,8 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
+	set_vm_flush_reset_perms(trampoline);
+
 	/*
 	 * Module allocation needs to be completed by making the page
 	 * executable. The page is still writable, which is a security hazard,
@@ -816,7 +814,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
-	tramp_free(trampoline, *tramp_size);
+	tramp_free(trampoline);
 	return 0;
 }
 
@@ -947,7 +945,7 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
 		return;
 
-	tramp_free((void *)ops->trampoline, ops->trampoline_size);
+	tramp_free((void *)ops->trampoline);
 	ops->trampoline = 0;
 }
 
