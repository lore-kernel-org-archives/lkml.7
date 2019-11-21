Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A41C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AAB206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKUUOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:14:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33406 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfKUUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:14:33 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXsqP-0004fR-Sn; Thu, 21 Nov 2019 21:14:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8345D1C1A4E;
        Thu, 21 Nov 2019 21:14:25 +0100 (CET)
Date:   Thu, 21 Nov 2019 20:14:25 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/32: Use %ss segment where required
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157436726542.21853.6281078128223109069.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4c4fd55d3d59a41ddfa6ecba7e76928921759f43
Gitweb:        https://git.kernel.org/tip/4c4fd55d3d59a41ddfa6ecba7e76928921759f43
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 09:49:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Nov 2019 19:37:43 +01:00

x86/entry/32: Use %ss segment where required

When re-building the IRET frame we use %eax as an destination %esp,
make sure to then also match the segment for when there is a nonzero
SS base (ESPFIX).

[peterz: Changelog and minor edits]
Fixes: 3c88c692c287 ("x86/stackframe/32: Provide consistent pt_regs")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
---
 arch/x86/entry/entry_32.S | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f4335ac..341597e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -210,6 +210,8 @@
 	/*
 	 * The high bits of the CS dword (__csh) are used for CS_FROM_*.
 	 * Clear them in case hardware didn't do this for us.
+	 *
+	 * Be careful: we may have nonzero SS base due to ESPFIX.
 	 */
 	andl	$0x0000ffff, 3*4(%esp)
 
@@ -263,6 +265,13 @@
 .endm
 
 .macro IRET_FRAME
+	/*
+	 * We're called with %ds, %es, %fs, and %gs from the interrupted
+	 * frame, so we shouldn't use them.  Also, we may be in ESPFIX
+	 * mode and therefore have a nonzero SS base and an offset ESP,
+	 * so any attempt to access the stack needs to use SS.  (except for
+	 * accesses through %esp, which automatically use SS.)
+	 */
 	testl $CS_FROM_KERNEL, 1*4(%esp)
 	jz .Lfinished_frame_\@
 
@@ -276,20 +285,20 @@
 	movl	5*4(%esp), %eax		# (modified) regs->sp
 
 	movl	4*4(%esp), %ecx		# flags
-	movl	%ecx, -4(%eax)
+	movl	%ecx, %ss:-1*4(%eax)
 
 	movl	3*4(%esp), %ecx		# cs
 	andl	$0x0000ffff, %ecx
-	movl	%ecx, -8(%eax)
+	movl	%ecx, %ss:-2*4(%eax)
 
 	movl	2*4(%esp), %ecx		# ip
-	movl	%ecx, -12(%eax)
+	movl	%ecx, %ss:-3*4(%eax)
 
 	movl	1*4(%esp), %ecx		# eax
-	movl	%ecx, -16(%eax)
+	movl	%ecx, %ss:-4*4(%eax)
 
 	popl	%ecx
-	lea	-16(%eax), %esp
+	lea	-4*4(%eax), %esp
 	popl	%eax
 .Lfinished_frame_\@:
 .endm
