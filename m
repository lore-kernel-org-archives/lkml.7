Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B70CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00BC206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390787AbfIEPpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbfIEPnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489952082C;
        Thu,  5 Sep 2019 15:43:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tv9-0007Se-IE; Thu, 05 Sep 2019 11:43:39 -0400
Message-Id: <20190905154339.451160440@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:42:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 01/25] kprobes: Allow kprobes coexist with livepatch
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Allow kprobes which do not modify regs->ip, coexist with livepatch
by dropping FTRACE_OPS_FL_IPMODIFY from ftrace_ops.

User who wants to modify regs->ip (e.g. function fault injection)
must set a dummy post_handler to its kprobes when registering.
However, if such regs->ip modifying kprobes is set on a function,
that function can not be livepatched.

Link: http://lkml.kernel.org/r/156403587671.30117.5233558741694155985.stgit@devnote2

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c | 56 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d9770a5393c8..f57deec96ba1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -961,9 +961,16 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 
 #ifdef CONFIG_KPROBES_ON_FTRACE
 static struct ftrace_ops kprobe_ftrace_ops __read_mostly = {
+	.func = kprobe_ftrace_handler,
+	.flags = FTRACE_OPS_FL_SAVE_REGS,
+};
+
+static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 	.func = kprobe_ftrace_handler,
 	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_IPMODIFY,
 };
+
+static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
 
 /* Must ensure p->addr is really on ftrace */
@@ -976,58 +983,75 @@ static int prepare_kprobe(struct kprobe *p)
 }
 
 /* Caller must lock kprobe_mutex */
-static int arm_kprobe_ftrace(struct kprobe *p)
+static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
+			       int *cnt)
 {
 	int ret = 0;
 
-	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
-				   (unsigned long)p->addr, 0, 0);
+	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
 	if (ret) {
 		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
 			 p->addr, ret);
 		return ret;
 	}
 
-	if (kprobe_ftrace_enabled == 0) {
-		ret = register_ftrace_function(&kprobe_ftrace_ops);
+	if (*cnt == 0) {
+		ret = register_ftrace_function(ops);
 		if (ret) {
 			pr_debug("Failed to init kprobe-ftrace (%d)\n", ret);
 			goto err_ftrace;
 		}
 	}
 
-	kprobe_ftrace_enabled++;
+	(*cnt)++;
 	return ret;
 
 err_ftrace:
 	/*
-	 * Note: Since kprobe_ftrace_ops has IPMODIFY set, and ftrace requires a
-	 * non-empty filter_hash for IPMODIFY ops, we're safe from an accidental
-	 * empty filter_hash which would undesirably trace all functions.
+	 * At this point, sinec ops is not registered, we should be sefe from
+	 * registering empty filter.
 	 */
-	ftrace_set_filter_ip(&kprobe_ftrace_ops, (unsigned long)p->addr, 1, 0);
+	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
 	return ret;
 }
 
+static int arm_kprobe_ftrace(struct kprobe *p)
+{
+	bool ipmodify = (p->post_handler != NULL);
+
+	return __arm_kprobe_ftrace(p,
+		ipmodify ? &kprobe_ipmodify_ops : &kprobe_ftrace_ops,
+		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
+}
+
 /* Caller must lock kprobe_mutex */
-static int disarm_kprobe_ftrace(struct kprobe *p)
+static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
+				  int *cnt)
 {
 	int ret = 0;
 
-	if (kprobe_ftrace_enabled == 1) {
-		ret = unregister_ftrace_function(&kprobe_ftrace_ops);
+	if (*cnt == 1) {
+		ret = unregister_ftrace_function(ops);
 		if (WARN(ret < 0, "Failed to unregister kprobe-ftrace (%d)\n", ret))
 			return ret;
 	}
 
-	kprobe_ftrace_enabled--;
+	(*cnt)--;
 
-	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
-			   (unsigned long)p->addr, 1, 0);
+	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
 	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
 		  p->addr, ret);
 	return ret;
 }
+
+static int disarm_kprobe_ftrace(struct kprobe *p)
+{
+	bool ipmodify = (p->post_handler != NULL);
+
+	return __disarm_kprobe_ftrace(p,
+		ipmodify ? &kprobe_ipmodify_ops : &kprobe_ftrace_ops,
+		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
+}
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 #define prepare_kprobe(p)	arch_prepare_kprobe(p)
 #define arm_kprobe_ftrace(p)	(-ENODEV)
-- 
2.20.1


