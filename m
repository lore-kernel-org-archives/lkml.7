Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5427CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF10520578
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="h5zOQzfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfEMKMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:12:31 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:62958 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbfEMKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:12:31 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x4DACNKg031245
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 19:12:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x4DACNKg031245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557742344;
        bh=ODlBAjHXxiCRJh7AQBv/FHzqUYiFWWcRz+GpxKhGA5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h5zOQzfCmd1u2QQl0952acDb+JzIQYIxxmZmZBxJmVW2Df2pTpesEwFOmfE4PU0kl
         cyhpKLJ3Ccjs6bKRSJxQg7651wS6AIawTpjrA772n8NUXZ8GndeeBKcjbaZ2FdqlFv
         VSXtdN2Ea8AiI2Inq5h1FLsXp7mo99FpBriHI+OkJElPNoNB+8Zu4BJjWdjVNRMrUy
         KnXw51DwpELDeNFGP11W0VwxnL7zTI/EDyEm1HQHSpi3VZdNTUHdmOl7rcCW3pc7V0
         C7acs/ltRB80bMXJ4GSvpI9/N3BFRuYGAYpYa9L5Mpa6hv4rKkDx28oa5f01mHlKcT
         pAyR5Lf9/4tnQ==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id o187so3152704vkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:12:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWMkQUKFTC3F6IaV0L1NnKJgv/PcNCAHgS/NBQtAf22UAfoHNAx
        kn7ftLP0kB65WOg4fGrBlP4uvhBwTU9EjN+Pwy0=
X-Google-Smtp-Source: APXvYqw6bacaHxJG1iOv2EVzi86Es0K5+epo1z6muUhdOcfXs2zpwFFO+BV/D+GQAutw46pYQ0Yt0GNOCgvA5rTVcOM=
X-Received: by 2002:a1f:6011:: with SMTP id u17mr4050525vkb.64.1557742342761;
 Mon, 13 May 2019 03:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
 <b5e2a4d9eb49290d6dc3449c90cdf07797b1aba6.camel@perches.com>
In-Reply-To: <b5e2a4d9eb49290d6dc3449c90cdf07797b1aba6.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 13 May 2019 19:11:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxsUheo2dHn5E=4ACafcYL9zNubgiVkJkANuZkx2RgpA@mail.gmail.com>
Message-ID: <CAK7LNAQxsUheo2dHn5E=4ACafcYL9zNubgiVkJkANuZkx2RgpA@mail.gmail.com>
Subject: Re: [Proposal] end of file checks by checkpatch.pl
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Fri, May 10, 2019 at 2:20 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-05-10 at 00:27 +0900, Masahiro Yamada wrote:
> > Hi Joe,
> >
> >
> > Does it make sense to check the following
> > by checkpatch.pl ?
> >
> >
> > [1] blank line at end of file
>
>
> > [2] no new line at end of file
>
> I'm pretty sure checkpatch does one this already.
> (around line 3175)
>
> # check for adding lines without a newline.
>                 if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
>                         WARN("MISSING_EOF_NEWLINE",
>                              "adding a line without newline at end of file\n" . $herecurr);
>                 }


I did not know this. Thanks.

Looks like the report depends on the file type.

scripts/checkpatch.pl  -f  arch/sparc/lib/NG4clear_page.S
scripts/checkpatch.pl  -f  tools/power/cpupower/bench/cpufreq-bench_plot.sh

reported it, but

scripts/checkpatch.pl  -f  drivers/media/dvb-frontends/cxd2880/Kconfig
scripts/checkpatch.pl  -f  drivers/parport/Makefile

did not.

>
> > When I apply a patch,
> > I sometimes see the following warning from 'git am'.
> >
> >
> > Applying: kunit: test: add string_stream a std::stream like string builder
> > .git/rebase-apply/patch:223: new blank line at EOF.
> > +
> >
> >
> > I just thought it could be checked
> > before the patch submission.
>
> perhaps:
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1c421ac42b07..ceb32c584ee5 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3356,6 +3356,12 @@ sub process {
>                         $last_blank_line = $linenr;
>                 }
>
> +# check the last line isn't blank
> +               if ($linenr >= $#rawlines && $line =~ /^\+\s*$/) {
> +                       WARN("LINE_SPACING",
> +                            "Avoid blank lines at EOF\n" . $herecurr);
> +               }
> +
>  # check for missing blank lines after declarations
>                 if ($sline =~ /^\+\s+\S/ &&                     #Not at char 1
>                         # actual declarations
>
>

Worked for me.
(but Makefile, Kconfig were not checked though)


Could you commit it ?

Tested-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks.

-- 
Best Regards
Masahiro Yamada
