Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B9C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBB1208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uJr+lWVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEMSeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:34:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEMSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:34:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4DIY4XH3649437
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 13 May 2019 11:34:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4DIY4XH3649437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557772445;
        bh=JRFthHKRGdLsHt7WrJA6BStb40SdgIvL9/qz0B0lmos=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uJr+lWVZARoAJ5vfvf9oHNCGwWpmb6TJCk/d1RBJEJD1DW0KWT/8snLWhxgZN4K0I
         TYKDo2d7XTegcchHP/7DIMs+HbxkTNvzTTKX9kLSYERBoubA1dGs5kq6K2KIkqviYc
         aOoeeiWmlNk4PmIz89hM1rJTsyiHh214fbTOcelDc2uQqz6ZTj+fMcLj5VmayDlI3W
         eEJwYcoMFb9PLuODGx6jVs8VVatBnIsZb/rJ2kc3eJ/oRiOADdvHMHvEfxPhrioqpX
         +2RpFZ7jndfwyGPHnmwQrXnb/kqxJSfVLaeGaQ2P6N8NK++/KnInUN8VRugmqN7JR/
         I9M6AL+8UKBhA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4DIY4xr3649434;
        Mon, 13 May 2019 11:34:04 -0700
Date:   Mon, 13 May 2019 11:34:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-e6da9567959e164f82bc81967e0d5b10dee870b4@git.kernel.org>
Cc:     jpoimboe@redhat.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org, jpoimboe@redhat.com
In-Reply-To: <71abc072ff48b2feccc197723a9c52859476c068.1557766718.git.jpoimboe@redhat.com>
References: <71abc072ff48b2feccc197723a9c52859476c068.1557766718.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Don't use ignore flag for fake jumps
Git-Commit-ID: e6da9567959e164f82bc81967e0d5b10dee870b4
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

Commit-ID:  e6da9567959e164f82bc81967e0d5b10dee870b4
Gitweb:     https://git.kernel.org/tip/e6da9567959e164f82bc81967e0d5b10dee870b4
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Mon, 13 May 2019 12:01:31 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 13 May 2019 20:31:17 +0200

objtool: Don't use ignore flag for fake jumps

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
