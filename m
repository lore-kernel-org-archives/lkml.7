Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A139BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670152077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LVcJQrWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCMRne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:43:34 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:41680 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:43:34 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2DHhBYs026058;
        Thu, 14 Mar 2019 02:43:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2DHhBYs026058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552498992;
        bh=+bgt4FknEQiOWUpXsMCO3fjYoODS51SZWAzuLFryQiQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LVcJQrWiucEFJHAO5X/8OpiPfRBj6LmQX6G2h80dYFd9YaCrfhMUISteHBsdiBumB
         spsG3YoNyrFjJY7XoASDEsd13LzhiFkAVF0QQda/rTL8cn0PLCFErsIX/hEoTRua59
         pC+7EnTtLl7UUjs5oqNLC/8YENyjeSUz/3HVj5Ys5cd2VOSuucF09fEv6WTDwMq7NM
         N9X/JRht2S9b2pTaCGltLMmgSQidzlcbvvul7e3D69LEZVQv3rTkYgsRghy7o1zRtW
         h5ooh0o5P0JeBI6tyHPRGreJa7TfXorPptloiB3V/OQrN0W5FOfhJcWrnUEeEcQBYu
         IhdDixCOmbUVQ==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id p190so691331vke.4;
        Wed, 13 Mar 2019 10:43:12 -0700 (PDT)
X-Gm-Message-State: APjAAAWwb3AnOSE77O2x9Ozypzmn4tCzTsS8iOx/qrk1zGNMzpe0bNtU
        mMmV3jbow1RmiRVxPPL7e1ek55TCVMNAYcwItJI=
X-Google-Smtp-Source: APXvYqwiRlgxgWY8uQpoXV6tURrlR/ehXb5ff4bi781WMRKHbSigndAKcQ8njJYo4hixck8X89gqHboTtmyjqfjZxFk=
X-Received: by 2002:a1f:1d01:: with SMTP id d1mr9546704vkd.0.1552498991358;
 Wed, 13 Mar 2019 10:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <1548996645-16962-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548996645-16962-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 02:42:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQicqVtx-b-qvm37U6Hq8AFztHULFuABLFVvb7i7urL3w@mail.gmail.com>
Message-ID: <CAK7LNAQicqVtx-b-qvm37U6Hq8AFztHULFuABLFVvb7i7urL3w@mail.gmail.com>
Subject: Re: [PATCH] modpost: always show verbose warning for section mismatch
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 2:26 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Unless CONFIG_DEBUG_SECTION_MISMATCH is enabled, modpost only shows
> the number of section mismatches.
>
> If you want to know the symbols causing the issue, you need to rebuild
> with CONFIG_DEBUG_SECTION_MISMATCH. It is tedious.
>
> I think it is fine to show annoying warning when a new section mismatch
> comes in.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.

>
>  scripts/Makefile.modpost |  1 -
>  scripts/mod/modpost.c    | 27 +++++----------------------
>  2 files changed, 5 insertions(+), 23 deletions(-)
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index c0b7f52..6b7f354 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -77,7 +77,6 @@ modpost = scripts/mod/modpost                    \
>   $(if $(KBUILD_EXTMOD),-I $(modulesymfile))      \
>   $(if $(KBUILD_EXTRA_SYMBOLS), $(patsubst %, -e %,$(KBUILD_EXTRA_SYMBOLS))) \
>   $(if $(KBUILD_EXTMOD),-o $(modulesymfile))      \
> - $(if $(CONFIG_DEBUG_SECTION_MISMATCH),,-S)      \
>   $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)  \
>   $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 26bf886..0b0d108 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -35,7 +35,6 @@ static int vmlinux_section_warnings = 1;
>  static int warn_unresolved = 0;
>  /* How a symbol is exported */
>  static int sec_mismatch_count = 0;
> -static int sec_mismatch_verbose = 1;
>  static int sec_mismatch_fatal = 0;
>  /* ignore missing files */
>  static int ignore_missing_files;
> @@ -1406,8 +1405,6 @@ static void report_sec_mismatch(const char *modname,
>         char *prl_to;
>
>         sec_mismatch_count++;
> -       if (!sec_mismatch_verbose)
> -               return;
>
>         get_pretty_name(from_is_func, &from, &from_p);
>         get_pretty_name(to_is_func, &to, &to_p);
> @@ -1655,9 +1652,7 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
>
>         sec_mismatch_count++;
>
> -       if (sec_mismatch_verbose)
> -               report_extable_warnings(modname, elf, mismatch, r, sym,
> -                                       fromsec, tosec);
> +       report_extable_warnings(modname, elf, mismatch, r, sym, fromsec, tosec);
>
>         if (match(tosec, mismatch->bad_tosec))
>                 fatal("The relocation at %s+0x%lx references\n"
> @@ -2433,7 +2428,7 @@ int main(int argc, char **argv)
>         struct ext_sym_list *extsym_iter;
>         struct ext_sym_list *extsym_start = NULL;
>
> -       while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awE")) != -1) {
> +       while ((opt = getopt(argc, argv, "i:I:e:mnsT:o:awE")) != -1) {
>                 switch (opt) {
>                 case 'i':
>                         kernel_read = optarg;
> @@ -2465,9 +2460,6 @@ int main(int argc, char **argv)
>                 case 's':
>                         vmlinux_section_warnings = 0;
>                         break;
> -               case 'S':
> -                       sec_mismatch_verbose = 0;
> -                       break;
>                 case 'T':
>                         files_source = optarg;
>                         break;
> @@ -2525,18 +2517,9 @@ int main(int argc, char **argv)
>         }
>         if (dump_write)
>                 write_dump(dump_write);
> -       if (sec_mismatch_count) {
> -               if (!sec_mismatch_verbose) {
> -                       warn("modpost: Found %d section mismatch(es).\n"
> -                            "To see full details build your kernel with:\n"
> -                            "'make CONFIG_DEBUG_SECTION_MISMATCH=y'\n",
> -                            sec_mismatch_count);
> -               }
> -               if (sec_mismatch_fatal) {
> -                       fatal("modpost: Section mismatches detected.\n"
> -                             "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
> -               }
> -       }
> +       if (sec_mismatch_count && sec_mismatch_fatal)
> +               fatal("modpost: Section mismatches detected.\n"
> +                     "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
>         free(buf.p);
>
>         return err;
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
