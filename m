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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60980C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F9F2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scbsmQ0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbfHVPGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:06:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54364 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387585AbfHVPGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:06:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so5984798wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f86P8y/bEfM/LNm6Gbw7F3VV00jAjdLsjnLP2BnusNc=;
        b=scbsmQ0WsynE3+iucma4KyewlPzagmL8m2e+Vw3n14Ka/qE8yDTPPOgkqQ4P3KVupS
         iLQaFvVXRrGyoWIoNVpsYKLIuBT/VCISpIxNC9ho5vujFyDe8aGgfXAqnZaI4rQeVeyD
         ApcXU0K8njsXPPJaYSQe0sg+H4axC7fc6HfNzC8gixRIu7ZQ3X+hNXhlNGxjTeqT99Tm
         9aIwFeMiD/81EmrqSVWz0Z3elzu/qtfedT0jBmsRXYvfgNvmlm4lMh3fmcuYMiEuXKZH
         IaUVssJHmKuRHM6ltwkzcoIWxyeMr9+NmID3NjpaiFJSxi+fwR1jphgOQVTRsg2Qbo1i
         yVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f86P8y/bEfM/LNm6Gbw7F3VV00jAjdLsjnLP2BnusNc=;
        b=GExVF9ETbdp4rdABEI1F05lA52hlchwQKQNKcQzrE6RPkB0RNQ2HhHiOl6tYcEK55M
         Iuf/9sJFTFpl2B1Vy5vYsEcbvOm5UqtkosURbLP55IBEoHCNhWzRoKH8hwqZHgIXj5wH
         uMMSv7WFadGPMKfIiI+0g38v43rsEnu85tecwAMksAufINz4IaJL5/j/ptbHaStoTUzL
         AhR04eK9qb1lkQwDUbHuW/Zz37Ay8PZ/h+13BdCE0vNpZR80yPZrcziraE0xnP19mwVb
         F3tL1dgf/ZUlPVQkiWxREopl5xODFzmbgn/08v3ldTiKzcn3vuqU6XG6lOJC6XHbss6u
         elWg==
X-Gm-Message-State: APjAAAVG8ecdACRW4Jri9zo3iiGK0IA13nsp0UPKh1p1aYLoEUrIms4U
        ZfG/P13VoeeGNIyO3Jm3kyI=
X-Google-Smtp-Source: APXvYqxVvx/3YX34Q402BNXkpuBssIZCO1hsFVIgEgim/PhREvq2JCRoX+bq1Bvv0/3KTPAFdW/2+w==
X-Received: by 2002:a1c:a701:: with SMTP id q1mr6801047wme.72.1566486358273;
        Thu, 22 Aug 2019 08:05:58 -0700 (PDT)
Received: from [192.168.1.67] (host81-157-241-155.range81-157.btcentralplus.com. [81.157.241.155])
        by smtp.gmail.com with ESMTPSA id b4sm3541836wma.5.2019.08.22.08.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:05:57 -0700 (PDT)
Subject: Re: [PATCH v2 06/12] irqchip/gic-v3: Dynamically allocate PPI NMI
 refcounts
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
 <20190806100121.240767-7-maz@kernel.org>
From:   Julien <julien.thierry.kdev@gmail.com>
Message-ID: <daa0ff03-cf73-e1de-b4b2-d1382c5d5548@gmail.com>
Date:   Thu, 22 Aug 2019 16:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190806100121.240767-7-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 06/08/19 11:01, Marc Zyngier wrote:
> As we're about to have a variable number of PPIs, let's make the
> allocation of the NMI refcounts dynamic. Also apply some minor
> cleanups (moving things around).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Julien Thierry <julien.thierry.kdev@gmail.com>

Thanks,

> ---
>   drivers/irqchip/irq-gic-v3.c | 47 ++++++++++++++++++++++++++----------
>   1 file changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index e03fb6d7c2ce..4253c7f67c86 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -88,7 +88,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>   static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
>   
>   /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
> -static refcount_t ppi_nmi_refs[16];
> +static refcount_t *ppi_nmi_refs;
>   
>   static struct gic_kvm_info gic_v3_kvm_info;
>   static DEFINE_PER_CPU(bool, has_rss);
> @@ -409,6 +409,16 @@ static void gic_irq_set_prio(struct irq_data *d, u8 prio)
>   	writeb_relaxed(prio, base + offset + index);
>   }
>   
> +static u32 gic_get_ppi_index(struct irq_data *d)
> +{
> +	switch (get_intid_range(d)) {
> +	case PPI_RANGE:
> +		return d->hwirq - 16;
> +	default:
> +		unreachable();
> +	}
> +}
> +
>   static int gic_irq_nmi_setup(struct irq_data *d)
>   {
>   	struct irq_desc *desc = irq_to_desc(d->irq);
> @@ -429,10 +439,12 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>   		return -EINVAL;
>   
>   	/* desc lock should already be held */
> -	if (gic_irq(d) < 32) {
> +	if (gic_irq_in_rdist(d)) {
> +		u32 idx = gic_get_ppi_index(d);
> +
>   		/* Setting up PPI as NMI, only switch handler for first NMI */
> -		if (!refcount_inc_not_zero(&ppi_nmi_refs[gic_irq(d) - 16])) {
> -			refcount_set(&ppi_nmi_refs[gic_irq(d) - 16], 1);
> +		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
> +			refcount_set(&ppi_nmi_refs[idx], 1);
>   			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
>   		}
>   	} else {
> @@ -464,9 +476,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
>   		return;
>   
>   	/* desc lock should already be held */
> -	if (gic_irq(d) < 32) {
> +	if (gic_irq_in_rdist(d)) {
> +		u32 idx = gic_get_ppi_index(d);
> +
>   		/* Tearing down NMI, only switch handler for last NMI */
> -		if (refcount_dec_and_test(&ppi_nmi_refs[gic_irq(d) - 16]))
> +		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
>   			desc->handle_irq = handle_percpu_devid_irq;
>   	} else {
>   		desc->handle_irq = handle_fasteoi_irq;
> @@ -1394,7 +1408,19 @@ static void gic_enable_nmi_support(void)
>   {
>   	int i;
>   
> -	for (i = 0; i < 16; i++)
> +	if (!gic_prio_masking_enabled())
> +		return;
> +
> +	if (gic_has_group0() && !gic_dist_security_disabled()) {
> +		pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
> +		return;
> +	}
> +
> +	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
> +	if (!ppi_nmi_refs)
> +		return;
> +
> +	for (i = 0; i < gic_data.ppi_nr; i++)
>   		refcount_set(&ppi_nmi_refs[i], 0);
>   
>   	static_branch_enable(&supports_pseudo_nmis);
> @@ -1472,12 +1498,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>   			gicv2m_init(handle, gic_data.domain);
>   	}
>   
> -	if (gic_prio_masking_enabled()) {
> -		if (!gic_has_group0() || gic_dist_security_disabled())
> -			gic_enable_nmi_support();
> -		else
> -			pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
> -	}
> +	gic_enable_nmi_support();
>   
>   	return 0;
>   
> 

-- 
Julien Thierry
