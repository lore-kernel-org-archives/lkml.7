Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B6A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RYCQ8ywP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbfDQOLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:11:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33257 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfDQOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:11:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEAuQE3933975
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:10:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEAuQE3933975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510257;
        bh=ObJtQlIfE5Kix+3Q3qYB77YEJ9lkYqajY+SlmOz11uk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RYCQ8ywPt9LJEAEIOZhlmcW+DT1UXSghlzWpygQl+GOcsm7Kei4fUVRzxAJjF38Z7
         HXAqITAA78PV6I6KkELpML8H4OuTdYDTCupItVLwevVXLIlvMNfao5iBXceXK6r1LD
         M+Pdd2q/ervgkWSulkkeMuKxdj4DOin4TYQSGVC9EuPGXj9Dqrr9uJ1y4pEIyXgtip
         q37pxqDfqd+e5jVAZ9Hcb0hhRVd6A7s2mDJJOOg+J1D7n67JjuK2fmlcNKw53Z35Dd
         UP05HK/Wlr2HMRMsJtEG1qo+mkahOEBp3+oHU9aSRVv4aAl6BsK9PKTCO88uJdL7xk
         XqIphmCB0JaQg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEAtit3933972;
        Wed, 17 Apr 2019 07:10:55 -0700
Date:   Wed, 17 Apr 2019 07:10:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d876b67343a648f3613506c7dbfed088fa0c875b@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, sean.j.christopherson@intel.com,
        mingo@kernel.org, jpoimboe@redhat.com, peterz@infradead.org,
        bp@suse.de, hpa@zytor.com, mingo@redhat.com, x86@kernel.org,
        tglx@linutronix.de, luto@kernel.org, linux-kernel@vger.kernel.org
Reply-To: mingo@redhat.com, x86@kernel.org, bp@suse.de, tglx@linutronix.de,
          luto@kernel.org, linux-kernel@vger.kernel.org,
          dave.hansen@linux.intel.com, sean.j.christopherson@intel.com,
          mingo@kernel.org, hpa@zytor.com, jpoimboe@redhat.com,
          peterz@infradead.org
In-Reply-To: <20190414160144.784487230@linutronix.de>
References: <20190414160144.784487230@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/traps: Use cpu_entry_area instead of orig_ist
Git-Commit-ID: d876b67343a648f3613506c7dbfed088fa0c875b
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

Commit-ID:  d876b67343a648f3613506c7dbfed088fa0c875b
Gitweb:     https://git.kernel.org/tip/d876b67343a648f3613506c7dbfed088fa0c875b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:50 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 13:01:59 +0200

x86/traps: Use cpu_entry_area instead of orig_ist

The orig_ist[] array is a shadow copy of the IST array in the TSS. The
reason why it exists is that older kernels used two TSS variants with
different pointers into the debug stack. orig_ist[] contains the real
starting points.

There is no point anymore to do so because the same information can be
retrieved using the base address of the cpu entry area mapping and the
offsets of the various exception stacks.

No functional change. Preparation for removing orig_ist.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.784487230@linutronix.de
---
 arch/x86/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 0524e1d74f24..06c089513d39 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -28,6 +28,7 @@
 #include <asm/mmu_context.h>		/* vma_pkey()			*/
 #include <asm/efi.h>			/* efi_recover_from_page_fault()*/
 #include <asm/desc.h>			/* store_idt(), ...		*/
+#include <asm/cpu_entry_area.h>		/* exception stack		*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -793,7 +794,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_vmalloc_addr((void *)address) &&
 	    (((unsigned long)tsk->stack - 1 - address < PAGE_SIZE) ||
 	     address - ((unsigned long)tsk->stack + THREAD_SIZE) < PAGE_SIZE)) {
-		unsigned long stack = this_cpu_read(orig_ist.ist[ESTACK_DF]) - sizeof(void *);
+		unsigned long stack = __this_cpu_ist_top_va(DF) - sizeof(void *);
 		/*
 		 * We're likely to be running with very little stack space
 		 * left.  It's plausible that we'd hit this condition but
