Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5D2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ACE2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576131848;
	bh=iFk0l3fNk+DznF5EHYeeRyW1NKE7uSXwlKEpYfm9jdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VIEWyPZTVJ7bhqlzpL6EbOG5H3PVQtkbDOAvvcrNJ4PNAZd6UzFdkBQaTOISQv1U7
	 yI3Q8178hng/TL/+oXs927xfcTaLtEcdFFLIn7/zUP+pGVdn1gow3nfBIE8E2iUEjb
	 RtzPTGCshDNJkwCCA/wgjT4zlSUTHW147lwehO9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfLLGXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:23:34 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:35320 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfLLGXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:23:33 -0500
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id xBC6NSf0023112
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 15:23:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com xBC6NSf0023112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576131809;
        bh=i7ocOMSc/MW6eFTX2hPMVcZEp0K52RbWh5zz/YcJAPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RCvQa6T4un0P7modVhShMH6LZJ/CgaCV3mrsFBlaq86vjUfPhDTY/QhMpkIwp2/U1
         h3vRYpNFhng5TYc0TQJyvj/BFRbWoBYiHXjMgCxsa/Q4TfMfD4sNwn39c0JxdG09gI
         Y0XlXry3GSHJ0dynVSkbhIM61AcIq+F9DMzc3m9cNEkKX8B2g2unYlnVC7hRlA/Lz3
         TMIUBH0LW3Q/cPcrO2F9gXFuqxFbjFsbHzU2Frg5AiOcOQY9RpOrc/1Gw+PTUvL6dv
         qmPGAHqJ5f/kGKbASBefcF3K7vrCt1ii5KQhDmjXmWp1MWI/dOwqPrBBlM+1K9Y2vP
         GvbbPvYPRZ7Sg==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id u6so79837vkn.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 22:23:28 -0800 (PST)
X-Gm-Message-State: APjAAAXGe96yFKzs9LynNo9oOQZQwVHa8EtNFvfEqZgOsbXxGECpBaP8
        Ve6uQCM1RIXbYzkxsxGrj56CBOlMLhEmDyquII0=
X-Google-Smtp-Source: APXvYqwEm/gQyJa2MpP2RIiSjW99Fc7GxuRNeWtbPxHbHRKlC4nJ8ewJTlxrhsE89XU5uf1j8vv0e+FaBmkUoZSUrBQ=
X-Received: by 2002:a1f:6344:: with SMTP id x65mr7376302vkb.26.1576131807703;
 Wed, 11 Dec 2019 22:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20191125154217.18640-1-jeyu@kernel.org> <20191206124102.12334-1-jeyu@kernel.org>
In-Reply-To: <20191206124102.12334-1-jeyu@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Dec 2019 15:22:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATcO3tW-ggosW7DxRquKbAWnQCNoZFtQZXxJn-+=UtE9g@mail.gmail.com>
Message-ID: <CAK7LNATcO3tW-ggosW7DxRquKbAWnQCNoZFtQZXxJn-+=UtE9g@mail.gmail.com>
Subject: Re: [PATCH v3] export.h: reduce __ksymtab_strings string duplication
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

On Fri, Dec 6, 2019 at 9:41 PM Jessica Yu <jeyu@kernel.org> wrote:
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
> v3:
>   - remove __KSTRTAB_ENTRY macros in favor of just putting the asm directly
>     in ___EXPORT_SYMBOL
>   - Document more clearly what the ___EXPORT_SYMBOL macro does
>
>  include/asm-generic/export.h |  8 +++++---
>  include/linux/export.h       | 27 ++++++++++++++++++++-------
>  2 files changed, 25 insertions(+), 10 deletions(-)
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
> index 201262793369..18dcdcd118e7 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -81,16 +81,29 @@ struct kernel_symbol {
>
>  #else
>
> -/* For every exported symbol, place a struct in the __ksymtab section */
> +/*
> + * For every exported symbol, do the following:

Just a nit.

You mention "an entry" twice
to talk about different classes of structures.

It might be better to be explicit about "which entry".


> + *
> + * - If applicable, place an entry in the __kcrctab section.

  "place a CRC entry in the __kcrctab section"
might be clearer ?


> + * - Put the name of the symbol and namespace (empty string "" for none) in
> + *   __ksymtab_strings.
> + * - Place an entry in the __ksymtab section.

 "Place a struct kernel_symbol entry in __ksymtab section"   ?
might be clearer ?


Other than that:
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


> + *
> + * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
> + * section flag requires it. Use '%progbits' instead of '@progbits' since the
> + * former apparently works on all arches according to the binutils source.
> + */
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
> +       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1\n"   \
> +           "__kstrtab_" #sym ":                                \n"     \
> +           "   .asciz  \"" #sym "\"                            \n"     \
> +           "__kstrtabns_" #sym ":                              \n"     \
> +           "   .asciz  \"" ns "\"                              \n"     \
> +           "   .previous                                       \n");   \
>         __KSYMTAB_ENTRY(sym, sec)
>
>  #endif
> --
> 2.16.4
>


-- 
Best Regards
Masahiro Yamada
