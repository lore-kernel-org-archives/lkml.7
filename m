Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D720AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0C922CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567008142;
	bh=pmFShqiGOPaZAwzKDUIhM37wWW87B9gBKhfun8dIi78=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=VfYUg9+AW+7ozQf3hwDE0GpASvP782IJCWMseNOZbwjuLuJQRKyf2WkZu/lSd06gG
	 KU8LXc+67VJsGYF8KuhhauFrJZ8YChaM7GBuAD2yHgSB/kxe9S2hjTKU3YxaaH2sJC
	 9BV59/FWXSCowqnrSlwF0H33o6XVwaZtT7bHlkiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfH1QCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:02:22 -0400
Received: from foss.arm.com ([217.140.110.172]:33666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfH1QCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:02:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E32C028;
        Wed, 28 Aug 2019 09:02:20 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A84DE3F59C;
        Wed, 28 Aug 2019 09:02:19 -0700 (PDT)
Subject: Re: [PATCH 04/13] irqchip: Add driver for Loongson-3 I/O interrupt
 controller
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, chenhc@lemote.com,
        paul.burton@mips.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.co, devicetree@vger.kernel.org
References: <20190827085302.5197-1-jiaxun.yang@flygoat.com>
 <20190827085302.5197-5-jiaxun.yang@flygoat.com>
 <e6a5862f-0f6c-cab0-9f4a-51b7889d38e7@kernel.org>
 <82c4b9ed-7270-74ce-6e10-165182e540dd@flygoat.com>
 <20190828075940.549e1983@why>
 <619b1d35-7bc2-999f-5a51-fb2efdc63f60@flygoat.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <45615c1a-7af8-3496-5369-4b2f174a76e7@kernel.org>
Date:   Wed, 28 Aug 2019 17:02:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <619b1d35-7bc2-999f-5a51-fb2efdc63f60@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 16:31, Jiaxun Yang wrote:
> 
> On 2019/8/28 下午2:59, Marc Zyngier wrote:
>> On Wed, 28 Aug 2019 08:27:05 +0800
>> Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>
>>> On 2019/8/28 上午12:45, Marc Zyngier wrote:
>>>> On 27/08/2019 09:52, Jiaxun Yang wrote:
>>>>> +	chained_irq_enter(chip, desc);
>>>>> +
>>>>> +	pending = readl(priv->intc_base + LS3_REG_INTC_EN_STATUS) &
>>>>> +		readl(priv->intc_base + LS3_REG_INTC_STATUS);
>>>> Reading the enabled status from the HW on each interrupt? I'm sure
>>>> that's pretty cheap...
>>> Seems expensive but to deal with a buggy hardware... That's worthy.
>> How broken is it? You very much seem to rely on the HW being correct
>> here, since you trust it exclusively. I'd expect the enable mask to be
>> a SW construct if you didn't blindly trust it
> Hi Marc
> 
> Thanks for your answering.
> 
> The vendor code did this and said there is a HW issue. I just don't have 
> the guts to remove this check.
> Seems like sometimes masked interrupt may get ISR set wrongly.

And that would just as well avoided by a SW managed mask.

>> And if this is truly the right way to do it, please document the
>> various problems with the controller so that we don't break it at a
>> later time.
> Thanks, will do.
>>
>> Then how comes this comes from the irqchip's DT node? This should be
>> part of the endpoint's interrupt specifier.
> 
> In theory it should be, However if we set different interrupt 
> lines/cores on that controller, interrupts may get lost. It means we can 
> only have single parent core/interrupt.
> 
> So I'd prefer just set them uniformly by controller's dt-binding to 
> prevent confusing.

And I disagree. You can document the restriction, and even maybe enforce
it by validating the DT one way or another. But we're not putting what
ends up being a routing table in the irqchip binding.

	M.
-- 
Jazz is not dead, it just smells funny...
