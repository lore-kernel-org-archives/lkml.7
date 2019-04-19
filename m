Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71773C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CDF2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wLhdAmWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfDSTEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbfDSTED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:04:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JCrh5f276522
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 05:53:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JCrh5f276522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555678424;
        bh=EucxO2YaYju/cfJ6zFGLmMFdzsEp79os09chICJ2wnQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wLhdAmWl0IHSuH+Wvq22eXRzn9iQSJB3Kwof8vFr0it9pSgYlNghHbShphdi3ZaKa
         0qi+tUbPQ6j8A1w1W0lCnZjO9ekSp3jOLzNgbkYnAJk4vV6B+MSAsl0bYPh9QLSndb
         GazU253+lyGsvQDhjP3ynbSVSUWZliMamiPafEb+Xx/o/pHlpG37Fg97/LBMNhEJ5p
         fesrhRdTKaAiOQvkvCMx+eKXf9IyCP/SiO6FPUROxUXQiUyoC+K1tYR7XQIDHdIa3H
         TF4oefhqFyn2EeFBj8+XjaKueKDHS3cvz9czvT4copr9la/pF4sSoera64qsSD5JnF
         TIlQtptRCKJkA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JCrhwr276519;
        Fri, 19 Apr 2019 05:53:43 -0700
Date:   Fri, 19 Apr 2019 05:53:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-fabe38ab6b2bd9418350284c63825f13b8a6abba@git.kernel.org>
Cc:     hpa@zytor.com, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, righi.andrea@gmail.com, tglx@linutronix.de,
        mathieu.desnoyers@efficios.com, francis.deslauriers@efficios.com,
        rostedt@goodmis.org, mingo@kernel.org,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, tglx@linutronix.de,
          mathieu.desnoyers@efficios.com, righi.andrea@gmail.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, torvalds@linux-foundation.org,
          francis.deslauriers@efficios.com, mhiramat@kernel.org,
          rostedt@goodmis.org
In-Reply-To: <155094062044.6137.6419622920568680640.stgit@devbox>
References: <155094062044.6137.6419622920568680640.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kprobes: Mark ftrace mcount handler functions
 nokprobe
Git-Commit-ID: fabe38ab6b2bd9418350284c63825f13b8a6abba
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

Commit-ID:  fabe38ab6b2bd9418350284c63825f13b8a6abba
Gitweb:     https://git.kernel.org/tip/fabe38ab6b2bd9418350284c63825f13b8a6abba
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Sun, 24 Feb 2019 01:50:20 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 14:26:06 +0200

kprobes: Mark ftrace mcount handler functions nokprobe

Mark ftrace mcount handler functions nokprobe since
probing on these functions with kretprobe pushes
return address incorrectly on kretprobe shadow stack.

Reported-by: Francis Deslauriers <francis.deslauriers@efficios.com>
Tested-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/155094062044.6137.6419622920568680640.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/trace/ftrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 26c8ca9bd06b..b920358dd8f7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -33,6 +33,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
+#include <linux/kprobes.h>
 
 #include <trace/events/sched.h>
 
@@ -6246,7 +6247,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
 	tr->ops->func = ftrace_stub;
 }
 
-static inline void
+static nokprobe_inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *ignored, struct pt_regs *regs)
 {
@@ -6306,11 +6307,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
 }
+NOKPROBE_SYMBOL(ftrace_ops_list_func);
 #else
 static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
 }
+NOKPROBE_SYMBOL(ftrace_ops_no_ops);
 #endif
 
 /*
@@ -6337,6 +6340,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
 }
+NOKPROBE_SYMBOL(ftrace_ops_assist_func);
 
 /**
  * ftrace_ops_get_func - get the function a trampoline should call
