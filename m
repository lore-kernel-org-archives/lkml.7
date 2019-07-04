Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD44BC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C23F218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfGDQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:19:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59558 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDQTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:19:23 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4S8-0005Xs-96; Thu, 04 Jul 2019 18:19:20 +0200
Date:   Thu, 4 Jul 2019 18:19:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Shijith Thotton <sthotton@marvell.com>
cc:     Julien Thierry <julien.thierry@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] genirq: update irq stats from NMI handlers
In-Reply-To: <a4ce3800-22f4-72dc-6ff8-75dfed1c377b@marvell.com>
Message-ID: <alpine.DEB.2.21.1907041818360.1802@nanos.tec.linutronix.de>
References: <1562214115-14022-1-git-send-email-sthotton@marvell.com> <6adfb296-50f1-9efb-0840-cc8732b8ebf9@arm.com> <a4ce3800-22f4-72dc-6ff8-75dfed1c377b@marvell.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019, Shijith Thotton wrote:
> On 7/4/19 12:13 AM, Julien Thierry wrote:
> > Looking at handle_percpu_irq(), I think this might be acceptable. But
> > does it make sense to only have kstats for percpu NMIs?
> > 
> 
> It would be better to have stats for both.
> 
> handle_fasteoi_nmi() can use __kstat_incr_irqs_this_cpu() if below 
> change can be added to kstat_irqs_cpu().
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index a92b33593b8d..9484e88dabc2 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -950,6 +950,11 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
>                          *per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
>   }
> 
> +static bool irq_is_nmi(struct irq_desc *desc)
> +{
> +       return desc->istate & IRQS_NMI;
> +}
> +
>   /**
>    * kstat_irqs - Get the statistics for an interrupt
>    * @irq:       The interrupt number
> @@ -967,7 +972,8 @@ unsigned int kstat_irqs(unsigned int irq)
>          if (!desc || !desc->kstat_irqs)
>                  return 0;
>          if (!irq_settings_is_per_cpu_devid(desc) &&
> -           !irq_settings_is_per_cpu(desc))
> +           !irq_settings_is_per_cpu(desc) &&
> +           !irq_is_nmi(desc))
>              return desc->tot_count;
> 
>          for_each_possible_cpu(cpu)
> 
> 
> Thomas,
> Please suggest a better way if any.

Looks good.

Thanks,

	tglx
