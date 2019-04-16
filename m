Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B796C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C1A20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZU7uqNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfDPVXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:23:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46818 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:23:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id s24so18855694otk.13;
        Tue, 16 Apr 2019 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSbt7gSTY0ZiiqAPV9bHSsOQXzLW95HIvp4EovOMx3E=;
        b=qZU7uqNCkttnmq52a+R21NPeIub8LxD7ARToxVaPTt+wYlPtTznjyd+GRb/luQ8bkC
         SCPwDj9YM7LbvLbdFCLxPFAlUbze8yvIUUq4nie98RjjQrnXB3JlV4ofq1hAmSqByDRr
         2TCVev+CKiu1/b3U1dvDEupAaYaMiQpJ6k250luvpn6js5S+lNBgAiWHk6pGm1WmKfnT
         b7qcUhmJG6JRCftUJsKHFhwLCpMnUprIGKviy3P7ce40GhS58Z8ibrO7xKisRaL8k52Q
         l77iju8cH2JLHFwOJH1WB71W5b8rCZFV8QFQeyHKUT95ZOoS3ZWcBqKkI9BomFKLguFS
         EC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSbt7gSTY0ZiiqAPV9bHSsOQXzLW95HIvp4EovOMx3E=;
        b=nWqOSw5LO6z/StuvAW/SXFEHesOxPs7l8ybbaJSiAZFWk0JpOKjlp+SPzVERBqXUPF
         5nKgSQPQwF2fuAXD9t4eLojA/qfay/BqDWY9ZRIicB/1luI6q1oPQkQnEsGAa5oOt8ZK
         7yX4P9ZrQOJH4apWh7jHBNdBXu7FGe2vKyQMBrruWranRarh1FmzRGW4El2aiR2Uiqql
         jwvfxM9JAN9kyY0Lv7C/F0KxMlKrNCBJ0gtRUq0rtxw42xN4ynYhBPMS7eEldLGo74z2
         wMmUL62C4GcCzmOAAtA/zr8CCdlgvqnEaqmyxMssBS62mr0k7zaiA10B5JGS+ZodU/Wf
         8AWw==
X-Gm-Message-State: APjAAAUyLXnL7PNZe66dHrM3Q76xh5y/vmhxnqhFXoAsN+7d3r0spHPW
        fivg+g/3zl2zZL9ZWwBTNsFUUCJidm4YpWgL9l0=
X-Google-Smtp-Source: APXvYqxRZCciYu1oN2IMm0pl7eZwo3M50MGFvrXbLWjuQqtQY3apqNG4Ia3uL/qPmmEeDD8fN68LUgnbPgd5OpgMMHE=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr19079524otk.48.1555449820556;
 Tue, 16 Apr 2019 14:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155618.1369-1-TheSven73@gmail.com> <20190416155618.1369-4-TheSven73@gmail.com>
 <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net> <CAGngYiXZSaUwrCiqavMGDRb5Vuo2x8fTjDetT00PAjjtrYW+NA@mail.gmail.com>
 <bd36b798-d129-c81a-ab2d-22a5b46567f6@metux.net>
In-Reply-To: <bd36b798-d129-c81a-ab2d-22a5b46567f6@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 16 Apr 2019 17:23:29 -0400
Message-ID: <CAGngYiUaUoRUAiGUGbJEWGRj0bszeSsDDBfZMwoWokQRrMUhfA@mail.gmail.com>
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

On Tue, Apr 16, 2019 at 5:07 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:>
> By the grey theory it would be better to split it into two separate
> drivers. But obviously, they need need a common part (a third piece).

Well yes, we could treat it as an mfd device, with a common register accessor,
which registers anybus-s host and adc drivers, all selectable via
Kconfig / defconfig... But that's a lot of extra code just to handle one single
bit in a register, which is a boolean input.

Can be done but is it worth it?

>
> Does it ever make sense to only use one of two functionalities ?

That depends on what the userspace app wants to do.
Our userspace app always attempts to monitor the CAN readout.

>
> Does this power read-out involve some CAN traffic, or is it just
> fetching from some card that just happens to be some CAN interface ?
> (IOW: is cansocket needed for that ?)
>

It is purely a boolean input. The boolean output of a voltage monitor chip.
When our hardware is assembled, the voltage monitor input is connected
to a signal which indicates the CAN status. In theory, it could be connected
to the factory's light switch. It would then read out the status of the factory
floor lights. It has no CAN functionality whatsoever.
