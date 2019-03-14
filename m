Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A4DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0456B2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfCNIdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:33:31 -0400
Received: from mout01.posteo.de ([185.67.36.141]:33797 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfCNIdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:33:31 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 14BFD160062
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 09:25:42 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 44Khc24ptWz6tmF;
        Thu, 14 Mar 2019 09:25:38 +0100 (CET)
Subject: Re: [PATCH] tty: atmel_serial: fix a NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190314071759.18845-1-kjlu@umn.edu>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <4369f8eb-e8d2-1f78-6fd5-f878ffbdee90@sorico.fr>
Date:   Thu, 14 Mar 2019 09:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314071759.18845-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Good catch !
Le 14/03/2019 à 08:17, Kangjie Lu a écrit :
> In case dmaengine_prep_dma_cyclic fails, the fix return a proper
> error code to avoid NULL pointer dereference.
> 
you could add:
Fixes: 34df42f59a60 ("serial: at91: add rx dma support")
So that -stable branches get this.

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/tty/serial/atmel_serial.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 05147fe24343..cf560d05008c 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1237,8 +1237,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_set(DMA_CYCLIC, mask);
>  
>  	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
> -	if (atmel_port->chan_rx == NULL)
> +	if (atmel_port->chan_rx == NULL) {
> +		ret = -EINVAL;
>  		goto chan_err;
> +	}
>  	dev_info(port->dev, "using %s for rx DMA transfers\n",
>  		dma_chan_name(atmel_port->chan_rx));
>  
> @@ -1257,6 +1259,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  
>  	if (!nent) {
>  		dev_dbg(port->dev, "need to release resource of dma\n");
> +		ret = -EINVAL;
>  		goto chan_err;
>  	} else {
>  		dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n", __func__,
> @@ -1288,6 +1291,11 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  					 sg_dma_len(&atmel_port->sg_rx)/2,
>  					 DMA_DEV_TO_MEM,
>  					 DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(port->dev, "Preparing DMA cyclic failed\n");
> +		ret = -ENOMEM;
IMHO, we don't really know why dmaengine_prep_dma_cyclic() failed, it
could be because it's already in use, or bad value, or...
(and anyway, we just check if the return value is < 0 in atmel _startup.)
Is there a specific reason you choose -ENOMEM ?
If not, maybe keeping this patch smaller with a simple dev_err()+goto
here would be a better choice.

> +		goto chan_err;
> +	}
>  	desc->callback = atmel_complete_rx_dma;
>  	desc->callback_param = port;
>  	atmel_port->desc_rx = desc;
> @@ -1300,7 +1308,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	atmel_port->use_dma_rx = 0;
>  	if (atmel_port->chan_rx)
>  		atmel_release_rx_dma(port);
> -	return -EINVAL;
> +	return ret;
>  }
>  
>  static void atmel_uart_timer_callback(struct timer_list *t)
> 

Thanks !

Richard.
