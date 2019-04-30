Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98281C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638412147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JknLuSco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfD3GCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:02:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33354 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3GCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:02:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3U61j2f112083;
        Tue, 30 Apr 2019 01:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556604105;
        bh=h3OKh0wANVTGMFN5PFdzxOS0UbeQzuBh9Z/vJt4Q8OE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JknLuScocmlMZa3NftVvv+fcaflDJhWeGQKYtmLQkknkgNfY1p3ALmeb+JeWw3xqt
         ype2/yFjp3zQIdC4jBpk2pXnYw51V3AG7ACtNp0kK8muyCFnL7KEWSS94iMMJ56t65
         osbvDVC25229nsTRoxG9+OV7VVo+rmuHBtI8ia8g=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3U61j13070786
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 01:01:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 01:01:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 01:01:45 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3U61dx9006088;
        Tue, 30 Apr 2019 01:01:41 -0500
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
 <36b8bc62-fff2-c015-8140-cda625efdabc@arm.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <a0f2a359-7139-18b3-6cb7-3e6445705bbd@ti.com>
Date:   Tue, 30 Apr 2019 11:31:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <36b8bc62-fff2-c015-8140-cda625efdabc@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/04/19 6:41 PM, Marc Zyngier wrote:
> On 20/04/2019 11:09, Lokesh Vutla wrote:
>> Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
>> which is an interrupt controller that does the following:
>> - Converts events to interrupts that can be understood by
>>   an interrupt router.
>> - Allows for multiplexing of events to interrupts.
>>
>> Configuration of the interrupt aggregator registers can only be done by
>> a system co-processor and the driver needs to send a message to this
>> co processor over TISCI protocol. This patch adds support for Interrupt
>> Aggregator irqdomain.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> Changes since v6:
>> - Updated commit message.
>> - Arranged header files in alphabetical order
>> - Included vint_bit in struct ti_sci_inta_event_desc
>> - With the above change now the chip_data is event_desc instead of vint_desc
>> - No loops are used in atomic contexts.
>> - Fixed locking issue while freeing parent virq
>> - Fixed few other cosmetic changes.
>>
>>  MAINTAINERS                       |   1 +
>>  drivers/irqchip/Kconfig           |  11 +
>>  drivers/irqchip/Makefile          |   1 +
>>  drivers/irqchip/irq-ti-sci-inta.c | 589 ++++++++++++++++++++++++++++++
>>  4 files changed, 602 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
>>
> 
> [...]
> 
>> +/**
>> + * ti_sci_inta_alloc_irq() -  Allocate an irq within INTA domain
>> + * @domain:	irq_domain pointer corresponding to INTA
>> + * @hwirq:	hwirq of the input event
>> + *
>> + * Note: Allocation happens in the following manner:
>> + *	- Find a free bit available in any of the vints available in the list.
>> + *	- If not found, allocate a vint from the vint pool
>> + *	- Attach the free bit to input hwirq.
>> + * Return event_desc if all went ok else appropriate error value.
>> + */
>> +static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_irq(struct irq_domain *domain,
>> +							    u32 hwirq)
>> +{
>> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
>> +	struct ti_sci_inta_vint_desc *vint_desc = NULL;
>> +	u16 free_bit;
>> +
>> +	mutex_lock(&inta->vint_mutex);
>> +	list_for_each_entry(vint_desc, &inta->vint_list, list) {
>> +		mutex_lock(&vint_desc->event_mutex);
>> +		free_bit = find_first_zero_bit(vint_desc->event_map,
>> +					       MAX_EVENTS_PER_VINT);
>> +		if (free_bit != MAX_EVENTS_PER_VINT) {
>> +			set_bit(free_bit, vint_desc->event_map);
>> +			mutex_unlock(&vint_desc->event_mutex);
>> +			mutex_unlock(&inta->vint_mutex);
>> +			goto alloc_event;
>> +		}
>> +		mutex_unlock(&vint_desc->event_mutex);
>> +	}
>> +	mutex_unlock(&inta->vint_mutex);
>> +
>> +	/* No free bits available. Allocate a new vint */
>> +	vint_desc = ti_sci_inta_alloc_parent_irq(domain);
>> +	if (IS_ERR(vint_desc))
>> +		return ERR_PTR(PTR_ERR(vint_desc));
>> +
>> +	mutex_lock(&vint_desc->event_mutex);
>> +	free_bit = find_first_zero_bit(vint_desc->event_map,
>> +				       MAX_EVENTS_PER_VINT);
>> +	set_bit(free_bit, vint_desc->event_map);
>> +	mutex_unlock(&vint_desc->event_mutex);
> 
> This code is still quite racy: you can have two parallel allocations
> failing to get a free bit in any of the already allocated vint_desc, and
> then both allocating a new vint_desc. If there was only one left, one of
> the allocation will fail despite having at least 63 free interrupts.

Good point. After thinking a bit more, I saw similar issue when two parallel
frees happens on a vint with only 2 bits allocated. First free when freeing
parent_irq might see all the bits cleared and does kfree(vint). Then second free
will crash when freeing parent irq.

Ill guard the entire allocation and freeing with vint_mutex and drop the
event_mutex altogether.

Thanks and regards,
Lokesh

> 
> 	M.
> 
