Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E5C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB5E21939
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfKTNet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:34:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:36832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729696AbfKTNes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:34:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50BBAB00A;
        Wed, 20 Nov 2019 13:34:46 +0000 (UTC)
Subject: Re: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20191119021917.15917-1-afaerber@suse.de>
 <20191119021917.15917-3-afaerber@suse.de>
 <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
 <e98364c5-a859-7981-8ccf-f8e5b5069379@suse.de> <20191119222956.23665e5d@why>
 <d7416bdb-e20a-42e1-daff-c61369f359fa@suse.de>
 <e4d30ff2485c3f9ffd2b934f1f757d19@www.loen.fr>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <18c09fc4-fe7b-7ba0-7cd3-ae0c650ca4a8@suse.de>
Date:   Wed, 20 Nov 2019 14:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <e4d30ff2485c3f9ffd2b934f1f757d19@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.11.19 um 11:20 schrieb Marc Zyngier:
> On 2019-11-19 23:33, Andreas Färber wrote:
>> Am 19.11.19 um 23:29 schrieb Marc Zyngier:
>>> On Tue, 19 Nov 2019 21:56:48 +0100
>>> Andreas Färber <afaerber@suse.de> wrote:
>>>> Am 19.11.19 um 13:01 schrieb Marc Zyngier:
>>>>> On 2019-11-19 02:19, Andreas Färber wrote:
>>>>>> +static void rtd1195_mux_enable_irq(struct irq_data *data)
>>>>>> +{
>>>>>> +    struct rtd1195_irq_mux_data *mux_data =
>>>>>> irq_data_get_irq_chip_data(data);
>>>>>> +    unsigned long flags;
>>>>>> +    u32 mask;
>>>>>> +
>>>>>> +    mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
>>>>>> +    if (!mask)
>>>>>> +        return;
>>>>>
>>>>> How can this happen? You've mapped the interrupt, so it exists.
>>>>> I can't see how you can decide to fail such enable.
>>>>
>>>> The [UMSK_]ISR bits and the SCPU_INT_EN bits are not (all) the same.
>>>>
>>>> My ..._isr_to_scpu_int_en[] arrays have 32 entries for O(1) lookup, but
>>>> are sparsely populated. So there are circumstances such as WDOG_NMI as
>>>> well as reserved bits that we cannot enable.
>>>
>>> But the you should have failed the map. The moment you allow the
>>> mapping to occur, you have accepted the contract that this interrupt is
>>> usable.
>>>
>>>> This check should be
>>>> identical to v3; the equivalent mask check inside the interrupt handler
>>>> was extended with "mask &&" to do the same in this v4.
>>>
>>> Spurious interrupts are a different matter. What I'm objecting to here
>>> is a simple question of logic, whether or not you are allowed to fail
>>> enabling an interrupt that you've otherwise allowed to be populated.
>>
>> Then what are you suggesting instead? I don't see how my array map
>> lookup could fail other than returning a zero value, given its static
>> initialization. Check for a zero mask in rtd1195_mux_irq_domain_map()?
>> Then we wouldn't be able to use the mentioned WDOG_NMI. Add another
>> per-mux info field for which interrupts are valid to map?
> 
> I'm suggesting that you fail the map if you're unable to allow the
> interrupt to be enabled.

The NMI will always be enabled, it just can't be disabled.

I have added a check to suppress a zero hwirq. Suppressing reserved IRQ
bits will take some more effort to distinguish from NMIs. In particular
if we flag this in the ..._isr_to_scpu_int_en array by some magic mask
value like 0xffffffff then all users need to check for two rather than
one value - but if we reduce the users, it shouldn't matter too much.

With contract I assume you're referring to these callbacks having a void
return type, unable to return an error to the caller, and there being no
is_enabled/is_masked callbacks for anyone to discover this.

Unfortunately NMI handling appears to be only used in GICv3 and is not
very intuitive for me: Apparently I can only flag the whole irq_chip as
being NMI but not individual IRQs? Would that mean that this driver
would need to instantiate a second irq_chip for that one IRQ? How would
that work for mapping from DT? Given that this mux relies on a maskable
GICv2 IRQ, it's not a "true" NMI in the Linux sense anyway, other than
the .irq_mask callback not being applicable. While I don't need that NMI
immediately, I would prefer not to merge a driver that by design can't
cope with it later.

I'll try to post a v5 with rsv and nmi blocked in map for further
discussion tonight.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
