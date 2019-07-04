Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FFCC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D586921852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfGDHNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:13:55 -0400
Received: from foss.arm.com ([217.140.110.172]:35324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfGDHNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:13:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 419DE344;
        Thu,  4 Jul 2019 00:13:54 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5063F703;
        Thu,  4 Jul 2019 00:15:46 -0700 (PDT)
Subject: Re: [PATCH] genirq: update irq stats from NMI handlers
To:     Shijith Thotton <sthotton@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
References: <1562214115-14022-1-git-send-email-sthotton@marvell.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <6adfb296-50f1-9efb-0840-cc8732b8ebf9@arm.com>
Date:   Thu, 4 Jul 2019 08:13:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1562214115-14022-1-git-send-email-sthotton@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shijith,

On 04/07/2019 05:22, Shijith Thotton wrote:
> The NMI handlers handle_percpu_devid_fasteoi_nmi() and
> handle_fasteoi_nmi() added by commit 2dcf1fbcad35 ("genirq: Provide NMI
> handlers") do not update the interrupt counts. Due to that the NMI
> interrupt count does not show up correctly in /proc/interrupts.
> 
> Update the functions to fix this. With this change, we can see stats of
> the perf NMI interrupts on arm64.
> 
> Fixes: 2dcf1fbcad35 ("genirq: Provide NMI handlers")
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  kernel/irq/chip.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 29d6c7d070b4..88d1e054c6ea 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -748,6 +748,8 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
>  	unsigned int irq = irq_desc_get_irq(desc);
>  	irqreturn_t res;
>  
> +	kstat_incr_irqs_this_cpu(desc);
> +

This needs to be called with the desc lock taken, otherwise we're likely
to corrupt desc->tot_count.
But taking the desc lock is something we can't do in NMI context (
*spin_lock_irq*() won't prevent an NMI from happening).

>  	trace_irq_handler_entry(irq, action);
>  	/*
>  	 * NMIs cannot be shared, there is only one action.
> @@ -962,6 +964,8 @@ void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
>  	unsigned int irq = irq_desc_get_irq(desc);
>  	irqreturn_t res;
>  
> +	__kstat_incr_irqs_this_cpu(desc);
> +

Looking at handle_percpu_irq(), I think this might be acceptable. But
does it make sense to only have kstats for percpu NMIs?

Cheers,

-- 
Julien Thierry
