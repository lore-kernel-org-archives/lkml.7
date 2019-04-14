Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DE2C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3CC2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vrpZqNDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfDNQFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:05:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60799 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfDNQFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7yvi/PpofvWU+h2cWVenn8gpuShDz30ZrzGs/wciCwI=; b=vrpZqNDlK6KmblrTmltHMpe+UR
        N52dUyOdMlYqoA7NE/Fl5kbOv4q3UpDq9dKrTLV2Ot1AIqJ9Ds6DkZ935uGm8KQexoFR/kgif0aLM
        mZc0KZCxLF+jUOlyy0OjtnGyWhK1FKodXnFHL/Kl2otI6lMp0hNggRZ342jzmExcz1ns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFhd0-000379-UW; Sun, 14 Apr 2019 18:05:10 +0200
Date:   Sun, 14 Apr 2019 18:05:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
Message-ID: <20190414160510.GA10323@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-19-olteanv@gmail.com>
 <20190413163754.GG17901@lunn.ch>
 <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 12:27:50AM +0300, Vladimir Oltean wrote:
> > > +             mgmt_route.macaddr = ether_addr_to_u64(hdr->h_dest);
> > > +             mgmt_route.destports = BIT(port);
> > > +             mgmt_route.enfport = 1;
> > > +             mgmt_route.tsreg = 0;
> > > +             mgmt_route.takets = false;
> > > +
> > > +             rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
> > > +                                               port, &mgmt_route, true);

>         rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
>                           *port*, &mgmt_route, true);
> 
> The switch IP aptly allocates 4 slots for management routes. And it's
> a 5-port switch where 1 port is the management port. I think the
> structure is fine.

So does the hardware look over all the slots and find the first one
which has a matching mgmt_route.macaddr destination MAC address? You
wait for the enfport to be cleared. I assume a slot with enfport
cleared is not active and won't match?

So we need to consider if there is a race condition where we have
multiple slots with the same destination MAC address, but different
destination ports? Say the bridge sends out BPDU to all ports of a
bridge in quick succession.

These work queues run in any order, and can sleep. Can we get into a
situation where we get the two slots setup, and then the frames sent
in reverse order? The match then happens backwards, and the frames get
sent out the wrong port?

Or say the two slots are setup, the two frames are sent in order, but
the stack decided to drop the first frame because buffers are
full. Can the second frame make it to the switch and match on the
first slot and go out the wrong port?

> > Also, please move all this code into the tagger. Just add exports for
> > sja1105_dynamic_config_write() and sja1105_dynamic_config_read().
> >
> 
> Well, you see, the tagger code is part of the dsa_core object. If I
> export function symbols from the driver, those still won't be there if
> I compile the driver as a module. On the other hand, the way I'm doing
> it, I think the schedule_work() gives me a pretty good separation.

That is solvable via Kconfig, don't allow it to be built as a module.

Also, DSA has been very successful, we keep getting more switches from
different vendors, and hence more taggers. So at some point, we should
turn the taggers into modules. I'm not saying that should happen now,
but when it does happen, this driver can then become a module.

The real reason is, tagger as all about handling frames, where as
drivers are all about configuring the switch. The majority of this
code is about frames, so it belongs in the tagger.
 
> > > +#include <linux/etherdevice.h>
> > > +#include <linux/if_vlan.h>
> > > +#include <linux/dsa/sja1105.h>
> > > +#include "../../drivers/net/dsa/sja1105/sja1105.h"
> >
> > Again, no, don't do this.
> >
> 
> This separation between driver and tagger is fairly arbitrary.
> I need access to the driver's private structure, in order to get a
> hold of the private shadow of the dsa_port. Moving the driver private
> structure to include/linux/dsa/ would pull in quite a number of
> dependencies. Maybe I could provide declarations for the most of them,
> but anyway the private structure wouldn't be so private any longer,
> would it?
> Otherwise put, would you prefer a dp->priv similar to the already
> existing ds->priv? struct sja1105_port is much more lightweight to
> keep in include/linux/dsa/.

Linux simply does not make use of relative paths going between
directories like this. That is the key point here. Whatever you need
to share between the tagger and the driver has to be put into
include/linux/dsa/. 

Assuming we are just exporting something like
sja1105_dynamic_config_write() and _read()


> > > +             rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
> > > +                                               port, &mgmt_route, true);

priv can be replaced with ds, which the tagger has. port is
known. BLK_IDX_MGMT_ROUTE is implicit, and all that the tagger needs
to pass for mgmt_route is the destination MAC address, which it has.

The tagger does need somewhere to keep the queue of frames to be sent
and its workqueue. I would probably add a void *tagger_priv to
dsa_switch, and two new methods to dsa_device_ops, .probe and
.release, to allow it to create and destroy what it needs in
tagger_priv.

> > > +#include "dsa_priv.h"
> > > +
> > > +/* Similar to is_link_local_ether_addr(hdr->h_dest) but also covers PTP */
> > > +static inline bool sja1105_is_link_local(const struct sk_buff *skb)
> > > +{
> > > +     const struct ethhdr *hdr = eth_hdr(skb);
> > > +     u64 dmac = ether_addr_to_u64(hdr->h_dest);
> > > +
> > > +     if ((dmac & SJA1105_LINKLOCAL_FILTER_A_MASK) ==
> > > +                 SJA1105_LINKLOCAL_FILTER_A)
> > > +             return true;
> > > +     if ((dmac & SJA1105_LINKLOCAL_FILTER_B_MASK) ==
> > > +                 SJA1105_LINKLOCAL_FILTER_B)
> > > +             return true;
> > > +     return false;
> > > +}
> > > +
> > > +static bool sja1105_filter(const struct sk_buff *skb, struct net_device *dev)
> > > +{
> > > +     if (sja1105_is_link_local(skb))
> > > +             return true;
> > > +     if (!dev->dsa_ptr->vlan_filtering)
> > > +             return true;
> > > +     return false;
> > > +}
> >
> > Please add a comment here about what frames cannot be handled by the
> > tagger. However, i'm not too happy about this design...
> >

> What would you improve about this design (assuming you're talking
> about the filter function)?

I want to understand what frames get passed via the master device, and
how ultimately they get to where they should be going.

Once i understand what sort of frames they are and what is
generating/consuming them, maybe we can find a better solution which
preserves the DSA concepts.

To me, it looks like they are not management frames, at least not BPDU
or PTP, since they are link local. If VLAN filtering is off, the VLAN
tag tells us which port they came in, so we can strip the tag and pass
them to the correct slave.

So it looks like real user frames with a VLAN tag are getting passed
to the master device. So i then assume you put vlan interfaces on top
of the master device, and your application then uses the vlan
interfaces? Your application does not care where the frames came from,
it is using the switch as a dumb switch. The DSA slaves are unused?

Could we enforce that a VLAN can only be assigned to a single port?
The tagger could then pass the tagged frame to the correct slave? Is
that too restrictive for your use case? Do you need the same VLAN on
multiple ports.

	 Andrew
