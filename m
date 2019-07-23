Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB4BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A2221897
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aqa1RZvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfGWX6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:58:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43180 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfGWX6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:58:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id j11so21700492otp.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 16:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojCoPrlATf3jyfxABbaqdPma7g9bAlp8rgQ8HqtNzy0=;
        b=Aqa1RZvN9BV92jFCzEOyelGd0l7LfG5wpilH7+W9t4IFFW1LJp0snpdw1GI7e2gCCq
         glbkiW91LMRkyVDCEUWq/tmhj6M6D0AShhJfhOXZ7XTeH3gTdK/vk9KEPwQ540tSlpTP
         Ore2RHyZuBdWQIfY0LA+pV0xyn2cpZ/hwR7yp/6ToqpqD1iBj/RHJ/vKXAMWq2SIScY/
         2p4j+KqZTk5w7/ZR1lsBKBefR9W/VBYsKMx5kNkZfUf5zQhAKEaIQoiwkBojnS6W7Gqg
         NyMpi/zt8ayfds1NFRwZ5wOvt1wPlJigGB5oGRXt/2HXEtuTAF6hbzktADOjgDqSl2o1
         GlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojCoPrlATf3jyfxABbaqdPma7g9bAlp8rgQ8HqtNzy0=;
        b=tOES3n0WvkxTu/Ibon44/3q92qNU6ApInV/iUsfq82QtfDLannViHX5j8uGO8865iD
         L1V0fwGIGkJU/2OAmcNyl3mZWqgQkE1VfR2rLLQ9CqAvOaJoVrrbUjZF03MXdz3QSswQ
         8RhCqBJR+S80kCkhQDJbvBQSCjQ4pAFB9txnPIormw2i++tQClrORMppvc1JHNvm0xgt
         z0j7v3hWnp8yM2JlDBmShXzSZKlQ1EXacK6XDNuOB1tBwMP/IVPD+lRacNxXPA8v2vYE
         i26XVzSVy3IjkJGxsWPUbbjdS6ZDFQ0SmAawim/Qldptrcaa9K7JFEGwf3KLz3+Y8LVm
         9KBg==
X-Gm-Message-State: APjAAAVb0JuAhHVpK9wzrNmhXp59tpLMDqyWOakjQxwTO0sJ2g82/Jyt
        +PdFmfuVY4a6avk9E5/doKKMrtAwalbAjjN9kj/utQ==
X-Google-Smtp-Source: APXvYqyMS6BPjhxt+BnQPVvkmpSKbO4ZhkTRQrjuqFC94KtPH2uVaDDQ5YeeK6cFMsENrw2oc4JRquXtVz09+BbNruE=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr59656462otj.195.1563926280319;
 Tue, 23 Jul 2019 16:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190720061647.234852-1-saravanak@google.com> <20190720061647.234852-4-saravanak@google.com>
 <CAL_JsqK9GTxxxjhhWwqxOW9XERFziu2O71ETV2RhXb7B1WFY2g@mail.gmail.com>
 <CAGETcx-hCrUvY5whZBihueqqCxmF3oDjFybjmoo3JUu87iiiEw@mail.gmail.com> <CAL_JsqJC-xvj5OJeFRPPNaYJj=-RqmXFJepZ5Q2+z36-7qyPgQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJC-xvj5OJeFRPPNaYJj=-RqmXFJepZ5Q2+z36-7qyPgQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 23 Jul 2019 16:57:24 -0700
Message-ID: <CAGETcx_qDnwa4O7ytvxac6d3krptquCKXMvCFoH9c1p=WY0TkQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] of/platform: Add functional dependency link from
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

On Tue, Jul 23, 2019 at 3:18 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Jul 23, 2019 at 2:49 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Jul 23, 2019 at 11:06 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Sat, Jul 20, 2019 at 12:17 AM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > Add device-links after the devices are created (but before they are
> > > > probed) by looking at common DT bindings like clocks and
> > > > interconnects.
> > >
> > > The structure now looks a lot better to me. A few minor things below.
> >
> > Thanks.
> >
> > > >
> > > > Automatically adding device-links for functional dependencies at the
> > > > framework level provides the following benefits:
> > > >
> > > > - Optimizes device probe order and avoids the useless work of
> > > >   attempting probes of devices that will not probe successfully
> > > >   (because their suppliers aren't present or haven't probed yet).
> > > >
> > > >   For example, in a commonly available mobile SoC, registering just
> > > >   one consumer device's driver at an initcall level earlier than the
> > > >   supplier device's driver causes 11 failed probe attempts before the
> > > >   consumer device probes successfully. This was with a kernel with all
> > > >   the drivers statically compiled in. This problem gets a lot worse if
> > > >   all the drivers are loaded as modules without direct symbol
> > > >   dependencies.
> > > >
> > > > - Supplier devices like clock providers, interconnect providers, etc
> > > >   need to keep the resources they provide active and at a particular
> > > >   state(s) during boot up even if their current set of consumers don't
> > > >   request the resource to be active. This is because the rest of the
> > > >   consumers might not have probed yet and turning off the resource
> > > >   before all the consumers have probed could lead to a hang or
> > > >   undesired user experience.
> > > >
> > > >   Some frameworks (Eg: regulator) handle this today by turning off
> > > >   "unused" resources at late_initcall_sync and hoping all the devices
> > > >   have probed by then. This is not a valid assumption for systems with
> > > >   loadable modules. Other frameworks (Eg: clock) just don't handle
> > > >   this due to the lack of a clear signal for when they can turn off
> > > >   resources. This leads to downstream hacks to handle cases like this
> > > >   that can easily be solved in the upstream kernel.
> > > >
> > > >   By linking devices before they are probed, we give suppliers a clear
> > > >   count of the number of dependent consumers. Once all of the
> > > >   consumers are active, the suppliers can turn off the unused
> > > >   resources without making assumptions about the number of consumers.
> > > >
> > > > By default we just add device-links to track "driver presence" (probe
> > > > succeeded) of the supplier device. If any other functionality provided
> > > > by device-links are needed, it is left to the consumer/supplier
> > > > devices to change the link when they probe.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  .../admin-guide/kernel-parameters.txt         |   5 +
> > > >  drivers/of/platform.c                         | 158 ++++++++++++++++++
> > > >  2 files changed, 163 insertions(+)
> > > >
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index 138f6664b2e2..109b4310844f 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -3141,6 +3141,11 @@
> > > >                         This can be set from sysctl after boot.
> > > >                         See Documentation/sysctl/vm.txt for details.
> > > >
> > > > +       of_devlink      [KNL] Make device links from common DT bindings. Useful
> > > > +                       for optimizing probe order and making sure resources
> > > > +                       aren't turned off before the consumer devices have
> > > > +                       probed.
> > > > +
> > > >         ohci1394_dma=early      [HW] enable debugging via the ohci1394 driver.
> > > >                         See Documentation/debugging-via-ohci1394.txt for more
> > > >                         info.
> > > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > > index 04ad312fd85b..88a2086e26fa 100644
> > > > --- a/drivers/of/platform.c
> > > > +++ b/drivers/of/platform.c
> > > > @@ -509,6 +509,163 @@ int of_platform_default_populate(struct device_node *root,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(of_platform_default_populate);
> > > >
> > > > +bool of_link_is_valid(struct device_node *con, struct device_node *sup)
> > > > +{
> > > > +       of_node_get(sup);
> > > > +       /*
> > > > +        * Don't allow linking a device node as a consumer of one of its
> > > > +        * descendant nodes. By definition, a child node can't be a functional
> > > > +        * dependency for the parent node.
> > > > +        */
> > > > +       while (sup) {
> > > > +               if (sup == con) {
> > > > +                       of_node_put(sup);
> > > > +                       return false;
> > > > +               }
> > > > +               sup = of_get_next_parent(sup);
> > > > +       }
> > > > +       return true;
> > > > +}
> > > > +
> > > > +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> > > > +{
> > > > +       struct platform_device *sup_dev;
> > > > +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> > > > +       int ret = 0;
> > > > +
> > > > +       /*
> > > > +        * Since we are trying to create device links, we need to find
> > > > +        * the actual device node that owns this supplier phandle.
> > > > +        * Often times it's the same node, but sometimes it can be one
> > > > +        * of the parents. So walk up the parent till you find a
> > > > +        * device.
> > > > +        */
> > > > +       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> > > > +               sup_np = of_get_next_parent(sup_np);
> > > > +       if (!sup_np)
> > > > +               return 0;
> > > > +
> > > > +       if (!of_link_is_valid(dev->of_node, sup_np)) {
> > > > +               of_node_put(sup_np);
> > > > +               return 0;
> > > > +       }
> > > > +       sup_dev = of_find_device_by_node(sup_np);
> > > > +       of_node_put(sup_np);
> > > > +       if (!sup_dev)
> > > > +               return -ENODEV;
> > > > +       if (!device_link_add(dev, &sup_dev->dev, dl_flags))
> > > > +               ret = -ENODEV;
> > > > +       put_device(&sup_dev->dev);
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static struct device_node *parse_prop_cells(struct device_node *np,
> > > > +                                           const char *prop, int i,
> > >
> > > I like 'i' for for loops, but less so for function params. Perhaps
> > > 'index' instead like of_parse_phandle_with_args.
> >
> > Sounds good.
> >
> > >
> > > > +                                           const char *binding,
> > > > +                                           const char *cell)
> > > > +{
> > > > +       struct of_phandle_args sup_args;
> > > > +
> > > > +       if (!i && strcmp(prop, binding))
> > >
> > > Why the '!i' test?
> >
> > To avoid a string comparison for every index. It's kinda wasteful once
> > the first index passes.
>
> That's not very obvious and pretty fragile though this is a static
> function. Perhaps we should split to match() and parse() functions.

Yeah, I did think about doing this. That's why I made it a struct for
supplier_bindings instead of just an array of function pointers. But
having a parse function just for a strcmp() was creating a lot of code
noise. So went ahead and did it this way. We can keep it this way and
if we later see the need for a separate parse function, it should be
easy to do so (because it's already a struct for each binding).

> At
> least put a comment here as to what we're doing.

Done.

> >
> > > > +               return NULL;
> > > > +
> > > > +       if (of_parse_phandle_with_args(np, binding, cell, i, &sup_args))
> > > > +               return NULL;
> > > > +
> > > > +       return sup_args.np;
> > > > +}
> > > > +
> > > > +static struct device_node *parse_clocks(struct device_node *np,
> > > > +                                       const char *prop, int i)
> > > > +{
> > > > +       return parse_prop_cells(np, prop, i, "clocks", "#clock-cells");
> > > > +}
> > > > +
> > > > +static struct device_node *parse_interconnects(struct device_node *np,
> > > > +                                              const char *prop, int i)
> > > > +{
> > > > +       return parse_prop_cells(np, prop, i, "interconnects",
> > > > +                               "#interconnect-cells");
> > > > +}
> > > > +
> > > > +static int strcmp_suffix(const char *str, const char *suffix)
> > > > +{
> > > > +       unsigned int len, suffix_len;
> > > > +
> > > > +       len = strlen(str);
> > > > +       suffix_len = strlen(suffix);
> > > > +       if (len <= suffix_len)
> > > > +               return -1;
> > > > +       return strcmp(str + len - suffix_len, suffix);
> > > > +}
> > > > +
> > > > +static struct device_node *parse_regulators(struct device_node *np,
> > > > +                                           const char *prop, int i)
> > > > +{
> > > > +       if (i || strcmp_suffix(prop, "-supply"))
> > > > +               return NULL;
> > > > +
> > > > +       return of_parse_phandle(np, prop, 0);
> > > > +}
> > > > +
> > > > +/**
> > > > + * struct supplier_bindings - Information for parsing supplier DT binding
> > > > + *
> > > > + * @parse_prop:                If the function cannot parse the property, return NULL.
> > > > + *                     Otherwise, return the phandle listed in the property
> > > > + *                     that corresponds to index i.
> > > > + */
> > > > +struct supplier_bindings {
> > > > +       struct device_node *(*parse_prop)(struct device_node *np,
> > > > +                                         const char *name, int i);
> > > > +};
> > > > +
> > > > +struct supplier_bindings bindings[] = {
> > >
> > > static const
> >
> > Will do.
> >
> > >
> > > > +       { .parse_prop = parse_clocks, },
> > > > +       { .parse_prop = parse_interconnects, },
> > > > +       { .parse_prop = parse_regulators, },
> > > > +       { },
> > > > +};
> > > > +
> > > > +static bool of_link_property(struct device *dev, struct device_node *con_np,
> > > > +                            const char *prop)
> > > > +{
> > > > +       struct device_node *phandle;
> > > > +       struct supplier_bindings *s = bindings;
> > > > +       unsigned int i = 0;
> > > > +       bool done = true;
> > > > +
> > > > +       while (!i && s->parse_prop) {
> > >
> > > Using 'i' is a little odd. Perhaps a 'matched' bool would be easier to read.
> >
> > That's how I wrote it first (locally) and then redid it this way
> > because the bool felt very superfluous. I don't think this is that
> > hard to understand.
>
> Alright...

I like the name "matched" over "found" that I had used locally. So, I
actually went ahead and did this.

-Saravana

> > > > +               while ((phandle = s->parse_prop(con_np, prop, i))) {
> > > > +                       i++;
> > > > +                       if (of_link_to_phandle(dev, phandle))
> > > > +                               done = false;
> > >
> > > Just return here. No point in continuing as 'done' is never set back to true.
> >
> > Actually, there is a point for this. Say Device-C depends on suppliers
> > Device-S1 and Device-S2 and they are listed in DT in that order.
> >
> > Say, S1 gets populated after late_initcall_sync but S2 is probes way
> > before that. If I don't continue past a "failed linking" to S1 and
> > also link up to S2, then S2 will get a sync_state() callback before C
> > is probed. So I have to go through all possible suppliers and as many
> > as possible.
> >
> > Let me add a comment about this somewhere in the code (probably the
> > header that defines the add_links() ops).
>
> Okay, makes sense.
>
> Rob
