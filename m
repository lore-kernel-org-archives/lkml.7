Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35881C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058E2208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfEMRBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfEMRBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:01:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2AC130054AB;
        Mon, 13 May 2019 17:01:39 +0000 (UTC)
Received: from treble.redhat.com (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ED9819C68;
        Mon, 13 May 2019 17:01:39 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] objtool: Fix function fallthrough detection
Date:   Mon, 13 May 2019 12:01:32 -0500
Message-Id: <546d143820cd08a46624ae8440d093dd6c902cae.1557766718.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1557766718.git.jpoimboe@redhat.com>
References: <cover.1557766718.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 13 May 2019 17:01:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a function falls through to the next function due to a compiler
bug, objtool prints some obscure warnings.  For example:

  drivers/regulator/core.o: warning: objtool: regulator_count_voltages()+0x95: return with modified stack frame
  drivers/regulator/core.o: warning: objtool: regulator_count_voltages()+0x0: stack state mismatch: cfa1=7+32 cfa2=7+8

Instead it should be printing:

  drivers/regulator/core.o: warning: objtool: regulator_supply_is_couple() falls through to next function regulator_count_voltages()

This used to work, but was broken by the following commit:

  13810435b9a7 ("objtool: Support GCC 8's cold subfunctions").

The padding nops at the end of a function aren't actually part of the
function, as defined by the symbol table.  So the 'func' variable in
validate_branch() is getting cleared to NULL when a padding nop is
encountered, breaking the fallthrough detection.

If the current instruction doesn't have a function associated with it,
just consider it to be part of the previously detected function by not
overwriting the previous value of 'func'.

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 90226791df6b..7325d89ccad9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1959,7 +1959,8 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			return 1;
 		}
 
-		func = insn->func ? insn->func->pfunc : NULL;
+		if (insn->func)
+			func = insn->func->pfunc;
 
 		if (func && insn->ignore) {
 			WARN_FUNC("BUG: why am I validating an ignored function?",
-- 
2.17.2

