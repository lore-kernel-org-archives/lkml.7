Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C1C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80AF22468
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RkhEnrGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfJGLYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfJGLXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sITR6qYd+NYNASRNNA0LvJFFU0Vx05/fpHy1WWiCLNI=; b=RkhEnrGrStTBqwwCJADlpCgx4a
        4eaJXiPJZBxyiRA9UA3VmzfId9HLRknmTxWxpZslnX0qzTIpDASGGlYJMCiKuU7/ONPC/9sf6x9xu
        PFqPxemWcDLI3RykbiVLP3hfzQs/cl4o2BwfkS++K1xW4PcDibLuWyeRHn9UNmN3ercus0GeIK0L9
        SsPfkovkr0Sgf3zfVnJHFZ6vOYUIr1zUgGpq9s6OuX/tHE7tC3VqtAtW9ahXqnl5WvUNBcnKKjS4W
        NA3mtSYSZzhASl60zW7paL4n68dTSblnznz1JvPzB4hRIQQn/rCRBLfb1jIJLHb7t1KYYTyf/NvA5
        SVKM/zdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0002BV-AT; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E8283073AB;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AD45A20244E32; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083830.70301561.0@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 03/13] static_call: Add inline static call infrastructure
References: <20191007082708.01393931.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add infrastructure for an arch-specific CONFIG_HAVE_STATIC_CALL_INLINE
option, which is a faster version of CONFIG_HAVE_STATIC_CALL.  At
runtime, the static call sites are patched directly, rather than using
the out-of-line trampolines.

Compared to out-of-line static calls, the performance benefits are more
modest, but still measurable.  Steven Rostedt did some tracepoint
measurements:

  https://lkml.kernel.org/r/20181126155405.72b4f718@gandalf.local.home

This code is heavily inspired by the jump label code (aka "static
jumps"), as some of the concepts are very similar.

For more details, see the comments in include/linux/static_call.h.

[peterz: simplified interface; merged trampolines]
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig                      |    4 
 include/asm-generic/vmlinux.lds.h |    7 
 include/linux/module.h            |   10 +
 include/linux/static_call.h       |   37 ++++
 include/linux/static_call_types.h |    9 +
 kernel/Makefile                   |    1 
 kernel/module.c                   |    5 
 kernel/static_call.c              |  302 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 374 insertions(+), 1 deletion(-)
 create mode 100644 kernel/static_call.c

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -963,6 +963,10 @@ config ARCH_HAS_MEM_ENCRYPT
 config HAVE_STATIC_CALL
 	bool
 
+config HAVE_STATIC_CALL_INLINE
+	bool
+	depends on HAVE_STATIC_CALL
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -333,6 +333,12 @@
 	KEEP(*(__jump_table))						\
 	__stop___jump_table = .;
 
+#define STATIC_CALL_DATA						\
+	. = ALIGN(8);							\
+	__start_static_call_sites = .;					\
+	KEEP(*(.static_call_sites))					\
+	__stop_static_call_sites = .;
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -342,6 +348,7 @@
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
+	STATIC_CALL_DATA						\
 	__end_ro_after_init = .;
 #endif
 
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -22,6 +22,7 @@
 #include <linux/error-injection.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
+#include <linux/static_call_types.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -476,6 +477,10 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	int num_static_call_sites;
+	struct static_call_site *static_call_sites;
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
@@ -732,6 +737,11 @@ static inline bool within_module(unsigne
 {
 	return false;
 }
+
+static inline bool within_module_init(unsigned long addr, const struct module *mod)
+{
+	return false;
+}
 
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -78,7 +78,42 @@ extern void arch_static_call_transform(v
 			     &STATIC_CALL_TRAMP(name), func);		\
 })
 
-#if defined(CONFIG_HAVE_STATIC_CALL)
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
+struct static_call_mod {
+	struct static_call_mod *next;
+	struct module *mod; /* for vmlinux, mod == NULL */
+	struct static_call_site *sites;
+};
+
+struct static_call_key {
+	void *func;
+	struct static_call_mod *next;
+};
+
+extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
+extern int static_call_mod_init(struct module *mod);
+
+#define DEFINE_STATIC_CALL(name, _func)					\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_NAME(name) = {		\
+		.func = _func,						\
+		.next = NULL,						\
+	};								\
+	__ADDRESSABLE(STATIC_CALL_NAME(name));				\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+
+#define static_call(name)	STATIC_CALL_TRAMP(name)
+
+#define EXPORT_STATIC_CALL(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_NAME(name));				\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+
+#define EXPORT_STATIC_CALL_GPL(name)					\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_NAME(name));			\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+
+#elif defined(CONFIG_HAVE_STATIC_CALL)
 
 struct static_call_key {
 	void *func;
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -12,4 +12,13 @@
 #define STATIC_CALL_TRAMP(name)	    STATIC_CALL_NAME(name##_tramp)
 #define STATIC_CALL_TRAMP_STR(name) __stringify(STATIC_CALL_TRAMP(name))
 
+/*
+ * The static call site table needs to be created by external tooling (objtool
+ * or a compiler plugin).
+ */
+struct static_call_site {
+	s32 addr;
+	s32 key;
+};
+
 #endif /* _STATIC_CALL_TYPES_H */
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
+obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3231,6 +3231,11 @@ static int find_module_sections(struct m
 					    sizeof(*mod->ei_funcs),
 					    &mod->num_ei_funcs);
 #endif
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	mod->static_call_sites = section_objs(info, ".static_call_sites",
+					      sizeof(*mod->static_call_sites),
+					      &mod->num_static_call_sites);
+#endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 
--- /dev/null
+++ b/kernel/static_call.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/static_call.h>
+#include <linux/bug.h>
+#include <linux/smp.h>
+#include <linux/sort.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/processor.h>
+#include <asm/sections.h>
+
+extern struct static_call_site __start_static_call_sites[],
+			       __stop_static_call_sites[];
+
+static bool static_call_initialized;
+
+#define STATIC_CALL_INIT 1UL
+
+/* mutex to protect key modules/sites */
+static DEFINE_MUTEX(static_call_mutex);
+
+static void static_call_lock(void)
+{
+	mutex_lock(&static_call_mutex);
+}
+
+static void static_call_unlock(void)
+{
+	mutex_unlock(&static_call_mutex);
+}
+
+static inline void *static_call_addr(struct static_call_site *site)
+{
+	return (void *)((long)site->addr + (long)&site->addr);
+}
+
+
+static inline struct static_call_key *static_call_key(const struct static_call_site *site)
+{
+	return (struct static_call_key *)
+		(((long)site->key + (long)&site->key) & ~STATIC_CALL_INIT);
+}
+
+/* These assume the key is word-aligned. */
+static inline bool static_call_is_init(struct static_call_site *site)
+{
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_INIT;
+}
+
+static inline void static_call_set_init(struct static_call_site *site)
+{
+	site->key = ((long)static_call_key(site) | STATIC_CALL_INIT) -
+		    (long)&site->key;
+}
+
+static int static_call_site_cmp(const void *_a, const void *_b)
+{
+	const struct static_call_site *a = _a;
+	const struct static_call_site *b = _b;
+	const struct static_call_key *key_a = static_call_key(a);
+	const struct static_call_key *key_b = static_call_key(b);
+
+	if (key_a < key_b)
+		return -1;
+
+	if (key_a > key_b)
+		return 1;
+
+	return 0;
+}
+
+static void static_call_site_swap(void *_a, void *_b, int size)
+{
+	long delta = (unsigned long)_a - (unsigned long)_b;
+	struct static_call_site *a = _a;
+	struct static_call_site *b = _b;
+	struct static_call_site tmp = *a;
+
+	a->addr = b->addr  - delta;
+	a->key  = b->key   - delta;
+
+	b->addr = tmp.addr + delta;
+	b->key  = tmp.key  + delta;
+}
+
+static inline void static_call_sort_entries(struct static_call_site *start,
+					    struct static_call_site *stop)
+{
+	sort(start, stop - start, sizeof(struct static_call_site),
+	     static_call_site_cmp, static_call_site_swap);
+}
+
+void __static_call_update(struct static_call_key *key, void *tramp, void *func)
+{
+	struct static_call_site *site, *stop;
+	struct static_call_mod *site_mod;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	if (key->func == func)
+		goto done;
+
+	key->func = func;
+
+	arch_static_call_transform(NULL, tramp, func);
+
+	/*
+	 * If uninitialized, we'll not update the callsites, but they still
+	 * point to the trampoline and we just patched that.
+	 */
+	if (WARN_ON_ONCE(!static_call_initialized))
+		goto done;
+
+	for (site_mod = key->next; site_mod; site_mod = site_mod->next) {
+		if (!site_mod->sites) {
+			/*
+			 * This can happen if the static call key is defined in
+			 * a module which doesn't use it.
+			 */
+			continue;
+		}
+
+		stop = __stop_static_call_sites;
+
+#ifdef CONFIG_MODULES
+		if (site_mod->mod) {
+			stop = site_mod->mod->static_call_sites +
+			       site_mod->mod->num_static_call_sites;
+		}
+#endif
+
+		for (site = site_mod->sites;
+		     site < stop && static_call_key(site) == key; site++) {
+			void *site_addr = static_call_addr(site);
+			struct module *mod = site_mod->mod;
+
+			if (static_call_is_init(site)) {
+				/*
+				 * Don't write to call sites which were in
+				 * initmem and have since been freed.
+				 */
+				if (!mod && system_state >= SYSTEM_RUNNING)
+					continue;
+				if (mod && !within_module_init((unsigned long)site_addr, mod))
+					continue;
+			}
+
+			if (!kernel_text_address((unsigned long)site_addr)) {
+				WARN_ONCE(1, "can't patch static call site at %pS",
+					  site_addr);
+				continue;
+			}
+
+			arch_static_call_transform(site_addr, NULL, func);
+		}
+	}
+
+done:
+	static_call_unlock();
+	cpus_read_unlock();
+}
+EXPORT_SYMBOL_GPL(__static_call_update);
+
+static int __static_call_init(struct module *mod,
+			      struct static_call_site *start,
+			      struct static_call_site *stop)
+{
+	struct static_call_site *site;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod;
+
+	if (start == stop)
+		return 0;
+
+	static_call_sort_entries(start, stop);
+
+	for (site = start; site < stop; site++) {
+		void *site_addr = static_call_addr(site);
+
+		if ((mod && within_module_init((unsigned long)site_addr, mod)) ||
+		    (!mod && init_section_contains(site_addr, 1)))
+			static_call_set_init(site);
+
+		key = static_call_key(site);
+		if (key != prev_key) {
+			prev_key = key;
+
+			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+			if (!site_mod)
+				return -ENOMEM;
+
+			site_mod->mod = mod;
+			site_mod->sites = site;
+			site_mod->next = key->next;
+			key->next = site_mod;
+		}
+
+		arch_static_call_transform(site_addr, NULL, key->func);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_MODULES
+
+static int static_call_add_module(struct module *mod)
+{
+	return __static_call_init(mod, mod->static_call_sites,
+				  mod->static_call_sites + mod->num_static_call_sites);
+}
+
+static void static_call_del_module(struct module *mod)
+{
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = mod->static_call_sites +
+					mod->num_static_call_sites;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod, **prev;
+	struct static_call_site *site;
+
+	for (site = start; site < stop; site++) {
+		key = static_call_key(site);
+		if (key == prev_key)
+			continue;
+
+		prev_key = key;
+
+		for (prev = &key->next, site_mod = key->next;
+		     site_mod && site_mod->mod != mod;
+		     prev = &site_mod->next, site_mod = site_mod->next)
+			;
+
+		if (!site_mod)
+			continue;
+
+		*prev = site_mod->next;
+		kfree(site_mod);
+	}
+}
+
+static int static_call_module_notify(struct notifier_block *nb,
+				     unsigned long val, void *data)
+{
+	struct module *mod = data;
+	int ret = 0;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	switch (val) {
+	case MODULE_STATE_COMING:
+		ret = static_call_add_module(mod);
+		if (ret) {
+			WARN(1, "Failed to allocate memory for static calls");
+			static_call_del_module(mod);
+		}
+		break;
+	case MODULE_STATE_GOING:
+		static_call_del_module(mod);
+		break;
+	}
+
+	static_call_unlock();
+	cpus_read_unlock();
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block static_call_module_nb = {
+	.notifier_call = static_call_module_notify,
+};
+
+#endif /* CONFIG_MODULES */
+
+static void __init static_call_init(void)
+{
+	int ret;
+
+	if (static_call_initialized)
+		return;
+
+	cpus_read_lock();
+	static_call_lock();
+	ret = __static_call_init(NULL, __start_static_call_sites,
+				 __stop_static_call_sites);
+	static_call_unlock();
+	cpus_read_unlock();
+
+	if (ret) {
+		pr_err("Failed to allocate memory for static_call!\n");
+		BUG();
+	}
+
+	static_call_initialized = true;
+
+#ifdef CONFIG_MODULES
+	register_module_notifier(&static_call_module_nb);
+#endif
+}
+early_initcall(static_call_init);


