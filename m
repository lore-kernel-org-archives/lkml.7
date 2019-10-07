Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E5C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C613F206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xj6kR1vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfJGVrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:47:45 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49343 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfJGVrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:47:45 -0400
Received: by mail-pg1-f202.google.com with SMTP id b1so2748505pgt.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GhUd95mx+KCkBqn10VKF/e1n3M9SJKBAJacEGkZgbag=;
        b=Xj6kR1vTPiMwrpWzrdLd6bqsZFwFLdke/Ujuf1OBX7bhUBePtDlfD5HYI05KOlbcSS
         05e9Q1rWHNNhX3BLwkOlohZphPCWugyOAVPVtLXSYsBYJA4VnBfs+uQ+8r7Z/LNDWYpI
         UTvfQB4AclGVn4LlowOYeosRcub+zxMBmY8OnsA/orRmKDRHOLtu1SOXpH75wARKTXhK
         eKEs3EJMRgpTqYZlKRUe1Ker2krcAxCuUQROBnvpM94j6zuAiiqwDONHA+9eSDyp+Gwj
         aWqvTa9MRX5BkeP4OcPNDoc9524/Dun25Rt9otDYWtxNtfDC8NbPZs+7lYK9aMvwNqEp
         Vgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GhUd95mx+KCkBqn10VKF/e1n3M9SJKBAJacEGkZgbag=;
        b=qYKFz/rRY3cA8fKcmy51CvTV9Y8jSs45Accid9eVr9uy1DfgaJqjRSM3Bnpe1B2bV7
         qyqIBj0c2b8bsQr9+cZGca5vGBHwA0fbCYEWdg3bUuPgxLHc16TUK0gMCaN+j50+vfMT
         le4SnyI621nlX0eSXfJmx6q1ITNxSCA3ipTUgrgBBNRxv6Tem8514AvrMc8kEcysziJC
         l3rvXiD34XyliIxurFOnzbiVjLLFahNpaO9StnIENNaDsSwCVnk1ZohrDDsmAA7dqsjc
         oybLjurhlpqOAGkpKShrVUa1sxfSFhuSO2SSAh5kH7FfMQi2cElVYhxBXoFaC248ss7d
         b7CQ==
X-Gm-Message-State: APjAAAUh8hwyrheU479VK+fJFybBIIcSvkhiS27ROxX1q0jEFhhd4tZC
        fNQibcOKI/TNxYWQi86tTzYw8Nkkr7/XjFcSeE0=
X-Google-Smtp-Source: APXvYqyXQ80CW607u4PEzfPHlLUdJgm2Qp6k81A+k5sjSgDbJzrsWUDOEc4YycrVbx20H4+tC8yDBqAOb48/bR0xvTU=
X-Received: by 2002:a63:b13:: with SMTP id 19mr18986701pgl.175.1570484864312;
 Mon, 07 Oct 2019 14:47:44 -0700 (PDT)
Date:   Mon,  7 Oct 2019 14:47:40 -0700
Message-Id: <20191007214740.188547-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] ftrace: fix function type mismatches
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes indirect call mismatches with function and function
graph tracing, which trip Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/trace/fgraph.c | 9 ++++++---
 kernel/trace/ftrace.c | 8 +++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 7950a0356042..ecfd4a4a106a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -327,14 +327,17 @@ void ftrace_graph_sleep_time_control(bool enable)
 	fgraph_sleep_time = enable;
 }
 
+void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
+{
+}
+
 int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
 {
 	return 0;
 }
 
 /* The callbacks that hook a function */
-trace_func_graph_ret_t ftrace_graph_return =
-			(trace_func_graph_ret_t)ftrace_stub;
+trace_func_graph_ret_t ftrace_graph_return = ftrace_graph_return_stub;
 trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
 static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
 
@@ -614,7 +617,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		goto out;
 
 	ftrace_graph_active--;
-	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
+	ftrace_graph_return = ftrace_graph_return_stub;
 	ftrace_graph_entry = ftrace_graph_entry_stub;
 	__ftrace_graph_entry = ftrace_graph_entry_stub;
 	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 62a50bf399d6..b68ee130d4a2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -125,8 +125,9 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 				 struct ftrace_ops *op, struct pt_regs *regs);
 #else
 /* See comment below, where ftrace_ops_list_func is defined */
-static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
-#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
+static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip,
+			      struct ftrace_ops *op, struct pt_regs *regs);
+#define ftrace_ops_list_func ftrace_ops_no_ops
 #endif
 
 static inline void ftrace_ops_init(struct ftrace_ops *ops)
@@ -6325,7 +6326,8 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 }
 NOKPROBE_SYMBOL(ftrace_ops_list_func);
 #else
-static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
+static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip,
+			      struct ftrace_ops *op, struct pt_regs *regs)
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
 }
-- 
2.23.0.581.g78d2f28ef7-goog

