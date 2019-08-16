Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB5EC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D3A2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHIQJ9Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfHPRC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:02:56 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46704 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHPRCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:02:55 -0400
Received: by mail-vs1-f66.google.com with SMTP id r3so4110377vsr.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WegIUfbHftQUTQTU11Go6S83AdqoYFM2efQvHBSuJlE=;
        b=SHIQJ9VxHiAm2dgkil0wkRQaprwozH+wzFD1o5G4b7Cl24oXtsC3DNbNh/lUCoHVtN
         gLHY3tT+L/xc942YRpoVU9mm7Oyx7YildvyNSX2m/U7sKAuOPyAylMSe4YZqdXeYKVeS
         oVNN0pPTzxbZp5nitkuz3DWL157kzOiVPqbDy8nJWLw7ABkvrmnwtDPOPcpTLmXExsN6
         vDotBGZCJnC7M0ouu2Nfer2SqLx5ktEfKsROFDkMvMn5Os0vOOWFw4fdhR/bqg52fOoE
         sQ2Uu20lL3sXRVB+JJQsErl/wR4EGEkGoLjrGqY5TyQthVEyEqJhIspELb4pMQAcx2FL
         546g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WegIUfbHftQUTQTU11Go6S83AdqoYFM2efQvHBSuJlE=;
        b=PCsFrsO0sZCsP/C1dw50VLdVJ6qLctFdeTw++RFSS+RZp8ahrfpMruZrT3xuXuBAke
         9eGrET3hS5ssnVeylGGTZFTEfAUghTcIxP+VKYPhBmmTYYsVNFexS4aJ0yVZzNcxueCs
         TLaS4RGR3mpnnh3LvmSUNMTDhX33Jn4lzTktKBMU80ospgiahf/OmZHncbimTlbP67eQ
         DUljgywR4zU5l2gcFtqJjW/te5Bibgq4LuYdMBaTemvQl7LSAoLviEz00sIASHqafLh/
         ba+jedzd6+Z545bTe9EMONjpgtlfXikN41s3+LG1uKCpZ4wi8pGZ68rj36sBBdPZPsue
         NmZQ==
X-Gm-Message-State: APjAAAVrvWvtWy8IVYtnZqJ8aKHCpMwk1OxvD8JI045/oslQ3z2tp35p
        Enl8l//g/jv/XtX54gLZhC2KQL+cispbRHMAbLkAsQ==
X-Google-Smtp-Source: APXvYqw46WJasW8kC/SWyhVHDui0erCq/jSmYoxOV9zJ7XFhgWzwdvP8c/T+20+JqkeFGhD8m07/RiyC36578bKcWNc=
X-Received: by 2002:a67:1687:: with SMTP id 129mr6725448vsw.232.1565974972708;
 Fri, 16 Aug 2019 10:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
 <20190813060249.GD6670@kroah.com> <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
 <20190814212012.GB22618@kroah.com> <CAHX4x84YM0PcoQw17FxMz=6=NPq2+HUUw2GWZarAKzZxr+ax=A@mail.gmail.com>
 <CADv6+07pYd-kg1i0TJXOPnEO6NUp6D5+BQBkqUO0MDAE+cquow@mail.gmail.com> <20190816091243.GB15703@kroah.com>
In-Reply-To: <20190816091243.GB15703@kroah.com>
From:   Duncan Laurie <dlaurie@google.com>
Date:   Fri, 16 Aug 2019 10:02:36 -0700
Message-ID: <CADv6+047cZFRS9HG+OpsXw2+yZU4ROUf8v3eSh9p9GpJHy0mQw@mail.gmail.com>
Subject: Re: Policy to keep USB ports powered in low-power states
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Crews <ncrews@chromium.org>, linux-usb@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Kurtz <djkurtz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 2:12 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 15, 2019 at 05:42:05PM -0600, Duncan Laurie wrote:
> > On Wed, Aug 14, 2019 at 6:08 PM Nick Crews <ncrews@chromium.org> wrote:
> > >
> > > Adding Duncan Laurie who I think has some more intimate knowledge
> > > of how this is implemented in HW. Duncan, could you correct or elaborate
> > > on my answers below as you see fit? Also, sorry if I make some beginner
> > > mistakes here, I'm just getting familiar with the USB subsystem, and thanks for
> > > your patience.
> > >
> > > On Wed, Aug 14, 2019 at 3:20 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Aug 14, 2019 at 02:12:07PM -0600, Nick Crews wrote:
> > > > > Thanks for the fast response!
> > > > >
> > > > > On Tue, Aug 13, 2019 at 12:02 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Aug 12, 2019 at 06:08:43PM -0600, Nick Crews wrote:
> > > > > > > Hi Greg!
> > > > > >
> > > > > > Hi!
> > > > > >
> > > > > > First off, please fix your email client to not send html so that vger
> > > > > > does not reject your messages :)
> > > > >
> > > > > Thanks, should be good now.
> > > > >
> > > > > >
> > > > > > > I am working on a Chrome OS device that supports a policy called "USB Power
> > > > > > > Share," which allows users to turn the laptop into a charge pack for their
> > > > > > > phone. When the policy is enabled, power will be supplied to the USB ports
> > > > > > > even when the system is in low power states such as S3 and S5. When
> > > > > > > disabled, then no power will be supplied in S3 and S5. I wrote a driver
> > > > > > > <https://lore.kernel.org/patchwork/patch/1062995/> for this already as part
> > > > > > > of drivers/platform/chrome/, but Enric Balletbo i Serra, the maintainer,
> > > > > > > had the reasonable suggestion of trying to move this into the USB subsystem.
> > > > > >
> > > > > > Correct suggestion.
> > > > > >
> > > > > > > Has anything like this been done before? Do you have any preliminary
> > > > > > > thoughts on this before I start writing code? A few things that I haven't
> > > > > > > figured out yet:
> > > > > > > - How to make this feature only available on certain devices. Using device
> > > > > > > tree? Kconfig? Making a separate driver just for this device that plugs
> > > > > > > into the USB core?
> > > > > > > - The feature is only supported on some USB ports, so we need a way of
> > > > > > > filtering on a per-port basis.
> > > > > >
> > > > > > Look at the drivers/usb/typec/ code, I think that should do everything
> > > > > > you need here as this is a typec standard functionality, right?
> > > > >
> > > > > Unfortunately this is for USB 2.0 ports, so it's not type-C.
> > > > > Is the type-C code still worth looking at?
> > > >
> > > > If this is for USB 2, does it use the "non-standard" hub commands to
> > > > turn on and off power?  If so, why not just use the usbreset userspace
> > > > program for that?
> > >
> > > It does not use the standard hub commands. The USB ports are controlled
> > > by an Embedded Controller (EC), so to control this policy we send a command
> > > to the EC. Since the command to send to the EC is very specific, this would need
> > > to go into a "hub driver" unique for these Wilco devices. We would make it so
> > > that the normal hub registration is intercepted by something that sees this is a
> > > Wilco device, and instead register the hub as a "wilco-hub", which has its own
> > > special "power_share" sysfs attribute, but still is treated as a normal USB hub
> > > otherwise?
> > >
> >
> >
> > I would say it is somewhat similar to the USB port power control which
> > eventually calls into usb_acpi_set_power_state() but in this case it only
> > affects the behavior when the system is NOT running.
>
> Ok, if this is when the system is not running, why does Linux need to be
> involved at all?
>
> And if Linux is running, why not just follow the USB spec and not create
> your own craziness?
>
> > This design has a standalone USB charge power controller on the board
> > that passes through the USB2 D+/D- pins from one port and is able to do
> > BC1.2 negotiation when the host controller is not powered, assuming
> > the chip has been enabled by the Embedded Controller.
>
> So it does follow the spec?  Or does not?  I can't determine here.
>


I didn't realize the part had a public datasheet:
https://www.dialog-semiconductor.com/sites/default/files/xslgc55544cr105_09292017.pdf

It is really only concerned with following the BC1.2 spec and not
interfering with the USB protocol part.


> If the EC is in charge of all of this, why does Linux need to get
> involved?
>

Only because we are looking to expose a policy to control the behavior
of this chip at the OS level.

Most systems would put this in as an option in the BIOS but we do
not have setup menus on Chrome OS and we want to have the policy
controlled directly, preferably without resorting to an opaque interface
to a userspace utility.

To that end we have added a number of different EC controls and are
looking to fit them into the appropriate subsystems wherever possible.
As you can see they don't always fit naturally..


> > > > And how are you turning a USB 2 port into a power source?  That feels
> > > > really odd given the spec.  Is this part of the standard somewhere or
> > > > just a firmware/hardware hack that you are adding to a device?
> > >
> > > The EC twiddles something in the port' HW so that the port turns into a
> > > DCP (Dedicated Charging Port) and only supplies power, not data. So I
> > > think yes, this is a bit of a hack that does not conform to the spec.
> > >
> > > >
> > > > Is there some port information in the firmware that describes this
> > > > functionality?  If so, can you expose it through sysfs to the port that
> > > > way?
> > >
> > > [I'm not sure I'm answering your question, but] I believe that we could
> > > make the BIOS firmware describe the USB ports' capabilities, and the
> > > kernel's behavior would be gated upon what the firmware reports. I see
> > > that struct usb_port already contains a "quirks" field, should we add a
> > > POWER_SHARE quirk to include/linux/usb/quirks.h? I would guess that
> > > should that should be reserved for quirks shared between many USB
> > > devices/hubs?
> >
> > We could add a Device Property to the affected USB port in ACPI and
> > describe it that way, similar to other properties like 'vcc-supply', 'clocks',
> > 'vbus-detect', etc and hook it into the phy-generic driver.
> >
> > However I'm not clear on whether the phy driver binding works with XHCI
> > when using ACPI, so this may not be an appropriate place either.
>
> Why would you have DT involved if you are using acpi?  :)
>

This would come in via the _DSD method of passing parameters to
specific ACPI devices.


-duncan
