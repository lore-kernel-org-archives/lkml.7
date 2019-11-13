Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC13C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46DF2245C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573638427;
	bh=vluBE7BSozFlc0jVdRWXM2kK0Sjeyop8uoFMTSBuSyE=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=F2riiHz75GdmNGVQlhIqlkhlPxVg/ff2uwo9fGRHCWNmhZkovKei+mh+egr2skqZ0
	 3HW7L5Uf1MqT3jc20m16DXzhxk1AEOCNG04lfSPljhayvqi/8xbeE6MpTC+Vwkz21W
	 q0+TBgFxr041M7x3A1XPBkezdwtSr6SiQxfSfLNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKMJrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:47:06 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:43814 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfKMJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:47:05 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iUpEs-0007KN-22; Wed, 13 Nov 2019 10:47:02 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 12/36] irqchip/gic-v4.1: Implement the v4.1 flavour  of VMAPP
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 10:56:22 +0109
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
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        <jiayanlei@huawei.com>, <liangboyan@hisilicon.com>
In-Reply-To: <c9ef4c0f-bb34-82ff-c286-8430c1c7c583@huawei.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-13-maz@kernel.org>
 <c9ef4c0f-bb34-82ff-c286-8430c1c7c583@huawei.com>
Message-ID: <c3830faf33c7f8b983ad4863fe02b86b@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, jnair@marvell.com, rrichter@marvell.com, wanghaibin.wang@huawei.com, jiayanlei@huawei.com, liangboyan@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2019-11-13 09:11, Zenghui Yu wrote:
> Hi Marc,
>
> On 2019/10/27 22:42, Marc Zyngier wrote:
>> The ITS VMAPP command gains some new fields with GICv4.1:
>> - a default doorbell, which allows a single doorbell to be used for
>>    all the VLPIs routed to a given VPE
>> - a pointer to the configuration table (instead of having it in a 
>> register
>>    that gets context switched)
>> - a flag indicating whether this is the first map or the last unmap 
>> for
>>    this particulat VPE
>> - a flag indicating whether the pending table is known to be zeroed, 
>> or not
>> Plumb in the new fields in the VMAPP builder, and add the map/unmap
>> refcounting so that the ITS can do the right thing.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> [...]
>
>> @@ -605,19 +626,45 @@ static struct its_vpe 
>> *its_build_vmapp_cmd(struct its_node *its,
>>   					   struct its_cmd_block *cmd,
>>   					   struct its_cmd_desc *desc)
>>   {
>> -	unsigned long vpt_addr;
>> +	unsigned long vpt_addr, vconf_addr;
>>   	u64 target;
>> -
>> -	vpt_addr = 
>> virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->vpt_page));
>> -	target = desc->its_vmapp_cmd.col->target_address + 
>> its->vlpi_redist_offset;
>> +	bool alloc;
>>
>>   	its_encode_cmd(cmd, GITS_CMD_VMAPP);
>>   	its_encode_vpeid(cmd, desc->its_vmapp_cmd.vpe->vpe_id);
>>   	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
>> +
>> +	if (!desc->its_vmapp_cmd.valid) {
>> +		if (is_v4_1(its)) {
>> +			alloc = 
>> !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
>> +			its_encode_alloc(cmd, alloc);
>> +		}
>> +
>> +		goto out;
>> +	}
>> +
>> +	vpt_addr = 
>> virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->vpt_page));
>> +	target = desc->its_vmapp_cmd.col->target_address + 
>> its->vlpi_redist_offset;
>> +
>>   	its_encode_target(cmd, target);
>>   	its_encode_vpt_addr(cmd, vpt_addr);
>>   	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
>>   +	if (!is_v4_1(its))
>> +		goto out;
>> +
>> +	vconf_addr = 
>> virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
>> +
>> +	alloc = 
>> atomic_inc_and_test(&desc->its_vmapp_cmd.vpe->vmapp_count);
>
> As the comment block on top of atomic_inc_and_test(atomic *v) says,
>
>  * Atomically increments @v by 1
>  * and returns true if the result is zero, or false for all
>  * other cases.
>  */
>
> We will always get the 'alloc' as false here, even if this is the
> first mapping of this vPE.  This is not as expected, I think.

As usual, a very good observation!

Indeed, I cocked up the logic here, as we need to test the value before
the increment (and not after). What we want is probably something like:

   alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);

> And on the other hand, I wonder what is the reason for 'vmapp_count'
> to be atomic_t?

The rational is that we could end-up with multiple VMAPP commands 
emitted
in parallel, for example. That's probably not strictly necessary right 
now,
but I'm trying to be cautious.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
