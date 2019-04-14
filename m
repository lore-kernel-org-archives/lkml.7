Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7E6C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD3D20848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1fAspbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfDNSmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:42:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41595 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNSms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:42:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so13516274lja.8;
        Sun, 14 Apr 2019 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TfuA0z9XkTzeRotfI4BfqAiqQ0bvh06gPLl+kc/FV0=;
        b=O1fAspbIkfTvFTZBwcbJtCXeTyDeoquOhG8FLZa14/lImiQ+Hp5RZZkm34ioH1hMFn
         Yujkb9VvYVJnyq16LzO1Rxvck2o3r0cIfK4DbsOVaublQXLFpibifhYN/SKzniMWGh+k
         190sebM2AWeYO4U9gXnpg0MAjwHZMlEG7mdhQU8WxxUZrGNwvU80mkCKecHmZQgGFHch
         yF8zZMU0+X4FHlR2Gs0G/CQfjW4qndyEWp/hwswWMqlTesVMlBSS01+ri7NN6wI07uvy
         6B4Orz3d+EToVkOKbmP28PI7vWuevQBipnAAG05Fr9sIEjb2Y8XJkCz2jsLFceLQFr+B
         bncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TfuA0z9XkTzeRotfI4BfqAiqQ0bvh06gPLl+kc/FV0=;
        b=a7bmUa41mkp44d4bSrM43H5bwwS5C9+NWcK00i0TLyP94g9uh7pETxM0a7yJxsX4GQ
         zr1nbjmrFNrXsj+jdhX3OAkntPOX4YQqNqKbVei+n95Puc2kPYqcJVDU1V8mnnHmeTL+
         98zf93QR2OScitSrwhkxGfXOLBk+ZtkZv0nO4XqbYWbBlF2A9V/qSTUjtCRnR/agtVyU
         95x1Bv9CMtjr/6eX16zP7MWh0jQHTh20U/Wnp8/pL4cFEyQh5Zat0rYvjl1sIvGDiZsR
         GAgjykjxj9mbxWzQsnvxD253oXZRtMOEkqnqIsTWSIUokS6h3oe7IJ0V+RLqV6olZist
         H55g==
X-Gm-Message-State: APjAAAUlZExsam7t2OLPkafUTfQLMvBbvJg6HQQuMCikBVWd1C2yKBGB
        odhn8ZaWhtNuG6Aj0dKYc4wQI262X4bvVElJO4g=
X-Google-Smtp-Source: APXvYqzCx1IMI9CkOGjXMr+deuARf8q4IbsNKu0N5hItjyU4sPno2T4owY94upHkKpU0hsmZwdsYDL+dlxmTQSpL4is=
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr13687528ljj.44.1555267365995;
 Sun, 14 Apr 2019 11:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-19-olteanv@gmail.com>
 <20190413163754.GG17901@lunn.ch> <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
 <20190414160510.GA10323@lunn.ch>
In-Reply-To: <20190414160510.GA10323@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sun, 14 Apr 2019 21:42:34 +0300
Message-ID: <CA+h21hoG8hRPoakx0Wvx1XyPVo2wmB-L=Y-7hGir5Pk1_NgaEg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019 at 19:05, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Apr 14, 2019 at 12:27:50AM +0300, Vladimir Oltean wrote:
> > > > +             mgmt_route.macaddr = ether_addr_to_u64(hdr->h_dest);
> > > > +             mgmt_route.destports = BIT(port);
> > > > +             mgmt_route.enfport = 1;
> > > > +             mgmt_route.tsreg = 0;
> > > > +             mgmt_route.takets = false;
> > > > +
> > > > +             rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
> > > > +                                               port, &mgmt_route, true);
>
> >         rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
> >                           *port*, &mgmt_route, true);
> >
> > The switch IP aptly allocates 4 slots for management routes. And it's
> > a 5-port switch where 1 port is the management port. I think the
> > structure is fine.
>
> So does the hardware look over all the slots and find the first one
> which has a matching mgmt_route.macaddr destination MAC address? You
> wait for the enfport to be cleared. I assume a slot with enfport
> cleared is not active and won't match?
>
> So we need to consider if there is a race condition where we have
> multiple slots with the same destination MAC address, but different
> destination ports? Say the bridge sends out BPDU to all ports of a
> bridge in quick succession.
>
> These work queues run in any order, and can sleep. Can we get into a
> situation where we get the two slots setup, and then the frames sent
> in reverse order? The match then happens backwards, and the frames get
> sent out the wrong port?
>

Yes, it looks like the hardware isn't doing me any favors on this one.
From UM10944: "If the host provides several management route entries
with identical values for the MACADDR, the one at the lowest index is
used first."
So the 4 hardware management slots serve no purpose unless I'm willing
to lock the sja1105_xmit_work_handler with a mutex. And even then
there's no reason to use separate slots since the workers are
serialized anyway. Weird.

> Or say the two slots are setup, the two frames are sent in order, but
> the stack decided to drop the first frame because buffers are
> full. Can the second frame make it to the switch and match on the
> first slot and go out the wrong port?
>

Yes if waiting for enfport times out there's some cleanup work I'm
currently not doing.

> > > Also, please move all this code into the tagger. Just add exports for
> > > sja1105_dynamic_config_write() and sja1105_dynamic_config_read().
> > >
> >
> > Well, you see, the tagger code is part of the dsa_core object. If I
> > export function symbols from the driver, those still won't be there if
> > I compile the driver as a module. On the other hand, the way I'm doing
> > it, I think the schedule_work() gives me a pretty good separation.
>
> That is solvable via Kconfig, don't allow it to be built as a module.
>
> Also, DSA has been very successful, we keep getting more switches from
> different vendors, and hence more taggers. So at some point, we should
> turn the taggers into modules. I'm not saying that should happen now,
> but when it does happen, this driver can then become a module.
>
> The real reason is, tagger as all about handling frames, where as
> drivers are all about configuring the switch. The majority of this
> code is about frames, so it belongs in the tagger.
>

The xmit worker needs to configure the switch to be able to handle
frames. Why doesn't that belong in the driver?
Not allowing the driver to be built as module is hardly any cleaner
than a schedule_work().
I only need dsa_slave_to_master for the delayed enqueue. And if DSA
supported a delayed enqueue method natively I wouldn't need it at all.

> > > > +#include <linux/etherdevice.h>
> > > > +#include <linux/if_vlan.h>
> > > > +#include <linux/dsa/sja1105.h>
> > > > +#include "../../drivers/net/dsa/sja1105/sja1105.h"
> > >
> > > Again, no, don't do this.
> > >
> >
> > This separation between driver and tagger is fairly arbitrary.
> > I need access to the driver's private structure, in order to get a
> > hold of the private shadow of the dsa_port. Moving the driver private
> > structure to include/linux/dsa/ would pull in quite a number of
> > dependencies. Maybe I could provide declarations for the most of them,
> > but anyway the private structure wouldn't be so private any longer,
> > would it?
> > Otherwise put, would you prefer a dp->priv similar to the already
> > existing ds->priv? struct sja1105_port is much more lightweight to
> > keep in include/linux/dsa/.
>
> Linux simply does not make use of relative paths going between
> directories like this. That is the key point here. Whatever you need
> to share between the tagger and the driver has to be put into
> include/linux/dsa/.
>
> Assuming we are just exporting something like
> sja1105_dynamic_config_write() and _read()
>
>
> > > > +             rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
> > > > +                                               port, &mgmt_route, true);
>
> priv can be replaced with ds, which the tagger has. port is
> known. BLK_IDX_MGMT_ROUTE is implicit, and all that the tagger needs
> to pass for mgmt_route is the destination MAC address, which it has.
>
> The tagger does need somewhere to keep the queue of frames to be sent
> and its workqueue. I would probably add a void *tagger_priv to
> dsa_switch, and two new methods to dsa_device_ops, .probe and
> .release, to allow it to create and destroy what it needs in
> tagger_priv.
>

I need to think about this.

> > > > +#include "dsa_priv.h"
> > > > +
> > > > +/* Similar to is_link_local_ether_addr(hdr->h_dest) but also covers PTP */
> > > > +static inline bool sja1105_is_link_local(const struct sk_buff *skb)
> > > > +{
> > > > +     const struct ethhdr *hdr = eth_hdr(skb);
> > > > +     u64 dmac = ether_addr_to_u64(hdr->h_dest);
> > > > +
> > > > +     if ((dmac & SJA1105_LINKLOCAL_FILTER_A_MASK) ==
> > > > +                 SJA1105_LINKLOCAL_FILTER_A)
> > > > +             return true;
> > > > +     if ((dmac & SJA1105_LINKLOCAL_FILTER_B_MASK) ==
> > > > +                 SJA1105_LINKLOCAL_FILTER_B)
> > > > +             return true;
> > > > +     return false;
> > > > +}
> > > > +
> > > > +static bool sja1105_filter(const struct sk_buff *skb, struct net_device *dev)
> > > > +{
> > > > +     if (sja1105_is_link_local(skb))
> > > > +             return true;
> > > > +     if (!dev->dsa_ptr->vlan_filtering)
> > > > +             return true;
> > > > +     return false;
> > > > +}
> > >
> > > Please add a comment here about what frames cannot be handled by the
> > > tagger. However, i'm not too happy about this design...
> > >
>
> > What would you improve about this design (assuming you're talking
> > about the filter function)?
>
> I want to understand what frames get passed via the master device, and
> how ultimately they get to where they should be going.
>
> Once i understand what sort of frames they are and what is
> generating/consuming them, maybe we can find a better solution which
> preserves the DSA concepts.
>
> To me, it looks like they are not management frames, at least not BPDU
> or PTP, since they are link local. If VLAN filtering is off, the VLAN
> tag tells us which port they came in, so we can strip the tag and pass
> them to the correct slave.
>
> So it looks like real user frames with a VLAN tag are getting passed
> to the master device. So i then assume you put vlan interfaces on top
> of the master device, and your application then uses the vlan
> interfaces? Your application does not care where the frames came from,
> it is using the switch as a dumb switch. The DSA slaves are unused?
>

Whatever the application may be, the DSA solution to switches that
can't decode all incoming traffic is to drop the rest. In this case it
means that the host port is no longer a valid destination for the L2
switching process.

> Could we enforce that a VLAN can only be assigned to a single port?
> The tagger could then pass the tagged frame to the correct slave? Is
> that too restrictive for your use case? Do you need the same VLAN on
> multiple ports.
>
>          Andrew

No we can't enforce that. The commit message of 07/24 has a pretty
lengthy explanation why.

Thanks,
-Vladimir
