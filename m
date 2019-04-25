Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE03EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A63A206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sueelB3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDYQuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:50:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41311 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfDYQuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:50:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so126188pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4iwsXPCC/VTnjHb7HgLK8oJKQkhil7ki/iuCFW1xXEA=;
        b=sueelB3NMdY+bgLk2gJfu5TZJ3zC6pDtFUAxELVKgyZR14OxzdALB5Xc7vzMPbGAHy
         EvwaO85FRry9CygJ751S9Z61NofNnzqIlGFUZr3C2XYMg3gox4Tiw64W1u2qgXWWQ1cA
         m6PYrjrbRDVipmoiwqVtx8UDr2U++Jcm+ipaCsuaBlFaeF9yH6XWMbzV5leRCZV8+CWN
         optBC09FD7rPjEkorGvOOkbRLPiMugcGdrCrWy92miGdtnPpgzc882FvL+LbT/XgyiqB
         mv2fe56zP3YoGzhaP7VOyb6HfJyJg6FL7hzpq+u8gGEdWzIeYGTT2uXHinDM6eAX1jte
         TCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4iwsXPCC/VTnjHb7HgLK8oJKQkhil7ki/iuCFW1xXEA=;
        b=cB8BWyDNrWqv78enWQuLx30FEpv3UH4+3dzLRCHo26CGuLB0kH+E0sVYIhaBceXaPs
         8tZRZfVFJaFQb86nigAupJcCWVTMIbI0Fny/Mwughuvwj5t/XAE+zf70LzZTWHthhQAy
         jPFWRgSKXe1L8tKY0hGgxbByMF/Q7q/hqN7O5LA0JCdl2sDNzVHA+98b7UVM5mvw4NRr
         Y+1t7mcUsucw6ygwM9/uLoczhkekd4HibAtd0l3XjECEVSABtzZQtG2yF3ZNKmFsY0Iw
         3VfbcnjnXViG8AUMreJnD0wgnAF51tGRZbykIAJxiMgahogdCUjHGujK2hUSpcDWgQS7
         AQag==
X-Gm-Message-State: APjAAAUKBxDTBsXvabHFuI2AG0oJPeUeeoXUKyOPg+5FSrs4ioyrtQM7
        CuEUCYcTScmDLH6erB3EdLA8PQ==
X-Google-Smtp-Source: APXvYqwUbWdnc9g4aMgTHTpFTuYANEejRUBEcynzv0xdsjOZtieJHX6uWdpdeylN895vN9CftNuaQg==
X-Received: by 2002:aa7:934d:: with SMTP id 13mr2185443pfn.207.1556211013559;
        Thu, 25 Apr 2019 09:50:13 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q33sm4287878pgl.38.2019.04.25.09.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 09:50:12 -0700 (PDT)
Date:   Thu, 25 Apr 2019 10:50:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 32/36] coresight: Support for ACPI bindings
Message-ID: <20190425165010.GA4080@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-33-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-33-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:15PM +0100, Suzuki K Poulose wrote:
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
>  drivers/hwtracing/coresight/coresight-platform.c | 409 +++++++++++++++++++++++
>  1 file changed, 409 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index c9a59fb..224f698 100644
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
> @@ -297,10 +298,414 @@ of_get_coresight_platform_data(struct device *dev,
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

Please mention what the 3 members must be to avoid having to go back to the
specs all the time.

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

Please add a comment to mention that a _DSD package consists of tuples, i.e a
UUID and a package to explain the += 2.

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

As you did in acpi_validate_dsd_graph(), please add the rational for the + 3.

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

In what kind of scenario nr_graphs would be more than 1?  From what I've seen in
DEN0067 and the implementation in patch 37 it shouldn't be the case.  As such I
would treat nr_graphs != 1 as an error.

I must admit I had a really hard time following the hard coded .element[]
throughout the code.  With time I was able to verify them all but it would
really help if the example of an ACPI device description was given at the
top of the file, just before the ACPI Graph UUID.  The following taken from
DEN0067 did the trick for me:

Device ( FUN1 ) { // Funnel 1 described in \SB scope
  Name (_HID , " ARMHC9FF ")
  Name (_CID , " ARMHC500 ")
  Name (_CRS , ResourceTemplate () {
  Memory32Fixed ( ReadWrite , 0 x208c0000 , 0 x1000 )
  })

  Name (_DSD , Package () {
    ToUUID (" ab02a46b -74 c7 -45a2 -bd68 - f7d344ef2153 ") ,
    Package () {
      0 , // Revision
      1 , // Number of graphs
      Package () {
        1 , // GraphID // CoreSight graphs UUID
        ToUUID ("3 ecbc8b6 -1 d0e -4 fb3 -8107 - e627f805c6cd ") ,
        3 , // Number of links
        Package () {0 , 0 , // output port 0 connected
             \_SB.RPL0 ,1} , // to input port 0 on RPL0 .
        Package () {0 , 0 , // input port 0 connected
             \_SB.ETF0 ,0} , // to output port 0 on ETF0 .
        Package () {1 , 0 , // input port 1 connected
             \_SB.ETF1 ,0} // to output port 0 on ETF1 .
        }
    }
  })

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
> +		/*
> +		 * Hold the refcount to the target device. This could be
> +		 * released via:
> +		 * 1) coresight_release_platform_data() if the probe fails or
> +		 *    this device is unregistered.
> +		 * 2) While removing the target device via
> +		 *    coresight_remove_match().
> +		 */
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
> + * acpi_handle_to_logical_cpuid - Map a given acpi_handle to the
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

As far as I can tell this function can't return < 0.  

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
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		goto out;
> +
> +	rc = acpi_coresight_parse_graph(adev, pdata);
> +	if (rc)
> +		goto out;

The goto statement is not needed here.

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

Function of_coresight_get_cpu() and of_get_coresight_platform_data() will also
need a stub if CONFIG_OF=n.

>  int coresight_get_cpu(struct device *dev)
>  {
>  	if (is_of_node(dev->fwnode))
>  		return of_coresight_get_cpu(dev);
> +	else if (is_acpi_device_node(dev->fwnode))
> +		return acpi_coresight_get_cpu(dev);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(coresight_get_cpu);
> @@ -320,6 +725,10 @@ coresight_get_platform_data(struct device *dev)
>  
>  	if (is_of_node(fwnode))
>  		ret = of_get_coresight_platform_data(dev, pdata);
> +	else if (is_acpi_device_node(fwnode))
> +		ret = acpi_get_coresight_platform_data(dev, pdata);
> +	else
> +		return ERR_PTR(-ENOENT);
>  
>  	if (!IS_ERR_OR_NULL(ret))
>  		return pdata;
> -- 
> 2.7.4
> 
