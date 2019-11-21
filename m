Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841BAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CB020672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUU72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:59:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33484 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUU72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:59:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXtXv-0005dd-H6; Thu, 21 Nov 2019 21:59:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 362A71C1A63;
        Thu, 21 Nov 2019 21:59:23 +0100 (CET)
Date:   Thu, 21 Nov 2019 20:59:23 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86/mov_ss_trap: Fix the SYSENTER test
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157436996315.21853.1892350494410986303.tip-bot2@tip-bot2>
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

Commit-ID:     8caa016bfc129f2c925d52da43022171d1d1de91
Gitweb:        https://git.kernel.org/tip/8caa016bfc129f2c925d52da43022171d1d1de91
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 12:59:13 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Nov 2019 21:55:51 +01:00

selftests/x86/mov_ss_trap: Fix the SYSENTER test

For reasons that I haven't quite fully diagnosed, running
mov_ss_trap_32 on a 32-bit kernel results in an infinite loop in
userspace.  This appears to be because the hacky SYSENTER test
doesn't segfault as desired; instead it corrupts the program state
such that it infinite loops.

Fix it by explicitly clearing EBP before doing SYSENTER.  This will
give a more reliable segfault.

Fixes: 59c2a7226fc5 ("x86/selftests: Add mov_to_ss test")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
---
 tools/testing/selftests/x86/mov_ss_trap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index 3c3a022..6da0ac3 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -257,7 +257,8 @@ int main()
 			err(1, "sigaltstack");
 		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND | SA_ONSTACK);
 		nr = SYS_getpid;
-		asm volatile ("mov %[ss], %%ss; SYSENTER" : "+a" (nr)
+		/* Clear EBP first to make sure we segfault cleanly. */
+		asm volatile ("xorl %%ebp, %%ebp; mov %[ss], %%ss; SYSENTER" : "+a" (nr)
 			      : [ss] "m" (ss) : "flags", "rcx"
 #ifdef __x86_64__
 				, "r11"
