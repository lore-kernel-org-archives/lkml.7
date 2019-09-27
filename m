Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA71C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AAC207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NKUk7uGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfI0Jh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:37:26 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:33056 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfI0JhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:37:01 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x8R9a5ud001372;
        Fri, 27 Sep 2019 18:36:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x8R9a5ud001372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569576969;
        bh=Fynp0G6evPgfPqhsg7r4WZQkR9spuRzwJdxpkYdeONU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKUk7uGll+V8LdUDPB1GVeeJOolszILWQCZ7SBQwkVdpbGuFn/6kDpUjNB0/QnynN
         2qtuscgntP19CTgrkmvl5MSiiiCNBM8MTMvqvOQ4ZMK6qxLZECMooRQMg6/8GhwHCg
         4qU/g9rGsuM3KtYDnkAKAF8mdbt1DU2+OHsXQWxPZbNlhE1f7JA0E0NXhTwlDXPVww
         4avl6+5iYDzdjgiBkx4qQI4Jn3n3WKQrBxF1+7k8g8hxJW9+fKH4EYxiht2YQCla4r
         xGD/ItNo3FzzIpks94EAkkrKdxQaT80bh4XJSdYX5FJ+9Eyq/pDWRgWKZzoce+x0d1
         X55tIS908scnw==
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
Subject: [PATCH 3/7] module: rename __kstrtab_ns_* to __kstrtabns_* to avoid symbol conflict
Date:   Fri, 27 Sep 2019 18:35:59 +0900
Message-Id: <20190927093603.9140-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927093603.9140-1-yamada.masahiro@socionext.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module namespace produces __strtab_ns_<sym> symbols to store
namespace strings, but it does not guarantee the name uniqueness.
This is a potential problem because we have exported symbols staring
with "ns_".

For example, kernel/capability.c exports the following symbols:

  EXPORT_SYMBOL(ns_capable);
  EXPORT_SYMBOL(capable);

Assume a situation where those are converted as follows:

  EXPORT_SYMBOL_NS(ns_capable, some_namespace);
  EXPORT_SYMBOL_NS(capable, some_namespace);

The former expands to "__kstrtab_ns_capable" and "__kstrtab_ns_ns_capable",
and the latter to "__kstrtab_capable" and "__kstrtab_ns_capable".
Then, we have the duplication for "__kstrtab_ns_capable".

To ensure the uniqueness, rename "__kstrtab_ns_*" to "__kstrtabns_*".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/export.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 0695d4e847d9..621158ecd2e2 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -55,7 +55,7 @@ extern struct module __this_module;
 	    "__ksymtab_" #ns NS_SEPARATOR #sym ":		\n"	\
 	    "	.long	" #sym "- .				\n"	\
 	    "	.long	__kstrtab_" #sym "- .			\n"	\
-	    "	.long	__kstrtab_ns_" #sym "- .		\n"	\
+	    "	.long	__kstrtabns_" #sym "- .			\n"	\
 	    "	.previous					\n")
 
 #define __KSYMTAB_ENTRY(sym, sec)					\
@@ -79,7 +79,7 @@ struct kernel_symbol {
 	asm("__ksymtab_" #ns NS_SEPARATOR #sym)				\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
 	__aligned(sizeof(void *))					\
-	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtab_ns_##sym }
+	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
 
 #define __KSYMTAB_ENTRY(sym, sec)					\
 	static const struct kernel_symbol __ksymtab_##sym		\
@@ -112,7 +112,7 @@ struct kernel_symbol {
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define ___EXPORT_SYMBOL_NS(sym, sec, ns)				\
 	___export_symbol_common(sym, sec);				\
-	static const char __kstrtab_ns_##sym[]				\
+	static const char __kstrtabns_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
 	= #ns;								\
 	__KSYMTAB_ENTRY_NS(sym, sec, ns)
-- 
2.17.1

