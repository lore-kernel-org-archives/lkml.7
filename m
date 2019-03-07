Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3CDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE6C2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBbx5QDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfCGLx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50992 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCGLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hjvTEGR1I4zdmxJ7G4K8d54N9zsu/P3oWnWhP63l8eI=; b=ZBbx5QDGpNjPWflkTAZDgmiDWt
        3jHskgr+eeBFXQ0SsBkNvnrmsmkwIZJsWouLko2x2lLMU5v2u0uXK+OXVoOKjtauh5xYp+XwJV/7h
        dFyZgWB4uVGLHhNiNnVCoSxqON3/aY1tkZ27W0q0Syynm9ski4gQusXl5NkxIeL5rmC1vKmCX+dNF
        K2RU+DnRmtwHQZYX14C7viCfOPJbHpuNO1oK8drKlFuuiiDG7b2EvqBJ9egRPpIZ+AC9YNWpbfz/q
        rK48txkHjyPJAY+Gf2CoR6Jm/41GXuNuIAB4vfVappLewZGFyLswFnnri5lwUPh6lzh0cY0Jd7wWA
        mEHuRs7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZo-0005Pg-E9; Thu, 07 Mar 2019 11:52:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D135020291FC4; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115200.515578829@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 16/20] objtool: Rewrite alt->skip_orig
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Really skip the original instruction flow, instead of letting it
continue with NOPs.

Since the alternative code flow already continues after the original
instructions, only the alt-original is skipped.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -31,6 +31,7 @@
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
+	bool skip_orig;
 };
 
 const char *objname;
@@ -623,9 +624,6 @@ static int add_call_destinations(struct
  *    conditionally jumps to the _end_ of the entry.  We have to modify these
  *    jumps' destinations to point back to .text rather than the end of the
  *    entry in .altinstr_replacement.
- *
- * 4. It has been requested that we don't validate the !POPCNT feature path
- *    which is a "very very small percentage of machines".
  */
 static int handle_group_alt(struct objtool_file *file,
 			    struct special_alt *special_alt,
@@ -641,9 +639,6 @@ static int handle_group_alt(struct objto
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		if (special_alt->skip_orig)
-			insn->type = INSN_NOP;
-
 		insn->alt_group = true;
 		last_orig_insn = insn;
 	}
@@ -808,6 +803,7 @@ static int add_special_section_alts(stru
 		}
 
 		alt->insn = new_insn;
+		alt->skip_orig = special_alt->skip_orig;
 		list_add_tail(&alt->list, &orig_insn->alts);
 
 		list_del(&special_alt->list);
@@ -1883,7 +1879,12 @@ static int validate_branch(struct objtoo
 		insn->visited = true;
 
 		if (!insn->ignore_alts) {
+			bool skip_orig = false;
+
 			list_for_each_entry(alt, &insn->alts, list) {
+				if (alt->skip_orig)
+					skip_orig = true;
+
 				ret = validate_branch(file, alt->insn, state);
 				if (ret) {
 					if (backtrace)
@@ -1891,6 +1892,9 @@ static int validate_branch(struct objtoo
 					return ret;
 				}
 			}
+
+			if (skip_orig)
+				return 0;
 		}
 
 		switch (insn->type) {


