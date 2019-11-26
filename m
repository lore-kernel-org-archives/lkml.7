Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3151C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C86E20748
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LSKbZLrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKZIdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:33:40 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:42824 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:33:40 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xAQ8XaU3013234
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 17:33:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xAQ8XaU3013234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574757217;
        bh=jmR4B8V+bf6G0fvJLPMQDvNnpvhzTX8p8RhOFj93hcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LSKbZLrkyFmCGBwxO+iUcYDcgVCv6FDsbEVoyo75WY5Uy2O5BiPQXGWAhNQoFSQXM
         YrMxvhKmQMy2XF3nI4nhEHEQWKfnFM80coxhdqjzajdh56/Evin5YRAUOJxPSKjnmj
         Jdmc53bJ6j2Mb+xjRWBAWnQHdDG4yGfW+Os5EK35Y4P772wGhnO1RV+Ry3yeeSTwSu
         mZOE2A9/XuCUxdDxjfRD8UD8OXcVkbqxhgCWENy6mAyGjJa1rMwEuU5YKvjBJqoke/
         cOWX3v5A3nWVrxsRvjtGhyrdO/BHxq0kZvpYcXLcepjhPf6Xv286Ub+1fQCFdt4XG8
         HhK5Z6VHXtd+g==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id a143so12158460vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 00:33:36 -0800 (PST)
X-Gm-Message-State: APjAAAWybNurMvYPR6aghtdlvMRDPHG55pqGFtVq2OQPjHsh0X6f4tya
        VctoRlQgkprEgxbxkqoLQ4236bpdWy1pwihb5x8=
X-Google-Smtp-Source: APXvYqy/qEwjsM8jUQDZsxB9uA23F3WTj/mOrZwm57C37ZC19aebke63fCAIRWkAGHGV+7jSBWqLbNUHpMlCqTuu2Qk=
X-Received: by 2002:a67:d31b:: with SMTP id a27mr23563011vsj.215.1574757215516;
 Tue, 26 Nov 2019 00:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20191120145110.8397-1-jeyu@kernel.org> <20191125154217.18640-1-jeyu@kernel.org>
In-Reply-To: <20191125154217.18640-1-jeyu@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 26 Nov 2019 17:32:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
Message-ID: <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
Subject: Re: [PATCH v2] export.h: reduce __ksymtab_strings string duplication
 by using "MS" section flags
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 12:42 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> Commit c3a6cf19e695 ("export: avoid code duplication in
> include/linux/export.h") refactors export.h quite nicely, but introduces
> a slight increase in memory usage due to using the empty string ""
> instead of NULL to indicate that an exported symbol has no namespace. As
> mentioned in that commit, this meant an increase of 1 byte per exported
> symbol without a namespace. For example, if a kernel configuration has
> about 10k exported symbols, this would mean that the size of
> __ksymtab_strings would increase by roughly 10kB.
>
> We can alleviate this situation by utilizing the SHF_MERGE and
> SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
> that the data in the section are null-terminated strings that can be
> merged to eliminate duplication. More specifically, from the binutils
> documentation - "for sections with both M and S, a string which is a
> suffix of a larger string is considered a duplicate. Thus "def" will be
> merged with "abcdef"; A reference to the first "def" will be changed to
> a reference to "abcdef"+3". Thus, all the empty strings would be merged
> as well as any strings that can be merged according to the cited method
> above. For example, "memset" and "__memset" would be merged to just
> "__memset" in __ksymtab_strings.
>
> As of v5.4-rc5, the following statistics were gathered with x86
> defconfig with approximately 10.7k exported symbols.
>
> Size of __ksymtab_strings in vmlinux:
> -------------------------------------
> v5.4-rc5: 213834 bytes
> v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
> v5.4-rc5 with this patch: 205759 bytes
>
> So, we already see memory savings of ~8kB compared to vanilla -rc5 and
> savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
>
> Unfortunately, as of this writing, strings will not get deduplicated for
> kernel modules, as ld does not do the deduplication for
> SHF_MERGE|SHF_STRINGS sections for relocatable files (ld -r), which
> kernel modules are. A patch for ld is currently being worked on to
> hopefully allow for string deduplication in relocatable files in the
> future.
>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>
> v2: use %progbits throughout and document the oddity in a comment.
>
>  include/asm-generic/export.h |  8 +++++---
>  include/linux/export.h       | 27 +++++++++++++++++++++------
>  2 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index fa577978fbbd..23bc98e97a66 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -26,9 +26,11 @@
>  .endm
>
>  /*
> - * note on .section use: @progbits vs %progbits nastiness doesn't matter,
> - * since we immediately emit into those sections anyway.
> + * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
> + * section flag requires it. Use '%progbits' instead of '@progbits' since the
> + * former apparently works on all arches according to the binutils source.
>   */
> +
>  .macro ___EXPORT_SYMBOL name,val,sec
>  #ifdef CONFIG_MODULES
>         .globl __ksymtab_\name
> @@ -37,7 +39,7 @@
>  __ksymtab_\name:
>         __put \val, __kstrtab_\name
>         .previous
> -       .section __ksymtab_strings,"a"
> +       .section __ksymtab_strings,"aMS",%progbits,1
>  __kstrtab_\name:
>         .asciz "\name"
>         .previous
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 201262793369..3d835ca34d33 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -81,16 +81,31 @@ struct kernel_symbol {
>
>  #else
>
> +/*
> + * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
> + * section flag requires it. Use '%progbits' instead of '@progbits' since the
> + * former apparently works on all arches according to the binutils source.
> + */
> +#define __KSTRTAB_ENTRY(sym)                                                   \
> +       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
> +           "__kstrtab_" #sym ":                                        \n"     \
> +           "   .asciz  \"" #sym "\"                                    \n"     \
> +           "   .previous                                               \n")
> +
> +#define __KSTRTAB_NS_ENTRY(sym, ns)                                            \
> +       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
> +           "__kstrtabns_" #sym ":                                      \n"     \
> +           "   .asciz  " #ns "                                         \n"     \


Hmm, it took some time for me to how this code works.

ns is already a C string, then you added # to it,
then I was confused.

Personally, I prefer this code:
" .asciz \"" ns "\" \n"

so it looks in the same way as __KSTRTAB_ENTRY().



BTW, you duplicated \"aMS\",%progbits,1" and ".previous"


I would write it shorter, like this:


#define ___EXPORT_SYMBOL(sym, sec, ns) \
        extern typeof(sym) sym; \
        extern const char __kstrtab_##sym[]; \
        extern const char __kstrtabns_##sym[]; \
        __CRC_SYMBOL(sym, sec); \
        asm("    .section \"__ksymtab_strings\",\"aMS\",%progbits,1\n" \
            "__kstrtab_" #sym ": \n" \
            "     .asciz \"" #sym "\" \n" \
            "__kstrtabns_" #sym ": \n" \
            "     .asciz \"" ns "\" \n" \
            "     .previous \n");    \
       __KSYMTAB_ENTRY(sym, sec)








> +           "   .previous                                               \n")
> +
>  /* For every exported symbol, place a struct in the __ksymtab section */
>  #define ___EXPORT_SYMBOL(sym, sec, ns)                                 \
>         extern typeof(sym) sym;                                         \
> +       extern const char __kstrtab_##sym[];                            \
> +       extern const char __kstrtabns_##sym[];                          \
>         __CRC_SYMBOL(sym, sec);                                         \
> -       static const char __kstrtab_##sym[]                             \
> -       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
> -       = #sym;                                                         \
> -       static const char __kstrtabns_##sym[]                           \
> -       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
> -       = ns;                                                           \
> +       __KSTRTAB_ENTRY(sym);                                           \
> +       __KSTRTAB_NS_ENTRY(sym, ns);                                    \
>         __KSYMTAB_ENTRY(sym, sec)
>
>  #endif
> --
> 2.16.4
>


-- 
Best Regards
Masahiro Yamada
