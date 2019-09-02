Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C55C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D332343A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfIBUQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 16:16:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45210 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfIBUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:16:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CA23982018; Mon,  2 Sep 2019 22:15:47 +0200 (CEST)
Date:   Mon, 2 Sep 2019 22:16:00 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Duncan Laurie <dlaurie@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Kurtz <djkurtz@google.com>
Subject: Re: Policy to keep USB ports powered in low-power states
Message-ID: <20190902201600.GB6546@bug>
References: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
 <20190813060249.GD6670@kroah.com>
 <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
 <20190814212012.GB22618@kroah.com>
 <CAHX4x84YM0PcoQw17FxMz=6=NPq2+HUUw2GWZarAKzZxr+ax=A@mail.gmail.com>
 <CADv6+07pYd-kg1i0TJXOPnEO6NUp6D5+BQBkqUO0MDAE+cquow@mail.gmail.com>
 <20190816091243.GB15703@kroah.com>
 <CADv6+047cZFRS9HG+OpsXw2+yZU4ROUf8v3eSh9p9GpJHy0mQw@mail.gmail.com>
 <3f1def95-e3d4-514b-af76-193cdc43990e@collabora.com>
 <CAHX4x843bshZPp4oYpvYQz8uNuG=JADqc8JFTioKypmJ5Qf4JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHX4x843bshZPp4oYpvYQz8uNuG=JADqc8JFTioKypmJ5Qf4JQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Without knowing the internal design, but having more infor now, looks to me that
> > should be modelled more as a kind of power supply? Maybe something similar to
> > UCS1002-2 device (drivers/power/supply/ucs1002_power.c) but behind the EC?
> 
> This would work, the problem would be that you lose the link to the
> actual USB port.
> On these Wilco devices, only one port supports this, and I don't think we really
> care about exposing which one it is, but theoretically you would want
> to be able to
> control this for individual ports. I talked with Duncan today and he
> will tweak the
> BIOS firmware so that it exposes which USB ports support the PowerShare ability.
> Then we can query this configuration via ACPI.
> 
> I hadn't seen that driver before, it looks very new, but looks quite
> similar. One problem
> is that the standard power_supply properties represent the present
> status of the device,
> whereas we want to control the state when the device is off.
> 
> I think that I will write this up as a power_supply driver and see
> what people think. As
> a fallback, we can look more into the USB subsystem. Greg, do you think that is
> acceptable, or would you really like this within the USB subsystem?

So, I'm not greg, but... Motorola Droid 4 (and other phones) have USB otg controllers...
They can act as a device (common use), but they can also support USB host, and they
can power the USB bus... either with battery voltage or with 5V.

Having ability to control that even if USB device is not present would be pretty
interesting for various hacks.

Best regards,								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
