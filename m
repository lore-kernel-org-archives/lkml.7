Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B694C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2032073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zmES29GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfKZQNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:13:15 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:17377 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfKZQNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:13:14 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xAQGD4PO009291
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 01:13:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xAQGD4PO009291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574784785;
        bh=caXvOgBhhR0k6h1bAZRvPp0CoWJZ4hewuqZMpwZ9tF0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zmES29GAtHZlNJLZ8pg0VSlC8cncIWmtT95gMhAo0aNwNrvJ6AuA1eq7071l+kaBv
         bEq4/Es6NsGIvxeYHONhfQIEs0ccUHjUsSLuTQEOzWHhK3EyMoGb1VRGreWp+1ZSs3
         ZG9B4E9RsFlVTkUw17JozMZdxpBOvNDP7qVpgfEiKGFhkbj9voQybx5mzxH3QXckxm
         StX0XOM2C2SxuvfQq9IIKC3RRQxroY9n7AVGbAG59Vs4DEkyD5otOKBQxiCmb6/r0c
         um8sM/bmM7G3kT4qJuxpYcXWLm4Hc6uNM2CI2x2uB0/CBc7VyH++QSNXxJSdFrqR/2
         lteJ8Zmg0x+HQ==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id s14so5860685uad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 08:13:04 -0800 (PST)
X-Gm-Message-State: APjAAAXh/CSAUgvRHTqg2zF7JrQ0vYeGfL8iKkedHdllfo56hTzCaBAB
        +qDYbWmBTJkTQcoigwjhA7ciJ8fhvpZ6QHoA9k4=
X-Google-Smtp-Source: APXvYqxkC4rJh+CHRqZ1zeIUmM7yUcaKNqsf5r01nQQ4qkbokqLCo8d/Nf860ZyqXjDAZd8ax211FsEJMnwO2fYtmiM=
X-Received: by 2002:ab0:6509:: with SMTP id w9mr3888820uam.121.1574784783489;
 Tue, 26 Nov 2019 08:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20191120145110.8397-1-jeyu@kernel.org> <20191125154217.18640-1-jeyu@kernel.org>
 <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
 <20191126135620.GA38845@google.com> <20191126153153.GA3495@linux-8ccs>
In-Reply-To: <20191126153153.GA3495@linux-8ccs>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Nov 2019 01:12:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS9WoqJh2NR81QrYNGVAUhbgU0Y97791HYb1XeAuHCtWw@mail.gmail.com>
Message-ID: <CAK7LNAS9WoqJh2NR81QrYNGVAUhbgU0Y97791HYb1XeAuHCtWw@mail.gmail.com>
Subject: Re: [PATCH v2] export.h: reduce __ksymtab_strings string duplication
 by using "MS" section flags
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:32 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Matthias Maennich [26/11/19 13:56 +0000]:
> >On Tue, Nov 26, 2019 at 05:32:59PM +0900, Masahiro Yamada wrote:
> >>On Tue, Nov 26, 2019 at 12:42 AM Jessica Yu <jeyu@kernel.org> wrote:
> >>>
> >>>Commit c3a6cf19e695 ("export: avoid code duplication in
> >>>include/linux/export.h") refactors export.h quite nicely, but introduces
> >>>a slight increase in memory usage due to using the empty string ""
> >>>instead of NULL to indicate that an exported symbol has no namespace. As
> >>>mentioned in that commit, this meant an increase of 1 byte per exported
> >>>symbol without a namespace. For example, if a kernel configuration has
> >>>about 10k exported symbols, this would mean that the size of
> >>>__ksymtab_strings would increase by roughly 10kB.
> >>>
> >>>We can alleviate this situation by utilizing the SHF_MERGE and
> >>>SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
> >>>that the data in the section are null-terminated strings that can be
> >>>merged to eliminate duplication. More specifically, from the binutils
> >>>documentation - "for sections with both M and S, a string which is a
> >>>suffix of a larger string is considered a duplicate. Thus "def" will be
> >>>merged with "abcdef"; A reference to the first "def" will be changed to
> >>>a reference to "abcdef"+3". Thus, all the empty strings would be merged
> >>>as well as any strings that can be merged according to the cited method
> >>>above. For example, "memset" and "__memset" would be merged to just
> >>>"__memset" in __ksymtab_strings.
> >>>
> >>>As of v5.4-rc5, the following statistics were gathered with x86
> >>>defconfig with approximately 10.7k exported symbols.
> >>>
> >>>Size of __ksymtab_strings in vmlinux:
> >>>-------------------------------------
> >>>v5.4-rc5: 213834 bytes
> >>>v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
> >>>v5.4-rc5 with this patch: 205759 bytes
> >>>
> >>>So, we already see memory savings of ~8kB compared to vanilla -rc5 and
> >>>savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
> >>>
> >>>Unfortunately, as of this writing, strings will not get deduplicated for
> >>>kernel modules, as ld does not do the deduplication for
> >>>SHF_MERGE|SHF_STRINGS sections for relocatable files (ld -r), which
> >>>kernel modules are. A patch for ld is currently being worked on to
> >>>hopefully allow for string deduplication in relocatable files in the
> >>>future.
> >>>
> >
> >Thanks for working on this!
> >
> >>>Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
> >>>---
> >>>
> >>>v2: use %progbits throughout and document the oddity in a comment.
> >>>
> >>> include/asm-generic/export.h |  8 +++++---
> >>> include/linux/export.h       | 27 +++++++++++++++++++++------
> >>> 2 files changed, 26 insertions(+), 9 deletions(-)
> >>>
> >>>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> >>>index fa577978fbbd..23bc98e97a66 100644
> >>>--- a/include/asm-generic/export.h
> >>>+++ b/include/asm-generic/export.h
> >>>@@ -26,9 +26,11 @@
> >>> .endm
> >>>
> >>> /*
> >>>- * note on .section use: @progbits vs %progbits nastiness doesn't matter,
> >>>- * since we immediately emit into those sections anyway.
> >>>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
> >>>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
> >>>+ * former apparently works on all arches according to the binutils source.
> >>>  */
> >>>+
> >>> .macro ___EXPORT_SYMBOL name,val,sec
> >>> #ifdef CONFIG_MODULES
> >>>        .globl __ksymtab_\name
> >>>@@ -37,7 +39,7 @@
> >>> __ksymtab_\name:
> >>>        __put \val, __kstrtab_\name
> >>>        .previous
> >>>-       .section __ksymtab_strings,"a"
> >>>+       .section __ksymtab_strings,"aMS",%progbits,1
> >>> __kstrtab_\name:
> >>>        .asciz "\name"
> >>>        .previous
> >>>diff --git a/include/linux/export.h b/include/linux/export.h
> >>>index 201262793369..3d835ca34d33 100644
> >>>--- a/include/linux/export.h
> >>>+++ b/include/linux/export.h
> >>>@@ -81,16 +81,31 @@ struct kernel_symbol {
> >>>
> >>> #else
> >>>
> >>>+/*
> >>>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
> >>>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
> >>>+ * former apparently works on all arches according to the binutils source.
> >>>+ */
> >>>+#define __KSTRTAB_ENTRY(sym)                                                   \
> >>>+       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
> >>>+           "__kstrtab_" #sym ":                                        \n"     \
> >>>+           "   .asciz  \"" #sym "\"                                    \n"     \
> >>>+           "   .previous                                               \n")
> >>>+
> >>>+#define __KSTRTAB_NS_ENTRY(sym, ns)                                            \
> >>>+       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
> >>>+           "__kstrtabns_" #sym ":                                      \n"     \
> >>>+           "   .asciz  " #ns "                                         \n"     \
> >>
> >>
> >>Hmm, it took some time for me to how this code works.
> >>
> >>ns is already a C string, then you added # to it,
> >>then I was confused.
> >>
> >>Personally, I prefer this code:
> >>" .asciz \"" ns "\" \n"
> >>
> >>so it looks in the same way as __KSTRTAB_ENTRY().
> >
> >I agree with this, these entries should be consistent.
> >
> >>
> >>
> >>
> >>BTW, you duplicated \"aMS\",%progbits,1" and ".previous"
> >>
> >>
> >>I would write it shorter, like this:
> >>
> >>
> >>#define ___EXPORT_SYMBOL(sym, sec, ns) \
> >>       extern typeof(sym) sym; \
> >>       extern const char __kstrtab_##sym[]; \
> >>       extern const char __kstrtabns_##sym[]; \
> >>       __CRC_SYMBOL(sym, sec); \
> >>       asm("    .section \"__ksymtab_strings\",\"aMS\",%progbits,1\n" \
> >>           "__kstrtab_" #sym ": \n" \
> >>           "     .asciz \"" #sym "\" \n" \
> >>           "__kstrtabns_" #sym ": \n" \
> >>           "     .asciz \"" ns "\" \n" \
> >>           "     .previous \n");    \
> >>      __KSYMTAB_ENTRY(sym, sec)
> >>
> >
> >I would prefer the separate macros though (as initially proposed) as I
> >find them much more readable. The code is already a bit tricky to reason
> >about and I don't think the shorter version is enough of a gain.
>
> Yeah, the macros were more readable IMO. But I could just squash them into one
> __KSTRTAB_ENTRY macro as a compromise for Masahiro maybe?
>
> Is this any better?

I prefer opposite.


__CRC_SYMBOL() is macrofied because it is ifdef'ed by
CONFIG_MODVERSIONS and CONFIG_MOD_REL_CRCS.

__KSYMTAB_ENTRY() is macrofied because it is ifdef'ed by
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS.



__KSTRTAB_ENTRY() does not depend on any CONFIG option,
so it can be expanded in ___EXPORT_SYMBOL().


You need to check multiple locations
to understand how it works as a whole.
I do not understand why increasing macro-chains is readable.



Masahiro




>
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 201262793369..f4a8fc798a1b 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -81,16 +81,30 @@ struct kernel_symbol {
>
>  #else
>
> +/*
> + * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
> + * section flag requires it. Use '%progbits' instead of '@progbits' since the
> + * former apparently works on all arches according to the binutils source.
> + *
> + * This basically corresponds to:
> + * const char __kstrtab_##sym[] __attribute__((section("__ksymtab_strings")) = #sym;
> + * const char __kstrtabns_##sym[] __attribute__((section("__ksymtab_strings")) = ns;
> + */
> +#define __KSTRTAB_ENTRY(sym, ns)                                               \
> +       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
> +           "__kstrtab_" #sym ":                                        \n"     \
> +           "   .asciz  \"" #sym "\"                                    \n"     \
> +           "__kstrtabns_" #sym ":                                      \n"     \
> +           "   .asciz  \"" ns "\"                                      \n"     \
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
> +       __KSTRTAB_ENTRY(sym, ns);                                       \
>         __KSYMTAB_ENTRY(sym, sec)
>
>  #endif
>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>>+           "   .previous                                               \n")
> >>>+
> >>> /* For every exported symbol, place a struct in the __ksymtab section */
> >>> #define ___EXPORT_SYMBOL(sym, sec, ns)                                 \
> >>>        extern typeof(sym) sym;                                         \
> >>>+       extern const char __kstrtab_##sym[];                            \
> >>>+       extern const char __kstrtabns_##sym[];                          \
> >>>        __CRC_SYMBOL(sym, sec);                                         \
> >>>-       static const char __kstrtab_##sym[]                             \
> >>>-       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
> >>>-       = #sym;                                                         \
> >
> >You could keep simplified versions of these statements as comment for
> >the above macros to increase readability.
> >
> >>>-       static const char __kstrtabns_##sym[]                           \
> >>>-       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
> >>>-       = ns;                                                           \
> >>>+       __KSTRTAB_ENTRY(sym);                                           \
> >>>+       __KSTRTAB_NS_ENTRY(sym, ns);                                    \
> >>>        __KSYMTAB_ENTRY(sym, sec)
> >>>
> >>> #endif
> >>>--
> >>>2.16.4
> >>>
> >
> >With the above addressed, please feel free to add
> >
> >Reviewed-by: Matthias Maennich <maennich@google.com>
> >
> >Cheers,
> >Matthias
> >
> >>
> >>
> >>--
> >>Best Regards
> >>Masahiro Yamada



--
Best Regards
Masahiro Yamada
