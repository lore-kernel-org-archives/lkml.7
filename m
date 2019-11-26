Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B3AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031742071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSczzWuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfKZQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:02:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53921 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfKZQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:02:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so3780698wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 08:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DxvroR9z4IIHtGDxIN43Rqp01bNOUASI/oAlkAhFSIU=;
        b=WSczzWuON6S/j8ledoK8Ud9GN7IaOaZKv857djb8REchmmYNbVwBTGSKX2INSMFEMN
         hN958pQOnBkgFkJ95ZSxQLjKxl6HgdtuOM/EmkgF5svwZmr9cQ0tcJ/7B0uG+IltYg74
         I2fEj31dOCPnluiOvdWL6cMEUCUk0hyMDuOX3XKdA1wYJim2hc9NLJfzZZOgaLUe1nRB
         Xqops7OLZEjQ1RHda9o6bwF5mV755714QalIXLok7anENpFzx9P0uNrPh9EuAwErOtZ/
         GTdwivxzWxZCJGRhxfA2H1ZgdQ6KDn1UV2PTH4qBFJeQ08LjKTq9Z6sfRsjfDOPLhkrz
         jkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DxvroR9z4IIHtGDxIN43Rqp01bNOUASI/oAlkAhFSIU=;
        b=Le7JM7CunnAAb/Qy4mUbU+yJEW1FkSW5gfuAalKH8HwwInrwCtTPbMqtYjAz3sV3wi
         9fZE1CLzzGQySQeZwBMU5M3Z1Mh1PbLeIkBatQBrSgQHGfnrv15TW3vTdEVpbvmIw9Y9
         1A+0oBRqjP5NgrysfK/Y57K7LUTFg3R06IlMDrfQt9jBal0Qx5dFjwqUWGsi8DP9NOQ1
         4HvGYJzt3ndkqi4E3e+wsMeGoTlQfifJetIrjw4mTIRxZ91r5nCZGBbdwxZIIA35FxVQ
         FB37+j4ML9ppahvevbj549LJuetWSqdM/uzy2mkRz+7blw8zH5V+LX1SIdj7rEOAObwY
         vkLQ==
X-Gm-Message-State: APjAAAWjPEHNgOdyur+N81HK0pLWTkB7mqnZCDrvrthLhPgs2fUBZlOB
        2fFajZoRJjMaO+zBj1ckcigaXQ==
X-Google-Smtp-Source: APXvYqzxCIxLDXC4OmWfCPEq1pVlxJo/eYZKM1VGy7wmd115xrhydBnxC6kMhzhQ0mMg7aiZJHPm/w==
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr3446104wmh.45.1574784130385;
        Tue, 26 Nov 2019 08:02:10 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id l10sm16816081wrg.90.2019.11.26.08.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:02:09 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:02:09 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] export.h: reduce __ksymtab_strings string duplication
 by using "MS" section flags
Message-ID: <20191126160209.GC38845@google.com>
References: <20191120145110.8397-1-jeyu@kernel.org>
 <20191125154217.18640-1-jeyu@kernel.org>
 <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
 <20191126135620.GA38845@google.com>
 <20191126153153.GA3495@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191126153153.GA3495@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 04:31:54PM +0100, Jessica Yu wrote:
>+++ Matthias Maennich [26/11/19 13:56 +0000]:
>>On Tue, Nov 26, 2019 at 05:32:59PM +0900, Masahiro Yamada wrote:
>>>On Tue, Nov 26, 2019 at 12:42 AM Jessica Yu <jeyu@kernel.org> wrote:
>>>>
>>>>Commit c3a6cf19e695 ("export: avoid code duplication in
>>>>include/linux/export.h") refactors export.h quite nicely, but introduces
>>>>a slight increase in memory usage due to using the empty string ""
>>>>instead of NULL to indicate that an exported symbol has no namespace. As
>>>>mentioned in that commit, this meant an increase of 1 byte per exported
>>>>symbol without a namespace. For example, if a kernel configuration has
>>>>about 10k exported symbols, this would mean that the size of
>>>>__ksymtab_strings would increase by roughly 10kB.
>>>>
>>>>We can alleviate this situation by utilizing the SHF_MERGE and
>>>>SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
>>>>that the data in the section are null-terminated strings that can be
>>>>merged to eliminate duplication. More specifically, from the binutils
>>>>documentation - "for sections with both M and S, a string which is a
>>>>suffix of a larger string is considered a duplicate. Thus "def" will be
>>>>merged with "abcdef"; A reference to the first "def" will be changed to
>>>>a reference to "abcdef"+3". Thus, all the empty strings would be merged
>>>>as well as any strings that can be merged according to the cited method
>>>>above. For example, "memset" and "__memset" would be merged to just
>>>>"__memset" in __ksymtab_strings.
>>>>
>>>>As of v5.4-rc5, the following statistics were gathered with x86
>>>>defconfig with approximately 10.7k exported symbols.
>>>>
>>>>Size of __ksymtab_strings in vmlinux:
>>>>-------------------------------------
>>>>v5.4-rc5: 213834 bytes
>>>>v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
>>>>v5.4-rc5 with this patch: 205759 bytes
>>>>
>>>>So, we already see memory savings of ~8kB compared to vanilla -rc5 and
>>>>savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
>>>>
>>>>Unfortunately, as of this writing, strings will not get deduplicated for
>>>>kernel modules, as ld does not do the deduplication for
>>>>SHF_MERGE|SHF_STRINGS sections for relocatable files (ld -r), which
>>>>kernel modules are. A patch for ld is currently being worked on to
>>>>hopefully allow for string deduplication in relocatable files in the
>>>>future.
>>>>
>>
>>Thanks for working on this!
>>
>>>>Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>>>>---
>>>>
>>>>v2: use %progbits throughout and document the oddity in a comment.
>>>>
>>>>include/asm-generic/export.h |  8 +++++---
>>>>include/linux/export.h       | 27 +++++++++++++++++++++------
>>>>2 files changed, 26 insertions(+), 9 deletions(-)
>>>>
>>>>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>>>>index fa577978fbbd..23bc98e97a66 100644
>>>>--- a/include/asm-generic/export.h
>>>>+++ b/include/asm-generic/export.h
>>>>@@ -26,9 +26,11 @@
>>>>.endm
>>>>
>>>>/*
>>>>- * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>>>>- * since we immediately emit into those sections anyway.
>>>>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>>>>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
>>>>+ * former apparently works on all arches according to the binutils source.
>>>> */
>>>>+
>>>>.macro ___EXPORT_SYMBOL name,val,sec
>>>>#ifdef CONFIG_MODULES
>>>>       .globl __ksymtab_\name
>>>>@@ -37,7 +39,7 @@
>>>>__ksymtab_\name:
>>>>       __put \val, __kstrtab_\name
>>>>       .previous
>>>>-       .section __ksymtab_strings,"a"
>>>>+       .section __ksymtab_strings,"aMS",%progbits,1
>>>>__kstrtab_\name:
>>>>       .asciz "\name"
>>>>       .previous
>>>>diff --git a/include/linux/export.h b/include/linux/export.h
>>>>index 201262793369..3d835ca34d33 100644
>>>>--- a/include/linux/export.h
>>>>+++ b/include/linux/export.h
>>>>@@ -81,16 +81,31 @@ struct kernel_symbol {
>>>>
>>>>#else
>>>>
>>>>+/*
>>>>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>>>>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
>>>>+ * former apparently works on all arches according to the binutils source.
>>>>+ */
>>>>+#define __KSTRTAB_ENTRY(sym)                                                   \
>>>>+       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
>>>>+           "__kstrtab_" #sym ":                                        \n"     \
>>>>+           "   .asciz  \"" #sym "\"                                    \n"     \
>>>>+           "   .previous                                               \n")
>>>>+
>>>>+#define __KSTRTAB_NS_ENTRY(sym, ns)                                            \
>>>>+       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
>>>>+           "__kstrtabns_" #sym ":                                      \n"     \
>>>>+           "   .asciz  " #ns "                                         \n"     \
>>>
>>>
>>>Hmm, it took some time for me to how this code works.
>>>
>>>ns is already a C string, then you added # to it,
>>>then I was confused.
>>>
>>>Personally, I prefer this code:
>>>" .asciz \"" ns "\" \n"
>>>
>>>so it looks in the same way as __KSTRTAB_ENTRY().
>>
>>I agree with this, these entries should be consistent.
>>
>>>
>>>
>>>
>>>BTW, you duplicated \"aMS\",%progbits,1" and ".previous"
>>>
>>>
>>>I would write it shorter, like this:
>>>
>>>
>>>#define ___EXPORT_SYMBOL(sym, sec, ns) \
>>>      extern typeof(sym) sym; \
>>>      extern const char __kstrtab_##sym[]; \
>>>      extern const char __kstrtabns_##sym[]; \
>>>      __CRC_SYMBOL(sym, sec); \
>>>      asm("    .section \"__ksymtab_strings\",\"aMS\",%progbits,1\n" \
>>>          "__kstrtab_" #sym ": \n" \
>>>          "     .asciz \"" #sym "\" \n" \
>>>          "__kstrtabns_" #sym ": \n" \
>>>          "     .asciz \"" ns "\" \n" \
>>>          "     .previous \n");    \
>>>     __KSYMTAB_ENTRY(sym, sec)
>>>
>>
>>I would prefer the separate macros though (as initially proposed) as I
>>find them much more readable. The code is already a bit tricky to reason
>>about and I don't think the shorter version is enough of a gain.
>
>Yeah, the macros were more readable IMO. But I could just squash them into one
>__KSTRTAB_ENTRY macro as a compromise for Masahiro maybe?
>
>Is this any better?

Yes, I like this variant.

>
>diff --git a/include/linux/export.h b/include/linux/export.h
>index 201262793369..f4a8fc798a1b 100644
>--- a/include/linux/export.h
>+++ b/include/linux/export.h
>@@ -81,16 +81,30 @@ struct kernel_symbol {
>
>#else
>
>+/*
>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
>+ * former apparently works on all arches according to the binutils source.
>+ *
>+ * This basically corresponds to:
>+ * const char __kstrtab_##sym[] __attribute__((section("__ksymtab_strings")) = #sym;
>+ * const char __kstrtabns_##sym[] __attribute__((section("__ksymtab_strings")) = ns;
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
You might want to drop the section attribute here to make the comment
shorter (even though it is not entirely correct than anymore).

Cheers,
Matthias

>+ */
>+#define __KSTRTAB_ENTRY(sym, ns)                                               \
>+       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
>+           "__kstrtab_" #sym ":                                        \n"     \
>+           "   .asciz  \"" #sym "\"                                    \n"     \
>+           "__kstrtabns_" #sym ":                                      \n"     \
>+           "   .asciz  \"" ns "\"                                      \n"     \
>+           "   .previous                                               \n")
>+
>/* For every exported symbol, place a struct in the __ksymtab section */
>#define ___EXPORT_SYMBOL(sym, sec, ns)                                 \
>       extern typeof(sym) sym;                                         \
>+       extern const char __kstrtab_##sym[];                            \
>+       extern const char __kstrtabns_##sym[];                          \
>       __CRC_SYMBOL(sym, sec);                                         \
>-       static const char __kstrtab_##sym[]                             \
>-       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
>-       = #sym;                                                         \
>-       static const char __kstrtabns_##sym[]                           \
>-       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
>-       = ns;                                                           \
>+       __KSTRTAB_ENTRY(sym, ns);                                       \
>       __KSYMTAB_ENTRY(sym, sec)
>
>#endif
>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>>+           "   .previous                                               \n")
>>>>+
>>>>/* For every exported symbol, place a struct in the __ksymtab section */
>>>>#define ___EXPORT_SYMBOL(sym, sec, ns)                                 \
>>>>       extern typeof(sym) sym;                                         \
>>>>+       extern const char __kstrtab_##sym[];                            \
>>>>+       extern const char __kstrtabns_##sym[];                          \
>>>>       __CRC_SYMBOL(sym, sec);                                         \
>>>>-       static const char __kstrtab_##sym[]                             \
>>>>-       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
>>>>-       = #sym;                                                         \
>>
>>You could keep simplified versions of these statements as comment for
>>the above macros to increase readability.
>>
>>>>-       static const char __kstrtabns_##sym[]                           \
>>>>-       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
>>>>-       = ns;                                                           \
>>>>+       __KSTRTAB_ENTRY(sym);                                           \
>>>>+       __KSTRTAB_NS_ENTRY(sym, ns);                                    \
>>>>       __KSYMTAB_ENTRY(sym, sec)
>>>>
>>>>#endif
>>>>--
>>>>2.16.4
>>>>
>>
>>With the above addressed, please feel free to add
>>
>>Reviewed-by: Matthias Maennich <maennich@google.com>
>>
>>Cheers,
>>Matthias
>>
>>>
>>>
>>>-- 
>>>Best Regards
>>>Masahiro Yamada
