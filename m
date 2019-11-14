Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B48C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458F420727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKNSTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfKNSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8A820859;
        Thu, 14 Nov 2019 18:18:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhK-00017I-8t; Thu, 14 Nov 2019 13:18:26 -0500
Message-Id: <20191114181826.145493743@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [for-next][PATCH 19/33] tracing: Make internal ftrace events static
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

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

Link: http://lkml.kernel.org/r/20191015121012.18824-1-ben.dooks@codethink.co.uk

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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


