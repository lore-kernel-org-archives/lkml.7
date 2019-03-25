Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEA3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49D1207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfCYLQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:16:19 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:35351 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:16:18 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id BABA52800B489;
        Mon, 25 Mar 2019 12:16:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7846B210C5; Mon, 25 Mar 2019 12:16:16 +0100 (CET)
Date:   Mon, 25 Mar 2019 12:16:16 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 17/28] thunderbolt: Add support for full PCIe daisy
 chains
Message-ID: <20190325111616.gjfkos666gz3blj2@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-18-mika.westerberg@linux.intel.com>
 <20190324113144.wubme46hby7rj6r2@wunner.de>
 <20190325095733.GC3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325095733.GC3622@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:57:33AM +0200, Mika Westerberg wrote:
> On Sun, Mar 24, 2019 at 12:31:44PM +0100, Lukas Wunner wrote:
> > On Wed, Feb 06, 2019 at 04:17:27PM +0300, Mika Westerberg wrote:
> > > -static void tb_activate_pcie_devices(struct tb *tb)
> > > +static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
> > >  {
> > [...]
> > > +	/*
> > > +	 * Look up available down port. Since we are chaining, it is
> > > +	 * typically found right above this switch.
> > > +	 */
> > > +	down = NULL;
> > > +	parent_sw = tb_to_switch(sw->dev.parent);
> > > +	while (parent_sw) {
> > > +		down = tb_find_unused_down_port(parent_sw);
> > > +		if (down)
> > > +			break;
> > > +		parent_sw = tb_to_switch(parent_sw->dev.parent);
> > > +	}
> > 
> > The problem I see here is that there's no guarantee that the switch
> > on which you're selecting a down port is actually itself connected
> > with a PCI tunnel.  E.g., allocation of a tunnel to that parent
> > switch may have failed.  In that case you end up establishing a
> > tunnel between that parent switch and the newly connected switch
> > but the tunnel is of no use.
> 
> Since this is going through tb_domain_approve_switch() it does not allow
> PCIe tunnel creation if the parent is not authorized first.

Yes, but my point is that it doesn't make much sense to establish a tunnel
between a switch and one of its parent switches unless that parent switch
is reachable from the root switch over a PCI tunnel or a series of PCI
tunnels.

It may be worth checking that condition, or, if new tunnels are established
top-down in the daisy-chain and tunnel establishment has failed for a
switch, to not establish tunnels for switches beyond that one.

Thanks,

Lukas
