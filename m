Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523FFC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C5C21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gTOOA3PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfJGLZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfJGLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IflCNhxDyIf4nOSWUeoA2DZsFUo5mAzEb13SRO4TUbQ=; b=gTOOA3PVnj9DvMLTf7jb71R2lx
        5zxGRApzqNFoHxmFLe/lUFaVeqxHWfBspep9GRvo0ol9WgXUrB1KRypSmUvzM4rEbmuM0i0oGIYH7
        buwoogD+bG8pRRpjINO4aZ5da94EhH9Q1CXrvKqcIMM9BDgTnJytEPKX1ZaxGxqTpJy80Kg8mDSE4
        7ZPRzDMGa+t1EG2gnDZBemF7rJczol/5dSwPUUZsnkr0qh9zccZY3ehpKQHcvakZIuGUxiM7zq/Eo
        2Jv6lhWNciw5h3GA3FHpwbCDFPvoj+lz+6gZyf57gnGvGg5D+ko/t8TQVt2LZcTWgRO7nxCbC85Cg
        xb/qXAiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003HK-T1; Mon, 07 Oct 2019 11:23:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32489307098;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D009520244E3C; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083830.98511141.6@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 08/13] tracepoints: Use static_call
References: <20191007082708.01393931.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt  <rostedt@goodmis.org>

[peterz: updated to new interface]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/tracepoint-defs.h |    5 ++
 include/linux/tracepoint.h      |   75 ++++++++++++++++++++++++++--------------
 include/trace/define_trace.h    |   14 +++----
 kernel/tracepoint.c             |   19 ++++++++--
 4 files changed, 77 insertions(+), 36 deletions(-)

--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -11,6 +11,8 @@
 #include <linux/atomic.h>
 #include <linux/static_key.h>
 
+struct static_call_key;
+
 struct trace_print_flags {
 	unsigned long		mask;
 	const char		*name;
@@ -30,6 +32,9 @@ struct tracepoint_func {
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
 	struct static_key key;
+	struct static_call_key *static_call_key;
+	void *static_call_tramp;
+	void *iterator;
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func __rcu *funcs;
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -19,6 +19,7 @@
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/static_call.h>
 
 struct module;
 struct tracepoint;
@@ -92,7 +93,9 @@ extern int syscall_regfunc(void);
 extern void syscall_unregfunc(void);
 #endif /* CONFIG_HAVE_SYSCALL_TRACEPOINTS */
 
+#ifndef PARAMS
 #define PARAMS(args...) args
+#endif
 
 #define TRACE_DEFINE_ENUM(x)
 #define TRACE_DEFINE_SIZEOF(x)
@@ -159,12 +162,11 @@ static inline struct tracepoint *tracepo
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
+#define __DO_TRACE(name, proto, args, cond, rcuidle)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
-		void *it_func;						\
-		void *__data;						\
 		int __maybe_unused __idx = 0;				\
+		void *__data;						\
 									\
 		if (!(cond))						\
 			return;						\
@@ -184,14 +186,11 @@ static inline struct tracepoint *tracepo
 			rcu_irq_enter_irqson();				\
 		}							\
 									\
-		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
-									\
+		it_func_ptr =						\
+			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
 		if (it_func_ptr) {					\
-			do {						\
-				it_func = (it_func_ptr)->func;		\
-				__data = (it_func_ptr)->data;		\
-				((void(*)(proto))(it_func))(args);	\
-			} while ((++it_func_ptr)->func);		\
+			__data = (it_func_ptr)->data;			\
+			static_call(tp_func_##name)(args);		\
 		}							\
 									\
 		if (rcuidle) {						\
@@ -207,7 +206,7 @@ static inline struct tracepoint *tracepo
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 1);			\
@@ -229,11 +228,13 @@ static inline struct tracepoint *tracepo
  * poking RCU a bit.
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+	extern int __tracepoint_iter_##name(data_proto);		\
+	DECLARE_STATIC_CALL(tp_func_##name, __tracepoint_iter_##name); \
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
-			__DO_TRACE(&__tracepoint_##name,		\
+			__DO_TRACE(name,				\
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 0);			\
@@ -279,21 +280,45 @@ static inline struct tracepoint *tracepo
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
  */
-#define DEFINE_TRACE_FN(name, reg, unreg)				 \
-	static const char __tpstrtab_##name[]				 \
-	__attribute__((section("__tracepoints_strings"))) = #name;	 \
-	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"), used)) =		 \
-		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
-	__TRACEPOINT_ENTRY(name);
+#define DEFINE_TRACE_FN(name, reg, unreg, proto, args)			\
+	static const char __tpstrtab_##name[]				\
+	__attribute__((section("__tracepoints_strings"))) = #name;	\
+	extern struct static_call_key tp_func_##name;			\
+	int __tracepoint_iter_##name(void *__data, proto);		\
+	struct tracepoint __tracepoint_##name				\
+	__attribute__((section("__tracepoints"), used)) =		\
+		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE,		\
+		  &STATIC_CALL_NAME(tp_func_##name),			\
+		  &STATIC_CALL_TRAMP(tp_func_##name),			\
+		  &__tracepoint_iter_##name,				\
+		  reg, unreg, NULL };					\
+	__TRACEPOINT_ENTRY(name);					\
+	int __tracepoint_iter_##name(void *__data, proto)		\
+	{								\
+		struct tracepoint_func *it_func_ptr;			\
+		void *it_func;						\
+									\
+		it_func_ptr =						\
+			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
+		do {							\
+			it_func = (it_func_ptr)->func;			\
+			__data = (it_func_ptr)->data;			\
+			((void(*)(void *, proto))(it_func))(__data, args); \
+		} while ((++it_func_ptr)->func);			\
+		return 0;						\
+	}								\
+	DEFINE_STATIC_CALL(tp_func_##name, __tracepoint_iter_##name);
 
-#define DEFINE_TRACE(name)						\
-	DEFINE_TRACE_FN(name, NULL, NULL);
+#define DEFINE_TRACE(name, proto, args)		\
+	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
-	EXPORT_SYMBOL_GPL(__tracepoint_##name)
+	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
+	EXPORT_STATIC_CALL_GPL(tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
-	EXPORT_SYMBOL(__tracepoint_##name)
+	EXPORT_SYMBOL(__tracepoint_##name);				\
+	EXPORT_STATIC_CALL(tp_func_##name)
+
 
 #else /* !TRACEPOINTS_ENABLED */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
@@ -322,8 +347,8 @@ static inline struct tracepoint *tracepo
 		return false;						\
 	}
 
-#define DEFINE_TRACE_FN(name, reg, unreg)
-#define DEFINE_TRACE(name)
+#define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
+#define DEFINE_TRACE(name, proto, args)
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)
 
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -25,7 +25,7 @@
 
 #undef TRACE_EVENT
 #define TRACE_EVENT(name, proto, args, tstruct, assign, print)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_CONDITION
 #define TRACE_EVENT_CONDITION(name, proto, args, cond, tstruct, assign, print) \
@@ -39,12 +39,12 @@
 #undef TRACE_EVENT_FN
 #define TRACE_EVENT_FN(name, proto, args, tstruct,		\
 		assign, print, reg, unreg)			\
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_FN_COND
 #define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
 		assign, print, reg, unreg)			\
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_EVENT_NOP
 #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
@@ -54,15 +54,15 @@
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args) \
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_FN
 #define DEFINE_EVENT_FN(template, name, proto, args, reg, unreg) \
-	DEFINE_TRACE_FN(name, reg, unreg)
+	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef DEFINE_EVENT_CONDITION
 #define DEFINE_EVENT_CONDITION(template, name, proto, args, cond) \
@@ -70,7 +70,7 @@
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(name, proto, args)	\
-	DEFINE_TRACE(name)
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 #undef TRACE_INCLUDE
 #undef __TRACE_INCLUDE
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -127,7 +127,7 @@ static void debug_print_probes(struct tr
 
 static struct tracepoint_func *
 func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
-	 int prio)
+	 int prio, int *tot_probes)
 {
 	struct tracepoint_func *old, *new;
 	int nr_probes = 0;
@@ -170,11 +170,12 @@ func_add(struct tracepoint_func **funcs,
 	new[nr_probes + 1].func = NULL;
 	*funcs = new;
 	debug_print_probes(*funcs);
+	*tot_probes = nr_probes + 1;
 	return old;
 }
 
 static void *func_remove(struct tracepoint_func **funcs,
-		struct tracepoint_func *tp_func)
+		struct tracepoint_func *tp_func, int *left)
 {
 	int nr_probes = 0, nr_del = 0, i;
 	struct tracepoint_func *old, *new;
@@ -228,6 +229,7 @@ static int tracepoint_add_func(struct tr
 			       struct tracepoint_func *func, int prio)
 {
 	struct tracepoint_func *old, *tp_funcs;
+	int probes = 0;
 	int ret;
 
 	if (tp->regfunc && !static_key_enabled(&tp->key)) {
@@ -238,7 +240,7 @@ static int tracepoint_add_func(struct tr
 
 	tp_funcs = rcu_dereference_protected(tp->funcs,
 			lockdep_is_held(&tracepoints_mutex));
-	old = func_add(&tp_funcs, func, prio);
+	old = func_add(&tp_funcs, func, prio, &probes);
 	if (IS_ERR(old)) {
 		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
@@ -253,6 +255,10 @@ static int tracepoint_add_func(struct tr
 	rcu_assign_pointer(tp->funcs, tp_funcs);
 	if (!static_key_enabled(&tp->key))
 		static_key_slow_inc(&tp->key);
+
+	__static_call_update(tp->static_call_key, tp->static_call_tramp,
+			     probes == 1 ? tp_funcs->func : tp->iterator);
+
 	release_probes(old);
 	return 0;
 }
@@ -267,10 +273,11 @@ static int tracepoint_remove_func(struct
 		struct tracepoint_func *func)
 {
 	struct tracepoint_func *old, *tp_funcs;
+	int probes_left = 0;
 
 	tp_funcs = rcu_dereference_protected(tp->funcs,
 			lockdep_is_held(&tracepoints_mutex));
-	old = func_remove(&tp_funcs, func);
+	old = func_remove(&tp_funcs, func, &probes_left);
 	if (IS_ERR(old)) {
 		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
@@ -284,6 +291,10 @@ static int tracepoint_remove_func(struct
 		if (static_key_enabled(&tp->key))
 			static_key_slow_dec(&tp->key);
 	}
+
+	__static_call_update(tp->static_call_key, tp->static_call_tramp,
+			     probes_left == 1 ? tp_funcs->func : tp->iterator);
+
 	rcu_assign_pointer(tp->funcs, tp_funcs);
 	release_probes(old);
 	return 0;


