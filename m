Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68045C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A1D20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569323902;
	bh=l/1nOJlzAx7a+1RwYHG7dsPZRi5qGsCrdLfDXBKjS2I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vhHmCkmZ/CbiU4WHioGwLHaDwhW0uVowRSa8rzOW/xtQNWjpKzZuqy8vh7FbQjeSp
	 Ue28S8ZC32Uniix5YQiswPV8gyV3Sy6jLrs5EKvN6z1zuI4o5sz2TLzCt282ApLkB8
	 7f2Yi3yq3pAahyPPKQYKH8FdVksVGDwsG9ijtkjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504626AbfIXLSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:18:21 -0400
Received: from foss.arm.com ([217.140.110.172]:57866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393364AbfIXLSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:18:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A728142F;
        Tue, 24 Sep 2019 04:18:20 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4A553F67D;
        Tue, 24 Sep 2019 04:18:18 -0700 (PDT)
Subject: Re: [PATCH 04/35] irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-5-maz@kernel.org>
 <20190924102413.GN9720@e119886-lin.cambridge.arm.com>
 <a8107ed9-bb95-a648-ea41-597510f35ec8@kernel.org>
 <20190924110019.GP9720@e119886-lin.cambridge.arm.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <054befea-ffc7-157d-03b8-5a099c639a57@kernel.org>
Date:   Tue, 24 Sep 2019 12:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924110019.GP9720@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2019 12:00, Andrew Murray wrote:
> On Tue, Sep 24, 2019 at 11:49:24AM +0100, Marc Zyngier wrote:
>> On 24/09/2019 11:24, Andrew Murray wrote:
>>> On Mon, Sep 23, 2019 at 07:25:35PM +0100, Marc Zyngier wrote:
>>>> GICv4.1 supports the RVPEID ("Residency per vPE ID"), which allows for
>>>> a much efficient way of making virtual CPUs resident (to allow direct
>>>> injection of interrupts).
>>>>
>>>> The functionnality needs to be discovered on each and every redistributor
>>>> in the system, and disabled if the settings are inconsistent.
>>>>
>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>> ---
>>>>  drivers/irqchip/irq-gic-v3.c       | 21 ++++++++++++++++++---
>>>>  include/linux/irqchip/arm-gic-v3.h |  2 ++
>>>>  2 files changed, 20 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>>> index 422664ac5f53..0b545e2c3498 100644
>>>> --- a/drivers/irqchip/irq-gic-v3.c
>>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>>> @@ -849,8 +849,21 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>>>>  					 void __iomem *ptr)
>>>>  {
>>>>  	u64 typer = gic_read_typer(ptr + GICR_TYPER);
>>>> +
>>>>  	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
>>>> -	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
>>>> +
>>>> +	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
>>>
>>> I think the doc says, RVPEID is *always* 1 for GICv4.1 (and presumably beyond)
>>> and when RVPEID==1 then DirectLPI is *always* 0 - but that's OK because for
>>> GICv4.1 support for direct LPIs is mandatory.
>>
>> Well, v4.1 support for DirectLPI is pretty patchy. It has just enough
>> features to make it useful.
>>
>>>
>>>> +	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
>>>> +	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
>>>> +					   gic_data.rdists.has_rvpeid);
>>>> +
>>>> +	/* Detect non-sensical configurations */
>>>> +	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
>>>
>>> How feasible is the following suitation? All the redistributors in the system has
>>> vlpis=0, and only the first redistributor has rvpeid=1 (with the remaining ones
>>> rvpeid=0).If we evaluate this WARN_ON_ONCE on each call to
>>> __gic_update_rdist_properties we end up without direct LPI support, however if we
>>> evaluated this after iterating through all the redistributors then we'd end up
>>> with direct LPI support and a non-essential WARN.
>>>
>>> Should we do the WARN after iterating through all the redistributors once we
>>> know what the final values of these flags will be, perhaps in
>>> gic_update_rdist_properties?
>>
>> What does it gains us?
> 
> It prevents an unnecessary WARN.
> 
> If the first redistributor has rvpeid=1, vlpis=0, direct_lpi=1, and the others
> have rvpeid=0, vlpis=0, direct_lpi=0. At the end of iteration, without the
> WARN if statement, you end up wth rvpeid=0, vlpis=0, direct_lpi=0. I.e. it's
> done the right thing. In this use-case the WARN doesn't achieve anything other
> than give the user a pointless WARN. If the WARN was moved to after iteration
> then the WARN wouldn't fire.

But it definitely *should* fire. RVPEID+!VLPI is terminally broken.
What's the use of RVPEID if you cannot directly inject anything? To me
blunt: any difference of HW configuration for any redistributor is an
error. They should all be identical (no, I'm not planning to deal with
the GIC equivalent OF BL).

> I have no idea how likely this use-case is.

There is no use case. Such a configuration shouldn't exist. I'm
considering calling panic instead.

	M.
-- 
Jazz is not dead, it just smells funny...
