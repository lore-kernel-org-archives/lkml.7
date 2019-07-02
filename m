Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855BBC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1158321479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562031123;
	bh=2Mw+ivS0hV5UkHxGe2ymIkLyazLIhIh1UeLSbs2LoY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Iz7El1bSp4jzwA7l++8qlx6Q25riiQwPAPLzpVV2Zcsrwh5/FwjD2baYgQb2yqKoD
	 H3miYPROEca0k3428x7maRj8Wun7i0ifVS0zst/kVichMXyF3MGOVoDjXS/CcN2I0b
	 vU8URBuPvxPmpDHYEw+Z32l1PKRPiy/yOWDnrjlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGBBcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 21:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfGBBcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 21:32:01 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B9A2184B;
        Tue,  2 Jul 2019 01:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562031119;
        bh=2Mw+ivS0hV5UkHxGe2ymIkLyazLIhIh1UeLSbs2LoY0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FkEsKYD0fc8PFC5ElA9IjNJ3N2xXS7QYkCyPJ39GBFXudPkqWe6TzIcXqvuBJ438c
         TkYwhbHY6WP6ujAbvDNqZbnExq1h5fcQn+k8HEJPiNHMI2F28T5NPSVB+DcHewlzLy
         VDMHOIfrrwB4JguMkHKOLrRnwZUG4ZbXv70NR1gg=
Received: by mail-qt1-f171.google.com with SMTP id h21so16762254qtn.13;
        Mon, 01 Jul 2019 18:31:59 -0700 (PDT)
X-Gm-Message-State: APjAAAU6Ohqz5kYDk4G5xaxr5ZJsags0aINs4JzM9bHW+HwsljgpOaGh
        NY/5nYFV65HXhxE48JZlYTMsYB42jwre4iP/LA==
X-Google-Smtp-Source: APXvYqwcUxOFicpHqQrEqsJw12DJ1TeqJDomjqazDKIYyIFwRM295gZp7ecuXq79SIaQE0UfaoJAtESO342S6fJOgdU=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr23758126qth.136.1562031118652;
 Mon, 01 Jul 2019 18:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com> <20190702004811.136450-3-saravanak@google.com>
In-Reply-To: <20190702004811.136450-3-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Jul 2019 19:31:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdvDpKB=iV6x3eTr2F4zY0bxU-Wjb+JeMjj5rdnRc-OQ@mail.gmail.com>
Message-ID: <CAL_JsqLdvDpKB=iV6x3eTr2F4zY0bxU-Wjb+JeMjj5rdnRc-OQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>
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

On Mon, Jul 1, 2019 at 6:48 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Add device-links after the devices are created (but before they are
> probed) by looking at common DT bindings like clocks and
> interconnects.
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
>  drivers/of/Kconfig    |  9 ++++++++
>  drivers/of/platform.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 37c2ccbefecd..7c7fa7394b4c 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -103,4 +103,13 @@ config OF_OVERLAY
>  config OF_NUMA
>         bool
>
> +config OF_DEVLINKS

I'd prefer this not be a config option. After all, we want one kernel
build that works for all platforms.

A kernel command line option to disable might be useful for debugging.

> +       bool "Device links from DT bindings"
> +       help
> +         Common DT bindings like clocks, interconnects, etc represent a
> +         consumer device's dependency on suppliers devices. This option
> +         creates device links from these common bindings so that consumers are
> +         probed only after all their suppliers are active and suppliers can
> +         tell when all their consumers are active.
> +
>  endif # OF
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 04ad312fd85b..a53717168aca 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -61,6 +61,57 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
>  EXPORT_SYMBOL(of_find_device_by_node);
>
>  #ifdef CONFIG_OF_ADDRESS
> +static int of_link_binding(struct device *dev, char *binding, char *cell)

Under CONFIG_OF_ADDRESS seems like a strange location.

> +{
> +       struct of_phandle_args sup_args;
> +       struct platform_device *sup_dev;
> +       unsigned int i = 0, links = 0;
> +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> +
> +       while (!of_parse_phandle_with_args(dev->of_node, binding, cell, i,
> +                                          &sup_args)) {
> +               i++;
> +               sup_dev = of_find_device_by_node(sup_args.np);
> +               if (!sup_dev)
> +                       continue;
> +               if (device_link_add(dev, &sup_dev->dev, dl_flags))
> +                       links++;
> +               put_device(&sup_dev->dev);
> +       }
> +       if (links < i)
> +               return -ENODEV;
> +       return 0;
> +}
> +
> +/*
> + * List of bindings and their cell names (use NULL if no cell names) from which
> + * device links need to be created.
> + */
> +static char *link_bindings[] = {

const

> +#ifdef CONFIG_OF_DEVLINKS
> +       "clocks", "#clock-cells",
> +       "interconnects", "#interconnect-cells",

Planning to add others?

> +#endif
> +};
> +
> +static int of_link_to_suppliers(struct device *dev)
> +{
> +       unsigned int i = 0;
> +       bool done = true;
> +
> +       if (unlikely(!dev->of_node))
> +               return 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(link_bindings) / 2; i++)
> +               if (of_link_binding(dev, link_bindings[i * 2],
> +                                       link_bindings[i * 2 + 1]))
> +                       done = false;
> +
> +       if (!done)
> +               return -ENODEV;
> +       return 0;
> +}
> +
>  /*
>   * The following routines scan a subtree and registers a device for
>   * each applicable node.
> @@ -524,6 +575,7 @@ static int __init of_platform_default_populate_init(void)
>         if (!of_have_populated_dt())
>                 return -ENODEV;
>
> +       platform_bus_type.add_links = of_link_to_suppliers;
>         /*
>          * Handle certain compatibles explicitly, since we don't want to create
>          * platform_devices for every node in /reserved-memory with a
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
