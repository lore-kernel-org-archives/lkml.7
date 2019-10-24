Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F6ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB1A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TLFo2ofc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406160AbfJXKRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:17:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56030 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392611AbfJXKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2wjWXnfmi/lTkSLWwKyZUWPMN4Uje8x22OKVQg74ivk=; b=TLFo2ofco6nF7FVRWwmBtThyz
        NlF17gVU/LknAkHLbHW32DdtkQS3CiDQFPJhalKVrZZ3T/sTQ72MotFfz7igqWzaxzBdiBTSmpmXl
        esa6mKLQdVPkdSiBNMlXek95MKVJUqEK8mvTJdtQbh65h6fjZJuOfi/8MyGC6jrM25fIzFLrtEH99
        E8Npcsn+aLHIboE2/HJxCAqDJQo7bkazuO0wb7tjKtwBxiN6pxPvhmDdjr5U/AagAL6ZezYT7zvpW
        HPKDQGW9I+TXQ5CkHG39efsmt/mMr+zasbd3JrSIKRKDlcgUAg1mKVq54jAIXglz7Ex+MWstenTiJ
        ZcL3JU7ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNaA9-0006Uj-Ge; Thu, 24 Oct 2019 10:17:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4950F3006E3;
        Thu, 24 Oct 2019 12:15:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97E612100B874; Thu, 24 Oct 2019 12:16:09 +0200 (CEST)
Date:   Thu, 24 Oct 2019 12:16:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191024101609.GA4131@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021222110.49044eb5@oasis.local.home>
 <20191022202401.GO1817@hirez.programming.kicks-ass.net>
 <20191023145245.53c75d70@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023145245.53c75d70@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 02:52:45PM -0400, Steven Rostedt wrote:
> After applying this series and this patch I triggered this:

Bah, I hate C.

(also for some reason I had KPROBE_EVENTS disabled, when I enabled it it
failed on boot due to selftests)

this one seems to boot and survive your selftests thing (that takes for
bloody ever to run).

---
Subject: ftrace: Rework event_create_dir()

Rework event_create_dir() to use an array of static data instead of
function pointers where possible.

The problem is that it would call the function pointer on module load
before parse_args(), possibly even before jump_labels were initialized.

Luckily the generated functions don't use jump_labels but it still seems
fragile. It also gets in the way of changing when we make the module map
executable.

The generated function are basically calling trace_define_field() with a
bunch of static arguments. So instead of a function, capture these
arguments in a static array, avoiding the function call.

Now there are a number of cases where the fields are dynamic (syscall
arguments, kprobes and uprobes), in which case a static array does not
work, for these we preserve the function call. Luckily all these cases
are not related to modules and so we can retain the function call for
them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/xfs/xfs_trace.h             |   4 +-
 include/linux/trace_events.h   |  18 ++++++-
 include/trace/events/filemap.h |   2 +-
 include/trace/trace_events.h   |  64 ++++++++-----------------
 kernel/trace/trace.h           |  31 ++++++------
 kernel/trace/trace_entries.h   |  66 +++++++------------------
 kernel/trace/trace_events.c    |  20 +++++++-
 kernel/trace/trace_export.c    | 106 +++++++++++++++--------------------------
 kernel/trace/trace_kprobe.c    |  16 ++++++-
 kernel/trace/trace_syscalls.c  |  50 ++++++++-----------
 kernel/trace/trace_uprobe.c    |   9 +++-
 11 files changed, 172 insertions(+), 214 deletions(-)

diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index eaae275ed430..53c5485cf2a1 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -218,8 +218,8 @@ DECLARE_EVENT_CLASS(xfs_bmap_class,
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(xfs_ino_t, ino)
-		__field(void *, leaf);
-		__field(int, pos);
+		__field(void *, leaf)
+		__field(int, pos)
 		__field(xfs_fileoff_t, startoff)
 		__field(xfs_fsblock_t, startblock)
 		__field(xfs_filblks_t, blockcount)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 30a8cdcfd4a4..a379255c14a9 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -187,6 +187,22 @@ enum trace_reg {
 
 struct trace_event_call;
 
+#define TRACE_FUNCTION_TYPE ((const char *)~0UL)
+
+struct trace_event_fields {
+	const char *type;
+	union {
+		struct {
+			const char *name;
+			const int  size;
+			const int  align;
+			const int  is_signed;
+			const int  filter_type;
+		};
+		int (*define_fields)(struct trace_event_call *);
+	};
+};
+
 struct trace_event_class {
 	const char		*system;
 	void			*probe;
@@ -195,7 +211,7 @@ struct trace_event_class {
 #endif
 	int			(*reg)(struct trace_event_call *event,
 				       enum trace_reg type, void *data);
-	int			(*define_fields)(struct trace_event_call *);
+	struct trace_event_fields *fields_array;
 	struct list_head	*(*get_fields)(struct trace_event_call *);
 	struct list_head	fields;
 	int			(*raw_init)(struct trace_event_call *);
diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index ee05db7ee8d2..796053e162d2 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -85,7 +85,7 @@ TRACE_EVENT(file_check_and_advance_wb_err,
 		TP_ARGS(file, old),
 
 		TP_STRUCT__entry(
-			__field(struct file *, file);
+			__field(struct file *, file)
 			__field(unsigned long, i_ino)
 			__field(dev_t, s_dev)
 			__field(errseq_t, old)
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4ecdfe2e3580..ca1d2e745a3f 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -394,22 +394,16 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 #undef __field_ext
-#define __field_ext(type, item, filter_type)				\
-	ret = trace_define_field(event_call, #type, #item,		\
-				 offsetof(typeof(field), item),		\
-				 sizeof(field.item),			\
-				 is_signed_type(type), filter_type);	\
-	if (ret)							\
-		return ret;
+#define __field_ext(_type, _item, _filter_type) {			\
+	.type = #_type, .name = #_item,					\
+	.size = sizeof(_type), .align = __alignof__(_type),		\
+	.is_signed = is_signed_type(_type), .filter_type = _filter_type },
 
 #undef __field_struct_ext
-#define __field_struct_ext(type, item, filter_type)			\
-	ret = trace_define_field(event_call, #type, #item,		\
-				 offsetof(typeof(field), item),		\
-				 sizeof(field.item),			\
-				 0, filter_type);			\
-	if (ret)							\
-		return ret;
+#define __field_struct_ext(_type, _item, _filter_type) {		\
+	.type = #_type, .name = #_item,					\
+	.size = sizeof(_type), .align = __alignof__(_type),		\
+	0, .filter_type = _filter_type },
 
 #undef __field
 #define __field(type, item)	__field_ext(type, item, FILTER_OTHER)
@@ -418,25 +412,16 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #define __field_struct(type, item) __field_struct_ext(type, item, FILTER_OTHER)
 
 #undef __array
-#define __array(type, item, len)					\
-	do {								\
-		char *type_str = #type"["__stringify(len)"]";		\
-		BUILD_BUG_ON(len > MAX_FILTER_STR_VAL);			\
-		BUILD_BUG_ON(len <= 0);					\
-		ret = trace_define_field(event_call, type_str, #item,	\
-				 offsetof(typeof(field), item),		\
-				 sizeof(field.item),			\
-				 is_signed_type(type), FILTER_OTHER);	\
-		if (ret)						\
-			return ret;					\
-	} while (0);
+#define __array(_type, _item, _len) {					\
+	.type = #_type"["__stringify(_len)"]", .name = #_item,		\
+	.size = sizeof(_type[_len]), .align = __alignof__(_type),	\
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
 
 #undef __dynamic_array
-#define __dynamic_array(type, item, len)				       \
-	ret = trace_define_field(event_call, "__data_loc " #type "[]", #item,  \
-				 offsetof(typeof(field), __data_loc_##item),   \
-				 sizeof(field.__data_loc_##item),	       \
-				 is_signed_type(type), FILTER_OTHER);
+#define __dynamic_array(_type, _item, _len) {				\
+	.type = "__data_loc " #_type "[]", .name = #_item,		\
+	.size = 4, .align = 4,						\
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
 
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
@@ -446,16 +431,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
-static int notrace __init						\
-trace_event_define_fields_##call(struct trace_event_call *event_call)	\
-{									\
-	struct trace_event_raw_##call field;				\
-	int ret;							\
-									\
-	tstruct;							\
-									\
-	return ret;							\
-}
+static struct trace_event_fields trace_event_fields_##call[] = {	\
+	tstruct								\
+	{} };
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)
@@ -613,7 +591,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
  *
  * static struct trace_event_class __used event_class_<template> = {
  *	.system			= "<system>",
- *	.define_fields		= trace_event_define_fields_<call>,
+ *	.fields_array		= trace_event_fields_<call>,
  *	.fields			= LIST_HEAD_INIT(event_class_##call.fields),
  *	.raw_init		= trace_event_raw_init,
  *	.probe			= trace_event_raw_event_##call,
@@ -761,7 +739,7 @@ _TRACE_PERF_PROTO(call, PARAMS(proto));					\
 static char print_fmt_##call[] = print;					\
 static struct trace_event_class __used __refdata event_class_##call = { \
 	.system			= TRACE_SYSTEM_STRING,			\
-	.define_fields		= trace_event_define_fields_##call,	\
+	.fields_array		= trace_event_fields_##call,		\
 	.fields			= LIST_HEAD_INIT(event_class_##call.fields),\
 	.raw_init		= trace_event_raw_init,			\
 	.probe			= trace_event_raw_event_##call,		\
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d685c61085c0..298a7cacf146 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -49,6 +49,9 @@ enum trace_type {
 #undef __field
 #define __field(type, item)		type	item;
 
+#undef __field_fn
+#define __field_fn(type, item)		type	item;
+
 #undef __field_struct
 #define __field_struct(type, item)	__field(type, item)
 
@@ -68,26 +71,22 @@ enum trace_type {
 #define F_STRUCT(args...)		args
 
 #undef FTRACE_ENTRY
-#define FTRACE_ENTRY(name, struct_name, id, tstruct, print, filter)	\
+#define FTRACE_ENTRY(name, struct_name, id, tstruct, print)		\
 	struct struct_name {						\
 		struct trace_entry	ent;				\
 		tstruct							\
 	}
 
 #undef FTRACE_ENTRY_DUP
-#define FTRACE_ENTRY_DUP(name, name_struct, id, tstruct, printk, filter)
+#define FTRACE_ENTRY_DUP(name, name_struct, id, tstruct, printk)
 
 #undef FTRACE_ENTRY_REG
-#define FTRACE_ENTRY_REG(name, struct_name, id, tstruct, print,	\
-			 filter, regfn) \
-	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
-		     filter)
+#define FTRACE_ENTRY_REG(name, struct_name, id, tstruct, print,	regfn)	\
+	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print))
 
 #undef FTRACE_ENTRY_PACKED
-#define FTRACE_ENTRY_PACKED(name, struct_name, id, tstruct, print,	\
-			    filter)					\
-	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
-		     filter) __packed
+#define FTRACE_ENTRY_PACKED(name, struct_name, id, tstruct, print)	\
+	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print)) __packed
 
 #include "trace_entries.h"
 
@@ -1899,17 +1898,15 @@ extern void tracing_log_err(struct trace_array *tr,
 #define internal_trace_puts(str) __trace_puts(_THIS_IP_, str, strlen(str))
 
 #undef FTRACE_ENTRY
-#define FTRACE_ENTRY(call, struct_name, id, tstruct, print, filter)	\
+#define FTRACE_ENTRY(call, struct_name, id, tstruct, print)	\
 	extern struct trace_event_call					\
 	__aligned(4) event_##call;
 #undef FTRACE_ENTRY_DUP
-#define FTRACE_ENTRY_DUP(call, struct_name, id, tstruct, print, filter)	\
-	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print), \
-		     filter)
+#define FTRACE_ENTRY_DUP(call, struct_name, id, tstruct, print)	\
+	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print))
 #undef FTRACE_ENTRY_PACKED
-#define FTRACE_ENTRY_PACKED(call, struct_name, id, tstruct, print, filter) \
-	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print), \
-		     filter)
+#define FTRACE_ENTRY_PACKED(call, struct_name, id, tstruct, print) \
+	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print))
 
 #include "trace_entries.h"
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index fc8e97328e54..3e9d81608284 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -61,15 +61,13 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 	TRACE_FN,
 
 	F_STRUCT(
-		__field(	unsigned long,	ip		)
-		__field(	unsigned long,	parent_ip	)
+		__field_fn(	unsigned long,	ip		)
+		__field_fn(	unsigned long,	parent_ip	)
 	),
 
 	F_printk(" %ps <-- %ps",
 		 (void *)__entry->ip, (void *)__entry->parent_ip),
 
-	FILTER_TRACE_FN,
-
 	perf_ftrace_event_register
 );
 
@@ -84,9 +82,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 		__field_desc(	int,		graph_ent,	depth		)
 	),
 
-	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth),
-
-	FILTER_OTHER
+	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
 );
 
 /* Function return entry */
@@ -97,18 +93,16 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
 		__field_desc(	unsigned long,	ret,		func	)
+		__field_desc(	unsigned long,	ret,		overrun	)
 		__field_desc(	unsigned long long, ret,	calltime)
 		__field_desc(	unsigned long long, ret,	rettime	)
-		__field_desc(	unsigned long,	ret,		overrun	)
 		__field_desc(	int,		ret,		depth	)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
 		 (void *)__entry->func, __entry->depth,
 		 __entry->calltime, __entry->rettime,
-		 __entry->depth),
-
-	FILTER_OTHER
+		 __entry->depth)
 );
 
 /*
@@ -137,9 +131,7 @@ FTRACE_ENTRY(context_switch, ctx_switch_entry,
 	F_printk("%u:%u:%u  ==> %u:%u:%u [%03u]",
 		 __entry->prev_pid, __entry->prev_prio, __entry->prev_state,
 		 __entry->next_pid, __entry->next_prio, __entry->next_state,
-		 __entry->next_cpu),
-
-	FILTER_OTHER
+		 __entry->next_cpu)
 );
 
 /*
@@ -157,9 +149,7 @@ FTRACE_ENTRY_DUP(wakeup, ctx_switch_entry,
 	F_printk("%u:%u:%u  ==+ %u:%u:%u [%03u]",
 		 __entry->prev_pid, __entry->prev_prio, __entry->prev_state,
 		 __entry->next_pid, __entry->next_prio, __entry->next_state,
-		 __entry->next_cpu),
-
-	FILTER_OTHER
+		 __entry->next_cpu)
 );
 
 /*
@@ -183,9 +173,7 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 		 (void *)__entry->caller[0], (void *)__entry->caller[1],
 		 (void *)__entry->caller[2], (void *)__entry->caller[3],
 		 (void *)__entry->caller[4], (void *)__entry->caller[5],
-		 (void *)__entry->caller[6], (void *)__entry->caller[7]),
-
-	FILTER_OTHER
+		 (void *)__entry->caller[6], (void *)__entry->caller[7])
 );
 
 FTRACE_ENTRY(user_stack, userstack_entry,
@@ -203,9 +191,7 @@ FTRACE_ENTRY(user_stack, userstack_entry,
 		 (void *)__entry->caller[0], (void *)__entry->caller[1],
 		 (void *)__entry->caller[2], (void *)__entry->caller[3],
 		 (void *)__entry->caller[4], (void *)__entry->caller[5],
-		 (void *)__entry->caller[6], (void *)__entry->caller[7]),
-
-	FILTER_OTHER
+		 (void *)__entry->caller[6], (void *)__entry->caller[7])
 );
 
 /*
@@ -222,9 +208,7 @@ FTRACE_ENTRY(bprint, bprint_entry,
 	),
 
 	F_printk("%ps: %s",
-		 (void *)__entry->ip, __entry->fmt),
-
-	FILTER_OTHER
+		 (void *)__entry->ip, __entry->fmt)
 );
 
 FTRACE_ENTRY_REG(print, print_entry,
@@ -239,8 +223,6 @@ FTRACE_ENTRY_REG(print, print_entry,
 	F_printk("%ps: %s",
 		 (void *)__entry->ip, __entry->buf),
 
-	FILTER_OTHER,
-
 	ftrace_event_register
 );
 
@@ -254,9 +236,7 @@ FTRACE_ENTRY(raw_data, raw_data_entry,
 	),
 
 	F_printk("id:%04x %08x",
-		 __entry->id, (int)__entry->buf[0]),
-
-	FILTER_OTHER
+		 __entry->id, (int)__entry->buf[0])
 );
 
 FTRACE_ENTRY(bputs, bputs_entry,
@@ -269,9 +249,7 @@ FTRACE_ENTRY(bputs, bputs_entry,
 	),
 
 	F_printk("%ps: %s",
-		 (void *)__entry->ip, __entry->str),
-
-	FILTER_OTHER
+		 (void *)__entry->ip, __entry->str)
 );
 
 FTRACE_ENTRY(mmiotrace_rw, trace_mmiotrace_rw,
@@ -283,16 +261,14 @@ FTRACE_ENTRY(mmiotrace_rw, trace_mmiotrace_rw,
 		__field_desc(	resource_size_t, rw,	phys	)
 		__field_desc(	unsigned long,	rw,	value	)
 		__field_desc(	unsigned long,	rw,	pc	)
-		__field_desc(	int, 		rw,	map_id	)
+		__field_desc(	int,		rw,	map_id	)
 		__field_desc(	unsigned char,	rw,	opcode	)
 		__field_desc(	unsigned char,	rw,	width	)
 	),
 
 	F_printk("%lx %lx %lx %d %x %x",
 		 (unsigned long)__entry->phys, __entry->value, __entry->pc,
-		 __entry->map_id, __entry->opcode, __entry->width),
-
-	FILTER_OTHER
+		 __entry->map_id, __entry->opcode, __entry->width)
 );
 
 FTRACE_ENTRY(mmiotrace_map, trace_mmiotrace_map,
@@ -304,15 +280,13 @@ FTRACE_ENTRY(mmiotrace_map, trace_mmiotrace_map,
 		__field_desc(	resource_size_t, map,	phys	)
 		__field_desc(	unsigned long,	map,	virt	)
 		__field_desc(	unsigned long,	map,	len	)
-		__field_desc(	int, 		map,	map_id	)
+		__field_desc(	int,		map,	map_id	)
 		__field_desc(	unsigned char,	map,	opcode	)
 	),
 
 	F_printk("%lx %lx %lx %d %x",
 		 (unsigned long)__entry->phys, __entry->virt, __entry->len,
-		 __entry->map_id, __entry->opcode),
-
-	FILTER_OTHER
+		 __entry->map_id, __entry->opcode)
 );
 
 
@@ -334,9 +308,7 @@ FTRACE_ENTRY(branch, trace_branch,
 	F_printk("%u:%s:%s (%u)%s",
 		 __entry->line,
 		 __entry->func, __entry->file, __entry->correct,
-		 __entry->constant ? " CONSTANT" : ""),
-
-	FILTER_OTHER
+		 __entry->constant ? " CONSTANT" : "")
 );
 
 
@@ -362,7 +334,5 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		 __entry->duration,
 		 __entry->outer_duration,
 		 __entry->nmi_total_ts,
-		 __entry->nmi_count),
-
-	FILTER_OTHER
+		 __entry->nmi_count)
 );
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index fba87d10f0c1..5ab10c3dce78 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 
 #include <trace/events/sched.h>
+#include <trace/syscall.h>
 
 #include <asm/setup.h>
 
@@ -1990,7 +1991,24 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	 */
 	head = trace_get_fields(call);
 	if (list_empty(head)) {
-		ret = call->class->define_fields(call);
+		struct trace_event_fields *field = call->class->fields_array;
+		unsigned int offset = sizeof(struct trace_entry);
+
+		for (; field->type; field++) {
+			if (field->type == TRACE_FUNCTION_TYPE) {
+				ret = field->define_fields(call);
+				break;
+			}
+
+			offset = ALIGN(offset, field->align);
+			ret = trace_define_field(call, field->type, field->name,
+						 offset, field->size,
+						 field->is_signed, field->filter_type);
+			if (ret)
+				break;
+
+			offset += field->size;
+		}
 		if (ret < 0) {
 			pr_warn("Could not initialize trace point events/%s\n",
 				name);
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 45630a76ed3a..6d64c1c19fd5 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -29,10 +29,8 @@ static int ftrace_event_register(struct trace_event_call *call,
  * function and thus become accesible via perf.
  */
 #undef FTRACE_ENTRY_REG
-#define FTRACE_ENTRY_REG(name, struct_name, id, tstruct, print, \
-			 filter, regfn) \
-	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
-		     filter)
+#define FTRACE_ENTRY_REG(name, struct_name, id, tstruct, print, regfn) \
+	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print))
 
 /* not needed for this file */
 #undef __field_struct
@@ -41,6 +39,9 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef __field
 #define __field(type, item)				type item;
 
+#undef __field_fn
+#define __field_fn(type, item)				type item;
+
 #undef __field_desc
 #define __field_desc(type, container, item)		type item;
 
@@ -60,7 +61,7 @@ static int ftrace_event_register(struct trace_event_call *call,
 #define F_printk(fmt, args...) fmt, args
 
 #undef FTRACE_ENTRY
-#define FTRACE_ENTRY(name, struct_name, id, tstruct, print, filter)	\
+#define FTRACE_ENTRY(name, struct_name, id, tstruct, print)		\
 struct ____ftrace_##name {						\
 	tstruct								\
 };									\
@@ -73,76 +74,46 @@ static void __always_unused ____ftrace_check_##name(void)		\
 }
 
 #undef FTRACE_ENTRY_DUP
-#define FTRACE_ENTRY_DUP(name, struct_name, id, tstruct, print, filter)	\
-	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
-		     filter)
+#define FTRACE_ENTRY_DUP(name, struct_name, id, tstruct, print)		\
+	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print))
 
 #include "trace_entries.h"
 
+#undef __field_ext
+#define __field_ext(_type, _item, _filter_type) {			\
+	.type = #_type, .name = #_item,					\
+	.size = sizeof(_type), .align = __alignof__(_type),		\
+	is_signed_type(_type), .filter_type = _filter_type },
+
 #undef __field
-#define __field(type, item)						\
-	ret = trace_define_field(event_call, #type, #item,		\
-				 offsetof(typeof(field), item),		\
-				 sizeof(field.item),			\
-				 is_signed_type(type), filter_type);	\
-	if (ret)							\
-		return ret;
+#define __field(_type, _item) __field_ext(_type, _item, FILTER_OTHER)
+
+#undef __field_fn
+#define __field_fn(_type, _item) __field_ext(_type, _item, FILTER_TRACE_FN)
 
 #undef __field_desc
-#define __field_desc(type, container, item)	\
-	ret = trace_define_field(event_call, #type, #item,		\
-				 offsetof(typeof(field),		\
-					  container.item),		\
-				 sizeof(field.container.item),		\
-				 is_signed_type(type), filter_type);	\
-	if (ret)							\
-		return ret;
+#define __field_desc(_type, _container, _item) __field_ext(_type, _item, FILTER_OTHER)
 
 #undef __array
-#define __array(type, item, len)					\
-	do {								\
-		char *type_str = #type"["__stringify(len)"]";		\
-		BUILD_BUG_ON(len > MAX_FILTER_STR_VAL);			\
-		ret = trace_define_field(event_call, type_str, #item,	\
-				 offsetof(typeof(field), item),		\
-				 sizeof(field.item),			\
-				 is_signed_type(type), filter_type);	\
-		if (ret)						\
-			return ret;					\
-	} while (0);
+#define __array(_type, _item, _len) {					\
+	.type = #_type"["__stringify(_len)"]", .name = #_item,		\
+	.size = sizeof(_type[_len]), .align = __alignof__(_type),	\
+	is_signed_type(_type), .filter_type = FILTER_OTHER },
 
 #undef __array_desc
-#define __array_desc(type, container, item, len)			\
-	BUILD_BUG_ON(len > MAX_FILTER_STR_VAL);				\
-	ret = trace_define_field(event_call, #type "[" #len "]", #item,	\
-				 offsetof(typeof(field),		\
-					  container.item),		\
-				 sizeof(field.container.item),		\
-				 is_signed_type(type), filter_type);	\
-	if (ret)							\
-		return ret;
+#define __array_desc(_type, _container, _item, _len) __array(_type, _item, _len)
 
 #undef __dynamic_array
-#define __dynamic_array(type, item)					\
-	ret = trace_define_field(event_call, #type "[]", #item,  \
-				 offsetof(typeof(field), item),		\
-				 0, is_signed_type(type), filter_type);\
-	if (ret)							\
-		return ret;
+#define __dynamic_array(_type, _item) {					\
+	.type = #_type "[]", .name = #_item,				\
+	.size = 0, .align = __alignof__(_type),				\
+	is_signed_type(_type), .filter_type = FILTER_OTHER },
 
 #undef FTRACE_ENTRY
-#define FTRACE_ENTRY(name, struct_name, id, tstruct, print, filter)	\
-static int __init							\
-ftrace_define_fields_##name(struct trace_event_call *event_call)	\
-{									\
-	struct struct_name field;					\
-	int ret;							\
-	int filter_type = filter;					\
-									\
-	tstruct;							\
-									\
-	return ret;							\
-}
+#define FTRACE_ENTRY(name, struct_name, id, tstruct, print)		\
+static struct trace_event_fields ftrace_event_fields_##name[] = {	\
+	tstruct								\
+	{} };
 
 #include "trace_entries.h"
 
@@ -152,6 +123,9 @@ ftrace_define_fields_##name(struct trace_event_call *event_call)	\
 #undef __field
 #define __field(type, item)
 
+#undef __field_fn
+#define __field_fn(type, item)
+
 #undef __field_desc
 #define __field_desc(type, container, item)
 
@@ -168,12 +142,10 @@ ftrace_define_fields_##name(struct trace_event_call *event_call)	\
 #define F_printk(fmt, args...) __stringify(fmt) ", "  __stringify(args)
 
 #undef FTRACE_ENTRY_REG
-#define FTRACE_ENTRY_REG(call, struct_name, etype, tstruct, print, filter,\
-			 regfn)						\
-									\
+#define FTRACE_ENTRY_REG(call, struct_name, etype, tstruct, print, regfn) \
 struct trace_event_class __refdata event_class_ftrace_##call = {	\
 	.system			= __stringify(TRACE_SYSTEM),		\
-	.define_fields		= ftrace_define_fields_##call,		\
+	.fields_array		= ftrace_event_fields_##call,		\
 	.fields			= LIST_HEAD_INIT(event_class_ftrace_##call.fields),\
 	.reg			= regfn,				\
 };									\
@@ -191,9 +163,9 @@ struct trace_event_call __used						\
 __attribute__((section("_ftrace_events"))) *__event_##call = &event_##call;
 
 #undef FTRACE_ENTRY
-#define FTRACE_ENTRY(call, struct_name, etype, tstruct, print, filter)	\
+#define FTRACE_ENTRY(call, struct_name, etype, tstruct, print)		\
 	FTRACE_ENTRY_REG(call, struct_name, etype,			\
-			 PARAMS(tstruct), PARAMS(print), filter, NULL)
+			 PARAMS(tstruct), PARAMS(print), NULL)
 
 bool ftrace_event_is_function(struct trace_event_call *call)
 {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1552a95c743b..66e0a8ff1c01 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1534,16 +1534,28 @@ static struct trace_event_functions kprobe_funcs = {
 	.trace		= print_kprobe_event
 };
 
+static struct trace_event_fields kretprobe_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = kretprobe_event_define_fields },
+	{}
+};
+
+static struct trace_event_fields kprobe_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = kprobe_event_define_fields },
+	{}
+};
+
 static inline void init_trace_event_call(struct trace_kprobe *tk)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
 
 	if (trace_kprobe_is_return(tk)) {
 		call->event.funcs = &kretprobe_funcs;
-		call->class->define_fields = kretprobe_event_define_fields;
+		call->class->fields_array = kretprobe_fields_array;
 	} else {
 		call->event.funcs = &kprobe_funcs;
-		call->class->define_fields = kprobe_event_define_fields;
+		call->class->fields_array = kprobe_fields_array;
 	}
 
 	call->flags = TRACE_EVENT_FL_KPROBE;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index fa8fbff736d6..53935259f701 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -198,11 +198,10 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 
 extern char *__bad_type_size(void);
 
-#define SYSCALL_FIELD(type, field, name)				\
-	sizeof(type) != sizeof(trace.field) ?				\
-		__bad_type_size() :					\
-		#type, #name, offsetof(typeof(trace), field),		\
-		sizeof(trace.field), is_signed_type(type)
+#define SYSCALL_FIELD(_type, _name) {					\
+	.type = #_type, .name = #_name,					\
+	.size = sizeof(_type), .align = __alignof__(_type),		\
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER }
 
 static int __init
 __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
@@ -269,42 +268,22 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 {
 	struct syscall_trace_enter trace;
 	struct syscall_metadata *meta = call->data;
-	int ret;
-	int i;
 	int offset = offsetof(typeof(trace), args);
-
-	ret = trace_define_field(call, SYSCALL_FIELD(int, nr, __syscall_nr),
-				 FILTER_OTHER);
-	if (ret)
-		return ret;
+	int ret, i;
 
 	for (i = 0; i < meta->nb_args; i++) {
 		ret = trace_define_field(call, meta->types[i],
 					 meta->args[i], offset,
 					 sizeof(unsigned long), 0,
 					 FILTER_OTHER);
+		if (ret)
+			break;
 		offset += sizeof(unsigned long);
 	}
 
 	return ret;
 }
 
-static int __init syscall_exit_define_fields(struct trace_event_call *call)
-{
-	struct syscall_trace_exit trace;
-	int ret;
-
-	ret = trace_define_field(call, SYSCALL_FIELD(int, nr, __syscall_nr),
-				 FILTER_OTHER);
-	if (ret)
-		return ret;
-
-	ret = trace_define_field(call, SYSCALL_FIELD(long, ret, ret),
-				 FILTER_OTHER);
-
-	return ret;
-}
-
 static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 {
 	struct trace_array *tr = data;
@@ -502,6 +481,13 @@ static int __init init_syscall_trace(struct trace_event_call *call)
 	return id;
 }
 
+static struct trace_event_fields __refdata syscall_enter_fields_array[] = {
+	SYSCALL_FIELD(int, __syscall_nr),
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = syscall_enter_define_fields },
+	{}
+};
+
 struct trace_event_functions enter_syscall_print_funcs = {
 	.trace		= print_syscall_enter,
 };
@@ -513,7 +499,7 @@ struct trace_event_functions exit_syscall_print_funcs = {
 struct trace_event_class __refdata event_class_syscall_enter = {
 	.system		= "syscalls",
 	.reg		= syscall_enter_register,
-	.define_fields	= syscall_enter_define_fields,
+	.fields_array	= syscall_enter_fields_array,
 	.get_fields	= syscall_get_enter_fields,
 	.raw_init	= init_syscall_trace,
 };
@@ -521,7 +507,11 @@ struct trace_event_class __refdata event_class_syscall_enter = {
 struct trace_event_class __refdata event_class_syscall_exit = {
 	.system		= "syscalls",
 	.reg		= syscall_exit_register,
-	.define_fields	= syscall_exit_define_fields,
+	.fields_array	= (struct trace_event_fields[]){
+		SYSCALL_FIELD(int, __syscall_nr),
+		SYSCALL_FIELD(long, ret),
+		{}
+	},
 	.fields		= LIST_HEAD_INIT(event_class_syscall_exit.fields),
 	.raw_init	= init_syscall_trace,
 };
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 352073d36585..476a382f1f1b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1507,12 +1507,17 @@ static struct trace_event_functions uprobe_funcs = {
 	.trace		= print_uprobe_event
 };
 
+static struct trace_event_fields uprobe_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = uprobe_event_define_fields },
+	{}
+};
+
 static inline void init_trace_event_call(struct trace_uprobe *tu)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
-
 	call->event.funcs = &uprobe_funcs;
-	call->class->define_fields = uprobe_event_define_fields;
+	call->class->fields_array = uprobe_fields_array;
 
 	call->flags = TRACE_EVENT_FL_UPROBE | TRACE_EVENT_FL_CAP_ANY;
 	call->class->reg = trace_uprobe_register;
