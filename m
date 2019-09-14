Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DD0C4CECA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C5B20830
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfINTAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:00:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38733 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfINTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:00:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id w10so3618037plq.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 12:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OFiiJYwXSRXINvUze1d4KfmURKJMOMB0TZAHUxFChKg=;
        b=qSoaRn0uaGeslazp6ByoAbL402HQmXJOO19f1Pmu4g27CQkrYBiRhqmYTyewjKuTh1
         9aDMOP1kMB7hb9hNLbV7+6uBLDkThdJxnGUMMqgfabk4doh/gwI7s2NTk2hZfeMH7b+z
         bMHYJUKRJKjd01GzSxF55XMQcw/L9oVU4WiDCA1toqD0VclGQDIBsgKveB9Jo9BDSRQy
         8TZvGH1Z1dfrAtbMOdmOU4hI7iNurQpk5AW+FIgn1oLfvB1QxyRD5nBmeyBi8mOH5gZs
         isyhUqJGctRSM22xY60FArcb91kg1zATnw2+HAS4OfQLOW2ApI0vrMxrFHwzJyJDjCfG
         yfCg==
X-Gm-Message-State: APjAAAXnxcFsSHa4gNfTTJOhccZAx7HOzptrvUpu5rVCuVs881sv13ky
        InGcY6QqBgPgmSd+Ejr+DYrA6g==
X-Google-Smtp-Source: APXvYqwCAZIGEJCOA0b/9T/YR7nXDut4D/Hkv2inKbJ3jCXen5H++uow94dW28QTx1kGUiJX/cXH7Q==
X-Received: by 2002:a17:902:8488:: with SMTP id c8mr52750200plo.164.1568487613263;
        Sat, 14 Sep 2019 12:00:13 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id u24sm41073974pgk.31.2019.09.14.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 12:00:12 -0700 (PDT)
Date:   Sat, 14 Sep 2019 12:00:12 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 11:50:32 PDT (-0700)
Subject:     Re: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
In-Reply-To: <529ec882-734f-17ae-e4cb-3aeb563ad1d5@bluespec.com>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Darius Rad <darius@bluespec.com>
Message-ID: <mhng-c06cc89b-42d9-4f95-b090-2db96628d5fb@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019 14:40:34 PDT (-0700), Darius Rad wrote:
> As per the existing comment, irq_mask and irq_unmask do not need
> to do anything for the PLIC.  However, the functions must exist
> (the pointers cannot be NULL) as they are not optional, based on
> the documentation (Documentation/core-api/genericirq.rst) as well
> as existing usage (e.g., include/linux/irqchip/chained_irq.h).
>
> Signed-off-by: Darius Rad <darius@bluespec.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index cf755964f2f8..52d5169f924f 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -111,6 +111,13 @@ static void plic_irq_disable(struct irq_data *d)
>  	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
>  }
>
> +/*
> + * There is no need to mask/unmask PLIC interrupts.  They are "masked"
> + * by reading claim and "unmasked" when writing it back.
> + */
> +static void plic_irq_mask(struct irq_data *d) { }
> +static void plic_irq_unmask(struct irq_data *d) { }
> +
>  #ifdef CONFIG_SMP
>  static int plic_set_affinity(struct irq_data *d,
>  			     const struct cpumask *mask_val, bool force)
> @@ -138,12 +145,10 @@ static int plic_set_affinity(struct irq_data *d,
>
>  static struct irq_chip plic_chip = {
>  	.name		= "SiFive PLIC",
> -	/*
> -	 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
> -	 * by reading claim and "unmasked" when writing it back.
> -	 */
>  	.irq_enable	= plic_irq_enable,
>  	.irq_disable	= plic_irq_disable,
> +	.irq_mask	= plic_irq_mask,
> +	.irq_unmask	= plic_irq_unmask,
>  #ifdef CONFIG_SMP
>  	.irq_set_affinity = plic_set_affinity,
>  #endif

I can't find any other drivers in irqchip with empty irq_mask/irq_unmask.  I'm 
not well versed in irqchip stuff, so I'll leave it up to the irqchip 
maintainers to comment on if this is the right way to do this.  Either way, I'm 
assuming it'll go in through some the irqchip tree so

Acked-by: Palmer Dabbelt <palmer@sifive.com>

just to make sure I don't get in the way if it is the right way to do it :).
