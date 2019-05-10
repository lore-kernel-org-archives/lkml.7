Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D29BC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A782183F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557456175;
	bh=pZ/RYhQiiXIobOqGJuOmMUFqoqiojXjUHDEaqT4DJ7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ISa/TW8KqVx3XHr/kaSX+QJ49Xua7SpGwKOtWksu7IRTGZODWGYA5zAqi9gXuDzid
	 NUrw0sbf47A25Hhxi86342ehkCvxtdiqIXaoWlEUjKGH8VTMx71u7la72zlx+mQY5d
	 pOgHG2j4GYwrMic67KGqosNAYOE6QcC5pL3CcoJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfEJCmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEJCmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:42:53 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4708E20645;
        Fri, 10 May 2019 02:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557456173;
        bh=pZ/RYhQiiXIobOqGJuOmMUFqoqiojXjUHDEaqT4DJ7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1EUSEGfLrYMAEAVek3nO0AAeZnER9ELE2yjPxiIqL5XMPgas/6nyjek8DCuJ+kOyJ
         uYzAjeS50aEtM/vdV89aQX8QO0voL7+I6wxLHbPQ1USI7EuB7PnBB2mXHQjEy2ZQ2z
         2vH97kNHNhvpvV92QMpq8An5OaGaDQzxEyVcZQ2Y=
Date:   Fri, 10 May 2019 10:42:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Message-ID: <20190510024215.GA15856@dragon>
References: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
 <20190421073958.GC19962@dragon>
 <20190421074152.GD19962@dragon>
 <DB3PR0402MB39161C0DDFF0EEA6D8A90378F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39164B30B26CAF62EE807168F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <VI1PR04MB5533CED52723AE8292CFC305EE220@VI1PR04MB5533.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5533CED52723AE8292CFC305EE220@VI1PR04MB5533.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 08:48:56AM +0000, Leonard Crestez wrote:
> On 4/22/2019 9:46 AM, Anson Huang wrote:
> >> -----Original Message-----
> >> From: Anson Huang
> >>> From: Shawn Guo [mailto:shawnguo@kernel.org]
> >>> On Sun, Apr 21, 2019 at 03:40:00PM +0800, Shawn Guo wrote:
> >>>> On Thu, Apr 11, 2019 at 06:49:12AM +0000, Anson Huang wrote:
> >>>>> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> >>>>> inside, the system controller is in charge of controlling power,
> >>>>> clock and fuse etc..
> >>>>>
> >>>>> This patch adds i.MX system controller soc driver support, Linux
> >>>>> kernel has to communicate with system controller via MU (message
> >>>>> unit) IPC to get soc revision, uid etc..
> >>>>>
> >>>>> With this patch, soc info can be read from sysfs:
> >>>>>
> >>>>>   drivers/soc/imx/Kconfig      |   7 ++
> >>>>>   drivers/soc/imx/Makefile     |   1 +
> >>>>>   drivers/soc/imx/soc-imx-sc.c | 220
> >>>>> +++++++++++++++++++++++++++++++++++++++++++
> >>>>>   3 files changed, 228 insertions(+)  create mode 100644
> >>>>> drivers/soc/imx/soc-imx-sc.c
> >>>>
> >>>> Rather than creating a new driver, please take a look at Abel's
> >>>> generic
> >>>> i.MX8 SoC driver, and see if it can be extended to cover i.MX8QXP.
> >>
> >> Got it, I didn't notice that this patch bas been accepted, I will redo the patch
> >> based on it, thanks.
> > 
> > I have sent the new patch set to support i.MX8QXP SoC revision based on generic i.MX8
> > SoC driver, however, the Kconfig modification is NOT good, it may break i.MX8MQ if IMX_SCU
> > is NOT enabled, although we can add some warp function for SCU firmware API call to fix it,
> > but after further thought and discussion with Dong Aisheng, I think we may need to roll back to
> > use this patch series to create a new SoC driver dedicated for i.MX8 SoCs
> > with system controller inside, such as i.MX8QXP, i.MX8QM etc., the reason are as below:
> > 
> > For i.MX8MQ/i.MX8MM:
> > 	1. SoC driver does NOT depends on i.MX SCU firmware, so no need to use platform driver
> > 	     probe model, just device_init phase call is good enough;
> > 	2. The SoC driver no need to depends on IMX_SCU, so it can be always built in, no need to
> > 	     check IMX_SCU config;
> > 	3. The fuse check for CPU speed grading, HDCP status, NoC settings etc. could be added to this driver,
> > 	    but they are ONLY for i.MX8MQ/i.MX8MM etc..
> > For i.MX8QXP/i.MX8QM:
> > 	1. SoC driver MUST depends on IMX_SCU;
> > 	2. MUST use platform model to support defer probe;
> > 	3. No fuse check for CPU speed grading.
> > 
> > So, I guess the reused code for i.MX8MQ and i.MX8QXP is ONLY those part of creating SoC id device node (less than
> > 30% I think), all other functions are implemented in total different ways, that is why I created the imx_sc_soc driver
> > in this patch series, so do you think we can add new SoC driver for i.MX8 SoC with SCU inside? Putting 2 different architecture
> > SoCs' driver into 1 file looks like NOT making enough sense.
> 
> +1 for separate SOC driver. The 8mq/8mm and 8qm/8qxp families are very 
> different, they just happen to share the imx8 prefix.
> 
> It makes sense to allow people to compile one without the other and this 
> is easier with distinct SOC drivers.

Leonard, Abel,

Can you guys help review the patch?  Thanks.

Shawn
