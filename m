Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CADC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8785321773
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfEYDSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 23:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfEYDRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:17:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915FC2186A;
        Sat, 25 May 2019 03:17:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNBq-0001lc-M6; Fri, 24 May 2019 23:17:46 -0400
Message-Id: <20190525031746.569488607@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:16:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: [PATCH 09/16 v3] ftrace: Allow ftrace startup flags exist without dynamic ftrace
References: <20190525031633.811342628@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Some of the flags for ftrace_startup() may be exposed even when
CONFIG_DYNAMIC_FTRACE is not configured in. This is fine as the difference
between dynamic ftrace and static ftrace is done within the internals of
ftrace itself. No need to have use cases fail to compile because dynamic
ftrace is disabled.

This change is needed to move some of the logic of what is passed to
ftrace_startup() out of the parameters of ftrace_startup().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 766c565ba243..d0307c9b866e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -286,6 +286,15 @@ static inline void stack_tracer_disable(void) { }
 static inline void stack_tracer_enable(void) { }
 #endif
 
+enum {
+	FTRACE_UPDATE_CALLS		= (1 << 0),
+	FTRACE_DISABLE_CALLS		= (1 << 1),
+	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
+	FTRACE_START_FUNC_RET		= (1 << 3),
+	FTRACE_STOP_FUNC_RET		= (1 << 4),
+	FTRACE_MAY_SLEEP		= (1 << 5),
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 int ftrace_arch_code_modify_prepare(void);
@@ -373,15 +382,6 @@ void ftrace_set_global_notrace(unsigned char *buf, int len, int reset);
 void ftrace_free_filter(struct ftrace_ops *ops);
 void ftrace_ops_set_global_filter(struct ftrace_ops *ops);
 
-enum {
-	FTRACE_UPDATE_CALLS		= (1 << 0),
-	FTRACE_DISABLE_CALLS		= (1 << 1),
-	FTRACE_UPDATE_TRACE_FUNC	= (1 << 2),
-	FTRACE_START_FUNC_RET		= (1 << 3),
-	FTRACE_STOP_FUNC_RET		= (1 << 4),
-	FTRACE_MAY_SLEEP		= (1 << 5),
-};
-
 /*
  * The FTRACE_UPDATE_* enum is used to pass information back
  * from the ftrace_update_record() and ftrace_test_record()
-- 
2.20.1


