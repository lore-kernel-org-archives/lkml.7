Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607592146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lpfYR1dO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCMRmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:42:44 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:40916 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:42:44 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2DHgcAF022223;
        Thu, 14 Mar 2019 02:42:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2DHgcAF022223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552498959;
        bh=OxkTR+OrPYwtoarg8NnZobRbJRvDX39GlzIe7Q3qN4E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lpfYR1dOwFHdgHDbkyxS7aFcngHxCdOmpqBVOOUgVPT+Vp/9Wpf+J8YJlxTxnJf8S
         Lx+G04Vd6RIFUF/bT4ENDpLYRgDXQpKtbmFCGU9qvPWqbLd8AZyVuMunpd3eMT5SOF
         LkfWM48yiP6YkiIn05kvSpvA/8OLCGQOinQFH0EN4rfx2hwAsaakRaOopxDdv/0Ykr
         QbqIzSKtO32kcTLy+Fq6t5szXfFoazCo+JigJ1gw45clfxb9pbAVRfAmfZvlOgXIZP
         viWOk8PYW/z9qe7XnKaUbZQnWZK/btEJ5QAfh3ayf56a+JsoaHX0dWRlXPnhg/mY5F
         60GFHOdE5EQ0Q==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id z25so239393vsk.8;
        Wed, 13 Mar 2019 10:42:38 -0700 (PDT)
X-Gm-Message-State: APjAAAUi3fy+RDL7Im+qPuAMbMZyru0650lEW8NgbRcSKqFWdGn/jSuf
        p0NJuY9Sw9V/pGCv2lTkr7qIBJyFDl6XjW7d4L0=
X-Google-Smtp-Source: APXvYqzKsDpeVmZ3inanRsYbk7sqK5WQ0kL1KYeRvvNEeYQ8p5LGid/TwV9MB2sEm5S5gOPjfeFbkKcIMElbBNRaxg4=
X-Received: by 2002:a67:76d1:: with SMTP id r200mr5224357vsc.54.1552498957379;
 Wed, 13 Mar 2019 10:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <1552024150-9831-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1552024150-9831-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 02:42:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJnjTi5hpOk4_ikB0zdUcP8k8Gyd88or7dBKY8PvPe+g@mail.gmail.com>
Message-ID: <CAK7LNASJnjTi5hpOk4_ikB0zdUcP8k8Gyd88or7dBKY8PvPe+g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: source include/config/auto.conf instead of ${KCONFIG_CONFIG}
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Forney <forney@google.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 2:50 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As commit 423a8155facf ("kbuild: Fix reading of .config in
> link-vmlinux.sh") addressed, some shells fail to perform '.' if
> ${KCONFIG_CONFIG} does not contain a slash at all.
>
> Instead, we can source include/config/auto.conf, which obviously
> contain slashes, and we do not expect its file path overridden by
> a user. Perhaps, the performance might be slightly better since
> unset CONFIG options are stripped from include/config/auto.conf.
>
> scripts/setlocalversion already works this way.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>  scripts/adjust_autoksyms.sh | 9 +--------
>  scripts/link-vmlinux.sh     | 9 +--------
>  2 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> index 6e6d639..84bf6b5 100755
> --- a/scripts/adjust_autoksyms.sh
> +++ b/scripts/adjust_autoksyms.sh
> @@ -39,14 +39,7 @@ case "$KBUILD_VERBOSE" in
>  esac
>
>  # We need access to CONFIG_ symbols
> -case "${KCONFIG_CONFIG}" in
> -*/*)
> -       . "${KCONFIG_CONFIG}"
> -       ;;
> -*)
> -       # Force using a file from the current directory
> -       . "./${KCONFIG_CONFIG}"
> -esac
> +. include/config/auto.conf
>
>  # Generate a new ksym list file with symbols needed by the current
>  # set of modules.
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index bc7f1fc..dc0e8c5 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -171,14 +171,7 @@ if [ "$1" = "clean" ]; then
>  fi
>
>  # We need access to CONFIG_ symbols
> -case "${KCONFIG_CONFIG}" in
> -*/*)
> -       . "${KCONFIG_CONFIG}"
> -       ;;
> -*)
> -       # Force using a file from the current directory
> -       . "./${KCONFIG_CONFIG}"
> -esac
> +. include/config/auto.conf
>
>  # Update version
>  info GEN .version
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
