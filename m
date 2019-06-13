Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2C62054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560439063;
	bh=tiOM6s1e3Yxb9Buj5nqBgGoEmTjuEMI0MPr9x1nrxwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yh7mrTl4+N+Ry3Al63gx1pqHDa3cNJ3b9BqskGpz7Q0919qqYpGGgzPWt4NyVd1sQ
	 5w2JKeLLqvljfuKRijkW3W7sOHWYwYFOvbnHXJ77qHLsKgCZPD4D61bHwNp+WluucK
	 n8g3Lb5KpIQ/EpCg4OIhtcrS822d4KAdTYpD0W44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbfFMPRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732179AbfFMNTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:19:51 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31EE217D7;
        Thu, 13 Jun 2019 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560431989;
        bh=tiOM6s1e3Yxb9Buj5nqBgGoEmTjuEMI0MPr9x1nrxwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KSVrU877UOAyC6Zkr+pIM6BK1VRggfQ++RYMYuGtj8JbaIYyQOIBRZk/+/i42W6p4
         kE1k0xgZ5EY2fiXXUP0XZViozP+qTwhDmIn3YHBViqS30J37Qx3IwRNCUqOgn8PAGs
         D5dzPOyuTcUrzm5l3WmGukhzsH6KF44Cd/BpM3KE=
Received: by mail-qk1-f170.google.com with SMTP id g18so12708195qkl.3;
        Thu, 13 Jun 2019 06:19:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUmKojIFn7lazvq9P+oDP0XoRJn2evwcT+ZmPW0W005cwaM0oXc
        NeFv/x+nzZq0TPtsvSurbHQNNohj3vqj/vUV6Q==
X-Google-Smtp-Source: APXvYqy4HLIEZMTKtHpWWUtJQ72uNV0Rwv6pVblqYItO2sXmSU2d/lB94Van4E7i3A34NFCBlMZMyjmpFcFsMo7Njvw=
X-Received: by 2002:a37:a6c9:: with SMTP id p192mr73052442qke.184.1560431988769;
 Thu, 13 Jun 2019 06:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <095b631b-155d-483e-5ffb-3a04b0db0245@gmail.com>
In-Reply-To: <095b631b-155d-483e-5ffb-3a04b0db0245@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Jun 2019 07:19:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLFTfAN5UZ8yy+z5fAXBa83JU0FGVDKzpu7pMLi10jvZQ@mail.gmail.com>
Message-ID: <CAL_JsqLFTfAN5UZ8yy+z5fAXBa83JU0FGVDKzpu7pMLi10jvZQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and
 optimize probe ordering
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 3:21 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Adding cc: David Collins
>
> Plus my comments below.
>
> On 6/3/19 5:32 PM, Saravana Kannan wrote:
> > Add a generic "depends-on" property that allows specifying mandatory
> > functional dependencies between devices. Add device-links after the
> > devices are created (but before they are probed) by looking at this
> > "depends-on" property.
> >
> > This property is used instead of existing DT properties that specify
> > phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
> > is because not all resources referred to by existing DT properties are
> > mandatory functional dependencies. Some devices/drivers might be able
> > to operate with reduced functionality when some of the resources
> > aren't available. For example, a device could operate in polling mode
> > if no IRQ is available, a device could skip doing power management if
> > clock or voltage control isn't available and they are left on, etc.
> >
> > So, adding mandatory functional dependency links between devices by
> > looking at referred phandles in DT properties won't work as it would
> > prevent probing devices that could be probed. By having an explicit
> > depends-on property, we can handle these cases correctly.
> >
> > Having functional dependencies explicitly called out in DT and
> > automatically added before the devices are probed, provides the
> > following benefits:
> >
> > - Optimizes device probe order and avoids the useless work of
> >   attempting probes of devices that will not probe successfully
> >   (because their suppliers aren't present or haven't probed yet).
> >
> >   For example, in a commonly available mobile SoC, registering just
> >   one consumer device's driver at an initcall level earlier than the
> >   supplier device's driver causes 11 failed probe attempts before the
> >   consumer device probes successfully. This was with a kernel with all
> >   the drivers statically compiled in. This problem gets a lot worse if
> >   all the drivers are loaded as modules without direct symbol
> >   dependencies.
> >
> > - Supplier devices like clock providers, regulators providers, etc
> >   need to keep the resources they provide active and at a particular
> >   state(s) during boot up even if their current set of consumers don't
> >   request the resource to be active. This is because the rest of the
> >   consumers might not have probed yet and turning off the resource
> >   before all the consumers have probed could lead to a hang or
> >   undesired user experience.
> >
> >   Some frameworks (Eg: regulator) handle this today by turning off
> >   "unused" resources at late_initcall_sync and hoping all the devices
> >   have probed by then. This is not a valid assumption for systems with
> >   loadable modules. Other frameworks (Eg: clock) just don't handle
> >   this due to the lack of a clear signal for when they can turn off
> >   resources. This leads to downstream hacks to handle cases like this
> >   that can easily be solved in the upstream kernel.
> >
> >   By linking devices before they are probed, we give suppliers a clear
> >   count of the number of dependent consumers. Once all of the
> >   consumers are active, the suppliers can turn off the unused
> >   resources without making assumptions about the number of consumers.
> >
> > By default we just add device-links to track "driver presence" (probe
> > succeeded) of the supplier device. If any other functionality provided
> > by device-links are needed, it is left to the consumer/supplier
> > devices to change the link when they probe.
> >
> >
> > Saravana Kannan (5):
> >   of/platform: Speed up of_find_device_by_node()
> >   driver core: Add device links support for pending links to suppliers
> >   dt-bindings: Add depends-on property
> >   of/platform: Add functional dependency link from "depends-on" property
> >   driver core: Add sync_state driver/bus callback
> >
> >  .../devicetree/bindings/depends-on.txt        |  26 +++++
> >  drivers/base/core.c                           | 106 ++++++++++++++++++
> >  drivers/of/platform.c                         |  75 ++++++++++++-
> >  include/linux/device.h                        |  24 ++++
> >  include/linux/of.h                            |   3 +
> >  5 files changed, 233 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/depends-on.txt
> >
>
>
> I don't think the above description adequately describes one key problem
> that the patch set addresses.
>
> David Collins described the problem in an email late in the thread of
> the first submission of this series.  Instead of providing a link to
> that email, I am going to fully copy it here:
>
> On 5/31/19 4:27 PM, David Collins wrote:
> > Hello Saravana,
> >
> > On 5/23/19 6:01 PM, Saravana Kannan wrote:
> > ...
> >> Having functional dependencies explicitly called out in DT and
> >> automatically added before the devices are probed, provides the
> >> following benefits:
> > ...
> >> - Supplier devices like clock providers, regulators providers, etc
> >>   need to keep the resources they provide active and at a particular
> >>   state(s) during boot up even if their current set of consumers don't
> >>   request the resource to be active. This is because the rest of the
> >>   consumers might not have probed yet and turning off the resource
> >>   before all the consumers have probed could lead to a hang or
> >>   undesired user experience.
> > This benefit provided by the sync_state() callback function introduced in
> > this series gives us a mechanism to solve a specific problem encountered
> > on Qualcomm Technologies, Inc. (QTI) boards when booting with drivers
> > compiled as modules.  QTI boards have a regulator that powers the PHYs for
> > display, camera, USB, UFS, and PCIe.  When these boards boot up, the boot
> > loader enables this regulator along with other resources in order to
> > display a splash screen image.  The regulator must remain enabled until
> > the Linux display driver has probed and made a request with the regulator
> > framework to keep the regulator enabled.  If the regulator is disabled
> > prematurely, then the screen image is corrupted and the display hardware
> > enters a bad state.
> >
> > We have observed that when the camera driver probes before the display
> > driver, it performs this sequence: regulator_enable(), camera register IO,
> > regulator_disable().  Since it is the first consumer of the shared
> > regulator, the regulator is physically disabled (even though display
> > hardware still requires it to be enabled).  We have solved this problem
> > when compiling drivers statically with a downstream regulator
> > proxy-consumer driver.  This proxy-consumer is able to make an enable
> > request for the shared regulator before any other consumer.  It then
> > removes its request at late_initcall_sync.
> >
> > Unfortunately, when drivers are compiled as modules instead of compiled
> > statically into the kernel image, late_initcall_sync is not a meaningful
> > marker of driver probe completion.  This means that our existing proxy
> > voting system will not work when drivers are compiled as modules.  The
> > sync_state() callback resolves this issue by providing a notification that
> > is guaranteed to arrive only after all consumers of the shared regulator
> > have probed.
> >
> > QTI boards have other cases of shared resources such as bus bandwidth
> > which must remain at least at a level set by boot loaders in order to
> > properly support hardware blocks that are enabled before the Linux kernel
> > starts booting.
> >
> > Take care,
> > David
> >
>
> To paraphrase, the problem is:
>
>    - bootloader enables a regulator for display
>    - during Linux boot camera driver probes:
>       * enable the regulator also used for display
>       * disable the regulator
>          + screen image is corrupted
>          + display hardware enters bad state
>    - later during Linux boot display driver probes:
>       * enable the regulator, but too late
>
> So the problem is an ordering dependency between the camera driver probe
> and the display driver probe.
>
> Or alternatively the problem could be seen as: the bootloader has enabled
> a regulator for a device that the bootloader is aware of, but has not
> communicated to the Linux regulator framework that the device requires
> the regulator to remain enabled.

The bootloader should have communicated this information via the
'simple-framebuffer' binding. The problem is I think we don't have any
mechanism to ensure the simple-fb driver probes before other drivers
(other than it's dependencies). Well, there are initcall levels, but
I'd really like to get rid of any reliance on that. Anything that
relies on initcall level ordering is not going to work as module
unless userspace also ensures the ordering.

The other case I've heard of is the serial port's clock getting
disabled and killing the earlycon as we assume the bootloader left
serial port dependencies configured.

> Thinking about the problem this way could lead to an entirely different
> solution.

I think the ordering issue is orthogonal to using modules. We need
some way to prioritize probing of some devices. IMO, just prioritizing
the 'stdout-path' device and 'simple-framebuffer' if present solves
this. I don't think we need a general solution in this case. The may
be a few other cases, but I think these are the exception. The state
from the bootloader (and don't forget about kexec) needs to be well
defined and minimal.

Rob
