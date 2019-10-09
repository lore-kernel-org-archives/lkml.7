Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D2AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF9020B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfJIGx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:53:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60835 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJIGx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:53:28 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI5qZ-0006pi-5k; Wed, 09 Oct 2019 08:53:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI5qV-0002hI-D8; Wed, 09 Oct 2019 08:53:15 +0200
Date:   Wed, 9 Oct 2019 08:53:15 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Message-ID: <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 09, 2019 at 02:18:31PM +0800, Anson Huang wrote:
> All i.MX SoCs except i.MX1 have ONLY 1 IRQ, so it is better to check
> the IRQ count before getting second/third IRQ to avoid below error
> message during probe:
> 
> [    0.726219] imx-uart 30860000.serial: IRQ index 1 not found
> [    0.731329] imx-uart 30860000.serial: IRQ index 2 not found

This message was introduced in commit
7723f4c5ecdb8d832f049f8483beb0d1081cedf6 for 5.4-rc1. I added the
involved people to the recipents of this mail.

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 504d81c..081fa82 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2198,6 +2198,7 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	u32 ucr1;
>  	struct resource *res;
>  	int txirq, rxirq, rtsirq;
> +	int irq_count;
>  
>  	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
>  	if (!sport)
> @@ -2220,9 +2221,17 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> +	irq_count = platform_irq_count(pdev);
> +	if (irq_count < 0)
> +		return irq_count;
> +
>  	rxirq = platform_get_irq(pdev, 0);
> -	txirq = platform_get_irq(pdev, 1);
> -	rtsirq = platform_get_irq(pdev, 2);
> +	if (irq_count > 1) {
> +		txirq = platform_get_irq(pdev, 1);
> +		rtsirq = platform_get_irq(pdev, 2);
> +	} else {
> +		txirq = rtsirq = -ENXIO;
> +	}

The patch is fine given the changed behaviour of platform_get_irq. I
wonder if it is sensible to introduce a variant of platform_get_irq (say
platform_get_irq_nowarn) that behaves like __platform_get_irq does
today. Then the imx driver would just call platform_get_irq_nowarn
without having to check the number of available irqs first.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
