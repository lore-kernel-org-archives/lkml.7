Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09265C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC073205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575636092;
	bh=aqLQypulfXGCmFpkmbOvyZNzsxFpCZGWdHmNsW87B5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c710ntpg+C7MdnQmtXZbKhcHdSJgkaLJab1PaR3E3AIOQaRvxy8+WhSsFOiWGow/B
	 h/52y4B2CqdMTXH+tycZOX0uu8W9XB8SrzS8EZiUGG9mPDBemW79TklYi45e65kmyn
	 zhW1NJZ7KecpDF4e+hDgODiclwCX+juSpcELSSI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLFMlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:41:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLFMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:41:21 -0500
Received: from linux-8ccs.suse.de (x2f7fd22.dyn.telefonica.de [2.247.253.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2F8205F4;
        Fri,  6 Dec 2019 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575636080;
        bh=aqLQypulfXGCmFpkmbOvyZNzsxFpCZGWdHmNsW87B5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCT7oLqt3YpwEiMAXcSSiihpR9dsPGAXvYTuybXr7XXDnO0+HjDjfQAVBq/8YESjb
         rTZB2hWN0XJthD/RtLZaiPbcuJCvHu7Tlqg+eg6gTIPjeCYNdN/BTzf1UzkDHJemfk
         7UCyA63kmXKnJK25qqRk1WIKcqS1Po+subNJiCR4=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v3] export.h: reduce __ksymtab_strings string duplication by using "MS" section flags
Date:   Fri,  6 Dec 2019 13:41:02 +0100
Message-Id: <20191206124102.12334-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191125154217.18640-1-jeyu@kernel.org>
References: <20191125154217.18640-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c3a6cf19e695 ("export: avoid code duplication in
include/linux/export.h") refactors export.h quite nicely, but introduces
a slight increase in memory usage due to using the empty string ""
instead of NULL to indicate that an exported symbol has no namespace. As
mentioned in that commit, this meant an increase of 1 byte per exported
symbol without a namespace. For example, if a kernel configuration has
about 10k exported symbols, this would mean that the size of
__ksymtab_strings would increase by roughly 10kB.

We can alleviate this situation by utilizing the SHF_MERGE and
SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
that the data in the section are null-terminated strings that can be
merged to eliminate duplication. More specifically, from the binutils
documentation - "for sections with both M and S, a string which is a
suffix of a larger string is considered a duplicate. Thus "def" will be
merged with "abcdef"; A reference to the first "def" will be changed to
a reference to "abcdef"+3". Thus, all the empty strings would be merged
as well as any strings that can be merged according to the cited method
above. For example, "memset" and "__memset" would be merged to just
"__memset" in __ksymtab_strings.

As of v5.4-rc5, the following statistics were gathered with x86
defconfig with approximately 10.7k exported symbols.

Size of __ksymtab_strings in vmlinux:
-------------------------------------
v5.4-rc5: 213834 bytes
v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
v5.4-rc5 with this patch: 205759 bytes

So, we already see memory savings of ~8kB compared to vanilla -rc5 and
savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.

Unfortunately, as of this writing, strings will not get deduplicated for
kernel modules, as ld does not do the deduplication for
SHF_MERGE|SHF_STRINGS sections for relocatable files (ld -r), which
kernel modules are. A patch for ld is currently being worked on to
hopefully allow for string deduplication in relocatable files in the
future.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
v3: 
  - remove __KSTRTAB_ENTRY macros in favor of just putting the asm directly
    in ___EXPORT_SYMBOL
  - Document more clearly what the ___EXPORT_SYMBOL macro does

 include/asm-generic/export.h |  8 +++++---
 include/linux/export.h       | 27 ++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index fa577978fbbd..23bc98e97a66 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -26,9 +26,11 @@
 .endm
 
 /*
- * note on .section use: @progbits vs %progbits nastiness doesn't matter,
- * since we immediately emit into those sections anyway.
+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
+ * former apparently works on all arches according to the binutils source.
  */
+
 .macro ___EXPORT_SYMBOL name,val,sec
 #ifdef CONFIG_MODULES
 	.globl __ksymtab_\name
@@ -37,7 +39,7 @@
 __ksymtab_\name:
 	__put \val, __kstrtab_\name
 	.previous
-	.section __ksymtab_strings,"a"
+	.section __ksymtab_strings,"aMS",%progbits,1
 __kstrtab_\name:
 	.asciz "\name"
 	.previous
diff --git a/include/linux/export.h b/include/linux/export.h
index 201262793369..18dcdcd118e7 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -81,16 +81,29 @@ struct kernel_symbol {
 
 #else
 
-/* For every exported symbol, place a struct in the __ksymtab section */
+/*
+ * For every exported symbol, do the following:
+ *
+ * - If applicable, place an entry in the __kcrctab section.
+ * - Put the name of the symbol and namespace (empty string "" for none) in
+ *   __ksymtab_strings.
+ * - Place an entry in the __ksymtab section.
+ *
+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
+ * former apparently works on all arches according to the binutils source.
+ */
 #define ___EXPORT_SYMBOL(sym, sec, ns)					\
 	extern typeof(sym) sym;						\
+	extern const char __kstrtab_##sym[];				\
+	extern const char __kstrtabns_##sym[];				\
 	__CRC_SYMBOL(sym, sec);						\
-	static const char __kstrtab_##sym[]				\
-	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
-	= #sym;								\
-	static const char __kstrtabns_##sym[]				\
-	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
-	= ns;								\
+	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1\n"	\
+	    "__kstrtab_" #sym ":				\n"	\
+	    "	.asciz 	\"" #sym "\"				\n"	\
+	    "__kstrtabns_" #sym ":				\n"	\
+	    "	.asciz 	\"" ns "\"				\n"	\
+	    "	.previous					\n");	\
 	__KSYMTAB_ENTRY(sym, sec)
 
 #endif
-- 
2.16.4

