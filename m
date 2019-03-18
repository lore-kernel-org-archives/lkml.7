Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46953C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C8B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ngHCfuOZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HvQp331h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfCRKsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:48:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfCRKsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:48:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B43B60DB3; Mon, 18 Mar 2019 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552906081;
        bh=83CCORDePcFOxUrcagi2flDbR6V8sSqYrBj9+d8Of8c=;
        h=From:To:Cc:Subject:Date:From;
        b=ngHCfuOZj3m+kTviqantOa1y4+NJr6gFu5ud+6gVBdJ0lgHJlPcXgvxFEyQuEwmS4
         AuvoluOGTpafv4zpKzMEeyaObgtb1mlppf9qyw2zPRHEnnnKbDaornzQ6Hmtavfzs8
         UOcCX/5lsurhps48+IMf9udJOgWprGh1vNU/k4rc=
Received: from prsood-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2E4F602FC;
        Mon, 18 Mar 2019 10:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552906079;
        bh=83CCORDePcFOxUrcagi2flDbR6V8sSqYrBj9+d8Of8c=;
        h=From:To:Cc:Subject:Date:From;
        b=HvQp331hQaKKJUQ+4ksMFHsBIRGsEoUGaokVZ86UyzspdLkL0Wq+/HMcGoalSZZJz
         ib6lHv5Mm7mArYfOp7hWMVDVFd1fQ170UoHnEYmsv7KrPvfsgsRRK80wKO8cMjs7mn
         QkCjItrEf8erCpfMY5STLGGCEyucQGArN3v5WL6Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2E4F602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        Prateek Sood <prsood@codeaurora.org>
Subject: [PATCH] perf: extend total_ref_count usage to protect perf_trace_buf access
Date:   Mon, 18 Mar 2019 16:17:45 +0530
Message-Id: <1552906065-24137-1-git-send-email-prsood@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A potential race exists between access of perf_trace_buf[i] from
perf_trace_buf_alloc() and perf_trace_event_unreg(). This can
result in perf_trace_buf[i] being NULL during access from memset()
in perf_trace_buf_alloc().

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
---
 include/linux/trace_events.h    |  2 ++
 include/trace/perf.h            |  5 ++++-
 kernel/trace/trace_event_perf.c | 43 ++++++++++++++++++++++++++++-------------
 kernel/trace/trace_kprobe.c     | 10 ++++++++--
 kernel/trace/trace_syscalls.c   | 14 ++++++++++----
 kernel/trace/trace_uprobe.c     |  2 ++
 6 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731..dbdad19 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -591,6 +591,8 @@ extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
 extern void ftrace_profile_free_filter(struct perf_event *event);
 void perf_trace_buf_update(void *record, u16 type);
 void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
+void get_perf_trace_buf(void);
+void put_perf_trace_buf(void);
 
 void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
 void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
diff --git a/include/trace/perf.h b/include/trace/perf.h
index dbc6c74..f808c33 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -55,9 +55,10 @@
 			     sizeof(u64));				\
 	__entry_size -= sizeof(u32);					\
 									\
+	get_perf_trace_buf();						\
 	entry = perf_trace_buf_alloc(__entry_size, &__regs, &rctx);	\
 	if (!entry)							\
-		return;							\
+		goto out;						\
 									\
 	perf_fetch_caller_regs(__regs);					\
 									\
@@ -68,6 +69,8 @@
 	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
 				  event_call, __count, __regs,		\
 				  head, __task);			\
+out:									\
+	put_perf_trace_buf();						\
 }
 
 /*
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 4629a61..fabfc21 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -21,7 +21,7 @@ typedef typeof(unsigned long [PERF_MAX_TRACE_SIZE / sizeof(unsigned long)])
 	perf_trace_t;
 
 /* Count the events in use (per event id, not per instance) */
-static int	total_ref_count;
+static atomic_t	total_ref_count;
 
 static int perf_trace_event_perm(struct trace_event_call *tp_event,
 				 struct perf_event *p_event)
@@ -88,6 +88,27 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	return 0;
 }
 
+void get_perf_trace_buf()
+{
+	atomic_inc(&total_ref_count);
+}
+EXPORT_SYMBOL_GPL(get_perf_trace_buf);
+NOKPROBE_SYMBOL(get_perf_trace_buf);
+
+void put_perf_trace_buf()
+{
+	int index;
+
+	if (atomic_dec_and_test(&total_ref_count)) {
+		for (index = 0; index < PERF_NR_CONTEXTS; index++) {
+			free_percpu(perf_trace_buf[index]);
+			perf_trace_buf[index] = NULL;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(put_perf_trace_buf);
+NOKPROBE_SYMBOL(put_perf_trace_buf);
+
 static int perf_trace_event_reg(struct trace_event_call *tp_event,
 				struct perf_event *p_event)
 {
@@ -108,7 +129,7 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
 
 	tp_event->perf_events = list;
 
-	if (!total_ref_count) {
+	if (!atomic_read(&total_ref_count)) {
 		char __percpu *buf;
 		int i;
 
@@ -125,11 +146,11 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
 	if (ret)
 		goto fail;
 
-	total_ref_count++;
+	get_perf_trace_buf();
 	return 0;
 
 fail:
-	if (!total_ref_count) {
+	if (!atomic_read(&total_ref_count)) {
 		int i;
 
 		for (i = 0; i < PERF_NR_CONTEXTS; i++) {
@@ -164,13 +185,7 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
 
 	free_percpu(tp_event->perf_events);
 	tp_event->perf_events = NULL;
-
-	if (!--total_ref_count) {
-		for (i = 0; i < PERF_NR_CONTEXTS; i++) {
-			free_percpu(perf_trace_buf[i]);
-			perf_trace_buf[i] = NULL;
-		}
-	}
+	put_perf_trace_buf();
 out:
 	module_put(tp_event->mod);
 }
@@ -453,15 +468,17 @@ void perf_trace_buf_update(void *record, u16 type)
 	memset(&regs, 0, sizeof(regs));
 	perf_fetch_caller_regs(&regs);
 
+	get_perf_trace_buf();
 	entry = perf_trace_buf_alloc(ENTRY_SIZE, NULL, &rctx);
 	if (!entry)
-		return;
+		goto out;
 
 	entry->ip = ip;
 	entry->parent_ip = parent_ip;
 	perf_trace_buf_submit(entry, ENTRY_SIZE, rctx, TRACE_FN,
 			      1, &regs, &head, NULL);
-
+out:
+	put_perf_trace_buf();
 #undef ENTRY_SIZE
 }
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5d5129b..7830190 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1166,15 +1166,18 @@ static int kretprobe_event_define_fields(struct trace_event_call *event_call)
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
+	get_perf_trace_buf();
 	entry = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!entry)
-		return 0;
+		goto out;
 
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	memset(&entry[1], 0, dsize);
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
+out:
+	put_perf_trace_buf();
 	return 0;
 }
 NOKPROBE_SYMBOL(kprobe_perf_func);
@@ -1202,15 +1205,18 @@ static int kretprobe_event_define_fields(struct trace_event_call *event_call)
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
+	get_perf_trace_buf();
 	entry = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!entry)
-		return;
+		goto out;
 
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
+out:
+	put_perf_trace_buf();
 }
 NOKPROBE_SYMBOL(kretprobe_perf_func);
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f93a56d..a08110f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -608,9 +608,10 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	size = ALIGN(size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
+	get_perf_trace_buf();
 	rec = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
-		return;
+		goto out;
 
 	rec->nr = syscall_nr;
 	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
@@ -620,12 +621,14 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
-		return;
+		goto out;
 	}
 
 	perf_trace_buf_submit(rec, size, rctx,
 			      sys_data->enter_event->event.type, 1, regs,
 			      head, NULL);
+out:
+	put_perf_trace_buf();
 }
 
 static int perf_sysenter_enable(struct trace_event_call *call)
@@ -706,9 +709,10 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	size = ALIGN(sizeof(*rec) + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
+	get_perf_trace_buf();
 	rec = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
-		return;
+		goto out;
 
 	rec->nr = syscall_nr;
 	rec->ret = syscall_get_return_value(current, regs);
@@ -717,11 +721,13 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	     !perf_call_bpf_exit(sys_data->exit_event, regs, rec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
-		return;
+		goto out;
 	}
 
 	perf_trace_buf_submit(rec, size, rctx, sys_data->exit_event->event.type,
 			      1, regs, head, NULL);
+out:
+	put_perf_trace_buf();
 }
 
 static int perf_sysexit_enable(struct trace_event_call *call)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index be78d99..c931b22 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1116,6 +1116,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	if (hlist_empty(head))
 		goto out;
 
+	get_perf_trace_buf();
 	entry = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!entry)
 		goto out;
@@ -1140,6 +1141,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
  out:
+	put_perf_trace_buf();
 	preempt_enable();
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

