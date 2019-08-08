Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2884E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGIVu5fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfHHCGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:06:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42524 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfHHCGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:06:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so43132194pff.9;
        Wed, 07 Aug 2019 19:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xEG3/XY389FHJwbMX0Fg1E0kicUHZSRkL0u3dbjBmBE=;
        b=RGIVu5fxEKjB+uT0uC70pD9DLhlEed7HYv4+fn61MBGYDaNp+NewNwRnjchZO4XHT1
         /a43bj5Yiwj91TgzRZHmACww5t40y0Rp3akXf/R2MQ9EwMejC+/KDOEY1aGPPIgKnOFM
         UGiXA4SdRKS5AO/UK9GA1bvUYRh1uDJ0LyujCTqRUVeoE3myJW4Yn1j3g05z8ESZgr54
         JklV4W+Hru7T8ueMvSBrs8BsM6DC+5E8pDY1Q0XNsNb40fNoSkPo8wxNh6RRQBQDAFTY
         7CXwv3iMw8eGnMC24GEmecBTbdD9OG5KuZlnRY63oQ1LWJukcRoUO8D578PuXgzJGdim
         gDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xEG3/XY389FHJwbMX0Fg1E0kicUHZSRkL0u3dbjBmBE=;
        b=cnH85OaRgSrv8kc/wKdCHa8IzWOQC0O2zJMQb+e1POPgmGA9nkjIWcVRdnSA6aZMdO
         4du1zcigXuTxkCqXFU6YZsyLWC1q0ksWqGA5cHPZbsyWHP54MBvXCWDVCjd1C7n2pVj4
         wcRbGgYoKhRGvfL5H0BDwrlRXWOkmrhPKoAqkn499VYcU22J9fm4VDYsVz5ihiRCXkkr
         7QsRBqG2Qky/KafL2rhWvCcwg/CXsyAiBrvk0dEa0DJ+hnl4X00pwPVR8+/S1Bd5MsBW
         Wo1DvJAj5/aOBiS//SGpGa6yUNs47/ZgoV0epTJMgenQJrr2BGwH623IfsIpVH7NKXVV
         EP/Q==
X-Gm-Message-State: APjAAAUIu46KaFpHoBispiyQqB1AcSlXxx7htV7ny9rg6eu6+iUMxDvh
        AW8GAjm/BinZuCXrjyl4I00=
X-Google-Smtp-Source: APXvYqxE45KIuTMTlo8RvnIPfzcStzh7o7UHvMouTGgD1rz5voPlkR7ZPT0VM4LFYpAWpKmnjuvjEw==
X-Received: by 2002:a62:6:: with SMTP id 6mr12349875pfa.159.1565230010412;
        Wed, 07 Aug 2019 19:06:50 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id x22sm99410396pff.5.2019.08.07.19.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 19:06:49 -0700 (PDT)
Subject: Re: [PATCH v7 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com, linux-doc@vger.kernel.org
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-4-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <141d2e16-26cc-1f05-1ac0-6784bab5ae88@gmail.com>
Date:   Wed, 7 Aug 2019 19:06:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724001100.133423-4-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/19 5:10 PM, Saravana Kannan wrote:
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
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  drivers/of/platform.c                         | 165 ++++++++++++++++++
>  2 files changed, 170 insertions(+)
> 

Documentation/admin-guide/kernel-paramers.rst:

After line 129, add:

	OF	Devicetree is enabled

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 46b826fcb5ad..12937349d79d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3170,6 +3170,11 @@
>  			This can be set from sysctl after boot.
>  			See Documentation/admin-guide/sysctl/vm.rst for details.
>  
> +	of_devlink	[KNL] Make device links from common DT bindings. Useful
> +			for optimizing probe order and making sure resources
> +			aren't turned off before the consumer devices have
> +			probed.

        of_supplier_depend instead of of_devlink ????

	of_supplier_depend
			[OF, KNL] Make device links from consumer devicetree
			nodes to supplier devicetree nodes.  The
			consumer / supplier relationships are inferred from
			scanning the devicetree.  The driver for a consumer
			device will not be probed until the drivers for all of
			its supplier devices have been successfully probed.


> +
>  	ohci1394_dma=early	[HW] enable debugging via the ohci1394 driver.
>  			See Documentation/debugging-via-ohci1394.txt for more
>  			info.
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 7801e25e6895..4344419a26fc 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -508,6 +508,170 @@ int of_platform_default_populate(struct device_node *root,
>  }
>  EXPORT_SYMBOL_GPL(of_platform_default_populate);
>  

> +bool of_link_is_valid(struct device_node *con, struct device_node *sup)

Change to less vague:

   bool of_ancestor_of(struct device_node *test_np, struct device_node *np)


> +{
> +	of_node_get(sup);
> +	/*
> +	 * Don't allow linking a device node as a consumer of one of its
> +	 * descendant nodes. By definition, a child node can't be a functional
> +	 * dependency for the parent node.
> +	 */
> +	while (sup) {
> +		if (sup == con) {
> +			of_node_put(sup);
> +			return false;
> +		}
> +		sup = of_get_next_parent(sup);
> +	}
> +	return true;

Change to more generic:

	of_node_get(test_np);
	while (test_np) {
		if (test_np == np) {
			of_node_put(test_np);
			return true;
		}
		test_np = of_get_next_parent(test_np);
	}
	return false;

> +}
> +


/**
 * of_link_to_phandle - Add device link to supplier
 * @dev: consumer device
 * @sup_np: pointer to the supplier device tree node
 *
 * TODO: ...
 *
 * Return:
 * * 0 if link successfully created for supplier or of_devlink is false
 * * an error if unable to create link
 */

Should have dev_debug() or pr_warn() or something on errors in this
function -- the caller does not report any issue

> +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> +{
> +	struct platform_device *sup_dev;
> +	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> +	int ret = 0;
> +
> +	/*

> +	 * Since we are trying to create device links, we need to find
> +	 * the actual device node that owns this supplier phandle.
> +	 * Often times it's the same node, but sometimes it can be one
> +	 * of the parents. So walk up the parent till you find a
> +	 * device.

Change comment to:

	 * Find the device node that contains the supplier phandle.  It may
	 * be @sup_np or it may be an ancestor of @sup_np.

> +	 */

See comment in caller of of_link_to_phandle() - do not hide the final
of_node_put() of sup_np inside of_link_to_phandle(), so need to do
an of_node_get() here.

	of_node_get(sup_np);

> +	while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> +		sup_np = of_get_next_parent(sup_np);
> +	if (!sup_np)

> +		return 0;

This case should never occur(?), it is an error.

                return -ENODEV;

> +
> +	if (!of_link_is_valid(dev->of_node, sup_np)) {
> +		of_node_put(sup_np);
> +		return 0;

Do not use a name that obscures what the function is doing, also
return an actual issue.

	if (of_ancestor_of(sup_np, dev->of_node)) {
		of_node_put(sup_np);
		return -EINVAL;

> +	}
> +	sup_dev = of_find_device_by_node(sup_np);
> +	of_node_put(sup_np);
> +	if (!sup_dev)
> +		return -ENODEV;
> +	if (!device_link_add(dev, &sup_dev->dev, dl_flags))
> +		ret = -ENODEV;
> +	put_device(&sup_dev->dev);
> +	return ret;
> +}
> +

/**
 * parse_prop_cells - Property parsing functions for suppliers
 *
 * @np:            pointer to a device tree node containing a list
 * @prop_name:     Name of property holding a phandle value
 * @phandle_index: For properties holding a table of phandles, this is the
 *                 index into the table
 * @list_name:     property name that contains a list
 * @cells_name:    property name that specifies phandles' arguments count
 *
 * This function is useful to parse lists of phandles and their arguments.
 *
 * Return:
 * * Node pointer with refcount incremented, use of_node_put() on it when done.
 * * NULL if not found.
 */

> +static struct device_node *parse_prop_cells(struct device_node *np,
> +					    const char *prop, int index,
> +					    const char *binding,
> +					    const char *cell)

Make names consistent with of_parse_phandle_with_args():
  Change prop to prop_name
  Change index to phandle_index
  Change binding to list_name
  Change cell to cells_name

> +{
> +	struct of_phandle_args sup_args;
> +

> +	/* Don't need to check property name for every index. */
> +	if (!index && strcmp(prop, binding))
> +		return NULL;

I read the discussion on whether to check property name only once
in version 6.

This check is fragile, depending upon the calling code to be properly
structured.  Do the check for all values of index.  The reduction of
overhead from not checking does not justify the fragileness and the
extra complexity for the code reader to understand why the check can
be bypassed when
index is not zero.

> +
> +	if (of_parse_phandle_with_args(np, binding, cell, index, &sup_args))
> +		return NULL;
> +
> +	return sup_args.np;
> +}
> +
> +static struct device_node *parse_clocks(struct device_node *np,
> +					const char *prop, int index)

Change prop to prop_name
Change index to phandle_index

> +{
> +	return parse_prop_cells(np, prop, index, "clocks", "#clock-cells");
> +}
> +
> +static struct device_node *parse_interconnects(struct device_node *np,
> +					       const char *prop, int index)

Change prop to prop_name
Change index to phandle_index

> +{
> +	return parse_prop_cells(np, prop, index, "interconnects",
> +				"#interconnect-cells");
> +}
> +
> +static int strcmp_suffix(const char *str, const char *suffix)
> +{
> +	unsigned int len, suffix_len;
> +
> +	len = strlen(str);
> +	suffix_len = strlen(suffix);
> +	if (len <= suffix_len)
> +		return -1;
> +	return strcmp(str + len - suffix_len, suffix);
> +}
> +
> +static struct device_node *parse_regulators(struct device_node *np,
> +					    const char *prop, int index)

Change prop to prop_name
Change index to phandle_index

> +{
> +	if (index || strcmp_suffix(prop, "-supply"))
> +		return NULL;
> +
> +	return of_parse_phandle(np, prop, 0);
> +}
> +
> +/**

> + * struct supplier_bindings - Information for parsing supplier DT binding
> + *
> + * @parse_prop:		If the function cannot parse the property, return NULL.
> + *			Otherwise, return the phandle listed in the property
> + *			that corresponds to the index.

There is no documentation of dynamic function parameters in the docbook
description of a struct.  Use this format for now and I will clean up when
I clean up all of the devicetree docbook info.

Change above comment to:

 * struct supplier_bindings - Property parsing functions for suppliers
 *
 * @parse_prop: function name
 *              parse_prop() finds the node corresponding to a supplier phandle
 * @parse_prop.np: Pointer to device node holding supplier phandle property
 * @parse_prop.prop_name: Name of property holding a phandle value
 * @parse_prop.index: For properties holding a table of phandles, this is the
 *                    index into the table
 *
 * Return:
 * * parse_prop() return values are
 * * Node pointer with refcount incremented, use of_node_put() on it when done.
 * * NULL if not found.

> + */
> +struct supplier_bindings {
> +	struct device_node *(*parse_prop)(struct device_node *np,
> +					  const char *name, int index);

Change name to prop_name
Change index to phandle_index

> +};
> +
> +static const struct supplier_bindings bindings[] = {
> +	{ .parse_prop = parse_clocks, },
> +	{ .parse_prop = parse_interconnects, },
> +	{ .parse_prop = parse_regulators, },

> +	{ },

	{},

> +};
> +

/**
 * of_link_property - TODO:
 * dev:
 * con_np:
 * prop:
 *
 * TODO...
 *
 * Any failed attempt to create a link will NOT result in an immediate return.
 * of_link_property() must create all possible links even when one of more
 * attempts to create a link fail.

Why?  isn't one failure enough to prevent probing this device?
Continuing to scan just results in extra work... which will be
repeated every time device_link_check_waiting_consumers() is called

 *
 * Return:
 * * 0 if TODO:
 * * -ENODEV on error
 */


I left some "TODO:" sections to be filled out above.


> +static bool of_link_property(struct device *dev, struct device_node *con_np,
> +			     const char *prop)

Returns 0 or -ENODEV, so bool is incorrect

(Also fixed on 8/8 in patch: "[PATCH 1/2] of/platform: Fix fn definitons for
of_link_is_valid() and of_link_property()")



> +{
> +	struct device_node *phandle;
> +	struct supplier_bindings *s = bindings;
> +	unsigned int i = 0;

> +	bool done = true, matched = false;

Change to:

   	bool matched = false;
	int ret = 0;

	/* do not stop at first failed link, link all available suppliers */

> +
> +	while (!matched && s->parse_prop) {
> +		while ((phandle = s->parse_prop(con_np, prop, i))) {
> +			matched = true;
> +			i++;
> +			if (of_link_to_phandle(dev, phandle))


Remove comment:

> +				/*
> +				 * Don't stop at the first failure. See
> +				 * Documentation for bus_type.add_links for
> +				 * more details.
> +				 */

> +				done = false;

				ret = -ENODEV;

Do not hide of_node_put() inside of_link_to_phandle(), do it here:

			of_node_put(phandle);

> +		}
> +		s++;
> +	}

> +	return done ? 0 : -ENODEV;

	return ret;

> +}
> +
> +static bool of_devlink;
> +core_param(of_devlink, of_devlink, bool, 0);
> +

/**
 * of_link_to_suppliers - Add device links to suppliers
 * @dev: consumer device
 *
 * Create device links to all available suppliers of @dev.
 * Must NOT stop at the first failed link.
 * If some suppliers are not yet available, this function will be
 * called again when additional suppliers become available.
 *
 * Return:
 * * 0 if links successfully created for all suppliers
 * * an error if one or more suppliers not yet available
 */

> +static int of_link_to_suppliers(struct device *dev)
> +{
> +	struct property *p;

> +	bool done = true;

remove done

        int ret = 0;

> +
> +	if (!of_devlink)
> +		return 0;

> +	if (unlikely(!dev->of_node))
> +		return 0;

Check not needed, for_each_property_of_node() will detect !dev->of_node.

> +
> +	for_each_property_of_node(dev->of_node, p)
> +		if (of_link_property(dev, dev->of_node, p->name))

> +			done = false;

                        ret = -EAGAIN;

> +
> +	return done ? 0 : -ENODEV;

	return ret;

> +}
> +
>  #ifndef CONFIG_PPC
>  static const struct of_device_id reserved_mem_matches[] = {
>  	{ .compatible = "qcom,rmtfs-mem" },
> @@ -523,6 +687,7 @@ static int __init of_platform_default_populate_init(void)
>  	if (!of_have_populated_dt())
>  		return -ENODEV;
>  
> +	platform_bus_type.add_links = of_link_to_suppliers;
>  	/*
>  	 * Handle certain compatibles explicitly, since we don't want to create
>  	 * platform_devices for every node in /reserved-memory with a
> -- 
> 2.22.0.709.g102302147b-goog
> 
>
