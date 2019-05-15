Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64561C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3274021734
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iAAAIgAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfEOAa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:30:28 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:38642 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbfEOAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:24 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B03D3C125E;
        Wed, 15 May 2019 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557880228; bh=CkssZQXbYGkx2a0Vqjl+j1ujpM6IPwBxaO1c+mSzFC8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iAAAIgADu34z/litm3pucblHNQRXJlaflfx52hSVCbmaB1nNtutAfZ4AO8V91VFkT
         UPiirFkjjjLb3rWrp+3wYOfvDNyOJA7Lo37dKWIMLAHYLQLVss7al+CWoDfsnqO0j7
         /brEta0Gkb0ajB0JbfwWuO428hPdnIGuEb5jKSyl6SLG+wuFq9LJwTWCJHdbodQ1+Q
         5xRfD8jj92p5RhNBJMuDH0kY9gQ8HVNsl1cOYstUkagSlv367SfY2LygaWqon58rcJ
         iVSj2uY9bSDUreQpAM8UTCiElm0YJ7cGGTelAA84OgZarcc0phXPsmF6/yUuGGtdWB
         KErzE9oY9CcfQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8F22CA023D;
        Wed, 15 May 2019 00:30:23 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 May 2019 17:30:21 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:18 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:29 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <paltsev@snyopsys.com>, <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 8/9] ARC: mm: do_page_fault refactor #7: fold the various error handling
Date:   Tue, 14 May 2019 17:29:35 -0700
Message-ID: <1557880176-24964-9-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.182.230]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - single up_read() call vs. 4
 - so much easier on eyes

Technically it seems like @bad_area label moved up, but even in old
regime, it was a special case of delivering SIGSEGV unconditionally
which we now do as well, although with checks.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/fault.c | 46 +++++++++++++---------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 0e1a222a97ad..20402217d9da 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -66,7 +66,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	int si_code = SEGV_MAPERR;
+	int sig, si_code = SEGV_MAPERR;
 	unsigned int write = 0, exec = 0, mask;
 	vm_fault_t fault;			/* handle_mm_fault() output */
 	unsigned int flags;			/* handle_mm_fault() input */
@@ -177,47 +177,27 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		return;
 	}
 
-	if (fault & VM_FAULT_OOM)
-		goto out_of_memory;
-	else if (fault & VM_FAULT_SIGSEGV)
-		goto bad_area;
-	else if (fault & VM_FAULT_SIGBUS)
-		goto do_sigbus;
-
-	/* no man's land */
-	BUG();
-
-	/*
-	 * Something tried to access memory that isn't in our memory map..
-	 * Fix it, but check if it's kernel or user first..
-	 */
 bad_area:
 	up_read(&mm->mmap_sem);
 
 	if (!user_mode(regs))
 		goto no_context;
 
-	tsk->thread.fault_address = address;
-	force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
-	return;
-
-out_of_memory:
-	up_read(&mm->mmap_sem);
-
-	if (!user_mode(regs))
-		goto no_context;
-
-	pagefault_out_of_memory();
-	return;
-
-do_sigbus:
-	up_read(&mm->mmap_sem);
+	if (fault & VM_FAULT_OOM) {
+		pagefault_out_of_memory();
+		return;
+	}
 
-	if (!user_mode(regs))
-		goto no_context;
+	if (fault & VM_FAULT_SIGBUS) {
+		sig = SIGBUS;
+		si_code = BUS_ADRERR;
+	}
+	else {
+		sig = SIGSEGV;
+	}
 
 	tsk->thread.fault_address = address;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
+	force_sig_fault(sig, si_code, (void __user *)address, tsk);
 	return;
 
 no_context:
-- 
2.7.4

