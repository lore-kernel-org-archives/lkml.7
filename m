Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D0EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9D62075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfC2VI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:08:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38341 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfC2VI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:08:56 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h9yk8-0000iv-Mq; Fri, 29 Mar 2019 22:08:52 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h9yk7-0006bi-Kz; Fri, 29 Mar 2019 22:08:51 +0100
Date:   Fri, 29 Mar 2019 22:08:51 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     laurentiu.tudor@nxp.com
Cc:     linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: don't leak the i2c adapter on error
Message-ID: <20190329210851.gi57f5jamxio3mxr@pengutronix.de>
References: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 02:48:17PM +0200, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Make sure to free the i2c adapter on the error exit path.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

>  drivers/i2c/busses/i2c-imx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 42fed40198a0..2dfd33f48cd8 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1169,11 +1169,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	/* Init DMA config if supported */
>  	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
>  	if (ret < 0)
> -		goto clk_notifier_unregister;
> +		goto del_adapter;
>  
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  	return 0;   /* Return OK */
>  
> +del_adapter:
> +	 i2c_del_adapter(&i2c_imx->adapter);

Indention problem here, please remove the superflous space here.

Other than that:

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: e1ab9a468e3b ("i2c: imx: improve the error handling in i2c_imx_dma_request()")

Thanks
Uwe

>  clk_notifier_unregister:
>  	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>  rpm_disable:
> -- 
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
