Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE2AC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B00208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhlEXyp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393630AbfIGAp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:45:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43075 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393085AbfIGApz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:45:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so4433698pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLV6sHHLSogvndUHIIN4vNngleTnd7sVbzQaekSuTUM=;
        b=UhlEXyp9ysrQLnEPNHjo5GwG9PQWmUrluralgZ6SLQWauqPTFv4+lUeQFhOrf4btOb
         Hv1j8PhlIW8E1beFDs2pIiIfxOsF9BRU8RUHfzEYKAfdLzGF2ZQUuMtSleQtDT64qz5d
         GXJd3tOxS3EdgObR9wcaon+uF1CZD5yLZ4X/a+2Tt73NYQGpbTJnczgIT/zUhrKyT5Hf
         FXz533/7ZrGBUj9hFUqBfV05YubGyHcjye4Al9iU0UBkoGOTLM1Ap7FuL5jwqNbZtYOp
         NCbkQ9UcUxPqpU8l/1xuNOZqzFJu6GyVhtwAiofXIb2vMR0aQYHqjZN1rPtf99eQHBsY
         6LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLV6sHHLSogvndUHIIN4vNngleTnd7sVbzQaekSuTUM=;
        b=e6EPWKapGWt+4tGw9zMNPUmqa/JsfmU6PEqWeNX+MizYmeh6Uq8c28CNZndba4dG2+
         GAIQyWX9uh5LBdHd9qn3eaSHiuauQH+52R+/8OxvrQy0v8aBfQOB8McoHAoFXvzDf1Cw
         S7yTTj2lhBDujcCH6XcOvmZP9py8PPwuPNno8FqIZX9v9Lwama7AuhNQGXvTcT5mc00y
         eVyY833HofGVk6RywyNZA7Ib/buU7Q/ZTh1C5YK32GUvLR5hd0kBk1ZWzwn0BQ8l8oDK
         GRR31qoH3r8/2JZn8vkC6zYZrP4M6U/diAI19ToTRa/CkqtAFhiuVPg+DtgndfCXjLOo
         KcxA==
X-Gm-Message-State: APjAAAUk/YTXOC99VFo5TqSf2/M7Eesir0I+RkPOyIzMOkrO/D9DmNGK
        aNrjlICHv9kdxdY1l6fJdwzNNnAt9X0Lv+nfZFIvYw==
X-Google-Smtp-Source: APXvYqxjFGZI2v48DqrORunVeUYCUkKiuHxRPy7CFjUVzmYJ1oPALwkyTGOYEGq18dshtS8MCz8+bifvWfHm5zo5d1s=
X-Received: by 2002:a65:690b:: with SMTP id s11mr10261014pgq.10.1567817154030;
 Fri, 06 Sep 2019 17:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
 <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
 <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
 <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com>
 <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com>
 <CAKwvOdmCBgKMLkXt29=vgvws_ek4XY3urMdfBUzbREH8Bj3uYA@mail.gmail.com> <CAHk-=whZ-ac4jm9zt=805xWsXaDAFWn2Bwn2PNtOBVx1vUmVvQ@mail.gmail.com>
In-Reply-To: <CAHk-=whZ-ac4jm9zt=805xWsXaDAFWn2Bwn2PNtOBVx1vUmVvQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Sep 2019 17:45:41 -0700
Message-ID: <CAKwvOdkWcB6jhqpr6p3LQkJOOt2si3i=bTGM11Poz8cZypS5EA@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@gmail.com>,
        Behan Webster <behanw@converseincode.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 5:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 6, 2019 at 5:07 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > So then Miguel should maybe split off a new branch, rebase to keep
> > just the relevant patch
> > (https://github.com/ojeda/linux/commit/c97e82b97f4bba00304905fe7965f923abd2d755),
> > and send a PR to you for inclusion in 5.3?
>
> Yes. With the appropriate test cycle

Sedat reported the issue and already tested/verified the fix.  How
long should it sit in -next before sending a PR for inclusion to 5.3
(as opposed to letting it ride out to 5.4)?

> , particularly obviously clang
> (which I don't test in my own minor tests).

It's the devil's compiler; wouldn't recommend.

In all seriousness, I'm missing giving an update at LPC this year
(have a much more important meeting:
https://ironmaiden.com/tours/legacy-of-the-beast-tour-2019-2019/usa-oakland-ca-oracle-arena-2019-09-10),
but I'm always happy to answer questions related to it or take a look
at bug reports.  Behan Webster is giving a talk about it at LPC
though!  Check it out if you're at LPC.
-- 
Thanks,
~Nick Desaulniers
