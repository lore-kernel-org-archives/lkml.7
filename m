Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C95AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E2D206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566226396;
	bh=D8NLHh/DMMsaCLqHnRP/cAhVUIC6PZid+v/PEUaRo7g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=shYpd6o1TOEBQkPYLGs4TkMBVglaYFUB1FRBbDzLFppltc2WJXQa8oXc47RFvCYrF
	 EjvPrxtmqs87T/XwGFvblLOrglK4qasUIIVaQB1UmXxlNLTSQ0NiqL/jvWhohGSNY4
	 3BYNMBWPXtZkYdLeqOajpUhm9otgnQDWUbpIhW/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfHSOxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:53:15 -0400
Received: from foss.arm.com ([217.140.110.172]:55902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfHSOxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:53:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E76928;
        Mon, 19 Aug 2019 07:53:14 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BB2D3F718;
        Mon, 19 Aug 2019 07:53:12 -0700 (PDT)
Subject: Re: [PATCH v2 01/12] irqchip/gic: Rework gic_configure_irq to take
 the full ICFGR base
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-2-maz@kernel.org>
 <a601236c-8128-ca7a-667f-12a4b7cefb89@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <e9129a9e-ebef-7108-d4a3-c91c22eb29a3@kernel.org>
Date:   Mon, 19 Aug 2019 15:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a601236c-8128-ca7a-667f-12a4b7cefb89@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2019 15:26, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2019/8/6 18:01, Marc Zyngier wrote:
>> gic_configure_irq is currently passed the (re)distributor address,
>> to which it applies an a fixed offset to get to the configuration
>> registers. This offset is constant across all GICs, or rather it was
>> until to v3.1...
>>
>> An easy way out is for the individual drivers to pass the base
>> address of the configuration register for the considered interrupt.
>> At the same time, move part of the error handling back to the
>> individual drivers, as things are about to change on that front.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-common.c | 14 +++++---------
>>   drivers/irqchip/irq-gic-v3.c     | 11 ++++++++++-
>>   drivers/irqchip/irq-gic.c        | 10 +++++++++-
>>   drivers/irqchip/irq-hip04.c      |  7 ++++++-
>>   4 files changed, 30 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
>> index b0a8215a13fc..6900b6f0921c 100644
>> --- a/drivers/irqchip/irq-gic-common.c
>> +++ b/drivers/irqchip/irq-gic-common.c
>> @@ -63,7 +63,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>>   	 * for "irq", depending on "type".
>>   	 */
>>   	raw_spin_lock_irqsave(&irq_controller_lock, flags);
>> -	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
>> +	val = oldval = readl_relaxed(base + confoff);
>>   	if (type & IRQ_TYPE_LEVEL_MASK)
>>   		val &= ~confmask;
>>   	else if (type & IRQ_TYPE_EDGE_BOTH)
>> @@ -83,14 +83,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>>   	 * does not allow us to set the configuration or we are in a
>>   	 * non-secure mode, and hence it may not be catastrophic.
>>   	 */
>> -	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
>> -	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val) {
>> -		if (WARN_ON(irq >= 32))
>> -			ret = -EINVAL;
> 
> Since this WARN_ON is dropped, the comment above should also be updated.
> But what is the reason for deleting it?  (It may give us some points
> when we fail to set type for SPIs.)

The core code already warns in the case where irq_set_type() fails, and
the duplication of warnings is pretty superfluous.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
