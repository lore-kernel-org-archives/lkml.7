Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7C22087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="T17/nGyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfCYRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:21:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36686 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCYRVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:21:17 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FE201EC058B;
        Mon, 25 Mar 2019 18:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553534475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=bgBFiSQM43v7Hs420HJj2xTz3tnO+nUwb34AHAVIWvI=;
        b=T17/nGyfqGQFtmv9m6ES+vGF2OzGUt5OG+YCzBgEvyqSFfDejMIyLmC46aoPwA2vHZgzmX
        ROO4pH3i3dBgqxaIDrOH+9jTg4q/3IfsjM+KJ6lReZyqARTd0J20KS/azhQwvi+0OiuYNR
        nMEIkfjEeCTCbDhubySI2bzDlvmKyEU=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org
Subject: [PATCH] x86/mce: Remove mce_report_event()
Date:   Mon, 25 Mar 2019 18:21:21 +0100
Message-Id: <20190325172121.7926-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Calling this function has been wrong for a while now:

* Can't call schedule_work() in #MC context.

* mce_notify_irq() either.

* None of that noodling is needed anymore - all it needs to do is kick
the IRQ work which would self-IPI so that once the #MC handler is done,
the work queue will run and process queued MCE records.

So remove it.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/mce/core.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b7fb541a4873..ca031fc79769 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -460,23 +460,6 @@ static void mce_irq_work_cb(struct irq_work *entry)
 	mce_schedule_work();
 }
 
-static void mce_report_event(struct pt_regs *regs)
-{
-	if (regs->flags & (X86_VM_MASK|X86_EFLAGS_IF)) {
-		mce_notify_irq();
-		/*
-		 * Triggering the work queue here is just an insurance
-		 * policy in case the syscall exit notify handler
-		 * doesn't run soon enough or ends up running on the
-		 * wrong CPU (can happen when audit sleeps)
-		 */
-		mce_schedule_work();
-		return;
-	}
-
-	irq_work_queue(&mce_irq_work);
-}
-
 /*
  * Check if the address reported by the CPU is in a format we can parse.
  * It would be possible to add code for most other cases, but all would
@@ -1301,7 +1284,8 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		mce_panic("Fatal machine check on current CPU", &m, msg);
 
 	if (worst > 0)
-		mce_report_event(regs);
+		irq_work_queue(&mce_irq_work);
+
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 
 	sync_core();
-- 
2.21.0

