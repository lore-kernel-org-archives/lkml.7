Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3709C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E388206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXRJ0YO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392055AbfIFKc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:32:56 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33742 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392026AbfIFKcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:32:52 -0400
Received: by mail-yw1-f73.google.com with SMTP id b2so4236782ywf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6KFIwWWApjCQfX4bs8S0gCxREVnzqCf121iaZRShrCw=;
        b=kXRJ0YO2AVoL/eO6tVZ31PmcQrpocEIsGGksoXq91D+DgrwMl9WG9U3oZyRsIdnGq8
         aircvFNC/xnaZV7N1bJCYERWM0edXRcc58A+mQCxW/jHcPQbdMmzwWg/wwKtA0djFZyH
         yshbI63FoSr/FPwZLILrKTsMJy3EX5rmNmMMGxi8xAWEI0dP4FnEAg3uhN8pcJy7GC2L
         OZJ+N4Q7AxjOdftSP7xtwuqzBwW8qUaEpeCZWQ//Q4J6FfsUmyn3+yn0wRNQkfp1pxFY
         aR8rus9h1g2mK6s1IeJ+dEtMXhYh2h/I821IMxJb/I/KFFzKdnfpyLXA5neuZtM2MPIa
         iz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6KFIwWWApjCQfX4bs8S0gCxREVnzqCf121iaZRShrCw=;
        b=nwceFCwWXE4E/jZg9pP8JJeNr6J+SOGKPCh/7R/6ORGXWlRBpeQJX8+vp3WFCtqWqd
         gAGMfmqRveVHNQLvnxn8WYwouIQdmmUvYfgllEIWqgj95+iCV+EhdpcyWS9rYR5ws4CN
         /PSu9YSi7QxfXxpdzKok+owM2IuS7/GgNgLt/ji0iK6WJen8RIqxRnKa1V7sJ3D+1Ls3
         K61MeBG650912uau8ln6mavB0QYmyXoCfEMii4txiuZTIVI5N9mYSn8PeQfSES4EE/LS
         cYv0TQdC98zzjac43gzN0z8Utp11lMzOpiDIqdfv16AM59n/g6bSi+HnwCDBHAxKt9z+
         aD1w==
X-Gm-Message-State: APjAAAWPtr1r0JGAhvT540MyYV2Uqm9wvrNnRkWw5OtZJAMPNPiGqqVN
        9MEVpPQi1c427ZuzgCmgdTOxBqJtbb2Kwiyv9g6sCD5cCQ12bt+c18/x30e2UK3TDn/gRrGmGBm
        q4GQCbw2O+q3Uo1nEsLo4D++yS1QXvSC5jbS682Z8O7eLYnsCWhir40ERAhJOV8/SLWMiOsjR5Y
        0=
X-Google-Smtp-Source: APXvYqyx8R9IrUKYa1igtaMIAEyLhj4ox4XQXbyMVEh/4JeWnkBKFhdjGXm/PdZiS/pBKdxAvZU9GILcRF5oyg==
X-Received: by 2002:a81:794c:: with SMTP id u73mr1553918ywc.230.1567765971037;
 Fri, 06 Sep 2019 03:32:51 -0700 (PDT)
Date:   Fri,  6 Sep 2019 11:32:27 +0100
In-Reply-To: <20190906103235.197072-1-maennich@google.com>
Message-Id: <20190906103235.197072-4-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190906103235.197072-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v5 03/11] module: add support for symbol namespaces.
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        joel@joelfernandes.org, lucas.de.marchi@gmail.com,
        maco@android.com, sspatil@google.com, will@kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EXPORT_SYMBOL_NS() and EXPORT_SYMBOL_NS_GPL() macros can be used to
export a symbol to a specific namespace.  There are no _GPL_FUTURE and
_UNUSED variants because these are currently unused, and I'm not sure
they are necessary.

I didn't add EXPORT_SYMBOL_NS() for ASM exports; this patch sets the
namespace of ASM exports to NULL by default. In case of relative
references, it will be relocatable to NULL. If there's a need, this
should be pretty easy to add.

A module that wants to use a symbol exported to a namespace must add a
MODULE_IMPORT_NS() statement to their module code; otherwise, modpost
will complain when building the module, and the kernel module loader
will emit an error and fail when loading the module.

MODULE_IMPORT_NS() adds a modinfo tag 'import_ns' to the module. That
tag can be observed by the modinfo command, modpost and kernel/module.c
at the time of loading the module.

The ELF symbols are renamed to include the namespace with an asm label;
for example, symbol 'usb_stor_suspend' in namespace USB_STORAGE becomes
'usb_stor_suspend.USB_STORAGE'.  This allows modpost to do namespace
checking, without having to go through all the effort of parsing ELF and
relocation records just to get to the struct kernel_symbols.

On x86_64 I saw no difference in binary size (compression), but at
runtime this will require a word of memory per export to hold the
namespace. An alternative could be to store namespaced symbols in their
own section and use a separate 'struct namespaced_kernel_symbol' for
that section, at the cost of making the module loader more complex.

Co-developed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 include/asm-generic/export.h |  6 +--
 include/linux/export.h       | 91 +++++++++++++++++++++++++++++-------
 include/linux/module.h       |  2 +
 kernel/module.c              | 43 +++++++++++++++++
 4 files changed, 123 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 63f54907317b..e2b5d0f569d3 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -17,11 +17,11 @@
 
 .macro __put, val, name
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-	.long	\val - ., \name - .
+	.long	\val - ., \name - ., 0 - .
 #elif defined(CONFIG_64BIT)
-	.quad	\val, \name
+	.quad	\val, \name, 0
 #else
-	.long	\val, \name
+	.long	\val, \name, 0
 #endif
 .endm
 
diff --git a/include/linux/export.h b/include/linux/export.h
index 28a4d2150689..d59461e71478 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -20,6 +20,8 @@ extern struct module __this_module;
 
 #ifdef CONFIG_MODULES
 
+#define NS_SEPARATOR "."
+
 #if defined(__KERNEL__) && !defined(__GENKSYMS__)
 #ifdef CONFIG_MODVERSIONS
 /* Mark the CRC weak since genksyms apparently decides not to
@@ -29,13 +31,13 @@ extern struct module __this_module;
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
 	    "	.weak	__crc_" #sym "				\n"	\
 	    "	.long	__crc_" #sym " - .			\n"	\
-	    "	.previous					\n");
+	    "	.previous					\n")
 #else
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
 	    "	.weak	__crc_" #sym "				\n"	\
 	    "	.long	__crc_" #sym "				\n"	\
-	    "	.previous					\n");
+	    "	.previous					\n")
 #endif
 #else
 #define __CRC_SYMBOL(sym, sec)
@@ -49,6 +51,16 @@ extern struct module __this_module;
  * absolute relocations that require runtime processing on relocatable
  * kernels.
  */
+#define __KSYMTAB_ENTRY_NS(sym, sec, ns)				\
+	__ADDRESSABLE(sym)						\
+	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.balign	4					\n"	\
+	    "__ksymtab_" #sym NS_SEPARATOR #ns ":		\n"	\
+	    "	.long	" #sym "- .				\n"	\
+	    "	.long	__kstrtab_" #sym "- .			\n"	\
+	    "	.long	__kstrtab_ns_" #sym "- .		\n"	\
+	    "	.previous					\n")
+
 #define __KSYMTAB_ENTRY(sym, sec)					\
 	__ADDRESSABLE(sym)						\
 	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
@@ -56,32 +68,53 @@ extern struct module __this_module;
 	    "__ksymtab_" #sym ":				\n"	\
 	    "	.long	" #sym "- .				\n"	\
 	    "	.long	__kstrtab_" #sym "- .			\n"	\
+	    "	.long	0 - .					\n"	\
 	    "	.previous					\n")
 
 struct kernel_symbol {
 	int value_offset;
 	int name_offset;
+	int namespace_offset;
 };
 #else
+#define __KSYMTAB_ENTRY_NS(sym, sec, ns)				\
+	static const struct kernel_symbol __ksymtab_##sym##__##ns	\
+	asm("__ksymtab_" #sym NS_SEPARATOR #ns)				\
+	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
+	__aligned(sizeof(void *))					\
+	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtab_ns_##sym }
+
 #define __KSYMTAB_ENTRY(sym, sec)					\
 	static const struct kernel_symbol __ksymtab_##sym		\
+	asm("__ksymtab_" #sym)						\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
 	__aligned(sizeof(void *))					\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+	= { (unsigned long)&sym, __kstrtab_##sym, NULL }
 
 struct kernel_symbol {
 	unsigned long value;
 	const char *name;
+	const char *namespace;
 };
 #endif
 
-/* For every exported symbol, place a struct in the __ksymtab section */
-#define ___EXPORT_SYMBOL(sym, sec)					\
+#define ___export_symbol_common(sym, sec)				\
 	extern typeof(sym) sym;						\
-	__CRC_SYMBOL(sym, sec)						\
+	__CRC_SYMBOL(sym, sec);						\
 	static const char __kstrtab_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
-	= #sym;								\
+	= #sym								\
+
+/* For every exported symbol, place a struct in the __ksymtab section */
+#define ___EXPORT_SYMBOL_NS(sym, sec, ns)				\
+	___export_symbol_common(sym, sec);				\
+	static const char __kstrtab_ns_##sym[]				\
+	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
+	= #ns;								\
+	__KSYMTAB_ENTRY_NS(sym, sec, ns)
+
+#define ___EXPORT_SYMBOL(sym, sec)					\
+	___export_symbol_common(sym, sec);				\
 	__KSYMTAB_ENTRY(sym, sec)
 
 #if defined(__DISABLE_EXPORTS)
@@ -91,6 +124,7 @@ struct kernel_symbol {
  * be reused in other execution contexts such as the UEFI stub or the
  * decompressor.
  */
+#define __EXPORT_SYMBOL_NS(sym, sec, ns)
 #define __EXPORT_SYMBOL(sym, sec)
 
 #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
@@ -117,18 +151,26 @@ struct kernel_symbol {
 #define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
 #define __cond_export_sym_0(sym, sec) /* nothing */
 
+#define __EXPORT_SYMBOL_NS(sym, sec, ns)				\
+	__ksym_marker(sym);						\
+	__cond_export_ns_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
+#define __cond_export_ns_sym(sym, sec, ns, conf)			\
+	___cond_export_ns_sym(sym, sec, ns, conf)
+#define ___cond_export_ns_sym(sym, sec, ns, enabled)			\
+	__cond_export_ns_sym_##enabled(sym, sec, ns)
+#define __cond_export_ns_sym_1(sym, sec, ns) ___EXPORT_SYMBOL_NS(sym, sec, ns)
+#define __cond_export_ns_sym_0(sym, sec, ns) /* nothing */
+
 #else
+#define __EXPORT_SYMBOL_NS ___EXPORT_SYMBOL_NS
 #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
 #endif
 
-#define EXPORT_SYMBOL(sym)					\
-	__EXPORT_SYMBOL(sym, "")
-
-#define EXPORT_SYMBOL_GPL(sym)					\
-	__EXPORT_SYMBOL(sym, "_gpl")
-
-#define EXPORT_SYMBOL_GPL_FUTURE(sym)				\
-	__EXPORT_SYMBOL(sym, "_gpl_future")
+#define EXPORT_SYMBOL(sym) __EXPORT_SYMBOL(sym, "")
+#define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_gpl")
+#define EXPORT_SYMBOL_GPL_FUTURE(sym) __EXPORT_SYMBOL(sym, "_gpl_future")
+#define EXPORT_SYMBOL_NS(sym, ns) __EXPORT_SYMBOL_NS(sym, "", ns)
+#define EXPORT_SYMBOL_NS_GPL(sym, ns) __EXPORT_SYMBOL_NS(sym, "_gpl", ns)
 
 #ifdef CONFIG_UNUSED_SYMBOLS
 #define EXPORT_UNUSED_SYMBOL(sym) __EXPORT_SYMBOL(sym, "_unused")
@@ -138,11 +180,28 @@ struct kernel_symbol {
 #define EXPORT_UNUSED_SYMBOL_GPL(sym)
 #endif
 
-#endif	/* __GENKSYMS__ */
+#endif	/* __KERNEL__ && !__GENKSYMS__ */
+
+#if defined(__GENKSYMS__)
+/*
+ * When we're running genksyms, ignore the namespace and make the _NS
+ * variants look like the normal ones. There are two reasons for this:
+ * 1) In the normal definition of EXPORT_SYMBOL_NS, the 'ns' macro
+ *    argument is itself not expanded because it's always tokenized or
+ *    concatenated; but when running genksyms, a blank definition of the
+ *    macro does allow the argument to be expanded; if a namespace
+ *    happens to collide with a #define, this can cause issues.
+ * 2) There's no need to modify genksyms to deal with the _NS variants
+ */
+#define EXPORT_SYMBOL_NS(sym, ns) EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL_NS_GPL(sym, ns) EXPORT_SYMBOL_GPL(sym)
+#endif
 
 #else /* !CONFIG_MODULES... */
 
 #define EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL_NS(sym, ns)
+#define EXPORT_SYMBOL_NS_GPL(sym, ns)
 #define EXPORT_SYMBOL_GPL(sym)
 #define EXPORT_SYMBOL_GPL_FUTURE(sym)
 #define EXPORT_UNUSED_SYMBOL(sym)
diff --git a/include/linux/module.h b/include/linux/module.h
index 1455812dd325..b3611e749f72 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -280,6 +280,8 @@ struct notifier_block;
 
 #ifdef CONFIG_MODULES
 
+#define MODULE_IMPORT_NS(ns) MODULE_INFO(import_ns, #ns)
+
 extern int modules_disabled; /* for sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
diff --git a/kernel/module.c b/kernel/module.c
index 3ee507c0a92f..6bb9b938f9c7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -544,6 +544,15 @@ static const char *kernel_symbol_name(const struct kernel_symbol *sym)
 #endif
 }
 
+static const char *kernel_symbol_namespace(const struct kernel_symbol *sym)
+{
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	return offset_to_ptr(&sym->namespace_offset);
+#else
+	return sym->namespace;
+#endif
+}
+
 static int cmp_name(const void *va, const void *vb)
 {
 	const char *a;
@@ -1379,6 +1388,34 @@ static inline int same_magic(const char *amagic, const char *bmagic,
 }
 #endif /* CONFIG_MODVERSIONS */
 
+static char *get_modinfo(const struct load_info *info, const char *tag);
+static char *get_next_modinfo(const struct load_info *info, const char *tag,
+			      char *prev);
+
+static int verify_namespace_is_imported(const struct load_info *info,
+					const struct kernel_symbol *sym,
+					struct module *mod)
+{
+	const char *namespace;
+	char *imported_namespace;
+
+	namespace = kernel_symbol_namespace(sym);
+	if (namespace) {
+		imported_namespace = get_modinfo(info, "import_ns");
+		while (imported_namespace) {
+			if (strcmp(namespace, imported_namespace) == 0)
+				return 0;
+			imported_namespace = get_next_modinfo(
+				info, "import_ns", imported_namespace);
+		}
+		pr_err("%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
+		       mod->name, kernel_symbol_name(sym), namespace);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+
 /* Resolve a symbol for this module.  I.e. if we find one, record usage. */
 static const struct kernel_symbol *resolve_symbol(struct module *mod,
 						  const struct load_info *info,
@@ -1407,6 +1444,12 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 		goto getname;
 	}
 
+	err = verify_namespace_is_imported(info, sym, mod);
+	if (err) {
+		sym = ERR_PTR(err);
+		goto getname;
+	}
+
 	err = ref_module(mod, owner);
 	if (err) {
 		sym = ERR_PTR(err);
-- 
2.23.0.187.g17f5b7556c-goog

