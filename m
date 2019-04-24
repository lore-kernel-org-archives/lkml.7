Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A162089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128389;
	bh=7ytUT25nApniYjVdY2qrdBjYpthTJc1twv6E3pgsj/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pIzzNDW5JVApj6r2pGuBSb6P4WWjyImLqRnyyOgVzO1U+gpzFSGCirVWHtak5iEHq
	 CGHFrpXlcU2CD0cZTWQKAV2B+qU/T1F5xcguvb7jYfRCVTHrASF0VY2c5638BCKzcS
	 8CjKyJ99HUD+juhdywAhe2eHo5AV8JNvK710k6vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbfDXR1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390479AbfDXR1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:32 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02692077C;
        Wed, 24 Apr 2019 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126851;
        bh=7ytUT25nApniYjVdY2qrdBjYpthTJc1twv6E3pgsj/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vcz7E3/soDhhIZsFHjhsG6W4pQgGVfAoJqAqFXmb3/uT7WD6/b36Zf29GXFsJLXnl
         IDpFDkrXvcrJAdKSeDDtr8D4IBHA7zixww6WhgXH1r9yBT25RRn1Vqf9t+9toeC2g3
         JR+yrUs+7QYWMeMwjyUoMhHDc637Gb2Knq7heCtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 40/70] kprobes: Mark ftrace mcount handler functions nokprobe
Date:   Wed, 24 Apr 2019 19:10:00 +0200
Message-Id: <20190424170912.851221323@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit fabe38ab6b2bd9418350284c63825f13b8a6abba upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -33,6 +33,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
+#include <linux/kprobes.h>
 
 #include <trace/events/sched.h>
 
@@ -6035,7 +6036,7 @@ void ftrace_reset_array_ops(struct trace
 	tr->ops->func = ftrace_stub;
 }
 
-static inline void
+static nokprobe_inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *ignored, struct pt_regs *regs)
 {
@@ -6098,11 +6099,13 @@ static void ftrace_ops_list_func(unsigne
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
@@ -6132,6 +6135,7 @@ static void ftrace_ops_assist_func(unsig
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
 }
+NOKPROBE_SYMBOL(ftrace_ops_assist_func);
 
 /**
  * ftrace_ops_get_func - get the function a trampoline should call


