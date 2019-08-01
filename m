Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224BE2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfHAJzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:55:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46879 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:55:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ht7o3-0000nO-Dh; Thu, 01 Aug 2019 11:55:31 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ht7o1-0006Fm-FK; Thu, 01 Aug 2019 11:55:29 +0200
Date:   Thu, 1 Aug 2019 11:55:29 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Message-ID: <20190801095529.dm3pvgts6cy6mbiq@pengutronix.de>
References: <20190801081524.22577-1-frieder.schrempf@kontron.de>
 <20190801084827.m42ci3amo37hmesi@pengutronix.de>
 <0674d68b-99fa-3408-1dd1-22dc84144b43@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0674d68b-99fa-3408-1dd1-22dc84144b43@kontron.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 09:28:33AM +0000, Schrempf Frieder wrote:
> Hi Uwe,
> 
> On 01.08.19 10:48, Uwe Kleine-König wrote:
> > On Thu, Aug 01, 2019 at 08:18:05AM +0000, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() will return
> >> -ENOSYS and cause the probing of the imx UART to fail. As the
> >> GPIOs are optional, we should continue probing in this case.
> > 
> > Is this really still the case? On which version did you hit this
> > problem?
> 
> Yes, I think it is. I used v5.2.5, that already has d99482673f95.
> 
> > 
> > I would expect that is gone with
> > d99482673f950817b30caf3fcdfb31179b050ce1 if not earlier.
> 
> I think this is a different problem. If CONFIG_GPIOLIB is disabled, 
> mctrl_gpio_init() returns -ENOSYS unconditionally here: [1]. The 
> existing patch (d99482673f95) seems to handle the case when 
> CONFIG_GPIOLIB is enabled, but no or not all GPIOs are given in the dtb.

Ah, I see.

I don't think we should handle this on a per-driver basis. So my
suggestion is to drop the dummy implementation for mctrl_gpio if GPIOLIB
is disabled. Then the behaviour should be consistant with the gpio stuff
returning NULL in this case. (Or alternatively adapt the dummy
implementation to shortcut and behave identically.)

(Having said that I don't like gpiolib's behaviour of returning NULL for
the optional calls if it's disabled, but having mctrl_gpio behave
differently is worse.)

> The sh-sci.c driver has a similar check to skip this case: [2].

This should than be dropped, too.

Best regards
Uwe

> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/serial_mctrl_gpio.h#n121
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/sh-sci.c#n3290

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
