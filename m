Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E56C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD98E2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lJy8rXvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391427AbfGRTXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:23:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390241AbfGRTXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:23:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJN3en2126681
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:23:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJN3en2126681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477783;
        bh=DZTPxQ3rM3tLm5Z36T6I+I09z1UPFRj4delZ3PlDZ2g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lJy8rXvUcnK5upYbk5yDLbPChVf7gdU3+icx6rsGd+3x4rPPjMddkGbqo/LLchLpi
         VbXuPnZEdOyx16BJwbHnU9fuijh2XMRxLYtXg87+hkWx5l2tmO04Sxv2lcdl97WKWy
         z0g0DtFZNXJ60k88RxV1eGrmIHFC9uMx4t7YRr2V4PLFA2xx4OgpoPPBjYgU2DNgVb
         W0Tv0cp3WqhS/UZlMyDkhystJUxqTmpb9gRraFGCZpDInfHtgwii7iqQdSvP1GTepO
         CJWWF4YMUKxliggPrSznW42AJwELoJ3WodFK8me+WdQJr08AqJttFLAFKF+g/BmyYI
         YxiYzKSxPYVyg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJN2Cw2126678;
        Thu, 18 Jul 2019 12:23:02 -0700
Date:   Thu, 18 Jul 2019 12:23:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-b68b9907069a8d3a65bc16a35360bf8f8603c8fa@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, ndesaulniers@google.com,
          tglx@linutronix.de, jpoimboe@redhat.com, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <30d4c758b267ef487fb97e6ecb2f148ad007b554.1563413318.git.jpoimboe@redhat.com>
References: <30d4c758b267ef487fb97e6ecb2f148ad007b554.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Support conditional retpolines
Git-Commit-ID: b68b9907069a8d3a65bc16a35360bf8f8603c8fa
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

Commit-ID:  b68b9907069a8d3a65bc16a35360bf8f8603c8fa
Gitweb:     https://git.kernel.org/tip/b68b9907069a8d3a65bc16a35360bf8f8603c8fa
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:57 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:10 +0200

objtool: Support conditional retpolines

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/30d4c758b267ef487fb97e6ecb2f148ad007b554.1563413318.git.jpoimboe@redhat.com

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
index 04572a049cfc..5f26620f13f5 100644
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
