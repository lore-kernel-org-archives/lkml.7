Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23017C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24442077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfLKH1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:27:24 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57987 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLKH1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:27:24 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iewP4-0006T3-E2; Wed, 11 Dec 2019 08:27:22 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iewP3-0004Eh-6N; Wed, 11 Dec 2019 08:27:21 +0100
Date:   Wed, 11 Dec 2019 08:27:21 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO
 regulator
Message-ID: <20191211072721.ze6yn2felxyae5eb@pengutronix.de>
References: <1571906920-29966-1-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB7023CD288FCC57806F067FD9EE5B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916D3DB4C0CE0017FC2D4B1F55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916D3DB4C0CE0017FC2D4B1F55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:22:06 up 25 days, 22:40, 33 users,  load average: 0.00, 0.00,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-11 01:06, Anson Huang wrote:
> 
> 
> > Subject: Re: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO
> > regulator
> > 
> > On 24.10.2019 11:51, Anson Huang wrote:
> > > On i.MX6UL 14x14 EVK board, sensors' power are controlled by
> > > GPIO5_IO02, add GPIO regulator for sensors to manage their power.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > For me this breaks network boot on imx6ul evk, relevant log snippet is this:
> > 
> >      fec 20b4000.ethernet eth0: Unable to connect to phy
> >      IP-Config: Failed to open eth0
> > 
> > Looking at schematics (SPF-28616_C2.pdf) I see that SNVS_TAMPER2 pin is
> > connected to PERI_PWREN which controls VPERI_3V3 which is used across
> > the board:
> >   * Sensors (VSENSOR_3V3)
> >   * Ethernet (VENET_3V3)
> >   * Bluetooth
> >   * CAN
> >   * Arduino header
> >   * Camera
> > 
> > Maybe there are board revision differences? As far as I can tell this regulator
> > is not specific to sensors so it should be always on.
> 
> You are correct, this regulator controls many other peripherals, I should make it always ON for now
> to make sure NOT break other peripheral, and after all other peripherals controlled
> by this regulator have added this regulator management, then the always ON can be
> removed.

IMHO marking the regulator as always on shouldn't be the fix. Is it to
much work to add all required regulators? At least please add a comment
which describes the need of the always-on property.

Regards,
  Marco 

> Thanks,
> Anson

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
