Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4713EC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F472182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563374124;
	bh=XiofycBCXyu6VcwheDp6RebLAzg8lu6vzbVWyGNOeI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oJhwgoWG8SWaDlbM21QRiBieWMhFrSseC37gO+Iroie1m7V6s0A5QNn4JnZH/Swbp
	 hCc1vZ+1ZjkkGFKKQ+EevLoACFofUL1VGUjGSqLNdyazNe/9OI4gHhftGOjZEWLoWY
	 XhDHzzC9wiensnsUw03Vwe7Evu60e4JyDuiU+UfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfGQOfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfGQOfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:35:21 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E17321851;
        Wed, 17 Jul 2019 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563374120;
        bh=XiofycBCXyu6VcwheDp6RebLAzg8lu6vzbVWyGNOeI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pt3EMqXQRNjLS9uVx/CUNGtj9qNo73uoxzBcTAOF1On4+vM4oV1xRxhpyF01rNWyP
         aRvQWerRHfTnWIaddW6MQXmClAwm5DhhuiOHBm3MioYpIWKieIkrtvmMm8URNEAhVz
         l0gk26MWziLmrzHKpoGiV9cSKf6ltUHacDex8nxc=
Received: by mail-qt1-f171.google.com with SMTP id k10so23604042qtq.1;
        Wed, 17 Jul 2019 07:35:20 -0700 (PDT)
X-Gm-Message-State: APjAAAXZzmZXW/NWtoqbH8VA+H6kmDAuVH4UOMOBseqX5JbJYcJU5aBz
        39BVxZxEVkiiyrYt4Zo902zp3TZvdDMfI5/+FA==
X-Google-Smtp-Source: APXvYqyKIZb03rg1hDW/gysGPkjbdrC81W6RIUzGSgJcpolRED+45l7jET0MUJp66UpjNMQIw7EYEH1RDJHyanSgpjw=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr29107481qve.148.1563374119179;
 Wed, 17 Jul 2019 07:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com> <20190712235245.202558-3-saravanak@google.com>
 <CAL_JsqJEmC5cttFavGH4iMh=3z2K4r4kjG44AFJCpxQZ9hPwQA@mail.gmail.com> <CAGETcx-5ykD=9X1Lo2-G+T5uokFncbY2FmiJM8eZrgQ9JaBgxw@mail.gmail.com>
In-Reply-To: <CAGETcx-5ykD=9X1Lo2-G+T5uokFncbY2FmiJM8eZrgQ9JaBgxw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 17 Jul 2019 08:35:08 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Dfm8ng1OVcB+1N2ack05v8+u1VydfxM4Ukefqd9XK2w@mail.gmail.com>
Message-ID: <CAL_Jsq+Dfm8ng1OVcB+1N2ack05v8+u1VydfxM4Ukefqd9XK2w@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 5:54 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Jul 16, 2019 at 4:43 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Fri, Jul 12, 2019 at 5:52 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Add device-links after the devices are created (but before they are
> > > probed) by looking at common DT bindings like clocks and
> > > interconnects.
> > >
> > > Automatically adding device-links for functional dependencies at the
> > > framework level provides the following benefits:
> > >
> > > - Optimizes device probe order and avoids the useless work of
> > >   attempting probes of devices that will not probe successfully
> > >   (because their suppliers aren't present or haven't probed yet).
> > >
> > >   For example, in a commonly available mobile SoC, registering just
> > >   one consumer device's driver at an initcall level earlier than the
> > >   supplier device's driver causes 11 failed probe attempts before the
> > >   consumer device probes successfully. This was with a kernel with all
> > >   the drivers statically compiled in. This problem gets a lot worse if
> > >   all the drivers are loaded as modules without direct symbol
> > >   dependencies.
> > >
> > > - Supplier devices like clock providers, interconnect providers, etc
> > >   need to keep the resources they provide active and at a particular
> > >   state(s) during boot up even if their current set of consumers don't
> > >   request the resource to be active. This is because the rest of the
> > >   consumers might not have probed yet and turning off the resource
> > >   before all the consumers have probed could lead to a hang or
> > >   undesired user experience.
> > >
> > >   Some frameworks (Eg: regulator) handle this today by turning off
> > >   "unused" resources at late_initcall_sync and hoping all the devices
> > >   have probed by then. This is not a valid assumption for systems with
> > >   loadable modules. Other frameworks (Eg: clock) just don't handle
> > >   this due to the lack of a clear signal for when they can turn off
> > >   resources. This leads to downstream hacks to handle cases like this
> > >   that can easily be solved in the upstream kernel.
> > >
> > >   By linking devices before they are probed, we give suppliers a clear
> > >   count of the number of dependent consumers. Once all of the
> > >   consumers are active, the suppliers can turn off the unused
> > >   resources without making assumptions about the number of consumers.
> > >
> > > By default we just add device-links to track "driver presence" (probe
> > > succeeded) of the supplier device. If any other functionality provided
> > > by device-links are needed, it is left to the consumer/supplier
> > > devices to change the link when they probe.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  5 ++
> > >  drivers/of/platform.c                         | 57 +++++++++++++++++++
> > >  2 files changed, 62 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 138f6664b2e2..109b4310844f 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3141,6 +3141,11 @@
> > >                         This can be set from sysctl after boot.
> > >                         See Documentation/sysctl/vm.txt for details.
> > >
> > > +       of_devlink      [KNL] Make device links from common DT bindings. Useful
> > > +                       for optimizing probe order and making sure resources
> > > +                       aren't turned off before the consumer devices have
> > > +                       probed.
> > > +
> > >         ohci1394_dma=early      [HW] enable debugging via the ohci1394 driver.
> > >                         See Documentation/debugging-via-ohci1394.txt for more
> > >                         info.
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index 04ad312fd85b..0930f9f89571 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -509,6 +509,62 @@ int of_platform_default_populate(struct device_node *root,
> > >  }
> > >  EXPORT_SYMBOL_GPL(of_platform_default_populate);
> > >
> > > +static int of_link_binding(struct device *dev,
> > > +                          const char *binding, const char *cell)
> > > +{
> > > +       struct of_phandle_args sup_args;
> > > +       struct platform_device *sup_dev;
> > > +       unsigned int i = 0, links = 0;
> > > +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> > > +
> > > +       while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
> > > +                                          &sup_args)) {
> > > +               i++;
> > > +               sup_dev = of_find_device_by_node(sup_args.np);
> > > +               of_node_put(sup_args.np);
> > > +               if (!sup_dev)
> > > +                       continue;
> > > +               if (device_link_add(dev, &sup_dev->dev, dl_flags))
> > > +                       links++;
> > > +               put_device(&sup_dev->dev);
> > > +       }
> > > +       if (links < i)
> > > +               return -ENODEV;
> > > +       return 0;
> > > +}
> > > +
> > > +static bool of_devlink;
> > > +core_param(of_devlink, of_devlink, bool, 0);
> > > +
> > > +/*
> > > + * List of bindings and their cell names (use NULL if no cell names) from which
> > > + * device links need to be created.
> > > + */
> > > +static const char * const link_bindings[] = {
> > > +       "clocks", "#clock-cells",
> > > +       "interconnects", "#interconnect-cells",
> > > +};
> > > +
> > > +static int of_link_to_suppliers(struct device *dev)
> > > +{
> > > +       unsigned int i = 0;
> > > +       bool done = true;
> > > +
> > > +       if (!of_devlink)
> > > +               return 0;
> > > +       if (unlikely(!dev->of_node))
> > > +               return 0;
> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
> > > +               if (of_link_binding(dev, link_bindings[i * 2],
> > > +                                       link_bindings[i * 2 + 1]))
> > > +                       done = false;
> >
> > Given the pending addition of regulators I think this should be
> > structured a bit differently so that we abstract out the matching and
> > phandle look-up so there's a clean separation of binding specifics.
> > It's kind of messy with 2 patterns to parse already and if we added a
> > 3rd? I would iterate over the properties as you do for regulators in
> > both cases and for each property call a binding specific match
> > function. The common pattern can of course be a common function. Let
> > me know if that makes sense. If not I can try to flesh it out some
> > more.
>
> I've added regulator support in this series and I've refactored this
> code as I went along. I fully expect to squash some of the refactors
> once the final result of the series is acceptable.

It would be easier to review the final result than incremental changes
which change the prior patches especially if the latter patches are
ultimately required.

> It's not clear to me if you got to the end of the series and still
> think the final result needs to be refactored. Let me know what you
> think about this towards the end of the series and I can clean it up
> if you still think it needs some clean up.

I probably should have replied on the regulator addition, but yes,
looking at that is what prompted my concerns here.

Rob
