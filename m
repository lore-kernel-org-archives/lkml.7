Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF69C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E22A20678
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20150623.gappssmtp.com header.i=@bluespec-com.20150623.gappssmtp.com header.b="R3UkWtcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfIPVlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:41:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41695 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfIPVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:41:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id x4so1743795qtq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uKEk7pcTQOPJj3RB17gVy4JPb5ypaqKNo8RuaGXS238=;
        b=R3UkWtcNWGujD8fkmMhGIDxxKHLAi6mcm39xmmHICtGEIwpUloFA5VYy2KLevUhPkN
         zG2ACU8l2o6Lai7vdCCpJBa7fS2KhdTT4OqRtXRou7Sxq2XzIJCebXnn+7r4c7Bnud8h
         SzXr6SAQGIRdmP06/3/AJSAwwdqwOqE5SLyZ0Oi9Ef0HlKWCfE2JF92gFDB/qn1DuER3
         70DICIHglL1rbdEIqXq+oHNfI+BVju2pIKCaYdCM/EYY+cjrT4SJ88QoUcrOG5zaufpN
         sL1pHi2V4qdI4QIF5ULY9bfTETsR9EpGO9xV8pXWvKEY2/76gdoeJRRriS0K1OSDMqex
         GGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uKEk7pcTQOPJj3RB17gVy4JPb5ypaqKNo8RuaGXS238=;
        b=AjRh+1LEmMpIiH9V02c3BrYc2JkIBELaI1elUbyxPt+airzNPXdlSB55D/xoERcB8Y
         1OqN5rnbMTHQL5c2ydBk4st9UiFotbdz/Sb9/0ZQAlXxh8/chH244vpUUaJBuQpFr6Yy
         Zk7ydxMHnLsghXRZDb8vFVoEX2geJQNvORqOV5Ryv2EM3czbihR6yqXmLHrp8UGnr9fZ
         7O4MgF0WZkO6P1SV4BxeHxPTjk1sMvYi20GirTxOcpOFZLChBnehbpKG7NucSgC7rVU0
         eLl5ViaupAXScMNxIu3DtYTiM5flfKkC/UR3CI0Ozxfs1dVvZoc3NJ1wxgHZ4cpmljDF
         AlFQ==
X-Gm-Message-State: APjAAAUvGrUNx4wRPklBmmbqQnw96iwsZiGrzxwgNh14AnC6FwFIKRYe
        FvoVXLC1KSNztIO0N7UGykBQ
X-Google-Smtp-Source: APXvYqz0NH1/5cvCw+LYXorC5ja42Ctcmhbotja18rZ9eEbBycTJdXZjVgQaGFdaeFlRPYYNwBkL/g==
X-Received: by 2002:a05:6214:4d:: with SMTP id c13mr101308qvr.118.1568670069748;
        Mon, 16 Sep 2019 14:41:09 -0700 (PDT)
Received: from [0.0.0.0] (198-0-189-189-static.hfc.comcastbusiness.net. [198.0.189.189])
        by smtp.gmail.com with ESMTPSA id k199sm129948qke.45.2019.09.16.14.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 14:41:09 -0700 (PDT)
Subject: Re: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
To:     Palmer Dabbelt <palmer@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Cc:     maz@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net
References: <mhng-df6c7aad-d4fd-4c44-96c8-bf63465e0c97@palmer-si-x1c4>
From:   Darius Rad <darius@bluespec.com>
Message-ID: <be21db32-ff5c-b25a-c8d6-af5bbd0c5469@bluespec.com>
Date:   Mon, 16 Sep 2019 17:41:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <mhng-df6c7aad-d4fd-4c44-96c8-bf63465e0c97@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/19 4:51 PM, Palmer Dabbelt wrote:
> On Mon, 16 Sep 2019 12:04:56 PDT (-0700), Darius Rad wrote:
>> On 9/15/19 2:20 PM, Marc Zyngier wrote:
>>> On Sun, 15 Sep 2019 18:31:33 +0100,
>>> Palmer Dabbelt <palmer@sifive.com> wrote:
>>>
>>> Hi Palmer,
>>>
>>>>
>>>> On Sun, 15 Sep 2019 07:24:20 PDT (-0700), maz@kernel.org wrote:
>>>>> On Thu, 12 Sep 2019 22:40:34 +0100,
>>>>> Darius Rad <darius@bluespec.com> wrote:
>>>>>
>>>>> Hi Darius,
>>>>>
>>>>>>
>>>>>> As per the existing comment, irq_mask and irq_unmask do not need
>>>>>> to do anything for the PLIC.  However, the functions must exist
>>>>>> (the pointers cannot be NULL) as they are not optional, based on
>>>>>> the documentation (Documentation/core-api/genericirq.rst) as well
>>>>>> as existing usage (e.g., include/linux/irqchip/chained_irq.h).
>>>>>>
>>>>>> Signed-off-by: Darius Rad <darius@bluespec.com>
>>>>>> ---
>>>>>>  drivers/irqchip/irq-sifive-plic.c | 13 +++++++++----
>>>>>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>>>>>> index cf755964f2f8..52d5169f924f 100644
>>>>>> --- a/drivers/irqchip/irq-sifive-plic.c
>>>>>> +++ b/drivers/irqchip/irq-sifive-plic.c
>>>>>> @@ -111,6 +111,13 @@ static void plic_irq_disable(struct irq_data *d)
>>>>>>      plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
>>>>>>  }
>>>>>>  +/*
>>>>>> + * There is no need to mask/unmask PLIC interrupts.  They are "masked"
>>>>>> + * by reading claim and "unmasked" when writing it back.
>>>>>> + */
>>>>>> +static void plic_irq_mask(struct irq_data *d) { }
>>>>>> +static void plic_irq_unmask(struct irq_data *d) { }
>>>>>
>>>>> This outlines a bigger issue. If your irqchip doesn't require
>>>>> mask/unmask, you're probably not using the right interrupt
>>>>> flow. Looking at the code, I see you're using handle_simple_irq, which
>>>>> is almost universally wrong.
>>>>>
>>>>> As per the description above, these interrupts should be using the
>>>>> fasteoi flow, which is designed for this exact behaviour (the
>>>>> interrupt controller knows which interrupt is in flight and doesn't
>>>>> require SW to do anything bar signalling the EOI).
>>>>>
>>>>> Another thing is that mask/unmask tends to be a requirement, while
>>>>> enable/disable tends to be optional. There is no hard line here, but
>>>>> the expectations are that:
>>>>>
>>>>> (a) A disabled line can drop interrupts
>>>>> (b) A masked line cannot drop interrupts
>>>>>
>>>>> Depending what the PLIC architecture mandates, you'll need to
>>>>> implement one and/or the other. Having just (a) is indicative of a HW
>>>>> bug, and I'm not assuming that this is the case. (b) only is pretty
>>>>> common, and (a)+(b) has a few adepts. My bet is that it requires (b)
>>>>> only.
>>>>>
>>>>>> +
>>>>>>  #ifdef CONFIG_SMP
>>>>>>  static int plic_set_affinity(struct irq_data *d,
>>>>>>                   const struct cpumask *mask_val, bool force)
>>>>>> @@ -138,12 +145,10 @@ static int plic_set_affinity(struct irq_data *d,
>>>>>>   static struct irq_chip plic_chip = {
>>>>>>      .name        = "SiFive PLIC",
>>>>>> -    /*
>>>>>> -     * There is no need to mask/unmask PLIC interrupts.  They are "masked"
>>>>>> -     * by reading claim and "unmasked" when writing it back.
>>>>>> -     */
>>>>>>      .irq_enable    = plic_irq_enable,
>>>>>>      .irq_disable    = plic_irq_disable,
>>>>>> +    .irq_mask    = plic_irq_mask,
>>>>>> +    .irq_unmask    = plic_irq_unmask,
>>>>>>  #ifdef CONFIG_SMP
>>>>>>      .irq_set_affinity = plic_set_affinity,
>>>>>>  #endif
>>>>>
>>>>> Can you give the following patch a go? It brings the irq flow in line
>>>>> with what the HW can do. It is of course fully untested (not even
>>>>> compile tested...).
>>>>>
>>>>> Thanks,
>>>>>
>>>>>     M.
>>>>>
>>>>> From c0ce33a992ec18f5d3bac7f70de62b1ba2b42090 Mon Sep 17 00:00:00 2001
>>>>> From: Marc Zyngier <maz@kernel.org>
>>>>> Date: Sun, 15 Sep 2019 15:17:45 +0100
>>>>> Subject: [PATCH] irqchip/sifive-plic: Switch to fasteoi flow
>>>>>
>>>>> The SiFive PLIC interrupt controller seems to have all the HW
>>>>> features to support the fasteoi flow, but the driver seems to be
>>>>> stuck in a distant past. Bring it into the 21st century.
>>>>
>>>> Thanks.  We'd gotten these comments during the review process but
>>>> nobody had gotten the time to actually fix the issues.
>>>
>>> No worries. The IRQ subsystem is an acquired taste... ;-)
>>>
>>>>>
>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>>> ---
>>>>>  drivers/irqchip/irq-sifive-plic.c | 29 +++++++++++++++--------------
>>>>>  1 file changed, 15 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>>>>> index cf755964f2f8..8fea384d392b 100644
>>>>> --- a/drivers/irqchip/irq-sifive-plic.c
>>>>> +++ b/drivers/irqchip/irq-sifive-plic.c
>>>>> @@ -97,7 +97,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
>>>>>      }
>>>>>  }
>>>>>  -static void plic_irq_enable(struct irq_data *d)
>>>>> +static void plic_irq_mask(struct irq_data *d)
>>>
>>> Of course, this is wrong. The perks of trying to do something at the
>>> last minute while boarding an airplane. Don't do that.
>>>
>>> This should of course read "plic_irq_unmask"...
>>>
>>>>>  {
>>>>>      unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
>>>>>                         cpu_online_mask);
>>>>> @@ -106,7 +106,7 @@ static void plic_irq_enable(struct irq_data *d)
>>>>>      plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
>>>>>  }
>>>>>  -static void plic_irq_disable(struct irq_data *d)
>>>>> +static void plic_irq_unmask(struct irq_data *d)
>>>
>>> ... and this should be "plic_irq_mask".
>>>
>>> [...]
>>>
>>>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>>>> Tested-by: Palmer Dabbelt <palmer@sifive.com> (QEMU Boot)
>>>
>>> Huhuh... It may be that QEMU doesn't implement the full-fat PLIC, as
>>> the above bug should have kept the IRQ lines masked.
>>>
>>>> We should test them on the hardware, but I don't have any with me
>>>> right now.  David's probably in the best spot to do this, as he's got
>>>> a setup that does all the weird interrupt sources (ie, PCIe).
>>>>
>>>> David: do you mind testing this?  I've put the patch here:
>>>>
>>>>    ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
>>>>    -b plic-fasteoi
>>>
>>> I've pushed out a branch with the fixed patch:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/plic-fasteoi
>>>
>>
>> That patch works for me on real-ish hardware.  I tried on two FPGA
>> systems that have different PLIC implementations.  Both include
>> a PCIe root port (and associated interrupt source).  So for
>> whatever it's worth:
>>
>> Tested-by: Darius Rad <darius@bluespec.com>
> 
> Awesome, thanks.  Would it be OK to put a "(on two hardware PLIC implementations)" after that, just so we're clear as to who tested what?

Fine by me.

> 
> Assuming one of yours wasn't a SiFive PLIC then it'd be great if David could still give this a whack, but I don't think it strictly needs to block merging the patch.  I've included the right David this time, with any luck that will be more fruitful :)

One of the systems I tested was based on rocket-chip, and the
associated PLIC, which I guess is the SiFive PLIC, right?  Can't hurt
to have more testing, though.

> 
>>
>>> Thanks,
>>>
>>>     M.
>>>
