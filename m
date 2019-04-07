Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3EAC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B034420B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1qJO1hok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfDGJWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 05:22:09 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:46794 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDGJWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 05:22:09 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x379LuFq005569;
        Sun, 7 Apr 2019 18:21:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x379LuFq005569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554628917;
        bh=qhxQyGSXrRr6HtsWMhTkDZmMv/049Dar1W1b1ADZqIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1qJO1hokIb9yXGHcjJwCkT3LOd+8Sd9MyfzTvuJefbv7Usl6W2uAikBQAPuQz97I9
         jTzosDL+uQDCmJ//E9nz8iP83fgQwwnqHQvVXwd/S93VHuYEFu8jmK1//LUhqVWifF
         AuWNXrXO/p8K9lcv8iCnSKFfxYpLY8G7I8fKDYw7ih8xmP367ELDBW8jkQBr8Q8vAi
         zEdyyeWPDxlBKvfGki/BuSZCQjUZpG4grNQ/3jhZJCd3UcM4kN3Nsv9jYF24yMEsu+
         yTbKtMo+806yssBgG3WDlisk4ozpRwnIBvbZNhQHKVgOGo9ZNENGKH7SU9YHAfzT/v
         jJ8v+DSqvoSTw==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id x2so2359063vkx.13;
        Sun, 07 Apr 2019 02:21:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWCwuzA+RscA0V3ppUTBaAxphusFN6AMyJ7Xa0mzdo9Qn5bGZq9
        dVYUvUq/WX7lUC+GMSwfDHghlH+r26CWgarXBAk=
X-Google-Smtp-Source: APXvYqxF8Sv0WGwhfJ0IGf32pozV+TRZrr+cBBWrd9rUXgjOik/Y7Nm0tGTLZDu8N6NZPQ/b/fV7tROO0ZHXR8mk1fg=
X-Received: by 2002:a1f:1594:: with SMTP id 142mr12880958vkv.42.1554628916260;
 Sun, 07 Apr 2019 02:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <1553947458-8311-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553947458-8311-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Apr 2019 18:21:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATLHaS-i0D61+ZFP-4CsCeyf8qZsetofw8eyf=eaP3-tQ@mail.gmail.com>
Message-ID: <CAK7LNATLHaS-i0D61+ZFP-4CsCeyf8qZsetofw8eyf=eaP3-tQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] kbuild: pass $(MAKECMDGOALS) to sub-make as is
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 9:04 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Manipulating $(MAKECMDGOALS) for sub-make seems odd to me.
>
> [1] 'make O=foo sub-make' is turned into 'make O=foo', which builds
> the default targets. It would make sense to terminate the build with:
>
>   *** No rule to make target 'sub-make'.  Stop.
>
> [2] 'make O=foo defconfig _all' is turned into 'make O=foo defconfig',
> which changes the behavior.
>
> Let's pass $(MAKECMDGOALS) as is.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild.


>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 92ad066..9cbd367 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -168,7 +168,7 @@ $(filter-out _all sub-make $(lastword $(MAKEFILE_LIST)), $(MAKECMDGOALS)) _all:
>  sub-make:
>         $(Q)$(MAKE) \
>         $(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
> -       -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
> +       -f $(CURDIR)/Makefile $(MAKECMDGOALS)
>
>  endif # need-sub-make
>  endif # sub_make_done
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
