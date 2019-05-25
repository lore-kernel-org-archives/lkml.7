Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3297DC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 04:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4AA2175B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 04:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbdTUK7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfEYEFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 00:05:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39117 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfEYEFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 00:05:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id r7so10475024otn.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 21:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60yASukqnvCrY7UNM6CcL3GGuSbOWBWxqRr9ejoMe/A=;
        b=PbdTUK7ERJjzvmM9TvSr/PgE5860t30pMKCQtMmHOx7ZJ/i15i4QfEVvs/4FgXkuWd
         VOq5K7HQvS1y9uxDuQhdJ6mgFk6WvDcqEOVvO+y09M5JwqUejAwJoOznpTPPrwTy9Rwi
         hc3zq4w3Gl8fVusLg9bQ8b15kyw8uB3EMX6tN9l97fsdlB4oXgQwHIIgsGRf+uszcKlI
         bc/bhPGJaanrMI0mqO5bkY23kQFVSrWltLkv34na0L/o5rId2kz46IXVwPQG1oquCTu8
         V0YdMmd2jKJ/NxIzcCbk9Bs+LIvigTuLJzkqeW69AN48+121DKM5Za8cBl9K6JfyXPv5
         MLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60yASukqnvCrY7UNM6CcL3GGuSbOWBWxqRr9ejoMe/A=;
        b=cXclUu2hslaRfEeRCSf57kp9W5vn/ZuQ7bPqXXdJsQwCMl6QTFjlifXS2MgS1rj1Xs
         5wbuLVkr+/VbDKP2LFBzvCJGE3cBnkfdauQJ27kK0byXKySDB144+Wxj1dh0Xx7cNh7C
         84XZ1LgV/4jf2DK6wdC1xVAp8wOVoF6zQ989ewpMe/NYJvVresTwlaNqy7FiGJoP96Vm
         T6EY+I+mfHcOk3Kj14fxDfVf7vvFa86zKoKSRkFKPIiXaq1MFQrAPYoJIUIQcOXAtXUv
         14npiNPbryzfUbJW0il6jmjWGTDSjPe9enrCNCDm3UmDAXDpwSk9Sc27Vzv/bZJm/CNy
         soyw==
X-Gm-Message-State: APjAAAWUvVHmEj50bg9VGrxPoSXvBXUn9a2mzwtwTecPQ4VEju8m3VH8
        1egSTy/Tgpv2AyZgardsLrPkzdfPnjcQnSs70FQM5g==
X-Google-Smtp-Source: APXvYqyq1/1AXMjMvK9E9mZhEz510iSobB5EXGgFOle0cwnxqxiIiZo62rjOL9wF4iqk1nN7P9yUBNh0Bj9BGTHS7f8=
X-Received: by 2002:a9d:3b49:: with SMTP id z67mr53415554otb.236.1558757112838;
 Fri, 24 May 2019 21:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com> <06b479e2-e8a0-b3e8-567c-7fa0f1c5bdf6@gmail.com>
 <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com> <d49dccee-203a-628a-8e47-191014619f6b@gmail.com>
In-Reply-To: <d49dccee-203a-628a-8e47-191014619f6b@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 24 May 2019 21:04:36 -0700
Message-ID: <CAGETcx-HPsxdwMfUJDUBvjpiuK9eyRCYRhqsXxiL5Q8g+YgHEg@mail.gmail.com>
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

On Fri, May 24, 2019 at 7:40 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Saranova,
>
> I'll try to address the other portions of this email that I <snipped>
> in my previous replies.
>
>
> On 5/24/19 2:53 PM, Saravana Kannan wrote:
> > On Fri, May 24, 2019 at 10:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 5/23/19 6:01 PM, Saravana Kannan wrote:
> >>> Add a generic "depends-on" property that allows specifying mandatory
> >>> functional dependencies between devices. Add device-links after the
> >>> devices are created (but before they are probed) by looking at this
> >>> "depends-on" property.
> >>>
> >>> This property is used instead of existing DT properties that specify
> >>> phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
> >>> is because not all resources referred to by existing DT properties are
> >>> mandatory functional dependencies. Some devices/drivers might be able> to operate with reduced functionality when some of the resources
> >>> aren't available. For example, a device could operate in polling mode
> >>> if no IRQ is available, a device could skip doing power management if
> >>> clock or voltage control isn't available and they are left on, etc.
> >>>
> >>> So, adding mandatory functional dependency links between devices by
> >>> looking at referred phandles in DT properties won't work as it would
> >>> prevent probing devices that could be probed. By having an explicit
> >>> depends-on property, we can handle these cases correctly.
> >>
> >> Trying to wrap my brain around the concept, this series seems to be
> >> adding the ability to declare that an apparent dependency (eg an IRQ
> >> specified by a phandle) is _not_ actually a dependency.
> >
> > The current implementation completely ignores existing bindings for
> > dependencies and so does the current tip of the kernel. So it's not
> > really overriding anything. However, if I change the implementation so
> > that depends-on becomes the source of truth if it exists and falls
> > back to existing common bindings if "depends-on" isn't present -- then
> > depends-on would truly be overriding existing bindings for
> > dependencies. It depends on how we want to define the DT property.
> >
> >> The phandle already implies the dependency.
> >
> > Sure, it might imply, but it's not always true.
> >
> >> Creating a separate
> >> depends-on property provides a method of ignoring the implied
> >> dependencies.
> >
> > implied != true
> >
> >> This is not just hardware description.  It is instead a combination
> >> of hardware functionality and driver functionality.  An example
> >> provided in the second paragraph of the email I am replying to
> >> suggests a device could operate in polling mode if no IRQ is
> >> available.  Using this example, the devicetree does not know
> >> whether the driver requires the IRQ (currently an implied
> >> dependency since the IRQ phandle exists).  My understanding
> >> of this example is that the device node would _not_ have a
> >> depends-on property for the IRQ phandle so the IRQ would be
> >> optional.  But this is an attribute of the driver, not the
> >> hardware.
> >
>
> > Not really. The interrupt could be for "SD card plugged in". That's
> > never a mandatory dependency for the SD card controller to work. So
> > the IRQ provider won't be a "depends-on" in this case. But if there is
> > no power supply or clock for the SD card controller, it isn't going to
> > work -- so they'd be listed in the "depends-on". So, this is still
> > defining the hardware and not the OS.
>
> Please comment on my observation that was based on an IRQ for a device
> will polling mode vs interrupt driven mode.
> You described a different
> case and did not address my comment.

I thought I did reply -- not sure what part you are looking for so
I'll rephrase. I was just picking the SD card controller as a concrete
example of device that can work with or without an interrupt. But
sure, I can call it "the device".

And yes, the device won't have a "depends-on" on the IRQ provider
because the device can still work without a working (as in bound to
driver) IRQ provider. Whether the driver insists on waiting on an IRQ
provider or not is up to the driver and the depends-on property is NOT
trying to dictate what the driver should do in this case. Does that
answer your implied question?

>
> >> This is also configuration, declaring whether the
> >> system is willing to accept polling mode instead of interrupt
> >> mode.
> >
> > Whether the driver will choose to operate without the IRQ is up to it.
> > The OS could also assume the power supply is never turned off and
> > still try to use the device. Depending on the hardware configuration,
> > that might or might not work.
> >
> >> Devicetree is not the proper place for driver description or
> >> for configuration.
> >
> > But depends-on isn't describing the driver configuration though.
> >
> > Overall, the clock provider example I gave in another reply is a much
> > better example. If you just assume implied dependencies are mandatory
> > dependencies, some devices will never be probe because the kernel is
> > using them incorrectly (they aren't meant to list mandatory
> > dependencies).
> >
> >> Another flaw with this method is that existing device trees
> >> will be broken after the kernel is modified, because existing
> >> device trees do not have the depends-on property.  This breaks
> >> the devicetree compatibility rules.
> >
> > This is 100% not true with the current implementation. I actually
> > tested this. This is fully backwards compatible. That's another reason
> > for adding depends-on and going by just what it says. The existing
> > bindings were never meant to describe only mandatory dependencies. So
> > using them as such is what would break backwards compatibility.
> >
> >>> Having functional dependencies explicitly called out in DT and
> >>> automatically added before the devices are probed, provides the
> >>> following benefits:
> >>>
> >>> - Optimizes device probe order and avoids the useless work of
> >>>   attempting probes of devices that will not probe successfully
> >>>   (because their suppliers aren't present or haven't probed yet).
> >>>
> >>>   For example, in a commonly available mobile SoC, registering just
> >>>   one consumer device's driver at an initcall level earlier than the
> >>>   supplier device's driver causes 11 failed probe attempts before the
> >>>   consumer device probes successfully. This was with a kernel with all
> >>>   the drivers statically compiled in. This problem gets a lot worse if
> >>>   all the drivers are loaded as modules without direct symbol
> >>>   dependencies.
> >>>
> >>> - Supplier devices like clock providers, regulators providers, etc
> >>>   need to keep the resources they provide active and at a particular
> >>>   state(s) during boot up even if their current set of consumers don't
> >>>   request the resource to be active. This is because the rest of the
> >>>   consumers might not have probed yet and turning off the resource
> >>>   before all the consumers have probed could lead to a hang or
> >>>   undesired user experience.
> >>>
> >>>   Some frameworks (Eg: regulator) handle this today by turning off
> >>>   "unused" resources at late_initcall_sync and hoping all the devices
> >>>   have probed by then. This is not a valid assumption for systems with
> >>>   loadable modules. Other frameworks (Eg: clock) just don't handle
> >>>   this due to the lack of a clear signal for when they can turn off
> >>>   resources. This leads to downstream hacks to handle cases like this
> >>>   that can easily be solved in the upstream kernel.
> >>>
> >>>   By linking devices before they are probed, we give suppliers a clear
> >>
> >> By linking devices to suppliers before they are probed, we give suppliers a clear
> >
> > Ack
> >
> >>>   count of the number of dependent consumers. Once all of the
> >>>   consumers are active, the suppliers can turn off the unused
> >>>   resources without making assumptions about the number of consumers.
> >>>
> >>> By default we just add device-links to track "driver presence" (probe
> >>> succeeded) of the supplier device. If any other functionality provided
> >>> by device-links are needed, it is left to the consumer/supplier
> >>> devices to change the link when they probe.
> >>>
> >>>
> >>> Saravana Kannan (5):
> >>>   of/platform: Speed up of_find_device_by_node()
> >>>   driver core: Add device links support for pending links to suppliers
> >>>   dt-bindings: Add depends-on property
> >>>   of/platform: Add functional dependency link from "depends-on" property
> >>>   driver core: Add sync_state driver/bus callback
> >>>
> >>>  .../devicetree/bindings/depends-on.txt        |  26 +++++
> >>>  drivers/base/core.c                           | 106 ++++++++++++++++++
> >>>  drivers/of/platform.c                         |  75 ++++++++++++-
> >>>  include/linux/device.h                        |  24 ++++
> >>>  include/linux/of.h                            |   3 +
> >>>  5 files changed, 233 insertions(+), 1 deletion(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/depends-on.txt
> >>>
> >>
> >> The above issues make this specific implementation not acceptable.
> >> I like the analysis of the problem areas, and I like the concepts of
> >> trying to solve not only probe ordering, but also the problem of
> >> when to turn off resources that will not be needed.
> >
> > Beating a dead horse here, but I want to make sure I get this into as
> > many minds as possible:
> > It is NOT just about turning off resources. It's about the kernel
> > taking full control of resources (allowing the full range of voltages,
> > clock frequencies, bus configurations, etc) and syncing the HW state
> > to the SW state as determined by the consumers.
> >
> >> But at the
> >> moment, I don't have a suggestion of a way to implement a solution.
> >
> > The problem of syncing resources to SW state after boot up completed
> > has been broken for a long time in the kernel. It's high time we fix
> > it. I'm open to other suggestions, but we can't just say "we don't
> > have a solution".
> >
> > For example, we can have a kernel command line argument that'll use
> > all common implicit bindings as mandatory dependencies and allow
> > "depends-on" to override them for the few cases where the implicit
> > dependencies don't match mandatory dependencies. Then:
> > - The kernel will be 100% backwards compatible with existing DT if the
> > command line arg isn't provided.
> > - New DT + old kernel will be no worse than today because old kernel
> > doesn't do any dependency tracking.
> > - Command line arg + new kernel + hardware where all implicit
> > dependencies are actually mandatory dependencies == things work
> > better.
> > - Command line arg + new kernel + hardware where all implicit
> > dependencies don't match mandatory dependencies + depends-on for those
> > exception case == things work better.
>
> Using a command line argument for this purpose just seems to be a
> hack and bad architecture.

I agree -- which is why the current implementation doesn't try to form
mandatory dependency from implicit bindings and makes the case that
all mandatory dependencies should be called out explicitly. But if
people insist on that implicit bindings be used as such, then a CONFIG
or commandline option would be an acceptable compromise for me.

> It also seems like an invitation to mis-configure a system (in other
> words, increases the complexity and difficulty of properly configuring
> and administering a system).

Just want to point out that, as of today, we have a broken system --
module loading is not compatible with proper handling of shared
mandatory resources during boot up. To be clear, I'm not arguing for a
commandline arg.

> The is not a hard no (yet), but it will take some convincing for me
> to accept the command line approach to add the feature, yet maintain
> compatibility.  Please do not spend any time replying to this concern
> yet - we will have plenty of time to discuss later if need be.

Sounds good.

-Saravana
