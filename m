Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A2AECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF86205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfJOMKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:10:34 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45324 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfJOMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:10:22 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKLeX-00016l-FO; Tue, 15 Oct 2019 13:10:13 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKLeX-0004uN-1N; Tue, 15 Oct 2019 13:10:13 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: make internal data static
Date:   Tue, 15 Oct 2019 13:10:12 +0100
Message-Id: <20191015121012.18824-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event_class_ftrace_##call and event_##call do not seem
to be used outside of trace_export.c so make them both static
to avoid a number of sparse warnings:

kernel/trace/trace_entries.h:59:1: warning: symbol 'event_class_ftrace_function' was not declared. Should it be static?
kernel/trace/trace_entries.h:59:1: warning: symbol '__event_function' was not declared. Should it be static?
kernel/trace/trace_entries.h:77:1: warning: symbol 'event_class_ftrace_funcgraph_entry' was not declared. Should it be static?
kernel/trace/trace_entries.h:77:1: warning: symbol '__event_funcgraph_entry' was not declared. Should it be static?
kernel/trace/trace_entries.h:93:1: warning: symbol 'event_class_ftrace_funcgraph_exit' was not declared. Should it be static?
kernel/trace/trace_entries.h:93:1: warning: symbol '__event_funcgraph_exit' was not declared. Should it be static?
kernel/trace/trace_entries.h:129:1: warning: symbol 'event_class_ftrace_context_switch' was not declared. Should it be static?
kernel/trace/trace_entries.h:129:1: warning: symbol '__event_context_switch' was not declared. Should it be static?
kernel/trace/trace_entries.h:149:1: warning: symbol 'event_class_ftrace_wakeup' was not declared. Should it be static?
kernel/trace/trace_entries.h:149:1: warning: symbol '__event_wakeup' was not declared. Should it be static?
kernel/trace/trace_entries.h:171:1: warning: symbol 'event_class_ftrace_kernel_stack' was not declared. Should it be static?
kernel/trace/trace_entries.h:171:1: warning: symbol '__event_kernel_stack' was not declared. Should it be static?
kernel/trace/trace_entries.h:191:1: warning: symbol 'event_class_ftrace_user_stack' was not declared. Should it be static?
kernel/trace/trace_entries.h:191:1: warning: symbol '__event_user_stack' was not declared. Should it be static?
kernel/trace/trace_entries.h:214:1: warning: symbol 'event_class_ftrace_bprint' was not declared. Should it be static?
kernel/trace/trace_entries.h:214:1: warning: symbol '__event_bprint' was not declared. Should it be static?
kernel/trace/trace_entries.h:230:1: warning: symbol 'event_class_ftrace_print' was not declared. Should it be static?
kernel/trace/trace_entries.h:230:1: warning: symbol '__event_print' was not declared. Should it be static?
kernel/trace/trace_entries.h:247:1: warning: symbol 'event_class_ftrace_raw_data' was not declared. Should it be static?
kernel/trace/trace_entries.h:247:1: warning: symbol '__event_raw_data' was not declared. Should it be static?
kernel/trace/trace_entries.h:262:1: warning: symbol 'event_class_ftrace_bputs' was not declared. Should it be static?
kernel/trace/trace_entries.h:262:1: warning: symbol '__event_bputs' was not declared. Should it be static?
kernel/trace/trace_entries.h:277:1: warning: symbol 'event_class_ftrace_mmiotrace_rw' was not declared. Should it be static?
kernel/trace/trace_entries.h:277:1: warning: symbol '__event_mmiotrace_rw' was not declared. Should it be static?
kernel/trace/trace_entries.h:298:1: warning: symbol 'event_class_ftrace_mmiotrace_map' was not declared. Should it be static?
kernel/trace/trace_entries.h:298:1: warning: symbol '__event_mmiotrace_map' was not declared. Should it be static?
kernel/trace/trace_entries.h:322:1: warning: symbol 'event_class_ftrace_branch' was not declared. Should it be static?
kernel/trace/trace_entries.h:322:1: warning: symbol '__event_branch' was not declared. Should it be static?
kernel/trace/trace_entries.h:343:1: warning: symbol 'event_class_ftrace_hwlat' was not declared. Should it be static?
kernel/trace/trace_entries.h:343:1: warning: symbol '__event_hwlat' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/trace/trace_export.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 45630a76ed3a..2e6d2e9741cc 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -171,7 +171,7 @@ ftrace_define_fields_##name(struct trace_event_call *event_call)	\
 #define FTRACE_ENTRY_REG(call, struct_name, etype, tstruct, print, filter,\
 			 regfn)						\
 									\
-struct trace_event_class __refdata event_class_ftrace_##call = {	\
+static struct trace_event_class __refdata event_class_ftrace_##call = {	\
 	.system			= __stringify(TRACE_SYSTEM),		\
 	.define_fields		= ftrace_define_fields_##call,		\
 	.fields			= LIST_HEAD_INIT(event_class_ftrace_##call.fields),\
@@ -187,7 +187,7 @@ struct trace_event_call __used event_##call = {				\
 	.print_fmt		= print,				\
 	.flags			= TRACE_EVENT_FL_IGNORE_ENABLE,		\
 };									\
-struct trace_event_call __used						\
+static struct trace_event_call __used						\
 __attribute__((section("_ftrace_events"))) *__event_##call = &event_##call;
 
 #undef FTRACE_ENTRY
-- 
2.23.0

