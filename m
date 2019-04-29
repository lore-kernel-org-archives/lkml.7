Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066E1C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C883421473
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfD2JQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:16:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42404 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbfD2JQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:16:24 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hL2Ob-0004En-W7
        for linux-kernel@vger.kernel.org; Mon, 29 Apr 2019 09:16:22 +0000
Received: by mail-pg1-f199.google.com with SMTP id l13so6895433pgp.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 02:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1vBVQBSQaK0ivjDWZNWqu8SXOnL5ZygG/J+bF2HLTJs=;
        b=sS6mpWZMYko6XFby7ikP8MCri+DDs4X9AeHGTFiaQ8A9oSO8P+7LcdxqteaAg0KNcb
         9reHAhENXXx8ZMsnzzSWQwyZ4BpeolYdcask54jQW1vhl2PGi2im43rQkQzjod6Sj1E9
         T83vMgq9/7CdNDh2ribOxUFSTbh1+KMtGUSY0fQb5xONlw7+JefKhtZd2BG/6496eloV
         eJCM37cnY02etHsQ9OOR8OWn93Kvahw67BhcTjV/CBibq5GOkxbuif4br7v+j6Ru50cz
         w/iCIHEeU2EW01i0r7jWWo+/SrxJC6vdKlijBOqFSPy2rO0SKvgdZVaD8i2pCexc7hsK
         gbrQ==
X-Gm-Message-State: APjAAAUV1qlqYmMv/Ftwsh4Id6nCCwDUeDBpmg7O0MVlAHg1mG4gbfKa
        amtsFMDGdk3a8szAqrZPNmMdNwDNjzH8JbzRdkBAmdN3i3J/NbUcsjKyxpfrkez7R5UqAROZ1wG
        7VCkmQkNx+gAjcbfFqObY3GVVfFgr1QU7YZOto5mfpA==
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr57315649plt.1.1556529380731;
        Mon, 29 Apr 2019 02:16:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9XpO1CeaEcjEEhjhsFZff8FIsuKve2mo/JyFPlSC/H3qRTN5B3xh7+JxXzybE2gVR/l0Djw==
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr57315617plt.1.1556529380409;
        Mon, 29 Apr 2019 02:16:20 -0700 (PDT)
Received: from 2001-b011-380f-14b9-d9ab-9ff9-92fc-2609.dynamic-ip6.hinet.net (2001-b011-380f-14b9-d9ab-9ff9-92fc-2609.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:d9ab:9ff9:92fc:2609])
        by smtp.gmail.com with ESMTPSA id f63sm55095222pfc.180.2019.04.29.02.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 02:16:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] pinctrl: intel: Clear interrupt status in unmask callback
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190426214758.GC9224@smile.fi.intel.com>
Date:   Mon, 29 Apr 2019 17:16:16 +0800
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        hotwater438@tutanota.com, hdegoede@redhat.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6BCF9C55-E365-4638-8030-99EBA348F8D4@canonical.com>
References: <20190422044539.16085-1-kai.heng.feng@canonical.com>
 <20190426214758.GC9224@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 05:47, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 22, 2019 at 12:45:39PM +0800, Kai-Heng Feng wrote:
>> Commit a939bb57cd47 ("pinctrl: intel: implement gpio_irq_enable") was
>> added because clearing interrupt status bit is required to avoid
>> unexpected behavior.
>>
>> Turns out the unmask callback also needs the fix, which can solve weird
>> IRQ triggering issues on I2C touchpad ELAN1200.
>
>> -static void intel_gpio_irq_enable(struct irq_data *d)
>> -{
>> -	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> -	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
>> -	const struct intel_community *community;
>> -	const struct intel_padgroup *padgrp;
>> -	int pin;
>> -
>> -	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
>> -	if (pin >= 0) {
>> -		unsigned int gpp, gpp_offset, is_offset;
>> -		unsigned long flags;
>> -		u32 value;
>> -
>> -		gpp = padgrp->reg_num;
>> -		gpp_offset = padgroup_offset(padgrp, pin);
>> -		is_offset = community->is_offset + gpp * 4;
>> -
>> -		raw_spin_lock_irqsave(&pctrl->lock, flags);
>> -		/* Clear interrupt status first to avoid unexpected interrupt */
>> -		writel(BIT(gpp_offset), community->regs + is_offset);
>> -
>> -		value = readl(community->regs + community->ie_offset + gpp * 4);
>> -		value |= BIT(gpp_offset);
>> -		writel(value, community->regs + community->ie_offset + gpp * 4);
>> -		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>> -	}
>> -}
>> -
>>  static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
>>  {
>>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> @@ -963,6 +934,11 @@ static void intel_gpio_irq_mask_unmask(struct  
>> irq_data *d, bool mask)
>>  		reg = community->regs + community->ie_offset + gpp * 4;
>>
>>  		raw_spin_lock_irqsave(&pctrl->lock, flags);
>> +
>> +		/* Clear interrupt status first to avoid unexpected interrupt */
>
>> +		if (!mask)
>
> Can we do this unconditionally?

Yes I think so.

>
>> +			writel(BIT(gpp_offset), community->regs +  
>> community->is_offset + gpp * 4);
>
> I would rather prefer to follow the below pattern, like
>
> reg = ...;
> writel(..., reg);
>
> or, to decrease calculus under spin lock, something like
>
> reg = ->regs + gpp * 4;
>
> writel(..., reg + is_offset);
>
> readl(reg + ie_offset);
>
> etc.

Ok, will do.

>
>> +
>>  		value = readl(reg);
>>  		if (mask)
>>  			value &= ~BIT(gpp_offset);
>> @@ -1106,7 +1082,6 @@ static irqreturn_t intel_gpio_irq(int irq, void  
>> *data)
>>
>>  static struct irq_chip intel_gpio_irqchip = {
>>  	.name = "intel-gpio",
>
>> -	.irq_enable = intel_gpio_irq_enable,
>
> Is it possible scenario when IRQ enable is called, but not masking  
> callbacks?
> For _AEI or GPE?

I am unfamiliar with both of them, what are the callbacks to be used for  
_AEI and GPE case?
Seems like both gpiolib and irqchip call irq_unmask() when irq_enable() is  
absent.

Kai-Heng

>
>> .irq_ack = intel_gpio_irq_ack,
>>  	.irq_mask = intel_gpio_irq_mask,
>>  	.irq_unmask = intel_gpio_irq_unmask,
>
> -- 
> With Best Regards,
> Andy Shevchenko


