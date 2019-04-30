Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A79DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B74E20675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XeJMlENZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfD3LYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:24:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3LYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:24:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBNT3Z1347949
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:23:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBNT3Z1347949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623410;
        bh=tmZb/ywuy5RuSOeSqOG7vwZj6rmGFHYEwUdw428e/8c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XeJMlENZHQHbFaWMJDB3MciBCjCAAIoX03eRjcdiOQizNlIIBARcZolUSGxSZW84N
         qqm1JktCBbgTIGH29WfwK+GouyWJeeq+WxGD6SWgFZ6QlU+YQ6baojEDBRqOR4bxYU
         oShqIPYI5ssL6NWmrrBtms3OG0xkDvWOSRJxxqvFi79IzcgfFQmIAz2ODeLZgLqjag
         TyIbXClTNcsmtUjqCY5lYZRl7raXnfOcvu8X+f1cQ7dw6w/vgoAPq9F5YKAAbNu3Fb
         md9bZBlQfNwQvROLZ9v/Y10tK7s3TdrhKELqsf9htHPslEyxDKA6eVSur6Qmc2oCMb
         uBJArRkcF+fBw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBNSS41347946;
        Tue, 30 Apr 2019 04:23:28 -0700
Date:   Tue, 30 Apr 2019 04:23:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-bb0a008d6a2c543efc11313b448d2f26f91dc4f8@git.kernel.org>
Cc:     luto@kernel.org, bp@alien8.de, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tglx@linutronix.de, mhiramat@kernel.org,
        kernel-hardening@lists.openwall.com, deneen.t.dock@intel.com,
        linux_dti@icloud.com, hpa@zytor.com, riel@surriel.com,
        mingo@kernel.org, kristen@linux.intel.com, keescook@chromium.org,
        namit@vmware.com, peterz@infradead.org, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, rick.p.edgecombe@intel.com,
        torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, kristen@linux.intel.com, hpa@zytor.com,
          riel@surriel.com, rick.p.edgecombe@intel.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          keescook@chromium.org, namit@vmware.com, will.deacon@arm.com,
          ard.biesheuvel@linaro.org, akpm@linux-foundation.org,
          bp@alien8.de, luto@kernel.org, dave.hansen@intel.com,
          linux-kernel@vger.kernel.org, deneen.t.dock@intel.com,
          linux_dti@icloud.com, tglx@linutronix.de, mhiramat@kernel.org,
          kernel-hardening@lists.openwall.com
In-Reply-To: <20190426001143.4983-13-namit@vmware.com>
References: <20190426001143.4983-13-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/jump-label: Remove support for custom text poker
Git-Commit-ID: bb0a008d6a2c543efc11313b448d2f26f91dc4f8
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

Commit-ID:  bb0a008d6a2c543efc11313b448d2f26f91dc4f8
Gitweb:     https://git.kernel.org/tip/bb0a008d6a2c543efc11313b448d2f26f91dc4f8
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:32 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:55 +0200

x86/jump-label: Remove support for custom text poker

There are only two types of text poking: early and breakpoint based. The use
of a function pointer to perform text poking complicates the code and is
probably inefficient due to the use of indirect branches.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-13-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/jump_label.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e7d8c636b228..e631c358f7f4 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -37,7 +37,6 @@ static void bug_at(unsigned char *ip, int line)
 
 static void __ref __jump_label_transform(struct jump_entry *entry,
 					 enum jump_label_type type,
-					 void *(*poker)(void *, const void *, size_t),
 					 int init)
 {
 	union jump_code_union jmp;
@@ -50,14 +49,6 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	jmp.offset = jump_entry_target(entry) -
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-	/*
-	 * As long as only a single processor is running and the code is still
-	 * not marked as RO, text_poke_early() can be used; Checking that
-	 * system_state is SYSTEM_BOOTING guarantees it.
-	 */
-	if (system_state == SYSTEM_BOOTING)
-		poker = text_poke_early;
-
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
 			expect = default_nop; line = __LINE__;
@@ -80,16 +71,19 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 		bug_at((void *)jump_entry_code(entry), line);
 
 	/*
-	 * Make text_poke_bp() a default fallback poker.
+	 * As long as only a single processor is running and the code is still
+	 * not marked as RO, text_poke_early() can be used; Checking that
+	 * system_state is SYSTEM_BOOTING guarantees it. It will be set to
+	 * SYSTEM_SCHEDULING before other cores are awaken and before the
+	 * code is write-protected.
 	 *
 	 * At the time the change is being done, just ignore whether we
 	 * are doing nop -> jump or jump -> nop transition, and assume
 	 * always nop being the 'currently valid' instruction
-	 *
 	 */
-	if (poker) {
-		(*poker)((void *)jump_entry_code(entry), code,
-			 JUMP_LABEL_NOP_SIZE);
+	if (init || system_state == SYSTEM_BOOTING) {
+		text_poke_early((void *)jump_entry_code(entry), code,
+				JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
@@ -101,7 +95,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
 	mutex_lock(&text_mutex);
-	__jump_label_transform(entry, type, NULL, 0);
+	__jump_label_transform(entry, type, 0);
 	mutex_unlock(&text_mutex);
 }
 
@@ -131,5 +125,5 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 			jlstate = JL_STATE_NO_UPDATE;
 	}
 	if (jlstate == JL_STATE_UPDATE)
-		__jump_label_transform(entry, type, text_poke_early, 1);
+		__jump_label_transform(entry, type, 1);
 }
