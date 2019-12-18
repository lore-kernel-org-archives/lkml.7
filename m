Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83721227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576679950;
	bh=EgGLL6jla2tPj4hM1nZ57EaYYxHE3Dgp4pJVEPdGbL8=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=mjp5srCfXsVHQQl+Y+T6gaFEHi+/EH+Y30pF3ncZFBa/AT2x/xLN/pYh/fiwOu1kG
	 4NXSiY4jnrKtVOMMGTfAkb7G/3P3nBxIHNEvTuVMm+dAEO9M8wgoc1qTqwQ8F6IKi4
	 tY54GgcsbUN9/mOUjwcNra8gq1864vkPVGm177cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLROjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:39:09 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:50989 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbfLROjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:39:08 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihaTg-0002jL-Mr; Wed, 18 Dec 2019 15:39:04 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 13/36] irqchip/gic-v4.1: Don't use the VPE proxy if  RVPEID is set
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 14:39:04 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
In-Reply-To: <8514ccbe-814a-5bdd-3791-bdd65510ce68@huawei.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-14-maz@kernel.org>
 <8514ccbe-814a-5bdd-3791-bdd65510ce68@huawei.com>
Message-ID: <762f78e917ac501629729fcf7718178c@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, jnair@marvell.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-01 11:05, Zenghui Yu wrote:
> Hi Marc,
>
> On 2019/10/27 22:42, Marc Zyngier wrote:
>> The infamous VPE proxy device isn't used with GICv4.1 because:
>> - we can invalidate any LPI from the DirectLPI MMIO interface
>> - the ITS and redistributors understand the life cycle of
>>    the doorbell, so we don't need to enable/disable it all
>>    the time
>> So let's escape early from the proxy related functions.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 220d490d516e..999e61a9b2c3 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -3069,7 +3069,7 @@ static const struct irq_domain_ops 
>> its_domain_ops = {
>>   /*
>>    * This is insane.
>>    *
>> - * If a GICv4 doesn't implement Direct LPIs (which is extremely
>> + * If a GICv4.0 doesn't implement Direct LPIs (which is extremely
>>    * likely), the only way to perform an invalidate is to use a fake
>>    * device to issue an INV command, implying that the LPI has first
>>    * been mapped to some event on that device. Since this is not 
>> exactly
>> @@ -3077,9 +3077,18 @@ static const struct irq_domain_ops 
>> its_domain_ops = {
>>    * only issue an UNMAP if we're short on available slots.
>>    *
>>    * Broken by design(tm).
>> + *
>> + * GICv4.1 actually mandates that we're able to invalidate by 
>> writing to a
>> + * MMIO register. It doesn't implement the whole of DirectLPI, but 
>> that's
>> + * good enough. And most of the time, we don't even have to 
>> invalidate
>> + * anything, so that's actually pretty good!
>
> I can't understand the meaning of this last sentence. May I ask for 
> an
> explanation? :)

Yeah, reading this now, it feels pretty clumsy, and only remotely
connected to the patch.

What I'm trying to say here is that, although GICv4.1 doesn't have
the full spectrum of v4.0 DirectLPI (it only allows a subset of it),
this subset is more then enough for us. Here's the rational:

When a vPE exits from the hypervisor, we know whether we need to
request a doorbell or not (depending on whether we're blocking on
WFI or not). On GICv4.0, this translates into enabling the doorbell
interrupt, which generates an invalidation (costly). And whenever
we've taken a doorbell, or are scheduled again, we need to turn
the doorbell off (invalidation again).

With v4.1, we can just say *at exit time* whether we want doorbells
to be subsequently generated (see its_vpe_4_1_deschedule() and the
req_db parameter in the info structure). This is part of making
the vPE non-resident, so we have 0 overhead at this stage.

I'll try and update the comment here.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
