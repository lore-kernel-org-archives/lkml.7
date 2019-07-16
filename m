Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4787C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCED2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shjR7DVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfGPXyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:54:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42461 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPXyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:54:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id s184so17031180oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L63UCSLKJ4OMT5NqgGQ8B7uM36pMA1wEj62intmncP0=;
        b=shjR7DVNL9/TqVYpbphhQN3r77abb9oKtSvfh0HHoJ/pKSm/z7zVTZm0k9OfHSrl6j
         dFxQ/xsD6Kwl02n6C0ddFcBEM7+i7cPQO7Lwzm6nLOE6i/GLwFvijfmehGqUEFjHvEvh
         KQn8BHmxp5/w+PGKVwlON87XjUAafOgoyxi2DNsW9srz0tCjRUmNzSnscT8G9YISn0Nx
         cpYQyFrA/T5AH5jPpm7j88I0mx6woFml5xFbD9VcxfmySpiEejRcblfYSdSliWNSxrfQ
         TL/4Hmrp7Jdw/DEDsTRce5iqOOWn343nT/0xzEn0Lb+SCH1tI0H3JR0vSCAmQ0BLJ7yL
         QOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L63UCSLKJ4OMT5NqgGQ8B7uM36pMA1wEj62intmncP0=;
        b=d20tjrrpPpKPFO2kriRFUKfyRK/7rrrAt6mtEapyoveWtWkwhi3DX6MGh6fJGwGWTZ
         Y8Fl4USzo3VDskGoqumdYf6ucvijw6H+KVPYViuHfWTQec6KYjwBzwCnZkqYytsGxmzB
         gvJENSE4uj3XEfUhctHCyrxHj+JvyuCJUWqmqqiaXEj2Cud/DhxxObil8CS39FE+YHwF
         1Lo47ThWYFFasAhFBvKmgbgWDHTzBkFGpf9WrOLqY625IucdSSclh6vf89aXLL52BzTQ
         IfdEfvJG6KiuHbBsfWlYLa6dbGpqmPEvHsUL894UJACWfpbVsV5aTtsEJpPeQuIlVV4I
         7u0Q==
X-Gm-Message-State: APjAAAVGnuTxqaejQyxJ0b5Rw/+KjAKubkjEMB3ow5URfsLKTNytduhb
        fXI0YTPR0tsLGylHK4VhjuK/94sZIBbUT1P7GuC3lg==
X-Google-Smtp-Source: APXvYqyVadR4/niowxrLmenSGn1UzqhGhoAgJTC/7kpKDcwlbQspwuNL2la4zhD9hoopEjvAfsnd5+3pO1VQt6iVbTQ=
X-Received: by 2002:aca:6104:: with SMTP id v4mr18318119oib.172.1563321274778;
 Tue, 16 Jul 2019 16:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com> <20190712235245.202558-3-saravanak@google.com>
 <CAL_JsqJEmC5cttFavGH4iMh=3z2K4r4kjG44AFJCpxQZ9hPwQA@mail.gmail.com>
In-Reply-To: <CAL_JsqJEmC5cttFavGH4iMh=3z2K4r4kjG44AFJCpxQZ9hPwQA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 16:53:58 -0700
Message-ID: <CAGETcx-5ykD=9X1Lo2-G+T5uokFncbY2FmiJM8eZrgQ9JaBgxw@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] of/platform: Add functional dependency link from
 DT bindings
To:     Rob Herring <robh+dt@kernel.org>
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

On Tue, Jul 16, 2019 at 4:43 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Jul 12, 2019 at 5:52 PM Saravana Kannan <saravanak@google.com> wrote:
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
> >  .../admin-guide/kernel-parameters.txt         |  5 ++
> >  drivers/of/platform.c                         | 57 +++++++++++++++++++
> >  2 files changed, 62 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 138f6664b2e2..109b4310844f 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3141,6 +3141,11 @@
> >                         This can be set from sysctl after boot.
> >                         See Documentation/sysctl/vm.txt for details.
> >
> > +       of_devlink      [KNL] Make device links from common DT bindings. Useful
> > +                       for optimizing probe order and making sure resources
> > +                       aren't turned off before the consumer devices have
> > +                       probed.
> > +
> >         ohci1394_dma=early      [HW] enable debugging via the ohci1394 driver.
> >                         See Documentation/debugging-via-ohci1394.txt for more
> >                         info.
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 04ad312fd85b..0930f9f89571 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -509,6 +509,62 @@ int of_platform_default_populate(struct device_node *root,
> >  }
> >  EXPORT_SYMBOL_GPL(of_platform_default_populate);
> >
> > +static int of_link_binding(struct device *dev,
> > +                          const char *binding, const char *cell)
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
> > +               of_node_put(sup_args.np);
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
> > +static bool of_devlink;
> > +core_param(of_devlink, of_devlink, bool, 0);
> > +
> > +/*
> > + * List of bindings and their cell names (use NULL if no cell names) from which
> > + * device links need to be created.
> > + */
> > +static const char * const link_bindings[] = {
> > +       "clocks", "#clock-cells",
> > +       "interconnects", "#interconnect-cells",
> > +};
> > +
> > +static int of_link_to_suppliers(struct device *dev)
> > +{
> > +       unsigned int i = 0;
> > +       bool done = true;
> > +
> > +       if (!of_devlink)
> > +               return 0;
> > +       if (unlikely(!dev->of_node))
> > +               return 0;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
> > +               if (of_link_binding(dev, link_bindings[i * 2],
> > +                                       link_bindings[i * 2 + 1]))
> > +                       done = false;
>
> Given the pending addition of regulators I think this should be
> structured a bit differently so that we abstract out the matching and
> phandle look-up so there's a clean separation of binding specifics.
> It's kind of messy with 2 patterns to parse already and if we added a
> 3rd? I would iterate over the properties as you do for regulators in
> both cases and for each property call a binding specific match
> function. The common pattern can of course be a common function. Let
> me know if that makes sense. If not I can try to flesh it out some
> more.

I've added regulator support in this series and I've refactored this
code as I went along. I fully expect to squash some of the refactors
once the final result of the series is acceptable.

It's not clear to me if you got to the end of the series and still
think the final result needs to be refactored. Let me know what you
think about this towards the end of the series and I can clean it up
if you still think it needs some clean up.

-Saravana
