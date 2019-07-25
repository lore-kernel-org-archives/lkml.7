Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E76C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693F42173E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="On0Lp5eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfGYGkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:40:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:40:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6P6eFGk882513
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Jul 2019 23:40:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6P6eFGk882513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564036816;
        bh=proqop0yrUNYT5NRgDwmSRB/tMZXltwzYVqjlnFmjng=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=On0Lp5eY/Spjv411R7zF8VQcDTH3fKZWZTkkuSjnyn2C3mimlxIa0Y66MfaYd1reU
         0qRR+XZ64BnJq2zc0c8E/jszR3yh8n7GzmQNd9scBnU3DqVTJp73Ip1ZwsbSlhbLHh
         ojbsU9YfrTXEyAjogo7craiU8Fvfy9845lAePrV1novmSfVe2HSHztnaT4XDYqmKz0
         Cu+VjZH3AP8jpc6TBTdhqa7Hbz3AN2nm8u1t3MNlXZWtGP0+px3+bjFkJlR4HW9P7O
         Zp/daMb4JRWZtqSSjwf+mTlY6B0bRuX466H4fli9WKaLbkU6pIOb6yJCp500ifqvwj
         8w6z6a9Ctf52A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6P6eFiV882509;
        Wed, 24 Jul 2019 23:40:15 -0700
Date:   Wed, 24 Jul 2019 23:40:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-882a0db9d143e5e8dac54b96e83135bccd1f68d1@git.kernel.org>
Cc:     hpa@zytor.com, ndesaulniers@google.com, natechancellor@gmail.com,
        sedat.dilek@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          peterz@infradead.org, ndesaulniers@google.com, hpa@zytor.com,
          sedat.dilek@gmail.com, natechancellor@gmail.com,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <5359166aad2d53f3145cd442d83d0e5115e0cd17.1564007838.git.jpoimboe@redhat.com>
References: <5359166aad2d53f3145cd442d83d0e5115e0cd17.1564007838.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Improve UACCESS coverage
Git-Commit-ID: 882a0db9d143e5e8dac54b96e83135bccd1f68d1
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

Commit-ID:  882a0db9d143e5e8dac54b96e83135bccd1f68d1
Gitweb:     https://git.kernel.org/tip/882a0db9d143e5e8dac54b96e83135bccd1f68d1
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 24 Jul 2019 17:47:26 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 08:36:39 +0200

objtool: Improve UACCESS coverage

A clang build reported an (obvious) double CLAC while a GCC build did not;
it turns out that objtool only re-visits instructions if the first visit
was with AC=0. If OTOH the first visit was with AC=1, it completely ignores
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
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/617
Link: https://lkml.kernel.org/r/5359166aad2d53f3145cd442d83d0e5115e0cd17.1564007838.git.jpoimboe@redhat.com

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
