Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB2DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EAB205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEVhWDoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfHMPkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:40:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37009 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfHMPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:40:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so47768131ljn.4;
        Tue, 13 Aug 2019 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=grRxknooNSCd8hm27khhdzHAI12l4taNDmLzaqAQyQI=;
        b=kEVhWDoO+B+Ku5M+8OzOpU5xxN+3Sp7BqONI7OL8AmaXZbaEP7hKctLtk7CXodnRBp
         WRJS+2njmLt5fHpbBhD1G6Vk6KCup177ml2I77ZceGXNjgvVG8ew3t7eWtVgqoB+W7J/
         rbyhWa11rAJLHfETT9TQvJv2eZymHUipqR4ZoaPjtdDeCDSso+xPqoKxoiSxk5xbxc7T
         oJvD4sbfxo34ekgH62QI+mhEAh1nkUsGrVgKj7sjz82y/I0SORFP3btgnQO2SRSQqMU+
         MIAla2B045s/LzcfViAjmZh+vlSkfG381DGKzwnaD/qrDU3UuQHNOBZzH4hhHD41EZbI
         nyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grRxknooNSCd8hm27khhdzHAI12l4taNDmLzaqAQyQI=;
        b=N2njeLeNeIz/QTYqnU3dKdY4MtQ1eFmAYk+qSjh2modiX88WKo8I4H7yrZWBdv2C2J
         mRD+fpPi4sYZ8hhKZZnvPtfChl2yKeBoQ9GY7SgMRLI+p+kqmChbi7GYAzweFOiNPW2f
         F+MaePuyBtcLecVrCrU1bx1RsSeO2qbpVjGOHN5/H8xP+TlNBEEcl6UqFghhUSeY+YRI
         H0Sj8RBqaOBybobSg5Gtpod92+SszrLQbzJZfH6vLElLHFKq/p9/qSke2ynhUa+ruv/z
         1vkvCrWsQkjSquez0E+vUaicPNpPTTJVRlMdH1kCKG8wsOUVbdp7kd7VNTK79udP6fHs
         LPlg==
X-Gm-Message-State: APjAAAVHwPkCJ2Hj+YNBBc3kyKqq2kNvijzQ3SRYvkRW33OrDVia90G6
        2SEBSRslZ0QasDHXW1xzCB/6x1kN
X-Google-Smtp-Source: APXvYqxAFOz1NUVs/mdjkn/UnN+U+n+li/AQArfgSUv1WWxJXV4ZtcwT26+LgyVk/W+37FCM6Cb8xw==
X-Received: by 2002:a2e:b0c6:: with SMTP id g6mr11530171ljl.60.1565710829780;
        Tue, 13 Aug 2019 08:40:29 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id i9sm19783873lfl.10.2019.08.13.08.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 08:40:28 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] irqchip/tegra: Clean up coding style
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190811183044.13925-1-digetx@gmail.com>
 <20190811183044.13925-2-digetx@gmail.com> <86a7cdnmpx.wl-maz@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4fbc5a90-e110-b020-15d3-c4bbe81b15cc@gmail.com>
Date:   Tue, 13 Aug 2019 18:40:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <86a7cdnmpx.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.08.2019 17:50, Marc Zyngier пишет:
> On Sun, 11 Aug 2019 19:30:44 +0100,
> Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Make coding style to conform to the kernel's standard by fixing checkpatch
>> warnings about "line over 80 characters".
> 
> The last time I used a VT100 was about 30 years ago. I still think
> this was one of the most brilliant piece of equipment DEC ever
> produced, but I replaced it at the time with a Wyse 50 that had a 132
> column mode. But even then, I could make my XTerm as wide as I wanted,
> and things haven't regressed much since.
> 
> More seriously, I don't consider the 80 column limit a hard one, and
> I'm pretty happy with code that spans more that 80 columns if that
> allows to read an expression without messing with the flow.

Usually I have multiple source files opened side-by-side and the view sizes are tuned for 80
chars, it messes at least my flow when something goes over 80 chars.

>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/irqchip/irq-tegra.c | 15 +++++----------
>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
>> index 14dcacc2ad38..f829a5990dae 100644
>> --- a/drivers/irqchip/irq-tegra.c
>> +++ b/drivers/irqchip/irq-tegra.c
>> @@ -74,7 +74,7 @@ static struct tegra_ictlr_info *lic;
>>  
>>  static inline void tegra_ictlr_write_mask(struct irq_data *d, unsigned long reg)
>>  {
>> -	void __iomem *base = (void __iomem __force *)d->chip_data;
>> +	void __iomem *base = lic->base[d->hwirq / 32];
> 
> (1) This is an undocumented change

In my opinion this is a very trivial change and then the end result is absolutely the same,
hence nothing to document here. Just read the code, I'd say.

> (2) Why do you think that moving from a per-interrupt base that is
>     known at setup time to something that has to be recomputed on each
>     and every access is a good thing?

I think that there is no practical difference and the new variant is a bit more obvious and
readable.

> 
>>  	u32 mask;
>>  
>>  	mask = BIT(d->hwirq % 32);
>> @@ -142,7 +142,8 @@ static int tegra_ictlr_suspend(void)
>>  		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
>>  
>>  		/* Enable the wakeup sources of ictlr */
>> -		writel_relaxed(lic->ictlr_wake_mask[i], ictlr + ICTLR_CPU_IER_SET);
>> +		writel_relaxed(lic->ictlr_wake_mask[i],
>> +			       ictlr + ICTLR_CPU_IER_SET);
>>  	}
>>  	local_irq_restore(flags);
>>  
>> @@ -222,7 +223,6 @@ static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
>>  {
>>  	struct irq_fwspec *fwspec = data;
>>  	struct irq_fwspec parent_fwspec;
>> -	struct tegra_ictlr_info *info = domain->host_data;
>>  	irq_hw_number_t hwirq;
>>  	unsigned int i;
>>  
>> @@ -235,13 +235,9 @@ static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
>>  	if (hwirq >= (num_ictlrs * 32))
>>  		return -EINVAL;
>>  
>> -	for (i = 0; i < nr_irqs; i++) {
>> -		int ictlr = (hwirq + i) / 32;
>> -
>> +	for (i = 0; i < nr_irqs; i++)
>>  		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> -					      &tegra_ictlr_chip,
>> -					      (void __force *)info->base[ictlr]);
>> -	}
>> +					      &tegra_ictlr_chip, NULL);
>>  
>>  	parent_fwspec = *fwspec;
>>  	parent_fwspec.fwnode = domain->parent->fwnode;
>> @@ -312,7 +308,6 @@ static int __init tegra_ictlr_init(struct device_node *node,
>>  	     "%pOF: Found %u interrupt controllers in DT; expected %u.\n",
>>  	     node, num_ictlrs, soc->num_ictlrs);
>>  
>> -
>>  	domain = irq_domain_add_hierarchy(parent_domain, 0, num_ictlrs * 32,
>>  					  node, &tegra_ictlr_domain_ops,
>>  					  lic);
>> -- 
>> 2.22.0
>>
> 

