Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B74C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAA120724
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNNWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:22:25 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:22:25 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MTiDV-1iIpxy2h3N-00U07p for <linux-kernel@vger.kernel.org>; Thu, 14 Nov
 2019 14:22:23 +0100
Received: by mail-qk1-f182.google.com with SMTP id z16so4915008qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:22:23 -0800 (PST)
X-Gm-Message-State: APjAAAVqC1ouxnZnMA+zA6nadCb6gTLqIRSvDTD2mSsQ4ByhMup/d5vj
        jXgHPdg+xTyuxLJsSz6AL+vVZxnwl0Mkd/C8inA=
X-Google-Smtp-Source: APXvYqxkA653TpKbCOAo1OlXn8jz4vIqRdu+4eROsKb0/kmqznIrTiegFm4QccKPaGRs8v/9JhgDx15SS8QhNIuD05U=
X-Received: by 2002:a37:44d:: with SMTP id 74mr7154394qke.3.1573737742525;
 Thu, 14 Nov 2019 05:22:22 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007ce85705974c50e5@google.com> <alpine.DEB.2.21.1911141210410.2507@nanos.tec.linutronix.de>
 <CACT4Y+aBLAWOQn4Mosd2Ymvmpbg9E2Lk7PhuziiL8fzM7LT-6g@mail.gmail.com> <CACT4Y+ap9wFaOq-3WhO3-QnW7dCFWArvozQHKxBcmzR3wppvFQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ap9wFaOq-3WhO3-QnW7dCFWArvozQHKxBcmzR3wppvFQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Nov 2019 14:22:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ybsTEgBd_oOeReTppO=mDBu+6rGufA8Lf+UGK+SgA-A@mail.gmail.com>
Message-ID: <CAK8P3a1ybsTEgBd_oOeReTppO=mDBu+6rGufA8Lf+UGK+SgA-A@mail.gmail.com>
Subject: Re: linux-next boot error: general protection fault in __x64_sys_settimeofday
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zUnzouuFyq0aeWgijQjTK2KBVoDRAotH/EGrgzUJ3bOWykx88Jr
 Q1Hd83bA+vg+dKo9Njj5bdeKdRt6/k0/3i8IDxW40ge0wvNJLO9Ut430WcB1gMgX64384zj
 gpoGqE/jzS0n3qaM3bxn1Zx4NwHQlYOiZi141V10v8z+hSeoHom9nAzJsKYJ5JRitDjFelZ
 4y6i/t14fwW7NiOmVbbPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wXl9+c9dfLo=:9e/4TQCIYe+7g0RKo4mck2
 yf2Lgx1+mEr9GIsfFNBwZnD0Qj07cPwx9pgfsnkyB/AkXFNhqj5w/S/ZNLdWUWxfiyPIBm7mn
 +nj5PsRfXPRasLydESMzlgmZJnM3wkAXy5hI2nCKw2x+F8NNCD47PUL7fPpEfbfPLdqyYDvy8
 56v1yGoV7S5HFMrZxktyzxJRJS/9UI8ZmQfOwX4+7PrXsJlweqr4Sc2WzzarRqry0HDbzQHVw
 tr4po22Slb/R1ThOgdkaJm27KseBdJQk6aFhF/RIRhWYfmgiJGOuUNwZIRoahfOKxy6HTlcJc
 X+hQWRBq83F5IWAsHoStJzcoifPc6oZa6D8YmJXq6ikG/UOWTwPIvsJ3oL6cRL6puZJioG+zh
 6ZqGgszGU/kVUP7Rjvbq/SMTCP+gbcAKBddhQ+UTGJRF3Bl6+TWtfXQn8y4AJRSr9kCZBN9/V
 Le7YRjwcdi46rfscIh3y7Y1uyYzsoKDkh/Ls8W+eqmHrHauZaZvsH5Lj93GKRl3/pajpFVwAD
 6mgYlf34NjCT3DhOVpo9KI/1QygH5ClBaCaaOBhqbPkBNrT+9M32+s6SkXGi4++6sd8KZNp9T
 9IDbgW4G/Y2kPoOoci9XRrIf7C8XExBobOR/DucZJkk2uG73WEHgaPrlRxsSkBRH+H1rK+1l5
 30kH6UF4I9L0wQInq6TiCaG8lz9hTmhtBOCbS4nWzjEk2Z8XXb33tPbchFqrm9kJiiHuve1GH
 lQI2R04jOon7civjvRC97DqzXCSBiibqIbWd1XPPJl35BPXoE3csazMr0aVe1HRSQ639OmuVm
 BrsUnmaoMr6h10AMy4GUfmixQeMaH6QRTIaoMKzCoMTVUTJq57Ij+grgHrOHTpbk0ig8Ye3Ib
 hSqut7wNykyISSAIWi+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 1:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Nov 14, 2019 at 1:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Nov 14, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Thu, 14 Nov 2019, syzbot wrote:
> > >
> > > From the full console output:

> >
> > Urgently need +Jann's patch to better explain these things!
>
> +Arnd, this does not look right:
>
> commit adde74306a4b05c04dc51f31a08240faf6e97aa9
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Wed Aug 15 20:04:11 2018 +0200
>
>     y2038: time: avoid timespec usage in settimeofday()
> ...
>
> -               if (!timeval_valid(&user_tv))
> +               if (tv->tv_usec > USEC_PER_SEC)
>                         return -EINVAL;

Thanks for the report!

I was checking the wrong variable, fixed now,
should push it out to my y2038 branch in a bit.

      Arnd
