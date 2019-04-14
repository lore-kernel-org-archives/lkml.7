Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF7C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E565420850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfDNUkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:40:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:40:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKeEtG2689691
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:40:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKeDth2689687;
        Sun, 14 Apr 2019 13:40:13 -0700
Date:   Sun, 14 Apr 2019 13:40:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2dfed4565afe263751d2451ad22336ad806c25a6@git.kernel.org>
Cc:     peterz@infradead.org, luto@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, hpa@zytor.com,
        glider@google.com, mingo@kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com
Reply-To: jpoimboe@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          glider@google.com, will.deacon@arm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          peterz@infradead.org, luto@kernel.org
In-Reply-To: <20190410103644.485737321@linutronix.de>
References: <20190410103644.485737321@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] lockdep: Remove the ULONG_MAX stack trace
 hackery
Git-Commit-ID: 2dfed4565afe263751d2451ad22336ad806c25a6
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

Commit-ID:  2dfed4565afe263751d2451ad22336ad806c25a6
Gitweb:     https://git.kernel.org/tip/2dfed4565afe263751d2451ad22336ad806c25a6
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:04 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:30 +0200

lockdep: Remove the ULONG_MAX stack trace hackery

No architecture terminates the stack trace with ULONG_MAX anymore. Remove
the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190410103644.485737321@linutronix.de

---
 kernel/locking/lockdep.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e16766ff184b..2edf9501d906 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -444,17 +444,6 @@ static int save_trace(struct stack_trace *trace)
 
 	save_stack_trace(trace);
 
-	/*
-	 * Some daft arches put -1 at the end to indicate its a full trace.
-	 *
-	 * <rant> this is buggy anyway, since it takes a whole extra entry so a
-	 * complete trace that maxes out the entries provided will be reported
-	 * as incomplete, friggin useless </rant>
-	 */
-	if (trace->nr_entries != 0 &&
-	    trace->entries[trace->nr_entries-1] == ULONG_MAX)
-		trace->nr_entries--;
-
 	trace->max_entries = trace->nr_entries;
 
 	nr_stack_trace_entries += trace->nr_entries;
