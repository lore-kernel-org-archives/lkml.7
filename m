Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB00C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C652147A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfFYTPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733041AbfFYTPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC82621726;
        Tue, 25 Jun 2019 19:15:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquw-0002Nc-Qs; Tue, 25 Jun 2019 15:15:46 -0400
Message-Id: <20190625191546.716820444@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/12] tracing/kprobe: Check registered state using kprobe
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Change registered check only by trace_kprobe and remove
TP_FLAG_REGISTERED from trace_probe, since this feature
is only used for trace_kprobe.

Link: http://lkml.kernel.org/r/155931588704.28323.4952266828256245833.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 23 +++++++++++++++--------
 kernel/trace/trace_probe.h  |  6 ------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 62362ad1ad98..9d483ad9bb6c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -157,6 +157,12 @@ static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
 	return nhit;
 }
 
+static nokprobe_inline bool trace_kprobe_is_registered(struct trace_kprobe *tk)
+{
+	return !(list_empty(&tk->rp.kp.list) &&
+		 hlist_unhashed(&tk->rp.kp.hlist));
+}
+
 /* Return 0 if it fails to find the symbol address */
 static nokprobe_inline
 unsigned long trace_kprobe_address(struct trace_kprobe *tk)
@@ -244,6 +250,8 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 		tk->rp.kp.pre_handler = kprobe_dispatcher;
 
 	tk->rp.maxactive = maxactive;
+	INIT_HLIST_NODE(&tk->rp.kp.hlist);
+	INIT_LIST_HEAD(&tk->rp.kp.list);
 
 	ret = trace_probe_init(&tk->tp, event, group);
 	if (ret < 0)
@@ -273,7 +281,7 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
 {
 	int ret = 0;
 
-	if (trace_probe_is_registered(&tk->tp) && !trace_kprobe_has_gone(tk)) {
+	if (trace_kprobe_is_registered(tk) && !trace_kprobe_has_gone(tk)) {
 		if (trace_kprobe_is_return(tk))
 			ret = enable_kretprobe(&tk->rp);
 		else
@@ -333,7 +341,7 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 	} else
 		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
-	if (!trace_probe_is_enabled(tp) && trace_probe_is_registered(tp)) {
+	if (!trace_probe_is_enabled(tp) && trace_kprobe_is_registered(tk)) {
 		if (trace_kprobe_is_return(tk))
 			disable_kretprobe(&tk->rp);
 		else
@@ -381,7 +389,7 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
-	if (trace_probe_is_registered(&tk->tp))
+	if (trace_kprobe_is_registered(tk))
 		return -EINVAL;
 
 	if (within_notrace_func(tk)) {
@@ -407,21 +415,20 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	else
 		ret = register_kprobe(&tk->rp.kp);
 
-	if (ret == 0)
-		trace_probe_set_flag(&tk->tp, TP_FLAG_REGISTERED);
 	return ret;
 }
 
 /* Internal unregister function - just handle k*probes and flags */
 static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 {
-	if (trace_probe_is_registered(&tk->tp)) {
+	if (trace_kprobe_is_registered(tk)) {
 		if (trace_kprobe_is_return(tk))
 			unregister_kretprobe(&tk->rp);
 		else
 			unregister_kprobe(&tk->rp.kp);
-		trace_probe_clear_flag(&tk->tp, TP_FLAG_REGISTERED);
-		/* Cleanup kprobe for reuse */
+		/* Cleanup kprobe for reuse and mark it unregistered */
+		INIT_HLIST_NODE(&tk->rp.kp.hlist);
+		INIT_LIST_HEAD(&tk->rp.kp.list);
 		if (tk->rp.kp.symbol_name)
 			tk->rp.kp.addr = NULL;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 6c33d4aa36c3..d1714820efe1 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -55,7 +55,6 @@
 /* Flags for trace_probe */
 #define TP_FLAG_TRACE		1
 #define TP_FLAG_PROFILE		2
-#define TP_FLAG_REGISTERED	4
 
 /* data_loc: data location, compatible with u32 */
 #define make_data_loc(len, offs)	\
@@ -261,11 +260,6 @@ static inline bool trace_probe_is_enabled(struct trace_probe *tp)
 	return trace_probe_test_flag(tp, TP_FLAG_TRACE | TP_FLAG_PROFILE);
 }
 
-static inline bool trace_probe_is_registered(struct trace_probe *tp)
-{
-	return trace_probe_test_flag(tp, TP_FLAG_REGISTERED);
-}
-
 static inline const char *trace_probe_name(struct trace_probe *tp)
 {
 	return trace_event_name(&tp->call);
-- 
2.20.1


