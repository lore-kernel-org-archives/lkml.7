Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8079C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11ED2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfFLINP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:13:15 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:30302 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436876AbfFLINP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:13:15 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 57567A01CF;
        Wed, 12 Jun 2019 10:13:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id uh2br7MzDbkY; Wed, 12 Jun 2019 10:13:08 +0200 (CEST)
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
From:   Stefan Roese <sr@denx.de>
Message-ID: <12e5180e-b4a0-e5fa-bcad-ddc8103d644c@denx.de>
Date:   Wed, 12 Jun 2019 10:13:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190611144828.GX9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.19 16:48, Andy Shevchenko wrote:
> On Tue, Jun 11, 2019 at 04:02:54PM +0200, Stefan Roese wrote:
>> On 11.06.19 14:44, Andy Shevchenko wrote:
>>> On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:
> 
>>>>    static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
>>>>    {
>>>>    	serial_out(up, UART_MCR, value);
>>>> +
>>>> +	if (up->gpios) {
>>>> +		int mctrl_gpio = 0;
>>>> +
>>>> +		if (value & UART_MCR_RTS)
>>>> +			mctrl_gpio |= TIOCM_RTS;
>>>> +		if (value & UART_MCR_DTR)
>>>> +			mctrl_gpio |= TIOCM_DTR;
>>>> +
>>>> +		mctrl_gpio_set(up->gpios, mctrl_gpio);
>>>> +	}
>>>>    }
> 
>>>>    static inline int serial8250_in_MCR(struct uart_8250_port *up)
>>>>    {
>>>> -	return serial_in(up, UART_MCR);
>>>> +	int mctrl;
>>>> +
>>>> +	mctrl = serial_in(up, UART_MCR);
>>>> +
>>>> +	if (up->gpios) {
>>>> +		int mctrl_gpio = 0;
>>>> +
>>>> +		/* save current MCR values */
>>>> +		if (mctrl & UART_MCR_RTS)
>>>> +			mctrl_gpio |= TIOCM_RTS;
>>>> +		if (mctrl & UART_MCR_DTR)
>>>> +			mctrl_gpio |= TIOCM_DTR;
>>>> +
>>>> +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
>>>> +		if (mctrl_gpio & TIOCM_RTS)
>>>> +			mctrl |= UART_MCR_RTS;
>>>> +		else
>>>> +			mctrl &= ~UART_MCR_RTS;
>>>> +
>>>> +		if (mctrl_gpio & TIOCM_DTR)
>>>> +			mctrl |= UART_MCR_DTR;
>>>> +		else
>>>> +			mctrl &= ~UART_MCR_DTR;
>>>> +	}
>>>> +
>>>> +	return mctrl;
>>>>    }
>>>
>>> These are using OR logic with potentially volatile data. Shouldn't we mask
>>> unused bits in UART_MCR in case of up->gpios != NULL?
>>
>> Sorry, I don't see, which bits you are referring to? Could you please be
>> a bit more specific with the variable / macro meant (example)?
> 
> I meant that we double write values in the out() which might have some
> consequences, though I hope nothing wrong with it happens.

Where is the double write to a register? Sorry, I fail to spot it.
  
> In the in() we read the all bits in the register.
> 
> As now I look at the implementation of mctrl_gpio_get_outputs(),
> I think we rather get helpers for conversion between TIOCM and UART_MCR values,
> so, they can be used in get_mctrl() / set_mctrl() and above.

Do you something like this in mind?

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index dc9354e34b60..f44561fcb941 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1954,19 +1954,12 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
         status = serial8250_modem_status(up);
         serial8250_rpm_put(up);
  
-       ret = 0;
-
         if (up->gpios)
                 return mctrl_gpio_get(up->gpios, &ret);
  
-       if (status & UART_MSR_DCD)
-               ret |= TIOCM_CAR;
-       if (status & UART_MSR_RI)
-               ret |= TIOCM_RNG;
-       if (status & UART_MSR_DSR)
-               ret |= TIOCM_DSR;
-       if (status & UART_MSR_CTS)
-               ret |= TIOCM_CTS;
+       ret = UART_MSR_TO_TIOCM_DCD(status) | UART_MSR_TO_TIOCM_RI(status) |
+               UART_MSR_TO_TIOCM_DSR(status) | UART_MSR_TO_TIOCM_CTS(status);
+
         return ret;
  }
  EXPORT_SYMBOL_GPL(serial8250_do_get_mctrl);
@@ -1983,16 +1976,9 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
         struct uart_8250_port *up = up_to_u8250p(port);
         unsigned char mcr = 0;
  
-       if (mctrl & TIOCM_RTS)
-               mcr |= UART_MCR_RTS;
-       if (mctrl & TIOCM_DTR)
-               mcr |= UART_MCR_DTR;
-       if (mctrl & TIOCM_OUT1)
-               mcr |= UART_MCR_OUT1;
-       if (mctrl & TIOCM_OUT2)
-               mcr |= UART_MCR_OUT2;
-       if (mctrl & TIOCM_LOOP)
-               mcr |= UART_MCR_LOOP;
+       mcr = TIOCM_TO_UART_MCR_RTS(mctrl) | TIOCM_TO_UART_MCR_DTR(mctrl) |
+               TIOCM_TO_UART_MCR_OUT1(mctrl) | TIOCM_TO_UART_MCR_OUT2(mctrl) |
+               TIOCM_TO_UART_MCR_LOOP(mctrl);
  
         mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
  
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index be07b5470f4b..bda905a1b765 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -376,5 +376,22 @@
  #define UART_ALTR_EN_TXFIFO_LW 0x01    /* Enable the TX FIFO Low Watermark */
  #define UART_ALTR_TX_LOW       0x41    /* Tx FIFO Low Watermark */
  
+#define UART_MSR_TO_TIOCM_DCD(val)     ((val & UART_MSR_DCD) ? TIOCM_CAR : 0)
+#define UART_MSR_TO_TIOCM_RI(val)      ((val & UART_MSR_RI) ? TIOCM_RNG : 0)
+#define UART_MSR_TO_TIOCM_DSR(val)     ((val & UART_MSR_DSR) ? TIOCM_DSR : 0)
+#define UART_MSR_TO_TIOCM_CTS(val)     ((val & UART_MSR_CTS) ? TIOCM_CTS : 0)
+#define UART_MSR_TO_TIOCM_RTS(val)     ((val & UART_MSR_RTS) ? TIOCM_RTS : 0)
+#define UART_MSR_TO_TIOCM_DTR(val)     ((val & UART_MSR_DTR) ? TIOCM_DTR : 0)
+
+#define TIOCM_TO_UART_MCR_DCD(val)     ((val & TIOCM_DCD) ? UART_MCR_CAR : 0)
+#define TIOCM_TO_UART_MCR_RI(val)      ((val & TIOCM_RI) ? UART_MCR_RNG : 0)
+#define TIOCM_TO_UART_MCR_DSR(val)     ((val & TIOCM_DSR) ? UART_MCR_DSR : 0)
+#define TIOCM_TO_UART_MCR_CTS(val)     ((val & TIOCM_CTS) ? UART_MCR_CTS : 0)
+#define TIOCM_TO_UART_MCR_RTS(val)     ((val & TIOCM_RTS) ? UART_MCR_RTS : 0)
+#define TIOCM_TO_UART_MCR_DTR(val)     ((val & TIOCM_DTR) ? UART_MCR_DTR : 0)
+#define TIOCM_TO_UART_MCR_LOOP(val)    ((val & TIOCM_LOOP) ? UART_MCR_LOOP : 0)
+#define TIOCM_TO_UART_MCR_OUT1(val)    ((val & TIOCM_OUT1) ? UART_MCR_OUT1 : 0)
+#define TIOCM_TO_UART_MCR_OUT2(val)    ((val & TIOCM_OUT2) ? UART_MCR_OUT2 : 0)
+
  #endif /* _LINUX_SERIAL_REG_H */


Plus the use of these macros in this patch of course.

If yes, then I'll add a new patch (pretty similar to the one included
above) to this series.

Thanks,
Stefan
