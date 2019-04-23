Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 04:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC29520811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 04:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfDWE5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:57:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWE5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 00:57:39 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hInUu-00076f-MY
        for linux-kernel@vger.kernel.org; Tue, 23 Apr 2019 04:57:36 +0000
Received: by mail-pg1-f197.google.com with SMTP id v9so9294688pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 21:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q0RUrB5N4OXLN2rv3Oiee0jxnB5YgC4g1Rx7LrZxleM=;
        b=AsWfKgIF3JtIYPblQJZdW3otDNYU9GWVIJwMRyCprBvqRvaZu74vGCBFSPywf4BZcr
         45TKBmzYNtWdkoA+pm6XyME2eJWBTGp4FfjxcxIGL3ZRmzGzagx+jzHnkjPDfPwrk1Sh
         NzgVxTDnIwcaqbsjYSxt0LXa2wc2fqAd4BRnJZIe070yVEIp68T/exhRd5UwLRV9bDam
         fYI+c7QJSBlNjXl9AehwTrMNmGOrMVhaD7Dqg+ftsXDmJPrS76Y4Y37JNjyK/KxPbpva
         s7dBso8Dm/9PZN3h3AieCqRi1rOBZH/03u7jwpuc1x01MIOUVdsFGdV0wQ3SgDwTBp+b
         ksgQ==
X-Gm-Message-State: APjAAAXbQU+Qu6sm8SGJTaXz4/IQhG0MOKVF1GEU+ZN2TIDQpo32HLye
        OUYKrQIzd9GnuwVKMUhersprps/EDrj9gVkSejzAwEetZhR1B2DD0j5TfiPDdTEAaUv6pG00rFD
        04NsE7W7b34+5gzyaisQPLHva3YL0Do/p+i8a0dAyLA==
X-Received: by 2002:a62:184a:: with SMTP id 71mr24255133pfy.1.1555995455362;
        Mon, 22 Apr 2019 21:57:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNa0hTfHI2SW1HzC6wzeDeiXZgXJ6fySRUhU1ySPXqL0a+oTQBdVzFCdr0N6RMQGzri1DNHw==
X-Received: by 2002:a62:184a:: with SMTP id 71mr24255082pfy.1.1555995454536;
        Mon, 22 Apr 2019 21:57:34 -0700 (PDT)
Received: from 2001-b011-380f-14b9-d015-82d6-2039-7ce9.dynamic-ip6.hinet.net (2001-b011-380f-14b9-d015-82d6-2039-7ce9.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:d015:82d6:2039:7ce9])
        by smtp.gmail.com with ESMTPSA id x66sm37198693pfb.78.2019.04.22.21.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 21:57:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] pinctrl: intel: Clear interrupt status in unmask callback
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Ld5HCy5--3-1@tutanota.com>
Date:   Tue, 23 Apr 2019 12:57:31 +0800
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linus.walleij@linaro.org, Hdegoede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <EA207DE8-E89A-427B-B910-A36170A76031@canonical.com>
References: <20190422044539.16085-1-kai.heng.feng@canonical.com>
 <Ld5HCy5--3-1@tutanota.com>
To:     hotwater438@tutanota.com
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

at 02:22, <hotwater438@tutanota.com> <hotwater438@tutanota.com> wrote:

> Hi.
> I've just applied this patch, and touchpad woorks smoothly, but suspend  
> issue is still present.
> After suspend, i2c_hid module bursts i2c_hid i2c-ELAN1200:00:  
> i2c_hid_get_input: incomplete report (16/65535) messages (more than 50  
> reports/sec).
> In dmesg I can see a frequency of reporting every 0.0007 - 0.001 dmesg  
> time units.

What’s the default suspend mode on the platform?
This is a common issue for system that defaults to Suspend-to-idle, but S3  
is in use.
The root cause is that the power of the touchpad doesn’t get cut off during  
S3 by platform firmware.

Do you also see this issue if S2I is in use?

Kai-Heng

>
> Though I can sucessfully restart module and after restarting it works as  
> good as it was.
>
> So suspend issue is still present.
>
> Regards,
> Vladislav.
>
>
> Apr 22, 2019, 7:45 AM by kai.heng.feng@canonical.com:
> Commit a939bb57cd47 ("pinctrl: intel: implement gpio_irq_enable") was
> added because clearing interrupt status bit is required to avoid
> unexpected behavior.
>
> Turns out the unmask callback also needs the fix, which can solve weird
> IRQ triggering issues on I2C touchpad ELAN1200.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/pinctrl/intel/pinctrl-intel.c | 35 ++++-----------------------
> 1 file changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c  
> b/drivers/pinctrl/intel/pinctrl-intel.c
> index 3b1818184207..53878604537e 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -913,35 +913,6 @@ static void intel_gpio_irq_ack(struct irq_data *d)
> }
> }
>
> -static void intel_gpio_irq_enable(struct irq_data *d)
> -{
> -	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> -	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
> -	const struct intel_community *community;
> -	const struct intel_padgroup *padgrp;
> -	int pin;
> -
> -	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
> -	if (pin >= 0) {
> -	unsigned int gpp, gpp_offset, is_offset;
> -	unsigned long flags;
> -	u32 value;
> -
> -	gpp = padgrp->reg_num;
> -	gpp_offset = padgroup_offset(padgrp, pin);
> -	is_offset = community->is_offset + gpp * 4;
> -
> -	raw_spin_lock_irqsave(&pctrl->lock, flags);
> -	/* Clear interrupt status first to avoid unexpected interrupt */
> -	writel(BIT(gpp_offset), community->regs + is_offset);
> -
> -	value = readl(community->regs + community->ie_offset + gpp * 4);
> -	value |= BIT(gpp_offset);
> -	writel(value, community->regs + community->ie_offset + gpp * 4);
> -	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> -	}
> -}
> -
> static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
> {
> struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> @@ -963,6 +934,11 @@ static void intel_gpio_irq_mask_unmask(struct  
> irq_data *d, bool mask)
> reg = community->regs + community->ie_offset + gpp * 4;
>
> raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> +	/* Clear interrupt status first to avoid unexpected interrupt */
> +	if (!mask)
> +	writel(BIT(gpp_offset), community->regs + community->is_offset +  
> gpp * 4);
> +
> value = readl(reg);
> if (mask)
> value &= ~BIT(gpp_offset);
> @@ -1106,7 +1082,6 @@ static irqreturn_t intel_gpio_irq(int irq, void  
> *data)
>
> static struct irq_chip intel_gpio_irqchip = {
> .name = "intel-gpio",
> -	.irq_enable = intel_gpio_irq_enable,
> .irq_ack = intel_gpio_irq_ack,
> .irq_mask = intel_gpio_irq_mask,
> .irq_unmask = intel_gpio_irq_unmask,
> -- 
> 2.17.1


