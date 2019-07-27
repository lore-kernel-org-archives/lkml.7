Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782FBC41514
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598BF2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfG0Xai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 19:30:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51219 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfG0Xah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 19:30:37 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrW95-0002Lo-Ew; Sun, 28 Jul 2019 01:30:35 +0200
Date:   Sat, 27 Jul 2019 23:26:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for 5.3-rc2 
Message-ID: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

up to:  882a0db9d143: objtool: Improve UACCESS coverage

A single robustness fix for objtool to handle unbalanced CLAC invocations
under all circumstances.

Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      objtool: Improve UACCESS coverage


 tools/objtool/check.c | 7 ++++---
 tools/objtool/check.h | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f26620f13f5..176f2f084060 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1946,6 +1946,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	struct alternative *alt;
 	struct instruction *insn, *next_insn;
 	struct section *sec;
+	u8 visited;
 	int ret;
 
 	insn = first;
@@ -1972,12 +1973,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 1;
 		}
 
+		visited = 1 << state.uaccess;
 		if (insn->visited) {
 			if (!insn->hint && !insn_state_match(insn, &state))
 				return 1;
 
-			/* If we were here with AC=0, but now have AC=1, go again */
-			if (insn->state.uaccess || !state.uaccess)
+			if (insn->visited & visited)
 				return 0;
 		}
 
@@ -2024,7 +2025,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		} else
 			insn->state = state;
 
-		insn->visited = true;
+		insn->visited |= visited;
 
 		if (!insn->ignore_alts) {
 			bool skip_orig = false;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index b881fafcf55d..6d875ca6fce0 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,8 +33,9 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
 	bool retpoline_safe;
+	u8 visited;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;

