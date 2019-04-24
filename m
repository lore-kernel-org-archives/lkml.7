Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B00C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF8121907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126592;
	bh=Gr2cVMTd9trIIxwruwRCr7jdoANIUg/jvsBKdxjcdgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VAn5r+1zGLilIsM6f/tBlfOPJjObKRE/qDE+Dd7fzyYlZRiA3uFENAsTGfEvJ4KOa
	 JtioWr76iBk52L9PIWcwsCCWODWO8y/i3VPdHwA1ehBZePCeMPrkOGrELpDWogJRSG
	 WNhoAEKymFGHwkIlUrACQhvrAH8LamI4oITkYUUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389668AbfDXRXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389656AbfDXRXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:09 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69A020675;
        Wed, 24 Apr 2019 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126588;
        bh=Gr2cVMTd9trIIxwruwRCr7jdoANIUg/jvsBKdxjcdgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfCR2tedh9M4c1fjIsSVQ5KTwnzV/lCskKWfb6PHIWl00J4vDQOSfPQOlCm6LfVO/
         xDV3zeR5SGvs7NbOqLZUJr7Gye5jvwGg/0NuxfTzxZz65xtnBca0WEKwmUDaJacEvJ
         DwEJlRISxVYccFi3qjP13t6SLI3hhR3/D6JrZpUo=
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
Subject: [PATCH 4.4 161/168] kprobes: Mark ftrace mcount handler functions nokprobe
Date:   Wed, 24 Apr 2019 19:10:05 +0200
Message-Id: <20190424170932.719238571@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -32,6 +32,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
+#include <linux/kprobes.h>
 
 #include <trace/events/sched.h>
 
@@ -5165,7 +5166,7 @@ static struct ftrace_ops control_ops = {
 	INIT_OPS_HASH(control_ops)
 };
 
-static inline void
+static nokprobe_inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *ignored, struct pt_regs *regs)
 {
@@ -5214,11 +5215,13 @@ static void ftrace_ops_list_func(unsigne
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
@@ -5239,6 +5242,7 @@ static void ftrace_ops_recurs_func(unsig
 
 	trace_clear_recursion(bit);
 }
+NOKPROBE_SYMBOL(ftrace_ops_recurs_func);
 
 /**
  * ftrace_ops_get_func - get the function a trampoline should call


