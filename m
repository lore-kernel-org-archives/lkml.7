Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7BAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A59D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0ZSDOz+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfLJQxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:53:23 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38364 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfLJQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:53:23 -0500
Received: by mail-io1-f67.google.com with SMTP id v3so2491990ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gYiw7Di0NzOtWzD6VlwkxgMTcpehHxWtxE56qXMIQik=;
        b=0ZSDOz+jqxDq45OnzMAp19tLaQXqTC1vgRseomiLX624e9Be4V3Y1BgfkwlE1IcepU
         nEUY/kBt7pmAhX6fMSbplrmijdbaQZwRKpE6V9X5XhaLXHM5CqgezIHO+i2icjJeI6CC
         Riwbd7e1DdwskveonwHKGEfHJG8YZHI+K6j2zOllQgmOQFXX1CEKNvbUU+1IDW0XsJxJ
         SIkqWiIY99L0/08ebscUt1rLYZl1cipwjH/F+of5umb60gPJwP1yOUz7DTZ9OpGHbes2
         dlqf8BRnq3IjDLbCmu6HwR1bZjSUxKXokMLZX1xiXRjqyFPZlZWvxlj9f+BzWb3BWLdy
         KKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gYiw7Di0NzOtWzD6VlwkxgMTcpehHxWtxE56qXMIQik=;
        b=RRC9wnHPM4ZNmdb+Ms37rToD2QGw5+spOziFET357JwjfvmeVjlwaFXdDGGvR8Dkq2
         RMAVggwBLQGqwJqg8GNXmhgd6CfqQ2rkvpYwW2+PKo0WISZ8WTSdyHPXJsdRSUt+s9/J
         rotWC19zMVqIkLWW3zs0xp8hT8D71IB3S5vUgVBmkVvV885xSW7PePXUoilJRAaTiRrK
         5cr90j6X4sith/0MbpvRloA39SDw6kktGiguMfDaWYgtYcLwU6Lclmb+qQzUXcYJCEvZ
         UvPVg3jrT8k0cvkOUWrX59fNE5K9m3pscnRhl32uIrREjmGx2e7SvIL37o8b9E74hV4t
         1HmA==
X-Gm-Message-State: APjAAAUozasUOFhtHphZwc/PTgNJnQrC9LYrKzCHLM/FtzqxDc36ZFlb
        8QosNlKcz0vrorS5EWj0WsfjpAPcyEuigGKbUyLPlh/0
X-Google-Smtp-Source: APXvYqzD3/7yu3i7NF4FeOXdISVRpUtpIAG4//6U5YvJx0I2tLW04uyw9hxoMEeHivorX/h7q5kwP2YBuHD8jV5+rU8=
X-Received: by 2002:a05:6602:2352:: with SMTP id r18mr25233661iot.220.1575996802119;
 Tue, 10 Dec 2019 08:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20191210100725.11005-1-brgl@bgdev.pl> <20191210121227.GB6110@sirena.org.uk>
 <CAMRc=MftOnQVAUjOz=UGV-S2HKPpiucQp98xYTdxgt7d8obCMg@mail.gmail.com>
 <20191210130244.GE6110@sirena.org.uk> <CAMRc=MenTgffszv4NsbCKRhH0TcRPSTLbeP3BttW9fmFBjLdCA@mail.gmail.com>
 <20191210132136.GG6110@sirena.org.uk>
In-Reply-To: <20191210132136.GG6110@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Dec 2019 17:53:11 +0100
Message-ID: <CAMRc=MfUSJeNur3VpA7_=kSDpk1L83cK1+Tke3MPBZwfG9NubA@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: add of_match table
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 14:21 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Tue, Dec 10, 2019 at 02:10:15PM +0100, Bartosz Golaszewski wrote:
> > wt., 10 gru 2019 o 14:02 Mark Brown <broonie@kernel.org> napisa=C5=82(a=
):
>
> > > This seems to work fine for other drivers and the platform bus has to=
 be
> > > usable on systems that don't use DT so that doesn't sound right.  Whi=
ch
> > > MODULE_ALIAS() are you using exactly?
>
> > MODULE_ALIAS("platform:max77650-regulator");
>
> Huh, that should work...  I wonder if adding a compatible to the DT has
> messed it up, does it work without the compatible in the .dts (and with
> the of_compatible removed from the MFD driver I guess)?
>

It does work when removing the compatible strings.

> > > > Besides: the DT bindings define the compatible for sub-nodes alread=
y.
> > > > We should probably conform to that.
>
> > > I would say that's a mistake and should be fixed, this particular way=
 of
> > > loading the regulators is a Linux implementation detail.
>
> > Fixed by removing this from the bindings?
>
> Yeah.  Though it may be too late, shame I didn't catch this when it was
> merged :(

Yeah, I didn't know any better too.

Rob: the bindings for this were released some time ago and they define
compatible strings for MFD sub-nodes, but using compatible strings for
sub-nodes is apparently incorrect and the drivers don't support it
either. Can we remove them from the bindings?

Best regards,
Bartosz Golaszewski
