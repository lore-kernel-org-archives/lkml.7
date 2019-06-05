Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7738BC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9F520717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfFEJfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:35:09 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:59686 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFEJfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:35:09 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 7734AA0191;
        Wed,  5 Jun 2019 11:35:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id zXe4_JImFazw; Wed,  5 Jun 2019 11:35:02 +0200 (CEST)
Subject: Re: [PATCH 2/2 v4] tty/serial/8250: use mctrl_gpio helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20190603083332.12480-1-sr@denx.de>
 <20190603083332.12480-2-sr@denx.de>
 <20190604165224.GP9224@smile.fi.intel.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <115804ab-7d7c-a656-e6f4-ad61b3e02705@denx.de>
Date:   Wed, 5 Jun 2019 11:35:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190604165224.GP9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.19 18:52, Andy Shevchenko wrote:
> On Mon, Jun 03, 2019 at 10:33:32AM +0200, Stefan Roese wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> This patch permits the usage for GPIOs to control
>> the CTS/RTS/DTR/DSR/DCD/RI signals.
> 
>> +	if (up->gpios) {
> 
>> +		mctrl_gpio_set(up->gpios, mctrl_gpio);
>> +	}
> 
> ...
> 
>> +	if (up->gpios) {
> 
>> +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
> 
>> +	}
> 
> ...
> 
>> +			gpios = mctrl_gpio_init(&uart->port, 0);
>> +			if (IS_ERR(gpios)) {
>> +				if (PTR_ERR(gpios) != -ENOSYS)
>> +					return PTR_ERR(gpios);
>> +			}
> 
> ...
> 
>> +	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
>> +						UART_GPIO_RTS))) {
> 
>> +	}
> 
> ...
> 
>> -	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
>> +	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW
>> +		&& IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
>> +							UART_GPIO_RTS))) {
> 
>> }
> 
> ...
> 
>> +	if (up->gpios)
>> +		mctrl_gpio_disable_ms(up->gpios);
> 
> ...
> 
>> +	if (up->gpios)
>> +		mctrl_gpio_enable_ms(up->gpios);
> 
> ...
> 
>> +	if (up->gpios)
>> +		return mctrl_gpio_get(up->gpios, &ret);
> 
> 
> Can we rather make this mimic the gpiod_get_optional() API?
> 
> So, if we get an error, it's an error, otherwise with NULL pointer the
> operations goes to be no-op.
> 
> [IS_ERR_OR_NULL() -> IS_ERR(), if (up->gpios) -> /dev/null, etc]

So you want me to drop all "if (up->gpios)" checks? I can do this in
some cases (e.g. serial8250_disable_ms()). But I would like to keep
it in other cases, like serial8250_out_MCR(), where this check prevents
some unnecessary code execution in the "non-gpios mode" (and vice-versa).

Would this be acceptable?

BTW: Regarding the OMAP specific code: I'm not the author of this code
and I don't have access to such hardware to do some tests here. But
changing IS_ERR_OR_NULL() -> IS_ERR() in this OMAP code does not
seem correct. IIUTC, these "if" clauses are extended here by
IS_ERR_OR_NULL(mctrl_gpio_to_gpiod()) to check if the GPIO's are not
enabled / used. Currently this will probably break, since when called
with "gpios == NULL", mctrl_gpio_to_gpiod() will crash [1].

If you don't object (or have other suggestions), I'll change this to
use "up->gpios == 0" instead. This seems to be what the original author
wanted to achieve.

Okay?

Thanks,
Stefan

[1]

struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
				      enum mctrl_gpio_idx gidx)
{
	return gpios->gpio[gidx];
}
