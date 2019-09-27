Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D966C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A589207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="B0R09e0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfI0JhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:37:04 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:33058 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfI0JhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:37:02 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x8R9a5ue001372;
        Fri, 27 Sep 2019 18:36:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x8R9a5ue001372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569576970;
        bh=rsB4h06qUtfwfDPTJVMKf592jd7/Pnx6aEXTAIEd2KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0R09e0lhFhBsdHnZKZbSPkPCeaxl+CutXvTjvjYBVKQU6KfUokdgT6QnYPVYx9wb
         xAd/Fv3g/mfSwGtaTAxLBxI0MBNqFfbWzXBvBHZDBuDAX7qag5oUXZFIPClKjPjlxp
         ly8cVPCH0Cp5U086RNQcP6jOioiNfOR4p99a8FEL2hN3iy5qKWy0Zgbyim33YVDDrQ
         /qGdifZtVgss0BFFcDYhsC2Blr+ZrYDH7zXPihfT1eeOpJZSHsKxTVwgG8wtRfAHoS
         Ij28vs2WB3r/nyt+Fisu8vTIOE6fD1AMQ4wsotlJs1AhLopuFrNqG8FbluLbYQWEJ+
         uT96h2QAFsYNg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] module: avoid code duplication in include/linux/export.h
Date:   Fri, 27 Sep 2019 18:36:00 +0900
Message-Id: <20190927093603.9140-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927093603.9140-1-yamada.masahiro@socionext.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/export.h has lots of code duplication between
EXPORT_SYMBOL and EXPORT_SYMBOL_NS.

To improve the maintainability and readability, unify the
implementation.

When the symbol has no namespace, pass the empty string "" to
the 'ns' parameter.

The drawback of this change is, it grows the code size.
When the symbol has no namespace, sym->namespace was previously
NULL, but it is now am empty string "". So, it increases 1 byte
for every no namespace EXPORT_SYMBOL.

A typical kernel configuration has 10K exported symbols, so it
increases 10KB in rough estimation.

I did not come up with a good idea to refactor it without increasing
the code size.

I am not sure how big a deal it is, but at least include/linux/export.h
looks nicer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/export.h | 100 +++++++++++++----------------------------
 kernel/module.c        |   2 +-
 2 files changed, 33 insertions(+), 69 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 621158ecd2e2..55245a405a2f 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -48,45 +48,28 @@ extern struct module __this_module;
  * absolute relocations that require runtime processing on relocatable
  * kernels.
  */
-#define __KSYMTAB_ENTRY_NS(sym, sec, ns)				\
+#define __KSYMTAB_ENTRY(sym, sec, ns)					\
 	__ADDRESSABLE(sym)						\
 	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
 	    "	.balign	4					\n"	\
-	    "__ksymtab_" #ns NS_SEPARATOR #sym ":		\n"	\
+	    "__ksymtab_" ns NS_SEPARATOR #sym ":		\n"	\
 	    "	.long	" #sym "- .				\n"	\
 	    "	.long	__kstrtab_" #sym "- .			\n"	\
 	    "	.long	__kstrtabns_" #sym "- .			\n"	\
 	    "	.previous					\n")
 
-#define __KSYMTAB_ENTRY(sym, sec)					\
-	__ADDRESSABLE(sym)						\
-	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.balign 4					\n"	\
-	    "__ksymtab_" #sym ":				\n"	\
-	    "	.long	" #sym "- .				\n"	\
-	    "	.long	__kstrtab_" #sym "- .			\n"	\
-	    "	.long	0					\n"	\
-	    "	.previous					\n")
-
 struct kernel_symbol {
 	int value_offset;
 	int name_offset;
 	int namespace_offset;
 };
 #else
-#define __KSYMTAB_ENTRY_NS(sym, sec, ns)				\
-	static const struct kernel_symbol __ksymtab_##sym##__##ns	\
-	asm("__ksymtab_" #ns NS_SEPARATOR #sym)				\
-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-	__aligned(sizeof(void *))					\
-	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
-
-#define __KSYMTAB_ENTRY(sym, sec)					\
+#define __KSYMTAB_ENTRY(sym, sec, ns)					\
 	static const struct kernel_symbol __ksymtab_##sym		\
-	asm("__ksymtab_" #sym)						\
+	asm("__ksymtab_" ns NS_SEPARATOR #sym)				\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
 	__aligned(sizeof(void *))					\
-	= { (unsigned long)&sym, __kstrtab_##sym, NULL }
+	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
 
 struct kernel_symbol {
 	unsigned long value;
@@ -97,29 +80,21 @@ struct kernel_symbol {
 
 #ifdef __GENKSYMS__
 
-#define ___EXPORT_SYMBOL(sym,sec)	__GENKSYMS_EXPORT_SYMBOL(sym)
-#define ___EXPORT_SYMBOL_NS(sym,sec,ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
+#define ___EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
 #else
 
-#define ___export_symbol_common(sym, sec)				\
+/* For every exported symbol, place a struct in the __ksymtab section */
+#define ___EXPORT_SYMBOL(sym, sec, ns)				\
 	extern typeof(sym) sym;						\
 	__CRC_SYMBOL(sym, sec);						\
 	static const char __kstrtab_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
-	= #sym								\
-
-/* For every exported symbol, place a struct in the __ksymtab section */
-#define ___EXPORT_SYMBOL_NS(sym, sec, ns)				\
-	___export_symbol_common(sym, sec);				\
+	= #sym;								\
 	static const char __kstrtabns_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
-	= #ns;								\
-	__KSYMTAB_ENTRY_NS(sym, sec, ns)
-
-#define ___EXPORT_SYMBOL(sym, sec)					\
-	___export_symbol_common(sym, sec);				\
-	__KSYMTAB_ENTRY(sym, sec)
+	= ns;								\
+	__KSYMTAB_ENTRY(sym, sec, ns)
 
 #endif
 
@@ -130,8 +105,7 @@ struct kernel_symbol {
  * be reused in other execution contexts such as the UEFI stub or the
  * decompressor.
  */
-#define __EXPORT_SYMBOL_NS(sym, sec, ns)
-#define __EXPORT_SYMBOL(sym, sec)
+#define __EXPORT_SYMBOL(sym, sec, ns)
 
 #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
 
@@ -147,48 +121,38 @@ struct kernel_symbol {
 #define __ksym_marker(sym)	\
 	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
 
-#define __EXPORT_SYMBOL(sym, sec)				\
+#define __EXPORT_SYMBOL(sym, sec, ns)				\
 	__ksym_marker(sym);					\
-	__cond_export_sym(sym, sec, __is_defined(__KSYM_##sym))
-#define __cond_export_sym(sym, sec, conf)			\
-	___cond_export_sym(sym, sec, conf)
-#define ___cond_export_sym(sym, sec, enabled)			\
-	__cond_export_sym_##enabled(sym, sec)
-#define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
-#define __cond_export_sym_0(sym, sec) /* nothing */
-
-#define __EXPORT_SYMBOL_NS(sym, sec, ns)				\
-	__ksym_marker(sym);						\
-	__cond_export_ns_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
-#define __cond_export_ns_sym(sym, sec, ns, conf)			\
-	___cond_export_ns_sym(sym, sec, ns, conf)
-#define ___cond_export_ns_sym(sym, sec, ns, enabled)			\
-	__cond_export_ns_sym_##enabled(sym, sec, ns)
-#define __cond_export_ns_sym_1(sym, sec, ns) ___EXPORT_SYMBOL_NS(sym, sec, ns)
-#define __cond_export_ns_sym_0(sym, sec, ns) /* nothing */
+	__cond_export_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
+#define __cond_export_sym(sym, sec, ns, conf)			\
+	___cond_export_sym(sym, sec, ns, conf)
+#define ___cond_export_sym(sym, sec, ns, enabled)		\
+	__cond_export_sym_##enabled(sym, sec, ns)
+#define __cond_export_sym_1(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
+#define __cond_export_sym_0(sym, sec, ns) /* nothing */
 
 #else
 
-#define __EXPORT_SYMBOL_NS(sym,sec,ns)	___EXPORT_SYMBOL_NS(sym,sec,ns)
-#define __EXPORT_SYMBOL(sym,sec)	___EXPORT_SYMBOL(sym,sec)
+#define __EXPORT_SYMBOL(sym, sec, ns)	___EXPORT_SYMBOL(sym, sec, ns)
 
 #endif /* CONFIG_MODULES */
 
 #ifdef DEFAULT_SYMBOL_NAMESPACE
-#undef __EXPORT_SYMBOL
-#define __EXPORT_SYMBOL(sym, sec)				\
-	__EXPORT_SYMBOL_NS(sym, sec, DEFAULT_SYMBOL_NAMESPACE)
+#include <linux/stringify.h>
+#define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, __stringify(DEFAULT_SYMBOL_NAMESPACE))
+#else
+#define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, "")
 #endif
 
-#define EXPORT_SYMBOL(sym)		__EXPORT_SYMBOL(sym, "")
-#define EXPORT_SYMBOL_GPL(sym)		__EXPORT_SYMBOL(sym, "_gpl")
-#define EXPORT_SYMBOL_GPL_FUTURE(sym)	__EXPORT_SYMBOL(sym, "_gpl_future")
-#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL_NS(sym, "", ns)
-#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL_NS(sym, "_gpl", ns)
+#define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym, "")
+#define EXPORT_SYMBOL_GPL(sym)		_EXPORT_SYMBOL(sym, "_gpl")
+#define EXPORT_SYMBOL_GPL_FUTURE(sym)	_EXPORT_SYMBOL(sym, "_gpl_future")
+#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", #ns)
+#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", #ns)
 
 #ifdef CONFIG_UNUSED_SYMBOLS
-#define EXPORT_UNUSED_SYMBOL(sym)	__EXPORT_SYMBOL(sym, "_unused")
-#define EXPORT_UNUSED_SYMBOL_GPL(sym)	__EXPORT_SYMBOL(sym, "_unused_gpl")
+#define EXPORT_UNUSED_SYMBOL(sym)	_EXPORT_SYMBOL(sym, "_unused")
+#define EXPORT_UNUSED_SYMBOL_GPL(sym)	_EXPORT_SYMBOL(sym, "_unused_gpl")
 #else
 #define EXPORT_UNUSED_SYMBOL(sym)
 #define EXPORT_UNUSED_SYMBOL_GPL(sym)
diff --git a/kernel/module.c b/kernel/module.c
index 32873bcce738..73f69ff86db5 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1399,7 +1399,7 @@ static int verify_namespace_is_imported(const struct load_info *info,
 	char *imported_namespace;
 
 	namespace = kernel_symbol_namespace(sym);
-	if (namespace) {
+	if (namespace && namespace[0]) {
 		imported_namespace = get_modinfo(info, "import_ns");
 		while (imported_namespace) {
 			if (strcmp(namespace, imported_namespace) == 0)
-- 
2.17.1

