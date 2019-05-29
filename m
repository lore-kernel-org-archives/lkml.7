Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E69EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F75522CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfE2N5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:57:42 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:25484 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfE2N5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:57:41 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id AEAC050261;
        Wed, 29 May 2019 15:57:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id Nea8omml6Tf8; Wed, 29 May 2019 15:57:33 +0200 (CEST)
Subject: Re: [PATCH 1/2 v3] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
References: <20190527111805.876-1-sr@denx.de> <20190529134435.GR568@localhost>
From:   Stefan Roese <sr@denx.de>
Message-ID: <4e45b298-78bf-c2a0-fcbe-45c10674990f@denx.de>
Date:   Wed, 29 May 2019 15:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190529134435.GR568@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.19 15:44, Johan Hovold wrote:
> On Mon, May 27, 2019 at 01:18:04PM +0200, Stefan Roese wrote:
>> This patch adds a check for the GPIOs property existence, before the
>> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
>> support is added (2nd patch in this patch series) on x86 platforms using
>> ACPI.
> 
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Yegor Yefremov <yegorslists@googlemail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>> v3:
>> - No change
>>
>> v2:
>> - Include the problem description and analysis from Mika into the commit
>>    text, as suggested by Greg.
>>
>>   drivers/tty/serial/serial_mctrl_gpio.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
>> index 39ed56214cd3..cac50b20a119 100644
>> --- a/drivers/tty/serial/serial_mctrl_gpio.c
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
>> @@ -116,6 +116,13 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
>>   
>>   	for (i = 0; i < UART_GPIO_MAX; i++) {
>>   		enum gpiod_flags flags;
>> +		char *gpio_str;
>> +
>> +		/* Check if GPIO property exists and continue if not */
>> +		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
>> +				     mctrl_gpios_desc[i].name);
> 
> Where's the corresponding kfree?

Its missing. I'll add it in v4.

Thanks,
Stefan
