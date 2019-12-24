Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23443C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED8B20722
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577179146;
	bh=U56Tzl38Vn8Mk3NXJD3PXZX9BDUmTlyLCXERb+QoEE4=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=l+b/kTZOQPkhKtiPdoOx14E/I0Vy9N1zbkIMu38AiQw3ta4UoGD4XjKkDrJTdSS36
	 vChztFaF2Borzko8KfZApiIxPwFQOyTHf9wUyHlcMzxME5vPsAF9uSfmElYRB3Upge
	 0O+a9vjXYVQZPVFDGL603PCdHsX8Nc3KnEFDZXjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLXJTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 04:19:06 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:46908 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfLXJTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 04:19:05 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ijgLE-0007yh-OI; Tue, 24 Dec 2019 10:19:00 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 11/36] irqchip/gic-v4.1: VPE table (aka  =?UTF-8?Q?GICR=5FVPROPBASER=29=20allocation?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Dec 2019 09:19:00 +0000
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
        Robert Richter <rrichter@marvell.com>,
        <tangnianyao@huawei.com>, <wangwudi@hisilicon.com>
In-Reply-To: <61526052-aa00-0769-d5bb-3524161c5650@huawei.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-12-maz@kernel.org>
 <61526052-aa00-0769-d5bb-3524161c5650@huawei.com>
Message-ID: <7eb71594ac3617e1a2b58b7537cf3d64@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, jnair@marvell.com, rrichter@marvell.com, tangnianyao@huawei.com, wangwudi@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2019-12-24 07:10, Zenghui Yu wrote:
> Hi Marc,
>
> [ +Wudi and Nianyao. As they spotted the following issue but
>  I forgot to send it out. ]
>
> On 2019/10/27 22:42, Marc Zyngier wrote:
>> GICv4.1 defines a new VPE table that is potentially shared between
>> both the ITSs and the redistributors, following complicated affinity
>> rules.
>> To make things more confusing, the programming of this table at
>> the redistributor level is reusing the GICv4.0 GICR_VPROPBASER 
>> register
>> for something completely different.
>> The code flow is somewhat complexified by the need to respect the
>> affinities required by the HW, meaning that tables can either be
>> inherited from a previously discovered ITS or redistributor.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---[...]
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 40912b3fb0e1..478d3678850c 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
> [...]
>> @@ -2025,6 +2098,214 @@ static int its_alloc_tables(struct its_node 
>> *its)
>>   	return 0;
>>   }
>>   +static u64 inherit_vpe_l1_table_from_its(void)
>> +{
>> +	struct its_node *its;
>> +	u64 val;
>> +	u32 aff;
>> +
>> +	val = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
>> +	aff = compute_common_aff(val);
>> +
>> +	list_for_each_entry(its, &its_nodes, entry) {
>> +		u64 baser;
>> +
>> +		if (!is_v4_1(its))
>> +			continue;
>> +
>> +		if (!FIELD_GET(GITS_TYPER_SVPET, its->typer))
>> +			continue;
>> +
>> +		if (aff != compute_its_aff(its))
>> +			continue;
>> +
>> +		/* GICv4.1 guarantees that the vPE table is GITS_BASER2 */
>> +		baser = its->tables[2].val;
>> +		if (!(baser & GITS_BASER_VALID))
>> +			continue;
>> +
>> +		/* We have a winner! */
>> +		val  = GICR_VPROPBASER_4_1_VALID;
>> +		if (baser & GITS_BASER_INDIRECT)
>> +			val |= GICR_VPROPBASER_4_1_INDIRECT;
>> +		val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE,
>> +				  FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser));
>> +		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR,
>> +				  GITS_BASER_ADDR_48_to_52(baser) >> 12);
>
> We've used GITS_BASER_ADDR_48_to_52() only in the KVM code where the
> pagesize of ITS table is fixed to 64K.
> It may not work when the pagesize is 4K or 16K?

You're absolutely right, we shouldn't mess with the 52bit macros when
PZ isn't set to 64k. I'm adding the following fix to this patch:

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index e1f8d5f9a0e3..3234bb9fbdbe 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2433,7 +2433,7 @@ static u64 inherit_vpe_l1_table_from_its(void)
  	aff = compute_common_aff(val);

  	list_for_each_entry(its, &its_nodes, entry) {
-		u64 baser;
+		u64 baser, addr;

  		if (!is_v4_1(its))
  			continue;
@@ -2455,8 +2455,15 @@ static u64 inherit_vpe_l1_table_from_its(void)
  			val |= GICR_VPROPBASER_4_1_INDIRECT;
  		val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE,
  				  FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser));
-		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR,
-				  GITS_BASER_ADDR_48_to_52(baser) >> 12);
+		switch (FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser)) {
+		case GIC_PAGE_SIZE_64K:
+			addr = GITS_BASER_ADDR_48_to_52(baser);
+			break;
+		default:
+			addr = baser & GENMASK_ULL(47, 12);
+			break;
+		}
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, addr >> 12);
  		val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
  				  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
  		val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,


Thanks again,

         M.
-- 
Jazz is not dead. It just smells funny...
