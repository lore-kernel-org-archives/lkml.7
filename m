Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5977C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8130A21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443355;
	bh=ehFxs3Y45qn6MCgbminxHnbEpP6fju9VVBe5cF608wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BKvfOxBimjIZiP637tckd/h7aIJSo9a3HVgOZRKyhtKjgRfSm+5PfMKMhgqJKEEnt
	 EfjUdR2V5OElq5NIRlst9Yapf9J+Z7M3OWDszSGNDlZRSaFlC7jnCiSKU45R/ZiFpB
	 g9i7d5JzoJKSFYuqEpyLPoRSPQdcSfsyniWf/Eic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfFMQ3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbfFMIfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:35:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D477206E0;
        Thu, 13 Jun 2019 08:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560414924;
        bh=ehFxs3Y45qn6MCgbminxHnbEpP6fju9VVBe5cF608wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fl24fKEXofJsY9HKPpZpOTVUkKeIRNc6kvidGBgFjtg8Zr8zpgYfDHcB6aan4spU+
         VqHxqMJm6nfftKQNh3fy3TNjfdIkUvkOmdspm2iUGSUNe58fFR1J7TzO/XcQSwVV+k
         H1cgXRsVNAVwOUP34fQjTmwVWaHPHMcHWzMVq+dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 22/81] objtool: Dont use ignore flag for fake jumps
Date:   Thu, 13 Jun 2019 10:33:05 +0200
Message-Id: <20190613075650.774016278@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e6da9567959e164f82bc81967e0d5b10dee870b4 ]

The ignore flag is set on fake jumps in order to keep
add_jump_destinations() from setting their jump_dest, since it already
got set when the fake jump was created.

But using the ignore flag is a bit of a hack.  It's normally used to
skip validation of an instruction, which doesn't really make sense for
fake jumps.

Also, after the next patch, using the ignore flag for fake jumps can
trigger a false "why am I validating an ignored function?" warning.

Instead just add an explicit check in add_jump_destinations() to skip
fake jumps.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/71abc072ff48b2feccc197723a9c52859476c068.1557766718.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ae3446768181..95326c6a7a24 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -28,6 +28,8 @@
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
 
+#define FAKE_JUMP_OFFSET -1
+
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -498,7 +500,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
 
-		if (insn->ignore)
+		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
 			continue;
 
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
@@ -645,10 +647,10 @@ static int handle_group_alt(struct objtool_file *file,
 		clear_insn_state(&fake_jump->state);
 
 		fake_jump->sec = special_alt->new_sec;
-		fake_jump->offset = -1;
+		fake_jump->offset = FAKE_JUMP_OFFSET;
 		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
 		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
-		fake_jump->ignore = true;
+		fake_jump->func = orig_insn->func;
 	}
 
 	if (!special_alt->new_len) {
-- 
2.20.1



