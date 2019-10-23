Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624EECA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2605B21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVVxCOX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfJWRDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:03:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45481 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfJWRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:03:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id y7so8800211edo.12;
        Wed, 23 Oct 2019 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfyYJCpihwCnIIE7ruVuey3YIuD1cBFEnblxL3Pf/GI=;
        b=MVVxCOX9LRMQ36a3zNVyY+afvH1vtKyY26cuhVBsZxf2IIbcJVSLjlQSbIN93RUx87
         5qKNEkqJ5jiuKu2gkZO7WelpuY14JiMDCgIsMHIauPcipDsQAcVrr3FnkTlWeVefe+fT
         qZsWYa4FBlP3s3WjQVeMbCTL0P0Tr8p3CuykPaplANBe+9/enfRdK5o7aSD6iNgfuTYp
         vY+F7iOG8ig/11r6XtjeNvobRL5SOtWqVMNBXClHzFga5wb8yY0FKPH46iGe6rJCe0N7
         Vr9rz0HzA4WOZa7Yj5K04ixXEldjtZOkx4eLWQkM+mGzAftjOY4y16i3aQDfiKOJ1XNy
         K+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lfyYJCpihwCnIIE7ruVuey3YIuD1cBFEnblxL3Pf/GI=;
        b=iQkfF7Q8QdRq6JEzciz2hrz7PeZCa/Oxb4p8WhAPkx57Su9gL2nttKBP7tTEffJjxM
         a0OVxcKhREUn4rmnILRZNPGgRqdpR+Xcd3MgageVwZeCJU23UTBATjV6bJlM3225M638
         wv79zrnDPQVYg5Yvic8IS0Kj3SB8Ng7MENRUNRo7SRnRpvyvTEzpCV1yAHfElJKizbpE
         PQo1MM+RoMESW0s2xN5/oVNVt+cmGJUjYqWl6/nwmoRwfk2/wXzKdAPUcEmJQiVCABHs
         SmC4kCdwKmcaoNmDPPYvseQM2xW7epwlapG6N6PZEGLXUw+HDMDVDdvKufguDSJ3cx3a
         hJ0A==
X-Gm-Message-State: APjAAAVNgVE1DtXZYBjXNojpDAh4dtmfwC9bsnVdClRsx72PkRO8ZmsV
        weFKrOwIg+EnfOUY9XYOkKE=
X-Google-Smtp-Source: APXvYqzymVs1QDqA/1YTAp6vInBkMYtF8XzZI8GIvyIFLORM5ghcENbZoOm+z/Kuq5t0R4oLkuwDLA==
X-Received: by 2002:a17:906:6a15:: with SMTP id o21mr33246404ejr.79.1571850177503;
        Wed, 23 Oct 2019 10:02:57 -0700 (PDT)
Received: from [10.67.50.53] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id sb3sm62677ejb.64.2019.10.23.10.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 10:02:56 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] irqchip/gic: Allow the use of SGI interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thanu Rangarajan <thanu.rangarajan@arm.com>
References: <20191023000547.7831-1-f.fainelli@gmail.com>
 <20191023000547.7831-3-f.fainelli@gmail.com>
 <112a725164b7fe321f27357fd4cd772f@www.loen.fr>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <fdb77138-3df8-ef51-6519-e630b6228eb0@gmail.com>
Date:   Wed, 23 Oct 2019 10:02:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <112a725164b7fe321f27357fd4cd772f@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello marc,

On 10/23/19 6:22 AM, Marc Zyngier wrote:
> Hi Florian,
> 
> Needless to say, I mostly have questions...
> 
> On 2019-10-23 01:05, Florian Fainelli wrote:
>> SGI interrupts are a convenient way for trusted firmware to target a
>> specific set of CPUs. Update the ARM GIC code to allow the translation
>> and mapping of SGI interrupts.
>>
>> Since the kernel already uses SGIs for various inter-processor interrupt
>> activities, we specifically make sure that we do not let users of the
>> IRQ API to even try to map those.
>>
>> Internal IPIs remain dispatched through handle_IPI() while public SGIs
>> get promoted to a normal interrupt flow management.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/irqchip/irq-gic.c | 41 +++++++++++++++++++++++++++------------
>>  1 file changed, 29 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index 30ab623343d3..dcfdbaacdd64 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -385,7 +385,10 @@ static void __exception_irq_entry
>> gic_handle_irq(struct pt_regs *regs)
>>               * Pairs with the write barrier in gic_raise_softirq
>>               */
>>              smp_rmb();
>> -            handle_IPI(irqnr, regs);
>> +            if (irqnr < NR_IPI)
>> +                handle_IPI(irqnr, regs);
>> +            else
>> +                handle_domain_irq(gic->domain, irqnr, regs);
> 
> Double EOI, UNPREDICTABLE territory, your state machine is now dead.

Oh yes, the interrupt flow now also goes through ->irq_eoi (that's the
whole point), meh.

> 
>>  #endif
>>              continue;
>>          }
>> @@ -1005,20 +1008,34 @@ static int gic_irq_domain_translate(struct
>> irq_domain *d,
>>          if (fwspec->param_count < 3)
>>              return -EINVAL;
>>
>> -        /* Get the interrupt number and add 16 to skip over SGIs */
>> -        *hwirq = fwspec->param[1] + 16;
>> -
>> -        /*
>> -         * For SPIs, we need to add 16 more to get the GIC irq
>> -         * ID number
>> -         */
>> -        if (!fwspec->param[0])
>> +        *hwirq = fwspec->param[1];
>> +        switch (fwspec->param[0]) {
>> +        case 0:
>> +            /*
>> +             * For SPIs, we need to add 16 more to get the GIC irq
>> +             * ID number
>> +             */
>> +            *hwirq += 16;
>> +            /* fall through */
>> +        case 1:
>> +            /* Add 16 to skip over SGIs */
>>              *hwirq += 16;
>> +            *type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>>
>> -        *type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>> +            /* Make it clear that broken DTs are... broken */
>> +            WARN_ON(*type == IRQ_TYPE_NONE);
>> +            break;
>> +        case 2:
>> +            /* Refuse to map internal IPIs */
>> +            if (*hwirq < NR_IPI)
> 
> So depending on how the kernel uses SGIs, you can or cannot use these SGIs.
> That looks like a good way to corner ourselves into not being to change
> much.

arch/arm/kernel/smp.c has a forward looking statement about SGI numbering:

        /*
         * SGI8-15 can be reserved by secure firmware, and thus may
         * not be usable by the kernel. Please keep the above limited
         * to at most 8 entries.
         */

is this something that can be used as an universal and unbreakable rule
for the ARM64 kernel as well in order to ensure SGIs 8-15 can be usable
through the IRQ API or is this simply not a guarantee at all?

> 
> Also, do you expect this to work for both Group-0 and Group-1 interrupts
> (since you imply that this works as a communication medium with the secure
> side)? Given that the kernel running in NS has no way to enable/disable
> Group-0 interrupts, this looks terminally flawed. Or is that Group-1 only?

That would be Group-1 interrupts only, are you suggesting there is an
additional check being done that such SGIs are actually part of Group-1?

> 
> How do we describe which SGIs are guaranteed to be available to Linux?

In our case, the Device Tree mailbox node gets populated its interrupts
property with the SGI number(s), and that same number is also passed as
a configuration parameter to the trusted firmware. Or are you echoing
back to your earlier comment about the fact that if the kernel changes
its own definition of NR_IPI then we suddenly start breaking IRQ API
uses of SGIs in a certain range?

> 
>> +                return -EPERM;
>> +
>> +            *type = IRQ_TYPE_NONE;
> 
> Or not. SGI are edge triggered, by definition.
> 
>> +            break;
>> +        default:
>> +            break;
>> +        }
>>
>> -        /* Make it clear that broken DTs are... broken */
>> -        WARN_ON(*type == IRQ_TYPE_NONE);
> 
> Really?

Given the comment in gic_set_type() about SGIs, the WARN_ON() was moved
above to continue checking for GIC_SPI and GIC_PPI, but we should
extract the type from the Devic eTree and only permit an edge mask.
-- 
Florian
