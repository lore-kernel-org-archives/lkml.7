Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6304C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B96C21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfDENNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:13:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfDENNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:13:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35DDJa12765940
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 06:13:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35DDJ5G2765937;
        Fri, 5 Apr 2019 06:13:19 -0700
Date:   Fri, 5 Apr 2019 06:13:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-b5b447b6b4e899e0978b95cb42d272978f8c7b4d@git.kernel.org>
Cc:     hpa@zytor.com, bp@alien8.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        valentin.schneider@arm.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
          tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
          valentin.schneider@arm.com
In-Reply-To: <20190311224752.8337-14-valentin.schneider@arm.com>
References: <20190311224752.8337-14-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/entry: Remove unneeded need_resched() loop
Git-Commit-ID: b5b447b6b4e899e0978b95cb42d272978f8c7b4d
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

Commit-ID:  b5b447b6b4e899e0978b95cb42d272978f8c7b4d
Gitweb:     https://git.kernel.org/tip/b5b447b6b4e899e0978b95cb42d272978f8c7b4d
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 11 Mar 2019 22:47:51 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 15:08:03 +0200

x86/entry: Remove unneeded need_resched() loop

Since the enabling and disabling of IRQs within preempt_schedule_irq() is
contained in a need_resched() loop, there is no need for the outer
architecture specific loop.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20190311224752.8337-14-valentin.schneider@arm.com

---
 arch/x86/entry/entry_32.S | 3 +--
 arch/x86/entry/entry_64.S | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d309f30cf7af..b1856fe9decf 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -766,13 +766,12 @@ END(ret_from_exception)
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
 	DISABLE_INTERRUPTS(CLBR_ANY)
-.Lneed_resched:
 	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	restore_all_kernel
 	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
 	jz	restore_all_kernel
 	call	preempt_schedule_irq
-	jmp	.Lneed_resched
+	jmp	restore_all_kernel
 END(resume_kernel)
 #endif
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..e7e270603fe7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -645,10 +645,9 @@ retint_kernel:
 	/* Check if we need preemption */
 	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
 	jnc	1f
-0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
+	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	1f
 	call	preempt_schedule_irq
-	jmp	0b
 1:
 #endif
 	/*
