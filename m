Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B526C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D84121721
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569835212;
	bh=BiaZ4OQsV2qvKkRzrVE7JaDs4FQRZzX9aRE3h0Vd6WI=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=vNcQtbAKdiYg7ci/pdiN7KEzVQMOqPcpSX7r2QEnDvefSCiSd8dFVQJuhB0JZKpwo
	 UslvL0zVDh5UkTZJ11u8n6H6xsgbTncCvWVcKQR9mRlZXoKz0hNm9Y4N03OMjA/CZa
	 w35Nug2M/+nrmwhmZRFsBeaYKXU/wDXDSL7Ctk18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfI3JUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:20:11 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:54925 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbfI3JUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:20:11 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iErqf-0001rF-5T; Mon, 30 Sep 2019 11:20:05 +0200
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 20/35] irqchip/gic-v4.1: Allow direct invalidation of  VLPIs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Sep 2019 10:20:05 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <db01f956-bc53-b8a5-9406-15b889d717f0@huawei.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-21-maz@kernel.org>
 <db01f956-bc53-b8a5-9406-15b889d717f0@huawei.com>
Message-ID: <1c96d38da22a97b1fda94a940b60e345@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-28 03:02, Zenghui Yu wrote:
> On 2019/9/24 2:25, Marc Zyngier wrote:
>> Just like for INVALL, GICv4.1 has grown a VPE-aware INVLPI register.
>> Let's plumb it in and make use of the DirectLPI code in that case.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 19 +++++++++++++++++--
>>   include/linux/irqchip/arm-gic-v3.h |  1 +
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index b791c9beddf2..34595a7fcccb 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1200,13 +1200,27 @@ static void wait_for_syncr(void __iomem 
>> *rdbase)
>>   static void direct_lpi_inv(struct irq_data *d)
>>   {
>> +	struct its_vlpi_map *map = get_vlpi_map(d);
>>   	struct its_collection *col;
>>   	void __iomem *rdbase;
>> +	u64 val;
>> +
>> +	if (map) {
>> +		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> +
>> +		WARN_ON(!is_v4_1(its_dev->its));
>> +
>> +		val  = GICR_INVLPIR_V;
>> +		val |= FIELD_PREP(GICR_INVLPIR_VPEID, map->vpe->vpe_id);
>> +		val |= FIELD_PREP(GICR_INVLPIR_INTID, map->vintid);
>> +	} else {
>> +		val = d->hwirq;
>> +	}
>>
>>   	/* Target the redistributor this LPI is currently routed to */
>>   	col = irq_to_col(d);
>
> I think irq_to_col() may not work when GICv4.1 VLPIs are involved in.
>
> irq_to_col() gives us col_map[event] as the target redistributor,
> but the correct one for VLPIs should be 
> vlpi_maps[event]->vpe->col_idx.
> These two are not always pointing to the same physical RD.
> For example, if guest issues a MOVI against a VLPI, we will update 
> the
> corresponding vlpi_map->vpe and issue a VMOVI on ITS... but leave the
> col_map[event] unchanged.
>
> col_map[event] usually describes the physical LPI's CPU affinity, but
> when this physical LPI serves as something which the VLPI is backed 
> by,
> we take really little care of it.  Did I miss something here?

You didn't miss anything, and this is indeed another pretty bad bug.
The collection mapping is completely unused when the LPI becomes a
VLPI, and it is only the vpe->col_id that matters (which gets updated
on VMOVP).

This shows that irq_to_col() is the wrong abstraction, and what we're
interested is something that is more like 'irq to cpuid', allowing us
to directly point to the right distributor.

Please see the patch I just pushed[1], which does that.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-v4.1-devel&id=aff363113eb26b6840136b69c2c7db2ea691db20
-- 
Jazz is not dead. It just smells funny...
