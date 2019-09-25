Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D14C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602E321D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKsyaL5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438945AbfIYPOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:14:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39376 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfIYPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:14:25 -0400
Received: by mail-io1-f67.google.com with SMTP id a1so14795224ioc.6;
        Wed, 25 Sep 2019 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6zI88mhTY3FSkVripqtLkmrpr2Cb14XrYzIZTS8FIo=;
        b=QKsyaL5hH7VPJ0Dq7i11j1RFrrMMiWB0ucJFpKVjvJByeOQQzhBPFVxQoWabt2BKcT
         od0Ca3somYdNuvpw8tbPaKrh0e9jftevqwkR4bf5gkBEzcSd1ZvpvVYyXQwW/+mlc5xI
         4x7POTRU4/iUmf2fpCSjsLs/dujxL8QT08M762O6OBHFEKnAeOblvOxpa6FuHKVt6zyU
         SEDWE6pCc+AYs11XGiYH31Nh+DyJqBfWYkSuPn8yGfXY954dMaM1LcD2MfdUC47iBhge
         PhFBpH5N9I6UgCZXLL8XAx2iAU2V1GMk60Za/mNUgkHPWnhFW0432TDkduuWaM5DhDOl
         qsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6zI88mhTY3FSkVripqtLkmrpr2Cb14XrYzIZTS8FIo=;
        b=nfuTXqHK15BWAxO6ox4ASXhkktv0WAdX2Ql3bBSs73hmY/7RtvNt6YvFXhowOFT/+7
         elSJkAePVYvILnAn51Y0WyLm53M3HlqulvGaW3qC6CAN/zvryxDuDvncRV8j0uFNEmI3
         fgE8RSFqcFZ5FZi6cLVoIVHR+LsBvCamGXMIfBAJb6qY4hiIqdJciRNj/w0hyW5bE7Wx
         Al0udgH/Yy07wF+CYNEHkd1394MNi1kgMjRydd8eGLoNz0TUsUuWtJCyRu4htiXNjLHK
         Kh1CP6zP2hNa4fGoSs5UTsBF3hXRoRMcKzxW+fdF8Q7RSJ4Ilm6DBMZZDP5ncEa+FfVG
         dX0g==
X-Gm-Message-State: APjAAAVoxVLuKCDAeZkskrvrm5yRcQ6f9thM6gZuUq+AZjgHih0t6sZM
        +FXuQhU+K7JVPR6qNG2nNoRVLba18Qs3Iv1G6Eo=
X-Google-Smtp-Source: APXvYqw15ECXLOWGrCGyLCk7r+Bo8SgwhjsI3y/lq+h+ziLSD35NaayAVSu9fKmOB5oYeZSvsaBVLzPJB8Mm+8anwhM=
X-Received: by 2002:a6b:b213:: with SMTP id b19mr6005281iof.58.1569424464024;
 Wed, 25 Sep 2019 08:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190919145114.13006-1-philipp.puschmann@emlix.com>
 <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <ac67f010-1b2c-6996-f542-ab955ca86489@emlix.com>
In-Reply-To: <ac67f010-1b2c-6996-f542-ab955ca86489@emlix.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 25 Sep 2019 10:14:12 -0500
Message-ID: <CAHCN7xL0BKmt8xrhuB4rrvOqkCM5AUJ6YAzbcU8eNDXbzj4fZg@mail.gmail.com>
Subject: Re: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
Cc:     Andy Duan <fugang.duan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 2:06 AM Philipp Puschmann
<philipp.puschmann@emlix.com> wrote:
>
> Hi Andy,
>
> Am 20.09.19 um 05:42 schrieb Andy Duan:
> > From: Philipp Puschmann <philipp.puschmann@emlix.com> Sent: Thursday, September 19, 2019 10:51 PM
> >> Using only 4 DMA periods for UART RX is very few if we have a high frequency
> >> of small transfers - like in our case using Bluetooth with many small packets
> >> via UART - causing many dma transfers but in each only filling a fraction of a
> >> single buffer. Such a case may lead to the situation that DMA RX transfer is
> >> triggered but no free buffer is available. When this happens dma channel ist
> >> stopped - with the patch
> >> "dmaengine: imx-sdma: fix dma freezes" temporarily only - with the possible
> >> consequences that:

I have an i.MX6Q with Wl1837MOD on UART 2 with flow control, and I am
getting Bluetooth transfer timeouts.
(see imx6-logicpd-som.dtsi)

On top of 5.3.1, I have installed:

dmaengine: imx-sdma: fix buffer ownership
dmaengine: imx-sdma: fix dma freezes
dmaengine: imx-sdma: drop redundant variable
dmaengine: imx-sdma: fix kernel hangs with SLUB slab allocator
serial: imx: adapt rx buffer and dma periods

and I still get timeouts:

[   66.632006] Bluetooth: hci0: command 0xff36 tx timeout
[   76.790499] Bluetooth: hci0: command 0x1001 tx timeout
[   87.110488] Bluetooth: hci0: command 0xff36 tx timeout
[   97.270507] Bluetooth: hci0: command 0x1001 tx timeout
[  107.590457] Bluetooth: hci0: command 0xff36 tx timeout
[  117.750477] Bluetooth: hci0: command 0x1001 tx timeout
[  226.390499] Bluetooth: hci0: command 0xfe38 tx timeout
[  231.590735] Bluetooth: hci0: command tx timeout

I did a bisect and found the start of my problems came from

361deb7243d2 ("dmaengine: dmatest: wrap src & dst data into a struct")

This happened sometime between v5.0 and v5.1

Is there a patch I missed somewhere?  Do I need to change my device
tree configuration somehow to allocate the proper DMA memory?



> >> with disabled hw flow control:
> >>   If enough data is incoming on UART port the RX FIFO runs over and
> >>   characters will be lost. What then happens depends on upper layer.
> >>
> >> with enabled hw flow control:
> >>   If enough data is incoming on UART port the RX FIFO reaches a level
> >>   where CTS is deasserted and remote device sending the data stops.
> >>   If it fails to stop timely the i.MX' RX FIFO may run over and data
> >>   get lost. Otherwise it's internal TX buffer may getting filled to
> >>   a point where it runs over and data is again lost. It depends on
> >>   the remote device how this case is handled and if it is recoverable.
> >>
> >> Obviously we want to avoid having no free buffers available. So we decrease
> >> the size of the buffers and increase their number and the total buffer size.
> >>
> >> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> >> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> >> ---
> >>
> >> Changelog v3:
> >>  - enhance description
> >>
> >> Changelog v2:
> >>  - split this patch from series "Fix UART DMA freezes for iMX6"
> >>  - add Reviewed-by tag
> >>
> >>  drivers/tty/serial/imx.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> >> 87c58f9f6390..51dc19833eab 100644
> >> --- a/drivers/tty/serial/imx.c
> >> +++ b/drivers/tty/serial/imx.c
> >> @@ -1034,8 +1034,6 @@ static void imx_uart_timeout(struct timer_list *t)
> >>         }
> >>  }
> >>
> >> -#define RX_BUF_SIZE    (PAGE_SIZE)
> >> -
> >>  /*
> >>   * There are two kinds of RX DMA interrupts(such as in the MX6Q):
> >>   *   [1] the RX DMA buffer is full.
> >> @@ -1118,7 +1116,8 @@ static void imx_uart_dma_rx_callback(void
> >> *data)  }
> >>
> >>  /* RX DMA buffer periods */
> >> -#define RX_DMA_PERIODS 4
> >> +#define RX_DMA_PERIODS 16
> >> +#define RX_BUF_SIZE    (PAGE_SIZE / 4)
> >>
> > Why to decrease the DMA RX buffer size here ?
> >
> > The current DMA implementation support DMA cyclic mode, one SDMA BD receive one Bluetooth frame can
> > bring better performance.
> > As you know, for L2CAP, a maximum transmission unit (MTU) associated with the largest Baseband payload
> > is 341 bytes for DH5 packets.
> >
> > So I suggest to increase RX_BUF_SIZE along with RX_DMA_PERIODS to feasible value.
>
> I debugged and developed this patches on a system with a 4.15 kernel. When prepared for upstream i have adapted
> some details and missed a important thing here. It should say:
>
> +#define RX_BUF_SIZE    (RX_DMA_PERIODS * PAGE_SIZE / 4)
>
> Yes, i wanted to increase the total buffer size too, even wrote it in the description.
> I will prepare a version 4, thanks for the hint.
>
> Just for info: A single RX DMA period aka buffer can be filled with mutliple packets in regard of the upper layer, here BT.
>
>
> Regards,
> Philipp
> >
> > Andy
> >
> >>  static int imx_uart_start_rx_dma(struct imx_port *sport)  {
> >> --
> >> 2.23.0
> >
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
