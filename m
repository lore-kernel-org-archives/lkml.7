Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0719C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF4F26B89
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315893;
	bh=DA8P4T+3wgACovGExfhc3vgRPHlpnGo8G4C+9COLFQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gJSKHeg+gfPrQ5N1PQbq6M1WwzDO2sDY6no0D9f2i22HuRflw3LTnL2HGvdmF4EzB
	 AR/us2ou0qqlW2yshXt7jZi917fRBdJAqEp3K4OZQwHF9UrzuPi9uGb/nGLj7XHFcW
	 NZqJlXtXT1GWbXvqMFl/4cIYBY+9O5MqRLTxDFLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEaPSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfEaPSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:18:12 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4685F22CD9;
        Fri, 31 May 2019 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315891;
        bh=DA8P4T+3wgACovGExfhc3vgRPHlpnGo8G4C+9COLFQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8ZnihIPX7VLlopvs2WP4Rog5PIa2N0EkI0ye4yF4NtbrGUBAn00qw3p+bh4OYu4J
         X2GcKDn+c+hcvmKmfa3jTCi4Z/MUyuvZBFzzLwmFggxbCfGqWOByiUaksScUM+9pSw
         2JXUd2O1lmyeLF0iCfKsJckCWgNNz95nOgMS0yVQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/21] tracing/kprobe: Check registered state using kprobe
Date:   Sat,  1 Jun 2019 00:18:07 +0900
Message-Id: <155931588704.28323.4952266828256245833.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change registered check only by trace_kprobe and remove
TP_FLAG_REGISTERED from trace_probe, since this feature
is only used for trace_kprobe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   23 +++++++++++++++--------
 kernel/trace/trace_probe.h  |    6 ------
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

