Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD00C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A22F2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="n+tBw8Lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbfHHNhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:37:15 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:31201 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733087AbfHHNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:37:15 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x78DbCt0005633
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 22:37:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x78DbCt0005633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565271433;
        bh=FJYlIOhi+obFN7K9ig4znA2ejjP8+DkG1RcRARqqczE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n+tBw8LkVYk4DCSVMdKsYwwTbdDsVMu/Kiq7Vo44lpFT6hw1WOlPP7hJdlWkrhAs9
         QlYNhr/ZNHCwz4Lo/8yS/8mRLEWGJjjjwO9IQYf6tJ6OzbSPfIbvqjb1uofB3Qbrwb
         PMBbIz72uxayNEVdeeoXpluzqlYTt0Rl78NjJIOPHhrXwa3iTFFDtcZeYoULOx9P0J
         rpB0mo3WIIfV/dr+Mh1cxJT2o6/6CNJryzHsh88LkYuid8jv+LAwU0TO3eoB1Jy9cf
         pJ/7AAgtlpxvtERxaplvZpZe3x4PpEFm2LAZWvCAfaxQB0ntQuangOxIifcsvQqBm+
         jPiyuod8eH9Vw==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id v18so36415562uad.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:37:12 -0700 (PDT)
X-Gm-Message-State: APjAAAWmD9k7Sih1CLEAVkCAf5IXPtqW+RjExikTvLBLW0PQnceQwqlf
        dYlNs4FPj6IygI0yCwycESCkig9D8u58GyCiLx8=
X-Google-Smtp-Source: APXvYqxomwoy5vLogosGkGVjS4qIT//rKhAvT75+AC92k5WYA6k4OpXl0nHPN6+2KwLFZ1r8pS8IKcOpxYyXTYj0ipI=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr9752668uaf.95.1565271431690;
 Thu, 08 Aug 2019 06:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARd_RVY9K6ZG0rvamuPizj8E2hfN35UROv++KYekDUcyw@mail.gmail.com>
 <20190808163306.092be501@canb.auug.org.au>
In-Reply-To: <20190808163306.092be501@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 8 Aug 2019 22:36:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNARipx_LD=2KPhWYGuij=iv7Vg9gcPwMuEfR-XH0_Fot9Q@mail.gmail.com>
Message-ID: <CAK7LNARipx_LD=2KPhWYGuij=iv7Vg9gcPwMuEfR-XH0_Fot9Q@mail.gmail.com>
Subject: Re: Please revert c4b230ac34ce for today's linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Aug 8, 2019 at 3:33 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Masahiro,
>
> On Thu, 8 Aug 2019 15:20:11 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >
> > I queued the following commit in linux-kbuild/fixes,
> > but it turned out to produce false-positive warnings for single-targets.
> >
> > commit c4b230ac34ce64bdd4006f5e0e9be880b8a4d0a5 (origin/fixes)
> > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Date:   Tue Aug 6 19:03:23 2019 +0900
> >
> >     kbuild: show hint if subdir-y/m is used to visit module Makefile
> >
> >
> > If it is not too late, could you revert it for today's linux-next ?
>
> Just caught me in time :-)  I have reverted it.

Thanks.

I fixed my branch now.
So, I hope it will be OK for tomorrow's linux-next (next-20190809)

-- 
Best Regards
Masahiro Yamada
