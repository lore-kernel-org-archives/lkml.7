Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5E4C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7922089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uj64cP5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfHOXmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:42:23 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45039 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfHOXmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:42:23 -0400
Received: by mail-vs1-f68.google.com with SMTP id c7so2572115vse.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adCOu9nDiZkMdpLyTmT0+/YcmhLlfKn9ZIk2EvNGin4=;
        b=Uj64cP5/AeOk/CghcfT2p+2nbk1bQvzFbxwrxXRumbp1HjIKC5UjhXiXj3PMo6BeTd
         AnqZm0zZ4O6fu8jqemv8mbSLPLQ8htWTuu9VL9CYJehnRUjUjYE0ILUP+t46sq1/QMjO
         nnbiw9NXBTi7lnlSt32X/XOIfMz31t7M6U5oTxXCNAwUnzsSGjl17Hi+eT1n2N2zG9II
         8/MFBywmzgMh0ARxu0GQ5UrRgmoyV6rod/NVvkMmW1qWCJXm0M/5c/QDMz0JDIlwPA7I
         yEDQhWy7I2nGi7DCj6zEXAOdL/M+niByHpAp7hnTK2GrqGkfubUYYQR3DmWHYGx4MVtW
         +Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adCOu9nDiZkMdpLyTmT0+/YcmhLlfKn9ZIk2EvNGin4=;
        b=S7lEwDVByGGtn4hJDIRXjVIliog7kP53m1FweWZo3EBzKqh46K88vOlVQwV05jtQ6D
         +EiLGUx/Tuc8LPw7qdx8XqiHBiOVpRfrsoHv4jP3FXDQGBbP8kaGvxruJHg8BwUQvUR1
         I55asdHQLme1m8s4xWzyb8bj0IFKmEjCsOjPXMq5onTbwHZImifnByU+Y1CextS/c23B
         PXlm/NUR91ilkZuFHXMwHkc03V9tl2tbkcfKwm3unmw+9G/UtTQ9f1smAo1ysO5l5Dg7
         8iBZE12phbozBB5eLUBkDxwhs2+tsKvXcdXRP/PH6tWHOJ2i+ymOqnazGRv8pYtdibkV
         8p8A==
X-Gm-Message-State: APjAAAV8qbC9ut8WYwL+dluP83pknVk/SIInCtgz+ckl5RUPwsePA0a0
        KP0Ip0LVHDpBX2yiGzxs2jpEsjOQqBQqpcczooVQpg==
X-Google-Smtp-Source: APXvYqwOgyRx9FKqQo804GjrF6fZbOZewFvcMKE8cJedUDm3jnXNo4HYJ9Gyh9H08j0Z0Kc4bxsVFkLNZaBHgEl1/q4=
X-Received: by 2002:a67:cd9a:: with SMTP id r26mr4589218vsl.152.1565912541342;
 Thu, 15 Aug 2019 16:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
 <20190813060249.GD6670@kroah.com> <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
 <20190814212012.GB22618@kroah.com> <CAHX4x84YM0PcoQw17FxMz=6=NPq2+HUUw2GWZarAKzZxr+ax=A@mail.gmail.com>
In-Reply-To: <CAHX4x84YM0PcoQw17FxMz=6=NPq2+HUUw2GWZarAKzZxr+ax=A@mail.gmail.com>
From:   Duncan Laurie <dlaurie@google.com>
Date:   Thu, 15 Aug 2019 17:42:05 -0600
Message-ID: <CADv6+07pYd-kg1i0TJXOPnEO6NUp6D5+BQBkqUO0MDAE+cquow@mail.gmail.com>
Subject: Re: Policy to keep USB ports powered in low-power states
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Kurtz <djkurtz@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 6:08 PM Nick Crews <ncrews@chromium.org> wrote:
>
> Adding Duncan Laurie who I think has some more intimate knowledge
> of how this is implemented in HW. Duncan, could you correct or elaborate
> on my answers below as you see fit? Also, sorry if I make some beginner
> mistakes here, I'm just getting familiar with the USB subsystem, and thanks for
> your patience.
>
> On Wed, Aug 14, 2019 at 3:20 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 14, 2019 at 02:12:07PM -0600, Nick Crews wrote:
> > > Thanks for the fast response!
> > >
> > > On Tue, Aug 13, 2019 at 12:02 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Aug 12, 2019 at 06:08:43PM -0600, Nick Crews wrote:
> > > > > Hi Greg!
> > > >
> > > > Hi!
> > > >
> > > > First off, please fix your email client to not send html so that vger
> > > > does not reject your messages :)
> > >
> > > Thanks, should be good now.
> > >
> > > >
> > > > > I am working on a Chrome OS device that supports a policy called "USB Power
> > > > > Share," which allows users to turn the laptop into a charge pack for their
> > > > > phone. When the policy is enabled, power will be supplied to the USB ports
> > > > > even when the system is in low power states such as S3 and S5. When
> > > > > disabled, then no power will be supplied in S3 and S5. I wrote a driver
> > > > > <https://lore.kernel.org/patchwork/patch/1062995/> for this already as part
> > > > > of drivers/platform/chrome/, but Enric Balletbo i Serra, the maintainer,
> > > > > had the reasonable suggestion of trying to move this into the USB subsystem.
> > > >
> > > > Correct suggestion.
> > > >
> > > > > Has anything like this been done before? Do you have any preliminary
> > > > > thoughts on this before I start writing code? A few things that I haven't
> > > > > figured out yet:
> > > > > - How to make this feature only available on certain devices. Using device
> > > > > tree? Kconfig? Making a separate driver just for this device that plugs
> > > > > into the USB core?
> > > > > - The feature is only supported on some USB ports, so we need a way of
> > > > > filtering on a per-port basis.
> > > >
> > > > Look at the drivers/usb/typec/ code, I think that should do everything
> > > > you need here as this is a typec standard functionality, right?
> > >
> > > Unfortunately this is for USB 2.0 ports, so it's not type-C.
> > > Is the type-C code still worth looking at?
> >
> > If this is for USB 2, does it use the "non-standard" hub commands to
> > turn on and off power?  If so, why not just use the usbreset userspace
> > program for that?
>
> It does not use the standard hub commands. The USB ports are controlled
> by an Embedded Controller (EC), so to control this policy we send a command
> to the EC. Since the command to send to the EC is very specific, this would need
> to go into a "hub driver" unique for these Wilco devices. We would make it so
> that the normal hub registration is intercepted by something that sees this is a
> Wilco device, and instead register the hub as a "wilco-hub", which has its own
> special "power_share" sysfs attribute, but still is treated as a normal USB hub
> otherwise?
>


I would say it is somewhat similar to the USB port power control which
eventually calls into usb_acpi_set_power_state() but in this case it only
affects the behavior when the system is NOT running.

This design has a standalone USB charge power controller on the board
that passes through the USB2 D+/D- pins from one port and is able to do
BC1.2 negotiation when the host controller is not powered, assuming
the chip has been enabled by the Embedded Controller.


>
> >
> > And how are you turning a USB 2 port into a power source?  That feels
> > really odd given the spec.  Is this part of the standard somewhere or
> > just a firmware/hardware hack that you are adding to a device?
>
> The EC twiddles something in the port' HW so that the port turns into a
> DCP (Dedicated Charging Port) and only supplies power, not data. So I
> think yes, this is a bit of a hack that does not conform to the spec.
>
> >
> > Is there some port information in the firmware that describes this
> > functionality?  If so, can you expose it through sysfs to the port that
> > way?
>
> [I'm not sure I'm answering your question, but] I believe that we could
> make the BIOS firmware describe the USB ports' capabilities, and the
> kernel's behavior would be gated upon what the firmware reports. I see
> that struct usb_port already contains a "quirks" field, should we add a
> POWER_SHARE quirk to include/linux/usb/quirks.h? I would guess that
> should that should be reserved for quirks shared between many USB
> devices/hubs?
>


We could add a Device Property to the affected USB port in ACPI and
describe it that way, similar to other properties like 'vcc-supply', 'clocks',
'vbus-detect', etc and hook it into the phy-generic driver.

However I'm not clear on whether the phy driver binding works with XHCI
when using ACPI, so this may not be an appropriate place either.

-duncan
