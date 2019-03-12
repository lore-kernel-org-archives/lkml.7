Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E67C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75A5214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCLBov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:44:51 -0400
Received: from foss.arm.com ([217.140.101.70]:35160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfCLBou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:44:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4315BA78;
        Mon, 11 Mar 2019 18:44:50 -0700 (PDT)
Received: from [192.168.3.111] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C3EB3F575;
        Mon, 11 Mar 2019 18:44:48 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: fix potential bug
To:     John Gong <johngong0791@gmail.com>, christoffer.dall@arm.com
Cc:     Shengmin Gong <shengmin.gong@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Jia He <hejianet@gmail.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <20190312003243.6712-1-johngong0791@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <2405014d-9370-c0d5-7a44-7ec336098c45@arm.com>
Date:   Tue, 12 Mar 2019 01:42:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190312003243.6712-1-johngong0791@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 00:32, John Gong wrote:
Hi,

> Since intid always >= VGIC_NR_PRIVATE_IRQS,

How so? The PMU and the arch timer emulation use PPIs, so intid is
definitely < VGIC_NR_PRIVATE_IRQS there.

> so then even vcpu == NULL, it never return -EINVAL.

I am not sure I follow.
To uniquely identify an SPI interrupt, we just need the interrupt ID
(which is always >= 32). For PPIs and SGIs, we additionally need the
vCPU ID this private interrupt belongs to, as there are multiple
interrupts with the same INTID (one per VCPU).
The VCPU ID passed in for SPIs is just a dummy value (because we use the
same function to inject private and shared interrupts), so we don't need
to check for its validity.

Cheers,
Andre.

> 
> Signed-off-by: Shengmin Gong <shengmin.gong@gmail.com>
> Signed-off-by: John Gong <johngong0791@gmail.com>
> ---
>  virt/kvm/arm/vgic/vgic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> index abd9c7352677..d3cb1ce880e2 100644
> --- a/virt/kvm/arm/vgic/vgic.c
> +++ b/virt/kvm/arm/vgic/vgic.c
> @@ -424,7 +424,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
>  		return ret;
>  
>  	vcpu = kvm_get_vcpu(kvm, cpuid);
> -	if (!vcpu && intid < VGIC_NR_PRIVATE_IRQS)
> +	if (!vcpu)
>  		return -EINVAL;
>  
>  	irq = vgic_get_irq(kvm, vcpu, intid);
> 

