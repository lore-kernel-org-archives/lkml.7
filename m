Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06893C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B74214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m8lcSqN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfION5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:57:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46870 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfION5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=F/ACcRyL2qqmFkbHAyxSdbuql7B7in2MrinBX2qvBxs=; b=m8lcSqN39XKDCaoSXtT/ep6hvQ
        zG+zDQd2sib/sfKOdyzMm1VPlL+733lMcjy9gerQHKb0uW8svgvATD7m4WdKKPNGC/UmQ/KPx/26V
        WJH8tDuuKbHJ+M7rNzH1kFFE04eyRPtWk5NhF3Pm8KofqeI2BERnFRiXTc36nNlzcuNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i9V1I-0004By-Ad; Sun, 15 Sep 2019 15:56:52 +0200
Date:   Sun, 15 Sep 2019 15:56:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     tinywrkb <tinywrkb@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190915135652.GC3427@lunn.ch>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muf6oyvr.fsf@tarshish>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Tinywrkb confirmed to me in private communication that revert of
> 5502b218e001 fixes Ethernet for him on effected system.
> 
> He also referred me to an old Cubox-i spec that lists 10/100 Ethernet
> only for i.MX6 Solo/DualLite variants of Cubox-i. It turns out that
> there was a plan to use a different 10/100 PHY for Solo/DualLite
> SOMs. This plan never materialized. All SolidRun i.MX6 SOMs use the same
> AR8035 PHY that supports 1Gb.
> 
> Commit 5502b218e001 might be triggering a hardware issue on the affected
> Cubox-i. I could not reproduce the issue here with Cubox-i and a Dual
> SOM variant running v5.3-rc8. I have no Solo/DualLite variant handy at
> the moment.

Could somebody with an affected device show us the output of ethtool
with and without 5502b218e001. Does one show 1G has been negotiated,
and the other 100Mbps? If this is true, how does it get 100Mbps
without that patch? We are missing a piece of the puzzle.

	Andrew
