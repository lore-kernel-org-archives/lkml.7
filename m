Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783BCC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB2E20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403808AbfFKFze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:55:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57051 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390485AbfFKFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:55:34 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1haZkp-0004O3-AA; Tue, 11 Jun 2019 07:55:31 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1haZko-0000Nw-Hl; Tue, 11 Jun 2019 07:55:30 +0200
Date:   Tue, 11 Jun 2019 07:55:30 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     daniel.baluta@nxp.com
Cc:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com
Subject: Re: [RFC PATCH 2/2] imx: mailbox: Introduce TX doorbell with ACK
Message-ID: <20190611055530.sl3krujmcqnq6ntt@pengutronix.de>
References: <20190610141609.17559-1-daniel.baluta@nxp.com>
 <20190610141609.17559-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610141609.17559-3-daniel.baluta@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:34:37 up 24 days, 10:52, 45 users,  load average: 0.00, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jun 10, 2019 at 10:16:09PM +0800, daniel.baluta@nxp.com wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> TX doorbell with ACK will allow us to push the doorbell ring button
> (trigger GIR) and also will allow us to handle the response from DSP.
> 
> DSP firmware found on i.MX8 boards implements a duplex
> communication protocol over MU channels.
> 
> On the host side (Linux) we need to plugin into Sound Open Firmware IPC
> communication infrastructure which handles all the details (e.g message
> queuing, tx/rx logic) [1] and the users are only required to provide the
> following callbacks:
> 
>   - send_msg (for Tx)
>   - irq_handler (Ack of Tx, request from DSP)
> 
> In order to implement send_msg and irq_handler we will use two MU
> channels:
> 	* channel #0, TX doorbell with ACK
> 	* channel #1, RX doorbell
> 
> Sending a request Host -> DSP (channel #0)
>   - send_msg callback
> 	- write data into SHMEM
> 	- push doorbell ring button (trigger GIR)
>  - irq handler
> 	- handle DSP request (channel #1)
> 	  - read SHMEM and trigger SOF IPC state machine
> 	  - send ACK (push doorbell ring button for channel #1)
> 	- handle DSP response (ACK) (channel #0)
> 	  - read SHMEM and trigger IPC state machine
> 
> The easisest way to implement this is to directly access the MU
> registers but since the MU is abstracted using the mailbox interface
> we need to use that instead.
> 
> [1] https://elixir.bootlin.com/linux/v5.2-rc4/source/sound/soc/sof/ipc.c
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 9f74dee1a58c..3a91611e17d2 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -42,6 +42,7 @@ enum imx_mu_chan_type {
>  	IMX_MU_TYPE_RX,		/* Rx */
>  	IMX_MU_TYPE_TXDB,	/* Tx doorbell */
>  	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
> +	IMX_MU_TYPE_TXDB_ACK	/* Tx doorbell with Ack */
>  };
>  
>  struct imx_mu_con_priv {
> @@ -124,6 +125,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
>  			(ctrl & IMX_MU_xCR_RIEn(cp->idx));
>  		break;
>  	case IMX_MU_TYPE_RXDB:
> +	case IMX_MU_TYPE_TXDB_ACK:
>  		val &= IMX_MU_xSR_GIPn(cp->idx) &
>  			(ctrl & IMX_MU_xCR_GIEn(cp->idx));
>  		break;
> @@ -200,6 +202,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
>  		imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(cp->idx), 0);
>  		break;
>  	case IMX_MU_TYPE_RXDB:
> +	case IMX_MU_TYPE_TXDB_ACK:
>  		imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIEn(cp->idx), 0);
>  		break;
>  	default:
> -- 
> 2.17.1

If I see it correctly, with your implementation  the mbox client
communication on channel 0 will look as follow:
mbox_client -> send_msg()
            /* sheduling of mbox_chan_txdone tasklet is avoided */
mbox_client <- cl->rx_callback()
mbox_client -> mbox_client_txdone()
mbox_client -> send_msg()

Without your patch you will need to register tx and rx doorbell
channels and the communication will looks like this:
mbox_client -> send_msg()
mbox_client <- mbox_chan_txdone() /* dummy notification, can be ignored */
mbox_client <- cl->rx_callback()
mbox_client -> send_msg()

I assume, you are trying to optimize it and avoid dummy
mbox_chan_txdone() notification. Correct?

The problem is, that current mailbox-framework will set txdone_method
inside of mbox_controller_register() for all channels even if
imx-mailbox has different types of channels.

The problem with your patch is, that it will silently merge two channels
(TXDB and RXDB) and not setting actual ACK by controller - mbox_chan_txdone().
Not sure, why we need to merge it in this case.

So, with current imx_mailbox implementation your firmware should work as
is. You will need to register two separate channels for TXDB and
RXDB. It will run with some overhead by triggering txdone tasklet in 
imx-mailbox driver.

If this overhead is a problem, then this should be fixed.
Merging two doorbell  channels in to one with ACK support is nice,
but will introduce more issues if we need other doorbell channels
without ACK support on same controller 

I personally would prefer to to extend mailbox framework to support
controllers with mixed channel types and remove dummy txdone tasklet
from imx-mailbox.

Since we already initialize part of &mbox->chans[i] by imx-mailbox driver,
we can set proper chan->txdone_method as well. So we need only to
prevent mbox_controller_register() to overwrite it.

Regards,
Oleksij.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
