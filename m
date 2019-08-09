Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9378BC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A01C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565348186;
	bh=R4cd2pp/xDVF2g/e7p9YqVn0zoNkJww09non3Fn36/A=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Wbl2NggiatHM5OKeabjEQsYMYISZPQMbdzQTspzf5a3NvqBpw0zJEQNz0mTxdCj7v
	 Zhla9aVhKajNdDvLKK4QI3VlARi6Hn3vjHeeAVf6GlwD3UNCGD+A8h8LRl7PiwaRwM
	 kUUaNw2vgyoxSOv2lQCFRdYDVsq6A4dsH92mYfbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406437AbfHIK4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:56:25 -0400
Received: from foss.arm.com ([217.140.110.172]:45416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406078AbfHIK4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:56:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15F3B1596;
        Fri,  9 Aug 2019 03:56:24 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60D033F575;
        Fri,  9 Aug 2019 03:56:22 -0700 (PDT)
Subject: Re: [PATCH 06/19] irqchip/mmp: add missing chained_irq_{enter,exit}()
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
        linux-clk@vger.kernel.org
References: <20190809093158.7969-1-lkundrak@v3.sk>
 <20190809093158.7969-7-lkundrak@v3.sk>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <319ebbbc-2231-42c9-faec-731ad81eb485@kernel.org>
Date:   Fri, 9 Aug 2019 11:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809093158.7969-7-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 10:31, Lubomir Rintel wrote:
> The lack of chained_irq_exit() leaves the muxed interrupt masked on MMP3.
> For reasons unknown this is not a problem on MMP2.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/irqchip/irq-mmp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> index af9cba4a51c2e..cd8d2253f56d1 100644
> --- a/drivers/irqchip/irq-mmp.c
> +++ b/drivers/irqchip/irq-mmp.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> @@ -132,11 +133,14 @@ struct irq_chip icu_irq_chip = {
>  static void icu_mux_irq_demux(struct irq_desc *desc)
>  {
>  	unsigned int irq = irq_desc_get_irq(desc);
> +	struct irq_chip *chip = irq_get_chip(irq);

Consider using irq_desc_get_chip() instead, which avoids going through
the irq->desc again.

>  	struct irq_domain *domain;
>  	struct icu_chip_data *data;
>  	int i;
>  	unsigned long mask, status, n;
>  
> +	chained_irq_enter(chip, desc);
> +
>  	for (i = 1; i < max_icu_nr; i++) {
>  		if (irq == icu_data[i].cascade_irq) {
>  			domain = icu_data[i].domain;
> @@ -146,7 +150,7 @@ static void icu_mux_irq_demux(struct irq_desc *desc)
>  	}
>  	if (i >= max_icu_nr) {
>  		pr_err("Spurious irq %d in MMP INTC\n", irq);
> -		return;
> +		goto out;
>  	}
>  
>  	mask = readl_relaxed(data->reg_mask);
> @@ -158,6 +162,9 @@ static void icu_mux_irq_demux(struct irq_desc *desc)
>  			generic_handle_irq(icu_data[i].virq_base + n);
>  		}
>  	}
> +
> +out:
> +	chained_irq_exit(chip, desc);
>  }
>  
>  static int mmp_irq_domain_map(struct irq_domain *d, unsigned int irq,
> 

Otherwise looks OK.

	M.
-- 
Jazz is not dead, it just smells funny...
