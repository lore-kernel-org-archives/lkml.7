Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FD5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2821220B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbfHFKPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:15:41 -0400
Received: from foss.arm.com ([217.140.110.172]:59898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFKPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:15:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F8A4337;
        Tue,  6 Aug 2019 03:15:40 -0700 (PDT)
Received: from [10.1.25.155] (summers-iphone.cambridge.arm.com [10.1.25.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25B1B3F694;
        Tue,  6 Aug 2019 03:15:37 -0700 (PDT)
Subject: Re: [PATCH v2 10/12] irqchip/gic-v3: Warn about inconsistent
 implementations of extended ranges
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-11-maz@kernel.org>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <e5512fcc-e24e-c29a-8a57-011d194e3c41@arm.com>
Date:   Tue, 6 Aug 2019 11:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806100121.240767-11-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 8/6/19 11:01 AM, Marc Zyngier wrote:
> As is it usual for the GIC, it isn't disallowed to put together a system
> that is majorly inconsistent, with a distributor supporting the
> extended ranges while some of the CPUs don't.
> 
> Kindly tell the user that things are sailing isn't going to be smooth.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3.c       | 5 +++++
>  include/linux/irqchip/arm-gic-v3.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index f53e58d398ba..334a10d9dbfb 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1014,6 +1014,11 @@ static void gic_cpu_init(void)
>  
>  	gic_enable_redist(true);
>  
> +	WARN((gic_data.ppi_nr > 16 || GIC_ESPI_NR != 0) &&
> +	     !(gic_read_ctlr() & ICC_CTLR_EL1_ExtRange),
> +	     "Distributor has extended ranges, but CPU%d doesn't\n",
> +	     smp_processor_id());
> +

Should such setup be tainted?

Cheers
Vladimir

>  	rbase = gic_data_rdist_sgi_base();
>  
>  	/* Configure SGIs/PPIs as non-secure Group-1 */
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 9ec3349dee04..5cc10cf7cb3e 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -496,6 +496,7 @@
>  #define ICC_CTLR_EL1_A3V_SHIFT		15
>  #define ICC_CTLR_EL1_A3V_MASK		(0x1 << ICC_CTLR_EL1_A3V_SHIFT)
>  #define ICC_CTLR_EL1_RSS		(0x1 << 18)
> +#define ICC_CTLR_EL1_ExtRange		(0x1 << 19)
>  #define ICC_PMR_EL1_SHIFT		0
>  #define ICC_PMR_EL1_MASK		(0xff << ICC_PMR_EL1_SHIFT)
>  #define ICC_BPR0_EL1_SHIFT		0
> 

