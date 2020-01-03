Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF40C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05522253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgACSRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:17:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:39092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgACSRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:17:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7722ACFA;
        Fri,  3 Jan 2020 18:17:02 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 5388DE0473; Fri,  3 Jan 2020 19:17:01 +0100 (CET)
Date:   Fri, 3 Jan 2020 19:17:01 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Matthew Wilcox <willy@infradead.org>,
        yu kuai <yukuai3@huawei.com>, klassert@kernel.org,
        davem@davemloft.net, hkallweit1@gmail.com,
        jakub.kicinski@netronome.com, hslester96@gmail.com, mst@redhat.com,
        yang.wei9@zte.com.cn, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhengbin13@huawei.com
Subject: Re: [PATCH] net: 3com: 3c59x: remove set but not used variable
 'mii_reg1'
Message-ID: <20200103181701.GB22387@unicorn.suse.cz>
References: <20200103121907.5769-1-yukuai3@huawei.com>
 <20200103144623.GI6788@bombadil.infradead.org>
 <20200103175318.GN1397@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103175318.GN1397@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 06:53:18PM +0100, Andrew Lunn wrote:
> On Fri, Jan 03, 2020 at 06:46:23AM -0800, Matthew Wilcox wrote:
> > On Fri, Jan 03, 2020 at 08:19:07PM +0800, yu kuai wrote:
> > > Fixes gcc '-Wunused-but-set-variable' warning:
> > > 
> > > drivers/net/ethernet/3com/3c59x.c: In function ‘vortex_up’:
> > > drivers/net/ethernet/3com/3c59x.c:1551:9: warning: variable
> > > ‘mii_reg1’ set but not used [-Wunused-but-set-variable]
> > > 
> > > It is never used, and so can be removed.
> > ...
> > >  	if (dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
> > > -		mii_reg1 = mdio_read(dev, vp->phys[0], MII_BMSR);
> > >  		mii_reg5 = mdio_read(dev, vp->phys[0], MII_LPA);
> > 
> > I know nothing about the MII interface, but in general this is not
> > a safe thing to do.
> 
> Hi Matthew
> 
> I fully agree about the general case. However, reading the MII_BMSR
> should not have any side affects. It would be an odd Ethernet PHY if
> it did.
> 
> But I am curious why this read is here. There is a slim change the
> MDIO bus is broken, and this is a workaround. So it would be good if
> somebody dug into the history and found out when this read was added
> and if there are any comments about why it is there. Or if the usage
> of mii_reg1 as been removed at some point, and the read was not
> cleaned up.

I tried to dig a bit and found that originally (before git), there was
also

	if (vortex_debug > 1)
		printk(KERN_INFO "%s: MII #%d status %4.4x, link partner capability %4.4x,"
		       " info1 %04x, setting %s-duplex.\n",
		       dev->name, vp->phys[0],
		       mii_reg1, mii_reg5,
		       vp->info1, ((vp->info1 & 0x8000) || vp->full_duplex) ? "full" : "half");

The whole mii code in vortex_up() was removed by commit 125d5ce8a4e9
("[PATCH] 3c59x: use mii_check_media") and later the mdio_read() calls
were restored by commit 09ce3512dcad ("[PATCH] 3c59x: fix networking for
10base2 NICs") with "Also brought back some mii stuff to be sure that it
does not break something else", but without the debugging printk().

It's not really a proof that reading MII_BMSR was only needed for the
log message but there is a good chance it was. I'm afraid we won't be
able to find anyone who would be able to tell for sure after all those
years.

Michal
