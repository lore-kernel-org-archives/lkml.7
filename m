Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E41C50701
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DB624769
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfLMNtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:49:07 -0500
Received: from mail.sysgo.com ([176.9.12.79]:58406 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfLMNtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:49:07 -0500
Subject: Re: [PATCH] tty/serial: atmel: fix out of range clock divider
 handling
To:     Richard Genoud <richard.genoud@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191211162954.8393-1-david.engraf@sysgo.com>
 <822ac68e-4dde-21e8-caf9-a219b910d49e@gmail.com>
From:   David Engraf <david.engraf@sysgo.com>
Message-ID: <1e2e3f63-84db-4b38-1bf1-85916116e0a2@sysgo.com>
Date:   Fri, 13 Dec 2019 14:49:03 +0100
MIME-Version: 1.0
In-Reply-To: <822ac68e-4dde-21e8-caf9-a219b910d49e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13.12.19 at 10:57, Richard Genoud wrote:
> Hi,
> 
> Le 11/12/2019 à 17:29, David Engraf a écrit :
>> Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
>> register was already written thus the clock selection is ignored.
>>
>> Fix by writing the mode register after calculating the baudrate.
>>
>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> 
> It seems that this bug was introduced by:
> commit 5bf5635ac170 ("tty/serial: atmel: add fractional baud rate support")
> 
> Could you add the "Fixes:" header ?

Sure.

> Ludovic, could you check if this was your intent at the time ?
> 
>> ---
>>   drivers/tty/serial/atmel_serial.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index a8dc8af83f39..9983e2fabbac 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -2270,9 +2270,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>>   		mode |= ATMEL_US_USMODE_NORMAL;
>>   	}
>>   
> I think it's better to mo move the "Set baud rate" block here (cf bellow)
> 
>> -	/* set the mode, clock divisor, parity, stop bits and data size */
>> -	atmel_uart_writel(port, ATMEL_US_MR, mode);
>> -
>>   	/*
>>   	 * when switching the mode, set the RTS line state according to the
>>   	 * new mode, otherwise keep the former state
>> @@ -2315,6 +2312,9 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>>   	}
>>   	quot = cd | fp << ATMEL_US_FP_OFFSET;
>>   
>> +	/* set the mode, clock divisor, parity, stop bits and data size */
>> +	atmel_uart_writel(port, ATMEL_US_MR, mode);
>> +
> I think your patch is good, but I'll be happier if instead of moving
> those 2 lines here, the whole "Set the baud rate" block was moved before
> "atmel_uart_writel(port, ATMEL_US_MR, mode);"
> 
> That's because at line 2291 the ATMEL_US_CR register is set with
> ATMEL_US_RTSDIS or ATMEL_US_RTSEN.
> And those 2 values have a different effect depending on US_MR.USART_MODE
> 
> Quoting from the relase manual:
> RTSEN:
> 1: Drives RTS pin to 1 if US_MR.USART_MODE field = 2, else drives RTS
> pin to 0 if US_MR.USART_MODE field = 0.
> 
> RTSDIS:
> 1: Drives RTS pin to 0 if US_MR.USART_MODE field = 2, else drives RTS
> pin to 1 if US_MR.USART_MODE field = 0.
> 
> So, I think it's better to set the mode register before setting the
> control register.

I fully agree, the RTS pin configuration depends on USART_MODE. I will 
make a new version of the patch.

Thanks
- David


> 
>>   	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
>>   		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
>>   	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>>
> 
> Thanks !
> 

