Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A37C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB71218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563887051;
	bh=hZCf8bF5bYSsw3AStRNQjVvLJpUG0cq8278mU358RhQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xvMai/WjDERDnD0xWJjm65zXp456nyGcH52yBsQQvauVLe5KTQ8WtXTDusUJy4ggV
	 yp+9/b1hfFnuwhJVID9LW70KJPDpqv8Ja79rRegHToVn5M6n/eFHpyI6iQz7JgBPAm
	 oZ+An/16J/O1799a18NBDJeAd3WUAKFHY13xvVqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbfGWNEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:04:10 -0400
Received: from foss.arm.com ([217.140.110.172]:54538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbfGWNEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:04:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E14B5337;
        Tue, 23 Jul 2019 06:04:08 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2D013F71F;
        Tue, 23 Jul 2019 06:04:07 -0700 (PDT)
Subject: Re: [PATCH 4/9] irqchip/gic-v3: Add ESPI range support
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190723104437.154403-1-maz@kernel.org>
 <20190723104437.154403-5-maz@kernel.org>
 <a54dfa07-2f3b-def7-fec4-b6dab2bcd84c@ti.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <de12cbf0-22ec-83d0-a034-9872f302101b@kernel.org>
Date:   Tue, 23 Jul 2019 14:04:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a54dfa07-2f3b-def7-fec4-b6dab2bcd84c@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 13:50, Lokesh Vutla wrote:
> 
> 
> On 23/07/19 4:14 PM, Marc Zyngier wrote:
>> Add the required support for the ESPI range, which behave exactly like
>> the SPIs of old, only with new funky INTIDs.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c       | 85 ++++++++++++++++++++++++------
>>  include/linux/irqchip/arm-gic-v3.h | 17 +++++-
>>  2 files changed, 85 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 2371e0a70215..d328a8de533f 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -51,13 +51,16 @@ struct gic_chip_data {
>>  	u32			nr_redist_regions;
>>  	u64			flags;
>>  	bool			has_rss;
>> -	unsigned int		irq_nr;
>>  	struct partition_desc	*ppi_descs[16];
>>  };
>>  
>>  static struct gic_chip_data gic_data __read_mostly;
>>  static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>>  
>> +#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
>> +#define GIC_LINE_NR	GICD_TYPER_SPIS(gic_data.rdists.gicd_typer)
>> +#define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
>> +
>>  /*
>>   * The behaviours of RPR and PMR registers differ depending on the value of
>>   * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
>> @@ -100,6 +103,7 @@ static DEFINE_PER_CPU(bool, has_rss);
>>  enum gic_intid_range {
>>  	PPI_RANGE,
>>  	SPI_RANGE,
>> +	ESPI_RANGE,
>>  	LPI_RANGE,
>>  	__INVALID_RANGE__
>>  };
>> @@ -111,6 +115,8 @@ static enum gic_intid_range __get_intid_range(irq_hw_number_t hwirq)
>>  		return PPI_RANGE;
>>  	case 32 ... 1019:
>>  		return SPI_RANGE;
>> +	case ESPI_BASE_INTID ... 8191:
> 
> as per dt documentation, shouldn't the range be
> 	case ESPI_BASE_INTID ... 5119:

Yes, you're right. Although I strongly suspect that someone will bump
this limit up again at some point (there is enough space in the new
register space for 4k interrupts -- madness).

> 
>> +		return ESPI_RANGE;
>>  	case 8192 ... GENMASK(23, 0):
>>  		return LPI_RANGE;
>>  	default:
>> @@ -141,6 +147,7 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
>>  		return gic_data_rdist_sgi_base();
>>  
>>  	case SPI_RANGE:
>> +	case ESPI_RANGE:
>>  		/* SPI -> dist_base */
>>  		return gic_data.dist_base;
>>  
>> @@ -234,6 +241,31 @@ static u32 convert_offset_index(struct irq_data *d, u32 offset, u32 *index)
>>  	case SPI_RANGE:
>>  		*index = d->hwirq;
>>  		return offset;
>> +	case ESPI_RANGE:
>> +		*index = d->hwirq - ESPI_BASE_INTID;
>> +		switch (offset) {
>> +		case GICD_ISENABLER:
>> +			return GICD_ISENABLERnE;
>> +		case GICD_ICENABLER:
>> +			return GICD_ICENABLERnE;
>> +		case GICD_ISPENDR:
>> +			return GICD_ISPENDRnE;
>> +		case GICD_ICPENDR:
>> +			return GICD_ICPENDRnE;
>> +		case GICD_ISACTIVER:
>> +			return GICD_ISACTIVERnE;
>> +		case GICD_ICACTIVER:
>> +			return GICD_ICACTIVERnE;
>> +		case GICD_IPRIORITYR:
>> +			return GICD_IPRIORITYRnE;
>> +		case GICD_ICFGR:
>> +			return GICD_ICFGRnE;
>> +		case GICD_IROUTER:
>> +			return GICD_IROUTERnE;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>>  	default:
>>  		break;
>>  	}
>> @@ -316,7 +348,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
>>  {
>>  	u32 reg;
>>  
>> -	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
>> +	if (d->hwirq >= 8192) /* PPI/SPI only */
>>  		return -EINVAL;
>>  
>>  	switch (which) {
>> @@ -343,7 +375,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
>>  static int gic_irq_get_irqchip_state(struct irq_data *d,
>>  				     enum irqchip_irq_state which, bool *val)
>>  {
>> -	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
>> +	if (d->hwirq >= 8192) /* PPI/SPI only */
>>  		return -EINVAL;
>>  
>>  	switch (which) {
>> @@ -567,7 +599,12 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>>  		gic_arch_enable_irqs();
>>  	}
>>  
>> -	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
>> +	/* Check for special IDs first */
>> +	if ((irqnr >= 1020 && irqnr <= 1023))
>> +		return;
> 
> May be I am missing something here, what is special about these 4 interrupts? or
> you meant to check for reserved range here?

What's so special about the special INTID range is that these are not
interrupts at all. That's how the GIC signals that *something else* is
happening (see 2.2.1 "Special INTIDs" in the architecture spec). In
practice, and as long as you run Linux in non-secure mode, only 1023 can
happen.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
