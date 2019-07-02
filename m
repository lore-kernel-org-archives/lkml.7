Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419ABC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD6321479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvXLX5r0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGBDZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:25:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39447 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfGBDZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:25:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so15064071otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 20:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHGF7VMQI7XpbRIIhAwMxS2GHFW+rRDDlK2JWUOPEgE=;
        b=QvXLX5r0YZB9lmN2nLXR/1agzDkcATg10L5l1wPAjnSUk3yG4S0pKdJTn8ki4OXllW
         Vxag2hu4q2FeyCR63o0yPcLgyzlAEgPStnXvUB734X7pSzS8cuyZfqREz6jwgfyHJVJo
         RaPmo9ACBri2i2Fh4W+xU7LGDrtWPebX4v7zNSRP653WSlKqWiN8pFvH2GID1xBGbZR6
         9hkntYcPWXxvG5RAhsvQw0pcLBVQ6QIGSK87nryn2Pi2FdEw884ZDpVsiPxzDFhhtcPe
         RahP5UH/bfYTHAW0BdCi/+tbKSEWC7JtSl0tmqKTs0FvYnETHx64Y/QrpMf2xzVRepoI
         KHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHGF7VMQI7XpbRIIhAwMxS2GHFW+rRDDlK2JWUOPEgE=;
        b=ZEtuo2JsJaZAkTx6kiGYDhS6ThVkLDaTgB6mOc/e20DfcBLB1iKlz0/7+BKUYr1pFv
         ayBVC4zaEWG8XRXUGzm0akTw4OMmjxhJerq02gNxijPXC68/LRY5U+K2tz0EOoe0hWqj
         pQwMwtU7Wt3jU3MJA85Kv+zl0as2H/J4YgicXbCu5u7IHfRf9It4kUoHe0t+02oNl2ld
         ehyiLaozPN6Mfm1S8MHdxS1qdxsmnNWzJ5rSdotWMG05As6qKBNR1me6rCkFftOvAjy+
         r9239955u0kBeZaC1K6NqQ2QfyddcoidUeND5Cc/hpkK1+4ZCDXfQESt1uOeTcXANM++
         CLAQ==
X-Gm-Message-State: APjAAAWxkzBhsNnmsJj4QOHpNTL40r6xcgGZLRbOKX/CM0EqsuXc6s3O
        s+CllE5Pj10gzaoCnbpsTCenz9o25PxFaYm2oyXPHw==
X-Google-Smtp-Source: APXvYqxjXzORSDw2eIRGi7Dn1JJFQLdnvYvYI3ay/pRZ46abc9t0OFoCANmmhhscaXeU7MYSx98U5DYT8f8rG8cGBLk=
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr18846471otp.225.1562037942860;
 Mon, 01 Jul 2019 20:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com> <20190702004811.136450-3-saravanak@google.com>
 <CAL_JsqLdvDpKB=iV6x3eTr2F4zY0bxU-Wjb+JeMjj5rdnRc-OQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLdvDpKB=iV6x3eTr2F4zY0bxU-Wjb+JeMjj5rdnRc-OQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 1 Jul 2019 20:25:06 -0700
Message-ID: <CAGETcx_i9353aRFbJXNS78EvqwmU-2-xSBJ+ySZX1gjjHpz_cg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] of/platform: Add functional dependency link from
 DT bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 6:32 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jul 1, 2019 at 6:48 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Add device-links after the devices are created (but before they are
> > probed) by looking at common DT bindings like clocks and
> > interconnects.
> >
> > Automatically adding device-links for functional dependencies at the
> > framework level provides the following benefits:
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
> > - Supplier devices like clock providers, interconnect providers, etc
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
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/Kconfig    |  9 ++++++++
> >  drivers/of/platform.c | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index 37c2ccbefecd..7c7fa7394b4c 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -103,4 +103,13 @@ config OF_OVERLAY
> >  config OF_NUMA
> >         bool
> >
> > +config OF_DEVLINKS
>
> I'd prefer this not be a config option. After all, we want one kernel
> build that works for all platforms.

We need a lot more changes before one kernel build can work for all
platforms. At least until then, I think we need this. Lot less chance
of breaking existing platforms before all the missing pieces are
created.

> A kernel command line option to disable might be useful for debugging.

Or we can have a command line to enable this for platforms that want
to use it and have it default off.

> > +       bool "Device links from DT bindings"
> > +       help
> > +         Common DT bindings like clocks, interconnects, etc represent a
> > +         consumer device's dependency on suppliers devices. This option
> > +         creates device links from these common bindings so that consumers are
> > +         probed only after all their suppliers are active and suppliers can
> > +         tell when all their consumers are active.
> > +
> >  endif # OF
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 04ad312fd85b..a53717168aca 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -61,6 +61,57 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
> >  EXPORT_SYMBOL(of_find_device_by_node);
> >
> >  #ifdef CONFIG_OF_ADDRESS
> > +static int of_link_binding(struct device *dev, char *binding, char *cell)
>
> Under CONFIG_OF_ADDRESS seems like a strange location.

Yeah, but the rest of the file seems to be under this. So I'm not
touching that. I can probably move this function further down (close
to platform populate) if you want that.
>
> > +{
> > +       struct of_phandle_args sup_args;
> > +       struct platform_device *sup_dev;
> > +       unsigned int i = 0, links = 0;
> > +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> > +
> > +       while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
> > +                                          &sup_args)) {
> > +               i++;
> > +               sup_dev = of_find_device_by_node(sup_args.np);
> > +               if (!sup_dev)
> > +                       continue;
> > +               if (device_link_add(dev, &sup_dev->dev, dl_flags))
> > +                       links++;
> > +               put_device(&sup_dev->dev);
> > +       }
> > +       if (links < i)
> > +               return -ENODEV;
> > +       return 0;
> > +}
> > +
> > +/*
> > + * List of bindings and their cell names (use NULL if no cell names) from which
> > + * device links need to be created.
> > + */
> > +static char *link_bindings[] = {
>
> const

Ack

>
> > +#ifdef CONFIG_OF_DEVLINKS
> > +       "clocks", "#clock-cells",
> > +       "interconnects", "#interconnect-cells",
>
> Planning to add others?

Not in this patch.

Regulators are the other big missing piece that I'm aware of now but
they need a lot of discussion (see email from David and my reply).

Not sure what other resources are shared where they can be "turned
off" and cause devices set up at boot to fail. For example, I don't
think interrupts need functional dependency tracking because they
aren't really turned off by consumer 1 in a way that breaks things for
consumer 2. Just masked and the consumer 2 can unmask and use it once
it probes.

I'm only intimately familiar with clocks, interconnects and regulators
(to some extent). I'm open to adding other supplier categories in
future patches as I educate myself of those or if other people want to
add support for more categories.

-Saravana

> > +#endif
> > +};
> > +
> > +static int of_link_to_suppliers(struct device *dev)
> > +{
> > +       unsigned int i = 0;
> > +       bool done = true;
> > +
> > +       if (unlikely(!dev->of_node))
> > +               return 0;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
> > +               if (of_link_binding(dev, link_bindings[i * 2],
> > +                                       link_bindings[i * 2 + 1]))
> > +                       done = false;
> > +
> > +       if (!done)
> > +               return -ENODEV;
> > +       return 0;
> > +}
> > +
> >  /*
> >   * The following routines scan a subtree and registers a device for
> >   * each applicable node.
> > @@ -524,6 +575,7 @@ static int __init of_platform_default_populate_init(void)
> >         if (!of_have_populated_dt())
> >                 return -ENODEV;
> >
> > +       platform_bus_type.add_links = of_link_to_suppliers;
> >         /*
> >          * Handle certain compatibles explicitly, since we don't want to create
> >          * platform_devices for every node in /reserved-memory with a
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
