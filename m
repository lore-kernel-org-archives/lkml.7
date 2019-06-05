Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F30C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E8020870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SLtS7Ah2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfFENYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:24:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfFENXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rsNrTIABkLRMEzMMSZMXSpmmsRd5mUIHqFf2DjcZdgI=; b=SLtS7Ah2uggsxJB6P/hDRB1vyp
        2zEraMFbT3UhVXC0LMT6ygAg91gL99yWIWo7cHaXhLKntC5ZTFTH2pOuYmM0V1i0bTs97PuX+gbrp
        otS5WhldtOfOIn5GMsCqlYM0yMWXZ2DgihPchUDfPvywxzvh5eFp22YPQkyPRxbMcfbvCUJX4q4d8
        YcjIaMbQtKU+6AUNX1csU3nY4K/DLhUJx92H2juRf7rRqxZO+SASinjKHhVk6dW0THd4HvGwDcfFP
        VvLPBQAUZ5rYjCnXkxoU0fANo4uCDWbQcdWy+GWO8zfDCSgbW5vmenGu1A5+aYLJ/XekYdF2QYGF0
        TvmSXo6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsK-0004qZ-Pu; Wed, 05 Jun 2019 13:22:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 977C320757B40; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131945.193241464@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:08:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 11/15] static_call: Add inline static call infrastructure
References: <20190605130753.327195108@infradead.org>
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

Cc: x86@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Julia Cartwright <julia@ni.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Edward Cree <ecree@solarflare.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/c70ea8c00b93dadcb97b9d83659cf204121372d6.1547073843.git.jpoimboe@redhat.com
---
 arch/Kconfig                      |    4 
 include/asm-generic/vmlinux.lds.h |    7 
 include/linux/module.h            |   10 +
 include/linux/static_call.h       |   63 +++++++
 include/linux/static_call_types.h |    9 +
 kernel/Makefile                   |    1 
 kernel/module.c                   |    5 
 kernel/static_call.c              |  316 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 414 insertions(+), 1 deletion(-)
 create mode 100644 kernel/static_call.c

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -930,6 +930,10 @@ config LOCK_EVENT_COUNTS
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
@@ -311,6 +311,12 @@
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
@@ -320,6 +326,7 @@
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
+	STATIC_CALL_DATA						\
 	__end_ro_after_init = .;
 #endif
 
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -21,6 +21,7 @@
 #include <linux/rbtree_latch.h>
 #include <linux/error-injection.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/static_call_types.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -472,6 +473,10 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	int num_static_call_sites;
+	struct static_call_site *static_call_sites;
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
@@ -728,6 +733,11 @@ static inline bool within_module(unsigne
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
@@ -47,6 +47,12 @@
  *    Each static_call() site calls into a trampoline associated with the key.
  *    The trampoline has a direct branch to the default function.  Updates to a
  *    key will modify the trampoline's branch destination.
+ *
+ *    If the arch has CONFIG_HAVE_STATIC_CALL_INLINE, then the call sites
+ *    themselves will be patched at runtime to call the functions directly,
+ *    rather than calling through the trampoline.  This requires objtool or a
+ *    compiler plugin to detect all the static_call() sites and annotate them
+ *    in the .static_call_sites section.
  */
 
 #include <linux/types.h>
@@ -64,7 +70,62 @@ extern void arch_static_call_transform(v
 	extern typeof(func) STATIC_CALL_TRAMP(key)
 
 
-#if defined(CONFIG_HAVE_STATIC_CALL)
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
+struct static_call_key {
+	void *func, *tramp;
+	/*
+	 * List of modules (including vmlinux) and their call sites associated
+	 * with this key.
+	 */
+	struct list_head site_mods;
+};
+
+struct static_call_mod {
+	struct list_head list;
+	struct module *mod; /* for vmlinux, mod == NULL */
+	struct static_call_site *sites;
+};
+
+extern void __static_call_update(struct static_call_key *key, void *func);
+extern int static_call_mod_init(struct module *mod);
+
+#define DEFINE_STATIC_CALL(key, _func)					\
+	DECLARE_STATIC_CALL(key, _func);				\
+	struct static_call_key key = {					\
+		.func = _func,						\
+		.tramp = STATIC_CALL_TRAMP(key),			\
+		.site_mods = LIST_HEAD_INIT(key.site_mods),		\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(key, _func)
+
+/*
+ * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
+ * the symbol table so objtool can reference it when it generates the
+ * static_call_site structs.
+ */
+#define static_call(key, args...)					\
+({									\
+	__ADDRESSABLE(key);						\
+	STATIC_CALL_TRAMP(key)(args);					\
+})
+
+#define static_call_update(key, func)					\
+({									\
+	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
+	__static_call_update(&key, func);				\
+})
+
+#define EXPORT_STATIC_CALL(key)						\
+	EXPORT_SYMBOL(key);						\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(key))
+
+#define EXPORT_STATIC_CALL_GPL(key)					\
+	EXPORT_SYMBOL_GPL(key);						\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(key))
+
+
+#elif defined(CONFIG_HAVE_STATIC_CALL)
 
 struct static_call_key {
 	void *func, *tramp;
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -10,4 +10,13 @@
 #define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
 #define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
 
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
@@ -100,6 +100,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
+obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3117,6 +3117,11 @@ static int find_module_sections(struct m
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
@@ -0,0 +1,316 @@
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
+void __static_call_update(struct static_call_key *key, void *func)
+{
+	struct static_call_mod *site_mod;
+	struct static_call_site *site, *stop;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	if (key->func == func)
+		goto done;
+
+	key->func = func;
+
+	/*
+	 * If called before init, leave the call sites unpatched for now.
+	 * In the meantime they'll continue to call the temporary trampoline.
+	 */
+	if (!static_call_initialized)
+		goto done;
+
+	list_for_each_entry(site_mod, &key->site_mods, list) {
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
+			arch_static_call_transform(site_addr, key->tramp, func);
+		}
+	}
+
+done:
+	static_call_unlock();
+	cpus_read_unlock();
+}
+EXPORT_SYMBOL_GPL(__static_call_update);
+
+#ifdef CONFIG_MODULES
+
+static int static_call_add_module(struct module *mod)
+{
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = mod->static_call_sites +
+					mod->num_static_call_sites;
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
+		if (within_module_init((unsigned long)site_addr, mod))
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
+			list_add_tail(&site_mod->list, &key->site_mods);
+		}
+
+		arch_static_call_transform(site_addr, key->tramp, key->func);
+	}
+
+	return 0;
+}
+
+static void static_call_del_module(struct module *mod)
+{
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = mod->static_call_sites +
+					mod->num_static_call_sites;
+	struct static_call_site *site;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod;
+
+	for (site = start; site < stop; site++) {
+		key = static_call_key(site);
+		if (key == prev_key)
+			continue;
+		prev_key = key;
+
+		list_for_each_entry(site_mod, &key->site_mods, list) {
+			if (site_mod->mod == mod) {
+				list_del(&site_mod->list);
+				kfree(site_mod);
+				break;
+			}
+		}
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
+		module_disable_ro(mod);
+		ret = static_call_add_module(mod);
+		module_enable_ro(mod, false);
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
+	struct static_call_site *start = __start_static_call_sites;
+	struct static_call_site *stop  = __stop_static_call_sites;
+	struct static_call_site *site;
+
+	if (start == stop) {
+		pr_warn("WARNING: empty static call table\n");
+		return;
+	}
+
+	cpus_read_lock();
+	static_call_lock();
+
+	static_call_sort_entries(start, stop);
+
+	for (site = start; site < stop; site++) {
+		struct static_call_key *key = static_call_key(site);
+		void *site_addr = static_call_addr(site);
+
+		if (init_section_contains(site_addr, 1))
+			static_call_set_init(site);
+
+		if (list_empty(&key->site_mods)) {
+			struct static_call_mod *site_mod;
+
+			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+			if (!site_mod) {
+				WARN(1, "Failed to allocate memory for static calls");
+				goto done;
+			}
+
+			site_mod->sites = site;
+			list_add_tail(&site_mod->list, &key->site_mods);
+		}
+
+		arch_static_call_transform(site_addr, key->tramp, key->func);
+	}
+
+	static_call_initialized = true;
+
+done:
+	static_call_unlock();
+	cpus_read_unlock();
+
+#ifdef CONFIG_MODULES
+	if (static_call_initialized)
+		register_module_notifier(&static_call_module_nb);
+#endif
+}
+early_initcall(static_call_init);


