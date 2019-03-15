Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177AF218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cnwDkYWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfCOP2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:28:42 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:27436 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfCOP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:28:41 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x2FFSKiK026702;
        Sat, 16 Mar 2019 00:28:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x2FFSKiK026702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552663701;
        bh=tRcK2s+apwdP0KyujQGOw5YmCBT+aOqLucuoiRasyUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cnwDkYWEQunXLXAQUkUz3LHYRYLjtE6g2gKYbTbFgnqZdRIeZ6QeXpXXkjb5JmtT9
         0IHjeJUsfM6Vmndb3049OqGCtaCebFDcD1F5dSCydhCjwO4ldnXqdIyOohx7zwaDok
         NSJ7Gwbk2MFBLYCgTc9dXx08JfX5c/sSUw9SqU++53oPOZqPDpTf4LlTJoG4PpQpmw
         sy+n5r00Iwb+vzGbHb6AcFvtuSqtyMTtcl04X1KXEYv0fn6avHqld0I6SdJT5vtPp5
         r+d53ihFzwswzfZgdHnj3JkVLzEmO1RIKOL3G3BCrIrqcNAUAVhSnr1fXQwTjkX9un
         ItdJHIIce+Ogg==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id x140so2289928vke.5;
        Fri, 15 Mar 2019 08:28:21 -0700 (PDT)
X-Gm-Message-State: APjAAAUnL+lkH/Dkdm5RVf+ndGCXAU9LkCKIPdsa8g683paT39Lz2WJ6
        rRUCiOXvcR1bDsxOxUVFrhbeWln51cLVS8mXgnI=
X-Google-Smtp-Source: APXvYqyj/fAW4G9eKa4hJu8LyD0GzUnQPF5F2FvyIVu38E9uPQjkLKt3RlwBIx4ssouVGHSyIVYg1MBGMKdlzT0P400=
X-Received: by 2002:a1f:682:: with SMTP id 124mr2413937vkg.34.1552663700145;
 Fri, 15 Mar 2019 08:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190314234159.191745-1-dianders@chromium.org>
In-Reply-To: <20190314234159.191745-1-dianders@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Mar 2019 00:27:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATa+TnXb+a6on-sx2mjNoAiORe-WeZ8UusETHdSrXowuw@mail.gmail.com>
Message-ID: <CAK7LNATa+TnXb+a6on-sx2mjNoAiORe-WeZ8UusETHdSrXowuw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Make NOSTDINC_FLAGS a simply expanded variable
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 8:42 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> During a simple no-op (nothing changed) build I saw 39 invocations of
> the C compiler with the argument "-print-file-name=include".  We don't
> need to call the C compiler 39 times for this--one time will suffice.
>
> Let's change NOSTDINC_FLAGS to a simply expanded variable to avoid
> this since there doesn't appear to be any reason it should be
> recursively expanded.
>
> On my build this shaved ~400 ms off my "no-op" build.
>
> Note that the recursive expansion seems to date back to the (really
> old) commit e8f5bdb02ce0 ("[PATCH] Makefile include path ordering").
> It's a little unclear to me if the point of that patch was to switch
> the variable to be recursively expanded (which it did) or to avoid
> directly assigning to NOSTDINC_FLAGS (AKA to switch to +=) because
> someone else (out of tree?) was setting it.  I presume later since if
> the only goal was to switch to recursive expansion the patch would
> have just removed the ":".
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Applied to linux-kbuild.
Thanks.



> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 9ef547fc7ffe..3034ba66ad51 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -402,7 +402,7 @@ CHECK               = sparse
>
>  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
>                   -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
> -NOSTDINC_FLAGS  =
> +NOSTDINC_FLAGS :=
>  CFLAGS_MODULE   =
>  AFLAGS_MODULE   =
>  LDFLAGS_MODULE  =
> --
> 2.21.0.360.g471c308f928-goog
>


-- 
Best Regards
Masahiro Yamada
