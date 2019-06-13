Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF017C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A8020673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfFMQq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:46:26 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:16972 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbfFMFdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 01:33:18 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id AE6674FFC4;
        Thu, 13 Jun 2019 07:33:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id x8XDMHiD5zbs; Thu, 13 Jun 2019 07:32:48 +0200 (CEST)
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de> <20190611124415.GT9224@smile.fi.intel.com>
 <85f0d39c-e5d8-320b-e611-d956630a629f@denx.de>
 <20190611144828.GX9224@smile.fi.intel.com>
 <12e5180e-b4a0-e5fa-bcad-ddc8103d644c@denx.de>
 <20190612091621.GA9224@smile.fi.intel.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <6a4f1001-b023-c972-7b36-6d2f8f9a3fa8@denx.de>
Date:   Thu, 13 Jun 2019 07:32:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190612091621.GA9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.19 11:16, Andy Shevchenko wrote:
> On Wed, Jun 12, 2019 at 10:13:05AM +0200, Stefan Roese wrote:
>> On 11.06.19 16:48, Andy Shevchenko wrote:
>>> On Tue, Jun 11, 2019 at 04:02:54PM +0200, Stefan Roese wrote:
>>>> On 11.06.19 14:44, Andy Shevchenko wrote:
>>>>> On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:
>>>
>>>>>>     static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
>>>>>>     {
>>>>>>     	serial_out(up, UART_MCR, value);
>>>>>> +
>>>>>> +	if (up->gpios) {
>>>>>> +		int mctrl_gpio = 0;
>>>>>> +
>>>>>> +		if (value & UART_MCR_RTS)
>>>>>> +			mctrl_gpio |= TIOCM_RTS;
>>>>>> +		if (value & UART_MCR_DTR)
>>>>>> +			mctrl_gpio |= TIOCM_DTR;
>>>>>> +
>>>>>> +		mctrl_gpio_set(up->gpios, mctrl_gpio);
>>>>>> +	}
>>>>>>     }
>>>
>>>>>>     static inline int serial8250_in_MCR(struct uart_8250_port *up)
>>>>>>     {
>>>>>> -	return serial_in(up, UART_MCR);
>>>>>> +	int mctrl;
>>>>>> +
>>>>>> +	mctrl = serial_in(up, UART_MCR);
>>>>>> +
>>>>>> +	if (up->gpios) {
>>>>>> +		int mctrl_gpio = 0;
>>>>>> +
>>>>>> +		/* save current MCR values */
>>>>>> +		if (mctrl & UART_MCR_RTS)
>>>>>> +			mctrl_gpio |= TIOCM_RTS;
>>>>>> +		if (mctrl & UART_MCR_DTR)
>>>>>> +			mctrl_gpio |= TIOCM_DTR;
>>>>>> +
>>>>>> +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
>>>>>> +		if (mctrl_gpio & TIOCM_RTS)
>>>>>> +			mctrl |= UART_MCR_RTS;
>>>>>> +		else
>>>>>> +			mctrl &= ~UART_MCR_RTS;
>>>>>> +
>>>>>> +		if (mctrl_gpio & TIOCM_DTR)
>>>>>> +			mctrl |= UART_MCR_DTR;
>>>>>> +		else
>>>>>> +			mctrl &= ~UART_MCR_DTR;
>>>>>> +	}
>>>>>> +
>>>>>> +	return mctrl;
>>>>>>     }
>>>>>
>>>>> These are using OR logic with potentially volatile data. Shouldn't we mask
>>>>> unused bits in UART_MCR in case of up->gpios != NULL?
>>>>
>>>> Sorry, I don't see, which bits you are referring to? Could you please be
>>>> a bit more specific with the variable / macro meant (example)?
>>>
>>> I meant that we double write values in the out() which might have some
>>> consequences, though I hope nothing wrong with it happens.
>>
>> Where is the double write to a register? Sorry, I fail to spot it.
> 
> Not to the one register. From the functional point of view the same signal is
> set up twice: once per UART register, once per GPIO pins.
> 
>>> In the in() we read the all bits in the register.
>>>
>>> As now I look at the implementation of mctrl_gpio_get_outputs(),
>>> I think we rather get helpers for conversion between TIOCM and UART_MCR values,
>>> so, they can be used in get_mctrl() / set_mctrl() and above.
>>
>> Do you something like this in mind?
> 
> More likely
> 
> static inline int serial8250_MCR_to_TIOCM(int mcr)

MSR_to_TIOCM (see below) ...

> {
> 	int tiocm = 0;
> 
> 	if (mcr & ...)
> 		tiocm |= ...;
> 	...
> 
> 	return tiocm;
> }
> 
> static inline int serial8250_TIOCM_to_MCR(int tiocm)
> {
> 	... in a similar way ...
> }

While implementing such wrapper functions I noticed, that get_mctrl() /
set_mctrl() need TIOCM->MCR and MSR->TIOCM (notice MSR vs MCR here) but
serial8250_in_MCR() needs MCR->TIOCM. So there is not that much
overlay here. Additionally the wrappers would need to handle all bits
and only some of them are needed in serial8250_in/out_MCR(), so I would
need to add masking here as well.

For my taste its not really worth adding these wrappers as they won't
make things much clearer (if at all).

Thanks,
Stefan
