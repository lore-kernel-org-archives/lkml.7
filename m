Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A7C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A822086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfEMIhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:37:13 -0400
Received: from foss.arm.com ([217.140.101.70]:48842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfEMIhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:37:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1CBA15AB;
        Mon, 13 May 2019 01:37:11 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35F063F7B7;
        Mon, 13 May 2019 01:37:10 -0700 (PDT)
Date:   Mon, 13 May 2019 09:37:04 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <marc.zyngier@arm.com>, <eric.auger@redhat.com>,
        <drjones@redhat.com>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] irqchip/gic-v3: Correct the usage of GICD_CTLR's
 RWP field
Message-ID: <20190513093704.0b293de0@donnerap.cambridge.arm.com>
In-Reply-To: <1557720954-6592-1-git-send-email-yuzenghui@huawei.com>
References: <1557720954-6592-1-git-send-email-yuzenghui@huawei.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 04:15:54 +0000
Zenghui Yu <yuzenghui@huawei.com> wrote:

Hi,

> As per ARM IHI 0069D, GICD_CTLR's RWP field tracks updates to:
> 
> 	GICD_CTLR's Group Enable bits, for transitions from 1 to 0 only
> 	GICD_CTLR's ARE bits, E1NWF bit and DS bit (if we have)
> 	GICD_ICENABLER<n>
> 
> We seemed use this field in an inappropriate way, somewhere in the
> GIC-v3 driver. For some examples:
> 
> In gic_set_affinity(), if the interrupt was not enabled, we only need
> to write GICD_IROUTER<n> with the appropriate mpidr value. Updates to
> GICD_IROUTER will not be tracked by RWP field, and we can remove the
> unnecessary RWP waiting.

I am not sure this is the proper fix, see below inline.

> In gic_dist_init(), we "Enable distributor with ARE, Group1" by writing
> to GICD_CTLR, and we should use gic_dist_wait_for_rwp() here.

That looks reasonable, yes.

> These two are obvious cases, and there are some other cases where we don't
> need to do RWP waiting, such as in gic_configure_irq() and gic_poke_irq().
> But too many modifications makes me not confident. It's hard for me to say
> whether this patch is doing the right thing and how does the RWP waiting
> affect the system, thus RFC.

So did you actually see a problem, and this patch fixes it? Or was this
just discovered by code inspection and comparing to the spec?

> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 15e55d3..8d63950 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -600,6 +600,7 @@ static void __init gic_dist_init(void)
>  	/* Enable distributor with ARE, Group1 */
>  	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A |
> GICD_CTLR_ENABLE_G1, base + GICD_CTLR);
> +	gic_dist_wait_for_rwp();
>  
>  	/*
>  	 * Set all global interrupts to the boot CPU only. ARE must be
> @@ -986,14 +987,9 @@ static int gic_set_affinity(struct irq_data *d,
> const struct cpumask *mask_val, 
>  	gic_write_irouter(val, reg);
>  
> -	/*
> -	 * If the interrupt was enabled, enabled it again. Otherwise,
> -	 * just wait for the distributor to have digested our changes.
> -	 */
> +	/* If the interrupt was enabled, enabled it again. */
>  	if (enabled)
>  		gic_unmask_irq(d);
> -	else
> -		gic_dist_wait_for_rwp();

I think you are right in this is not needed here.
But I guess this call belongs further up in this function, after the
gic_mask_irq() call, as this one writes to GICD_ICENABLER. So in case this
IRQ was enabled, we should wait for the distributor to have properly
disabled it, before changing its affinity.

Cheers,
Andre.

>  
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  

