Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C1FC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E92220870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDNUn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:43:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43381 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:43:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKgtQ52690093
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:42:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKgs442690090;
        Sun, 14 Apr 2019 13:42:54 -0700
Date:   Sun, 14 Apr 2019 13:42:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-accddc41b96915ab4e5d37796c6d17d70805999c@git.kernel.org>
Cc:     rostedt@goodmis.org, peterz@infradead.org, jpoimboe@redhat.com,
        luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        glider@google.com, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: peterz@infradead.org, jpoimboe@redhat.com, luto@kernel.org,
          rostedt@goodmis.org, tglx@linutronix.de, mingo@kernel.org,
          glider@google.com, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190410103644.853527514@linutronix.de>
References: <20190410103644.853527514@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] latency_top: Remove the ULONG_MAX stack trace
 hackery
Git-Commit-ID: accddc41b96915ab4e5d37796c6d17d70805999c
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

Commit-ID:  accddc41b96915ab4e5d37796c6d17d70805999c
Gitweb:     https://git.kernel.org/tip/accddc41b96915ab4e5d37796c6d17d70805999c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:08 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:31 +0200

latency_top: Remove the ULONG_MAX stack trace hackery

No architecture terminates the stack trace with ULONG_MAX anymore. The
consumer terminates on the first zero entry or at the number of entries, so
no functional change.

Remove the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Link: https://lkml.kernel.org/r/20190410103644.853527514@linutronix.de

---
 fs/proc/base.c      |  3 +--
 kernel/latencytop.c | 12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a803a0b75df..5569f215fc54 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -489,10 +489,9 @@ static int lstats_show_proc(struct seq_file *m, void *v)
 				   lr->count, lr->time, lr->max);
 			for (q = 0; q < LT_BACKTRACEDEPTH; q++) {
 				unsigned long bt = lr->backtrace[q];
+
 				if (!bt)
 					break;
-				if (bt == ULONG_MAX)
-					break;
 				seq_printf(m, " %ps", (void *)bt);
 			}
 			seq_putc(m, '\n');
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 96b4179cee6a..f5a90ab3c6b9 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -120,8 +120,8 @@ account_global_scheduler_latency(struct task_struct *tsk,
 				break;
 			}
 
-			/* 0 and ULONG_MAX entries mean end of backtrace: */
-			if (record == 0 || record == ULONG_MAX)
+			/* 0 entry marks end of backtrace: */
+			if (!record)
 				break;
 		}
 		if (same) {
@@ -210,8 +210,8 @@ __account_scheduler_latency(struct task_struct *tsk, int usecs, int inter)
 				break;
 			}
 
-			/* 0 and ULONG_MAX entries mean end of backtrace: */
-			if (record == 0 || record == ULONG_MAX)
+			/* 0 entry is end of backtrace */
+			if (!record)
 				break;
 		}
 		if (same) {
@@ -252,10 +252,10 @@ static int lstats_show(struct seq_file *m, void *v)
 				   lr->count, lr->time, lr->max);
 			for (q = 0; q < LT_BACKTRACEDEPTH; q++) {
 				unsigned long bt = lr->backtrace[q];
+
 				if (!bt)
 					break;
-				if (bt == ULONG_MAX)
-					break;
+
 				seq_printf(m, " %ps", (void *)bt);
 			}
 			seq_puts(m, "\n");
