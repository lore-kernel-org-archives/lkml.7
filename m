Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F199BC742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 11:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA66C2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 11:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="BjzTWr4N";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="byzTE/Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGLLx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 07:53:27 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:49726 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbfGLLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 07:53:27 -0400
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6CBqt1T015195
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 12:53:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=AdelIb2YSJRciDPYH07qx45uPJJSr94oYp9bJDKCICw=;
 b=BjzTWr4NGIn7xN+6l2W/zJ3rAqjmpscbVyk7vP1ivC5S9jR47ehtmk03Lb4cTjPB7HM1
 /iq+9NPHpnP01vuaqB7bPcW3Z/DT5e5iGTXlq6jjpTHlMq1Isu1LjRkNMq9ETtdaCqFR
 ptHIteuzguCLdpKWAOcxtaE2C+IMoJDaiXx8EkeCNs/o1RN5mU4CaBYjHdwXjZZhtSeG
 YY/mIQu+zQUBM+0IFcbrTPXxyQ5M1p1q/Xp5PIe5961d7wroybu/Bb5VMdQvh4JiXYVu
 ccuL/lfM3wM4d6yUGRvRMqcE+41g19toUuIscfFcR1JU/dU9UwsnnKRzhg2XyY65rAwJ FA== 
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        by mx08-00252a01.pphosted.com with ESMTP id 2tmd5x1u57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 12:53:23 +0100
Received: by mail-wm1-f69.google.com with SMTP id d65so2792930wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AdelIb2YSJRciDPYH07qx45uPJJSr94oYp9bJDKCICw=;
        b=byzTE/PfFrp7l6eGgz71mVU9xfJ3HWDTuI5WNBMRh4uyrnsxwiSLlcN6Dv1A5HuFMT
         t40dbiiv1OO8R8fMuBwq6ihe6qAAa5nc1OFUwuNg4oMKGPwuJ+H/pChW9Cb+YIFLJ2ik
         yZ+79vmnJbtF7hFhDQhHkOEsVLME+B4zMqOOZPGbFSiGzkFK3wvnVv6GCUANrJRj6GRl
         5q6hzX0YdTCrkkQqC6q+A7DOgQ25a+AecOCsIY5HqoS6XX0sqQuCifs7qzoRT7YCJpwI
         8Z20jFUXhKsUf4BAABhsxenRy7kxjhA/tlRzvs+cc1/cX9A6xaa0ftNxpCrVQNN6kh3D
         taWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AdelIb2YSJRciDPYH07qx45uPJJSr94oYp9bJDKCICw=;
        b=RSIJzZTqZ8fWzqyfzcxB8JiQuHNkmJmjEgvzmby7bstrEoQ/AroI8qB6kGj8xiJ7KL
         nSdvMiOkyHP7u3rXoYdhZbPZJjZu6ixxLd3hGA+dLw0Z2gkfVWscdPx/IDoeMu+42Wfj
         yllKi3hUZNo9S0Acnkj9mdyDjomvdNGaWdKuFYYbM9pWbX5kPyIfPe0FBfOjiSh/iOVb
         zBZM32X7i1X4WjlIk7cpizA9LO8+3XRixb9P+nk31gf7r9e2Rt1Va+MRSg9VFoL4o4bC
         hnFxboqOy/9+zp6GPUGDW8XBS9tph1lgzaa8CJ/nrkS6EZkvo1NTD6iniz1x4oj7mUpc
         927Q==
X-Gm-Message-State: APjAAAWRF/MFcBz456O0sh2R2QCY28VvbC8ngh3FZi7608x9UDHOjSdU
        KXmVb3mh2fo5QMGuGafIwmvS7ZrZAcqcB5nmlAQ5PNjV6AxNpj3daNh+3sx09mIe5NXcEsTMhi5
        b4MMriqbSfOKCBNdSwfsNyPz0
X-Received: by 2002:a1c:c747:: with SMTP id x68mr9650775wmf.138.1562932402532;
        Fri, 12 Jul 2019 04:53:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyR8Fl6Hz1+SkGynbWRlJLuYost8j9E5ShaK38u3IaW4NWmQic/3yGbzdQRU7egRV2qwsNKiA==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr9650755wmf.138.1562932402195;
        Fri, 12 Jul 2019 04:53:22 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:3df0:c4c3:bb86:e0f3? ([2a00:1098:3142:14:3df0:c4c3:bb86:e0f3])
        by smtp.gmail.com with ESMTPSA id q18sm5872577wrw.36.2019.07.12.04.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 04:53:21 -0700 (PDT)
Subject: Re: [PATCH] tty: amba-pl011: Make TX optimisation conditional
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
 <20190712112105.GH2790@e103592.cambridge.arm.com>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <979f2ac1-2b7f-e592-f776-60ca07d77097@raspberrypi.org>
Date:   Fri, 12 Jul 2019 12:53:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712112105.GH2790@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-12_04:2019-07-12,2019-07-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Thanks for the reply.

On 12/07/2019 12:21, Dave Martin wrote:
> On Thu, Jul 11, 2019 at 02:45:32PM +0100, Phil Elwell wrote:
>> pl011_tx_chars takes a "from_irq" parameter to reduce the number of
>> register accesses. When from_irq is true the function assumes that the
>> FIFO is half empty and writes up to half a FIFO's worth of bytes
>> without polling the FIFO status register, the reasoning being that
>> the function is being called as a result of the TX interrupt being
>> raised. This logic would work were it not for the fact that
>> pl011_rx_chars, called from pl011_int before pl011_tx_chars, releases
>> the spinlock before calling tty_flip_buffer_push.
>>
>> A user thread writing to the UART claims the spinlock and ultimately
>> calls pl011_tx_chars with from_irq set to false. This reverts to the
>> older logic that polls the FIFO status register before sending every
>> byte. If this happen on an SMP system during the section of the IRQ
>> handler where the spinlock has been released, then by the time the TX
>> interrupt handler is called, the FIFO may already be full, and any
>> further writes are likely to be lost.
>>
>> The fix involves adding a per-port flag that is true iff running from
>> within the interrupt handler and the spinlock has not yet been released.
>> This flag is then used as the value for the from_irq parameter of
>> pl011_tx_chars, causing polling to be used in the unsafe case.
> 
> Releasing the lock in pl011_int() before calling pl011_tx_chars()
> wouldn't the source of this issue, though it may make it easier to hit:
> there would anyway be a window between the interrupt being asserted and
> the initial spin_lock_irqsave() in pl011_int(), during which the TX
> FIFO could be topped up by another cpu.

Yes - if the TXINTR is only cleared by the write to the ICR then there is
still that small window where the FIFO is vulnerable.

> So, assuming you've diagnosed the problem correctly, I'm not sure this
> patch really fixes it.
> 
> What's the failure scenario exactly?  Are you using DMA?

No - no DMA. A loopback test on a Raspberry Pi 3 or 4 is an easy way of
reproducing the data loss.

> If chars are being lost and falling back to polled TXFF per char fixes
> it, then that does suggest a TX FIFO overflow somewhere.
> 
> Looking at the code, I'm slightly amazed we don't hit this more often.
> It looks like if we have stuttering output that is sufficient to fill
> the TX FIFO to the interrupt trigger threshold sometimes, but
> uap->port.state->xmit stays empty, then we can probably get pl011_int()
> and pl011_start_tx_pio() fighting with each other, as you suggest.

I'm not hypothesising - a GPIO-instrumented driver and a logic analyser clearly
show the failure mechanism.

> One option would be to track who can write the TX FIFO, either the
> irq handler, or regular task context, and make them mutually exclusive.
> 
> We already have a flag for that in the form of the TXIM interrupt mask
> bit.  So, fixing this might be as simple as [1].  Can you give it a
> try?

That patch does also seem to fix the data loss, and is simpler.

> If is works, I can work it up into a proper patch.
> 
> Cheers
> ---Dave
> 
>>
>> Fixes: 1e84d22322ce ("serial/amba-pl011: Refactor and simplify TX FIFO handling")
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> ---
>>  drivers/tty/serial/amba-pl011.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 5921a33..70c1dc9 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -270,6 +270,7 @@ struct uart_amba_port {
>>  	unsigned int		old_cr;		/* state during shutdown */
>>  	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
>>  	char			type[12];
>> +	bool			irq_locked;	/* in irq, unreleased lock */
>>  #ifdef CONFIG_DMA_ENGINE
>>  	/* DMA stuff */
>>  	bool			using_tx_dma;
>> @@ -814,6 +815,7 @@ __acquires(&uap->port.lock)
>>  		return;
>>  
>>  	/* Avoid deadlock with the DMA engine callback */
>> +	uap->irq_locked = 0;
>>  	spin_unlock(&uap->port.lock);
>>  	dmaengine_terminate_all(uap->dmatx.chan);
>>  	spin_lock(&uap->port.lock);
>> @@ -941,6 +943,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
>>  		fifotaken = pl011_fifo_to_tty(uap);
>>  	}
>>  
>> +	uap->irq_locked = 0;
>>  	spin_unlock(&uap->port.lock);
>>  	dev_vdbg(uap->port.dev,
>>  		 "Took %d chars from DMA buffer and %d chars from the FIFO\n",
>> @@ -1349,6 +1352,7 @@ __acquires(&uap->port.lock)
>>  {
>>  	pl011_fifo_to_tty(uap);
>>  
>> +	uap->irq_locked = 0;
>>  	spin_unlock(&uap->port.lock);
>>  	tty_flip_buffer_push(&uap->port.state->port);
>>  	/*
>> @@ -1483,6 +1487,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
>>  	int handled = 0;
>>  
>>  	spin_lock_irqsave(&uap->port.lock, flags);
>> +	uap->irq_locked = 1;
>>  	status = pl011_read(uap, REG_RIS) & uap->im;
>>  	if (status) {
>>  		do {
>> @@ -1502,7 +1507,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
>>  				      UART011_CTSMIS|UART011_RIMIS))
>>  				pl011_modem_status(uap);
>>  			if (status & UART011_TXIS)
>> -				pl011_tx_chars(uap, true);
>> +				pl011_tx_chars(uap, uap->irq_locked);
>>  
>>  			if (pass_counter-- == 0)
>>  				break;
>> -- 
>> 2.7.4
>>
> 
> [1] Untested, alternative "fix"
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 89ade21..1902071 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1307,6 +1307,13 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
>  /* Start TX with programmed I/O only (no DMA) */
>  static void pl011_start_tx_pio(struct uart_amba_port *uap)
>  {
> +	/*
> +	 * Avoid FIFO overfills if the TX IRQ is active:
> +	 * pl011_int() will comsume chars waiting in the xmit queue anyway.
> +	 */
> +	if (uap->im & UART011_TXIM)
> +		return;
> +
>  	if (pl011_tx_chars(uap, false)) {
>  		uap->im |= UART011_TXIM;
>  		pl011_write(uap->im, uap, REG_IMSC);
> 
