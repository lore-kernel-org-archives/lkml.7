Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E15C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A4820896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfFKEdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:33:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51647 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfFKEdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:33:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1haYTE-0005Bb-BD; Tue, 11 Jun 2019 06:33:16 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1haYTD-0005xx-CH; Tue, 11 Jun 2019 06:33:15 +0200
Date:   Tue, 11 Jun 2019 06:33:15 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     daniel.baluta@nxp.com
Cc:     jassisinghbrar@gmail.com, aisheng.dong@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] mailbox: imx: Clear GIEn bit at shutdown
Message-ID: <20190611043315.mr72owvjrxkegdww@pengutronix.de>
References: <20190610141609.17559-1-daniel.baluta@nxp.com>
 <20190610141609.17559-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610141609.17559-2-daniel.baluta@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:27:45 up 24 days, 10:45, 45 users,  load average: 0.10, 0.05,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:16:08PM +0800, daniel.baluta@nxp.com wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> GIEn is enabled at startup for RX doorbell mailboxes so
> we need to clear the bit at shutdown in order to avoid
> leaving the interrupt line enabled.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Please send  bug fixes separately from RFC patches.

You can add my
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
>  drivers/mailbox/imx-mailbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 25be8bb5e371..9f74dee1a58c 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -217,8 +217,8 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
>  	if (cp->type == IMX_MU_TYPE_TXDB)
>  		tasklet_kill(&cp->txdb_tasklet);
>  
> -	imx_mu_xcr_rmw(priv, 0,
> -		   IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp->idx));
> +	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx) |
> +		       IMX_MU_xCR_RIEn(cp->idx) | IMX_MU_xCR_GIEn(cp->idx));
>  
>  	free_irq(priv->irq, chan);
>  }
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
