Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B31C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EDB21855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aygQDYI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfCNSii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:38:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44536 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfCNSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:38:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id n18so3794160ljg.11;
        Thu, 14 Mar 2019 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+gQBiVflYsd+bovfxrF0mnBQAXyra2Y1EbBe8xHSvA=;
        b=aygQDYI9FcLewv5oySMNO+nToTCVV+AcmaAzqNPUxFj6DVt7q9uggshhh9q6jCVNSs
         SObnxDrEgV5HGmsTV9/U41JzR9xVQTT9OsgL8GDA5EnqVkszIFVDltraOHjPzcK8GYv/
         qM1JwL24ce3eLgf4Oi6R2+ii5BG8kFjNUKX0z53gEAw5Y6GiZ8bHwoE25qncydGV9Uh6
         3yGEZpu5u+6eTHRIHRFKpRlw0bPEDkZI+ZbYlWkOMlrRmFbyttsR0KiwKaUycGvipbaI
         4eSblrO0Xe+Hrmcl3EWTM3bpKYpNjZYFT6rSD+RLyfeHqH/cPBTeZxlhehwFRdrmOHJk
         47xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+gQBiVflYsd+bovfxrF0mnBQAXyra2Y1EbBe8xHSvA=;
        b=e/tZ1Om3d4wlGrA0TKxGQs+ZZO/Mo6amVIX+Ddzs8Yq+nNKgUEDRNYjWRQ+3EMZemi
         jSYuihYTaZ73S+uEqTTrgjaPGbRcDO/WEA5Wrlc/MiJE6ot4YKWt2OqHXjjIN5AFHxBA
         PICPy8oAWnjzBG4GQhSEvNBwR4yurieF9uCbyxQy2WDdO2dSIL//zt5SAlCLN/0tK00X
         pBS2yuAakphRFN+KnI0KU7gipQIlcbZ0iIFPDKAZkCEUe3kKYCcjrswB1hkjU1+g0lt/
         JUa3jTXaJKOozaHMLE6pVzP1QMeibHSCxKUoI0cTUFkYFs/X16XY8CX5TsZunqhPk+nM
         V9ig==
X-Gm-Message-State: APjAAAXS9JfCN8JKv9uMAWmtlIQmxF6Lcg1jj7ZsU3JIJKlxCyEg4JWc
        yOS0Dl3veSxAa3dgIkcqh2MzCBWBAUfCvKcGJ4Y=
X-Google-Smtp-Source: APXvYqwoIA9+oFdNRl5vGcdsCEzjcw26PKAmV+VPivP8mn6sjaVwVmuqwu5+x4YtD9tL+MP2yDUtjNB0IBwc8o3APfQ=
X-Received: by 2002:a2e:21d1:: with SMTP id h78mr24267925lji.49.1552588714628;
 Thu, 14 Mar 2019 11:38:34 -0700 (PDT)
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
 <CAHk-=wj3v41CWH+3ry3+vrkjAEcyGojtevpsZDbiXVvpv1nTkA@mail.gmail.com> <CAMuHMdU76V=p8GLqVdChx+Sa_aPZ9BMCnnzmzWonqEq4Xe+LEQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU76V=p8GLqVdChx+Sa_aPZ9BMCnnzmzWonqEq4Xe+LEQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 14 Mar 2019 19:38:23 +0100
Message-ID: <CANiq72=Hvvw7QCKMquWmefKz1OLUrYoDZUHRT2XKUEwTfsLv4Q@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Tue, Mar 12, 2019 at 9:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Yeah, the alphas on the server side, powering AltaVista, are also long
> gone...

As usual with these things, people can still use older Linux releases
for a very long time. If they really need it (e.g. commercially), they
have the reference code and can bring it up to speed again relatively
easily. It is not as if they have no way to submit it back again.

Cheers,
Miguel
