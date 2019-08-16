Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57339C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090AF2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAMJJne9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfHPBve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:51:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38251 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHPBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:51:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id p124so3708485oig.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCi/in7gseJMAean2CF1KC0xrxNeRZi+lVHLUu1z8gQ=;
        b=wAMJJne9vt6uNQW9wHq2Ha9fpr1F/2HopYCHjZo5ascjYcpiZZ+l/dd39ab+8rRKEJ
         DLMjP9v9dQEN7mCshBeuK3GH9q6mQl/YUztfYMM3/tBRHBvxtV/NzLKNYR5NCsDDS4+5
         2yGOyCnWgchMczryxqHuFP8xAVlwNMDHqwWFfjvGtedhHizmP/7ye6JnHnLAPDATzUFE
         aBkjFxnaM/R2EBJJa77TQUV3bDM4KNOkpcGp/Y1GSp0oNQyR1aVoUXqV1NDoocjf/+0p
         OA7XmHMYaEGKchObqyUT0lLBJm3Vgu4KwxBuwoztPvUs5+sUBXAZaf85DXDMdBFB4VgI
         G7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCi/in7gseJMAean2CF1KC0xrxNeRZi+lVHLUu1z8gQ=;
        b=ZtrlYCYvKlvWFWVGZ1i2QRijQ7UrAoBWUS/JD5m1yjVvg/VaEQ45UrTL6KUIr5vGPl
         h6ZJpLX6gEm9kFlrnjNSmMPzK2bala/EB/2w5xLv5R6tBL2GWbyX62hFe/hcG4GMq/fn
         jJvQuFjpF9TK7prUJIpccdqGmfTzBTKr6MnQCYPJQOACD+8PWPrgs4+XWkDndQe40GHB
         XxOc7rMjT1MYFcwIaZ7tBSFQLjmxfcJ3bz6Apaa/XbAW0GjIF6Q7KRVVJYUzxMTUDFU/
         Bouqr4rur6Yf/m+rLsqYPkjckxJ0bz/u5Wyt6tKYx5h1rCT41ueAT1SbUPn15N3A7r7J
         bTEg==
X-Gm-Message-State: APjAAAUnfC2NmetaCs5Un4aah85Ro6wXUsZZfs5dbjCaVSTLCSSTlf2g
        ApCBJFwG1YS8zQtJFKFKhT+DNiQVHqgDROitNSHYGg==
X-Google-Smtp-Source: APXvYqwShjzeNtSpgvFHQcP7SpZExVXJIv1MH7jtZ443+k6NEfZiP/K5YVOdoLaJXnjiJ5ojTygKwiCKVGB99kxIlgo=
X-Received: by 2002:aca:6104:: with SMTP id v4mr3605317oib.172.1565920290278;
 Thu, 15 Aug 2019 18:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com> <20190724001100.133423-4-saravanak@google.com>
 <141d2e16-26cc-1f05-1ac0-6784bab5ae88@gmail.com>
In-Reply-To: <141d2e16-26cc-1f05-1ac0-6784bab5ae88@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 15 Aug 2019 18:50:54 -0700
Message-ID: <CAGETcx-dVnLCRA+1CX47gtZgtwTcrN5KefpjMzh9OJB-BEnqyg@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 7:06 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 7/23/19 5:10 PM, Saravana Kannan wrote:
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
> >  .../admin-guide/kernel-parameters.txt         |   5 +
> >  drivers/of/platform.c                         | 165 ++++++++++++++++++
> >  2 files changed, 170 insertions(+)
> >
>
> Documentation/admin-guide/kernel-paramers.rst:
>
> After line 129, add:
>
>         OF      Devicetree is enabled

Will do.

> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 46b826fcb5ad..12937349d79d 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3170,6 +3170,11 @@
> >                       This can be set from sysctl after boot.
> >                       See Documentation/admin-guide/sysctl/vm.rst for details.
> >
> > +     of_devlink      [KNL] Make device links from common DT bindings. Useful
> > +                     for optimizing probe order and making sure resources
> > +                     aren't turned off before the consumer devices have
> > +                     probed.
>
>         of_supplier_depend instead of of_devlink ????

I'm open to other names, but of_supplier_depend is just odd.
of_devlink stands for of_device_links. If someone wants to know what
device links do, they can read up on the device links documentation?

>
>         of_supplier_depend
>                         [OF, KNL] Make device links from consumer devicetree
>                         nodes to supplier devicetree nodes.

We are creating device links between devices. Not device tree nodes.
So this would be wrong. I'll replace it with "devicetree nodes" with
"devices"?

> The
>                         consumer / supplier relationships are inferred from
>                         scanning the devicetree.

I like this part. How about clarifying it with "from scanning the
common bindings in the devicetree"? Because we aren't trying to scan
the device specific properties.

>  The driver for a consumer
>                         device will not be probed until the drivers for all of
>                         its supplier devices have been successfully probed.

A driver is never probed. It's a device that's probed. The dependency
is between devices and not drivers. So, how about I replace this with:
"The consumer device will not be probed until all of its supplier
devices are successfully probed"?

Also, any reason you removed the "resources aren't turned off ..."
part? That's one of the biggest improvements of this patch series. Do
you want to rewrite that part too? Or I'll leave my current wording of
that part as is?

>
>
> > +
> >       ohci1394_dma=early      [HW] enable debugging via the ohci1394 driver.
> >                       See Documentation/debugging-via-ohci1394.txt for more
> >                       info.
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 7801e25e6895..4344419a26fc 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -508,6 +508,170 @@ int of_platform_default_populate(struct device_node *root,
> >  }
> >  EXPORT_SYMBOL_GPL(of_platform_default_populate);
> >
>
> > +bool of_link_is_valid(struct device_node *con, struct device_node *sup)
>
> Change to less vague:
>
>    bool of_ancestor_of(struct device_node *test_np, struct device_node *np)

I thought about that when I wrote the code. But the consumer being the
ancestor of the supplier is just one of the things that makes a link
invalid. There can be other tests we might add as we go. That's why I
kept the function name as of_link_is_valid(). Even if I add an
"ancestor_of" helper function, I'll still have of_link_is_valid() as a
wrapper around it.

> > +{
> > +     of_node_get(sup);
> > +     /*
> > +      * Don't allow linking a device node as a consumer of one of its
> > +      * descendant nodes. By definition, a child node can't be a functional
> > +      * dependency for the parent node.
> > +      */
> > +     while (sup) {
> > +             if (sup == con) {
> > +                     of_node_put(sup);
> > +                     return false;
> > +             }
> > +             sup = of_get_next_parent(sup);
> > +     }
> > +     return true;
>
> Change to more generic:
>
>         of_node_get(test_np);
>         while (test_np) {
>                 if (test_np == np) {
>                         of_node_put(test_np);
>                         return true;
>                 }
>                 test_np = of_get_next_parent(test_np);
>         }
>         return false;

If you do insist on this change, I think we need better names than
test_np and np. It's not clear which node needs to be the ancestor for
this function to return true. With consumer/supplier, it's kinda
obvious that a consumer can't be an ancestor of a supplier.

> > +}
> > +
>
>
> /**
>  * of_link_to_phandle - Add device link to supplier
>  * @dev: consumer device
>  * @sup_np: pointer to the supplier device tree node

Could you suggest something that makes it a bit more clear that this
phandle/node doesn't need to be an actual device (as in, one with
compatible property)? phandle kinda make it clear at least to me. I'd
prefer just saying "phandle to supplier". Thoughts?

Also, what's the guideline on which functions needs doc headers? I
always leaned towards adding them only for non-static functions.
That's why I skipped this one. What's the reasoning for needing one
for this? I'm happy to do this, just want to see that there's some
consistent guideline that's being followed and something I can use for
future patches.

>  *
>  * TODO: ...
>  *
>  * Return:
>  * * 0 if link successfully created for supplier or of_devlink is false

The "or of_devlink is false" isn't true for this function?

>  * * an error if unable to create link
>  */
>
> Should have dev_debug() or pr_warn() or something on errors in this
> function -- the caller does not report any issue

I think that'll be too spammy during bootup. This function is expected
to fail often and it's not necessary a catastrophic failure. The
caller can print something if they care to. The current set of callers
don't.

> > +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> > +{
> > +     struct platform_device *sup_dev;
> > +     u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> > +     int ret = 0;
> > +
> > +     /*
>
> > +      * Since we are trying to create device links, we need to find
> > +      * the actual device node that owns this supplier phandle.
> > +      * Often times it's the same node, but sometimes it can be one
> > +      * of the parents. So walk up the parent till you find a
> > +      * device.
>
> Change comment to:
>
>          * Find the device node that contains the supplier phandle.  It may
>          * be @sup_np or it may be an ancestor of @sup_np.

Aren't the existing comments giving a better explanation with more context?
But I'll do this.

>
> > +      */
>
> See comment in caller of of_link_to_phandle() - do not hide the final
> of_node_put() of sup_np inside of_link_to_phandle(), so need to do
> an of_node_get() here.
>
>         of_node_get(sup_np);

Will do. Good point.

>
> > +     while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> > +             sup_np = of_get_next_parent(sup_np);
> > +     if (!sup_np)
>
> > +             return 0;
>
> This case should never occur(?), it is an error.
>
>                 return -ENODEV;

I'm not too sure about all the possible DT combinations to say this?
In that case, this isn't an error. As in, the consumer doesn't need to
wait for this non-existent device to get populated/added. I'd lean
towards leaving it as is and address it later if this is actually a
problem. I want of_link_to_phandle to fail only when a link can be
created, but isn't due to current system state (device isn't added,
creating a cyclic link, etc).

>
> > +
> > +     if (!of_link_is_valid(dev->of_node, sup_np)) {
> > +             of_node_put(sup_np);
> > +             return 0;
>
> Do not use a name that obscures what the function is doing, also
> return an actual issue.
>
>         if (of_ancestor_of(sup_np, dev->of_node)) {
>                 of_node_put(sup_np);
>                 return -EINVAL;

See my comment about not erroring on cases where a link can't ever be
created? So in your case, you'd want the caller to check the error
value to device which ones to ignore and which ones not to? That seems
a bit more fragile when this function is potentially changed in the
furture.

>
> > +     }
> > +     sup_dev = of_find_device_by_node(sup_np);
> > +     of_node_put(sup_np);
> > +     if (!sup_dev)
> > +             return -ENODEV;
> > +     if (!device_link_add(dev, &sup_dev->dev, dl_flags))
> > +             ret = -ENODEV;

For example, in the earlier comment you suggested -ENODEV if there's
no device with "compatible" property that encapsulates the supplier
phandle. But -ENODEV makes more sense for this case where there's
actually no device because it hasn't been added yet. And the caller
needs to be able to distinguish between these two. Are we just going
to arbitrarily pick error values just to make sure they don't overlap?

I don't have a strong opinion one way or another, but I'm trying to
understand what's better in the long run where this function can
evolve to add more checks or handle more cases.

> > +     put_device(&sup_dev->dev);
> > +     return ret;
> > +}
> > +
>
> /**
>  * parse_prop_cells - Property parsing functions for suppliers
>  *
>  * @np:            pointer to a device tree node containing a list
>  * @prop_name:     Name of property holding a phandle value
>  * @phandle_index: For properties holding a table of phandles, this is the
>  *                 index into the table
>  * @list_name:     property name that contains a list
>  * @cells_name:    property name that specifies phandles' arguments count
>  *
>  * This function is useful to parse lists of phandles and their arguments.
>  *
>  * Return:
>  * * Node pointer with refcount incremented, use of_node_put() on it when done.
>  * * NULL if not found.
>  */
>
> > +static struct device_node *parse_prop_cells(struct device_node *np,
> > +                                         const char *prop, int index,
> > +                                         const char *binding,
> > +                                         const char *cell)
>
> Make names consistent with of_parse_phandle_with_args():
>   Change prop to prop_name
>   Change index to phandle_index

You call this index even in of_parse_phandle_with_args()

>   Change binding to list_name
>   Change cell to cells_name

This going to cause a lot more line wraps for barely better names. But
I'll reluctantly do this.

>
> > +{
> > +     struct of_phandle_args sup_args;
> > +
>
> > +     /* Don't need to check property name for every index. */
> > +     if (!index && strcmp(prop, binding))
> > +             return NULL;
>
> I read the discussion on whether to check property name only once
> in version 6.
>
> This check is fragile, depending upon the calling code to be properly
> structured.  Do the check for all values of index.  The reduction of
> overhead from not checking does not justify the fragileness and the
> extra complexity for the code reader to understand why the check can
> be bypassed when
> index is not zero.

This is used only in this file. I understand needing the balance
between code complexity/fragility and efficiency. But I think you push
the line too far away from efficiency. This code is literally never
going to fail because it's a static function called only inside this
file. And the check isn't that hard to understand with that tiny
comment.

> > +
> > +     if (of_parse_phandle_with_args(np, binding, cell, index, &sup_args))
> > +             return NULL;
> > +
> > +     return sup_args.np;
> > +}
> > +
> > +static struct device_node *parse_clocks(struct device_node *np,
> > +                                     const char *prop, int index)
>
> Change prop to prop_name
> Change index to phandle_index
>
> > +{
> > +     return parse_prop_cells(np, prop, index, "clocks", "#clock-cells");
> > +}
> > +
> > +static struct device_node *parse_interconnects(struct device_node *np,
> > +                                            const char *prop, int index)
>
> Change prop to prop_name
> Change index to phandle_index
>
> > +{
> > +     return parse_prop_cells(np, prop, index, "interconnects",
> > +                             "#interconnect-cells");
> > +}
> > +
> > +static int strcmp_suffix(const char *str, const char *suffix)
> > +{
> > +     unsigned int len, suffix_len;
> > +
> > +     len = strlen(str);
> > +     suffix_len = strlen(suffix);
> > +     if (len <= suffix_len)
> > +             return -1;
> > +     return strcmp(str + len - suffix_len, suffix);
> > +}
> > +
> > +static struct device_node *parse_regulators(struct device_node *np,
> > +                                         const char *prop, int index)
>
> Change prop to prop_name
> Change index to phandle_index
>

Will do all the renames you list above.

> > +{
> > +     if (index || strcmp_suffix(prop, "-supply"))
> > +             return NULL;
> > +
> > +     return of_parse_phandle(np, prop, 0);
> > +}
> > +
> > +/**
>
> > + * struct supplier_bindings - Information for parsing supplier DT binding
> > + *
> > + * @parse_prop:              If the function cannot parse the property, return NULL.
> > + *                   Otherwise, return the phandle listed in the property
> > + *                   that corresponds to the index.
>
> There is no documentation of dynamic function parameters in the docbook
> description of a struct.  Use this format for now and I will clean up when
> I clean up all of the devicetree docbook info.
>
> Change above comment to:
>
>  * struct supplier_bindings - Property parsing functions for suppliers
>  *
>  * @parse_prop: function name
>  *              parse_prop() finds the node corresponding to a supplier phandle
>  * @parse_prop.np: Pointer to device node holding supplier phandle property
>  * @parse_prop.prop_name: Name of property holding a phandle value
>  * @parse_prop.index: For properties holding a table of phandles, this is the
>  *                    index into the table
>  *
>  * Return:
>  * * parse_prop() return values are
>  * * Node pointer with refcount incremented, use of_node_put() on it when done.
>  * * NULL if not found.

Will do. Thanks for writing it.

> > + */
> > +struct supplier_bindings {
> > +     struct device_node *(*parse_prop)(struct device_node *np,
> > +                                       const char *name, int index);
>
> Change name to prop_name
> Change index to phandle_index
>
> > +};
> > +
> > +static const struct supplier_bindings bindings[] = {
> > +     { .parse_prop = parse_clocks, },
> > +     { .parse_prop = parse_interconnects, },
> > +     { .parse_prop = parse_regulators, },
>
> > +     { },
>
>         {},
>
> > +};
> > +
>
> /**
>  * of_link_property - TODO:
>  * dev:
>  * con_np:
>  * prop:
>  *
>  * TODO...
>  *
>  * Any failed attempt to create a link will NOT result in an immediate return.
>  * of_link_property() must create all possible links even when one of more
>  * attempts to create a link fail.
>
> Why?  isn't one failure enough to prevent probing this device?
> Continuing to scan just results in extra work... which will be
> repeated every time device_link_check_waiting_consumers() is called

Context:
As I said in the cover letter, avoiding unnecessary probes is just one
of the reasons for this patch. The other (arguably more important)
reason for this patch is to make sure suppliers know that they have
consumers that are yet to be probed. That way, suppliers can leave
their resource on AND in the right state if they were left on by the
bootloader. For example, if a clock was left on and at 200 MHz, the
clock provider needs to keep that clock ON and at 200 MHz till all the
consumers are probed.

Answer: Let's say a consumer device Z has suppliers A, B and C. If the
linking fails at A and you return immediately, then B and C could
probe and then figure that they have no more consumers (they don't see
a link to Z) and turn off their resources. And Z could fail
catastrophically.

>  *
>  * Return:
>  * * 0 if TODO:
>  * * -ENODEV on error
>  */
>
>
> I left some "TODO:" sections to be filled out above.

Will do.

>
>
> > +static bool of_link_property(struct device *dev, struct device_node *con_np,
> > +                          const char *prop)
>
> Returns 0 or -ENODEV, so bool is incorrect
>
> (Also fixed on 8/8 in patch: "[PATCH 1/2] of/platform: Fix fn definitons for
> of_link_is_valid() and of_link_property()")

Right.

>
> > +{
> > +     struct device_node *phandle;
> > +     struct supplier_bindings *s = bindings;
> > +     unsigned int i = 0;
>
> > +     bool done = true, matched = false;
>
> Change to:
>
>         bool matched = false;
>         int ret = 0;
>
>         /* do not stop at first failed link, link all available suppliers */
>
> > +
> > +     while (!matched && s->parse_prop) {
> > +             while ((phandle = s->parse_prop(con_np, prop, i))) {
> > +                     matched = true;
> > +                     i++;
> > +                     if (of_link_to_phandle(dev, phandle))
>
>
> Remove comment:
>
> > +                             /*
> > +                              * Don't stop at the first failure. See
> > +                              * Documentation for bus_type.add_links for
> > +                              * more details.
> > +                              */

Ok

>
> > +                             done = false;
>
>                                 ret = -ENODEV;

This is nicer. Thanks.

>
> Do not hide of_node_put() inside of_link_to_phandle(), do it here:
>
>                         of_node_put(phandle);

Ok

>
> > +             }
> > +             s++;
> > +     }
>
> > +     return done ? 0 : -ENODEV;
>
>         return ret;
>
> > +}
> > +
> > +static bool of_devlink;
> > +core_param(of_devlink, of_devlink, bool, 0);
> > +
>
> /**
>  * of_link_to_suppliers - Add device links to suppliers
>  * @dev: consumer device
>  *
>  * Create device links to all available suppliers of @dev.
>  * Must NOT stop at the first failed link.
>  * If some suppliers are not yet available, this function will be
>  * called again when additional suppliers become available.
>  *
>  * Return:
>  * * 0 if links successfully created for all suppliers
>  * * an error if one or more suppliers not yet available
>  */

Ok

> > +static int of_link_to_suppliers(struct device *dev)
> > +{
> > +     struct property *p;
>
> > +     bool done = true;
>
> remove done
>
>         int ret = 0;
>
> > +
> > +     if (!of_devlink)
> > +             return 0;
>
> > +     if (unlikely(!dev->of_node))
> > +             return 0;
>
> Check not needed, for_each_property_of_node() will detect !dev->of_node.
>
> > +
> > +     for_each_property_of_node(dev->of_node, p)
> > +             if (of_link_property(dev, dev->of_node, p->name))
>
> > +                     done = false;
>
>                         ret = -EAGAIN;
>
> > +
> > +     return done ? 0 : -ENODEV;
>
>         return ret;

Thanks. I think I was too caught up on the rest of the logic
complexity that I missed this obviously ugly code. Will fix.

Thanks,
Saravana
