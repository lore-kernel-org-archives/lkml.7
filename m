Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD0C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0142068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLDIeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56441 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLDIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:34:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6P-0005JD-Ij; Wed, 04 Dec 2019 09:33:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 42FFD1C2656;
        Wed,  4 Dec 2019 09:33:36 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:36 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/ftrace: Mark ftrace_modify_code_direct() __ref
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191116204607.GC23231@zn.tnic>
References: <20191116204607.GC23231@zn.tnic>
MIME-Version: 1.0
Message-ID: <157544841616.21853.11033937966281103251.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     38ebd8d119245eecb99fe00b0f57e269baf22767
Gitweb:        https://git.kernel.org/tip/38ebd8d119245eecb99fe00b0f57e269baf22767
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 18 Nov 2019 18:20:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:24 +01:00

x86/ftrace: Mark ftrace_modify_code_direct() __ref

... because it calls the .init.text function text_poke_early(). That is
ok because it does call that function early, during boot.

Fixes: 9706f7c3531f ("x86/ftrace: Use text_poke()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191116204607.GC23231@zn.tnic
---
 arch/x86/kernel/ftrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 2a179fb..108ee96 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -99,7 +99,12 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
 	return 0;
 }
 
-static int
+/*
+ * Marked __ref because it calls text_poke_early() which is .init.text. That is
+ * ok because that call will happen early, during boot, when .init sections are
+ * still present.
+ */
+static int __ref
 ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 			  const char *new_code)
 {
