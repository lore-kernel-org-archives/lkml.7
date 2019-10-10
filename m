Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1735C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716E2208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyB4NIF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfJJPQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:16:16 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:54940 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfJJPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:16:15 -0400
Received: by mail-wr1-f73.google.com with SMTP id z1so2877327wrw.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i3Erxj68tMcwkIZ2NUT8ZG/xvUxR9gGY2fME2mvG5JY=;
        b=tyB4NIF4cyHaIp1deXiILh3c/NzNlyLfId7Y01hj7cBrdXiAD5xlGQJutMNAGCtNmG
         ZKUSPPCStZWLOV/zrn9ZVfQ0dgRnycAO478qTG/1k2UWvgsEZWhqRUE1IWFVAwnLdUMr
         N/5Y1aBXECx5kPn+1WmAsLLyI8fXweizVUDikwqGEMRkPfDLOpCUyQv5GgqrPQBUQi2s
         MAxDgN89vvewQZl4gT7NCY39rc4pVbYCKMGlL1U4iX9rbcA4FP8tw7l01GYvjrCqShoc
         /STRfyXIDPQXEuI1ky55ZGGvrHCrNZVlQ4bPrfRsNptOT/sHAQAxJA5mUdJGineCrdTT
         Pw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i3Erxj68tMcwkIZ2NUT8ZG/xvUxR9gGY2fME2mvG5JY=;
        b=mxZZvZU+kxqT5hapLneDrIG+VEHgkZ1L5tUOOYCZiC8CIEREktyFKrKBmysipjwWYV
         Vjv2rGjc5ZYDmWeQ0wnGmRRifcoRt10cmB1faWqjwbE+GX+JBxxGzOjt/fTFhVSbkuSX
         g5PLZuqN+2YNKFQoF58mC8aSKljz6gH269PSZMmvXYRYB3v/zjqhx8RIMZfJt/LvdMpu
         q152xXvSGvgYCWjJ3bvdt5rMPjhM3/v6n11y8Sb4Gz7bQLbd/mbBjCsXo+1r2bVybTLo
         IoZYVmaT2mKSNQDC7UC1FU+9TB5RkHJtR660Ix2lOgO5aPQ5P3vgXOrhR4l+ucdVQQJo
         oFrQ==
X-Gm-Message-State: APjAAAX6kRP37ZnBK7rJU1azsOBBBenJ04PEmWo2khhbXH58M+9nnlUT
        mQCYsifgiCIYkIuzrjXqDmOb6lJPXU0haxK49IpckTDBOz/9Vve8N8OX6r2XFS0ogLMgtKwxUZt
        ntaklICnVXZaBILzL89gC/EA3PB8B1LydnSqmjkRAwxfsQKMUk7R7r4iRLLfGXyunslp6FKdSPt
        A=
X-Google-Smtp-Source: APXvYqzykiWp/pYZwS7FjqEfOT321sqVXUyjY6mctjsFEEZhtdsbXpRqa/2zu/NB+vr22KsSqa76pviTrglD3w==
X-Received: by 2002:a5d:4691:: with SMTP id u17mr8903588wrq.41.1570720571422;
 Thu, 10 Oct 2019 08:16:11 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:14:43 +0100
In-Reply-To: <20191010151443.7399-1-maennich@google.com>
Message-Id: <20191010151443.7399-5-maennich@google.com>
Mime-Version: 1.0
References: <20191010151443.7399-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 4/4] export: avoid code duplication in include/linux/export.h
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Shaun Ruffell <sruffell@sruffell.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the namespace value is not part of the __ksymtab entry name
anymore, we can simplify the implementation of EXPORT_SYMBOL*. By
allowing the empty string "" to represent 'no namespace', we can unify
the implementation and drop a lot redundant code.  That increases
readability and maintainability.

As Masahiro pointed out earlier,
"The drawback of this change is, it grows the code size. When the symbol
has no namespace, sym->namespace was previously NULL, but it is now am
empty string "". So, it increases 1 byte for every no namespace
EXPORT_SYMBOL. A typical kernel configuration has 10K exported symbols,
so it increases 10KB in rough estimation."

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 include/linux/export.h | 92 +++++++++++++-----------------------------
 kernel/module.c        |  2 +-
 2 files changed, 29 insertions(+), 65 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index f24b86d7dd4d..201262793369 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -46,7 +46,7 @@ extern struct module __this_module;
  * absolute relocations that require runtime processing on relocatable
  * kernels.
  */
-#define __KSYMTAB_ENTRY_NS(sym, sec)					\
+#define __KSYMTAB_ENTRY(sym, sec)					\
 	__ADDRESSABLE(sym)						\
 	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
 	    "	.balign	4					\n"	\
@@ -56,34 +56,17 @@ extern struct module __this_module;
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
-#define __KSYMTAB_ENTRY_NS(sym, sec)					\
-	static const struct kernel_symbol __ksymtab_##sym		\
-	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-	__aligned(sizeof(void *))					\
-	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
-
 #define __KSYMTAB_ENTRY(sym, sec)					\
 	static const struct kernel_symbol __ksymtab_##sym		\
-	asm("__ksymtab_" #sym)						\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
 	__aligned(sizeof(void *))					\
-	= { (unsigned long)&sym, __kstrtab_##sym, NULL }
+	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
 
 struct kernel_symbol {
 	unsigned long value;
@@ -94,28 +77,20 @@ struct kernel_symbol {
 
 #ifdef __GENKSYMS__
 
-#define ___EXPORT_SYMBOL(sym,sec)	__GENKSYMS_EXPORT_SYMBOL(sym)
-#define ___EXPORT_SYMBOL_NS(sym,sec,ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
+#define ___EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
 #else
 
-#define ___export_symbol_common(sym, sec)				\
+/* For every exported symbol, place a struct in the __ksymtab section */
+#define ___EXPORT_SYMBOL(sym, sec, ns)					\
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
-	__KSYMTAB_ENTRY_NS(sym, sec)
-
-#define ___EXPORT_SYMBOL(sym, sec)					\
-	___export_symbol_common(sym, sec);				\
+	= ns;								\
 	__KSYMTAB_ENTRY(sym, sec)
 
 #endif
@@ -127,8 +102,7 @@ struct kernel_symbol {
  * be reused in other execution contexts such as the UEFI stub or the
  * decompressor.
  */
-#define __EXPORT_SYMBOL_NS(sym, sec, ns)
-#define __EXPORT_SYMBOL(sym, sec)
+#define __EXPORT_SYMBOL(sym, sec, ns)
 
 #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
 
@@ -144,48 +118,38 @@ struct kernel_symbol {
 #define __ksym_marker(sym)	\
 	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
 
-#define __EXPORT_SYMBOL(sym, sec)				\
-	__ksym_marker(sym);					\
-	__cond_export_sym(sym, sec, __is_defined(__KSYM_##sym))
-#define __cond_export_sym(sym, sec, conf)			\
-	___cond_export_sym(sym, sec, conf)
-#define ___cond_export_sym(sym, sec, enabled)			\
-	__cond_export_sym_##enabled(sym, sec)
-#define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
-#define __cond_export_sym_0(sym, sec) /* nothing */
-
-#define __EXPORT_SYMBOL_NS(sym, sec, ns)				\
+#define __EXPORT_SYMBOL(sym, sec, ns)					\
 	__ksym_marker(sym);						\
-	__cond_export_ns_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
-#define __cond_export_ns_sym(sym, sec, ns, conf)			\
-	___cond_export_ns_sym(sym, sec, ns, conf)
-#define ___cond_export_ns_sym(sym, sec, ns, enabled)			\
-	__cond_export_ns_sym_##enabled(sym, sec, ns)
-#define __cond_export_ns_sym_1(sym, sec, ns) ___EXPORT_SYMBOL_NS(sym, sec, ns)
-#define __cond_export_ns_sym_0(sym, sec, ns) /* nothing */
+	__cond_export_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
+#define __cond_export_sym(sym, sec, ns, conf)				\
+	___cond_export_sym(sym, sec, ns, conf)
+#define ___cond_export_sym(sym, sec, ns, enabled)			\
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
index ff2d7359a418..26c13173da3d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1400,7 +1400,7 @@ static int verify_namespace_is_imported(const struct load_info *info,
 	char *imported_namespace;
 
 	namespace = kernel_symbol_namespace(sym);
-	if (namespace) {
+	if (namespace && namespace[0]) {
 		imported_namespace = get_modinfo(info, "import_ns");
 		while (imported_namespace) {
 			if (strcmp(namespace, imported_namespace) == 0)
-- 
2.23.0.581.g78d2f28ef7-goog

