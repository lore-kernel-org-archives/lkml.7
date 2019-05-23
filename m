Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF11C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE22173E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfEWAn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:43:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60244 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfEWAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:43:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbpA-0004HG-H1; Wed, 22 May 2019 18:43:12 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnb-0005Z3-Nt; Wed, 22 May 2019 18:41:37 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:07 -0500
Message-Id: <20190523003916.20726-18-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnb-0005Z3-Nt;;;mid=<20190523003916.20726-18-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+NSKN9kc9oOZ73p1G7C7vPr8p5OGew4lA=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 17/26] signal/arm: Remove tsk parameter from __do_user_fault
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __do_user_fault function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This makes it clear that __do_user_fault calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/mm/fault.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 58f69fa07df9..324def0279b2 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -157,10 +157,11 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
  * User mode accesses just cause a SIGSEGV
  */
 static void
-__do_user_fault(struct task_struct *tsk, unsigned long addr,
-		unsigned int fsr, unsigned int sig, int code,
-		struct pt_regs *regs)
+__do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
+		int code, struct pt_regs *regs)
 {
+	struct task_struct *tsk = current;
+
 	if (addr > TASK_SIZE)
 		harden_branch_predictor();
 
@@ -196,7 +197,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * have no context to handle this fault with.
 	 */
 	if (user_mode(regs))
-		__do_user_fault(tsk, addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	else
 		__do_kernel_fault(mm, addr, fsr, regs);
 }
@@ -392,7 +393,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 			SEGV_ACCERR : SEGV_MAPERR;
 	}
 
-	__do_user_fault(tsk, addr, fsr, sig, code, regs);
+	__do_user_fault(addr, fsr, sig, code, regs);
 	return 0;
 
 no_context:
-- 
2.21.0

