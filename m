Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE2C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F8920862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EpYk8kaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEOAbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:31:40 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:38622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbfEOAaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:10 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2BD98C01E5;
        Wed, 15 May 2019 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557880215; bh=zoCTft68JktbsggQz6TW+TG89hjYIxyCWbFeh7G+lg4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=EpYk8kaWid8FQBKfJdGrhLXxVpGOeb1N4dWenHNLmFcJioi4AS39WFurV1uxKVlIm
         V5wM6MKd80saj10PfiNlsgi//Pu0DRYsDZZqej121oDgyoM8BDohqL3KVLdX/YGp2H
         VsGadn4JiLz65/sb/QYi7G/sEtCKLjBUu/Y+FOvQ0c+XrOHo1m22f0JHQxgn42e2Q8
         E+I5bO7/WijqDxswUmuaIJoFiTMB+FS14U8EFgbqptKTOvOOenGZyszSyVehmduL50
         EPXc/lT2VwRWbrTmoi4P/UViXmXjRNF818JklZPvQA/emHA+OB7CEGodW7gJB9+j7A
         u0EUIfSNEAlYQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B2CF7A0378;
        Wed, 15 May 2019 00:30:08 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 May 2019 17:30:08 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:04 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:16 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <paltsev@snyopsys.com>, <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma access permission code
Date:   Tue, 14 May 2019 17:29:31 -0700
Message-ID: <1557880176-24964-5-git-send-email-vgupta@synopsys.com>
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

The coding pattern to NOT intialize variables at declaration time but
rather near code which makes us eof them makes it much easier to grok
the overall logic, specially when the init is not simply 0 or 1

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/fault.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index f1175685d914..ae890a8d5ebf 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -67,9 +67,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	int si_code = SEGV_MAPERR;
+	unsigned int write = 0, exec = 0, mask;
 	vm_fault_t fault;
-	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	unsigned int flags;
 
 	/*
 	 * NOTE! We MUST NOT take any locks for this case. We may
@@ -91,8 +91,18 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	if (faulthandler_disabled() || !mm)
 		goto no_context;
 
+	if (regs->ecr_cause & ECR_C_PROTV_STORE)	/* ST/EX */
+		write = 1;
+	else if ((regs->ecr_vec == ECR_V_PROTV) &&
+	         (regs->ecr_cause == ECR_C_PROTV_INST_FETCH))
+		exec = 1;
+
+	flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+	if (write)
+		flags |= FAULT_FLAG_WRITE;
+
 retry:
 	down_read(&mm->mmap_sem);
 
@@ -105,24 +115,17 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	}
 
 	/*
-	 * Ok, we have a good vm_area for this memory access, so
-	 * we can handle it..
+	 * vm_area is good, now check permissions for this memory access
 	 */
-	si_code = SEGV_ACCERR;
-
-	/* Handle protection violation, execute on heap or stack */
-
-	if ((regs->ecr_vec == ECR_V_PROTV) &&
-	    (regs->ecr_cause == ECR_C_PROTV_INST_FETCH))
+	mask = VM_READ;
+	if (write)
+		mask = VM_WRITE;
+	if (exec)
+		mask = VM_EXEC;
+
+	if (!(vma->vm_flags & mask)) {
+		si_code = SEGV_ACCERR;
 		goto bad_area;
-
-	if (write) {
-		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;
-		flags |= FAULT_FLAG_WRITE;
-	} else {
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
-			goto bad_area;
 	}
 
 	/*
-- 
2.7.4

