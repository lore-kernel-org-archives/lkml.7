Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9DAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8961A222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptL+t++P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfIZToX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:44:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41200 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfIZToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:44:23 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so9679958ioh.8;
        Thu, 26 Sep 2019 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YaOJjbeJ4vHzFNCKN4Rfl7SNbQO++40kW4opqhFvjE=;
        b=ptL+t++PhjIDsGKfuLy0BchccV5YdocaOsRsXZ/4JqKqUKoQzhFSC1NY4npM9rE3Yl
         C7Zl9VNtkmAwuniXVUGj4fMyTDLJ9ep+95WejAowbtGq6FHtnA2xpNZVLKkTBrGnzor0
         0V+gRFuTh35NxWLvtKPNWwtsROhtajgumBlMHA4ZM5svWHQtB83GqJQoIMPvnDLX0Mog
         7cFhKRgDTuCirRwxX668mKmMZkEuY9LObevYVy1kBjI8F/Gm4TsEt4zLDYd6uSq7cZCt
         gi9GXWN/AxMMuWydGrQclQzQp/+PcBWPKz+vNmn/hh8LJXIC7WXRfqGKq1Ck+jfEHf1j
         qu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YaOJjbeJ4vHzFNCKN4Rfl7SNbQO++40kW4opqhFvjE=;
        b=UevvZPYC0oERjnJCZc2pso/1jVu71iwvggUtlT5hqDw9Pz/IyPp9uj1lUdemN5TeQx
         y3M3EVrGpm7wYXX9sqSzqoZGlBbCfwfSfXwnUv2204z7Whm0RspeKr6mM6EKpVAMqxRp
         3aOaHdRmnFCnV8luqDV7GV2qnfANPC1RKZ6750iKw8GrC8DBgefZuIj/P7cMt51WaZYM
         wEG9oDSIwzrcsTO+P3XWxmoOOqMjaGEemfgro9BCoaR4mNfvxXkFyd3aG5SKOhgO+75W
         GxItr5WbNDroD+0WRPQMDo1DBS1J7zxWPV73pJkzfaJWMI7E/e5WqaReE1SPtxj99Cp3
         scUw==
X-Gm-Message-State: APjAAAX+4J9zmiZmpI0kINxseiE+rvneaUiCnTl1wgpRRXGbwOqAbhFl
        Zw5GKmZjCQSx2r8KpTrGAHM/C+hRNZXlCo8yrvI=
X-Google-Smtp-Source: APXvYqws94RCz1OEKmJWcCJfFYz8odw3snwroxEbJRlT5VqNIjb8opn290GiegEG8UnQeVF3x/P4koKd12cnxdqwU+Y=
X-Received: by 2002:a92:3f0a:: with SMTP id m10mr357121ila.158.1569527062022;
 Thu, 26 Sep 2019 12:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190919145114.13006-1-philipp.puschmann@emlix.com>
 <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <ac67f010-1b2c-6996-f542-ab955ca86489@emlix.com> <CAHCN7xL0BKmt8xrhuB4rrvOqkCM5AUJ6YAzbcU8eNDXbzj4fZg@mail.gmail.com>
 <15be848facd5e80222e5db30c61fe72f82a85713.camel@analog.com>
In-Reply-To: <15be848facd5e80222e5db30c61fe72f82a85713.camel@analog.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 26 Sep 2019 14:44:10 -0500
Message-ID: <CAHCN7xK=kxEFiuUEX=q4R3XEyeaAp+HGFCUpYkYUESMhqwMA6A@mail.gmail.com>
Subject: Re: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "philipp.puschmann@emlix.com" <philipp.puschmann@emlix.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "fugang.duan@nxp.com" <fugang.duan@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 1:37 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Wed, 2019-09-25 at 10:14 -0500, Adam Ford wrote:
> > [External]
> >
> > On Fri, Sep 20, 2019 at 2:06 AM Philipp Puschmann
> > <philipp.puschmann@emlix.com> wrote:
> > > Hi Andy,
> > >
> > > Am 20.09.19 um 05:42 schrieb Andy Duan:
> > > > From: Philipp Puschmann <philipp.puschmann@emlix.com> Sent: Thursday,
> > > > September 19, 2019 10:51 PM
> > > > > Using only 4 DMA periods for UART RX is very few if we have a high
> > > > > frequency
> > > > > of small transfers - like in our case using Bluetooth with many
> > > > > small packets
> > > > > via UART - causing many dma transfers but in each only filling a
> > > > > fraction of a
> > > > > single buffer. Such a case may lead to the situation that DMA RX
> > > > > transfer is
> > > > > triggered but no free buffer is available. When this happens dma
> > > > > channel ist
> > > > > stopped - with the patch
> > > > > "dmaengine: imx-sdma: fix dma freezes" temporarily only - with the
> > > > > possible
> > > > > consequences that:
> >
> > I have an i.MX6Q with Wl1837MOD on UART 2 with flow control, and I am
> > getting Bluetooth transfer timeouts.
> > (see imx6-logicpd-som.dtsi)
> >
> > On top of 5.3.1, I have installed:
> >
> > dmaengine: imx-sdma: fix buffer ownership
> > dmaengine: imx-sdma: fix dma freezes
> > dmaengine: imx-sdma: drop redundant variable
> > dmaengine: imx-sdma: fix kernel hangs with SLUB slab allocator
> > serial: imx: adapt rx buffer and dma periods
> >
> > and I still get timeouts:
> >
> > [   66.632006] Bluetooth: hci0: command 0xff36 tx timeout
> > [   76.790499] Bluetooth: hci0: command 0x1001 tx timeout
> > [   87.110488] Bluetooth: hci0: command 0xff36 tx timeout
> > [   97.270507] Bluetooth: hci0: command 0x1001 tx timeout
> > [  107.590457] Bluetooth: hci0: command 0xff36 tx timeout
> > [  117.750477] Bluetooth: hci0: command 0x1001 tx timeout
> > [  226.390499] Bluetooth: hci0: command 0xfe38 tx timeout
> > [  231.590735] Bluetooth: hci0: command tx timeout
> >
> > I did a bisect and found the start of my problems came from
> >
> > 361deb7243d2 ("dmaengine: dmatest: wrap src & dst data into a struct")
>
> That commit only touches `drivers/dma/dmatest.c`
> Are you using that module?
>
> It's a "unit-test" module for testing DMAengine drivers.
> The only way that can break anything [from what I can tell], is if it is
> being run. It will probably put the DMA into a weird state (it is a test-
> module after-all), and it may require some DMAs to be reset.
> I admit it would be nice that the test-module would put the DMA back into a
> normal-working state, but that effort could be big for some cases.

I will bisect it again.  I removed the CONFIG_DMATEST from the
omx_v6_v7_defconfig, and I still got the failure using Kernel 5.3.1,
so I'll work on this tomorrow and try to narrow it down better with
and without the test module installed.

adam
>
>
> >
> > This happened sometime between v5.0 and v5.1
> >
> > Is there a patch I missed somewhere?  Do I need to change my device
> > tree configuration somehow to allocate the proper DMA memory?
> >
> >
> >
> > > > > with disabled hw flow control:
> > > > >   If enough data is incoming on UART port the RX FIFO runs over and
> > > > >   characters will be lost. What then happens depends on upper
> > > > > layer.
> > > > >
> > > > > with enabled hw flow control:
> > > > >   If enough data is incoming on UART port the RX FIFO reaches a
> > > > > level
> > > > >   where CTS is deasserted and remote device sending the data stops.
> > > > >   If it fails to stop timely the i.MX' RX FIFO may run over and
> > > > > data
> > > > >   get lost. Otherwise it's internal TX buffer may getting filled to
> > > > >   a point where it runs over and data is again lost. It depends on
> > > > >   the remote device how this case is handled and if it is
> > > > > recoverable.
> > > > >
> > > > > Obviously we want to avoid having no free buffers available. So we
> > > > > decrease
> > > > > the size of the buffers and increase their number and the total
> > > > > buffer size.
> > > > >
> > > > > Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> > > > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > ---
> > > > >
> > > > > Changelog v3:
> > > > >  - enhance description
> > > > >
> > > > > Changelog v2:
> > > > >  - split this patch from series "Fix UART DMA freezes for iMX6"
> > > > >  - add Reviewed-by tag
> > > > >
> > > > >  drivers/tty/serial/imx.c | 5 ++---
> > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > > index
> > > > > 87c58f9f6390..51dc19833eab 100644
> > > > > --- a/drivers/tty/serial/imx.c
> > > > > +++ b/drivers/tty/serial/imx.c
> > > > > @@ -1034,8 +1034,6 @@ static void imx_uart_timeout(struct
> > > > > timer_list *t)
> > > > >         }
> > > > >  }
> > > > >
> > > > > -#define RX_BUF_SIZE    (PAGE_SIZE)
> > > > > -
> > > > >  /*
> > > > >   * There are two kinds of RX DMA interrupts(such as in the MX6Q):
> > > > >   *   [1] the RX DMA buffer is full.
> > > > > @@ -1118,7 +1116,8 @@ static void imx_uart_dma_rx_callback(void
> > > > > *data)  }
> > > > >
> > > > >  /* RX DMA buffer periods */
> > > > > -#define RX_DMA_PERIODS 4
> > > > > +#define RX_DMA_PERIODS 16
> > > > > +#define RX_BUF_SIZE    (PAGE_SIZE / 4)
> > > > >
> > > > Why to decrease the DMA RX buffer size here ?
> > > >
> > > > The current DMA implementation support DMA cyclic mode, one SDMA BD
> > > > receive one Bluetooth frame can
> > > > bring better performance.
> > > > As you know, for L2CAP, a maximum transmission unit (MTU) associated
> > > > with the largest Baseband payload
> > > > is 341 bytes for DH5 packets.
> > > >
> > > > So I suggest to increase RX_BUF_SIZE along with RX_DMA_PERIODS to
> > > > feasible value.
> > >
> > > I debugged and developed this patches on a system with a 4.15 kernel.
> > > When prepared for upstream i have adapted
> > > some details and missed a important thing here. It should say:
> > >
> > > +#define RX_BUF_SIZE    (RX_DMA_PERIODS * PAGE_SIZE / 4)
> > >
> > > Yes, i wanted to increase the total buffer size too, even wrote it in
> > > the description.
> > > I will prepare a version 4, thanks for the hint.
> > >
> > > Just for info: A single RX DMA period aka buffer can be filled with
> > > mutliple packets in regard of the upper layer, here BT.
> > >
> > >
> > > Regards,
> > > Philipp
> > > > Andy
> > > >
> > > > >  static int imx_uart_start_rx_dma(struct imx_port *sport)  {
> > > > > --
> > > > > 2.23.0
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
