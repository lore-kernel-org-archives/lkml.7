Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD84FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73703206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+TN06f6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfDPSoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:44:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40627 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:44:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id f196so7130235oib.7;
        Tue, 16 Apr 2019 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExN7Wtws8YpNZwB7QCsbUBpoEfN2Q23PblpQPqiK3EY=;
        b=D+TN06f66R1rlpjFrOx+wOQ3H6HFeP2YKPqTtHjPE+i5Wtft8jRzzWJsr63ARjq8d/
         krin1rVq6YHnvBUGaYqzGM2TdUSIuX8wZAPJc+yxI9ljs9jEHIHs8iVxD0oM9KCAUiN+
         PdefJAQsJJD3aYJ06Lrghin6LCxU04bOl7MWWGsLZwGv5ileWU/2Fy4rf4ksozqzSvFV
         8MgudSYRr5G9QpMaJZZrOizEFXxAnU5eYMWrNIxx+JjCq8fBa5EIsJtclcsYsqSCiSU1
         nXaVEWpxuxcnQ2OM3TUF74cqM9MaBrofVMDsZBm3c6glLSI68kLOoYQt6QkPTWavpIAZ
         XOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExN7Wtws8YpNZwB7QCsbUBpoEfN2Q23PblpQPqiK3EY=;
        b=RoRWW6WD6kLhq+o1GigAXuiC3523Fxkn2e27mwyI4dy5pL+ks1sWXVKFdnWFPlgVIT
         dm04CNUA224WmUIp54rQaf/enoJ1i3D+SduIZwwwZPo88h3vecute4sMKX+nZizc5PIW
         dShsTXDGp1frpp3fT/YSmzstPUzhcYJpVpZ8WGNisjhDiESuP6ensmU2loOxm/hSS9DK
         Pp3EjhkQkuudnFCdRJoNGIoydyHqJE1XknCijz5Q3weVCiWVoAJQNaHK/1VxDCDffIGR
         Xb7xbBIP7hZKRXXSV1v3nuS6h4Ehlosdnj6dfMb2cAp15VRs3oamWeGg+AWSkClEzzPW
         vHWg==
X-Gm-Message-State: APjAAAWQURJzF5Yckc36Gcy7agc+tYQUcnZg9Rpw1iJyd/s3u36C5GNZ
        ORMa87fe/cnP+GFRfRFxRCNbbA/LI4Gg9LI+ACw=
X-Google-Smtp-Source: APXvYqz6M7aiyDUiNYoPmyhFyLGsZlfAruMFmrU/88WwvOKDIyMT4u4zWU1S9qK8B+F13YSRD0bX5GvZy0hnVpf5VMk=
X-Received: by 2002:aca:4202:: with SMTP id p2mr22668863oia.169.1555440240315;
 Tue, 16 Apr 2019 11:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155618.1369-1-TheSven73@gmail.com> <20190416155618.1369-3-TheSven73@gmail.com>
 <4aecef30-0d64-c5f7-c4de-43b0754e2fdd@metux.net>
In-Reply-To: <4aecef30-0d64-c5f7-c4de-43b0754e2fdd@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 16 Apr 2019 14:43:49 -0400
Message-ID: <CAGngYiX3QP25MLupsc-=gfb6CAh5wK49eGs2xqHh_5LxrKtaAA@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] anybus-s: support HMS Anybus-S bus
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

On Tue, Apr 16, 2019 at 1:10 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> Is it some proprietary backplane bus, where things like eg. fieldbus
> adapters are attached to ?
>
> I see some struct bus_type field declaration - is that going to be some
> subsystem, similar to those for other bus'es (eg. pci, usb, ...) ?
>

Correct on both points :)
The author of this proprietary standard (HMS) calls this a bus, but only
a single card can be connected to a slot. So it's not like pci or usb,
where you can connect multiple devices to a host.

> Maybe that deserves a bit more documentation :p
>

Sure, I can do that. What would be the best location for this?
The commit message? The Kconfig blurb? Comments in host.c?
Somewhere in Documentation/ ?

Sven
