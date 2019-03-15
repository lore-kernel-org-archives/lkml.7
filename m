Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3440621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfCOIfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:35:36 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:43036 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCOIfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:35:36 -0400
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1h4iJQ-0008Ee-T8; Fri, 15 Mar 2019 08:35:33 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1h4iJP-0000xz-Bp; Fri, 15 Mar 2019 08:35:32 +0000
Subject: Re: [PATCH] um: irq: don't set the chip for all irqs
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190314150344.8555-1-brgl@bgdev.pl>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ebcc2921-9048-9943-331b-6cc5baee95ea@cambridgegreys.com>
Date:   Fri, 15 Mar 2019 08:35:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314150344.8555-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/03/2019 15:03, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Setting a chip for an interrupt marks it as allocated. Since UM doesn't
> support dynamic interrupt numbers (yet), it means we cannot simply
> increase NR_IRQS and then use the free irqs between LAST_IRQ and NR_IRQS
> with gpio-mockup or iio testing drivers as irq_alloc_descs() will fail
> after not being able to neither find an unallocated range of interrupts
> nor expand the range.
> 
> Only call irq_set_chip_and_handler() for irqs until LAST_IRQ.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> Note: I plan to introduce support for SPARSE_IRQ but AFAICT it will be
> a bit more complicated, so in the meantime I'd like to propose this change.
> 
>   arch/um/kernel/irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index f4874b7ec503..598d7b3d9355 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -479,7 +479,7 @@ void __init init_IRQ(void)
>   	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
>   
>   
> -	for (i = 1; i < NR_IRQS; i++)
> +	for (i = 1; i < LAST_IRQ; i++)
>   		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
>   	/* Initialize EPOLL Loop */
>   	os_setup_epoll();
> 

Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
