Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E9C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A67208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="doKGn4jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfF0WXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:23:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:23:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RMMjpF474346
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 15:22:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RMMjpF474346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561674166;
        bh=jl84uHOJoJu2FrLyWu0lm0fCW1jHdCJo5JULXqi65q0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=doKGn4jlOgiVamX4c8OM3b0co/WboaUGGHsVuA3NjxdDEMbOW9Ss2tkT/QA0HagOx
         MiqTXisufCB4qxHJYw8/nrSudmblm3+9LI064qCBsXhBU+bfTDBbJziuvxudm4Y8kL
         CVIltmvanfkWTzjlglkab2OOxd7RcThD5ffIjQ2Xl2KrPHNZbgoQNpB3y4kMq1I3Kn
         /gkLqT1GcOHHTBKfvGSmmtQYFrVyQsSTBnrXMl8nhxx8wL7dvEclp+bT3Zc8WkgI2H
         ee3KpxIjBxJ4/AZrn8m2C3436aAbJsEDVB6BSgMZ1qixILvVpTfC/NHeQkrS0s+TgN
         SDTXd0yhLj6Mg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RMMjiL474343;
        Thu, 27 Jun 2019 15:22:45 -0700
Date:   Thu, 27 Jun 2019 15:22:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-ae6a45a0868986f69039a2150d3b2b9ca294c378@git.kernel.org>
Cc:     rostedt@goodmis.org, kasong@redhat.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jpoimboe@redhat.com, songliubraving@fb.com,
        tglx@linutronix.de
Reply-To: bp@alien8.de, kasong@redhat.com, rostedt@goodmis.org,
          tglx@linutronix.de, songliubraving@fb.com, jpoimboe@redhat.com,
          peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <b6f69208ddff4343d56b7bfac1fc7cfcd62689e8.1561595111.git.jpoimboe@redhat.com>
References: <b6f69208ddff4343d56b7bfac1fc7cfcd62689e8.1561595111.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/unwind/orc: Fall back to using frame pointers
 for generated code
Git-Commit-ID: ae6a45a0868986f69039a2150d3b2b9ca294c378
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

Commit-ID:  ae6a45a0868986f69039a2150d3b2b9ca294c378
Gitweb:     https://git.kernel.org/tip/ae6a45a0868986f69039a2150d3b2b9ca294c378
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 26 Jun 2019 19:33:55 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:11:21 +0200

x86/unwind/orc: Fall back to using frame pointers for generated code

The ORC unwinder can't unwind through BPF JIT generated code because
there are no ORC entries associated with the code.

If an ORC entry isn't available, try to fall back to frame pointers.  If
BPF and other generated code always do frame pointer setup (even with
CONFIG_FRAME_POINTERS=n) then this will allow ORC to unwind through most
generated code despite there being no corresponding ORC entries.

Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
Reported-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kairui Song <kasong@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/b6f69208ddff4343d56b7bfac1fc7cfcd62689e8.1561595111.git.jpoimboe@redhat.com

---
 arch/x86/kernel/unwind_orc.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 33b66b5c5aec..72b997eaa1fc 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -82,9 +82,9 @@ static struct orc_entry *orc_find(unsigned long ip);
  * But they are copies of the ftrace entries that are static and
  * defined in ftrace_*.S, which do have orc entries.
  *
- * If the undwinder comes across a ftrace trampoline, then find the
+ * If the unwinder comes across a ftrace trampoline, then find the
  * ftrace function that was used to create it, and use that ftrace
- * function's orc entrie, as the placement of the return code in
+ * function's orc entry, as the placement of the return code in
  * the stack will be identical.
  */
 static struct orc_entry *orc_ftrace_find(unsigned long ip)
@@ -128,6 +128,16 @@ static struct orc_entry null_orc_entry = {
 	.type = ORC_TYPE_CALL
 };
 
+/* Fake frame pointer entry -- used as a fallback for generated code */
+static struct orc_entry orc_fp_entry = {
+	.type		= ORC_TYPE_CALL,
+	.sp_reg		= ORC_REG_BP,
+	.sp_offset	= 16,
+	.bp_reg		= ORC_REG_PREV_SP,
+	.bp_offset	= -16,
+	.end		= 0,
+};
+
 static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
@@ -392,8 +402,16 @@ bool unwind_next_frame(struct unwind_state *state)
 	 * calls and calls to noreturn functions.
 	 */
 	orc = orc_find(state->signal ? state->ip : state->ip - 1);
-	if (!orc)
-		goto err;
+	if (!orc) {
+		/*
+		 * As a fallback, try to assume this code uses a frame pointer.
+		 * This is useful for generated code, like BPF, which ORC
+		 * doesn't know about.  This is just a guess, so the rest of
+		 * the unwind is no longer considered reliable.
+		 */
+		orc = &orc_fp_entry;
+		state->error = true;
+	}
 
 	/* End-of-stack check for kernel threads: */
 	if (orc->sp_reg == ORC_REG_UNDEFINED) {
