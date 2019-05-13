Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6D5C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B9120879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfEMRBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfEMRBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:01:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02AD23082E69;
        Mon, 13 May 2019 17:01:39 +0000 (UTC)
Received: from treble.redhat.com (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75B8819C72;
        Mon, 13 May 2019 17:01:38 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] objtool: Don't use ignore flag for fake jumps
Date:   Mon, 13 May 2019 12:01:31 -0500
Message-Id: <71abc072ff48b2feccc197723a9c52859476c068.1557766718.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1557766718.git.jpoimboe@redhat.com>
References: <cover.1557766718.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 13 May 2019 17:01:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/objtool/check.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ac743a1d53ab..90226791df6b 100644
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
@@ -568,7 +570,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
 
-		if (insn->ignore)
+		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
 			continue;
 
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
@@ -745,10 +747,10 @@ static int handle_group_alt(struct objtool_file *file,
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
2.17.2

