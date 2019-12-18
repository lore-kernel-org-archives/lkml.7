Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545B9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284012176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576678710;
	bh=whI8DBA9SGsVnqnn2M3j6v6bt3I/MFibIh165SHkZ3Q=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=2BoJvd5bn9DKejZiA93Y/8EmKHTEMBJZcjfEMszEl4RwDBQAc21Ngi0NZ2O2/14j7
	 94tShj3qqbysOL+uIGGaidvWkoTjtbFliQIirLBdQ56vWgUCOcP46mSMmfhEGuTdMc
	 bI36N55FOK+q9EJ/BA9dzQp5wAbumHOYGi8sgW3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLROS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:18:29 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:58302 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbfLROS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:18:28 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iha9g-0002Dh-1A; Wed, 18 Dec 2019 15:18:24 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 19/36] irqchip/gic-v4.1: Add VPE INVALL callback
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 14:18:23 +0000
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
In-Reply-To: <28e29c2d-a35a-6a67-c65d-7ab61d33b21b@huawei.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-20-maz@kernel.org>
 <28e29c2d-a35a-6a67-c65d-7ab61d33b21b@huawei.com>
Message-ID: <54ec5b97e909e4da85064c66fb2a1348@www.loen.fr>
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

[Old email, doing some v3 cleanup]

On 2019-11-01 11:51, Zenghui Yu wrote:
> Hi Marc,
>
> On 2019/10/27 22:42, Marc Zyngier wrote:
>> GICv4.1 redistributors have a VPE-aware INVALL register. Progress!
>> We can now emulate a guest-requested INVALL without emiting a
>> VINVALL command.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 14 ++++++++++++++
>>   include/linux/irqchip/arm-gic-v3.h |  3 +++
>>   2 files changed, 17 insertions(+)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index f7effd453729..10bd156aa042 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -3511,6 +3511,19 @@ static void its_vpe_4_1_deschedule(struct 
>> its_vpe *vpe,
>>   	}
>>   }
>>   +static void its_vpe_4_1_invall(struct its_vpe *vpe)
>> +{
>> +	void __iomem *rdbase;
>> +	u64 val;
>> +
>> +	val  = GICR_INVLPIR_V;
>> +	val |= FIELD_PREP(GICR_INVLPIR_VPEID, vpe->vpe_id);
>
> Can we use GICR_INVALL_V/VPEID instead, and ...
>
>> +
>> +	/* Target the redistributor this vPE is currently known on */
>> +	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
>> +	gic_write_lpir(val, rdbase + GICR_INVALLR);
>> +}
>> +
>>   static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void 
>> *vcpu_info)
>>   {
>>   	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> @@ -3526,6 +3539,7 @@ static int 
>> its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>>   		return 0;
>>
>>   	case INVALL_VPE:
>> +		its_vpe_4_1_invall(vpe);
>>   		return 0;
>>
>>   	default:
>> diff --git a/include/linux/irqchip/arm-gic-v3.h 
>> b/include/linux/irqchip/arm-gic-v3.h
>> index 6fd89d77b2b2..b69f60792554 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -247,6 +247,9 @@
>>   #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
>>   #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
>>   +#define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
>> +#define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
>> +
>
> ... define them here:
>
> #define GICR_INVALL_VPEID		GICR_INVLPIR_VPEID
> #define GICR_INVALL_V			GICR_INVLPIR_V

Yes, that's a sensible things to do. I'll squash that in my rebased 
series.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
