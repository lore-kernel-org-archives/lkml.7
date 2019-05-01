Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AD4C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 12:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82882075E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 12:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xpGNYik6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEAMkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 08:40:40 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:43537 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfEAMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 08:40:40 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x41CeEvq012097;
        Wed, 1 May 2019 21:40:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x41CeEvq012097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556714415;
        bh=wstbh6udNlyaWVSJp63gZDV8qckdtdvHWUSqhwKDTBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xpGNYik6PkrHcrmRRatBTfGwBShD05t/viLiJMc/NAWFDS5I8e225gpyVC6hxeKrC
         bwghV7p4xPuNu7gnDACU83zabJ/v5RpSMux3JFmb6s7XN0ZvdaHxNlImbL8EFNW6o8
         apVF08+0fizEhKanhpl/lyTy9nXbOfO+jmSRdoUAUGD7/zo1t35CHmYkkBJI+mhCRO
         SnxDFfLQu57//ZkkRSwN5fsGKb6efQZhY9EgqUCjWZhn/dnec2LHsffpxwTiHgzvaj
         M60DPQ0pEGiX//4EqoBT5PfRYgcSCOh+faTeX4oCrNu/Ejc1PSZ3EQSoP+xty6QJQl
         kGPJUmIGkJGKw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id g187so9770055vsc.8;
        Wed, 01 May 2019 05:40:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVCjiiOFxmHMJ7fwu+G6RfAeAeCTycVkyUQAdB4paDxUDpQnly7
        c8ySBkKEmHgFm5QI8fl8YL7xvlwXYAq/8MxKi88=
X-Google-Smtp-Source: APXvYqwtb7qafYKHH8EQMfXlBNAi1O6+jjKobAktgcxFpVPb8KpUXXNxsbrCe6pMNY6EgdXssJMG2v4uC/j26IDVuLk=
X-Received: by 2002:a67:f105:: with SMTP id n5mr39314337vsk.181.1556714414404;
 Wed, 01 May 2019 05:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1556510803-5628-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1556510803-5628-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 1 May 2019 21:39:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATcTiFgeTz7NJMgHZkZKuEiBuSRRrxftp4UBEzNFa2ErA@mail.gmail.com>
Message-ID: <CAK7LNATcTiFgeTz7NJMgHZkZKuEiBuSRRrxftp4UBEzNFa2ErA@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags.sh: fix direct execution of scripts/tags.sh
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 1:07 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I thought this script was run via "make tags" etc. but some people
> run it directly.
>
> Prior to commit a9a49c2ad9b9 ("kbuild: use $(srctree) instead of
> KBUILD_SRC to check out-of-tree build"), in such a usecase, "tree"
> was set empty since KBUILD_SRC is undefined. Now, "tree" is set to
> "${srctree}/", which is evaluated to "/".
>
> Fix it by taking into account the case where "srctree" is unset.
>
> Link: https://lkml.org/lkml/2019/4/19/501
> Fixes: a9a49c2ad9b9 ("kbuild: use $(srctree) instead of KBUILD_SRC to check out-of-tree build")
> Reported-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>
>  scripts/tags.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 6a55180..70e14c6 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -19,7 +19,7 @@ ignore="$ignore ( -name *.mod.c ) -prune -o"
>  # Do not use full path if we do not use O=.. builds
>  # Use make O=. {tags|cscope}
>  # to force full paths for a non-O= build
> -if [ "${srctree}" = "." ]; then
> +if [ "${srctree}" = "." -o -z "${srctree}" ]; then
>         tree=
>  else
>         tree=${srctree}/
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
