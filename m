Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED377C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00420872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZyKAFXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfDQORY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:17:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38034 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbfDQORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:17:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id a6so20135412oie.5;
        Wed, 17 Apr 2019 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNKutiGN1xSSlBhn3jAZrB43LklhOxjyhSkjry6Dbqo=;
        b=DZyKAFXAEPEZTXZA+O+/qClgT85ElVZImMwleBG1Anxk0btUiyAAYI2vyO20TBkaKF
         CyhlxtaHTTwzzisq0nz4EpE8GyLLNG72459g80leQHnmyzVOdXVrXAg7f9sM7AlpfYX+
         go9c9Or1yhKNnjOllOsz94ZU7HqM6BSjhkMGk59PS6c7H4RvC7P82J27hWNXSv5lIum0
         TKnvHRlWxUAaS86nHoXJV1oRHj/CPRlawM9r8zLocYS2V99ZjjgIj0yCBEUaNWsz8Khl
         XV526jQqnS7WqWRLam9QQ09RsGdytLRcDn3sxGtyOW1e1N/zeBCn/4YXwnKgJHYJ98hN
         m1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNKutiGN1xSSlBhn3jAZrB43LklhOxjyhSkjry6Dbqo=;
        b=gk7vm4OoUSwKnwJ4yzSAPb1LLPV2Wuudi9XzR0046+ckLPWqZqNW9L4RCUzuEFzFU8
         2OBN7mdVnJKZhqxfskrUXWF43kE5Td304kCMmoTc16gwhVzPZEKtGf3IIz9A2xfmggbj
         4rGU7v57hStVcBixcikXdLYbzaoVLa7HqfJ1Y9+/eCoxzB3omb2fkOqaKk+kWuHL/Xao
         yK5o5K2sVrPap9BSd5XeY7vEGP+DYBD0od3xayyqSKSo8MpcHyoOVjY6WeDcG/X6bLUf
         2oahquX0+oh2oFftfw5Kg6yiGzi4EcG5d77ZR3qwib7Gh+oA00mqoaN3liL/flZ00k2M
         1eZw==
X-Gm-Message-State: APjAAAXbrqo3oSA/epm4Y9deN1jKTfspYFYC6XDGrOW3qmtdf4Mh/Be0
        gHjdeTBbVvG49EDUtTYEifUXH0NHgs1kKkJJO3A=
X-Google-Smtp-Source: APXvYqzcJbnFX1yDJ/tJxhE4kEL/IWin8EYm40aaFtftVgnKOGhF1In3WWHUw/NEGsQHyljrywvvQHqFbx/IAZDQMco=
X-Received: by 2002:aca:4202:: with SMTP id p2mr25359548oia.169.1555510642767;
 Wed, 17 Apr 2019 07:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155618.1369-1-TheSven73@gmail.com> <20190416155618.1369-4-TheSven73@gmail.com>
 <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net> <CAGngYiXZSaUwrCiqavMGDRb5Vuo2x8fTjDetT00PAjjtrYW+NA@mail.gmail.com>
 <bd36b798-d129-c81a-ab2d-22a5b46567f6@metux.net> <CAGngYiUaUoRUAiGUGbJEWGRj0bszeSsDDBfZMwoWokQRrMUhfA@mail.gmail.com>
 <3103f45a-facf-89a3-8a36-84507c570909@metux.net>
In-Reply-To: <3103f45a-facf-89a3-8a36-84507c570909@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 17 Apr 2019 10:17:11 -0400
Message-ID: <CAGngYiXd34hTriDsKvhOWogaF0uLfVbUn5BzJc3cUnZcWpFXAg@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] anybus-s: support the Arcx anybus controller
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Wed, Apr 17, 2019 at 4:41 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> hmm, I think the main question here is clean separation between
> subsystems - devices that span multiple subsystems, IMHO, fall
> into the category "mfd".
>

Generally I agree wholeheartedly, but as we discussed,
it might not be worth the trouble in this case.

> separate drivers probably don't make much sense here, but maybe
> a CONFIG_ flag for disabling this functionality ?

Yes, I can add that for sure !

>
> hmm, wouldn't the input subsystem be more appropriate for that ?
>

The input subsystem is concerned with input from humans?
But in this case, it's really a power output from an external card
on a PCB assembly. Regulator seemed the kernel abstraction
closest to what this actually represents.

I'm honestly not fully satisfied by the use of the regulator
abstraction here. If you know of a different abstraction
which seems better, I'll definitely consider it.
