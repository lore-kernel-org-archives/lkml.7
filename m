Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D655C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7324D2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fAPuyBKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKHiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:38:22 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51522 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfKKHiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:38:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAB7bxs9019718;
        Mon, 11 Nov 2019 01:37:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573457879;
        bh=9D1qH61QLDyxQW4aYPv6eSClSjnsnxJWzJVKKh7GxIo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fAPuyBKrrQXFB8WnFArOtRnMtSytXCCciyPVf/agF9dBQdnzlZhrRhLrpBzklKS7M
         9GC9nJ5IXfhYxvKUJECYSL7Fv6Ytt/o4XSd4VfNJ8Y4OO9GyFjHt45ZMEyOygUBYQS
         XORkAdBd0rhCCie0hb4ElJ7J/Kdpv4gtP92XqA6c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB7bxaF015948;
        Mon, 11 Nov 2019 01:37:59 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 01:37:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 01:37:42 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB7btm1005431;
        Mon, 11 Nov 2019 01:37:55 -0600
Subject: Re: [PATCH v4 02/15] soc: ti: k3: add navss ringacc driver
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-3-peter.ujfalusi@ti.com>
 <20191111042119.GK952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f24947f4-53d0-bdb8-fc29-7a985aba2052@ti.com>
Date:   Mon, 11 Nov 2019 09:39:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111042119.GK952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2019 6.21, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
>> +config TI_K3_RINGACC
>> +	tristate "K3 Ring accelerator Sub System"
>> +	depends on ARCH_K3 || COMPILE_TEST
>> +	depends on TI_SCI_INTA_IRQCHIP
>> +	default y
> 
> You want to get an earful from Linus? We dont do default y on new stuff,
> never :)

OK

>> +struct k3_ring_rt_regs {
>> +	u32	resv_16[4];
>> +	u32	db;		/* RT Ring N Doorbell Register */
>> +	u32	resv_4[1];
>> +	u32	occ;		/* RT Ring N Occupancy Register */
>> +	u32	indx;		/* RT Ring N Current Index Register */
>> +	u32	hwocc;		/* RT Ring N Hardware Occupancy Register */
>> +	u32	hwindx;		/* RT Ring N Current Index Register */
> 
> nice comments, how about moving them up into kernel-doc style? (here and
> other places as well)

Sure, I'll convert the comments.

>> +struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>> +					int id, u32 flags)
>> +{
>> +	int proxy_id = K3_RINGACC_PROXY_NOT_USED;
>> +
>> +	mutex_lock(&ringacc->req_lock);
>> +
>> +	if (id == K3_RINGACC_RING_ID_ANY) {
>> +		/* Request for any general purpose ring */
>> +		struct ti_sci_resource_desc *gp_rings =
>> +						&ringacc->rm_gp_range->desc[0];
>> +		unsigned long size;
>> +
>> +		size = gp_rings->start + gp_rings->num;
>> +		id = find_next_zero_bit(ringacc->rings_inuse, size,
>> +					gp_rings->start);
>> +		if (id == size)
>> +			goto error;
>> +	} else if (id < 0) {
>> +		goto error;
>> +	}
>> +
>> +	if (test_bit(id, ringacc->rings_inuse) &&
>> +	    !(ringacc->rings[id].flags & K3_RING_FLAG_SHARED))
>> +		goto error;
>> +	else if (ringacc->rings[id].flags & K3_RING_FLAG_SHARED)
>> +		goto out;
>> +
>> +	if (flags & K3_RINGACC_RING_USE_PROXY) {
>> +		proxy_id = find_next_zero_bit(ringacc->proxy_inuse,
>> +					      ringacc->num_proxies, 0);
>> +		if (proxy_id == ringacc->num_proxies)
>> +			goto error;
>> +	}
>> +
>> +	if (!try_module_get(ringacc->dev->driver->owner))
>> +		goto error;
> 
> should this not be one of the first things to do?

I'll move it.

> 
>> +
>> +	if (proxy_id != K3_RINGACC_PROXY_NOT_USED) {
>> +		set_bit(proxy_id, ringacc->proxy_inuse);
>> +		ringacc->rings[id].proxy_id = proxy_id;
>> +		dev_dbg(ringacc->dev, "Giving ring#%d proxy#%d\n", id,
>> +			proxy_id);
>> +	} else {
>> +		dev_dbg(ringacc->dev, "Giving ring#%d\n", id);
>> +	}
> 
> how bout removing else and doing common print?

When the proxy is used we want to print that as well, I think it is
cleaner to have separate prints for the two cases.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
