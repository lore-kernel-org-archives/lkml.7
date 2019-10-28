Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF3ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F37720B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572232525;
	bh=E2rmGEKJWc4SPd5hu34sYqUV9AyvQoUs/7AVX3h7orM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vlaDgYXv2gk2vKQXLB85jRil4YFSNVU/YDzTFKoZ5urkQ8y37BXVGOl3X6Q8aPGDA
	 oPWkP48/k3zTRQezQxCnY24BDIfJWxvKtAtNdeTmoHUsTpJyEVl6ZspyCpB79HaKLX
	 7GqRiU0gCICodxfD50KBFNDHaDfZ6AhAghlOuflA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfJ1DPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfJ1DPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:15:24 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDFC020873;
        Mon, 28 Oct 2019 03:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572232523;
        bh=E2rmGEKJWc4SPd5hu34sYqUV9AyvQoUs/7AVX3h7orM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtuHAFfgVqZrLteGy3y/MnjNgN2MyJdRESeyoOcTuXq7Hq1Dq0kYjG+XscuwFG3fx
         KlGejELfnIMgJkmO7dkceyYV0YGdHPr6p1ubMDpIVYlD66lcdg1TyI+K5rFz5UTjrG
         4jd4Ue/Nvdn8fRsYqF/IPXKOz+AQGngVsqdzK2ME=
Date:   Mon, 28 Oct 2019 11:15:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>, Jun Li <jun.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "angus@akkea.ca" <angus@akkea.ca>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        "dafna.hirschfeld@collabora.com" <dafna.hirschfeld@collabora.com>,
        Richard Hu <richard.hu@technexion.com>,
        "andradanciu1997@gmail.com" <andradanciu1997@gmail.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/5] arm64: dts: imx8qxp: Move usdhc clocks assignment to
 board DT
Message-ID: <20191028031459.GI16985@dragon>
References: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
 <20191026120902.GL14401@dragon>
 <DB3PR0402MB3916A2258E1E8B4690CC1B7DF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916A2258E1E8B4690CC1B7DF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:29:32AM +0000, Anson Huang wrote:
> Hi, Shawn
> 
> > On Wed, Oct 16, 2019 at 10:14:23AM +0800, Anson Huang wrote:
> > > usdhc's clock rate is different according to different devices
> > > connected, so clock rate assignment should be placed in board DT
> > > according to different devices connected on each usdhc port.
> > 
> > I think it should be fine that we have a reasonable default settings in soc.dtsi,
> > and boards that need a different setup can overwrite the settings in
> > board.dts.
> 
> Someone was complaining about the usdhc clock assignment in soc.dtsi, because some
> usdhc nodes are having clock assignments while some are NOT. That is why I did this
> patch set. I agree that we can have default settings in soc.dtsi, so do you think it makes
> sense to add default clock assignment to all usdhc nodes? If yes, I will redo the patch
> set.

I had a second thought on this. To ease the maintenance of soc.dtsi,
let's do clock assignments in board.dts.

Series applied, thanks.

Shawn
