Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF65C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB95E21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfCVVlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:41:25 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:48956 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCVVlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:41:24 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-115-194-nat.elisa-mobile.fi [85.76.115.194])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 213A6B0049;
        Fri, 22 Mar 2019 23:41:20 +0200 (EET)
Date:   Fri, 22 Mar 2019 23:41:20 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED, REGRESSION] Broken networking on MIPS/OCTEON
 EdgeRouter Lite
Message-ID: <20190322214120.GB29013@darkstar.musicnaut.iki.fi>
References: <20190322002125.GD7872@darkstar.musicnaut.iki.fi>
 <20190322064506.GB5348@vkoul-mobl>
 <20190322205059.GA29013@darkstar.musicnaut.iki.fi>
 <20190322212557.GF16623@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322212557.GF16623@lunn.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 22, 2019 at 10:25:57PM +0100, Andrew Lunn wrote:
> > The OCTEON HW code knows only about RGMII. And looking at
> > octeon ethernet staging driver it does phy connect always with
> > PHY_INTERFACE_MODE_GMII. I did some experimentation, and it seems that
> > with PHY_INTERFACE_MODE_RGMII_RXID it starts to work.. In the DT we have
> > for ethernet for this board:
> > 
> > 	rx-delay = <0>;
> > 	tx-delay = <0x10>;
> 
> These are not PHY properties. 
> 
> Looking at the code, it looks like these control delays the MAC
> inserts. I don't see a binding document for these properties, so i've
> no idea what 0x10 means. Before this driver moves out of staging,
> these values should be changed to be in ns.

Documentation/devicetree/bindings/net/cavium-pip.txt

Not sure how I could figure out the ns values?

> However, PHY_INTERFACE_MODE_RGMII_RXID would make sense if 0x10 is
> sufficient to add the TX delay.
> 
> What the driver should however do is call of_of_get_phy_mode() to get
> the phy-mode from the DT blob and pass that to of_phy_connect().

OK, thanks, I'll try to work on this.

A.
