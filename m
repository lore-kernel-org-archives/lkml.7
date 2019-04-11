Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C53C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B2A2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZSGkUQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDKQTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:19:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34812 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:19:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so8174884wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yJJue+e+IO7F6Bkj7d9J6uPt/CaJhI8uLBaY1Yg2FE0=;
        b=BZSGkUQGp1ZJIpVTOa4r/YRmFOTW2j5IBhi7p+2tHNPyPev/LvbcEHrLq9hlJfPi4E
         YPbdGIZ9lm58Xtl/nyrYMLGqhX9VytaPCE92ZcDOchpUjGWYvdG213p7gceN2C2rzrby
         d4e2NHNJuDC96mWOgDpknFAcYSMDHAcPD30/OUMUT3drEmsjjnaSw+ef479eECIe/vPE
         nTDwGaCNRKNGRG59vfjJGS/mus83ANU0Kz/Iltilh6F8j6eBut1EZSefTYz2P5buE1vY
         +gh7AcRBAtkoEHVA9lDeEtuelHHuPrCq0SavoDLDFF/bg4p0COx2qwkeYEayUCbnL+BE
         j07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yJJue+e+IO7F6Bkj7d9J6uPt/CaJhI8uLBaY1Yg2FE0=;
        b=cOEdIHArGsh/48dCVepmUTLTieb9KCFbKn+k5FEhPDZi5be6uKR0wYfiFXI4tNuBbn
         xuw7lfJC0RWrX/As2XBg15qblzD8tnfoOtnMGMbyvdSxjtdej7ObXf5Jg8AOFw9p3KvS
         +BMgndeUQNxM1FdZOiIwHMfgFLbCuMAbcpUIyQNwtOl2UtGEGxJ1xlWaaGq7dIDCGlr4
         5rH+CXEN++ZYPepOYnhpOLtr/PTdPhziHEIMJGTjUAVOde2ECBoesf0zZmkmVr8BvjQ8
         ZUJnT1SCUacnOqZcpcXFJYxc1ZvaBh/xnqw9eiblUMOBGwJZojKrS4CdoaEH6QdRr4f6
         PL3A==
X-Gm-Message-State: APjAAAUsGUqrKEj7HKNw/x8ZxQaHQDqn0PJo822eq8QZ9h4HCOhqg7Vc
        Cp7kfDoLdcaJGUvHmiLuMH33cA==
X-Google-Smtp-Source: APXvYqw+J+SDJiMnEuErgSPRP7gceslV36bxtV5oOzNCNxzZAGjGPjTSEtQ03Z/XEPFD1ozSRUjjGQ==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr4045582wrw.71.1554999576164;
        Thu, 11 Apr 2019 09:19:36 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id r30sm124450448wrr.46.2019.04.11.09.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:19:35 -0700 (PDT)
Subject: Re: [PATCH 04/12] clocksource/drivers/tcb_clksrc: stop depending on
 atmel_tclib
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-5-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7ce7342d-7fa2-d2b0-621d-2c47a0e5cdba@linaro.org>
Date:   Thu, 11 Apr 2019 18:19:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403141120.32754-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 16:11, Alexandre Belloni wrote:
> atmel_tclib is probed too late in the boot process to be able to use the
> TCB as the boot clocksource. This is an issue for SoCs without the PIT
> (sams70, samv70 and samv71 families) as they simply currently can't boot.
> 
> Get rid of the atmel_tclib dependency and probe everything on our own using
> the correct device tree binding.
> 
> This also allows getting rid of ATMEL_TCB_CLKSRC_BLOCK and makes the driver
> a bit more flexible as the TCB is not hardcoded in the kernel anymore.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/clocksource/tcb_clksrc.c | 103 +++++++++++++++++++------------
>  drivers/misc/Kconfig             |  14 +----
>  2 files changed, 66 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index 138a12090149..c7eec9808289 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -9,7 +9,8 @@
>  #include <linux/err.h>
>  #include <linux/ioport.h>
>  #include <linux/io.h>
> -#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/syscore_ops.h>
>  #include <soc/at91/atmel_tcb.h>
>  
> @@ -28,13 +29,6 @@
>   *     source, used in either periodic or oneshot mode.  This runs
>   *     at 32 KiHZ, and can handle delays of up to two seconds.
>   *
> - * A boot clocksource and clockevent source are also currently needed,
> - * unless the relevant platforms (ARM/AT91, AVR32/AT32) are changed so
> - * this code can be used when init_timers() is called, well before most
> - * devices are set up.  (Some low end AT91 parts, which can run uClinux,
> - * have only the timers in one TC block... they currently don't support
> - * the tclib code, because of that initialization issue.)
> - *
>   * REVISIT behavior during system suspend states... we should disable
>   * all clocks and save the power.  Easily done for clockevent devices,
>   * but clocksources won't necessarily get the needed notifications.
> @@ -112,7 +106,6 @@ void tc_clksrc_resume(struct clocksource *cs)
>  }
>  
>  static struct clocksource clksrc = {
> -	.name           = "tcb_clksrc",
>  	.rating         = 200,
>  	.read           = tc_get_cycles,
>  	.mask           = CLOCKSOURCE_MASK(32),
> @@ -214,7 +207,6 @@ static int tc_next_event(unsigned long delta, struct clock_event_device *d)
>  
>  static struct tc_clkevt_device clkevt = {
>  	.clkevt	= {
> -		.name			= "tc_clkevt",
>  		.features		= CLOCK_EVT_FEAT_PERIODIC |
>  					  CLOCK_EVT_FEAT_ONESHOT,
>  		/* Should be lower than at91rm9200's system timer */
> @@ -330,33 +322,64 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
>  	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
>  }
>  
> -static int __init tcb_clksrc_init(void)
> +static int __init tcb_clksrc_init(struct device_node *node)
>  {
> -	static char bootinfo[] __initdata
> -		= KERN_DEBUG "%s: tc%d at %d.%03d MHz\n";
> -
> -	struct platform_device *pdev;
> -	struct atmel_tc *tc;
> +	struct atmel_tc tc;
>  	struct clk *t0_clk;
> +	const struct of_device_id *match;
> +	int irq;
>  	u32 rate, divided_rate = 0;
>  	int best_divisor_idx = -1;
>  	int clk32k_divisor_idx = -1;
>  	int i;
>  	int ret;
>  
> -	tc = atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
> -	if (!tc) {
> -		pr_debug("can't alloc TC for clocksource\n");
> -		return -ENODEV;
> -	}
> -	tcaddr = tc->regs;
> -	pdev = tc->pdev;
> +	/* Protect against multiple calls */
> +	if (tcaddr)
> +		return 0;
> +
> +	tc.regs = of_iomap(node->parent, 0);
> +	if (!tc.regs)
> +		return -ENXIO;
> +
> +	t0_clk = of_clk_get_by_name(node->parent, "t0_clk");
> +	if (IS_ERR(t0_clk))
> +		return PTR_ERR(t0_clk);
> +
> +	tc.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
> +	if (IS_ERR(tc.slow_clk))
> +		return PTR_ERR(tc.slow_clk);
> +
> +	irq = of_irq_get(node->parent, 0);
> +	if (irq <= 0)
> +		return -EINVAL;
> +
> +	tc.clk[0] = t0_clk;
> +	tc.clk[1] = of_clk_get_by_name(node->parent, "t1_clk");
> +	if (IS_ERR(tc.clk[1]))
> +		tc.clk[1] = t0_clk;
> +	tc.clk[2] = of_clk_get_by_name(node->parent, "t2_clk");
> +	if (IS_ERR(tc.clk[2]))
> +		tc.clk[2] = t0_clk;
> +	tc.irq[0] = irq;
> +	tc.irq[1] = of_irq_get(node->parent, 1);
> +	if (tc.irq[1] <= 0)
> +		tc.irq[1] = irq;
> +	tc.irq[2] = of_irq_get(node->parent, 2);
> +	if (tc.irq[2] <= 0)
> +		tc.irq[2] = irq;

Why are clk[1/2] and irq[1/2] defaulting back to t0 in case of error?


[ ... ]



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

