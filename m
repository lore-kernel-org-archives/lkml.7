Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF62DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F12C20872
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLxZoJtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406491AbfFKUUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:20:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43148 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406240AbfFKUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:20:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id i8so13192872oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZN1SnBquRzXuf2+xQl9wQuhxCyT0k91S9YrA851zmG8=;
        b=VLxZoJtBU3LoJ1q77LadvK1F88vWwDRzdEvQpSiAep2KDJmHOqGB6LyyBz1+4NqZwS
         bE23W4vqqI7RcG/bLR2oxUKh45SjQJmY6xdK5oUW6cUlTobeLtUhylLStQxgIxCrauOM
         oz8tXQmJb9Na/kMveFMGedzc4E3ybDQcWsalq5p4giGOLVqPjYaoPzIAbDiXRy6vymmD
         2Pf11dEYFnnPL2mIWNFE9OrBoxhQDOhOVq53W7fB5TyxjOD0vOzzM+MMN5H9f3Pt2895
         Zq1YhuNTTC9MpUCq9sOIslqpxGFntgE41HM7IyXq24xF5A7loPHYMzXbebuiRbCjnVRA
         upzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZN1SnBquRzXuf2+xQl9wQuhxCyT0k91S9YrA851zmG8=;
        b=OdBR3MpuVZM2DFv/jsPu+Pi/vh87gNJPp4hAGfGKV4FbEyATBhbQHXKLp9JSzc8cCC
         1ojLE/PEZVCckjbKLJan5iHJoNYbnaOR6R/1ntCyf65Ln0nF6xFjunjJw62S4WkLy7ZL
         Xrez08MHYFnup+owXSc+0CV6JSt6WDS9CcMAv2TFl671Bmq/mxXm2dcSYIj4Dlrcl/rC
         DqTSdB8LNl7E9lgI8qpPnvBNXspEOnmBrjOqkKduMPfix69S4D/nzcywzt0RN84jHzAz
         y6K2fd1ENVV9hUzZ5NvCnimqhH/h+K+gLsvVgjtVKwME8gvlaQmGYLrcAhQlz30ZqO4v
         Wkqw==
X-Gm-Message-State: APjAAAVm7kgzwXrOcLXzb6pZm27ZxB7ChSOTEguFzGMmwlW1n/DvERfE
        o7lbCri+l1WuQlpZo8xkizvvljYVp8NbeUEy7TkVQQ==
X-Google-Smtp-Source: APXvYqxuWlhccFyXteP6ApBz3nhtKKOKK84dG6MwtBasnRXOCw14GKlmfvRalKmCAk1tHb3kQs/MvFCapJjSAE8aCcQ=
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr35545957otp.225.1560284429523;
 Tue, 11 Jun 2019 13:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com> <06b479e2-e8a0-b3e8-567c-7fa0f1c5bdf6@gmail.com>
 <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
 <d49dccee-203a-628a-8e47-191014619f6b@gmail.com> <CAGETcx-HPsxdwMfUJDUBvjpiuK9eyRCYRhqsXxiL5Q8g+YgHEg@mail.gmail.com>
 <5a3c1776-69ed-eeec-9326-8632c6bd0d58@gmail.com>
In-Reply-To: <5a3c1776-69ed-eeec-9326-8632c6bd0d58@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 11 Jun 2019 13:19:53 -0700
Message-ID: <CAGETcx_kFMXTCdBVFX-VQ6mktoDe=nqYMS76QBWGdhL=+fT79Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe ordering
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 7:56 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Saravana,
>
> On 5/24/19 9:04 PM, Saravana Kannan wrote:
> > On Fri, May 24, 2019 at 7:40 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> Hi Saranova,
> >>
> >> I'll try to address the other portions of this email that I <snipped>
> >> in my previous replies.
> >>
> >>
> >> On 5/24/19 2:53 PM, Saravana Kannan wrote:
> >>> On Fri, May 24, 2019 at 10:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> On 5/23/19 6:01 PM, Saravana Kannan wrote:
> >>>>> Add a generic "depends-on" property that allows specifying mandatory
> >>>>> functional dependencies between devices. Add device-links after the
> >>>>> devices are created (but before they are probed) by looking at this
> >>>>> "depends-on" property.
> >>>>>
> >>>>> This property is used instead of existing DT properties that specify
> >>>>> phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
> >>>>> is because not all resources referred to by existing DT properties are
> >>>>> mandatory functional dependencies. Some devices/drivers might be able>>>>> to operate with reduced functionality when some of the resources
>
>
> In your original email, you say this:
>
> >>>>> aren't available. For example, a device could operate in polling mode
> >>>>> if no IRQ is available, a device could skip doing power management if
> >>>>> clock or voltage control isn't available and they are left on, etc.
>
>
> >>>>>
> >>>>> So, adding mandatory functional dependency links between devices by
> >>>>> looking at referred phandles in DT properties won't work as it would
> >>>>> prevent probing devices that could be probed. By having an explicit
> >>>>> depends-on property, we can handle these cases correctly.
> >>>>
> >>>> Trying to wrap my brain around the concept, this series seems to be
> >>>> adding the ability to declare that an apparent dependency (eg an IRQ
> >>>> specified by a phandle) is _not_ actually a dependency.
> >>>
> >>> The current implementation completely ignores existing bindings for
> >>> dependencies and so does the current tip of the kernel. So it's not
> >>> really overriding anything. However, if I change the implementation so
> >>> that depends-on becomes the source of truth if it exists and falls
> >>> back to existing common bindings if "depends-on" isn't present -- then
> >>> depends-on would truly be overriding existing bindings for
> >>> dependencies. It depends on how we want to define the DT property.
> >>>
> >>>> The phandle already implies the dependency.
> >>>
> >>> Sure, it might imply, but it's not always true.
> >>>
> >>>> Creating a separate
> >>>> depends-on property provides a method of ignoring the implied
> >>>> dependencies.
> >>>
> >>> implied != true
> >>>
>
> I refer to your irq mode vs polled mode device example:
>
> >>>> This is not just hardware description.  It is instead a combination
> >>>> of hardware functionality and driver functionality.  An example
> >>>> provided in the second paragraph of the email I am replying to
> >>>> suggests a device could operate in polling mode if no IRQ is
> >>>> available.  Using this example, the devicetree does not know
> >>>> whether the driver requires the IRQ (currently an implied
> >>>> dependency since the IRQ phandle exists).  My understanding
> >>>> of this example is that the device node would _not_ have a
> >>>> depends-on property for the IRQ phandle so the IRQ would be
> >>>> optional.  But this is an attribute of the driver, not the
> >>>> hardware.
> >>>
> >>
>
> You change the subject from irq mode vs polled mode device to some
> other type of device:
>
> >>> Not really. The interrupt could be for "SD card plugged in". That's
> >>> never a mandatory dependency for the SD card controller to work. So
> >>> the IRQ provider won't be a "depends-on" in this case. But if there is
> >>> no power supply or clock for the SD card controller, it isn't going to
> >>> work -- so they'd be listed in the "depends-on". So, this is still
> >>> defining the hardware and not the OS.
> >>
>
> I again try to get you to discuss the irq mode vs polled mode device:
>
> >> Please comment on my observation that was based on an IRQ for a device
> >> will polling mode vs interrupt driven mode.
> >> You described a different
> >> case and did not address my comment.
> > > I thought I did reply -- not sure what part you are looking for so
> > I'll rephrase. I was just picking the SD card controller as a concrete
> > example of device that can work with or without an interrupt. But
> > sure, I can call it "the device".
> >
>
> And the thread is so deeply nested that you are missing the original
> point that I made.
>
> > And yes, the device won't have a "depends-on" on the IRQ provider
> > because the device can still work without a working (as in bound to
> > driver) IRQ provider. Whether the driver insists on waiting on an IRQ
> > provider or not is up to the driver and the depends-on property is NOT
> > trying to dictate what the driver should do in this case. Does that
> > answer your implied question?
>
> If the device _must_ operate in irq mode to achieve the throughput
> that is _required_ for the system to be functional then that system
> would need a devicetree to have a "depends-on" property for the irq.
> But another system using the same exact hardware might be able to
> tolerate the reduced throughput of operating in polled mode.  This
> second system would need a devicetree that does _not_ have a
> depends-on property for that same irq, as used by that same device.

Thanks for clarifying the point. I see the difference in our view points.

The way I see it, on the system where the device must operate in IRQ
mode to meet performance requirements, the DRIVER would choose to
always -EPROBE_DEFER till it gets the IRQ. Or if it's BSD or Windows
or whatever other theoretical OS that is trying to use the same DT
blob, it'll follow whatever mechanism that OS provides for waiting for
the IRQ to become available.
On the system where not having the IRQ is okay, the DRIVER would not
EPROBE_DEFER and just go to using polling mode.
In both these cases I don't expect the depends-on to list the IRQ provider.

I have more to say but I'll say that in the RESEND thread as a reply
to your other email.

-Saravana
