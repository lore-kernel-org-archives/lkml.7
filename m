Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A34C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF6F22445
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKSU4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:56:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:50354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbfKSU4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:56:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F97FAC84;
        Tue, 19 Nov 2019 20:56:50 +0000 (UTC)
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
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <e98364c5-a859-7981-8ccf-f8e5b5069379@suse.de>
Date:   Tue, 19 Nov 2019 21:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.11.19 um 13:01 schrieb Marc Zyngier:
> On 2019-11-19 02:19, Andreas Färber wrote:
>> +static void rtd1195_mux_enable_irq(struct irq_data *data)
>> +{
>> +    struct rtd1195_irq_mux_data *mux_data =
>> irq_data_get_irq_chip_data(data);
>> +    unsigned long flags;
>> +    u32 mask;
>> +
>> +    mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
>> +    if (!mask)
>> +        return;
> 
> How can this happen? You've mapped the interrupt, so it exists.
> I can't see how you can decide to fail such enable.

The [UMSK_]ISR bits and the SCPU_INT_EN bits are not (all) the same.

My ..._isr_to_scpu_int_en[] arrays have 32 entries for O(1) lookup, but
are sparsely populated. So there are circumstances such as WDOG_NMI as
well as reserved bits that we cannot enable. This check should be
identical to v3; the equivalent mask check inside the interrupt handler
was extended with "mask &&" to do the same in this v4.

The other question I'll need to dig into, it's been two years since I
wrote that code - first very simple guesswork, then more elaborate
quirks like the above.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
