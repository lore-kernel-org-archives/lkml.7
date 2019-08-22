Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F59C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC1421743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGLofpNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbfHVQLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:11:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45243 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731582AbfHVQL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:11:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so5939983wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WOLXM4xnMFVlUdch1z2qt+dH7SvetoRUB1nh7ILEzLo=;
        b=tGLofpNBmcpASXCyYQUE04zbFx8m0Z/y0veSwyQqisIX3/bbhBvFF7OXpd08qeOzI/
         ZlLf48LbCuVVHqpeAAmvxPEk6cVUSIzSYJCszZr9QT1RtCtBdn76arhc0DU1WBX4GzYW
         UItgJn8tIm9gkeHtkPybMBfm0s/x/7VJLXlDTkPxcz3VjEUdVN49frWItLnjWiJG5y7V
         YcFUtXkvKDAzv2rEFrUSY8I7/XA8TtV4jNlABdlSK2YrjNg6oBJGQTn+niHzTdSkRVq2
         EVaHhnataaraXJiH9V+td1ywrZMGqpYrVvntdnZUbLJYaf+ioYEhctTOgPhpF7gEEDyV
         xnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WOLXM4xnMFVlUdch1z2qt+dH7SvetoRUB1nh7ILEzLo=;
        b=lhlwKPgtgNvTU8j8EH8PBXU9fNihBmWavuH2g3dmRe+oJvy0iepS/YWmHj38bcGPcN
         oh2AZRy19PtxYtvSau9TW20hObUfq+A9xNFGHEjr2FRWEIVRwM+jHlRZisO+4qXWknhE
         nwF2BheSy9/DJO1ydD6pPvsr63tKfN55szhGLiJRDfMoFv7Fi89hg8wYY36gSdjtrY13
         D66FwAY23a+Xxm51GMnqlZAWlRtleSNu3d6WlVRAJqgc7LYDZSbDGGGbiRbGA5fHzIeL
         HTktF1jzJHzU+9W3Vc/Wlgzn+TjErZEW5LpmEEvBQrlGPpid+JPRPffPHZPzG4mb5Ryw
         aZcA==
X-Gm-Message-State: APjAAAV8TqvpiHK9Nk+zTBLNq0tvRRAuHQebX7gMuuAU+MMkrC5SymW3
        UYCiLVIlpzb2iyw0cGljNcw=
X-Google-Smtp-Source: APXvYqyDq/eLLXqjbCOrQ1WMMAgAphtlW/ZMl5pwttqfYEyK5zWHbaqVDumW8k93uBQ7q0WRR1PYrQ==
X-Received: by 2002:a5d:480e:: with SMTP id l14mr47231857wrq.96.1566490286927;
        Thu, 22 Aug 2019 09:11:26 -0700 (PDT)
Received: from [192.168.1.67] (host81-157-241-155.range81-157.btcentralplus.com. [81.157.241.155])
        by smtp.gmail.com with ESMTPSA id x6sm47988wrt.63.2019.08.22.09.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:11:26 -0700 (PDT)
Subject: Re: [PATCH v2 05/12] irqchip/gic: Prepare for more than 16 PPIs
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-6-maz@kernel.org>
From:   Julien <julien.thierry.kdev@gmail.com>
Message-ID: <1b2675f6-f839-80f8-b7d8-a7d402085745@gmail.com>
Date:   Thu, 22 Aug 2019 17:11:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190806100121.240767-6-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 06/08/19 11:01, Marc Zyngier wrote:
> GICv3.1 allows up to 80 PPIs (16 legaci PPIs and 64 Extended PPIs),
> meaning we can't just leave the old 16 hardcoded everywhere.
> 
> We also need to add the infrastructure to discover the number of PPIs
> on a per redistributor basis, although we still pretend there is only
> 16 of them for now.
> 
> No functional change.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-common.c | 19 ++++++++++++-------
>   drivers/irqchip/irq-gic-common.h |  2 +-
>   drivers/irqchip/irq-gic-v3.c     | 22 +++++++++++++++-------
>   drivers/irqchip/irq-gic.c        |  2 +-
>   drivers/irqchip/irq-hip04.c      |  2 +-
>   5 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
> index 6900b6f0921c..14110db01c05 100644
> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -128,26 +128,31 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
>   		sync_access();
>   }
>   
> -void gic_cpu_config(void __iomem *base, void (*sync_access)(void))
> +void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
>   {
>   	int i;
>   
>   	/*
>   	 * Deal with the banked PPI and SGI interrupts - disable all
> -	 * PPI interrupts, ensure all SGI interrupts are enabled.
> -	 * Make sure everything is deactivated.
> +	 * private interrupts. Make sure everything is deactivated.
>   	 */
> -	writel_relaxed(GICD_INT_EN_CLR_X32, base + GIC_DIST_ACTIVE_CLEAR);
> -	writel_relaxed(GICD_INT_EN_CLR_PPI, base + GIC_DIST_ENABLE_CLEAR);
> -	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
> +	for (i = 0; i < nr; i += 32) {

You added "nr" as argument but if "nr" isn't a multiple of 32 weird 
things might happen, no?

It would be worth specifying that somewhere, and checking it with a WARN().

Maybe it might be worth reducing the granularity to manipulating 16 irqs 
since there are 16 SGI + 16 PPI + 64 EPPI, but that might not be very 
useful right now.

Cheers,

Julien

> +		writel_relaxed(GICD_INT_EN_CLR_X32,
> +			       base + GIC_DIST_ACTIVE_CLEAR + i / 8);
> +		writel_relaxed(GICD_INT_EN_CLR_X32,
> +			       base + GIC_DIST_ENABLE_CLEAR + i / 8);
> +	}
>   
>   	/*
>   	 * Set priority on PPI and SGI interrupts
>   	 */
> -	for (i = 0; i < 32; i += 4)
> +	for (i = 0; i < nr; i += 4)
>   		writel_relaxed(GICD_INT_DEF_PRI_X4,
>   					base + GIC_DIST_PRI + i * 4 / 4);
>   
> +	/* Ensure all SGI interrupts are now enabled */
> +	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
> +
>   	if (sync_access)
>   		sync_access();
>   }
> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> index 5a46b6b57750..ccba8b0fe0f5 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -22,7 +22,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>                          void __iomem *base, void (*sync_access)(void));
>   void gic_dist_config(void __iomem *base, int gic_irqs,
>   		     void (*sync_access)(void));
> -void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
> +void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void));
>   void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>   		void *data);
>   void gic_enable_of_quirks(const struct device_node *np,
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 1ca4dde32034..e03fb6d7c2ce 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -51,6 +51,7 @@ struct gic_chip_data {
>   	u32			nr_redist_regions;
>   	u64			flags;
>   	bool			has_rss;
> +	unsigned int		ppi_nr;
>   	struct partition_desc	*ppi_descs[16];
>   };
>   
> @@ -812,19 +813,24 @@ static int gic_populate_rdist(void)
>   	return -ENODEV;
>   }
>   
> -static int __gic_update_vlpi_properties(struct redist_region *region,
> -					void __iomem *ptr)
> +static int __gic_update_rdist_properties(struct redist_region *region,
> +					 void __iomem *ptr)
>   {
>   	u64 typer = gic_read_typer(ptr + GICR_TYPER);
>   	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
>   	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
> +	gic_data.ppi_nr = 16;
>   
>   	return 1;
>   }
>   
> -static void gic_update_vlpi_properties(void)
> +static void gic_update_rdist_properties(void)
>   {
> -	gic_iterate_rdists(__gic_update_vlpi_properties);
> +	gic_data.ppi_nr = UINT_MAX;
> +	gic_iterate_rdists(__gic_update_rdist_properties);
> +	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
> +		gic_data.ppi_nr = 0;
> +	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
>   	pr_info("%sVLPI support, %sdirect LPI support\n",
>   		!gic_data.rdists.has_vlpis ? "no " : "",
>   		!gic_data.rdists.has_direct_lpi ? "no " : "");
> @@ -968,6 +974,7 @@ static int gic_dist_supports_lpis(void)
>   static void gic_cpu_init(void)
>   {
>   	void __iomem *rbase;
> +	int i;
>   
>   	/* Register ourselves with the rest of the world */
>   	if (gic_populate_rdist())
> @@ -978,9 +985,10 @@ static void gic_cpu_init(void)
>   	rbase = gic_data_rdist_sgi_base();
>   
>   	/* Configure SGIs/PPIs as non-secure Group-1 */
> -	writel_relaxed(~0, rbase + GICR_IGROUPR0);
> +	for (i = 0; i < gic_data.ppi_nr + 16; i += 32)
> +		writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
>   
> -	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
> +	gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
>   
>   	/* initialise system registers */
>   	gic_cpu_sys_reg_init();
> @@ -1449,7 +1457,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>   
>   	set_handle_irq(gic_handle_irq);
>   
> -	gic_update_vlpi_properties();
> +	gic_update_rdist_properties();
>   
>   	gic_smp_init();
>   	gic_dist_init();
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index ab48760acabb..25c1ae69db30 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -543,7 +543,7 @@ static int gic_cpu_init(struct gic_chip_data *gic)
>   				gic_cpu_map[i] &= ~cpu_mask;
>   	}
>   
> -	gic_cpu_config(dist_base, NULL);
> +	gic_cpu_config(dist_base, 32, NULL);
>   
>   	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
>   	gic_cpu_if_up(gic);
> diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
> index 1626131834a6..130caa1c9d93 100644
> --- a/drivers/irqchip/irq-hip04.c
> +++ b/drivers/irqchip/irq-hip04.c
> @@ -273,7 +273,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
>   		if (i != cpu)
>   			hip04_cpu_map[i] &= ~cpu_mask;
>   
> -	gic_cpu_config(dist_base, NULL);
> +	gic_cpu_config(dist_base, 32, NULL);
>   
>   	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
>   	writel_relaxed(1, base + GIC_CPU_CTRL);
> 

-- 
Julien Thierry
