Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE71206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578585543;
	bh=pqYBkMCnDQvhqdV8W+2A+12RrpwtiFvJ0yGf0YsiuY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F6iwd7RTrFvv3Gr0C4eZZVe/8SGQfocsHSLGhArn+taHJlDcOpTxbIfe8MhHgDYwz
	 Uub3NqKeH4iqv+RZobF5VppJFOHADvHRPOfdT/o/iaEYWIPT29R9LA7OynLQMX2mQ1
	 zD1R7Gz3doQM34uNI3A+lorRUq+VTkE0Xpe0YEGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgAIP7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:59:02 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51239 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgAIP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:59:02 -0500
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 009FwiPo026239;
        Fri, 10 Jan 2020 00:58:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 009FwiPo026239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578585525;
        bh=AqJ/xCc4C+EoY9ZSnwE5jiP6hg2Sr1yHiLOvcetf/bQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dSABy3Fr9rRGVz/zvukRpgXU5BVu5Z6BG0JLUvmN+FgQfRisxUQ4O7pdVq8IKGJlC
         Q0SMySoHBKWHqDiZZiqN44caYJ9/Yt7Q9Ud5lycWuz4fSXhEQOGYNEw6TSFgg0HHzz
         2y6XMq/bRkLdI48/yaFhENpqKpeqhlV7ngOzZ0Ynl+XBmIWlVe4DFByTXI0Bzm7c5v
         8XPw7QANBo+/qpZHQPObF/vDyL+HOgkTiegqox4DngP3FiXm2bDEBA4mMs19T1AAfZ
         HjnQ9tP/3g7bCCZ+MilrymB6hBuPHEYeG6XyVNvg5Xpxmx9ELx/5DPfIBznuQYK4D6
         fyUnosw9lndHA==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id t129so2086199vkg.6;
        Thu, 09 Jan 2020 07:58:44 -0800 (PST)
X-Gm-Message-State: APjAAAVVqrWm9DDt9Tef/zEHawzH0MrYBuY2yBMFbBJ3x4uqTKw+gqnb
        UxkBmqzHP/Uom2LZm44Cyvv+oDAhGAgSwzVtwJI=
X-Google-Smtp-Source: APXvYqzruv7RWg+pfK/b0ETXr/aI70RSHd3Q1CFedSeqhCKKB6AqzsA1lPUseZ5PEpdmHMMD8giiTzu6KZv++mGANAA=
X-Received: by 2002:a1f:18b:: with SMTP id 133mr7051654vkb.73.1578585523664;
 Thu, 09 Jan 2020 07:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20200109125627.24654-1-brgl@bgdev.pl>
In-Reply-To: <20200109125627.24654-1-brgl@bgdev.pl>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jan 2020 00:58:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBLXzgy2=fGfyrGbbWq2wL7Y9uaSh-MQQcd7tpvUBbMg@mail.gmail.com>
Message-ID: <CAK7LNASBLXzgy2=fGfyrGbbWq2wL7Y9uaSh-MQQcd7tpvUBbMg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix an "implicit declaration of function" warning
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 9:56 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> strncasecmp() & strcasecmp() functions are declared in strings.h, not
> string.h. On most environments the former is implicitly included by
> the latter but on some setups, building menuconfig results in the
> following warning:
>
>   HOSTCC  scripts/kconfig/mconf.o
> scripts/kconfig/mconf.c: In function =E2=80=98search_conf=E2=80=99:
> scripts/kconfig/mconf.c:423:6: warning: implicit declaration of function =
=E2=80=98strncasecmp=E2=80=99 [-Wimplicit-function-declaration]
>   if (strncasecmp(dialog_input_result, CONFIG_, strlen(CONFIG_)) =3D=3D 0=
)
>       ^~~~~~~~~~~
> scripts/kconfig/mconf.c: In function =E2=80=98main=E2=80=99:
> scripts/kconfig/mconf.c:1021:8: warning: implicit declaration of function=
 =E2=80=98strcasecmp=E2=80=99 [-Wimplicit-function-declaration]
>    if (!strcasecmp(mode, "single_menu"))
>         ^~~~~~~~~~
>
> Fix it by explicitly including strings.h.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks.

I see strncasecmp() in
scripts/kconfig/nconf.c too.

Could you fix both in a single patch?

You can try it with "make nconfig".



> ---
>  scripts/kconfig/mconf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> index 49c26ea9dd98..4063dbc1b927 100644
> --- a/scripts/kconfig/mconf.c
> +++ b/scripts/kconfig/mconf.c
> @@ -15,6 +15,7 @@
>  #include <stdarg.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <strings.h>
>  #include <signal.h>
>  #include <unistd.h>
>
> --
> 2.23.0
>


--=20
Best Regards
Masahiro Yamada
