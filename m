Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F534C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38AC2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfHAUda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:33:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38015 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:33:30 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1htHlI-0003TO-CA; Thu, 01 Aug 2019 22:33:20 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1htHlE-0001p3-TM; Thu, 01 Aug 2019 22:33:16 +0200
Date:   Thu, 1 Aug 2019 22:33:16 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] serial: mctrl_gpio: Avoid probe failures in case
 of missing gpiolib
Message-ID: <20190801203316.7ntlv6hequmddfxu@pengutronix.de>
References: <20190801184505.17239-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801184505.17239-1-frieder.schrempf@kontron.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 06:45:21PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() and
> mctrl_gpio_init_noauto() will currently return an error pointer with
> -ENOSYS. As the mctrl GPIOs are usually optional, drivers need to
> check for this condition to allow continue probing.
> 
> To avoid the need for this check in each driver, we return NULL
> instead, as all the mctrl_gpio_*() functions are skipped anyway.
> We also adapt mctrl_gpio_to_gpiod() to be in line with this change.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

nitpick: put your S-o-b last.

> ---
> Changes in v2
> =============
> * Move the sh_sci changes to a separate patch
> * Add a patch for the 8250 driver
> * Add Fabio's R-b tag
> ---
>  drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
>  drivers/tty/serial/serial_mctrl_gpio.h | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 2b400189be91..54c43e02e375 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>  				      enum mctrl_gpio_idx gidx)
>  {
> +	if (gpios == NULL)
> +		return NULL;
> +

I wonder why you need this. If GPIOLIB is off this code isn't active and
with GPIOLIB calling mctrl_gpio_to_gpiod with a gpios == NULL is a bug
that IMHO should not be silently ignored.

Am I missing something (again)?

>  	return gpios->gpio[gidx];
>  }

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
