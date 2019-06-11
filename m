Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79184C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486A7205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfFKO4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:56:39 -0400
Received: from foss.arm.com ([217.140.110.172]:35194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387887AbfFKO4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:56:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7FC3337;
        Tue, 11 Jun 2019 07:56:38 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB9203F246;
        Tue, 11 Jun 2019 07:56:36 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v5 2/4] x86/entry: Simplify _TIF_SYSCALL_EMU handling
Date:   Tue, 11 Jun 2019 15:56:27 +0100
Message-Id: <20190611145627.23229-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523090618.13410-3-sudeep.holla@arm.com>
References: <20190523090618.13410-3-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of emulated and _TIF_SYSCALL_EMU flags in syscall_trace_enter
is more complicated than required.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/x86/entry/common.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

Hi Catalin,

I assume you can now pick up this patch.

Regards,
Sudeep

v4->v5: Updated changelog as suggested by tglx and added his Reviewed-by

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index a986b3c8294c..0a61705d62ec 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -72,23 +72,18 @@ static long syscall_trace_enter(struct pt_regs *regs)

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

