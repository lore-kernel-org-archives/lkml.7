Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479D1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBF1206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfC2Ok3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:40:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfC2Ok2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:40:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TEeEcF3825205
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 07:40:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TEeEs63825202;
        Fri, 29 Mar 2019 07:40:14 -0700
Date:   Fri, 29 Mar 2019 07:40:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-39f0584ee695f1d75f4181b209602b9c49e73821@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, bp@suse.de,
        tglx@linutronix.de, tony.luck@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, tony.luck@intel.com, mingo@kernel.org,
          tglx@linutronix.de, bp@suse.de
In-Reply-To: <20190325172121.7926-1-bp@alien8.de>
References: <20190325172121.7926-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Remove mce_report_event()
Git-Commit-ID: 39f0584ee695f1d75f4181b209602b9c49e73821
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

Commit-ID:  39f0584ee695f1d75f4181b209602b9c49e73821
Gitweb:     https://git.kernel.org/tip/39f0584ee695f1d75f4181b209602b9c49e73821
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 12 Mar 2019 19:39:23 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 29 Mar 2019 15:34:03 +0100

x86/mce: Remove mce_report_event()

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
Link: https://lkml.kernel.org/r/20190325172121.7926-1-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c3498732ba28..58925e7ccb27 100644
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
@@ -1331,7 +1314,8 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		mce_panic("Fatal machine check on current CPU", &m, msg);
 
 	if (worst > 0)
-		mce_report_event(regs);
+		irq_work_queue(&mce_irq_work);
+
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 
 	sync_core();
