Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD403C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3F7206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="orgRZOCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfFEOih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:38:37 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:52063 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFEOih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559745516; x=1591281516;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sn9ZrZI5Aau7XgusfWoyz0sENtq4VCzkHC1GHyk4z3U=;
  b=orgRZOCpgH3sNwVqSrFhxbRXYUg0WOkFqwTzY1eNY+2hgXMW/d0GHfs6
   6ZURx5M9SAyaHFEseHqA9u/BAHV1fgfuXvqEzvJANBxReLhgng3GZ//5Z
   XkZXkv68fDqhJHW/hQI6EShAL2igQ/V/VMIkTMLBL8XoYFpLNU8S+bQBj
   A=;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="808751026"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 Jun 2019 14:38:31 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 575DEA22B3;
        Wed,  5 Jun 2019 14:38:28 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 14:38:27 +0000
Received: from [10.125.238.52] (10.43.162.57) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 5 Jun
 2019 14:38:18 +0000
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna Labs
 Fabric Interrupt Controller Driver
To:     Marc Zyngier <marc.zyngier@arm.com>, <nicolas.ferre@microchip.com>,
        <jason@lakedaemon.net>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <robh+dt@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>, <talel@amazon.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-3-git-send-email-talel@amazon.com>
 <fa6e5a95-d9dd-19f6-43e3-3046e0898bda@arm.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <553d06a4-a6b6-816f-b110-6ef7f300dde4@amazon.com>
Date:   Wed, 5 Jun 2019 17:38:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fa6e5a95-d9dd-19f6-43e3-3046e0898bda@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.162.57]
X-ClientProxiedBy: EX13D18UWC001.ant.amazon.com (10.43.162.105) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, will publish the fixes on v3.

On 6/5/2019 3:22 PM, Marc Zyngier wrote:
> Talel,
>
> On 05/06/2019 11:52, Talel Shenhar wrote:
>> The Amazon's Annapurna Labs Fabric Interrupt Controller has 32 inputs
>> lines. A FIC (Fabric Interrupt Controller) may be cascaded into another FIC
> Really? :-(

Cascading is used for control path events. For data path the HW is not 
cascaded (and usually even configured in MSI-X instead of wire interrupts)


>
> +}
> +
> +static int al_fic_irq_set_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
> +	struct al_fic *fic = gc->private;
> +	enum al_fic_state new_state;
> +	int ret = 0;
> +
> +	irq_gc_lock(gc);
> +
> +	if (!(flow_type & IRQ_TYPE_LEVEL_HIGH) &&
> +	    !(flow_type & IRQ_TYPE_EDGE_RISING)) {
> And what if this gets passed EDGE_BOTH?

FIC only support two sensing modes, rising-edge and level.

>
>> +	 * This is generally fixed depending on what pieces of HW it's wired up
>> +	 * to.
>> +	 *
>> +	 * We configure it based on the sensitivity of the first source
>> +	 * being setup, and reject any subsequent attempt at configuring it in a
>> +	 * different way.
> Is that a reliable guess? It also strikes me that the DT binding doesn't
> allow for the trigger type to be passed, meaning the individual drivers
> have to request the trigger as part of their request_irq() call. I'd
> rather you have a complete interrupt specifier in DT, and document the
> various limitations of the HW.

Indeed we use interrupt specifier that has the level type in it 
(dt-binding: "#interrupt-cells: must be 2.") which in turns causes to 
this irq_set_type callback.

Part of the FICs are connected to hws that generate pulse (for those, 
FIC shall be configured to rising-edge-triggered) and the others to hws 
that keep the line up (for those the FIC shall be configured to 
level-triggered).

>
>> +	 */
>> +	if (fic->state == AL_FIC_CLEAN) {
>> +		al_fic_set_trigger(fic, gc, new_state);
>> +	} else if (fic->state != new_state) {
>> +		pr_err("fic %s state already configured to %d\n",
>> +		       fic->name, fic->state);
>> +		ret = -EPERM;
> Same as above.

Those error messages are control path messages. if we return the same 
error value from here and from the previous error, how can we 
differentiate between the two error cases by looking at the log?

Having informative printouts seems like a good idea for bad 
configuration cases as such, wouldn't you agree?


