Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1870FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C307F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6COAwWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406461AbfFKUIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:08:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37582 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406095AbfFKUIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:08:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id r10so13173523otd.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wu5V06JjvlYtLTYwOjXCUcwHA/ZXRKacudSVXc/qyLM=;
        b=t6COAwWiGhiE/0DvQedmgVW+ApWldYJ1b0mFdPv1RNHG9589h2kf28P4YxhTpyX6tN
         C55kpbk5rtDosu6tmN6tUUkuDn+dWAobmudYFI/CZbvT1Wybtn3R54j4oSleCx6fozlb
         ZC4PozSCM4+3sO02nef3OkrqCeqO6DE7dzoY8m5ufccwJDU5G6Gg2Hzj5b++YjTlkqHc
         MuO0O4fho0IL4bmgoA+/suPDF7F7/0zrpS5PQ4oyyWzijQpDxCfSPHVF41iaLYdC3F6W
         HhMCi4VVLujvvZ3pl15SgVvcf7C9fEu4pkaJ96T2ZMV7nFQ8XOOp4lyzwvyBD8K+HvDd
         HPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wu5V06JjvlYtLTYwOjXCUcwHA/ZXRKacudSVXc/qyLM=;
        b=ajaznEF8yrgpH+GtFugluYhE/rB2p1ujPX40Xvdur7kJmeAy5bDi/1eoZlOexIkgNj
         N3M7FXmApIGYWOV3G2yXC9YO8tl3EHjqpfuXPxYMLHZ2rnZnc7Gp4dk4vpgvxh/2UPZk
         uYgr+VVt20q9rJkwwA/ZjsNzeWoFZv2oqHlNAGixzSkMH62bzBIwQ3TPHDta1Qdk5916
         TyvhuAZRjMKFJA6wsvbLpM9NhtXcBIpGVwAiMUnGP7/T1wvas8aU4U/YMWLyan997o7a
         1ldj4d8EkgnFquKh2PzA9fOlwvfv9flzV4opq+oJS5scYrF/0gcoXT2WP6XjtbsXR9Uk
         Ob6g==
X-Gm-Message-State: APjAAAUiIgLVi0JHHzkRmO9djmej5fihCjubzSNfOoJwmSEgvtbqSnXH
        AVJUnh5JNLgxglXfnAtu0W4UUGWGjcEmAhFYZyHdMA==
X-Google-Smtp-Source: APXvYqzbL4YJmh4Q4/UloaiwtpLeN2icmCmXUWR5ClxF0zqslixM+AcMA26mq5D9qUJsInSzM1xRnVR8dZbsRi8BSeI=
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr35503170otp.225.1560283714379;
 Tue, 11 Jun 2019 13:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com> <20190524010117.225219-2-saravanak@google.com>
 <6f4ca588-106f-93d1-8579-9e8d32c8031d@gmail.com> <CAGETcx9zgMs5ne3jPa+6xR+EHR=+QuF7XfRb1gpenh-3ZQwV+w@mail.gmail.com>
 <b3a88f46-5c3b-0e33-e08f-e0d9b5df2864@gmail.com> <b272ae7b-dcc6-acda-78b2-92eace0b6978@gmail.com>
In-Reply-To: <b272ae7b-dcc6-acda-78b2-92eace0b6978@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 11 Jun 2019 13:07:58 -0700
Message-ID: <CAGETcx9nP8OUV1qX43UwfeJV=95cKrHgCm7wjQ96KHouDKm-Mg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
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

On Tue, Jun 11, 2019 at 7:51 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Saravana,
>
> (I notice that I never seem to spell your name correctly.  Apologies for that,
> both past and future).

Thanks for noticing :) One trick that might help with remembering my
name is that every other letter is an "a" :)

>
> This email was never answered.

Yeah, because this patch wasn't central to the functionality. At worse
case, I drop the patch and modules would still work. While waiting for
responses for the other emails -- I was working on measuring the speed
up.

If I just took the clock bindings (in a final solution we'll have to
look up clocks, resets, regulators, interrupts, etc) in a SDM845 and
made them into device links, that resulted in ~500+ searches for
devices by their nodes.

Looking at all 500+ of the lookups:

Total time:
With patch, : 2 milliseconds
Without patch: 12 milliseconds

Worst case single look up:
With patch: 39 microseconds
Without patch: 250 microseconds

Median of lookup times:
With patch: 208 nanoseconds
Without patch: 23 microseconds

Even if I assume there are 1000 device nodes, the increase in memory
from one additional pointer this patch adds is ~8KB.
2GB is the low ball on the amount of memory available in a typical
SDM845 device.
Boot time to userspace on the device Iooked at is: 1149 ms
So total boot time reduction is 0.8%
Total memory increase is 0.00038%

Once more device links are added I expect the boot time impact to be
larger. I think a 1% reduction in boot time for 0.00038% increase in
memory usage is a good trade off.

That 1% faster boot time can also be approximated to 1% reduction in
boot up power usage. That scaled to a million or billion devices
that'll run an Android or some form of ARM Linux kernel is still a
good chunk of energy savings for a small memory increase.

I still stand by the usefulness of this patch, but this is not the
hill I'm going to die on (so if dropping this patch is what it takes
to get modules working, I'll drop it for now).

-Saravana

>
> -Frank
>
>
> On 5/24/19 5:12 PM, Frank Rowand wrote:
> > On 5/24/19 11:21 AM, Saravana Kannan wrote:
> >> On Fri, May 24, 2019 at 10:56 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>
> >>> Hi Sarvana,
> >>>
> >>> I'm not reviewing patches 1-5 in any detail, given my reply to patch 0.
> >>>
> >>> But I had already skimmed through this patch before I received the
> >>> email for patch 0, so I want to make one generic comment below,
> >>> to give some feedback as you continue thinking through possible
> >>> implementations to solve the underlying problems.
> >>
> >> Appreciate the feedback Frank!
> >>
> >>>
> >>>
> >>> On 5/23/19 6:01 PM, Saravana Kannan wrote:
> >>>> Add a pointer from device tree node to the device created from it.
> >>>> This allows us to find the device corresponding to a device tree node
> >>>> without having to loop through all the platform devices.
> >>>>
> >>>> However, fallback to looping through the platform devices to handle
> >>>> any devices that might set their own of_node.
> >>>>
> >>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>>> ---
> >>>>  drivers/of/platform.c | 20 +++++++++++++++++++-
> >>>>  include/linux/of.h    |  3 +++
> >>>>  2 files changed, 22 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >>>> index 04ad312fd85b..1115a8d80a33 100644
> >>>> --- a/drivers/of/platform.c
> >>>> +++ b/drivers/of/platform.c
> >>>> @@ -42,6 +42,8 @@ static int of_dev_node_match(struct device *dev, void *data)
> >>>>       return dev->of_node == data;
> >>>>  }
> >>>>
> >>>> +static DEFINE_SPINLOCK(of_dev_lock);
> >>>> +
> >>>>  /**
> >>>>   * of_find_device_by_node - Find the platform_device associated with a node
> >>>>   * @np: Pointer to device tree node
> >>>> @@ -55,7 +57,18 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
> >>>>  {
> >>>>       struct device *dev;
> >>>>
> >>>> -     dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
> >>>> +     /*
> >>>> +      * Spinlock needed to make sure np->dev doesn't get freed between NULL
> >>>> +      * check inside and kref count increment inside get_device(). This is
> >>>> +      * achieved by grabbing the spinlock before setting np->dev = NULL in
> >>>> +      * of_platform_device_destroy().
> >>>> +      */
> >>>> +     spin_lock(&of_dev_lock);
> >>>> +     dev = get_device(np->dev);
> >>>> +     spin_unlock(&of_dev_lock);
> >>>> +     if (!dev)
> >>>> +             dev = bus_find_device(&platform_bus_type, NULL, np,
> >>>> +                                   of_dev_node_match);
> >>>>       return dev ? to_platform_device(dev) : NULL;
> >>>>  }
> >>>>  EXPORT_SYMBOL(of_find_device_by_node);
> >>>> @@ -196,6 +209,7 @@ static struct platform_device *of_platform_device_create_pdata(
> >>>>               platform_device_put(dev);
> >>>>               goto err_clear_flag;
> >>>>       }
> >>>> +     np->dev = &dev->dev;
> >>>>
> >>>>       return dev;
> >>>>
> >>>> @@ -556,6 +570,10 @@ int of_platform_device_destroy(struct device *dev, void *data)
> >>>>       if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
> >>>>               device_for_each_child(dev, NULL, of_platform_device_destroy);
> >>>>
> >>>> +     /* Spinlock is needed for of_find_device_by_node() to work */
> >>>> +     spin_lock(&of_dev_lock);
> >>>> +     dev->of_node->dev = NULL;
> >>>> +     spin_unlock(&of_dev_lock);
> >>>>       of_node_clear_flag(dev->of_node, OF_POPULATED);
> >>>>       of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
> >>>>
> >>>> diff --git a/include/linux/of.h b/include/linux/of.h
> >>>> index 0cf857012f11..f2b4912cbca1 100644
> >>>> --- a/include/linux/of.h
> >>>> +++ b/include/linux/of.h
> >>>> @@ -48,6 +48,8 @@ struct property {
> >>>>  struct of_irq_controller;
> >>>>  #endif
> >>>>
> >>>> +struct device;
> >>>> +
> >>>>  struct device_node {
> >>>>       const char *name;
> >>>>       phandle phandle;
> >>>> @@ -68,6 +70,7 @@ struct device_node {
> >>>>       unsigned int unique_id;
> >>>>       struct of_irq_controller *irq_trans;
> >>>>  #endif
> >>>> +     struct device *dev;             /* Device created from this node */
> >>>
> >>> We have actively been working on shrinking the size of struct device_node,
> >>> as part of reducing the devicetree memory usage.  As such, we need strong
> >>> justification for adding anything to this struct.  For example, proof that
> >>> there is a performance problem that can only be solved by increasing the
> >>> memory usage.
> >>
> >> I didn't mean for people to focus on the deferred probe optimization.
> >
> > I was speaking specifically of the of_find_device_by_node() optimization.
> > I did not chase any further back in the call chain to see how that would
> > impact anything else.  My comments stand, whether this patch is meant
> > to optimize deferred probe optimization or to optimize something else.
> >
> >
> >> In reality that was just a added side benefit of this series. The main
> >> problem to solve is that of suppliers having to know when all their
> >> consumers are up and managing the resources actively, especially in a
> >> system with loadable modules where we can't depend on the driver to
> >> notify the supplier because the consumer driver module might not be
> >> available or loaded until much later.
> >>
> >> Having said that, I'm not saying we should go around and waste space
> >> willy-nilly. But, isn't the memory usage going to increase based on
> >> the number of DT nodes present in DT? I'd think as the number of DT
> >> nodes increase it's more likely for those devices have more memory? So
> >> at least in this specific case I think adding the field is justified.
> >
> > Struct device_node is the nodes of the in kernel devicetree data.  This
> > patch adds a field to every single node of the devicetree.
> >
> > The patch series is also adding a new property, of varying size, to
> > some nodes.  This also results in additional memory usage by
> > devicetree.
> >
> > Arguing that a more complex system is likely to have more memory is
> > likely true, but beside the point.  Minimizing devicetree memory
> > used on less complex systems is also one of our goals.
> >
> >
> >> Also, right now the look up is O(n) complexity and if we are trying to
> >> add device links to most of the devices, that whole process becomes
> >> O(n^2). Having this field makes the look up a O(1) and the entire
> >> linking process a O(n) process. I think the memory usage increase is
> >> worth the efficiency improvement.
> >
> > Hand waving about O(n) and O(1) and O(n2) is not sufficient.  We require
> > actual measurements that show O(n2) (when the existing algorithm is such)
> > is a performance problem and that the proposed change to the algorithm
> > results in a specific change in the performance.
> >
> > The devicetree maintainers have decided that memory use is important and
> > to be minimized, and the burden of proof that performance is an issue
> > lies on the submitter of a patch that improves performance at the cost
> > of memory.
> >
> > Most devicetree boot time cpu overhead only affects the boot event.
> > Added memory use persists for the entire booted lifetime of the system.
> >
> > That is not to say that we never increase memory use to improve boot
> > performance.  We have done so when the measured performance issue and
> > measured performance improvement justified the change.
> >
> >>
> >> And if people are still strongly against it, we could make this a config option.
> >>
> >> -Saravana
> >>
> >
> >
>
