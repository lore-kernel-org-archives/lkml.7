Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0481C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8275D20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCRH2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:28:31 -0400
Received: from mout02.posteo.de ([185.67.36.142]:57669 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfCRH2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:28:31 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C39B82400FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 08:28:28 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 44N7884Lwgz9rxH;
        Mon, 18 Mar 2019 08:28:24 +0100 (CET)
Subject: Re: [PATCH] tty: atmel_serial: fix a NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <d8978a94-23fc-3610-e3da-5e1da2d86914@sorico.fr>
 <20190315171606.6282-1-kjlu@umn.edu>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <cb9a62d2-1d91-a9d6-22ed-1e19ca1d96c7@sorico.fr>
Date:   Mon, 18 Mar 2019 08:28:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315171606.6282-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/03/2019 à 18:16, Kangjie Lu a écrit :
> In case dmaengine_prep_dma_cyclic fails, the fix returns a proper
> error code to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Fixes: 34df42f59a60 ("serial: at91: add rx dma support")
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> 
> ---
> V2: simplified the patch as suggested by
> Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 05147fe24343..41b728d223d1 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1288,6 +1288,10 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  					 sg_dma_len(&atmel_port->sg_rx)/2,
>  					 DMA_DEV_TO_MEM,
>  					 DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(port->dev, "Preparing DMA cyclic failed\n");
> +		goto chan_err;
> +	}
>  	desc->callback = atmel_complete_rx_dma;
>  	desc->callback_param = port;
>  	atmel_port->desc_rx = desc;
> 

Thanks !

Richard
