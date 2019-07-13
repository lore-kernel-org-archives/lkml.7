Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C2CC31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 22:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6152064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 22:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="tMVaEtsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfGMW6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 18:58:47 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43408 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfGMW6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 18:58:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id o2so5386514uae.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C521pemh84hQDpPKGvZwcyDQbmvvEOy9KjEBffRDfy8=;
        b=tMVaEtsma6gM3qxAeq2DWlq9ccipMteWpzx1QSsbtJxp1KQsgpUK1O3Xm3rUL7U5d6
         7HIlcZjebo4lVO1eu7C9v7gvyXfkALLm01JlnyVN1tom+hEFpiwojkqysbG+gMY8eAFU
         19eHob+krzEh4d+U1Rt3N+ZUqIK0qMaXE6YwJAClmNlCZvYNRPxV/qsRQUnAPU3nqWd5
         tL6X3DfIXabcYmh0gJ8H2oOt2n0UMY5pkjVBuG/IN7GzDV502O1UVmZehdQQIDupVzto
         9in+iY7dMAO36YkrkXzPqfuQtXMBScjUQpLZBG7jDuXub8zkFyZa4zLDdSnd322Pjcq0
         8L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C521pemh84hQDpPKGvZwcyDQbmvvEOy9KjEBffRDfy8=;
        b=RRzrQY4b8iJ9Vn/7uWmQn4qPriMW29z2oh0fy/06Rcbb6gFo8tRlJlLBStTSSBoyQM
         WJyndHZGYFQiCz/NRTC285EgTUWNet14Q73vtWywkW1r/U9J+eoSyRAx3wuTY9F7qy9R
         Za9sTJkCnbGZhIjRnSHUKf2zo2AGBZX1osOLSVXO/r4I+k0vY9fcGzHt+UlkLtaeOFmj
         yFZdTuFMM72X2Ya5D1qO8VLm24nKkHLUgnM+Md8M1UeoBM/V6BxZEoJ384hOytNCWd1i
         RQbttMXJ+7PrsQSbLDrZV2oA/rOLHpkMpK2y/yhUq0Mnh/kfrVdapO4v1XBzr4srhZHy
         pz4g==
X-Gm-Message-State: APjAAAW7IR49A59TeigZAIwtLgEwhvQjx1o+C2Kse/iMYS5Ie7j6MiR7
        rVqHCqsSBY59OD9vvuXcTyJoo79Yt2Sg/z1+ZwU=
X-Google-Smtp-Source: APXvYqy9iyOxbGuuKGCYA7P9x4/jCssoGs1MvrDafxGacYP2yXkE8lKvX3eDFZmQr3u0yULaYS1miZoz7xW6gN4q6+4=
X-Received: by 2002:ab0:2a49:: with SMTP id p9mr12794749uar.0.1563058726092;
 Sat, 13 Jul 2019 15:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <59042b09-7651-be1d-347f-0dc4aa02a91b@gmx.co.uk>
 <5fe66d5d-0624-323f-3bf8-56134ca85eca@gmx.co.uk> <f47f8759-8113-812a-b17a-4be09665369e@gmx.co.uk>
 <2648434.ut0pN6mfR1@phil> <2d52b787-187c-5638-660c-33d51a07770c@gmx.co.uk>
In-Reply-To: <2d52b787-187c-5638-660c-33d51a07770c@gmx.co.uk>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 13 Jul 2019 19:58:38 -0300
Message-ID: <CAAEAJfAeZaT5wd4k8Lkf6T3G7LpK5LmOOG2ZbVJAQ6Xb7Wtdcw@mail.gmail.com>
Subject: Re: [REGRESSION] Xorg segfaults on Asus Chromebook CP101 with Linux
 v5.2 (was Asus C101P Chromeboot fails to boot with Linux 5.2)
To:     Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2019 at 13:43, Alex Dewar <alex.dewar@gmx.co.uk> wrote:
>
> On 13/07/2019 16:17, Heiko Stuebner wrote:
> > Hi,
> >
> > Am Samstag, 13. Juli 2019, 13:38:45 CEST schrieb Alex Dewar:
> >> I initially thought my machine was failing to boot entirely, but it
> >> turns out it was just failing to start the display manager. I managed to
> >> escape to a tty by hammering the keyboard a bit.
> >>
> >> I suspect the culprit is the rockchip_vpu driver (in staging/media),
> >> which has been renamed to hantro in this merge window. When I run startx
> >> from a terminal, X fails to start and Xorg segfaults (log here:
> >> http://users.sussex.ac.uk/~ad374/xorg.log). X seems to work without any
> >> issues in v5.1.
> >
> > 5.2 also has support for Panfrost (Mali-Midgard GPUs) but I'm not
> > sure if it already can support X11 yet and your X11 log mentions
> > libglamoregl in the segfault stack trace.
> >
> > Apart from it bisect that Greg suggested you could also just try
> > blacklisting either panfrost or vpu kernel modules
> > /etc/udev/somewhere . This would prevent them from loading
> >
> > Hope that helps
> > Heiko
> >
> >
>
> Hi Heiko,
>
> Thanks for this. I blacklisted the panfrost driver and X magically
> started working again.
>
> I'll try to do a bisect later to find the offending commit though.
>
> In related news, it also seems that the sound and wifi drivers aren't
> working either in 5.2 (although I need to do a bit more testing to
> confirm the latter).
>

Adding myself and Tomeu.

Perhaps we need to disable Panfrost from defconfig from now?

Regards,
Eze
