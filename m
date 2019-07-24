Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB7BC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD56D2238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfGXWs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388286AbfGXWsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96791307D934;
        Wed, 24 Jul 2019 22:48:54 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-90.rdu2.redhat.com [10.10.122.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 724201001B04;
        Wed, 24 Jul 2019 22:48:53 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] objtool: Improve UACCESS coverage
Date:   Wed, 24 Jul 2019 17:47:26 -0500
Message-Id: <5359166aad2d53f3145cd442d83d0e5115e0cd17.1564007838.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1564007838.git.jpoimboe@redhat.com>
References: <cover.1564007838.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Jul 2019 22:48:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

A clang build reported an (obvious) double CLAC while a GCC build did
not; it turns out we only re-visit instructions if the first visit was
with AC=0. If OTOH the first visit was with AC=1, we completely ignore
any subsequent visit, even when it has AC=0.

Fix this by using a visited mask instead of a boolean, and (explicitly)
mark the AC state.

$ ./objtool check -b --no-fp --retpoline --uaccess drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x22: redundant UACCESS disable
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xea: (alt)
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xd9: (alt)
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xb2: (branch)
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x39: (branch)
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x0: <=== (func)

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/617
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
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
-- 
2.20.1

