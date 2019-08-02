Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B0CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C212184E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404113AbfHBIYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:24:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40577 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfHBIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:24:51 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1htSrk-0001JP-AM; Fri, 02 Aug 2019 10:24:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1htSrh-0000NT-R6; Fri, 02 Aug 2019 10:24:41 +0200
Date:   Fri, 2 Aug 2019 10:24:41 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] serial: mctrl_gpio: Avoid probe failures in case
 of missing gpiolib
Message-ID: <20190802082441.udsrc5ev4nwj7abz@pengutronix.de>
References: <20190801184505.17239-1-frieder.schrempf@kontron.de>
 <20190801203316.7ntlv6hequmddfxu@pengutronix.de>
 <011ac0ac-571e-b898-2b2d-89b9a771b0c1@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <011ac0ac-571e-b898-2b2d-89b9a771b0c1@kontron.de>
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

On Fri, Aug 02, 2019 at 07:56:54AM +0000, Schrempf Frieder wrote:
> On 01.08.19 22:33, Uwe Kleine-König wrote:
> > On Thu, Aug 01, 2019 at 06:45:21PM +0000, Schrempf Frieder wrote:
> >> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> >> index 2b400189be91..54c43e02e375 100644
> >> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> >> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> >> @@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
> >>   struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
> >>   				      enum mctrl_gpio_idx gidx)
> >>   {
> >> +	if (gpios == NULL)
> >> +		return NULL;
> >> +
> > 
> > I wonder why you need this. If GPIOLIB is off this code isn't active and
> > with GPIOLIB calling mctrl_gpio_to_gpiod with a gpios == NULL is a bug
> > that IMHO should not be silently ignored.
> > 
> > Am I missing something (again)?
> 
> No, you're right. My thoughts were, that if the mctrl_gpio functions are 
> allowed to be passed a NULL pointer in general, they all should have a 
> NULL check, even if in the current context (GPIOLIB disabled) this code 
> is not active. Apparently there are other cases when a NULL pointer is 
> passed, see [1]. So you can't really consider gpios == NULL to be a bug 
> as this seems to be allowed in general.

OK, then this is another separate commit, right? Preferably with a
comment pointing to drivers that use mctrl_gpio before being
initialized.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
