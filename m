Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D9720854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfCYTaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:30:12 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:34238 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfCYTaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:30:11 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-115-194-nat.elisa-mobile.fi [85.76.115.194])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 6A9CC40057;
        Mon, 25 Mar 2019 21:30:06 +0200 (EET)
Date:   Mon, 25 Mar 2019 21:30:06 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED, REGRESSION] Broken networking on MIPS/OCTEON
 EdgeRouter Lite
Message-ID: <20190325193006.GA16484@darkstar.musicnaut.iki.fi>
References: <20190322002125.GD7872@darkstar.musicnaut.iki.fi>
 <20190322064506.GB5348@vkoul-mobl>
 <20190322205059.GA29013@darkstar.musicnaut.iki.fi>
 <20190322212557.GF16623@lunn.ch>
 <20190322214120.GB29013@darkstar.musicnaut.iki.fi>
 <20190324201734.GC7782@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324201734.GC7782@lunn.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 24, 2019 at 09:17:34PM +0100, Andrew Lunn wrote:
> On Fri, Mar 22, 2019 at 11:41:20PM +0200, Aaro Koskinen wrote:
> > On Fri, Mar 22, 2019 at 10:25:57PM +0100, Andrew Lunn wrote:
> > > > The OCTEON HW code knows only about RGMII. And looking at
> > > > octeon ethernet staging driver it does phy connect always with
> > > > PHY_INTERFACE_MODE_GMII. I did some experimentation, and it seems that
> > > > with PHY_INTERFACE_MODE_RGMII_RXID it starts to work.. In the DT we have
> > > > for ethernet for this board:
> > > > 
> > > > 	rx-delay = <0>;
> > > > 	tx-delay = <0x10>;
> > > 
> > > These are not PHY properties. 
> > > 
> > > Looking at the code, it looks like these control delays the MAC
> > > inserts. I don't see a binding document for these properties, so i've
> > > no idea what 0x10 means. Before this driver moves out of staging,
> > > these values should be changed to be in ns.
> > 
> > Documentation/devicetree/bindings/net/cavium-pip.txt
> 
> Hi Aaro
> 
> Ah, sorry, missed that.
> 
> - rx-delay: Delay value for RGMII receive clock. Optional. Disabled if 0.
>   Value range is 1-31, and mapping to the actual delay varies depending on HW.
> 
> - tx-delay: Delay value for RGMII transmit clock. Optional. Disabled if 0.
>   Value range is 1-31, and mapping to the actual delay varies depending on HW.
> 
> I'm surprised this made it passed review. We try to avoid having DT
> poke magic values into registers. That is what this appears to be,
> since it is unclear what the value actually means.

It's probably not too late to improve this since those are
likely used only in-tree. Vendor GPL bundles provide some more
documentation for this setting, as does the FreeBSD source tree:
https://github.com/freebsd/freebsd/blob/master/sys/contrib/octeon-sdk/cvmx-asxx-defs.h#L911

But reading that, I think it could be still difficult to change it to
rx-delay-ps as it seems to be too coarse/unreliable.

> It is also good to state what happens if the property is not
> present. It often means it defaults to zero. But this implementation
> just leaves the value alone. So to be on the safe side, the DT blob
> should probably have these properties, so the behaviour is well
> defined.

The default is to set both to 16 on CN50XX and 24 on other chips.

A.
