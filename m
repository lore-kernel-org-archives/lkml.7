Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566702184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDAr9VMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfC2TJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:09:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42731 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfC2TJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:09:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so1476298pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J0HZ0OXlCGQ6D4eV/2OGqBZV6OftD6KDOi2P0Wgd8WM=;
        b=FDAr9VMGfFGM89hYw8G6mhV8DaKY8ZoQWHewWmnmyvzWfzf4GWOwD8tQSMeDY0HHHs
         I7GAhr0GGPzROL2mglkMVgWIOSs2UNSSCZwx0AcCuoH9iJ0WUBTxZQKNPGGKOB5sfCba
         p+i2c1PmuD3DnAZTEi34fHWXgIw2RKS87aJlO3y6NVGDBnSYOv0zIm62GJSvXi62AoZr
         7/+r/ZU0tvnVY/H/nXC4eoy2jvkz32kCR4bO04ONriKabzybCNa2qGpB2/TIq1YQFY1K
         /TNvNx+9cNZl8ADd7djiI7Te/vsQ0AJ7TtuEz02Y2srt/SegyeyCyhOEzBcC/DSqSXnu
         QS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J0HZ0OXlCGQ6D4eV/2OGqBZV6OftD6KDOi2P0Wgd8WM=;
        b=LJ/qNRPg3LOQU70wh2fXjjFdozP72aJ2SrAHkQDrKr3foTL1dicMgOdrUKVOtmVTXM
         8uviIoAv3COpALfL3Y2ALZDFvBvrRC2KIaaMTOolFqt6xu4BrCcDc448dWYIGtO6Bn5H
         Njb/WP/yyjE7kFGGpxS2r8axr62yaFhFugrkmyCtO3aKRyRsSy5eZK0fxDflAEk6Ydkx
         ftdoJXiSqpCBOHhvkrOW1uI2zTXGxENrwzeKMdknFcdjXi5ChJANwNEO/+zhy4mHjjEJ
         FETzCpurZBWrA/54zKpINw0onCdtulY4swQFGXdasE95nhJOSWZPZn3tf9/dLOJAckfk
         Nxuw==
X-Gm-Message-State: APjAAAVZSTi+x10Fttyw5veqir80VkE4D31lPgTsYkhbiTw/HOLLVme4
        RXhCR1+6S0hxzPRvFqKQKrpR1A==
X-Google-Smtp-Source: APXvYqxTcfxUpgWf1IUhwuXg/M/XFRqkahIPGVBDTJI7mtXXlsx+YycqzrLlgGrc7Ba57FR079M0Sw==
X-Received: by 2002:aa7:8458:: with SMTP id r24mr14998159pfn.231.1553886594267;
        Fri, 29 Mar 2019 12:09:54 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w3sm5662825pfn.179.2019.03.29.12.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 12:09:53 -0700 (PDT)
Date:   Fri, 29 Mar 2019 13:09:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 24/25] coresight: Support for ACPI bindings
Message-ID: <20190329190951.GB7163@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-25-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553107783-3340-25-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:41PM +0000, Suzuki K Poulose wrote:
> Add support for parsing the ACPI platform description
> for CoreSight. The connections are encoded in a DSD graph
> property with CoreSight specific variation of the property.
> 
> The ETMs are listed as the children device of the respective
> CPU.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 402 +++++++++++++++++++++++
>  1 file changed, 402 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 5eee987..06b1188 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2012, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> @@ -289,10 +290,409 @@ of_get_coresight_platform_data(struct device *dev,
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +
> +#include <acpi/actypes.h>
> +#include <acpi/processor.h>
> +
> +/* ACPI Graph _DSD UUID : "ab02a46b-74c7-45a2-bd68-f7d344ef2153" */
> +static const guid_t acpi_graph_uuid = GUID_INIT(0xab02a46b, 0x74c7, 0x45a2,
> +						0xbd, 0x68, 0xf7, 0xd3,
> +						0x44, 0xef, 0x21, 0x53);
> +/* Coresight ACPI Graph UUID : "3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd" */
> +static const guid_t coresight_graph_uuid = GUID_INIT(0x3ecbc8b6, 0x1d0e, 0x4fb3,
> +						     0x81, 0x07, 0xe6, 0x27,
> +						     0xf8, 0x05, 0xc6, 0xcd);
> +#define ACPI_CORESIGHT_LINK_SLAVE	0
> +#define ACPI_CORESIGHT_LINK_MASTER	1
> +
> +static inline bool is_acpi_guid(const union acpi_object *obj)
> +{
> +	return (obj->type == ACPI_TYPE_BUFFER) && (obj->buffer.length == 16);
> +}
> +
> +/*
> + * acpi_guid_matches	- Checks if the given object is a GUID object and
> + * that it matches the supplied the GUID.
> + */
> +static inline bool acpi_guid_matches(const union acpi_object *obj,
> +				   const guid_t *guid)
> +{
> +	return is_acpi_guid(obj) &&
> +	       guid_equal((guid_t *)obj->buffer.pointer, guid);
> +}
> +
> +static inline bool is_acpi_dsd_graph_guid(const union acpi_object *obj)
> +{
> +	return acpi_guid_matches(obj, &acpi_graph_uuid);
> +}
> +
> +static inline bool is_acpi_coresight_graph_guid(const union acpi_object *obj)
> +{
> +	return acpi_guid_matches(obj, &coresight_graph_uuid);
> +}
> +
> +static inline bool is_acpi_coresight_graph(const union acpi_object *obj)
> +{
> +	const union acpi_object *graphid, *guid, *links;
> +
> +	if (obj->type != ACPI_TYPE_PACKAGE ||
> +	    obj->package.count < 3)
> +		return false;
> +
> +	graphid = &obj->package.elements[0];
> +	guid = &obj->package.elements[1];
> +	links = &obj->package.elements[2];
> +
> +	if (graphid->type != ACPI_TYPE_INTEGER ||
> +	    links->type != ACPI_TYPE_INTEGER)
> +		return false;
> +
> +	return is_acpi_coresight_graph_guid(guid);
> +}
> +
> +/*
> + * acpi_validate_dsd_graph	- Make sure the given _DSD graph conforms
> + * to the ACPI _DSD Graph specification.
> + *
> + * ACPI Devices Graph property has the following format:
> + *	Revision	- Integer, must be 0
> + *	NumberOfGraphs	- Integer, N indicating the following list.
> + *	Graph[1],
> + *	 ...
> + *	Graph[N]
> + *
> + * And each Graph entry has the following format:
> + *	GraphID		- Integer, identifying a graph the device belongs to.
> + *	UUID		- UUID identifying the specification that governs
> + *			  this graph. (e.g, see is_acpi_coresight_graph())
> + *	NumberOfLinks	- Number "N" of connections on this node of the graph.
> + *	Links[1]
> + *	...
> + *	Links[N]
> + */
> +static inline bool acpi_validate_dsd_graph(const union acpi_object *graph)
> +{
> +	int i, n;
> +	const union acpi_object *rev, *nr_graphs;
> +
> +	/* The graph must contain at least the Revision and Number of Graphs */
> +	if (graph->package.count < 2)
> +		return false;
> +
> +	rev = &graph->package.elements[0];
> +	nr_graphs = &graph->package.elements[1];
> +
> +	if (rev->type != ACPI_TYPE_INTEGER ||
> +	    nr_graphs->type != ACPI_TYPE_INTEGER)
> +		return false;
> +
> +	/* We only support revision 0 */
> +	if (rev->integer.value != 0)
> +		return false;
> +
> +	n = nr_graphs->integer.value;
> +	/* Make sure the package has right number of elements */
> +	if (graph->package.count != (n + 2))
> +		return false;
> +
> +	/* Each entry must be a graph package with at least 3 members */
> +	for (i = 2; i < n + 2; i++) {
> +		const union acpi_object *obj = &graph->package.elements[i];
> +
> +		if (obj->type != ACPI_TYPE_PACKAGE ||
> +		    obj->package.count < 3)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* acpi_get_dsd_graph	- Find the _DSD Graph property for the given device. */
> +const union acpi_object *
> +acpi_get_dsd_graph(struct acpi_device *adev)
> +{
> +	int i;
> +	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
> +	acpi_status status;
> +	const union acpi_object *dsd;
> +
> +	status = acpi_evaluate_object_typed(adev->handle, "_DSD", NULL,
> +					    &buf, ACPI_TYPE_PACKAGE);
> +	if (ACPI_FAILURE(status))
> +		return NULL;
> +
> +	dsd = buf.pointer;
> +	for (i = 0; i + 1 < dsd->package.count; i += 2) {
> +		const union acpi_object *guid, *package;
> +
> +		guid = &dsd->package.elements[i];
> +		package = &dsd->package.elements[i + 1];
> +
> +		/* All _DSD elements must have a UUID and a Package */
> +		if (!is_acpi_guid(guid) || package->type != ACPI_TYPE_PACKAGE)
> +			break;
> +		/* Skip the non-Graph _DSD packages */
> +		if (!is_acpi_dsd_graph_guid(guid))
> +			continue;
> +		if (acpi_validate_dsd_graph(package))
> +			return package;
> +		/* Invalid graph format, continue */
> +		dev_warn(&adev->dev, "Invalid Graph _DSD property\n");
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline bool
> +acpi_validate_coresight_graph(const union acpi_object *cs_graph)
> +{
> +	int nlinks;
> +
> +	nlinks = cs_graph->package.elements[2].integer.value;
> +	if (cs_graph->package.count != (nlinks + 3))
> +		return false;
> +	/* The links are validated in acpi_coresight_parse_link() */
> +	return true;
> +}
> +
> +/*
> + * acpi_get_coresight_graph	- Parse the device _DSD tables and find
> + * the Graph property matching the CoreSight Graphs.
> + *
> + * Returns the pointer to the CoreSight Graph Package when found. Otherwise
> + * returns NULL.
> + */
> +const union acpi_object *
> +acpi_get_coresight_graph(struct acpi_device *adev)
> +{
> +	const union acpi_object *graph_list, *graph;
> +	int i, nr_graphs;
> +
> +	graph_list = acpi_get_dsd_graph(adev);
> +	if (!graph_list)
> +		return graph_list;
> +
> +	nr_graphs = graph_list->package.elements[1].integer.value;
> +
> +	for (i = 2; i < nr_graphs + 2; i++) {
> +		graph = &graph_list->package.elements[i];
> +		if (!is_acpi_coresight_graph(graph))
> +			continue;
> +		if (acpi_validate_coresight_graph(graph))
> +			return graph;
> +		/* Invalid graph format */
> +		break;
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * acpi_coresight_parse_link	- Parse the given Graph connection
> + * of the device and populate the coresight_connection for an output
> + * connection.
> + *
> + * CoreSight Graph specification mandates that the direction of the data
> + * flow must be specified in the link. i.e,
> + *
> + *	SourcePortAddress,	// Integer
> + *	DestinationPortAddress,	// Integer
> + *	DestinationDeviceName,	// Reference to another device
> + *	DirectionOfFlow,	// 1 for output(master), 0 for input(slave)
> + *
> + * Returns the direction of the data flow [ Input(slave) or Output(master) ]
> + * upon success.
> + * Returns an negative error number otherwise.
> + */
> +static int acpi_coresight_parse_link(struct acpi_device *adev,
> +				     const union acpi_object *link,
> +				     struct coresight_connection *conn)
> +{
> +	int rc, dir;
> +	const union acpi_object *fields;
> +	struct acpi_device *r_adev;
> +	struct device *rdev;
> +
> +	if (link->type != ACPI_TYPE_PACKAGE ||
> +	    link->package.count != 4)
> +		return -EINVAL;
> +
> +	fields = link->package.elements;
> +
> +	if (fields[0].type != ACPI_TYPE_INTEGER ||
> +	    fields[1].type != ACPI_TYPE_INTEGER ||
> +	    fields[2].type != ACPI_TYPE_LOCAL_REFERENCE ||
> +	    fields[3].type != ACPI_TYPE_INTEGER)
> +		return -EINVAL;
> +
> +	rc = acpi_bus_get_device(fields[2].reference.handle, &r_adev);
> +	if (rc)
> +		return rc;
> +
> +	dir = fields[3].integer.value;
> +	if (dir == ACPI_CORESIGHT_LINK_MASTER) {
> +		conn->outport = fields[0].integer.value;
> +		conn->child_port = fields[1].integer.value;
> +		rdev = coresight_find_device_by_fwnode(&r_adev->fwnode);
> +		if (!rdev)
> +			return -EPROBE_DEFER;
> +		conn->child_fwnode = fwnode_handle_get(&r_adev->fwnode);
> +	}
> +
> +	return dir;
> +}
> +
> +/*
> + * acpi_coresight_parse_graph	- Parse the _DSD CoreSight graph
> + * connection information and populate the supplied coresight_platform_data
> + * instance.
> + */
> +static int acpi_coresight_parse_graph(struct acpi_device *adev,
> +				      struct coresight_platform_data *pdata)
> +{
> +	int rc, i, nlinks;
> +	const union acpi_object *graph;
> +	struct coresight_connection *conns, *ptr;
> +
> +	pdata->nr_inport = pdata->nr_outport = 0;
> +	graph = acpi_get_coresight_graph(adev);
> +	if (!graph)
> +		return -ENOENT;
> +
> +	nlinks = graph->package.elements[2].integer.value;
> +	if (!nlinks)
> +		return 0;
> +
> +	/*
> +	 * To avoid scanning the table twice (once for finding the number of
> +	 * output links and then later for parsing the output links),
> +	 * cache the links information in one go and then later copy
> +	 * it to the pdata.
> +	 */
> +	conns = devm_kcalloc(&adev->dev, nlinks, sizeof(*conns), GFP_KERNEL);
> +	if (!conns)
> +		return -ENOMEM;
> +	ptr = conns;
> +	for (i = 0; i < nlinks; i++) {
> +		const union acpi_object *link = &graph->package.elements[3 + i];
> +		int dir;
> +
> +		dir = acpi_coresight_parse_link(adev, link, ptr);
> +		if (dir < 0)
> +			return dir;
> +
> +		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
> +			pdata->nr_outport++;
> +			ptr++;
> +		} else {
> +			pdata->nr_inport++;
> +		}
> +	}
> +
> +	rc = coresight_alloc_conns(&adev->dev, pdata);
> +	if (rc)
> +		return rc;
> +
> +	/* Copy the connection information to the final location */
> +	for (i = 0; i < pdata->nr_outport; i++)
> +		pdata->conns[i] = conns[i];
> +
> +	devm_kfree(&adev->dev, conns);
> +	return 0;
> +}
> +
> +/*
> + * acpi_handle_to_logical_cpuid	- Map a given acpi_handle to the

This looks a little weird... I think all tabs should be drop in the comments.

> + * logical CPU id of the corresponding CPU device.
> + *
> + * Returns the logical CPU id when found. Otherwise returns >= nr_cpus_id.
> + */
> +static int
> +acpi_handle_to_logical_cpuid(acpi_handle handle)
> +{
> +	int i;
> +	struct acpi_processor *pr;
> +
> +	for_each_possible_cpu(i) {
> +		pr = per_cpu(processors, i);
> +		if (pr && pr->handle == handle)
> +			break;
> +	}
> +
> +	return i;
> +}
> +
> +/*
> + * acpi_coresigh_get_cpu - Find the logical CPU id of the CPU associated
> + * with this coresight device. With ACPI bindings, the CoreSight components
> + * are listed as child device of the associated CPU.
> + *
> + * Returns the logical CPU id when found. Otherwise returns < 0.
> + */
> +static int acpi_coresight_get_cpu(struct device *dev)
> +{
> +	int cpu;
> +	acpi_handle cpu_handle;
> +	acpi_status status;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!adev)
> +		return 0;
> +	status = acpi_get_parent(adev->handle, &cpu_handle);
> +	if (ACPI_FAILURE(status))
> +		return 0;
> +
> +	cpu = acpi_handle_to_logical_cpuid(cpu_handle);
> +	if (cpu >= nr_cpu_ids)
> +		return 0;
> +	return cpu;
> +}
> +
> +static struct coresight_platform_data *
> +acpi_get_coresight_platform_data(struct device *dev,
> +				 struct coresight_platform_data *pdata)
> +{
> +	int rc = -EINVAL;
> +	struct acpi_device *adev;
> +
> +	if (!dev)
> +		goto out;

If we are here dev is valid.  Otherwise things would have blown up in
coresight_get_platform_data() when calling is_acpi_device_node().

> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		goto out;
> +
> +	rc = acpi_coresight_parse_graph(adev, pdata);
> +	if (rc)
> +		goto out;
> +out:
> +	if (rc)
> +		return ERR_PTR(rc);
> +	return pdata;
> +}
> +
> +#else
> +
> +static inline struct coresight_platform_data *
> +acpi_get_coresight_platform_data(struct device *dev,
> +				 struct coresight_platform_data *pdata)
> +{
> +	return NULL;
> +}
> +
> +static inline int acpi_coresight_get_cpu(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  int coresight_get_cpu(struct device *dev)
>  {
>  	if (is_of_node(dev->fwnode))
>  		return of_coresight_get_cpu(dev);
> +	else if (is_acpi_device_node(dev->fwnode))
> +		return acpi_coresight_get_cpu(dev);
>  	return 0;

If we failed both of and acpi discovery method I'd return an error.

I've only reviewed the bottom half of this patch but I'm out of time for today.
I will continue next week.

Thanks,
Mathieu

>  }
>  EXPORT_SYMBOL_GPL(coresight_get_cpu);
> @@ -315,6 +715,8 @@ coresight_get_platform_data(struct device *dev)
>  
>  	if (is_of_node(dev->fwnode))
>  		return of_get_coresight_platform_data(dev, pdata);
> +	else if (is_acpi_device_node(dev->fwnode))
> +		return acpi_get_coresight_platform_data(dev, pdata);
>  
>  	return ERR_PTR(-ENOENT);
>  }
> -- 
> 2.7.4
> 
