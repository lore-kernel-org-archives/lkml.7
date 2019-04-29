Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD8C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0791720656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QHusFS31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfD2JA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:00:26 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39180 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfD2JA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:00:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3T903GW088945;
        Mon, 29 Apr 2019 04:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556528404;
        bh=6AoMSEP6k0dB31rGEgSMYkvxlMJV2xJSnrQQRDzjTkg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QHusFS31q57Y1idKXPWuRPB3aAlPnoJ6+bqdgRkwp9l0rv6O9c4jqBlV85q7HRDyj
         vLWYrI7/yaTELtP7ZOi2HzAuXGXfn1Ki5cNYEvDS7aRbtXPMR4w8Y6R1Sxx1ntWnGV
         kGZzxdL54oGX44+iLcSQnOh0+5qIeqd8Cqz4t8/k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3T903xl065793
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Apr 2019 04:00:03 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 29
 Apr 2019 04:00:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 29 Apr 2019 04:00:03 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3T8xwEq020597;
        Mon, 29 Apr 2019 03:59:59 -0500
Subject: Re: [PATCH v7 11/14] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
References: <20190420100950.7997-1-lokeshvutla@ti.com>
 <20190420100950.7997-12-lokeshvutla@ti.com>
 <bb768bc0-e18b-3794-8083-1612da10b0c1@ti.com>
 <79b34c45-023b-2df4-26f4-e151e74a46ac@arm.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <7d012633-e540-df8f-7c21-07702447cb8a@ti.com>
Date:   Mon, 29 Apr 2019 14:29:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <79b34c45-023b-2df4-26f4-e151e74a46ac@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/04/19 2:17 PM, Marc Zyngier wrote:
> On 23/04/2019 11:00, Lokesh Vutla wrote:
>> Hi Marc,
> 
> [...]
> 
>>> +/**
>>> + * ti_sci_inta_set_type() - Update the trigger type of the irq.
>>> + * @data:	Pointer to corresponding irq_data
>>> + * @type:	Trigger type as specified by user
>>> + *
>>> + * Note: This updates the handle_irq callback for level msi.
>>> + *
>>> + * Return 0 if all went well else appropriate error.
>>> + */
>>> +static int ti_sci_inta_set_type(struct irq_data *data, unsigned int type)
>>> +{
>>> +	struct irq_desc *desc = irq_to_desc(data->irq);
>>> +
>>> +	/*
>>> +	 * .alloc default sets handle_edge_irq. But if the user specifies
>>> +	 * that IRQ is level MSI, then update the handle to handle_level_irq
>>> +	 */
>>> +	if (type & IRQF_TRIGGER_HIGH)
>>> +		desc->handle_irq = handle_level_irq;
>>> +
>>> +	return 0;
>>
>>
>> Returning error value is causing request_irq to fail, so still returning 0. Do
>> you suggest any other method to handle this?
> 
> But that is the very point, isn't it? If you pass the wrong triggering
> type to request_irq, it *must* fail. What you should have is something like:
> 
> switch (type & IRQ_TYPE_SENSE_MASK) {
> case IRQF_TRIGGER_HIGH:
> 	desc->handle_irq = handle_level_irq;
> 	return 0;
> case IRQ_TYPE_EDGE_RISING:
> 	return 0;
> default:
> 	return -EINVAL;
> }
> 
> (adjust as necessary).
> 
> What's wrong with this?

I get it. Will fix it in next version. I also got the firmware update as well.
If you are okay with rest of the series, I want to post the next version with
the firmware update.

Thanks and regards,
Lokesh
