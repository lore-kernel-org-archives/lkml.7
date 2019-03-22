Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AE721900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfCVUvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:51:03 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:48646 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCVUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:51:02 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-115-194-nat.elisa-mobile.fi [85.76.115.194])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id E38D94004B;
        Fri, 22 Mar 2019 22:50:59 +0200 (EET)
Date:   Fri, 22 Mar 2019 22:50:59 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED, REGRESSION] Broken networking on MIPS/OCTEON
 EdgeRouter Lite
Message-ID: <20190322205059.GA29013@darkstar.musicnaut.iki.fi>
References: <20190322002125.GD7872@darkstar.musicnaut.iki.fi>
 <20190322064506.GB5348@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322064506.GB5348@vkoul-mobl>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 22, 2019 at 12:15:06PM +0530, Vinod Koul wrote:
> On 22-03-19, 02:21, Aaro Koskinen wrote:
> > When booting v5.1-rc1 on EdgeRouter Lite (MIPS/OCTEON), with at803x phy
> > driver enabled, networking no longer works - I even need to go physically
> > power cycle the board before getting networking to work again (otherwise
> > bootloader cannot tftp an older working image).
> > 
> > Bisected to:
> > 
> > 	commit 6d4cd041f0af5b4c8fc742b4a68eac22e420e28c
> > 	Author: Vinod Koul <vkoul@kernel.org>
> > 	Date:   Thu Feb 21 15:53:15 2019 +0530
> > 
> > 	    net: phy: at803x: disable delay only for RGMII mode
> 
> Hello,
> 
> So with cd28d1d6e52e ("net: phy: at803x: Disable phy delay for RGMII
> mode") it works for you but not 6d4cd041f0af ("net: phy: at803x: disable
> delay only for RGMII mode"). That is bit more weird case :)

Yes, I guess it's the new "disable by default" behaviour that breaks it.

> So does the ethernet expect RGMII mode or RGMII_ID mode here, looks like
> disable delay is expected as well?

The OCTEON HW code knows only about RGMII. And looking at
octeon ethernet staging driver it does phy connect always with
PHY_INTERFACE_MODE_GMII. I did some experimentation, and it seems that
with PHY_INTERFACE_MODE_RGMII_RXID it starts to work.. In the DT we have
for ethernet for this board:

	rx-delay = <0>;
	tx-delay = <0x10>;

which I guess matches, or does this make any sense?

> Can you point me to the DT node as well..

arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts

A.
