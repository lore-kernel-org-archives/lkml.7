Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1BBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B3020882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIxYoi8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDCCg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:36:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44686 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDCCgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:36:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id i21so12281793oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yclw0WY4SjlZ13NhfTcy8gAGVQqxZafa6XnGdXkfYEI=;
        b=ZIxYoi8RF212CiSbiX/gsfNkaI/Zle1KnDJOW7VOaX5H3OK/+IVYDeMPVQRTCU/zW/
         AsPo7cXv/yRe12CBgTWFyPHOdN3WG+qjYFq0sUgmrrEifhlXH27MiLLBRRK3JyFcvBPZ
         tE9eEMNZSJYXAbR91CwqQxcxLz9QDCMOualugTqRXjAIGELgqpMxJbZx5uiIl+DT2BMa
         wdoCday1C1c8tp/Ws5I11cGWzNz9KEdVZXCklDWZw8WqbZ6Ytq+mxP4OaCaeiawj+vVc
         kYoQ/M6G5ngOqNt1xqHEdpyI98by9LqEIgS/Sj3jyUJdosThB5K/aHhXhF06Rvm3KJBk
         fgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yclw0WY4SjlZ13NhfTcy8gAGVQqxZafa6XnGdXkfYEI=;
        b=oocfKuyGtfOqh2HX1v+Hlsf4J7g8pftMEsat5Vrj+KKeJWpPQylXaeKoV8gMGYnrEi
         vjYQvi5QthTrnP7/Tujb4iLlvL1uR14p1L8OeNFeK7wGIdT7jOjfFLhknndex5D0SgVs
         bWKNE06D/3KKv7QKYiNLOxsHiDFnfXbf/N85U7DqOF8QXTmQ/yPeSfaq/uWkVCdRBdnJ
         c4gniLN4/0r6vywoTYMmeI4S6TU41d4yYnsLSeu//RTkeKdA97y5K5H8BBqXfk83c120
         rX09rzRDZ4fDzKmMvyGJm7t8q2KmdAzjLDsOJlLJ42BZPN+bY7LAF4jIbmKY7qNVXCok
         dRAw==
X-Gm-Message-State: APjAAAV2cCGP+BjUxkVQ2AwgobZVrd+i/0Tl1UJdH81kroTBnsgFpuSL
        a+ITlgnAtUnhhNgJefeYHj4B7Dno6nUQOcwizHg=
X-Google-Smtp-Source: APXvYqzPcf/SYSi07UcRbKXT08OUGeMUgqwwte0rzaaMuyDch2fFZzI7SNUbZ9VoQfY0P5PTs0rqyJnijAMonuR3LEc=
X-Received: by 2002:aca:f1d4:: with SMTP id p203mr166219oih.154.1554259013877;
 Tue, 02 Apr 2019 19:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <1437124312-44700-1-git-send-email-b18965@freescale.com>
 <20151027081834.GB1425@svinekod> <DB3PR04MB07407D83CC5F8F5F19A7207F4FB0@DB3PR04MB074.eurprd04.prod.outlook.com>
 <4875455.lvoc6XpkZc@wuerfel> <alpine.DEB.2.11.1512291449380.28591@nanos>
 <20160102102955.GP8644@n2100.arm.linux.org.uk> <alpine.DEB.2.11.1601051039320.3689@nanos>
In-Reply-To: <alpine.DEB.2.11.1601051039320.3689@nanos>
From:   Yang Li <pku.leo@gmail.com>
Date:   Tue, 2 Apr 2019 21:36:42 -0500
Message-ID: <CADRPPNTHyMUQ80EEB3dSOfWM2q4+HpPVKNVW9bnvXJV3rQuwrA@mail.gmail.com>
Subject: Re: [PATCH] arm: kernel: utilize hrtimer based broadcast
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huan Wang <alison.wang@freescale.com>,
        Huan Wang <alison.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2016 at 3:46 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 2 Jan 2016, Russell King - ARM Linux wrote:
> > On Tue, Dec 29, 2015 at 02:54:10PM +0100, Thomas Gleixner wrote:
> > > I have no real opinion about that patch. It does no harm to unconditionally
> > > setup the hrtimer based broadcast even if it's never used.
> > >
> > > Up to the arch maintainer to decide.
> >
> > That's really not fair to keep shovelling these kinds of decisions onto
> > architecture maintainers without any kind of explanation about how an
> > architecture maintainer should make such a decision.
> >
> > Do I roll a 6-face dice, and if it gives an odd number, I apply this
> > patch, otherwise I reject it?
> >
> > Is there a technical basis for making the decision?  If so, please
> > explain what the technical arguments are against having or not having
> > this change.
>
> The hrtimer based broadcast device is used when you have per cpu timers which
> stop in deeper power states, but you have no other timer hardware on the chip
> which can backup the per cpu timer in deep power states. The trick is that it
> emulates a timer hardware via a hrtimer and then tells the cpu idle code not
> to go into deep power states on the cpu which owns that hrtimer. All other
> cpus can go as deep as they want and still get woken up.
>
> The only downside of adding this unconditionally is extra code in case that it
> is not needed on a particular platform.
>
> Hope that helps.

Hi Russell,

This has been pending for so long time.  I assume this is an ack from
Thomas.  And given the same thing has been added for arm64 and powerpc
architecture, can you also merge this for ARM?


Regards,
Leo
