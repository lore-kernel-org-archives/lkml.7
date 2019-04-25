Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8182084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfDYRaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:30:09 -0400
Received: from foss.arm.com ([217.140.101.70]:49158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbfDYRaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:30:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93CD280D;
        Thu, 25 Apr 2019 10:30:08 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A95A3F246;
        Thu, 25 Apr 2019 10:30:06 -0700 (PDT)
Subject: Re: [PATCH v2 32/36] coresight: Support for ACPI bindings
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-33-git-send-email-suzuki.poulose@arm.com>
 <20190425165010.GA4080@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6e3c92e9-2a9f-353d-67ab-612434dab676@arm.com>
Date:   Thu, 25 Apr 2019 18:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425165010.GA4080@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2019 17:50, Mathieu Poirier wrote:
> On Mon, Apr 15, 2019 at 05:04:15PM +0100, Suzuki K Poulose wrote:
>> Add support for parsing the ACPI platform description
>> for CoreSight. The connections are encoded in a DSD graph
>> property with CoreSight specific variation of the property.
>>
>> The ETMs are listed as the children device of the respective
>> CPU.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

...

>> +/*
>> + * acpi_validate_dsd_graph	- Make sure the given _DSD graph conforms
>> + * to the ACPI _DSD Graph specification.
>> + *
>> + * ACPI Devices Graph property has the following format:
>> + *	Revision	- Integer, must be 0
>> + *	NumberOfGraphs	- Integer, N indicating the following list.
>> + *	Graph[1],
>> + *	 ...
>> + *	Graph[N]
>> + *
>> + * And each Graph entry has the following format:
>> + *	GraphID		- Integer, identifying a graph the device belongs to.
>> + *	UUID		- UUID identifying the specification that governs
>> + *			  this graph. (e.g, see is_acpi_coresight_graph())
>> + *	NumberOfLinks	- Number "N" of connections on this node of the graph.
>> + *	Links[1]
>> + *	...
>> + *	Links[N]
>> + */
>> +static inline bool acpi_validate_dsd_graph(const union acpi_object *graph)
>> +{
>> +	int i, n;
>> +	const union acpi_object *rev, *nr_graphs;
>> +
>> +	/* The graph must contain at least the Revision and Number of Graphs */
>> +	if (graph->package.count < 2)
>> +		return false;
>> +
>> +	rev = &graph->package.elements[0];
>> +	nr_graphs = &graph->package.elements[1];
>> +
>> +	if (rev->type != ACPI_TYPE_INTEGER ||
>> +	    nr_graphs->type != ACPI_TYPE_INTEGER)
>> +		return false;
>> +
>> +	/* We only support revision 0 */
>> +	if (rev->integer.value != 0)
>> +		return false;
>> +
>> +	n = nr_graphs->integer.value;
>> +	/* Make sure the package has right number of elements */
>> +	if (graph->package.count != (n + 2))
>> +		return false;
>> +
>> +	/* Each entry must be a graph package with at least 3 members */
> 
> Please mention what the 3 members must be to avoid having to go back to the
> specs all the time.

Actually this is explained in the comment above. Graph entry contains :
GraphID, UUID and number of links. I could add make it explicit here,
just like I did it for the "Revision and Number of Graphs" above.

> 
>> +	for (i = 2; i < n + 2; i++) {
>> +		const union acpi_object *obj = &graph->package.elements[i];
>> +
>> +		if (obj->type != ACPI_TYPE_PACKAGE ||
>> +		    obj->package.count < 3)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}


>> +
>> +/* acpi_get_dsd_graph	- Find the _DSD Graph property for the given device. */
>> +const union acpi_object *
>> +acpi_get_dsd_graph(struct acpi_device *adev)
>> +{
>> +	int i;
>> +	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
>> +	acpi_status status;
>> +	const union acpi_object *dsd;
>> +
>> +	status = acpi_evaluate_object_typed(adev->handle, "_DSD", NULL,
>> +					    &buf, ACPI_TYPE_PACKAGE);
>> +	if (ACPI_FAILURE(status))
>> +		return NULL;
>> +
>> +	dsd = buf.pointer;
> 
> Please add a comment to mention that a _DSD package consists of tuples, i.e a
> UUID and a package to explain the += 2.
> 

Sure, it took me a while to figure that out myself.

>> +static inline bool
>> +acpi_validate_coresight_graph(const union acpi_object *cs_graph)
>> +{
>> +	int nlinks;
>> +
>> +	nlinks = cs_graph->package.elements[2].integer.value;
> 
> As you did in acpi_validate_dsd_graph(), please add the rational for the + 3.

Sure.

>> +	if (cs_graph->package.count != (nlinks + 3))
>> +		return false;
>> +	/* The links are validated in acpi_coresight_parse_link() */
>> +	return true;
>> +}
>> +
>> +/*
>> + * acpi_get_coresight_graph	- Parse the device _DSD tables and find
>> + * the Graph property matching the CoreSight Graphs.
>> + *
>> + * Returns the pointer to the CoreSight Graph Package when found. Otherwise
>> + * returns NULL.
>> + */
>> +const union acpi_object *
>> +acpi_get_coresight_graph(struct acpi_device *adev)
>> +{
>> +	const union acpi_object *graph_list, *graph;
>> +	int i, nr_graphs;
>> +
>> +	graph_list = acpi_get_dsd_graph(adev);
>> +	if (!graph_list)
>> +		return graph_list;
>> +
>> +	nr_graphs = graph_list->package.elements[1].integer.value;
> 
> In what kind of scenario nr_graphs would be more than 1?  From what I've seen in
> DEN0067 and the implementation in patch 37 it shouldn't be the case.  As such I
> would treat nr_graphs != 1 as an error.

The device could be part of multiple graphs theoretically. However, for
CoreSight we have only one graph, which shows the ATB connections. I could
enforce that here.


> 
> I must admit I had a really hard time following the hard coded .element[]
> throughout the code.  With time I was able to verify them all but it would
> really help if the example of an ACPI device description was given at the
> top of the file, just before the ACPI Graph UUID.  The following taken from
> DEN0067 did the trick for me:

I understand the pain. It is indeed a bit tricky. I will add an example graph
property.

> 
> Device ( FUN1 ) { // Funnel 1 described in \SB scope
>    Name (_HID , " ARMHC9FF ")
>    Name (_CID , " ARMHC500 ")
>    Name (_CRS , ResourceTemplate () {
>    Memory32Fixed ( ReadWrite , 0 x208c0000 , 0 x1000 )
>    })
> 
>    Name (_DSD , Package () {
>      ToUUID (" ab02a46b -74 c7 -45a2 -bd68 - f7d344ef2153 ") ,
>      Package () {
>        0 , // Revision
>        1 , // Number of graphs
>        Package () {
>          1 , // GraphID // CoreSight graphs UUID
>          ToUUID ("3 ecbc8b6 -1 d0e -4 fb3 -8107 - e627f805c6cd ") ,
>          3 , // Number of links
>          Package () {0 , 0 , // output port 0 connected
>               \_SB.RPL0 ,1} , // to input port 0 on RPL0 .
>          Package () {0 , 0 , // input port 0 connected
>               \_SB.ETF0 ,0} , // to output port 0 on ETF0 .
>          Package () {1 , 0 , // input port 1 connected
>               \_SB.ETF1 ,0} // to output port 0 on ETF1 .
>          }
>      }
>    })
> 

...

>> +/*
>> + * acpi_coresigh_get_cpu - Find the logical CPU id of the CPU associated
>> + * with this coresight device. With ACPI bindings, the CoreSight components
>> + * are listed as child device of the associated CPU.
>> + *
>> + * Returns the logical CPU id when found. Otherwise returns < 0.
> 
> As far as I can tell this function can't return < 0.
> 

You're right. I will fix the comment.

>> +static struct coresight_platform_data *
>> +acpi_get_coresight_platform_data(struct device *dev,
>> +				 struct coresight_platform_data *pdata)
>> +{
>> +	int rc = -EINVAL;
>> +	struct acpi_device *adev;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		goto out;
>> +
>> +	rc = acpi_coresight_parse_graph(adev, pdata);
>> +	if (rc)
>> +		goto out;
> 
> The goto statement is not needed here.
> 

OK

>> +out:
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +	return pdata;
>> +}
>> +
>> +#else
>> +
>> +static inline struct coresight_platform_data *
>> +acpi_get_coresight_platform_data(struct device *dev,
>> +				 struct coresight_platform_data *pdata)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline int acpi_coresight_get_cpu(struct device *dev)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
> 
> Function of_coresight_get_cpu() and of_get_coresight_platform_data() will also
> need a stub if CONFIG_OF=n.
>

Yep, agreed.

Thank you so much for the review !
Suzuki
