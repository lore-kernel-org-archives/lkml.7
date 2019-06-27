Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B937C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD9021852
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfF0AfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:35:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbfF0AfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC4D630832D3;
        Thu, 27 Jun 2019 00:35:05 +0000 (UTC)
Received: from treble.redhat.com (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A88235D9D6;
        Thu, 27 Jun 2019 00:35:03 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 4/4] x86/unwind/orc: Fall back to using frame pointers for generated code
Date:   Wed, 26 Jun 2019 19:33:55 -0500
Message-Id: <b6f69208ddff4343d56b7bfac1fc7cfcd62689e8.1561595111.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1561595111.git.jpoimboe@redhat.com>
References: <cover.1561595111.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 27 Jun 2019 00:35:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ORC unwinder can't unwind through BPF JIT generated code because
there are no ORC entries associated with the code.

If an ORC entry isn't available, try to fall back to frame pointers.  If
BPF and other generated code always do frame pointer setup (even with
CONFIG_FRAME_POINTERS=n) then this will allow ORC to unwind through most
generated code despite there being no corresponding ORC entries.

Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
Reported-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
-- 
2.20.1

