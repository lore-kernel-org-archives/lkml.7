Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617A3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D471521926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0ehXnmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfGXQsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:48:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387729AbfGXQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I/I/F1YjxAyAsOp42imqjb1kYs8ytmj9frM5VjUVPfE=; b=s0ehXnmi0V1+yb+A0Jvr2AIv7
        ZsOfYO/1Sy3Q5td4hQPIpGsFDDdNiMqBF0RsiBcaVOvdeTZxHQKopFmAlaJtPpBwkm+2+/5awYfnF
        OHYs2+5+penGJ58PhGijbvFcloafasHBikDqujhrY9X8+aqlchkFReL+as89cSjCwTg5t5MqFOUbF
        uzPcOETWnJsJggsNLgE5ydNHYehIQXP7hMKfa2OCdmhOgJz4QMNyp3CkbODnADH500QeZDBTZbGKY
        uU19A3xJ6FeL23uQUHtZ+nJHbJBCEj7NAoqxMJeW6t/HyGufvO18N/5rfw52fhMo+ESMi/nF93nE8
        YTU0DRmhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqKRE-0003zz-5d; Wed, 24 Jul 2019 16:48:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E881B20288388; Wed, 24 Jul 2019 18:48:21 +0200 (CEST)
Date:   Wed, 24 Jul 2019 18:48:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] objtool: Improve UACCESS coverage
Message-ID: <20190724164821.GB31425@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble>
 <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
 <20190724125525.kgybu3nnpvwlcz2c@treble>
 <20190724133516.GB31381@hirez.programming.kicks-ass.net>
 <20190724141040.GA31425@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724141040.GA31425@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:10:40PM +0200, Peter Zijlstra wrote:
> And that most certainly should trigger...
> 
> Let me gdb that objtool thing.

---
Subject: objtool: Improve UACCESS coverage

A clang build reported an (obvious) double CLAC while a GCC build did
not; it turns out we only re-visit instructions if the first visit was
with AC=0. If OTOH the first visit was with AC=1, we completely ignore
any subsequent visit, even when it has AC=0.

Fix this by using a visited mask, instead of boolean and (explicitly)
mark the AC state.

$ ./objtool check -b --no-fp --retpoline --uaccess ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o
../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x22: redundant UACCESS disable
../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xea: (alt)
../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xd9: (alt)
../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xb2: (branch)
../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x39: (branch)
../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x0: <=== (func)

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
