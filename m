Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11585C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BFC21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563765589;
	bh=o9ug2UGWvRNfm5yi/YzSxu10Y1TaJv2KLaYjJ/mfy0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rwcx7mt3ItvJTw52wTdrAl7lVg+KSXDmfFoUboGRpvM0O2flBGrBWF1JEpuJzZqxq
	 BYgxXwpD+sSIwNOXByL3qVtnmZ7Jwz4sIFUTQeVyXam4/8PZ/xicKmB+9lV2zuJqAJ
	 W+32/wh3AKLndeiPUKZOJEVYrOVYdo1La2G6EyUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfGVDTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 23:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfGVDTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:19:47 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD48421926;
        Mon, 22 Jul 2019 03:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563765585;
        bh=o9ug2UGWvRNfm5yi/YzSxu10Y1TaJv2KLaYjJ/mfy0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgUn3Rj4Aed2n2RovpV4pioNUoW2LcC3GtRy+3THrGzonOpPTFoYCy02l7V5upYjT
         atHVlacFtwY7jCkSzTBDM4UY73DNKHTkqhxA+s6CBDulL6HsPLWJqH6w3i81D94jKv
         Vg2NwDzTz3Lub6sWRazgE01R03KHX6XW+KMCbV6Y=
Date:   Mon, 22 Jul 2019 11:19:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "will@kernel.org" <will@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Message-ID: <20190722031914.GU3738@dragon>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190624022200.GN3800@dragon>
 <20190624022713.GO3800@dragon>
 <DB3PR0402MB39162662C69B45BDB948D002F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190722020026.GQ3738@dragon>
 <AM6PR0402MB39113A76EE8A63F9C9F589C1F5C40@AM6PR0402MB3911.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR0402MB39113A76EE8A63F9C9F589C1F5C40@AM6PR0402MB3911.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 02:15:10AM +0000, Anson Huang wrote:
> Hi, Shawn
> 
> > On Mon, Jun 24, 2019 at 02:35:10AM +0000, Anson Huang wrote:
> > > Hi, Shawn
> > >
> > > > -----Original Message-----
> > > > From: Shawn Guo <shawnguo@kernel.org>
> > > > Sent: Monday, June 24, 2019 10:27 AM
> > > > To: Anson Huang <anson.huang@nxp.com>
> > > > Cc: mark.rutland@arm.com; Aisheng Dong <aisheng.dong@nxp.com>;
> > Peng
> > > > Fan <peng.fan@nxp.com>; festevam@gmail.com; Jacky Bai
> > > > <ping.bai@nxp.com>; devicetree@vger.kernel.org; sboyd@kernel.org;
> > > > catalin.marinas@arm.com; s.hauer@pengutronix.de; linux-
> > > > kernel@vger.kernel.org; Daniel Baluta <daniel.baluta@nxp.com>;
> > > > linux- clk@vger.kernel.org; robh+dt@kernel.org; dl-linux-imx <linux-
> > > > imx@nxp.com>; kernel@pengutronix.de; Leonard Crestez
> > > > <leonard.crestez@nxp.com>; will@kernel.org; mturquette@baylibre.com;
> > > > linux-arm-kernel@lists.infradead.org; Abel Vesa <abel.vesa@nxp.com>
> > > > Subject: Re: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for
> > > > ARCH_MXC platforms
> > > >
> > > > On Mon, Jun 24, 2019 at 10:22:01AM +0800, Shawn Guo wrote:
> > > > > On Fri, Jun 21, 2019 at 03:07:17PM +0800, Anson.Huang@nxp.com
> > wrote:
> > > > > > From: Anson Huang <Anson.Huang@nxp.com>
> > > > > >
> > > > > > ARCH_MXC platforms needs system counter as broadcast timer to
> > > > > > support cpuidle, enable it by default.
> > > > > >
> > > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > > > ---
> > > > > >  arch/arm64/Kconfig.platforms | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/Kconfig.platforms
> > > > > > b/arch/arm64/Kconfig.platforms index 4778c77..f5e623f 100644
> > > > > > --- a/arch/arm64/Kconfig.platforms
> > > > > > +++ b/arch/arm64/Kconfig.platforms
> > > > > > @@ -173,6 +173,7 @@ config ARCH_MXC
> > > > > >  	select PM
> > > > > >  	select PM_GENERIC_DOMAINS
> > > > > >  	select SOC_BUS
> > > > > > +	select TIMER_IMX_SYS_CTR
> > > > >
> > > > > Where is that driver?
> > > >
> > > > Okay, just found it in the mailbox.  They seem to be sent in the wrong
> > order.
> > > > Really, you should send this series only after the driver lands on mainline.
> > >
> > > OK, just noticed that mainline does NOT have it, since I did it based on next
> > tree.
> > > I will resend the patch series after the system counter driver landing on
> > mainline.
> > 
> > I just picked the series up, so no need to resend.
> 
> Something changed for this series, the system counter clock related implementation
> are changed after some comments from maintainer, so I think you should picked up
> below patch series instead, and drop this series,
> 
> https://patchwork.kernel.org/patch/11037953/

Okay, dropped clk and dts patches.  arch/arm64/Kconfig.platforms one is kept.

Shawn
