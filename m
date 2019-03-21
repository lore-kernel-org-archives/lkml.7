Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4606C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3102192C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfCULHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:07:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfCULHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:07:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LB75AN100759
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:07:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LB74U0100756;
        Thu, 21 Mar 2019 04:07:04 -0700
Date:   Thu, 21 Mar 2019 04:07:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-0c671812f152b628bd87c0af49da032cc2a2c319@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        moosotc@gmail.com, jpoimboe@redhat.com
Reply-To: hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          moosotc@gmail.com, jpoimboe@redhat.com
In-Reply-To: <df92dcbc4b84b02ffa252f46876df125fb56e2d7.1552954176.git.jpoimboe@redhat.com>
References: <df92dcbc4b84b02ffa252f46876df125fb56e2d7.1552954176.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Move objtool_file struct off the stack
Git-Commit-ID: 0c671812f152b628bd87c0af49da032cc2a2c319
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

Commit-ID:  0c671812f152b628bd87c0af49da032cc2a2c319
Gitweb:     https://git.kernel.org/tip/0c671812f152b628bd87c0af49da032cc2a2c319
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Mon, 18 Mar 2019 19:09:38 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:02:19 +0100

objtool: Move objtool_file struct off the stack

Objtool uses over 512k of stack, thanks to the hash table embedded in
the objtool_file struct.  This causes an unnecessarily large stack
allocation and breaks users with low stack limits.

Move the struct off the stack.

Fixes: 042ba73fe7eb ("objtool: Add several performance improvements")
Reported-by: Vassili Karpov <moosotc@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/df92dcbc4b84b02ffa252f46876df125fb56e2d7.1552954176.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..5dde107083c6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2184,9 +2184,10 @@ static void cleanup(struct objtool_file *file)
 	elf_close(file->elf);
 }
 
+static struct objtool_file file;
+
 int check(const char *_objname, bool orc)
 {
-	struct objtool_file file;
 	int ret, warnings = 0;
 
 	objname = _objname;
