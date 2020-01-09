Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92DFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C992072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgAIUCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:02:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgAIUCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:02:24 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipe0b-0007HG-KY; Thu, 09 Jan 2020 21:02:21 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 20AA7105BCE; Thu,  9 Jan 2020 21:02:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel-managed IRQ affinity (cont)
In-Reply-To: <20191219161115.GA18672@ming.t460p>
References: <20191216195712.GA161272@xz-x1> <20191219082819.GB15731@ming.t460p> <20191219143214.GA50561@xz-x1> <20191219161115.GA18672@ming.t460p>
Date:   Thu, 09 Jan 2020 21:02:20 +0100
Message-ID: <87eew8l7oz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming,

Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Dec 19, 2019 at 09:32:14AM -0500, Peter Xu wrote:
>> ... this one seems to be more appealing at least to me.
>
> OK, please try the following patch:
>
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 6c8512d3be88..0fbcbacd1b29 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -13,6 +13,7 @@ enum hk_flags {
>  	HK_FLAG_TICK		= (1 << 4),
>  	HK_FLAG_DOMAIN		= (1 << 5),
>  	HK_FLAG_WQ		= (1 << 6),
> +	HK_FLAG_MANAGED_IRQ	= (1 << 7),
>  };
>  
>  #ifdef CONFIG_CPU_ISOLATION
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 1753486b440c..0a75a09cc4e8 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/task.h>
>  #include <uapi/linux/sched/types.h>
>  #include <linux/task_work.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "internals.h"
>  
> @@ -212,12 +213,33 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  {
>  	struct irq_desc *desc = irq_data_to_desc(data);
>  	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	const struct cpumask *housekeeping_mask =
> +		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
>  	int ret;
> +	cpumask_var_t tmp_mask;
>  
>  	if (!chip || !chip->irq_set_affinity)
>  		return -EINVAL;
>  
> -	ret = chip->irq_set_affinity(data, mask, force);
> +	if (!zalloc_cpumask_var(&tmp_mask, GFP_KERNEL))
> +		return -EINVAL;

That's wrong. This code is called with interrupts disabled, so
GFP_KERNEL is wrong. And NO, we won't do a GFP_ATOMIC allocation here.

> +	/*
> +	 * Userspace can't change managed irq's affinity, make sure
> +	 * that isolated CPU won't be selected as the effective CPU
> +	 * if this irq's affinity includes both isolated CPU and
> +	 * housekeeping CPU.
> +	 *
> +	 * This way guarantees that isolated CPU won't be interrupted
> +	 * by IO submitted from housekeeping CPU.
> +	 */
> +	if (irqd_affinity_is_managed(data) &&
> +			cpumask_intersects(mask, housekeeping_mask))
> +		cpumask_and(tmp_mask, mask, housekeeping_mask);

This is duct tape engineering with absolutely no semantics. I can't even
figure out the intent of this 'managed_irq' parameter.

If the intent is to keep managed device interrupts away from isolated
cores then you really want to do that when the interrupts are spread and
not in the middle of the affinity setter code.

But first you need to define how that mask should work:

 1) Exclude CPUs from managed interrupt spreading completely

 2) Exclude CPUs only when the resulting spreading contains
    housekeeping CPUs

 3) Whatever ...

Thanks,

        tglx


