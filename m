Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D18C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AE82173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xBDKH6rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfEIHIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:08:35 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:19541 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfEIHIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:08:35 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4978VeH014122;
        Thu, 9 May 2019 16:08:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4978VeH014122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557385712;
        bh=0PXGM4BK4jSqcwrnNMFHPK9/6aXejRLVrTdCjlzhgjU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xBDKH6rhURPqD3T6WfiY1hOTULL238/if9EqvcN+7wkxjt4wztlbuAfuCG/mh7D5G
         GY7F3ehGGaaFaDE1QXz2EgZt9nPQlTd9i3LpQAI4xxjZCVWriHqzoaVkp9Wnfj0neO
         kL0NG1AgZRIVNn/Pj8u7smnDb5lLJ7x6K45osfeA32jwuDRow/qNwD24yRXtJ0slOv
         k+hFXQrzhVy7Gfcz3Jq699WEufA3g8H73afhbewUuVJYk8OjKJ7tnVSr+LsUHcaC/N
         9uFw5I2Bn24lqQz1zmWmajxlx8MQ6E4oe48tl2TYv7czLK4lUJV3ylnD6rDFCB82j/
         05jm0zIEZkLuA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id z17so417332uar.3;
        Thu, 09 May 2019 00:08:31 -0700 (PDT)
X-Gm-Message-State: APjAAAUOH2YQaL8lVUmQyYmu7MQFF2sGFREAC1O8bcLG/oQgJ99730qI
        Y2IXVY/w5/Ls9KqYOhkNjOBn1ztOg83mhXUjmhs=
X-Google-Smtp-Source: APXvYqyuWuezYXHGKR6yDqqcIT5AS6uKQtZ3SfsYBJiRXZ0khuwBsCpd4TiCOIGlG3PgK91XPq7CjUQuT6qu8NR5J8A=
X-Received: by 2002:ab0:2bd8:: with SMTP id s24mr1000432uar.121.1557385710510;
 Thu, 09 May 2019 00:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
 <20190424180223.253025-1-ndesaulniers@google.com> <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
 <CAKwvOdkpjwgt3pP9rjZtm=rEK9MhEfQdc6PEr91Bnb9tMVDBEA@mail.gmail.com>
 <CAK7LNASL+oNNbZ4YaPtGnwka06sRr3Pz8HjjM7oxUC-JkvqF2Q@mail.gmail.com> <fc61a1c2-5503-b18d-e178-491952e059f6@physik.fu-berlin.de>
In-Reply-To: <fc61a1c2-5503-b18d-e178-491952e059f6@physik.fu-berlin.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 May 2019 16:07:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATEizpakgj_UT4-OyUy8cs7C_kz8wEWDJAdoftfVK=uKw@mail.gmail.com>
Message-ID: <CAK7LNATEizpakgj_UT4-OyUy8cs7C_kz8wEWDJAdoftfVK=uKw@mail.gmail.com>
Subject: Re: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Lutomirski <luto@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 3:11 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> On 5/9/19 2:44 AM, Masahiro Yamada wrote:
> > On Thu, May 9, 2019 at 5:13 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >>
> >> bumping for review, as the merge window is now open.
> >
> >
> > sh is not very active these days.
>
> We're still supporting SH with an up-to-date kernel and userland in Debian, so
> if your patch broke something, we will notice that soonish. This also applies
> to ia64 and many other architectures.
>
> So, if in doubt, there are folks in Debian which can test your kernel patch
> if you fear that it breaks something.

Thanks for taking care of them in Debian.

I am talking about the sh sub-system in the kernel here.

SH patches occasionally fly around in LKML, but
the SH maintainers are not picking up them these days.

This one is trivial from the build system point of view.
So, I offer to apply it to my tree.

Thanks.




> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913



-- 
Best Regards
Masahiro Yamada
