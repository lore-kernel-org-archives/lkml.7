Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDACC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1420B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfEWAnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:43:22 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49796 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbfEWAnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:43:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp8-0002LN-Sc; Wed, 22 May 2019 18:43:10 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnO-0005Z3-JK; Wed, 22 May 2019 18:41:24 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:03 -0500
Message-Id: <20190523003916.20726-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnO-0005Z3-JK;;;mid=<20190523003916.20726-14-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Dez3gsl4HM7Z/Ie2zWYu2qafvElswi/Y=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 13/26] signal/sh: Remove tsk parameter from force_sig_info_fault
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The force_sig_info_fault function is always called with tsk == current.
Make that explicit by removing the tsk parameter.

This also makes it clear that the sh force_sig_info_fault passes
current into force_sig_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sh/mm/fault.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 6defd2c6d9b1..851a3cbb2b9c 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -39,10 +39,9 @@ static inline int notify_page_fault(struct pt_regs *regs, int trap)
 }
 
 static void
-force_sig_info_fault(int si_signo, int si_code, unsigned long address,
-		     struct task_struct *tsk)
+force_sig_info_fault(int si_signo, int si_code, unsigned long address)
 {
-	force_sig_fault(si_signo, si_code, (void __user *)address, tsk);
+	force_sig_fault(si_signo, si_code, (void __user *)address, current);
 }
 
 /*
@@ -244,8 +243,6 @@ static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, int si_code)
 {
-	struct task_struct *tsk = current;
-
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		/*
@@ -253,7 +250,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		 */
 		local_irq_enable();
 
-		force_sig_info_fault(SIGSEGV, si_code, address, tsk);
+		force_sig_info_fault(SIGSEGV, si_code, address);
 
 		return;
 	}
@@ -308,7 +305,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 	if (!user_mode(regs))
 		no_context(regs, error_code, address);
 
-	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
+	force_sig_info_fault(SIGBUS, BUS_ADRERR, address);
 }
 
 static noinline int
-- 
2.21.0

