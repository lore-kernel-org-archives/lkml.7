Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C97C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FB72186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFSgST4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbfDRRpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:45:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41787 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389817AbfDRRpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:45:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id 64so2388510otb.8;
        Thu, 18 Apr 2019 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw1Q0whns+iQC063j+I9mS0wS9YVXaXRGzhwtWnzi9g=;
        b=GFSgST4QXJxSC4Nc5GEP2dN9knGtxEOO8y3GJxcTrB6xkdxdf2dPlvOKUP6bzNCFPP
         TnFBBh3HJNK/nNJjSCfqZJibYUT8KQCml87nyZ6eu5eTdUme5R1cyoipHLu3Uue+OHSL
         e7pmJK4KnIWyDOMl5jlEbEmfDJ3SwggD36NZ5THZlWnW+JcviCbCZJZlHgFFepyobyjP
         Z9u7fo1mTgDbkzB83iex5GRZRSdacb8g9h9RPOCPY70YM3tgFCboEYhUhiWMl7fqf9xs
         AU2tGHg2ib/TCzoeAqK18sqo93PLF1MgIEGpvq9zf6tbEeStGy0oW/1FkyugF/lCtuCr
         OOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw1Q0whns+iQC063j+I9mS0wS9YVXaXRGzhwtWnzi9g=;
        b=A8U255QGIr0XwoiWFt+DzjoNzMKWiOtZOgpinbhmIaRoJKTLb6IhH/Sv0QesUKfd41
         o+aC0SzioLg5iPMLz29l3RZecWW+U/ceNAhlMSHS71m3CHOeF5TnUx2ZC5imyYruVtwG
         0NdDf/oMD+tzWe5RIc1Trv6mMrVCATQAR0YppGyJ/9bKa6sZ8O/BU9G6chTa543zOCUY
         lMn7aDJblavOJmP3Mqf4OrtMNYUpyZGSCJN4JF84W1HyJGrDtYcDkSF/lV+Mb+sYUTcS
         e8j8Nt/kPgQZYB+eEnS/lGGrw91iV+8a3Ez8fiWuTE5VI3aNw0n3/W4r9a7/EdC/hA+5
         yDdQ==
X-Gm-Message-State: APjAAAUPvG3TJyaTP8TJVI3znkxdnLUn4ImmQQyo1JeTP0xXoayPgGZC
        TTR7Nm39A+wrbB6/ZbKTCLLK6TavVBhPHXd6Lww=
X-Google-Smtp-Source: APXvYqy0yDKMk1hoCFbGO/vpVcHdqjGp1hNdY1ZF7qhEUWRaicjVysMZ5zTBhMhEptnHyOm5U1bHMGPIn7Pk+9mDSA8=
X-Received: by 2002:a05:6830:185:: with SMTP id q5mr57726988ota.245.1555609501435;
 Thu, 18 Apr 2019 10:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155618.1369-1-TheSven73@gmail.com> <20190416155618.1369-3-TheSven73@gmail.com>
 <4aecef30-0d64-c5f7-c4de-43b0754e2fdd@metux.net> <CAGngYiX3QP25MLupsc-=gfb6CAh5wK49eGs2xqHh_5LxrKtaAA@mail.gmail.com>
 <34a70ef9-4bb2-98f6-2344-3a0482b5cb7f@metux.net> <CAGngYiUroMwErLugXeVXwHc37Nm+Bw4Tv5i1VUv8=qVcNbaSQQ@mail.gmail.com>
 <2630e582-cc4b-764e-9f20-f5a2905fa4ab@metux.net>
In-Reply-To: <2630e582-cc4b-764e-9f20-f5a2905fa4ab@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 18 Apr 2019 13:44:50 -0400
Message-ID: <CAGngYiUWnFeHLee5c1=E6gS1mZtL9ferzaTdm0txFaG2wVCxpg@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] anybus-s: support HMS Anybus-S bus
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:28 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> But: I'd rather call it it "iec61158" instead of fieldbus", as there're
> lots of different fieldbus types (eg. MVB has pretty different semantics
> than iec61158)
>

I agree that correct naming is very important.
In this case however, we can't let the perfect get in the way of the good.
This subsystem has a single user right now (me) and that can change
only if others can discover and understand it. And at this stage, simple
is best.

At this point we don't know yet where the API might possibly go.
It might evolve into something broader that includes IEC61158 as
just one aspect.

If and when we mature and get more users/stakeholders, we can then
look at changing to more specific naming. Definitely before coming out
of staging/.

Greg KH has accepted the v11 patch set, so at this stage we can make
changes only by circulating patches on the mailing list. Would you like
me to post patches for anybus-s documentation / making the
regulator optional? Or would you like to have a go at that yourself?

Sven
