Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7FEC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7E921904
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563760859;
	bh=0+CKCqaGn9rc9ATckfsjU7zrwnYa0a42D4iOj0xJWso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cwFoxBYf08Qztcl8Lkum1xGdQkf7MLID0dfCClWrJ/pxbZR1qCWIlH1UlK+T8x0Bb
	 toEXC9Y29onA4jwBIkRUfwytpFNrBazpZp2QLlg0jLb6A1k8Qx1EiZRiVgGrVAqHfq
	 El2pa9u5iV9jMYOQJ2z0Nv6unQejrvlA410gi7hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfGVCA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfGVCA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:00:56 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2145B21903;
        Mon, 22 Jul 2019 02:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563760855;
        bh=0+CKCqaGn9rc9ATckfsjU7zrwnYa0a42D4iOj0xJWso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9r0LDVxTxRVHTVu+Rs7Uu12SKkCSVLixXbjwwaiInDmkCupXAUAm1imOSKmaSyAE
         cjCr91IMOcSgs3x5zmhT4DmEju+YPdVp8Js1Jt31SHWrwsZpSyvpN/xPAK0ICOkOVm
         nY+sOq57aaxkOqcC8x82pyQtFKRSBaCTzfBIKUbg=
Date:   Mon, 22 Jul 2019 10:00:27 +0800
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
Message-ID: <20190722020026.GQ3738@dragon>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190624022200.GN3800@dragon>
 <20190624022713.GO3800@dragon>
 <DB3PR0402MB39162662C69B45BDB948D002F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39162662C69B45BDB948D002F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 02:35:10AM +0000, Anson Huang wrote:
> Hi, Shawn
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Monday, June 24, 2019 10:27 AM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: mark.rutland@arm.com; Aisheng Dong <aisheng.dong@nxp.com>; Peng
> > Fan <peng.fan@nxp.com>; festevam@gmail.com; Jacky Bai
> > <ping.bai@nxp.com>; devicetree@vger.kernel.org; sboyd@kernel.org;
> > catalin.marinas@arm.com; s.hauer@pengutronix.de; linux-
> > kernel@vger.kernel.org; Daniel Baluta <daniel.baluta@nxp.com>; linux-
> > clk@vger.kernel.org; robh+dt@kernel.org; dl-linux-imx <linux-
> > imx@nxp.com>; kernel@pengutronix.de; Leonard Crestez
> > <leonard.crestez@nxp.com>; will@kernel.org; mturquette@baylibre.com;
> > linux-arm-kernel@lists.infradead.org; Abel Vesa <abel.vesa@nxp.com>
> > Subject: Re: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
> > platforms
> > 
> > On Mon, Jun 24, 2019 at 10:22:01AM +0800, Shawn Guo wrote:
> > > On Fri, Jun 21, 2019 at 03:07:17PM +0800, Anson.Huang@nxp.com wrote:
> > > > From: Anson Huang <Anson.Huang@nxp.com>
> > > >
> > > > ARCH_MXC platforms needs system counter as broadcast timer to
> > > > support cpuidle, enable it by default.
> > > >
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > ---
> > > >  arch/arm64/Kconfig.platforms | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm64/Kconfig.platforms
> > > > b/arch/arm64/Kconfig.platforms index 4778c77..f5e623f 100644
> > > > --- a/arch/arm64/Kconfig.platforms
> > > > +++ b/arch/arm64/Kconfig.platforms
> > > > @@ -173,6 +173,7 @@ config ARCH_MXC
> > > >  	select PM
> > > >  	select PM_GENERIC_DOMAINS
> > > >  	select SOC_BUS
> > > > +	select TIMER_IMX_SYS_CTR
> > >
> > > Where is that driver?
> > 
> > Okay, just found it in the mailbox.  They seem to be sent in the wrong order.
> > Really, you should send this series only after the driver lands on mainline.
> 
> OK, just noticed that mainline does NOT have it, since I did it based on next tree.
> I will resend the patch series after the system counter driver landing on mainline.

I just picked the series up, so no need to resend.

Shawn
