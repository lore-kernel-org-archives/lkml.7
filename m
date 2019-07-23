Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C752C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8386218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563905203;
	bh=ATZxf7FiN3oB+M5mvyAZv00bjhePqLf7c5O+1PYZH80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ENDYDfp7zrFbAz7QXJYacfXlXUdpyLrtpEcwJe8i0UvuVKEbbjzXaAsDpFBL89Kr+
	 zzWux868JyIpd6rfac3D/UyIGnOgJjS2e6Q2gNmuRf5T5puGeHOPIH0AI2XdHwkrjG
	 iePQjMTEp1IhXEaP5BlN61Gb7Wa5h+sbbPN/1b5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbfGWSGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387766AbfGWSGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:06:41 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF1A227B9;
        Tue, 23 Jul 2019 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563905199;
        bh=ATZxf7FiN3oB+M5mvyAZv00bjhePqLf7c5O+1PYZH80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F9B4OkqYLKKg87918iaCmoQkIOwRNQ7zR6LS7flzsQS6QJKst9O1qGtq2a0X5UTFE
         jxoOpduoB5yMfd/5maT9utCt06jCXhxupXAec/7mAtkOY7NcSYkJU9qvxPQssLNfyA
         xheGfGRkm1zpE0RRn68AcDmH9OKmWmXbxasq6M74=
Received: by mail-qk1-f173.google.com with SMTP id r6so31837603qkc.0;
        Tue, 23 Jul 2019 11:06:39 -0700 (PDT)
X-Gm-Message-State: APjAAAUGWVEm5cYWP52wLCQzumB4t8S4s3tUMCf0Lc7TjJ1t93gCd9h2
        bCFoPUoxOXpwMKz6olaPuDJOD0HarHBiGj4c9w==
X-Google-Smtp-Source: APXvYqzLb9X8SJsIt1UslCRzXBn5OFdvPH3RBcYmZvdiceD0ex+msHgws7xNxSYJtScc/0u8o0DCvqncPOl93OWX1Cg=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr52410261qke.223.1563905198195;
 Tue, 23 Jul 2019 11:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190720061647.234852-1-saravanak@google.com> <20190720061647.234852-4-saravanak@google.com>
In-Reply-To: <20190720061647.234852-4-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 23 Jul 2019 12:06:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK9GTxxxjhhWwqxOW9XERFziu2O71ETV2RhXb7B1WFY2g@mail.gmail.com>
Message-ID: <CAL_JsqK9GTxxxjhhWwqxOW9XERFziu2O71ETV2RhXb7B1WFY2g@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 12:17 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Add device-links after the devices are created (but before they are
> probed) by looking at common DT bindings like clocks and
> interconnects.

The structure now looks a lot better to me. A few minor things below.

>
> Automatically adding device-links for functional dependencies at the
> framework level provides the following benefits:
>
> - Optimizes device probe order and avoids the useless work of
>   attempting probes of devices that will not probe successfully
>   (because their suppliers aren't present or haven't probed yet).
>
>   For example, in a commonly available mobile SoC, registering just
>   one consumer device's driver at an initcall level earlier than the
>   supplier device's driver causes 11 failed probe attempts before the
>   consumer device probes successfully. This was with a kernel with all
>   the drivers statically compiled in. This problem gets a lot worse if
>   all the drivers are loaded as modules without direct symbol
>   dependencies.
>
> - Supplier devices like clock providers, interconnect providers, etc
>   need to keep the resources they provide active and at a particular
>   state(s) during boot up even if their current set of consumers don't
>   request the resource to be active. This is because the rest of the
>   consumers might not have probed yet and turning off the resource
>   before all the consumers have probed could lead to a hang or
>   undesired user experience.
>
>   Some frameworks (Eg: regulator) handle this today by turning off
>   "unused" resources at late_initcall_sync and hoping all the devices
>   have probed by then. This is not a valid assumption for systems with
>   loadable modules. Other frameworks (Eg: clock) just don't handle
>   this due to the lack of a clear signal for when they can turn off
>   resources. This leads to downstream hacks to handle cases like this
>   that can easily be solved in the upstream kernel.
>
>   By linking devices before they are probed, we give suppliers a clear
>   count of the number of dependent consumers. Once all of the
>   consumers are active, the suppliers can turn off the unused
>   resources without making assumptions about the number of consumers.
>
> By default we just add device-links to track "driver presence" (probe
> succeeded) of the supplier device. If any other functionality provided
> by device-links are needed, it is left to the consumer/supplier
> devices to change the link when they probe.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  drivers/of/platform.c                         | 158 ++++++++++++++++++
>  2 files changed, 163 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 138f6664b2e2..109b4310844f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3141,6 +3141,11 @@
>                         This can be set from sysctl after boot.
>                         See Documentation/sysctl/vm.txt for details.
>
> +       of_devlink      [KNL] Make device links from common DT bindings. Useful
> +                       for optimizing probe order and making sure resources
> +                       aren't turned off before the consumer devices have
> +                       probed.
> +
>         ohci1394_dma=early      [HW] enable debugging via the ohci1394 driver.
>                         See Documentation/debugging-via-ohci1394.txt for more
>                         info.
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 04ad312fd85b..88a2086e26fa 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -509,6 +509,163 @@ int of_platform_default_populate(struct device_node *root,
>  }
>  EXPORT_SYMBOL_GPL(of_platform_default_populate);
>
> +bool of_link_is_valid(struct device_node *con, struct device_node *sup)
> +{
> +       of_node_get(sup);
> +       /*
> +        * Don't allow linking a device node as a consumer of one of its
> +        * descendant nodes. By definition, a child node can't be a functional
> +        * dependency for the parent node.
> +        */
> +       while (sup) {
> +               if (sup == con) {
> +                       of_node_put(sup);
> +                       return false;
> +               }
> +               sup = of_get_next_parent(sup);
> +       }
> +       return true;
> +}
> +
> +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> +{
> +       struct platform_device *sup_dev;
> +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> +       int ret = 0;
> +
> +       /*
> +        * Since we are trying to create device links, we need to find
> +        * the actual device node that owns this supplier phandle.
> +        * Often times it's the same node, but sometimes it can be one
> +        * of the parents. So walk up the parent till you find a
> +        * device.
> +        */
> +       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> +               sup_np = of_get_next_parent(sup_np);
> +       if (!sup_np)
> +               return 0;
> +
> +       if (!of_link_is_valid(dev->of_node, sup_np)) {
> +               of_node_put(sup_np);
> +               return 0;
> +       }
> +       sup_dev = of_find_device_by_node(sup_np);
> +       of_node_put(sup_np);
> +       if (!sup_dev)
> +               return -ENODEV;
> +       if (!device_link_add(dev, &sup_dev->dev, dl_flags))
> +               ret = -ENODEV;
> +       put_device(&sup_dev->dev);
> +       return ret;
> +}
> +
> +static struct device_node *parse_prop_cells(struct device_node *np,
> +                                           const char *prop, int i,

I like 'i' for for loops, but less so for function params. Perhaps
'index' instead like of_parse_phandle_with_args.

> +                                           const char *binding,
> +                                           const char *cell)
> +{
> +       struct of_phandle_args sup_args;
> +
> +       if (!i && strcmp(prop, binding))

Why the '!i' test?

> +               return NULL;
> +
> +       if (of_parse_phandle_with_args(np, binding, cell, i, &sup_args))
> +               return NULL;
> +
> +       return sup_args.np;
> +}
> +
> +static struct device_node *parse_clocks(struct device_node *np,
> +                                       const char *prop, int i)
> +{
> +       return parse_prop_cells(np, prop, i, "clocks", "#clock-cells");
> +}
> +
> +static struct device_node *parse_interconnects(struct device_node *np,
> +                                              const char *prop, int i)
> +{
> +       return parse_prop_cells(np, prop, i, "interconnects",
> +                               "#interconnect-cells");
> +}
> +
> +static int strcmp_suffix(const char *str, const char *suffix)
> +{
> +       unsigned int len, suffix_len;
> +
> +       len = strlen(str);
> +       suffix_len = strlen(suffix);
> +       if (len <= suffix_len)
> +               return -1;
> +       return strcmp(str + len - suffix_len, suffix);
> +}
> +
> +static struct device_node *parse_regulators(struct device_node *np,
> +                                           const char *prop, int i)
> +{
> +       if (i || strcmp_suffix(prop, "-supply"))
> +               return NULL;
> +
> +       return of_parse_phandle(np, prop, 0);
> +}
> +
> +/**
> + * struct supplier_bindings - Information for parsing supplier DT binding
> + *
> + * @parse_prop:                If the function cannot parse the property, return NULL.
> + *                     Otherwise, return the phandle listed in the property
> + *                     that corresponds to index i.
> + */
> +struct supplier_bindings {
> +       struct device_node *(*parse_prop)(struct device_node *np,
> +                                         const char *name, int i);
> +};
> +
> +struct supplier_bindings bindings[] = {

static const

> +       { .parse_prop = parse_clocks, },
> +       { .parse_prop = parse_interconnects, },
> +       { .parse_prop = parse_regulators, },
> +       { },
> +};
> +
> +static bool of_link_property(struct device *dev, struct device_node *con_np,
> +                            const char *prop)
> +{
> +       struct device_node *phandle;
> +       struct supplier_bindings *s = bindings;
> +       unsigned int i = 0;
> +       bool done = true;
> +
> +       while (!i && s->parse_prop) {

Using 'i' is a little odd. Perhaps a 'matched' bool would be easier to read.

> +               while ((phandle = s->parse_prop(con_np, prop, i))) {
> +                       i++;
> +                       if (of_link_to_phandle(dev, phandle))
> +                               done = false;

Just return here. No point in continuing as 'done' is never set back to true.

> +               }
> +               s++;
> +       }
> +       return done ? 0 : -ENODEV;
> +}
> +
> +static bool of_devlink;
> +core_param(of_devlink, of_devlink, bool, 0);
> +
> +static int of_link_to_suppliers(struct device *dev)
> +{
> +       struct property *p;
> +       bool done = true;
> +
> +       if (!of_devlink)
> +               return 0;
> +       if (unlikely(!dev->of_node))
> +               return 0;
> +
> +       for_each_property_of_node(dev->of_node, p)
> +               if (of_link_property(dev, dev->of_node, p->name))
> +                       done = false;
> +
> +       return done ? 0 : -ENODEV;
> +}
> +
>  #ifndef CONFIG_PPC
>  static const struct of_device_id reserved_mem_matches[] = {
>         { .compatible = "qcom,rmtfs-mem" },
> @@ -524,6 +681,7 @@ static int __init of_platform_default_populate_init(void)
>         if (!of_have_populated_dt())
>                 return -ENODEV;
>
> +       platform_bus_type.add_links = of_link_to_suppliers;
>         /*
>          * Handle certain compatibles explicitly, since we don't want to create
>          * platform_devices for every node in /reserved-memory with a
> --
> 2.22.0.657.g960e92d24f-goog
>
