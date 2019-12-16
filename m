Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F95C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0042075A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576489309;
	bh=9YOYN2iP58bI4J+bKGl8t0iCZQLFDD2RuDreTIo5bog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r35Gnopll8j4j3P1pyrZWILB3kCKqExXjyZl52CoYat49EjDmWtAbbf9raBmcJYYP
	 jMY5hYoRGMNV50OMWMs1pFLQiQX18V+o/oiNA0tmA8uzrOY0h+GRdCAqmPCIn/P2zw
	 0u2oJhyRboC06kuMcT1TJOza6EdRAJxSFpNEum+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLPJls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfLPJls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:41:48 -0500
Received: from linux-8ccs (ip-109-41-193-110.web.vodafone.de [109.41.193.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849F6206D7;
        Mon, 16 Dec 2019 09:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576489307;
        bh=9YOYN2iP58bI4J+bKGl8t0iCZQLFDD2RuDreTIo5bog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAqpZ546xIW01RnhuqKvuEqbLw2Ug/1+XwhSWu9y8jFwRsw/RAvvgcY7I7FQiiQub
         L3X3MawNtVNVtV8bIJmdVb2oMRkJPXUegIHBekL+SVN3j7OH8dJ1NnrsEqW+WMyn2K
         s0NJ6PvPF5r6EjMbOUcEARH6cmci1M2p9eDiH0Nk=
Date:   Mon, 16 Dec 2019 10:41:42 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] export.h: reduce __ksymtab_strings string duplication
 by using "MS" section flags
Message-ID: <20191216094141.GA18893@linux-8ccs>
References: <20191206124102.12334-1-jeyu@kernel.org>
 <20191212141613.24966-1-jeyu@kernel.org>
 <20191212142940.GE58955@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191212142940.GE58955@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Maennich [12/12/19 14:29 +0000]:
>On Thu, Dec 12, 2019 at 03:16:13PM +0100, Jessica Yu wrote:
>>Commit c3a6cf19e695 ("export: avoid code duplication in
>>include/linux/export.h") refactors export.h quite nicely, but introduces
>>a slight increase in memory usage due to using the empty string ""
>>instead of NULL to indicate that an exported symbol has no namespace. As
>>mentioned in that commit, this meant an increase of 1 byte per exported
>>symbol without a namespace. For example, if a kernel configuration has
>>about 10k exported symbols, this would mean that the size of
>>__ksymtab_strings would increase by roughly 10kB.
>>
>>We can alleviate this situation by utilizing the SHF_MERGE and
>>SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
>>that the data in the section are null-terminated strings that can be
>>merged to eliminate duplication. More specifically, from the binutils
>>documentation - "for sections with both M and S, a string which is a
>>suffix of a larger string is considered a duplicate. Thus "def" will be
>>merged with "abcdef"; A reference to the first "def" will be changed to
>>a reference to "abcdef"+3". Thus, all the empty strings would be merged
>>as well as any strings that can be merged according to the cited method
>>above. For example, "memset" and "__memset" would be merged to just
>>"__memset" in __ksymtab_strings.
>>
>>As of v5.4-rc5, the following statistics were gathered with x86
>>defconfig with approximately 10.7k exported symbols.
>>
>>Size of __ksymtab_strings in vmlinux:
>>-------------------------------------
>>v5.4-rc5: 213834 bytes
>>v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
>>v5.4-rc5 with this patch: 205759 bytes
>>
>>So, we already see memory savings of ~8kB compared to vanilla -rc5 and
>>savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
>>
>>Unfortunately, as of this writing, strings will not get deduplicated for
>>kernel modules, as ld does not do the deduplication for
>>SHF_MERGE|SHF_STRINGS sections for relocatable files (ld -r), which
>>kernel modules are. A patch for ld is currently being worked on to
>>hopefully allow for string deduplication in relocatable files in the
>>future.
>>
>>Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>>---
>>v4:
>> - fix the comment above ___EXPORT_SYMBOL to be more specific about what
>>   entries are being placed in their respective sections.
>>
>>include/asm-generic/export.h |  8 +++++---
>>include/linux/export.h       | 27 ++++++++++++++++++++-------
>>
>>2 files changed, 25 insertions(+), 10 deletions(-)
>>
>>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>>index afddc5442e92..365345f9a9e3 100644
>>--- a/include/asm-generic/export.h
>>+++ b/include/asm-generic/export.h
>>@@ -27,9 +27,11 @@
>>.endm
>>
>>/*
>>- * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>>- * since we immediately emit into those sections anyway.
>>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
>>+ * former apparently works on all arches according to the binutils source.
>> */
>>+
>>.macro ___EXPORT_SYMBOL name,val,sec
>>#ifdef CONFIG_MODULES
>>	.section ___ksymtab\sec+\name,"a"
>>@@ -37,7 +39,7 @@
>>__ksymtab_\name:
>>	__put \val, __kstrtab_\name
>>	.previous
>>-	.section __ksymtab_strings,"a"
>>+	.section __ksymtab_strings,"aMS",%progbits,1
>>__kstrtab_\name:
>>	.asciz "\name"
>>	.previous
>>diff --git a/include/linux/export.h b/include/linux/export.h
>>index 627841448293..c166d35e3d76 100644
>>--- a/include/linux/export.h
>>+++ b/include/linux/export.h
>>@@ -82,16 +82,29 @@ struct kernel_symbol {
>>
>>#else
>>
>>-/* For every exported symbol, place a struct in the __ksymtab section */
>>+/*
>>+ * For every exported symbol, do the following:
>>+ *
>>+ * - If applicable, place a CRC entry in the __kcrctab section.
>>+ * - Put the name of the symbol and namespace (empty string "" for none) in
>>+ *   __ksymtab_strings.
>>+ * - Place a struct kernel_symbol entry in the __ksymtab section.
>>+ *
>>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
>>+ * former apparently works on all arches according to the binutils source.
>>+ */
>>#define ___EXPORT_SYMBOL(sym, sec, ns)					\
>>	extern typeof(sym) sym;						\
>>+	extern const char __kstrtab_##sym[];				\
>>+	extern const char __kstrtabns_##sym[];				\
>>	__CRC_SYMBOL(sym, sec);						\
>>-	static const char __kstrtab_##sym[]				\
>>-	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
>>-	= #sym;								\
>>-	static const char __kstrtabns_##sym[]				\
>>-	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
>>-	= ns;								\
>>+	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1\n"	\
>>+	    "__kstrtab_" #sym ":				\n"	\
>>+	    "	.asciz 	\"" #sym "\"				\n"	\
>>+	    "__kstrtabns_" #sym ":				\n"	\
>>+	    "	.asciz 	\"" ns "\"				\n"	\
>>+	    "	.previous					\n");	\
>
>nit: You might want to align the newline characters up to the asm line.
>
>Thanks for working on this!
>
>Reviewed-by: Matthias Maennich <maennich@google.com>

I've fixed up the newlines and applied to modules-next. Thanks! 

Jessica
