Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C125AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1F920820
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394973AbfITHGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:06:07 -0400
Received: from mx1.emlix.com ([188.40.240.192]:60668 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394945AbfITHGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:06:07 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id A4BD55FB2E;
        Fri, 20 Sep 2019 09:06:03 +0200 (CEST)
Subject: Re: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
To:     Andy Duan <fugang.duan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190919145114.13006-1-philipp.puschmann@emlix.com>
 <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <ac67f010-1b2c-6996-f542-ab955ca86489@emlix.com>
Date:   Fri, 20 Sep 2019 09:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am 20.09.19 um 05:42 schrieb Andy Duan:
> From: Philipp Puschmann <philipp.puschmann@emlix.com> Sent: Thursday, September 19, 2019 10:51 PM
>> Using only 4 DMA periods for UART RX is very few if we have a high frequency
>> of small transfers - like in our case using Bluetooth with many small packets
>> via UART - causing many dma transfers but in each only filling a fraction of a
>> single buffer. Such a case may lead to the situation that DMA RX transfer is
>> triggered but no free buffer is available. When this happens dma channel ist
>> stopped - with the patch
>> "dmaengine: imx-sdma: fix dma freezes" temporarily only - with the possible
>> consequences that:
>> with disabled hw flow control:
>>   If enough data is incoming on UART port the RX FIFO runs over and
>>   characters will be lost. What then happens depends on upper layer.
>>
>> with enabled hw flow control:
>>   If enough data is incoming on UART port the RX FIFO reaches a level
>>   where CTS is deasserted and remote device sending the data stops.
>>   If it fails to stop timely the i.MX' RX FIFO may run over and data
>>   get lost. Otherwise it's internal TX buffer may getting filled to
>>   a point where it runs over and data is again lost. It depends on
>>   the remote device how this case is handled and if it is recoverable.
>>
>> Obviously we want to avoid having no free buffers available. So we decrease
>> the size of the buffers and increase their number and the total buffer size.
>>
>> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
>> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
>> ---
>>
>> Changelog v3:
>>  - enhance description
>>
>> Changelog v2:
>>  - split this patch from series "Fix UART DMA freezes for iMX6"
>>  - add Reviewed-by tag
>>
>>  drivers/tty/serial/imx.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
>> 87c58f9f6390..51dc19833eab 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1034,8 +1034,6 @@ static void imx_uart_timeout(struct timer_list *t)
>>         }
>>  }
>>
>> -#define RX_BUF_SIZE    (PAGE_SIZE)
>> -
>>  /*
>>   * There are two kinds of RX DMA interrupts(such as in the MX6Q):
>>   *   [1] the RX DMA buffer is full.
>> @@ -1118,7 +1116,8 @@ static void imx_uart_dma_rx_callback(void
>> *data)  }
>>
>>  /* RX DMA buffer periods */
>> -#define RX_DMA_PERIODS 4
>> +#define RX_DMA_PERIODS 16
>> +#define RX_BUF_SIZE    (PAGE_SIZE / 4)
>>
> Why to decrease the DMA RX buffer size here ?
> 
> The current DMA implementation support DMA cyclic mode, one SDMA BD receive one Bluetooth frame can
> bring better performance.
> As you know, for L2CAP, a maximum transmission unit (MTU) associated with the largest Baseband payload
> is 341 bytes for DH5 packets.
> 
> So I suggest to increase RX_BUF_SIZE along with RX_DMA_PERIODS to feasible value.

I debugged and developed this patches on a system with a 4.15 kernel. When prepared for upstream i have adapted
some details and missed a important thing here. It should say:

+#define RX_BUF_SIZE    (RX_DMA_PERIODS * PAGE_SIZE / 4)

Yes, i wanted to increase the total buffer size too, even wrote it in the description.
I will prepare a version 4, thanks for the hint.

Just for info: A single RX DMA period aka buffer can be filled with mutliple packets in regard of the upper layer, here BT.


Regards,
Philipp
> 
> Andy
> 
>>  static int imx_uart_start_rx_dma(struct imx_port *sport)  {
>> --
>> 2.23.0
> 

