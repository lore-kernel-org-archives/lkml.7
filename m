Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CE6CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E4321D80
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfJ1Nlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:41:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39117 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfJ1Nlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:41:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iP5H3-0006uL-5A; Mon, 28 Oct 2019 14:41:33 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iP5H1-0005La-MM; Mon, 28 Oct 2019 14:41:31 +0100
Date:   Mon, 28 Oct 2019 14:41:31 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Biwen Li <biwen.li@nxp.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        Leo Li <leoyang.li@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [EXT] Re: [RESEND v2] i2c: imx: support slave mode for imx I2C
 driver
Message-ID: <20191028134131.5pq2vaqojx4gpfth@pengutronix.de>
References: <20191009101802.19309-1-biwen.li@nxp.com>
 <113865e9-e846-1079-6f58-7fddb245398c@pengutronix.de>
 <DB7PR04MB449066A02FB9FD0A795CFAFB8F650@DB7PR04MB4490.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB449066A02FB9FD0A795CFAFB8F650@DB7PR04MB4490.eurprd04.prod.outlook.com>
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

On Fri, Oct 25, 2019 at 04:02:11AM +0000, Biwen Li wrote:
> > I'm trying to test you patch on i.MX6S RIoTBoard. So far I fail to get it
> > working with following setup:
> > 1. register i2c-gpio
> > 2. connect i2c-gpio SCL to i2c-imx SCL pin and i2c-gpio SDA to i2c-imx SDA
> > pin 3. run this command to register i2c slave eeprom on i2c-imx:
> > echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device
> > 4. run "i2cdetect 4" on i2c-gpio to detect eeprom on i2c-imx slave.
> > 
> > So far, nothing was detected and even irq counter of i2c-imx didn't
> > increased.
> > 
> > Do I'm missing some thing? Please, help me to test you patch.
> You not miss anything, but the i2c-gpio driver from upstream is not
> workable on imx(I have tested the i2c-gpio driver with oscilloscope
> on imx8mm-evk, I cannot get any signal from the i2c-gpio bus).

In general the GPIOs are known to work, so I wonder what the problem is.
If it relies on being able to read the state of an output it might help
to set the SION bit on the related pins.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
