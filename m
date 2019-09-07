Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC9C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 05:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2078621670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 05:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDJPAvy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394449AbfIGFuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 01:50:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46639 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394351AbfIGFuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 01:50:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so8571382wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rAHu/cSAYCVs27fp3q0UmPkjyf2rH/LgmFmZg+hAKyM=;
        b=BDJPAvy+0nDI9ZIOq2mVYJrFX0QCi6OJvS0BYFAyzpg9nxVc6vvXACHJQR4ZtkbBI8
         ec58qA7asMSTFwHOe9xtWLgcGm0gxrFJkt21XMlGtfyX/1mc8wk6KMQUseggqkeXehkL
         LEGmHnvQBKpwoIEuvvSJTh+vSAZGjkkNof/UPcpV4wlSj+cuQfuThBhKhQGLaW1wHWRW
         ixt3bxwEURROxVz6nDHMVwN2f6yguBfvR8BrxygwvY+YAsAhyKd3CYtT7wdAgkxySy6o
         zpvKBYIHIBo1c+oMnjNZPu2wOdo6Ji01zOR+dZHrAg4uVweDZvKBrJbmR+dAXS9ktrhA
         4srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rAHu/cSAYCVs27fp3q0UmPkjyf2rH/LgmFmZg+hAKyM=;
        b=MjTta7gc2ggI5n+ECfQ/sxExRF9s6KGJjFuBIDxedcLg+kd08LDztyM4yr8EYZyL92
         2XIKHy1ejOWwJ1bdi03jYwNQo9ozq+BV9pltyCXk4hzPlmwyoEq9Ioo2Zx29Lha1Hf9Z
         ym0UTlQtNAkmqdCyzVBFdZU8gY1t2QD+z23jWXVJqayl/7odjX6LaDyKWeqP/ZeYsOY2
         rHzqG5aT/N09C5wBJxNqBjrv6h+v2AQGOIXxwcT7/Of01WKyJWSa3DKuGtcEiy7VX6if
         WdpIfoZ7w9vgpMbsy8y5t5cEyEcWg7Zg02tXLc0rUxXMCfQPLtM6gMU6AuZ6VQ/deqMk
         xQWg==
X-Gm-Message-State: APjAAAUmM9G2tOvn3MOndcLeOvsvbC8Mq1qUPggnh2NEi/t6SNO+enaA
        ZIbhvnyT5fccjXTZTEMI9DoL/RdHADNbDFp5J7c=
X-Google-Smtp-Source: APXvYqyBSWvYprvDU2ClDBrDU+yqGRK8FU/KXz8KkeFblKtdyVpezCMhX+PqWb+OBYgHK8cMEk5wkdWWJdQZc0O3OuI=
X-Received: by 2002:adf:e390:: with SMTP id e16mr10418212wrm.29.1567835405086;
 Fri, 06 Sep 2019 22:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
 <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
 <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
 <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com>
 <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com>
 <CAKwvOdmCBgKMLkXt29=vgvws_ek4XY3urMdfBUzbREH8Bj3uYA@mail.gmail.com>
 <CAHk-=whZ-ac4jm9zt=805xWsXaDAFWn2Bwn2PNtOBVx1vUmVvQ@mail.gmail.com>
 <CAKwvOdkWcB6jhqpr6p3LQkJOOt2si3i=bTGM11Poz8cZypS5EA@mail.gmail.com> <CAHk-=wiyxKDMW2fPumh2WyP3tP1BHpispjGfTWQ-we8keZ=q7Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiyxKDMW2fPumh2WyP3tP1BHpispjGfTWQ-we8keZ=q7Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 7 Sep 2019 07:52:21 +0000
Message-ID: <CA+icZUVNATrXZ7SDTrKa10cK8xtrRiC6VeXjkP6e9WyeKstMnA@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@gmail.com>,
        Behan Webster <behanw@converseincode.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 12:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 6, 2019 at 5:45 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > > Yes. With the appropriate test cycle
> >
> > Sedat reported the issue and already tested/verified the fix.  How
> > long should it sit in -next before sending a PR for inclusion to 5.3
> > (as opposed to letting it ride out to 5.4)?
>
> If the original patch was already in -next, I wouldn't worry about it,
> as long as you do enough local testing that there's nothing stupid
> going on.
>

I am the original reporter and tester of the ClangBuiltLinux issue
#619 and highly appreciate to have the single fix in Linux v5.3 final.

The compiler-attribute patchset sit for some weeks in linux-next, so I
have not seen any complains.

What I still prefer is to re-integrate the arm64 and sh arch related
patches which went through maintainer's trees in linux-next.
AFAICS some massage of the commit messages were missing, too.

devil's OMG dileks used compiler and linker: LLVM/Clang and LLD v9.0.0-rc3

> The -next cycle is a few days, and even with an rc8 we're getting
> close enough to release that I'd rather get it earlier than later.  So
> I'd rather get a pull request this weekend than then have to deal with
> it when traveling next week.
>

+1 for ASAPISSIMO

Thanks for taking care.

- Sedat -
