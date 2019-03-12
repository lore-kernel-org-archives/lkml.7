Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AFDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4153214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfCLIos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:44:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38636 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:44:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id h132so1092889vsd.5;
        Tue, 12 Mar 2019 01:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYHhDPutvmRW/s4Gd5kvh+ag+8DUkGkrMyTX/zZ528U=;
        b=ioJ/EyDCWGWfirfmy+n92Ka9VgMPamXuPC/7EQ/i6M4oOPkK9smm05/xbJRoh5WaWV
         idIjtlRbEo8QIyIIZoATzr6vynoMh4BB1bNVbIcorr0Skey0Tdt6I+/WADsiM1VYFUkI
         QL8cFi3FIIGI84CNmoHt5luo7qqrUovCuBEmeJQkVfGWltD10uqq860mepBql2S146o8
         hTWit2oj4FJvg/4pGr/utmUZZgW3iYio0wMN5p9GTLNXNX5MmdZtCgTiHFjhVzkGWBVj
         Gb6xyBDcOWvEsajDfW5+ayQe71E63G9avYL7xBfeXmKv0TGd1fGS437I1TfQsY0lnyO5
         4NBg==
X-Gm-Message-State: APjAAAVkzIGDS735mV2RYxMRMlA/1bFnB46l9KB3BHaaKTI/NLk8Uisu
        UHn8ndJZ3wALX7sySr5pKYHQQv8GslbShYynmuKj6g==
X-Google-Smtp-Source: APXvYqzLuzfNCmbrcazvRI4ZsxYTz25X7Z4NR8xn99ABERz4UAk219Vc87Zwd+8iTok5ZV83UM/5HKd55zwzdeREARs=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr19461608vsp.166.1552380286385;
 Tue, 12 Mar 2019 01:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
 <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
 <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com>
 <yw1xa7i14btw.fsf@mansr.com> <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
 <yw1x5zsp473a.fsf@mansr.com> <CAHk-=wiU7xacTqDfm-x29-meyJWNd_X95K0T8FQMcDgy-yo3Qw@mail.gmail.com>
 <yw1x1s3d42ia.fsf@mansr.com> <CAK8P3a031d9mSOxVmCAGcrbdaCE8N3R4e2Smtxp-Z+cautTAvg@mail.gmail.com>
 <CAHk-=wj3v41CWH+3ry3+vrkjAEcyGojtevpsZDbiXVvpv1nTkA@mail.gmail.com>
In-Reply-To: <CAHk-=wj3v41CWH+3ry3+vrkjAEcyGojtevpsZDbiXVvpv1nTkA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 09:44:34 +0100
Message-ID: <CAMuHMdU76V=p8GLqVdChx+Sa_aPZ9BMCnnzmzWonqEq4Xe+LEQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Matt Turner <mattst88@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 11, 2019 at 2:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > The main historic use case I've heard of was running Netscape
> > Navigator on Alpha Linux, before there was an open source version.
> > Doing this today to connect to the open internet is probably
> > a bit pointless, but there may be other use cases.
>
> The _really_ main version was that I decided to make my life easier
> for the initial alpha port by trying to run basic (tested) OSF/1
> binaries directly.
>
> Netscape may have been one of the binaries people actually ended up
> using, but it's probably not a reason any more, since the internet has
> moved past that anyway.

Yeah, the alphas on the server side, powering AltaVista, are also long
gone...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
