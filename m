Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C2E218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfDJLGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:06:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbfDJLFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:05:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB3C-00058K-0S; Wed, 10 Apr 2019 13:05:54 +0200
Message-Id: <20190410103645.492122341@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [RFC patch 21/41] proc: Simplify task stack retrieval
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -407,7 +407,6 @@ static void unlock_trace(struct task_str
 static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
-	struct stack_trace trace;
 	unsigned long *entries;
 	int err;
 
@@ -430,20 +429,16 @@ static int proc_pid_stack(struct seq_fil
 	if (!entries)
 		return -ENOMEM;
 
-	trace.nr_entries	= 0;
-	trace.max_entries	= MAX_STACK_TRACE_DEPTH;
-	trace.entries		= entries;
-	trace.skip		= 0;
-
 	err = lock_trace(task);
 	if (!err) {
-		unsigned int i;
+		unsigned int i, nent;
 
-		save_stack_trace_tsk(task, &trace);
+		nent = stack_trace_save_tsk(task, entries,
+					    MAX_STACK_TRACE_DEPTH, 0);
 
-		for (i = 0; i < trace.nr_entries; i++) {
+		for (i = 0; i < nent; i++)
 			seq_printf(m, "[<0>] %pB\n", (void *)entries[i]);
-		}
+
 		unlock_trace(task);
 	}
 	kfree(entries);


