Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2462AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4B1206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5jUkgSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfGYJvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:51:25 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44981 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:51:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id v129so33299755vsb.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6wP9P6W628pwsNoz0uPS/Pivt4xDGduNsvhZDp9MnQ=;
        b=g5jUkgSwiAQTdPyxXYC99PohHjZpw4vN33ELhAaf74icYXeVey4yxZQ3J1D9b5IB2F
         ycK8QUxJ0zNpvlgqIY28nAv/RocTsY7uhvz5hRxUmi13/guskqWcnzQjwKz3DbC9v8hN
         Nao+IAQfBWkYy7dShadaiLuSTo/ftztKCuKG6xekV8a5Lx8qNhJd3E99p9OT6byBw0fs
         TGwIVD4KZ0Dc82it4goXoKZJxrSwDifF1jNiZSf6HUhPwTQ1LHENlddXNIgn4lUHZ6k+
         iyO1y+BwRYK+SpoaA7ofqf0E/5z1vqLTj9XMR7FlG+TQasdgaqDoJ5KxlqWpQP6x+ZoM
         S9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6wP9P6W628pwsNoz0uPS/Pivt4xDGduNsvhZDp9MnQ=;
        b=PQn+HC2E0MW6R7iDw0CL4UVDUBgN7FuuAlWj9WABufyaUKv6/s1RHJeV3Xtj8hjl5C
         q2FkF7uUwPkByWYbv2Vbio9tibfj66D+wrU1WjueylhSsQVDTX8AATxxtMXu1iEBoJm2
         JXROdLEZXec4UhBTf0pC5dG+LujedYHbUiU0NVuLeEQIrTS9AzWTilF14Hw7QUZxanZ7
         bmwpZZRhYN7X9QqMvazbb65HnfSJusGnN3H8uBxtMqthrmUT6Jkh9/xPQfRWdAqKK0Ch
         JIWw7RdhXYiyZtot6ZsvaPVWksXInVu3FVZK2ETEArZDrMESvPorRyFaGYUwUgPxwf2N
         +Cvg==
X-Gm-Message-State: APjAAAXgFwaABeHl7pL1fMG1FkqbghQHYh9EvB/vwFwDtYmMhspSLcsl
        /jWhHUxJRjao1Vy4rUDqkH1aoQDiVssAgcdWQQ==
X-Google-Smtp-Source: APXvYqydx09PFugR1+DQAAtY+36xMPy/hV8WYTgdDC1ltB5Cq8o2gndqs0x9JjppyF4d2kZnJDz5Ie7Z1Edt9DFa1zE=
X-Received: by 2002:a67:d46:: with SMTP id 67mr55814029vsn.181.1564048284438;
 Thu, 25 Jul 2019 02:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com>
 <alpine.DEB.2.21.1907241257240.1791@nanos.tec.linutronix.de>
 <CALjTZvZtu8sSycu2soSXCEP1yZiVNFKkxs4JY_puFahwFuuRcQ@mail.gmail.com>
 <alpine.DEB.2.21.1907250810530.1791@nanos.tec.linutronix.de>
 <CALjTZvb6aiUEgLN9BxOxBZCBXHoFxOx4TpBxkRQbZjgCna4WUA@mail.gmail.com> <alpine.DEB.2.21.1907251127430.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907251127430.1791@nanos.tec.linutronix.de>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 25 Jul 2019 10:51:13 +0100
Message-ID: <CALjTZvY6b3C4EnKCDfqN2HUje45sh0uojYRRuyO=Jiuzz8uauw@mail.gmail.com>
Subject: Re: [BUG] Linux 5.3-rc1: timer problem on x86-64 (Pentium D)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Thu, 25 Jul 2019 at 10:37, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Duh. Yes, this explains it nicely.
>
> > [    1.123548] clocksource: timekeeping watchdog on CPU1: Marking
> > clocksource 'tsc-early' as unstable because the skew is too large:
> > [    1.123552] clocksource:                       'hpet' wd_now: 33
> > wd_last: 33 mask: ffffffff
>
> The HPET counter check succeeded, but the early enable and the following
> reconfiguration confused it completely. So the HPET is not counting:
>
>         'hpet' wd_now: 33 wd_last: 33 mask: ffffffff
>
> Which is a full explanation for the boot fail because if the counter is not
> working then the HPET timer is not expiring and the early boot is waiting
> for HPET to fire forever.

Interesting. Thanks for the detailed explanation!

> That's consistent with the above. 5.3-rc1 unpatched would of course boot as
> well with hpet=disable now that we know the root cause.

I guess that's the only thing I hadn't tried, hindsight is 20/20. :)

> I'll write a changelog and route it to Linus for -rc2.
>
> Thanks a lot for debugging this and providing all the information!

My pleasure! I'm glad to have this old workhorse chugging along again.

Thanks,
Rui
