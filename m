Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60627C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D1B2184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfGCR63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:58:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46088 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:58:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so2571318qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBoVgDxevh+0orMCb2YPrkAIPpPXPXsDVuRye2tAk2k=;
        b=JqBymbZ2ZSZJ2JEw+CakS7jx1ajjZVfe0vlD3ymPwoCjZWU4RxOeyHqiX/iWCENRuQ
         n6DalD7Fqkm7xdZ7CQ8xwTmBLAA7hA8RPfQzn6NV/cYE6ICPb7UODDhnSKAsApjYt+oC
         J4l+4ypl2OUpbjWDdVy32RlMhGL0eyMNdsy7LNhBxmloodV1hjgwXxPY832bNmiSUpcs
         IlWm5NpTisJfs9eQUyHjL65D8hC/cAxUroQCF4qDiLXh/lpUraNeRbQ4n6O4uhEoN/n7
         u36new3kmR2CTWLxyWNDCLmhbOY2hHLeV7pyjMZmaqk/CqvD6mcrQDKUFyoPVAS4FGTd
         867g==
X-Gm-Message-State: APjAAAX16bQdo5qkg40C8HPvbLwp/jdlSzIOcTq9D0wQVroGn+frgVJk
        Hw/T67DCN+2aXQ8XQ/4HFPKHeUGounbCd3kl9r8=
X-Google-Smtp-Source: APXvYqxf8mmbpvC31jKkb8dNVoAULaDG6q3i0PfGuKmnoUA7EPFs/+lF1YWPl9jqzm58WQs2s/8ws2mh2h1uXrUftwc=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr30964672qtn.304.1562176708215;
 Wed, 03 Jul 2019 10:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190703153112.2767411-1-arnd@arndb.de> <20190703165919.GC118075@archlinux-epyc>
In-Reply-To: <20190703165919.GC118075@archlinux-epyc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jul 2019 19:58:08 +0200
Message-ID: <CAK8P3a098AZfkz0bxfgN_XXk7QSQYi1V-EEmqLjQPjzR7986aA@mail.gmail.com>
Subject: Re: [PATCH] soc: rockchip: work around clang warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 6:59 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Wed, Jul 03, 2019 at 05:30:59PM +0200, Arnd Bergmann wrote:
> > clang emits a warning about a negative shift count for an
> > unused part of a conditional constant expression:
> >
> > drivers/soc/rockchip/pm_domains.c:795:21: error: shift count is negative [-Werror,-Wshift-count-negative]
> >         [RK3328_PD_VIO]         = DOMAIN_RK3328(-1, 8, 8, false),
> >                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/soc/rockchip/pm_domains.c:129:2: note: expanded from macro 'DOMAIN_RK3328'
> >         DOMAIN_M(pwr, pwr, req, (req) + 10, req, wakeup)
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/soc/rockchip/pm_domains.c:105:33: note: expanded from macro 'DOMAIN_M'
> >         .status_mask = (status >= 0) ? BIT(status) : 0, \
> >                                        ^~~~~~~~~~~
> > include/linux/bits.h:6:24: note: expanded from macro 'BIT'
> >
> > This is a bug in clang that will be fixed in the future, but in order
> > to build cleanly with clang-8, it would be helpful to shut up this
> > warning. This file is the only instance reported by kernelci at the
> > moment.
> >
> > The best solution I could come up with is to move the BIT() usage
> > out of the macro into the instantiation, so we can avoid using
> > BIT(-1).
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Nick recently mentioned that Nathan was working on a fix on the clang
> side. It might be worth holding off on this to see if it can make it
> into LLVM 9, which will branch in about two weeks and be released at
> the end of August (according to llvm.org).

I think fixing it in llvm is a good idea regardless of the workaround.
My main goal for the workaround is to get a clean kernelci build
again, and it will probably take a little while to move that to a fixed
clang-9 build (release or prerelease).

> I don't feel strongly about it though so if this is going in:
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks!

      Arnd
