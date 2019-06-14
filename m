Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C813C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054372177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ws5E8yah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfFNSQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:16:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42391 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfFNSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:16:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so1913901pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=puTHRzJLDYkby5dm7Z8PxTsKRwDG5hRxWOagm4BjqQs=;
        b=Ws5E8yahDqKXoYIz72TJmHfAl5rhhKJVVPGEfYEKGwK1Xc7tB9TLqy3FeLI4M9by0Y
         nMXLSaMHVOLx61lkQ4eUUCb9vUtSwVTg4ls6Pn098zvhtKgMxYUVGLgcxnqtWZcuj0wb
         +rdB2UpYxEYkA2PhycUv7iLSB5vLDV1Xvf4sl/3t6gl7PWUiqvlBpaE+roV7yxDRQXKx
         JNgFRV6RLUNG7r+ARt5Y35EJFWsQ6NJ6v+sxMi3CDaL8CVgehmo+c1j6ldTPFTSCBFJ6
         xzyPPD6EcNGFtUWUTqjTdPh2hq0sg1ENk0pHqOMNBAOLMRkl5CBNejc+HZ2RvgdPrON7
         TGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puTHRzJLDYkby5dm7Z8PxTsKRwDG5hRxWOagm4BjqQs=;
        b=suBLMizIeVSQdOJVBjiWV+0J6svzmpApv0SCt2nMFEH2xbjNmBmfb4PGz5O54sp6NK
         AaAH3dJ0Lco97/3EiqAA6wmNwO+3DusuHuIMFOgSrNE6t2unbBP4qcPpQlaory9j9/U2
         TkA09e7NWDMSRXKeg8Y+pjBM+hC1hJ9OefjM4Wj++/IjPrvZr+MbCcqEdmr7cQbgnNM1
         7RiYcHpKi5OgmNSFXAAwqNOkeHO4o/tThc2ywGu9rTX19SFgfVzBfjgnSDa5FxHc6kxg
         +AJ5zzeAKgPrG9FoeI3IxhsqzTQMk5xeMY185HjZorkYseyEjwCrXxtb0ZRPT0iM9zJC
         xUUg==
X-Gm-Message-State: APjAAAWzeXLIX5Imw9D+KArrYRqYZyceZPQ7x7KSVk3fvya895yI94lG
        cnc4y1hjP7ej9q83j7PwIxgvsFjokhKTrWhtLy2f1g==
X-Google-Smtp-Source: APXvYqyZgc8wUMxZ3Mln8U6UN35HufOhqqxZRAFb4tsblfJ4VSYkx2CoHaVLiNC8cZ96pfDUEqTOt66XarYRLfO+rdA=
X-Received: by 2002:a63:52:: with SMTP id 79mr36714073pga.381.1560536203926;
 Fri, 14 Jun 2019 11:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190614165242.79257-1-natechancellor@gmail.com>
In-Reply-To: <20190614165242.79257-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Jun 2019 11:16:32 -0700
Message-ID: <CAKwvOdkyoEYe83HdF-0ofPckFkE5rsFdNnQw5NxXTUQfHNntsg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Enable -Wuninitialized
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 9:53 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> This helps fine very dodgy behavior through both -Wuninitialized
> (warning that a variable is always uninitialized) and
> -Wsometimes-uninitialized (warning that a variable is sometimes
> uninitialized, like GCC's -Wmaybe-uninitialized). These warnings
> catch things that GCC doesn't such as:
>
> https://lore.kernel.org/lkml/86649ee4-9794-77a3-502c-f4cd10019c36@lca.pw/

or this one, which was my favorite, and quite insidious from an
underhanded C contest perspective.
https://lore.kernel.org/lkml/20190226053855.7020-1-natechancellor@gmail.com/

Thank you very much for all the hard work you did tracking done and
fixing all of the cases we could find.  I very much look forward to
this patch as the capstone to all that work.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> We very much want to catch these so turn this warning on so that CI is
> aware of it.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/381
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  scripts/Makefile.extrawarn | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 98081ab300e5..699683a7c116 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -71,6 +71,5 @@ KBUILD_CFLAGS += -Wno-unused-value
>  KBUILD_CFLAGS += -Wno-format
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-format-zero-length
> -KBUILD_CFLAGS += -Wno-uninitialized
>  endif
>  endif
> --
> 2.22.0
>


-- 
Thanks,
~Nick Desaulniers
