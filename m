Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4A7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5F0214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKMICu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:02:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfKMICu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:02:50 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 333D7E05137A09BBC0E5;
        Wed, 13 Nov 2019 16:02:48 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 16:02:38 +0800
Subject: Re: [PATCH v2 12/36] irqchip/gic-v4.1: Implement the v4.1 flavour of
 VMAPP
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        "Robert Richter" <rrichter@marvell.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        <jiayanlei@huawei.com>, <liangboyan@hisilicon.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-13-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c9ef4c0f-bb34-82ff-c286-8430c1c7c583@huawei.com>
Date:   Wed, 13 Nov 2019 16:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-13-maz@kernel.org>
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

On 2019/10/27 22:42, Marc Zyngier wrote:
> The ITS VMAPP command gains some new fields with GICv4.1:
> - a default doorbell, which allows a single doorbell to be used for
>    all the VLPIs routed to a given VPE
> - a pointer to the configuration table (instead of having it in a register
>    that gets context switched)
> - a flag indicating whether this is the first map or the last unmap for
>    this particulat VPE
> - a flag indicating whether the pending table is known to be zeroed, or not
> 
> Plumb in the new fields in the VMAPP builder, and add the map/unmap
> refcounting so that the ITS can do the right thing.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

[...]

> @@ -605,19 +626,45 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
>   					   struct its_cmd_block *cmd,
>   					   struct its_cmd_desc *desc)
>   {
> -	unsigned long vpt_addr;
> +	unsigned long vpt_addr, vconf_addr;
>   	u64 target;
> -
> -	vpt_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->vpt_page));
> -	target = desc->its_vmapp_cmd.col->target_address + its->vlpi_redist_offset;
> +	bool alloc;
>   
>   	its_encode_cmd(cmd, GITS_CMD_VMAPP);
>   	its_encode_vpeid(cmd, desc->its_vmapp_cmd.vpe->vpe_id);
>   	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
> +
> +	if (!desc->its_vmapp_cmd.valid) {
> +		if (is_v4_1(its)) {
> +			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
> +			its_encode_alloc(cmd, alloc);
> +		}
> +
> +		goto out;
> +	}
> +
> +	vpt_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->vpt_page));
> +	target = desc->its_vmapp_cmd.col->target_address + its->vlpi_redist_offset;
> +
>   	its_encode_target(cmd, target);
>   	its_encode_vpt_addr(cmd, vpt_addr);
>   	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
>   
> +	if (!is_v4_1(its))
> +		goto out;
> +
> +	vconf_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
> +
> +	alloc = atomic_inc_and_test(&desc->its_vmapp_cmd.vpe->vmapp_count);

As the comment block on top of atomic_inc_and_test(atomic *v) says,

	 * Atomically increments @v by 1
	 * and returns true if the result is zero, or false for all
	 * other cases.
	 */

We will always get the 'alloc' as false here, even if this is the
first mapping of this vPE.  This is not as expected, I think.

And on the other hand, I wonder what is the reason for 'vmapp_count'
to be atomic_t?


Thanks,
Zenghui

> +
> +	its_encode_alloc(cmd, alloc);
> +
> +	/* We can only signal PTZ when alloc==1. Why do we have two bits? */
> +	its_encode_ptz(cmd, alloc);
> +	its_encode_vconf_addr(cmd, vconf_addr);
> +	its_encode_vmapp_default_db(cmd, desc->its_vmapp_cmd.vpe->vpe_db_lpi);
> +
> +out:
>   	its_fixup_cmd(cmd);
>   
>   	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
> @@ -3349,7 +3396,10 @@ static int its_vpe_init(struct its_vpe *vpe)
>   
>   	vpe->vpe_id = vpe_id;
>   	vpe->vpt_page = vpt_page;
> -	vpe->vpe_proxy_event = -1;
> +	if (gic_rdists->has_rvpeid)
> +		atomic_set(&vpe->vmapp_count, 0);
> +	else
> +		vpe->vpe_proxy_event = -1;
>   
>   	return 0;
>   }
> diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
> index ab1396afe08a..6213ced6f199 100644
> --- a/include/linux/irqchip/arm-gic-v4.h
> +++ b/include/linux/irqchip/arm-gic-v4.h
> @@ -37,8 +37,20 @@ struct its_vpe {
>   	irq_hw_number_t		vpe_db_lpi;
>   	/* VPE resident */
>   	bool			resident;
> -	/* VPE proxy mapping */
> -	int			vpe_proxy_event;
> +	union {
> +		/* GICv4.0 implementations */
> +		struct {
> +			/* VPE proxy mapping */
> +			int	vpe_proxy_event;
> +			/* Implementation Defined Area Invalid */
> +			bool	idai;
> +		};
> +		/* GICv4.1 implementations */
> +		struct {
> +			atomic_t vmapp_count;
> +		};
> +	};
> +
>   	/*
>   	 * This collection ID is used to indirect the target
>   	 * redistributor for this VPE. The ID itself isn't involved in
> @@ -47,8 +59,6 @@ struct its_vpe {
>   	u16			col_idx;
>   	/* Unique (system-wide) VPE identifier */
>   	u16			vpe_id;
> -	/* Implementation Defined Area Invalid */
> -	bool			idai;
>   	/* Pending VLPIs on schedule out? */
>   	bool			pending_last;
>   };
> 

