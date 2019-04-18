Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B09C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9E3206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqgBmBI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbfDRRWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:22:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43902 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:22:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so1401263pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LbVeSWKfue7/gECMK5v38M3tt+cwkQaJRNo3LXCgg98=;
        b=kqgBmBI+C8w0uc0UzwoFnwq5qP0K8S58FeYL9TGPB7Y4l9eNvs9Pm/byCztTLkQ+IJ
         8gNhkPEr/RImSdP9Q0R6qZj55mqP+JyajZyfRd6+9UBXaS+sBsjWJPb44cHME0308BqY
         qIE3k42QCHZzQ7z7NVKh6hHDG7zdrnIPRWIugYhB403yoiFkvLo5WB5KqSMmPrHk1C0k
         0GePhfFJU6oCTJIe0V/tOtY5lmqiEyiYSaY+vz4+8JREq2gm81hJAJgmLNzsrR+q2VL6
         requYd9lf8YxkWJGEBxz291wMzw9YjUwU4nYWznPtqskx2vxg/FXKAJ+1WjBRU+4kN5N
         RSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LbVeSWKfue7/gECMK5v38M3tt+cwkQaJRNo3LXCgg98=;
        b=KtmcLoP6/HZHzjUjERwDWx7SZHrDYZwMexr+lY2jLUlpiIdIUiqD7Y54DUtlm99vF+
         SDWuUs9l8UdtQdGHJRSZ+gyGaWrRUKM55rKLyJ5Ubhd9R3cpSIjhHIW7+R0GgbRRdnQg
         LlG1n5E8h8tOJ/yovthLAIi++oOTT/iv3y2XkJ3rLXp9giM19+uPQ+ZMFXIe9l0o/mRk
         0uOP1bsmzJDeXnHFT7p+grq7BFmvXBN/08sE0MLwZiBqlUqVKhyjywS4lxlOdGXfy/TG
         IA/7VA9g0WJN2DIlql+g78u6QwiQ7InYWT5d2UpV7llM1abydba7tMCbvu+7YYeFqP4s
         siXQ==
X-Gm-Message-State: APjAAAUmjwUJ9iei01733gMIqjdqHj4eMedCaZBZNsAQg4LeMG06qSER
        JpAxkXaGpKdw+Vq4ahHUa7KkNQ==
X-Google-Smtp-Source: APXvYqwaOvvk942d5BCfqkHiKwPCoEjiy2zpfUZR7wBo2xnx2TxKZgwhhFRIsD4TPSKMOXfEiaO0cg==
X-Received: by 2002:a65:554e:: with SMTP id t14mr79642974pgr.107.1555608168762;
        Thu, 18 Apr 2019 10:22:48 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 66sm3888635pfr.44.2019.04.18.10.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 10:22:47 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:22:45 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 14/36] coresight: Rename of_coresight to
 coresight-platform
Message-ID: <20190418172245.GB10675@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-15-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-15-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:03:57PM +0100, Suzuki K Poulose wrote:
> Rename the firmware handling file to a more generic
> name, in preparation for adding ACPI support.

I am in agreement with this patch and also understand why you're doing it.  But
for someone without context and with this very short changelog, it would
certainly be cryptic.

Please enhance the description so that someone without background can have a
better understanding of what is going on.

With that:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/Makefile             |   3 +-
>  drivers/hwtracing/coresight/coresight-platform.c | 298 +++++++++++++++++++++++
>  drivers/hwtracing/coresight/of_coresight.c       | 297 ----------------------
>  3 files changed, 299 insertions(+), 299 deletions(-)
>  create mode 100644 drivers/hwtracing/coresight/coresight-platform.c
>  delete mode 100644 drivers/hwtracing/coresight/of_coresight.c
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 3b435aa..3c0ac42 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -2,8 +2,7 @@
>  #
>  # Makefile for CoreSight drivers.
>  #
> -obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
> -obj-$(CONFIG_OF) += of_coresight.o
> +obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o coresight-platform.o
>  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o \
>  					     coresight-tmc-etf.o \
>  					     coresight-tmc-etr.o
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> new file mode 100644
> index 0000000..514cc2b
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2012, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/amba/bus.h>
> +#include <linux/coresight.h>
> +#include <linux/cpumask.h>
> +#include <asm/smp_plat.h>
> +
> +#ifdef CONFIG_OF
> +static int of_dev_node_match(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}
> +
> +static struct device *
> +of_coresight_get_endpoint_device(struct device_node *endpoint)
> +{
> +	struct device *dev = NULL;
> +
> +	/*
> +	 * If we have a non-configurable replicator, it will be found on the
> +	 * platform bus.
> +	 */
> +	dev = bus_find_device(&platform_bus_type, NULL,
> +			      endpoint, of_dev_node_match);
> +	if (dev)
> +		return dev;
> +
> +	/*
> +	 * We have a configurable component - circle through the AMBA bus
> +	 * looking for the device that matches the endpoint node.
> +	 */
> +	return bus_find_device(&amba_bustype, NULL,
> +			       endpoint, of_dev_node_match);
> +}
> +
> +static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
> +{
> +	return of_property_read_bool(ep, "slave-mode");
> +}
> +
> +static void of_coresight_get_ports_legacy(const struct device_node *node,
> +					  int *nr_inport, int *nr_outport)
> +{
> +	struct device_node *ep = NULL;
> +	int in = 0, out = 0;
> +
> +	do {
> +		ep = of_graph_get_next_endpoint(node, ep);
> +		if (!ep)
> +			break;
> +
> +		if (of_coresight_legacy_ep_is_input(ep))
> +			in++;
> +		else
> +			out++;
> +
> +	} while (ep);
> +
> +	*nr_inport = in;
> +	*nr_outport = out;
> +}
> +
> +static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
> +{
> +	struct device_node *parent = of_graph_get_port_parent(ep);
> +
> +	/*
> +	 * Skip one-level up to the real device node, if we
> +	 * are using the new bindings.
> +	 */
> +	if (of_node_name_eq(parent, "in-ports") ||
> +	    of_node_name_eq(parent, "out-ports"))
> +		parent = of_get_next_parent(parent);
> +
> +	return parent;
> +}
> +
> +static inline struct device_node *
> +of_coresight_get_input_ports_node(const struct device_node *node)
> +{
> +	return of_get_child_by_name(node, "in-ports");
> +}
> +
> +static inline struct device_node *
> +of_coresight_get_output_ports_node(const struct device_node *node)
> +{
> +	return of_get_child_by_name(node, "out-ports");
> +}
> +
> +static inline int
> +of_coresight_count_ports(struct device_node *port_parent)
> +{
> +	int i = 0;
> +	struct device_node *ep = NULL;
> +
> +	while ((ep = of_graph_get_next_endpoint(port_parent, ep)))
> +		i++;
> +	return i;
> +}
> +
> +static void of_coresight_get_ports(const struct device_node *node,
> +				   int *nr_inport, int *nr_outport)
> +{
> +	struct device_node *input_ports = NULL, *output_ports = NULL;
> +
> +	input_ports = of_coresight_get_input_ports_node(node);
> +	output_ports = of_coresight_get_output_ports_node(node);
> +
> +	if (input_ports || output_ports) {
> +		if (input_ports) {
> +			*nr_inport = of_coresight_count_ports(input_ports);
> +			of_node_put(input_ports);
> +		}
> +		if (output_ports) {
> +			*nr_outport = of_coresight_count_ports(output_ports);
> +			of_node_put(output_ports);
> +		}
> +	} else {
> +		/* Fall back to legacy DT bindings parsing */
> +		of_coresight_get_ports_legacy(node, nr_inport, nr_outport);
> +	}
> +}
> +
> +static int of_coresight_alloc_memory(struct device *dev,
> +			struct coresight_platform_data *pdata)
> +{
> +	if (pdata->nr_outport) {
> +		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
> +					    sizeof(*pdata->conns),
> +					    GFP_KERNEL);
> +		if (!pdata->conns)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +int of_coresight_get_cpu(const struct device_node *node)
> +{
> +	int cpu;
> +	struct device_node *dn;
> +
> +	dn = of_parse_phandle(node, "cpu", 0);
> +	/* Affinity defaults to CPU0 */
> +	if (!dn)
> +		return 0;
> +	cpu = of_cpu_node_to_id(dn);
> +	of_node_put(dn);
> +
> +	/* Affinity to CPU0 if no cpu nodes are found */
> +	return (cpu < 0) ? 0 : cpu;
> +}
> +EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
> +
> +/*
> + * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> + * and fill the connection information in @conn
> + *
> + * Parses the local port, remote device name and the remote port.
> + *
> + * Returns :
> + *	 1	- If the parsing is successful and a connection record
> + *		  was created for an output connection.
> + *	 0	- If the parsing completed without any fatal errors.
> + *	-Errno	- Fatal error, abort the scanning.
> + */
> +static int of_coresight_parse_endpoint(struct device *dev,
> +				       struct device_node *ep,
> +				       struct coresight_connection *conn)
> +{
> +	int ret = 0;
> +	struct of_endpoint endpoint, rendpoint;
> +	struct device_node *rparent = NULL;
> +	struct device_node *rep = NULL;
> +	struct device *rdev = NULL;
> +
> +	do {
> +		/* Parse the local port details */
> +		if (of_graph_parse_endpoint(ep, &endpoint))
> +			break;
> +		/*
> +		 * Get a handle on the remote endpoint and the device it is
> +		 * attached to.
> +		 */
> +		rep = of_graph_get_remote_endpoint(ep);
> +		if (!rep)
> +			break;
> +		rparent = of_coresight_get_port_parent(rep);
> +		if (!rparent)
> +			break;
> +		if (of_graph_parse_endpoint(rep, &rendpoint))
> +			break;
> +
> +		/* If the remote device is not available, defer probing */
> +		rdev = of_coresight_get_endpoint_device(rparent);
> +		if (!rdev) {
> +			ret = -EPROBE_DEFER;
> +			break;
> +		}
> +
> +		conn->outport = endpoint.port;
> +		conn->child_name = devm_kstrdup(dev,
> +						dev_name(rdev),
> +						GFP_KERNEL);
> +		conn->child_port = rendpoint.port;
> +		/* Connection record updated */
> +		ret = 1;
> +	} while (0);
> +
> +	of_node_put(rparent);
> +	of_node_put(rep);
> +	put_device(rdev);
> +
> +	return ret;
> +}
> +
> +struct coresight_platform_data *
> +of_get_coresight_platform_data(struct device *dev,
> +			       const struct device_node *node)
> +{
> +	int ret = 0;
> +	struct coresight_platform_data *pdata;
> +	struct coresight_connection *conn;
> +	struct device_node *ep = NULL;
> +	const struct device_node *parent = NULL;
> +	bool legacy_binding = false;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Use device name as sysfs handle */
> +	pdata->name = dev_name(dev);
> +	pdata->cpu = of_coresight_get_cpu(node);
> +
> +	/* Get the number of input and output port for this component */
> +	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
> +
> +	/* If there are no output connections, we are done */
> +	if (!pdata->nr_outport)
> +		return pdata;
> +
> +	ret = of_coresight_alloc_memory(dev, pdata);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	parent = of_coresight_get_output_ports_node(node);
> +	/*
> +	 * If the DT uses obsoleted bindings, the ports are listed
> +	 * under the device and we need to filter out the input
> +	 * ports.
> +	 */
> +	if (!parent) {
> +		legacy_binding = true;
> +		parent = node;
> +		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
> +	}
> +
> +	conn = pdata->conns;
> +
> +	/* Iterate through each output port to discover topology */
> +	while ((ep = of_graph_get_next_endpoint(parent, ep))) {
> +		/*
> +		 * Legacy binding mixes input/output ports under the
> +		 * same parent. So, skip the input ports if we are dealing
> +		 * with legacy binding, as they processed with their
> +		 * connected output ports.
> +		 */
> +		if (legacy_binding && of_coresight_legacy_ep_is_input(ep))
> +			continue;
> +
> +		ret = of_coresight_parse_endpoint(dev, ep, conn);
> +		switch (ret) {
> +		case 1:
> +			conn++;		/* Fall through */
> +		case 0:
> +			break;
> +		default:
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
> +	return pdata;
> +}
> +EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
> +#endif
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> deleted file mode 100644
> index 7045930..0000000
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ /dev/null
> @@ -1,297 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2012, The Linux Foundation. All rights reserved.
> - */
> -
> -#include <linux/types.h>
> -#include <linux/err.h>
> -#include <linux/slab.h>
> -#include <linux/clk.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_graph.h>
> -#include <linux/of_platform.h>
> -#include <linux/platform_device.h>
> -#include <linux/amba/bus.h>
> -#include <linux/coresight.h>
> -#include <linux/cpumask.h>
> -#include <asm/smp_plat.h>
> -
> -
> -static int of_dev_node_match(struct device *dev, void *data)
> -{
> -	return dev->of_node == data;
> -}
> -
> -static struct device *
> -of_coresight_get_endpoint_device(struct device_node *endpoint)
> -{
> -	struct device *dev = NULL;
> -
> -	/*
> -	 * If we have a non-configurable replicator, it will be found on the
> -	 * platform bus.
> -	 */
> -	dev = bus_find_device(&platform_bus_type, NULL,
> -			      endpoint, of_dev_node_match);
> -	if (dev)
> -		return dev;
> -
> -	/*
> -	 * We have a configurable component - circle through the AMBA bus
> -	 * looking for the device that matches the endpoint node.
> -	 */
> -	return bus_find_device(&amba_bustype, NULL,
> -			       endpoint, of_dev_node_match);
> -}
> -
> -static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
> -{
> -	return of_property_read_bool(ep, "slave-mode");
> -}
> -
> -static void of_coresight_get_ports_legacy(const struct device_node *node,
> -					  int *nr_inport, int *nr_outport)
> -{
> -	struct device_node *ep = NULL;
> -	int in = 0, out = 0;
> -
> -	do {
> -		ep = of_graph_get_next_endpoint(node, ep);
> -		if (!ep)
> -			break;
> -
> -		if (of_coresight_legacy_ep_is_input(ep))
> -			in++;
> -		else
> -			out++;
> -
> -	} while (ep);
> -
> -	*nr_inport = in;
> -	*nr_outport = out;
> -}
> -
> -static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
> -{
> -	struct device_node *parent = of_graph_get_port_parent(ep);
> -
> -	/*
> -	 * Skip one-level up to the real device node, if we
> -	 * are using the new bindings.
> -	 */
> -	if (of_node_name_eq(parent, "in-ports") ||
> -	    of_node_name_eq(parent, "out-ports"))
> -		parent = of_get_next_parent(parent);
> -
> -	return parent;
> -}
> -
> -static inline struct device_node *
> -of_coresight_get_input_ports_node(const struct device_node *node)
> -{
> -	return of_get_child_by_name(node, "in-ports");
> -}
> -
> -static inline struct device_node *
> -of_coresight_get_output_ports_node(const struct device_node *node)
> -{
> -	return of_get_child_by_name(node, "out-ports");
> -}
> -
> -static inline int
> -of_coresight_count_ports(struct device_node *port_parent)
> -{
> -	int i = 0;
> -	struct device_node *ep = NULL;
> -
> -	while ((ep = of_graph_get_next_endpoint(port_parent, ep)))
> -		i++;
> -	return i;
> -}
> -
> -static void of_coresight_get_ports(const struct device_node *node,
> -				   int *nr_inport, int *nr_outport)
> -{
> -	struct device_node *input_ports = NULL, *output_ports = NULL;
> -
> -	input_ports = of_coresight_get_input_ports_node(node);
> -	output_ports = of_coresight_get_output_ports_node(node);
> -
> -	if (input_ports || output_ports) {
> -		if (input_ports) {
> -			*nr_inport = of_coresight_count_ports(input_ports);
> -			of_node_put(input_ports);
> -		}
> -		if (output_ports) {
> -			*nr_outport = of_coresight_count_ports(output_ports);
> -			of_node_put(output_ports);
> -		}
> -	} else {
> -		/* Fall back to legacy DT bindings parsing */
> -		of_coresight_get_ports_legacy(node, nr_inport, nr_outport);
> -	}
> -}
> -
> -static int of_coresight_alloc_memory(struct device *dev,
> -			struct coresight_platform_data *pdata)
> -{
> -	if (pdata->nr_outport) {
> -		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
> -					    sizeof(*pdata->conns),
> -					    GFP_KERNEL);
> -		if (!pdata->conns)
> -			return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -
> -int of_coresight_get_cpu(const struct device_node *node)
> -{
> -	int cpu;
> -	struct device_node *dn;
> -
> -	dn = of_parse_phandle(node, "cpu", 0);
> -	/* Affinity defaults to CPU0 */
> -	if (!dn)
> -		return 0;
> -	cpu = of_cpu_node_to_id(dn);
> -	of_node_put(dn);
> -
> -	/* Affinity to CPU0 if no cpu nodes are found */
> -	return (cpu < 0) ? 0 : cpu;
> -}
> -EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
> -
> -/*
> - * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> - * and fill the connection information in @conn
> - *
> - * Parses the local port, remote device name and the remote port.
> - *
> - * Returns :
> - *	 1	- If the parsing is successful and a connection record
> - *		  was created for an output connection.
> - *	 0	- If the parsing completed without any fatal errors.
> - *	-Errno	- Fatal error, abort the scanning.
> - */
> -static int of_coresight_parse_endpoint(struct device *dev,
> -				       struct device_node *ep,
> -				       struct coresight_connection *conn)
> -{
> -	int ret = 0;
> -	struct of_endpoint endpoint, rendpoint;
> -	struct device_node *rparent = NULL;
> -	struct device_node *rep = NULL;
> -	struct device *rdev = NULL;
> -
> -	do {
> -		/* Parse the local port details */
> -		if (of_graph_parse_endpoint(ep, &endpoint))
> -			break;
> -		/*
> -		 * Get a handle on the remote endpoint and the device it is
> -		 * attached to.
> -		 */
> -		rep = of_graph_get_remote_endpoint(ep);
> -		if (!rep)
> -			break;
> -		rparent = of_coresight_get_port_parent(rep);
> -		if (!rparent)
> -			break;
> -		if (of_graph_parse_endpoint(rep, &rendpoint))
> -			break;
> -
> -		/* If the remote device is not available, defer probing */
> -		rdev = of_coresight_get_endpoint_device(rparent);
> -		if (!rdev) {
> -			ret = -EPROBE_DEFER;
> -			break;
> -		}
> -
> -		conn->outport = endpoint.port;
> -		conn->child_name = devm_kstrdup(dev,
> -						dev_name(rdev),
> -						GFP_KERNEL);
> -		conn->child_port = rendpoint.port;
> -		/* Connection record updated */
> -		ret = 1;
> -	} while (0);
> -
> -	of_node_put(rparent);
> -	of_node_put(rep);
> -	put_device(rdev);
> -
> -	return ret;
> -}
> -
> -struct coresight_platform_data *
> -of_get_coresight_platform_data(struct device *dev,
> -			       const struct device_node *node)
> -{
> -	int ret = 0;
> -	struct coresight_platform_data *pdata;
> -	struct coresight_connection *conn;
> -	struct device_node *ep = NULL;
> -	const struct device_node *parent = NULL;
> -	bool legacy_binding = false;
> -
> -	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata)
> -		return ERR_PTR(-ENOMEM);
> -
> -	/* Use device name as sysfs handle */
> -	pdata->name = dev_name(dev);
> -	pdata->cpu = of_coresight_get_cpu(node);
> -
> -	/* Get the number of input and output port for this component */
> -	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
> -
> -	/* If there are no output connections, we are done */
> -	if (!pdata->nr_outport)
> -		return pdata;
> -
> -	ret = of_coresight_alloc_memory(dev, pdata);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	parent = of_coresight_get_output_ports_node(node);
> -	/*
> -	 * If the DT uses obsoleted bindings, the ports are listed
> -	 * under the device and we need to filter out the input
> -	 * ports.
> -	 */
> -	if (!parent) {
> -		legacy_binding = true;
> -		parent = node;
> -		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
> -	}
> -
> -	conn = pdata->conns;
> -
> -	/* Iterate through each output port to discover topology */
> -	while ((ep = of_graph_get_next_endpoint(parent, ep))) {
> -		/*
> -		 * Legacy binding mixes input/output ports under the
> -		 * same parent. So, skip the input ports if we are dealing
> -		 * with legacy binding, as they processed with their
> -		 * connected output ports.
> -		 */
> -		if (legacy_binding && of_coresight_legacy_ep_is_input(ep))
> -			continue;
> -
> -		ret = of_coresight_parse_endpoint(dev, ep, conn);
> -		switch (ret) {
> -		case 1:
> -			conn++;		/* Fall through */
> -		case 0:
> -			break;
> -		default:
> -			return ERR_PTR(ret);
> -		}
> -	}
> -
> -	return pdata;
> -}
> -EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
> -- 
> 2.7.4
> 
