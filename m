Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC280C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF95214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfDAI6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14975 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfDAI6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CBEA30833C4;
        Mon,  1 Apr 2019 08:58:35 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4A35D706;
        Mon,  1 Apr 2019 08:58:31 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V5 3/7] x86/jump_label: Add a __jump_label_set_jump_code() helper
Date:   Mon,  1 Apr 2019 10:58:15 +0200
Message-Id: <ab1bfaf65feb3fd1f126e1d6c922cb9184214000.1554106794.git.bristot@redhat.com>
In-Reply-To: <cover.1554106794.git.bristot@redhat.com>
References: <cover.1554106794.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 01 Apr 2019 08:58:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of the code to be written from
__jump_label_transform() to a specialized function.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/jump_label.c | 47 ++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f99bd26bd3f1..8aa65fbbd764 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -35,24 +35,20 @@ static void bug_at(unsigned char *ip, int line)
 	BUG();
 }
 
-static void __ref __jump_label_transform(struct jump_entry *entry,
-					 enum jump_label_type type,
-					 void *(*poker)(void *, const void *, size_t),
-					 int init)
+static void __jump_label_set_jump_code(struct jump_entry *entry,
+				       enum jump_label_type type,
+				       union jump_code_union *code,
+				       int init)
 {
-	union jump_code_union jmp;
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *expect, *code;
+	const void *expect;
 	int line;
 
-	jmp.jump = 0xe9;
-	jmp.offset = jump_entry_target(entry) -
+	code->jump = 0xe9;
+	code->offset = jump_entry_target(entry) -
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-	if (early_boot_irqs_disabled)
-		poker = text_poke_early;
-
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
 			expect = default_nop; line = __LINE__;
@@ -60,19 +56,34 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 			expect = ideal_nop; line = __LINE__;
 		}
 
-		code = &jmp.code;
+		if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
+			bug_at((void *)jump_entry_code(entry), line);
+
 	} else {
 		if (init) {
 			expect = default_nop; line = __LINE__;
 		} else {
-			expect = &jmp.code; line = __LINE__;
+			expect = code->code; line = __LINE__;
 		}
 
-		code = ideal_nop;
+		if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
+			bug_at((void *)jump_entry_code(entry), line);
+
+		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
 	}
+}
+
+static void __ref __jump_label_transform(struct jump_entry *entry,
+					 enum jump_label_type type,
+					 void *(*poker)(void *, const void *, size_t),
+					 int init)
+{
+	union jump_code_union code;
+
+	if (early_boot_irqs_disabled)
+		poker = text_poke_early;
 
-	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
-		bug_at((void *)jump_entry_code(entry), line);
+	__jump_label_set_jump_code(entry, type, &code, init);
 
 	/*
 	 * Make text_poke_bp() a default fallback poker.
@@ -83,12 +94,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	 *
 	 */
 	if (poker) {
-		(*poker)((void *)jump_entry_code(entry), code,
+		(*poker)((void *)jump_entry_code(entry), &code,
 			 JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
+	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE,
 		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 }
 
-- 
2.20.1

