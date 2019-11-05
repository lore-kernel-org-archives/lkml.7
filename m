Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75466C010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4650221929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbfKEKae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:30:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388022AbfKEKae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:30:34 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5B4CDD69C5C10393D309;
        Tue,  5 Nov 2019 18:30:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 18:30:22 +0800
Subject: Re: [PATCH v2 03/36] irqchip/gic-v3-its: Allow LPI invalidation via
 the DirectLPI interface
To:     Marc Zyngier <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-4-maz@kernel.org>
 <a263e264-298c-57cf-31b7-a781160a3929@huawei.com>
 <86ftj7ybg2.wl-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <6d96dfc1-723a-be1e-d4ae-39c79e7fe080@huawei.com>
Date:   Tue, 5 Nov 2019 18:30:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <86ftj7ybg2.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/11/1 21:26, Marc Zyngier wrote:
> On Thu, 31 Oct 2019 08:49:32 +0000,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> But this patch really drives me to look through all callsites of
>> dev_event_to_col(), the abstraction which can be used _only_ with
>> physical LPI mappings.
>>
>> I find that when building the INV command, we use dev_event_to_col()
>> to find the "sync_obj" and then pass it to the following SYNC command.
>> But the "INV+SYNC" will be performed both on physical LPI and *VLPI*
>> (lpi_update_config/its_send_inv).
>> So I have two questions about the way we sending INV on VLPI:
>>
>> 1) Which "sync" command should be followed?  SYNC or VSYNC?
>> (we currently use SYNC, while the spec says, SYNC "ensures all
>> outstanding ITS operations associated with *physical* interrupts
>> for the Redistributor are globally observed ...")
>>
>> 2) The "sync_obj" we are currently using seems to be wrong.
> 
> I think you're right on both counts (where were you when I wrote the
> initial GICv4 support? ;-). I think the confusion stems from the fact

(I'm a bit late here :-).

> that there is no 'VINV' command, and we simply overlooked the sync
> object issue. It is quite likely that existing implementations don't
> care much about the difference (otherwise we'd have seen the problem
> before), but it doesn't hurt to do the right thing.
> 
> I have the following patch as part of a set of fixes that I'm about to
> post (once I get a chance to test them), let me know what you think.
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index a47ed2ba2907..75ab3716a870 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -702,6 +702,24 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
>   	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
>   }
>   
> +static struct its_vpe *its_build_vinv_cmd(struct its_node *its,
> +					  struct its_cmd_block *cmd,
> +					  struct its_cmd_desc *desc)
> +{
> +	struct its_vlpi_map *map;
> +
> +	map = dev_event_to_vlpi_map(desc->its_inv_cmd.dev,
> +				    desc->its_inv_cmd.event_id);

Indeed!  I think we need this kind of abstraction for VLPI.

> +
> +	its_encode_cmd(cmd, GITS_CMD_INV);
> +	its_encode_devid(cmd, desc->its_inv_cmd.dev->device_id);
> +	its_encode_event_id(cmd, desc->its_inv_cmd.event_id);
> +
> +	its_fixup_cmd(cmd);
> +
> +	return valid_vpe(its, map->vpe);
> +}
> +
>   static u64 its_cmd_ptr_to_offset(struct its_node *its,
>   				 struct its_cmd_block *ptr)
>   {
> @@ -1068,6 +1086,20 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
>   	its_send_single_vcommand(its, its_build_vinvall_cmd, &desc);
>   }
>   
> +static void its_send_vinv(struct its_device *dev, u32 event_id)
> +{
> +	struct its_cmd_desc desc;
> +
> +	/*
> +	 * There is no real VINV command. This is just a normal INV,
> +	 * with a VSYNC instead of a SYNC.
> +	 */
> +	desc.its_inv_cmd.dev = dev;
> +	desc.its_inv_cmd.event_id = event_id;
> +
> +	its_send_single_vcommand(dev->its, its_build_vinv_cmd, &desc);
> +}
> +
>   /*
>    * irqchip functions - assumes MSI, mostly.
>    */
> @@ -1142,8 +1174,10 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
>   	lpi_write_config(d, clr, set);
>   	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
>   		direct_lpi_inv(d);
> -	else
> +	else if (!irqd_is_forwarded_to_vcpu(d))
>   		its_send_inv(its_dev, its_get_event_id(d));
> +	else
> +		its_send_vinv(its_dev, its_get_event_id(d));

Yeah, this is exactly what I was having in the mind when reporting this
problem - "maybe we should have a SW emulated VINV+VSYNC for VLPI".
So I think this patch has done the right thing.

And what about the INT and CLEAR?  In response to guest's INT/CLEAR
commands, hypervisor (I mean KVM) will bother the ITS driver to send
INT/CLEAR for VLPIs.  They're both followed by SYNC and might need the
same fixes?


Thanks,
Zenghui

>   }
>   
>   static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
> 

