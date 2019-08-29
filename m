Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA03C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7249C2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FnV9FO+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfH2WK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:10:56 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34426 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfH2WKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:10:55 -0400
Received: by mail-ot1-f42.google.com with SMTP id c7so5049535otp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JKFzvD/Td3ApmM/HXXB8Lz647XcddtGLKf27MuXwcE=;
        b=FnV9FO+uy1lH3K4uw7V6op9fJUw2CONvHixSUm+Ms7mWNJUIw8UKuYoO/il7WGK+7+
         FwEFJWJJQYE8lU0KzpgHjvHbJeMWEQRVpWJvQqs6z6KULpySz3XPKnLKkAU3BoUGDeYS
         NwdmZ1cGiMlFg1UnOdPFpbhf/2xayeK37a+uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JKFzvD/Td3ApmM/HXXB8Lz647XcddtGLKf27MuXwcE=;
        b=NOYkfyErLc+QF567jLq267ZoZSrEfAPmy/TRlwjnfipwyMkCZOu46FaH15LSSniUVG
         GKtUlnT3bnTrAFZdaeqQjXcazZ2cm9af8uFovvy+q2vJ2391ZBYKUc9nON9BVIxjzY7l
         GhOBMyE7y+OoE0wK/oWRgCfn6mzRif3FiPSBIT8zT1G+J9GzGULuJErV39yM6IZIU6wD
         NrAnT1Gmr5tF0iavRLVRbykD3ZQlnRxGXFbUt6c+xvwawhmMo8R05PsZfdPONswV/p4Q
         qfBUJLYoPS4B4XQPLn9U4oPMLAb1H5qL6s9MJDI4PsBcUG2nk4vK0g0OUmTS5JR5q8+L
         LXCA==
X-Gm-Message-State: APjAAAXfI6wrTL+MagEBRRDlRawoLeA6u4ZTHqdGE8Wn3mFQYBLSLvAj
        lWjZPUeJVHCiIMQdcC1iH6oRTr/brN8=
X-Google-Smtp-Source: APXvYqxmC9nvbYQlDDfkJgcMrYsi0H6WLHvXMSMdvYaap1gN6fCnPZpyOF9wB3LsQPlUz/Zmhwl4aA==
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr9539947ota.289.1567116653635;
        Thu, 29 Aug 2019 15:10:53 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id a17sm1187640otq.56.2019.08.29.15.10.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 15:10:52 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id b25so3837898oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:10:52 -0700 (PDT)
X-Received: by 2002:aca:5251:: with SMTP id g78mr187207oib.49.1567116651565;
 Thu, 29 Aug 2019 15:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
 <20190813060249.GD6670@kroah.com> <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
 <20190814212012.GB22618@kroah.com> <CAHX4x84YM0PcoQw17FxMz=6=NPq2+HUUw2GWZarAKzZxr+ax=A@mail.gmail.com>
 <CADv6+07pYd-kg1i0TJXOPnEO6NUp6D5+BQBkqUO0MDAE+cquow@mail.gmail.com>
 <20190816091243.GB15703@kroah.com> <CADv6+047cZFRS9HG+OpsXw2+yZU4ROUf8v3eSh9p9GpJHy0mQw@mail.gmail.com>
 <3f1def95-e3d4-514b-af76-193cdc43990e@collabora.com>
In-Reply-To: <3f1def95-e3d4-514b-af76-193cdc43990e@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 29 Aug 2019 15:10:39 -0700
X-Gmail-Original-Message-ID: <CAHX4x843bshZPp4oYpvYQz8uNuG=JADqc8JFTioKypmJ5Qf4JQ@mail.gmail.com>
Message-ID: <CAHX4x843bshZPp4oYpvYQz8uNuG=JADqc8JFTioKypmJ5Qf4JQ@mail.gmail.com>
Subject: Re: Policy to keep USB ports powered in low-power states
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Duncan Laurie <dlaurie@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Kurtz <djkurtz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 8:29 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 16/8/19 19:02, Duncan Laurie wrote:
> > On Fri, Aug 16, 2019 at 2:12 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Aug 15, 2019 at 05:42:05PM -0600, Duncan Laurie wrote:
> >>> On Wed, Aug 14, 2019 at 6:08 PM Nick Crews <ncrews@chromium.org> wrote:
> >>>>
> >>>> Adding Duncan Laurie who I think has some more intimate knowledge
> >>>> of how this is implemented in HW. Duncan, could you correct or elaborate
> >>>> on my answers below as you see fit? Also, sorry if I make some beginner
> >>>> mistakes here, I'm just getting familiar with the USB subsystem, and thanks for
> >>>> your patience.
> >>>>
> >>>> On Wed, Aug 14, 2019 at 3:20 PM Greg Kroah-Hartman
> >>>> <gregkh@linuxfoundation.org> wrote:
> >>>>>
> >>>>> On Wed, Aug 14, 2019 at 02:12:07PM -0600, Nick Crews wrote:
> >>>>>> Thanks for the fast response!
> >>>>>>
> >>>>>> On Tue, Aug 13, 2019 at 12:02 AM Greg Kroah-Hartman
> >>>>>> <gregkh@linuxfoundation.org> wrote:
> >>>>>>>
> >>>>>>> On Mon, Aug 12, 2019 at 06:08:43PM -0600, Nick Crews wrote:
> >>>>>>>> Hi Greg!
> >>>>>>>
> >>>>>>> Hi!
> >>>>>>>
> >>>>>>> First off, please fix your email client to not send html so that vger
> >>>>>>> does not reject your messages :)
> >>>>>>
> >>>>>> Thanks, should be good now.
> >>>>>>
> >>>>>>>
> >>>>>>>> I am working on a Chrome OS device that supports a policy called "USB Power
> >>>>>>>> Share," which allows users to turn the laptop into a charge pack for their
> >>>>>>>> phone. When the policy is enabled, power will be supplied to the USB ports
> >>>>>>>> even when the system is in low power states such as S3 and S5. When
> >>>>>>>> disabled, then no power will be supplied in S3 and S5. I wrote a driver
> >>>>>>>> <https://lore.kernel.org/patchwork/patch/1062995/> for this already as part
> >>>>>>>> of drivers/platform/chrome/, but Enric Balletbo i Serra, the maintainer,
> >>>>>>>> had the reasonable suggestion of trying to move this into the USB subsystem.
> >>>>>>>
> >>>>>>> Correct suggestion.
> >>>>>>>
> >>>>>>>> Has anything like this been done before? Do you have any preliminary
> >>>>>>>> thoughts on this before I start writing code? A few things that I haven't
> >>>>>>>> figured out yet:
> >>>>>>>> - How to make this feature only available on certain devices. Using device
> >>>>>>>> tree? Kconfig? Making a separate driver just for this device that plugs
> >>>>>>>> into the USB core?
> >>>>>>>> - The feature is only supported on some USB ports, so we need a way of
> >>>>>>>> filtering on a per-port basis.
> >>>>>>>
> >>>>>>> Look at the drivers/usb/typec/ code, I think that should do everything
> >>>>>>> you need here as this is a typec standard functionality, right?
> >>>>>>
> >>>>>> Unfortunately this is for USB 2.0 ports, so it's not type-C.
> >>>>>> Is the type-C code still worth looking at?
> >>>>>
> >>>>> If this is for USB 2, does it use the "non-standard" hub commands to
> >>>>> turn on and off power?  If so, why not just use the usbreset userspace
> >>>>> program for that?
> >>>>
> >>>> It does not use the standard hub commands. The USB ports are controlled
> >>>> by an Embedded Controller (EC), so to control this policy we send a command
> >>>> to the EC. Since the command to send to the EC is very specific, this would need
> >>>> to go into a "hub driver" unique for these Wilco devices. We would make it so
> >>>> that the normal hub registration is intercepted by something that sees this is a
> >>>> Wilco device, and instead register the hub as a "wilco-hub", which has its own
> >>>> special "power_share" sysfs attribute, but still is treated as a normal USB hub
> >>>> otherwise?
> >>>>
> >>>
> >>>
> >>> I would say it is somewhat similar to the USB port power control which
> >>> eventually calls into usb_acpi_set_power_state() but in this case it only
> >>> affects the behavior when the system is NOT running.
> >>
> >> Ok, if this is when the system is not running, why does Linux need to be
> >> involved at all?
> >>
> >> And if Linux is running, why not just follow the USB spec and not create
> >> your own craziness?
> >>
> >>> This design has a standalone USB charge power controller on the board
> >>> that passes through the USB2 D+/D- pins from one port and is able to do
> >>> BC1.2 negotiation when the host controller is not powered, assuming
> >>> the chip has been enabled by the Embedded Controller.
> >>
> >> So it does follow the spec?  Or does not?  I can't determine here.
> >>
> >
> >
> > I didn't realize the part had a public datasheet:
> > https://www.dialog-semiconductor.com/sites/default/files/xslgc55544cr105_09292017.pdf
> >
> > It is really only concerned with following the BC1.2 spec and not
> > interfering with the USB protocol part.
> >
>
> Without knowing the internal design, but having more infor now, looks to me that
> should be modelled more as a kind of power supply? Maybe something similar to
> UCS1002-2 device (drivers/power/supply/ucs1002_power.c) but behind the EC?

This would work, the problem would be that you lose the link to the
actual USB port.
On these Wilco devices, only one port supports this, and I don't think we really
care about exposing which one it is, but theoretically you would want
to be able to
control this for individual ports. I talked with Duncan today and he
will tweak the
BIOS firmware so that it exposes which USB ports support the PowerShare ability.
Then we can query this configuration via ACPI.

I hadn't seen that driver before, it looks very new, but looks quite
similar. One problem
is that the standard power_supply properties represent the present
status of the device,
whereas we want to control the state when the device is off.

I think that I will write this up as a power_supply driver and see
what people think. As
a fallback, we can look more into the USB subsystem. Greg, do you think that is
acceptable, or would you really like this within the USB subsystem?


>
> Cheers,
>  Enric
>
> >
> >> If the EC is in charge of all of this, why does Linux need to get
> >> involved?
> >>
> >
> > Only because we are looking to expose a policy to control the behavior
> > of this chip at the OS level.
> >
> > Most systems would put this in as an option in the BIOS but we do
> > not have setup menus on Chrome OS and we want to have the policy
> > controlled directly, preferably without resorting to an opaque interface
> > to a userspace utility.
> >
> > To that end we have added a number of different EC controls and are
> > looking to fit them into the appropriate subsystems wherever possible.
> > As you can see they don't always fit naturally..
> >
> >
> >>>>> And how are you turning a USB 2 port into a power source?  That feels
> >>>>> really odd given the spec.  Is this part of the standard somewhere or
> >>>>> just a firmware/hardware hack that you are adding to a device?
> >>>>
> >>>> The EC twiddles something in the port' HW so that the port turns into a
> >>>> DCP (Dedicated Charging Port) and only supplies power, not data. So I
> >>>> think yes, this is a bit of a hack that does not conform to the spec.
> >>>>
> >>>>>
> >>>>> Is there some port information in the firmware that describes this
> >>>>> functionality?  If so, can you expose it through sysfs to the port that
> >>>>> way?
> >>>>
> >>>> [I'm not sure I'm answering your question, but] I believe that we could
> >>>> make the BIOS firmware describe the USB ports' capabilities, and the
> >>>> kernel's behavior would be gated upon what the firmware reports. I see
> >>>> that struct usb_port already contains a "quirks" field, should we add a
> >>>> POWER_SHARE quirk to include/linux/usb/quirks.h? I would guess that
> >>>> should that should be reserved for quirks shared between many USB
> >>>> devices/hubs?
> >>>
> >>> We could add a Device Property to the affected USB port in ACPI and
> >>> describe it that way, similar to other properties like 'vcc-supply', 'clocks',
> >>> 'vbus-detect', etc and hook it into the phy-generic driver.
> >>>
> >>> However I'm not clear on whether the phy driver binding works with XHCI
> >>> when using ACPI, so this may not be an appropriate place either.
> >>
> >> Why would you have DT involved if you are using acpi?  :)
> >>
> >
> > This would come in via the _DSD method of passing parameters to
> > specific ACPI devices.
> >
> >
> > -duncan
> >
