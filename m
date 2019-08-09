Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967CFC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B39E208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565352775;
	bh=xR5/+eCLl3ujKXGcG3RYBBRhh/uHuFlKJUB6btWgSKE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=2MnOSgP8Hn0ocCYwlh9nqjgS4NuXQq01korBJoMg3Do4a22hsd+E/H6W5XBUO39TV
	 yZjYRO4DWEVfWSU5N43yrH6kUvfPQDYsgdcdLQdbsJYPtZfj2wBpjPNVhih8QsWwMr
	 P7QIqIKwRSnUVorq88/9D5OLUVvIs+3MNjsTfhJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406711AbfHIMMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:12:54 -0400
Received: from foss.arm.com ([217.140.110.172]:46532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfHIMMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:12:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D4A1596;
        Fri,  9 Aug 2019 05:12:52 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6683F706;
        Fri,  9 Aug 2019 05:12:50 -0700 (PDT)
Subject: Re: [PATCH 05/19] irqchip/mmp: do not use of_address_to_resource() to
 get mux regs
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20190809093158.7969-1-lkundrak@v3.sk>
 <20190809093158.7969-6-lkundrak@v3.sk>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <16d77ca3-7ad1-3af2-650e-722cf6a931ed@kernel.org>
Date:   Fri, 9 Aug 2019 13:12:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809093158.7969-6-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 10:31, Lubomir Rintel wrote:
> The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
> are offsets from intc's base, not addresses on the parent bus. At this
> point it probably can't be fixed.
> 
> On an OLPC XO-1.75 machine, the muxes are children of the intc, not the
> axi bus, and thus of_address_to_resource() won't work. We should treat
> the values as mere integers as opposed to bus addresses.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
>  drivers/irqchip/irq-mmp.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> index 14618dc0bd396..af9cba4a51c2e 100644
> --- a/drivers/irqchip/irq-mmp.c
> +++ b/drivers/irqchip/irq-mmp.c
> @@ -424,9 +424,9 @@ IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
>  static int __init mmp2_mux_of_init(struct device_node *node,
>  				   struct device_node *parent)
>  {
> -	struct resource res;
>  	int i, ret, irq, j = 0;
>  	u32 nr_irqs, mfp_irq;
> +	u32 reg[4];
>  
>  	if (!parent)
>  		return -ENODEV;
> @@ -438,18 +438,20 @@ static int __init mmp2_mux_of_init(struct device_node *node,
>  		pr_err("Not found mrvl,intc-nr-irqs property\n");
>  		return -EINVAL;
>  	}
> -	ret = of_address_to_resource(node, 0, &res);
> +
> +	/*
> +	 * For historical reasonsm, the "regs" property of the
> +	 * mrvl,mmp2-mux-intc is not a regular * "regs" property containing
> +	 * addresses on the parent bus, but offsets from the intc's base.
> +	 * That is why we can't use of_address_to_resource() here.
> +	 */
> +	ret = of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));

This will return 0 even if you've read less than your expected 4 u32s.
You may want to try of_property_read_variable_u32_array instead.

>  	if (ret < 0) {
>  		pr_err("Not found reg property\n");
>  		return -EINVAL;
>  	}
> -	icu_data[i].reg_status = mmp_icu_base + res.start;
> -	ret = of_address_to_resource(node, 1, &res);
> -	if (ret < 0) {
> -		pr_err("Not found reg property\n");
> -		return -EINVAL;
> -	}
> -	icu_data[i].reg_mask = mmp_icu_base + res.start;
> +	icu_data[i].reg_status = mmp_icu_base + reg[0];
> +	icu_data[i].reg_mask = mmp_icu_base + reg[2];
>  	icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
>  	if (!icu_data[i].cascade_irq)
>  		return -EINVAL;
> 

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
