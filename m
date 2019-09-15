Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1382EC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD0B214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfIORbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:31:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37626 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIORbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:31:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so18417384pfo.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 10:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7jPP6uykt4djIujvVe4JcrX0jlYqFug5SZAhTUjC5fU=;
        b=tSWnir8REfrbz8owEt4o08WRWadX/sBcdtFmT2lwUaqNdOi9eEJvkMuS5xVSKVfcKg
         U5WHLONyflrXoRAofJvIdDQcoOLLAv98/kzlMwIl8njbe08ms9Tl8GoKzpxqJ4PsCD+W
         mzDn5/B+Rh7GTd1OFVvM4opz8cwSsKnvCN2TGggw3XHGeIyV/X/avTBsG0mhBryNcKkN
         QE5g+EsnOqriTuq+fpCJDOQgBSX0ZsDEgWikMxY1RW3s0UT/a2bKT5AplEWMe7SOrEwe
         TTDwWjnHGY+1MoOoNA67O4SEGcwpqtcvQPFg/fTvMthVYSS9QjSlzKsCvfQoRRMX3D/9
         VhqA==
X-Gm-Message-State: APjAAAU8GckDAoC8KFqpj4Dk+rcKKvYAqvWIz9fT9g/wnfWqbwG2qfRU
        vj96cHTWffL0Lk1f52f9sA+jNQ==
X-Google-Smtp-Source: APXvYqxq4EUBJIPAKXGYmJQK33mno/KylCwPXwHyaZL5QhyHScTMRF7BDzUNvZe0BZ0iCjoNHBkFrg==
X-Received: by 2002:a63:1521:: with SMTP id v33mr9263997pgl.9.1568568694021;
        Sun, 15 Sep 2019 10:31:34 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id s24sm28979930pgm.3.2019.09.15.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 10:31:33 -0700 (PDT)
Date:   Sun, 15 Sep 2019 10:31:33 -0700 (PDT)
X-Google-Original-Date: Sun, 15 Sep 2019 10:18:16 PDT (-0700)
Subject:     Re: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
In-Reply-To: <8636gxskmj.wl-maz@kernel.org>
CC:     Darius Rad <darius@bluespec.com>, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     maz@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        David Johnson <davidj@sifive.com>
Message-ID: <mhng-8de39ab4-730a-4ded-a8b5-d50f34d1697b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2019 07:24:20 PDT (-0700), maz@kernel.org wrote:
> On Thu, 12 Sep 2019 22:40:34 +0100,
> Darius Rad <darius@bluespec.com> wrote:
>
> Hi Darius,
>
>> 
>> As per the existing comment, irq_mask and irq_unmask do not need
>> to do anything for the PLIC.  However, the functions must exist
>> (the pointers cannot be NULL) as they are not optional, based on
>> the documentation (Documentation/core-api/genericirq.rst) as well
>> as existing usage (e.g., include/linux/irqchip/chained_irq.h).
>> 
>> Signed-off-by: Darius Rad <darius@bluespec.com>
>> ---
>>  drivers/irqchip/irq-sifive-plic.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index cf755964f2f8..52d5169f924f 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -111,6 +111,13 @@ static void plic_irq_disable(struct irq_data *d)
>>  	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
>>  }
>>  
>> +/*
>> + * There is no need to mask/unmask PLIC interrupts.  They are "masked"
>> + * by reading claim and "unmasked" when writing it back.
>> + */
>> +static void plic_irq_mask(struct irq_data *d) { }
>> +static void plic_irq_unmask(struct irq_data *d) { }
>
> This outlines a bigger issue. If your irqchip doesn't require
> mask/unmask, you're probably not using the right interrupt
> flow. Looking at the code, I see you're using handle_simple_irq, which
> is almost universally wrong.
>
> As per the description above, these interrupts should be using the
> fasteoi flow, which is designed for this exact behaviour (the
> interrupt controller knows which interrupt is in flight and doesn't
> require SW to do anything bar signalling the EOI).
>
> Another thing is that mask/unmask tends to be a requirement, while
> enable/disable tends to be optional. There is no hard line here, but
> the expectations are that:
>
> (a) A disabled line can drop interrupts
> (b) A masked line cannot drop interrupts
>
> Depending what the PLIC architecture mandates, you'll need to
> implement one and/or the other. Having just (a) is indicative of a HW
> bug, and I'm not assuming that this is the case. (b) only is pretty
> common, and (a)+(b) has a few adepts. My bet is that it requires (b)
> only.
>
>> +
>>  #ifdef CONFIG_SMP
>>  static int plic_set_affinity(struct irq_data *d,
>>  			     const struct cpumask *mask_val, bool force)
>> @@ -138,12 +145,10 @@ static int plic_set_affinity(struct irq_data *d,
>>  
>>  static struct irq_chip plic_chip = {
>>  	.name		= "SiFive PLIC",
>> -	/*
>> -	 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
>> -	 * by reading claim and "unmasked" when writing it back.
>> -	 */
>>  	.irq_enable	= plic_irq_enable,
>>  	.irq_disable	= plic_irq_disable,
>> +	.irq_mask	= plic_irq_mask,
>> +	.irq_unmask	= plic_irq_unmask,
>>  #ifdef CONFIG_SMP
>>  	.irq_set_affinity = plic_set_affinity,
>>  #endif
>
> Can you give the following patch a go? It brings the irq flow in line
> with what the HW can do. It is of course fully untested (not even
> compile tested...).
>
> Thanks,
>
> 	M.
>
> From c0ce33a992ec18f5d3bac7f70de62b1ba2b42090 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Sun, 15 Sep 2019 15:17:45 +0100
> Subject: [PATCH] irqchip/sifive-plic: Switch to fasteoi flow
>
> The SiFive PLIC interrupt controller seems to have all the HW
> features to support the fasteoi flow, but the driver seems to be
> stuck in a distant past. Bring it into the 21st century.

Thanks.  We'd gotten these comments during the review process but nobody had 
gotten the time to actually fix the issues.

>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index cf755964f2f8..8fea384d392b 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -97,7 +97,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
>  	}
>  }
>  
> -static void plic_irq_enable(struct irq_data *d)
> +static void plic_irq_mask(struct irq_data *d)
>  {
>  	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
>  					   cpu_online_mask);
> @@ -106,7 +106,7 @@ static void plic_irq_enable(struct irq_data *d)
>  	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
>  }
>  
> -static void plic_irq_disable(struct irq_data *d)
> +static void plic_irq_unmask(struct irq_data *d)
>  {
>  	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
>  }
> @@ -125,10 +125,8 @@ static int plic_set_affinity(struct irq_data *d,
>  	if (cpu >= nr_cpu_ids)
>  		return -EINVAL;
>  
> -	if (!irqd_irq_disabled(d)) {
> -		plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
> -		plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
> -	}
> +	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
> +	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
>  
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  
> @@ -136,14 +134,18 @@ static int plic_set_affinity(struct irq_data *d,
>  }
>  #endif
>  
> +static void plic_irq_eoi(struct irq_data *d)
> +{
> +	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +
> +	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +}
> +
>  static struct irq_chip plic_chip = {
>  	.name		= "SiFive PLIC",
> -	/*
> -	 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
> -	 * by reading claim and "unmasked" when writing it back.
> -	 */
> -	.irq_enable	= plic_irq_enable,
> -	.irq_disable	= plic_irq_disable,
> +	.irq_mask	= plic_irq_mask,
> +	.irq_unmask	= plic_irq_unmask,
> +	.irq_eoi	= plic_irq_eoi,
>  #ifdef CONFIG_SMP
>  	.irq_set_affinity = plic_set_affinity,
>  #endif
> @@ -152,7 +154,7 @@ static struct irq_chip plic_chip = {
>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>  			      irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_and_handler(irq, &plic_chip, handle_simple_irq);
> +	irq_set_chip_and_handler(irq, &plic_chip, handle_fasteoi_irq);
>  	irq_set_chip_data(irq, NULL);
>  	irq_set_noprobe(irq);
>  	return 0;
> @@ -188,7 +190,6 @@ static void plic_handle_irq(struct pt_regs *regs)
>  					hwirq);
>  		else
>  			generic_handle_irq(irq);
> -		writel(hwirq, claim);
>  	}
>  	csr_set(sie, SIE_SEIE);
>  }
> -- 
> 2.20.1
>
>
> -- 
> Jazz is not dead, it just smells funny.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Tested-by: Palmer Dabbelt <palmer@sifive.com> (QEMU Boot)

We should test them on the hardware, but I don't have any with me right now.  
David's probably in the best spot to do this, as he's got a setup that does all 
the weird interrupt sources (ie, PCIe).

David: do you mind testing this?  I've put the patch here:

    ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
    -b plic-fasteoi
