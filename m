Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC0FC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B10214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfGOAhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbfGOAhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23AAD86676;
        Mon, 15 Jul 2019 00:37:47 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1931F5D9D2;
        Mon, 15 Jul 2019 00:37:46 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 16/22] objtool: Do frame pointer check before dead end check
Date:   Sun, 14 Jul 2019 19:37:11 -0500
Message-Id: <c49defd0e9b26945f1a31bd54f9d85407268046d.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 15 Jul 2019 00:37:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even calls to __noreturn functions need the frame pointer setup first.
Such functions often dump the stack.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 970dfeac841d..3fb656ea96b9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -133,6 +133,9 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"rewind_stack_do_exit",
 	};
 
+	if (!func)
+		return false;
+
 	if (func->bind == STB_WEAK)
 		return false;
 
@@ -2071,19 +2074,16 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (insn->type == INSN_CALL) {
-				if (is_fentry_call(insn))
-					break;
-
-				if (dead_end_function(file, insn->call_dest))
-					return 0;
-			}
-
-			if (!no_fp && func && !has_valid_stack_frame(&state)) {
+			if (!no_fp && func && !is_fentry_call(insn) &&
+			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
 				return 1;
 			}
+
+			if (dead_end_function(file, insn->call_dest))
+				return 0;
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
-- 
2.20.1

