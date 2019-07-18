Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB6C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328F221019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389218AbfGRBhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389146AbfGRBhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8044F8667D;
        Thu, 18 Jul 2019 01:37:38 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7042F5D9CC;
        Thu, 18 Jul 2019 01:37:37 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 22/22] objtool: Support conditional retpolines
Date:   Wed, 17 Jul 2019 20:36:57 -0500
Message-Id: <30d4c758b267ef487fb97e6ecb2f148ad007b554.1563413318.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563413318.git.jpoimboe@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 18 Jul 2019 01:37:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Clang-built kernel is showing the following warning:

  arch/x86/kernel/platform-quirks.o: warning: objtool: x86_early_init_platform_quirks()+0x84: unreachable instruction

That corresponds to this code:

  7e:   0f 85 00 00 00 00       jne    84 <x86_early_init_platform_quirks+0x84>
                        80: R_X86_64_PC32       __x86_indirect_thunk_r11-0x4
  84:   c3                      retq

This is a conditional retpoline sibling call, which is now possible
thanks to retpolines.  Objtool hasn't seen that before.  It's
incorrectly interpreting the conditional jump as an unconditional
dynamic jump.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/objtool/arch.h  |  1 +
 tools/objtool/check.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 50448c0c4bca..ced3765c4f44 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -15,6 +15,7 @@ enum insn_type {
 	INSN_JUMP_CONDITIONAL,
 	INSN_JUMP_UNCONDITIONAL,
 	INSN_JUMP_DYNAMIC,
+	INSN_JUMP_DYNAMIC_CONDITIONAL,
 	INSN_CALL,
 	INSN_CALL_DYNAMIC,
 	INSN_RETURN,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 381e36dc587c..a93ecce40641 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -575,7 +575,11 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
 			 */
-			insn->type = INSN_JUMP_DYNAMIC;
+			if (insn->type == INSN_JUMP_UNCONDITIONAL)
+				insn->type = INSN_JUMP_DYNAMIC;
+			else
+				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
+
 			insn->retpoline_safe = true;
 			continue;
 		} else {
@@ -2114,13 +2118,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
+		case INSN_JUMP_DYNAMIC_CONDITIONAL:
 			if (func && is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
 			}
 
-			return 0;
+			if (insn->type == INSN_JUMP_DYNAMIC)
+				return 0;
+
+			break;
 
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
-- 
2.20.1

