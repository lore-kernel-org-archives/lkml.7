Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4394120874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555320245;
	bh=JulKskcohmjU1LQCxlJpqEI+tr9kx1WSlzr48IXgw5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OHFkYnvOs7nAOLLZI7lt5eiQYFqhdR9ifBu8ghdFlme6CrzNO7sDWpwG35Eq3DHcm
	 0wYxVeQKst7koSquSxc843JpgwStxVufu1uPZsbBqbYU89waBLuyQtOYXbtEnezGJ8
	 UMBgqOVhG/hGqR03ivUFo3D5FqqB4bxt1o4qbfho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfDOJYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDOJYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:24:03 -0400
Received: from X250.skyworth_vap (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0DF20656;
        Mon, 15 Apr 2019 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555320243;
        bh=JulKskcohmjU1LQCxlJpqEI+tr9kx1WSlzr48IXgw5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPiLlj6fvXqyHnS3MqqlO/pxiwz87HdwMQbjjkRGIWvB7hZSdseWXBZoe6Y08YVRx
         orjFxfk6P/C6R9i3gU8mS4xe/WRK/O5zZsW2LUWmngYpywMZInFvBpsk1plUWGHeFn
         QNwx4lg5tJoovZXubKyMhL/hRPiiEeXuYiCWMU/I=
Date:   Mon, 15 Apr 2019 17:23:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH V7 2/4] firmware: imx: enable imx scu general
 irq function
Message-ID: <20190415092350.GC18917@X250.skyworth_vap>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
 <1554785675-8090-2-git-send-email-Anson.Huang@nxp.com>
 <20190411073252.GC3050@dragon>
 <DB3PR0402MB3916B67E6DA995AB70C29799F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB4211816EDBEF23F7B330CCCB80280@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB39162D194A2B5B79211C1774F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190412084116.GS3578@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412084116.GS3578@piout.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 10:41:16AM +0200, Alexandre Belloni wrote:
> On 12/04/2019 02:32:54+0000, Anson Huang wrote:
> > > > 	As i.MX SCU general irq function is picked up by Shawn, could you
> > > > please also pick up below i.MX SC RTC alarm support patch ?
> > > > 	https://patchwork.kernel.org/patch/10890525/
> > > >
> > > 
> > > No, it can't go through Alexandre's tree due to dependency issue.
> > > 
> > > Shawn,
> > > Do you think you can pick it up? Alexandre already gave the Ack.
> > > 
> > > AFAIK there's no other SCU RTC patches since v5.1-rc1 in Alexandre's tree.
> > 
> > Yes, need to make sure the dependency is handled, the RTC alarm patch MUST be picked up
> > ONLY when scu irq patch is ready, NOT sure how to handle this case for such scenario?
> > 
> 
> Either it goes through arm-soc or if it can wait one release, I pick it
> up for 5.3. The other solution involves immutable branch but I don't
> think this is necessary.

I send other subsystem patch through arm-soc tree only when it's
absolutely necessary. This is not anything either critical or urgent,
so I'm not going to take it.  Wait one release, I'd say.

Shawn
