Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFB2C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD2F21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfD3RFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:05:38 -0400
Received: from foss.arm.com ([217.140.101.70]:50430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfD3RFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:05:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF5B374;
        Tue, 30 Apr 2019 10:05:35 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54B483F5C1;
        Tue, 30 Apr 2019 10:05:32 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v3 2/4] x86: simplify _TIF_SYSCALL_EMU handling
Date:   Tue, 30 Apr 2019 18:05:18 +0100
Message-Id: <20190430170520.29470-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430170520.29470-1-sudeep.holla@arm.com>
References: <20190430170520.29470-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of emulated/_TIF_SYSCALL_EMU flags in syscall_trace_enter
seems to be bit overcomplicated than required. Let's simplify it.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/x86/entry/common.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7bc105f47d21..c647ddfd5579 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -70,23 +70,18 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	struct thread_info *ti = current_thread_info();
 	unsigned long ret = 0;
-	bool emulated = false;
 	u32 work;
 
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 		BUG_ON(regs != task_pt_regs(current));
 
-	work = READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
+	work = READ_ONCE(ti->flags);
 
-	if (unlikely(work & _TIF_SYSCALL_EMU))
-		emulated = true;
-
-	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
-	    tracehook_report_syscall_entry(regs))
-		return -1L;
-
-	if (emulated)
-		return -1L;
+	if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
+		ret = tracehook_report_syscall_entry(regs);
+		if (ret || (work & _TIF_SYSCALL_EMU))
+			return -1L;
+	}
 
 #ifdef CONFIG_SECCOMP
 	/*
-- 
2.17.1

