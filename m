Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5A8C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D29A2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKPLv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:51:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKPLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbq-00026F-8F; Sat, 16 Nov 2019 12:51:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CDF0E1C0089;
        Sat, 16 Nov 2019 12:51:21 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:21 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/entry/32: Clarify register saving in __switch_to_asm()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508173.12247.7248719446712791567.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     a3ba966066afbe8fd0d3605ffe04c633083752f1
Gitweb:        https://git.kernel.org/tip/a3ba966066afbe8fd0d3605ffe04c633083752f1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 16 Nov 2019 11:12:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:07 +01:00

x86/entry/32: Clarify register saving in __switch_to_asm()

commit 6690e86be83a ("sched/x86: Save [ER]FLAGS on context switch")
re-introduced the flags saving on context switch to prevent AC leakage.

The pushf/popf instructions are right among the callee saved register
section, so the comment explaining the save/restore is not entirely
correct.

Add a seperate comment to pushf/popf explaining the reason.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f83ca5a..99fad6f 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -718,6 +718,11 @@ ENTRY(__switch_to_asm)
 	pushl	%ebx
 	pushl	%edi
 	pushl	%esi
+	/*
+	 * Flags are saved to prevent AC leakage. This could go
+	 * away if objtool would have 32bit support to verify
+	 * the STAC/CLAC correctness.
+	 */
 	pushfl
 
 	/* switch stack */
@@ -740,8 +745,9 @@ ENTRY(__switch_to_asm)
 	FILL_RETURN_BUFFER %ebx, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
 #endif
 
-	/* restore callee-saved registers */
+	/* Restore flags or the incoming task to restore AC state. */
 	popfl
+	/* restore callee-saved registers */
 	popl	%esi
 	popl	%edi
 	popl	%ebx
