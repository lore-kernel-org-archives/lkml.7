Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F5B206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GYZbe9No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfLPOhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:37:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UW5nLIkQq/WHlCEQJIhKlW+UPR/jh81A7kAlxP4grRw=; b=GYZbe9No74+1PSaR6Y16fcaN5
        Nwxr9v0xvEf83FT7Ezp36q4be2v08XnZM3wofF4ByxlHxXTFBrSfJmaUX47IOSGzquSrHrS0qDALe
        F8Ozh8t6L88xTjEX45iHq6WCK3Qj89D9gXChEVCwHY2+50e8Wm5Rp+KSnuOaDpQpvHMU6RKwlgAz4
        QsmPK2qZQJTwinLcdnnsZX8zVdOJc7Q7eyG0w9rHFnyOpC/GTVjese1kPGUOUWl7tdSGLW50dR41I
        hWWj65wICtUAzbSA/bYrwg7z28iqvP2Ji+gDY02LgMnb5mdq5iauuQAHewgn7RFlHio2VGcIlVvuW
        31aZwns+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igrVH-0007xt-VK; Mon, 16 Dec 2019 14:37:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49EA4301747;
        Mon, 16 Dec 2019 15:36:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79D112B2A1915; Mon, 16 Dec 2019 15:37:42 +0100 (CET)
Date:   Mon, 16 Dec 2019 15:37:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 3/7] Add infrastructure to store and update
 instantaneous thermal pressure
Message-ID: <20191216143742.GS2844@hirez.programming.kicks-ass.net>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-4-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-4-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:11:44PM -0500, Thara Gopinath wrote:
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 8a0fae9..90b18c3 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -16,6 +16,9 @@
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>  
> +/* Replace task scheduler's defalut thermal pressure retrieve API */
> +#define arch_scale_thermal_capacity topology_get_thermal_pressure

Witsness the previously observed confusion.

>  #else
>  
>  static inline void init_cpu_topology(void) { }
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index a4d945d..ccb277b 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -25,6 +25,9 @@ int pcibus_to_node(struct pci_bus *bus);
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>  
> +/* Replace task scheduler's defalut thermal pressure retrieve API */
> +#define arch_scale_thermal_capacity topology_get_thermal_pressure
> +
>  #include <asm-generic/topology.h>
>  
>  #endif /* _ASM_ARM_TOPOLOGY_H */
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1eb81f11..3a91379 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -42,6 +42,19 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  	per_cpu(cpu_scale, cpu) = capacity;
>  }
>  
> +DEFINE_PER_CPU(unsigned long, thermal_pressure);
> +
> +void arch_set_thermal_pressure(struct cpumask *cpus,
> +			       unsigned long capped_capacity)
> +{
> +	int cpu;
> +	unsigned long delta = arch_scale_cpu_capacity(cpumask_first(cpus)) -
> +					capped_capacity;
> +
> +	for_each_cpu(cpu, cpus)
> +		WRITE_ONCE(per_cpu(thermal_pressure, cpu), delta);
> +}

Not a capacity.

>  static ssize_t cpu_capacity_show(struct device *dev,
>  				 struct device_attribute *attr,
>  				 char *buf)
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 3015ecb..7a04364 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -33,6 +33,17 @@ unsigned long topology_get_freq_scale(int cpu)
>  	return per_cpu(freq_scale, cpu);
>  }
>  
> +DECLARE_PER_CPU(unsigned long, thermal_pressure);
> +
> +static inline
> +unsigned long topology_get_thermal_pressure(int cpu)
> +{
> +	return per_cpu(thermal_pressure, cpu);
> +}
