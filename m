Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7261206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfDDNQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:16:56 -0400
Received: from foss.arm.com ([217.140.101.70]:60118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDDNQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:16:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84466A78;
        Thu,  4 Apr 2019 06:16:55 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9251E3F68F;
        Thu,  4 Apr 2019 06:16:53 -0700 (PDT)
Date:   Thu, 4 Apr 2019 14:16:42 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <marc.zyngier@arm.com>, <christoffer.dall@arm.com>,
        <eric.auger@redhat.com>, <james.morse@arm.com>,
        <julien.thierry@arm.com>, <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Restrict setting irq->targets
 only in GICv2
Message-ID: <20190404141642.385daf5b@donnerap.cambridge.arm.com>
In-Reply-To: <1554381015-13056-1-git-send-email-yuzenghui@huawei.com>
References: <1554381015-13056-1-git-send-email-yuzenghui@huawei.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 12:30:15 +0000
Zenghui Yu <yuzenghui@huawei.com> wrote:

Hi,

> Commit ad275b8bb1e6 ("KVM: arm/arm64: vgic-new: vgic_init: implement
> vgic_init") had set irq->targets in kvm_vgic_vcpu_init(), regardless of
> the GIC architecture (v2 or v3). When the number of vcpu reaches 32
> (in v3), UBSAN will complain about it.

The first part looks similar to this one:
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/637209.html

>  ================================================================================
>  UBSAN: Undefined behaviour in arch/arm64/kvm/../../../virt/kvm/arm/vgic/vgic-init.c:223:21
>  shift exponent 32 is too large for 32-bit type 'unsigned int'
>  CPU: 13 PID: 833 Comm: CPU 32/KVM Kdump: loaded Not tainted 5.1.0-rc1+ #16
>  Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.58 10/24/2018
>  Call trace:
>   dump_backtrace+0x0/0x190
>   show_stack+0x24/0x30
>   dump_stack+0xc8/0x114
>   ubsan_epilogue+0x14/0x50
>   __ubsan_handle_shift_out_of_bounds+0x118/0x188
>   kvm_vgic_vcpu_init+0x1d4/0x200
>   kvm_arch_vcpu_init+0x3c/0x48
>   kvm_vcpu_init+0xa8/0x100
>   kvm_arch_vcpu_create+0x94/0x120
>   kvm_vm_ioctl+0x57c/0xe58
>   do_vfs_ioctl+0xc4/0x7f0
>   ksys_ioctl+0x8c/0xa0
>   __arm64_sys_ioctl+0x28/0x38
>   el0_svc_common+0xa0/0x190
>   el0_svc_handler+0x38/0x78
>   el0_svc+0x8/0xc
>  ================================================================================
> 
> This patch Restricts setting irq->targets in GICv2, which only supports
> a maximum of eight PEs, to keep UBSAN quiet. And since irq->mpidr will
> only be used by SPI in GICv3, we decided to set mpidr to 0 for SGI and
> PPI.
> 
> Like commit ab2d5eb03dbb ("KVM: arm/arm64: vgic: Always initialize the
> group of private IRQs"), we should also take the creating order of the
> VGIC and VCPUs into consideration.
> 
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  virt/kvm/arm/vgic/vgic-init.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index 3bdb31e..0cba92e 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -220,7 +220,6 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  		irq->intid = i;
>  		irq->vcpu = NULL;
>  		irq->target_vcpu = vcpu;
> -		irq->targets = 1U << vcpu->vcpu_id;
>  		kref_init(&irq->refcount);
>  		if (vgic_irq_is_sgi(i)) {
>  			/* SGIs */
> @@ -231,10 +230,14 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  			irq->config = VGIC_CONFIG_LEVEL;
>  		}
>  
> -		if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
> +		if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
>  			irq->group = 1;
> -		else
> +			irq->mpidr = 0;
> +		} else {
>  			irq->group = 0;
> +			if (vcpu->vcpu_id < VGIC_V2_MAX_CPUS)
> +				irq->targets = 1U << vcpu->vcpu_id;
> +		}
>  	}
>  
>  	if (!irqchip_in_kernel(vcpu->kvm))
> @@ -297,10 +300,13 @@ int vgic_init(struct kvm *kvm)
>  
>  		for (i = 0; i < VGIC_NR_PRIVATE_IRQS; i++) {
>  			struct vgic_irq *irq = &vgic_cpu->private_irqs[i];
> -			if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
> +			if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
>  				irq->group = 1;
> -			else
> +				irq->mpidr = 0;
> +			} else {
>  				irq->group = 0;
> +				irq->targets = 1U << vcpu->vcpu_id;
> +			}

So why would you need this part? That does the same as above, doesn't it?

Cheers,
Andre.


>  		}
>  	}
>  

