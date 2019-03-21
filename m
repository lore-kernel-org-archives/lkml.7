Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1926C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FE9218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yyi1M7LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfCULue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:50:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33182 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCULud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vKkM8nQh1u+Sy4yebjY6mgBREl8Wuz8f5vh61zqIaXY=; b=yyi1M7LXrBBoWNyZcnj2u+m0Oz
        bnl0K9eFJw/KqfNZmAC7huWV0d66i8PzFYQOgvLbLI7dM2KPcGI1J7F+7zzltCQi3pmMQnk2305GH
        xfp/bf3cZXsNQ1QzRW3rhCIPS9H668HyTZBv2cu6VMRrUaC5fMK0ri+0s1FxezvuhJbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h6wDJ-0003Zw-SZ; Thu, 21 Mar 2019 12:50:25 +0100
Date:   Thu, 21 Mar 2019 12:50:25 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Fabio Estevam <festevam@gmail.com>, Abel Vesa <abel.vesa@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Message-ID: <20190321115025.GH2900@lunn.ch>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
 <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
 <VI1PR10MB2352D2C805B675A1C4CBDC6AFE420@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR10MB2352D2C805B675A1C4CBDC6AFE420@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I bisected to the original breakage (for the NFS rootfs) back to this commit:
> commit 13d0ab6750b20957ac1466da4e44dc0af746ff28

I don't think that is the correct patch. Yes, it broke here, but that
was a different problem. 

I think the real commit is:
6d4cd041f0af ("net: phy: at803x: disable delay only for RGMII mode")

That commit contains a fix for broken behaviour in the PHY driver,
when then also causes broken DTs to fail.

	     Andrew
