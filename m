Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742ACC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132062147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6fg2So8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDMW0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:26:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35534 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDMW0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 18:26:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so3566687ljc.2;
        Sat, 13 Apr 2019 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dw8nUW/x9U2PANf4yxX50gsb2JayiatU9aBgexZhxl4=;
        b=I6fg2So80orw8Y4Kv/InDusFRCa4FcULAAjTQNXes+EyvRuJkRguLRKK3Ka4BN2bdK
         TGUlyv6reuQfJdQpAsQpxw61g+KADrZQQPBxTT7WVC1LyIKXXjLFM7nZnmyT9DjcSWzB
         HBob1o1TSRrNwxOpC/wcJCmncxfgVsWAfcqSjFtbvxpL9tDk3jgYtSqhHxAJJ3kMsOPR
         f/EJHvYx1QURXT343AO0beb3tPql6v9DlQjEg86an482zy22DLuuFRmWd/T+FHWLLNd6
         gesSrO9rRv4WNB2i6ltsLeMwRxR1Snx15NE+Hwy97avsRlXDJvLtrj4wLJM4C6tnmQ7w
         1mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dw8nUW/x9U2PANf4yxX50gsb2JayiatU9aBgexZhxl4=;
        b=evWmhlXQb0dzI5Tdqxv0ua7gPA9l9zbFlnyIg7OcEoyYirb+JiHMglHYhztX92Rt4X
         B8ZdLTHvGxx4psKSL3+pczQZ81Sy7a7mJeuFncejVT4QOx9sWgpWrCfWCGIUiRugPlwg
         ln8kMiRYHCUmYgZpnr6HjfMm/F+4HRF5ZpfYDQu0YLAG1XlalAq9POFvbTA8Ofp6Hvkm
         fEreu2wM+qqx71Omg1Hcv1wobWvt+xjQqGN67u/RpU1kZ3zJsSn3gdACL8p4MEQ/tMvc
         zd2zgUEgG8YU1Qtm6SyezwXGNb8RK0xmKEL2iIQq9MHg7nHnAkbHdOYxtViAYKnwIB5l
         F3VA==
X-Gm-Message-State: APjAAAU71nR7vfjoiQ5u/5lTgwW7aflcwi4KcaXtFwsOlJJYkn7L8tOl
        TnIhR/61LNBPEZKi0PMdhpgLkq3ao+g9RYgAP88=
X-Google-Smtp-Source: APXvYqwjsxI3NBxEPNEIch96Je1n6IAu75QX/TgkLfno0iNfFNxEJ2Rm4zMdDSBm6Ew14h3+aYz3mswRNzgczH17WTw=
X-Received: by 2002:a2e:b058:: with SMTP id d24mr7201556ljl.42.1555194379432;
 Sat, 13 Apr 2019 15:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-19-olteanv@gmail.com>
 <20190413163754.GG17901@lunn.ch> <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
 <CA+h21hp=_LrGDZo3Jmoe2hNKqx7nrdqRbK3UWYntN-9My-z5Hg@mail.gmail.com>
In-Reply-To: <CA+h21hp=_LrGDZo3Jmoe2hNKqx7nrdqRbK3UWYntN-9My-z5Hg@mail.gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sun, 14 Apr 2019 01:26:08 +0300
Message-ID: <CA+h21hp47bOwvEdF5KCV0bAo01mv+K11JSuP9AzEoWHTjmVAtQ@mail.gmail.com>
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

On Sun, 14 Apr 2019 at 01:08, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Sun, 14 Apr 2019 at 00:27, Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > On Sat, 13 Apr 2019 at 19:38, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Sat, Apr 13, 2019 at 04:28:16AM +0300, Vladimir Oltean wrote:
> > > > In order to support this, we are creating a make-shift switch tag out of
> > > > a VLAN trunk configured on the CPU port. Termination of normal traffic
> > > > on switch ports only works when not under a vlan_filtering bridge.
> > > > Termination of management (PTP, BPDU) traffic works under all
> > > > circumstances because it uses a different tagging mechanism
> > > > (incl_srcpt). We are making use of the generic CONFIG_NET_DSA_TAG_8021Q
> > > > code and leveraging it from our own CONFIG_NET_DSA_TAG_SJA1105.
> > > >
> > > > There are two types of traffic: regular and link-local.
> > > > The link-local traffic received on the CPU port is trapped from the
> > > > switch's regular forwarding decisions because it matched one of the two
> > > > DMAC filters for management traffic.
> > > > On transmission, the switch requires special massaging for these
> > > > link-local frames. Due to a weird implementation of the switching IP, by
> > > > default it drops link-local frames that originate on the CPU port. It
> > > > needs to be told where to forward them to, through an SPI command
> > > > ("management route") that is valid for only a single frame.
> > > > So when we're sending link-local traffic, we need to clone skb's from
> > > > DSA and send them in our custom xmit worker that also performs SPI access.
> > > >
> > > > For that purpose, the DSA xmit handler and the xmit worker communicate
> > > > through a per-port "skb ring" software structure, with a producer and a
> > > > consumer index. At the moment this structure is rather fragile
> > > > (ping-flooding to a link-local DMAC would cause most of the frames to
> > > > get dropped). I would like to move the management traffic on a separate
> > > > netdev queue that I can stop when the skb ring got full and hardware is
> > > > busy processing, so that we are not forced to drop traffic.
> > > >
> > > > Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> > > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > ---
> > > > Changes in v3:
> > > > Made management traffic be receivable on the DSA netdevices even when
> > > > switch tagging is disabled, as well as regular traffic be receivable on
> > > > the master netdevice in the same scenario. Both are accomplished using
> > > > the sja1105_filter() function and some small touch-ups in the .rcv
> > > > callback.
> > >
> > > It seems like you made major changes to this. When you do that, you
> > > should drop any reviewed-by tags you have. They are no longer valid
> > > because of the major changes.
> > >
> >
> > Ok, noted.
> >
> > > >  /* This callback needs to be present */
> > > > @@ -1141,7 +1158,11 @@ static int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled)
> > > >       if (rc)
> > > >               dev_err(ds->dev, "Failed to change VLAN Ethertype\n");
> > > >
> > > > -     return rc;
> > > > +     /* Switch port identification based on 802.1Q is only passable
> > >
> > > possible, not passable.
> > >
> >
> > Passable (satisfactory, decent, acceptable) is what I wanted to say.
> > Tagging using VLANs is possible even when the bridge wants to use
> > them, but it's smarter not to go there. But I get your point, maybe
> > I'll rephrase.
> >
> > > > +      * if we are not under a vlan_filtering bridge. So make sure
> > > > +      * the two configurations are mutually exclusive.
> > > > +      */
> > > > +     return sja1105_setup_8021q_tagging(ds, !enabled);
> > > >  }
> > > >
> > > >  static void sja1105_vlan_add(struct dsa_switch *ds, int port,
> > > > @@ -1233,9 +1254,107 @@ static int sja1105_setup(struct dsa_switch *ds)
> > > >        */
> > > >       ds->vlan_filtering_is_global = true;
> > > >
> > > > +     /* The DSA/switchdev model brings up switch ports in standalone mode by
> > > > +      * default, and that means vlan_filtering is 0 since they're not under
> > > > +      * a bridge, so it's safe to set up switch tagging at this time.
> > > > +      */
> > > > +     return sja1105_setup_8021q_tagging(ds, true);
> > > > +}
> > > > +
> > > > +#include "../../../net/dsa/dsa_priv.h"
> > >
> > > No. Don't use relative includes like this.
> > >
> > > What do you need from the header? Maybe move it into
> > > include/linux/net/dsa.h
> > >
> >
> > dsa_slave_to_master()
> >
> > > > +/* Deferred work is unfortunately necessary because setting up the management
> > > > + * route cannot be done from atomit context (SPI transfer takes a sleepable
> > > > + * lock on the bus)
> > > > + */
> > > > +static void sja1105_xmit_work_handler(struct work_struct *work)
> > > > +{
> > > > +     struct sja1105_port *sp = container_of(work, struct sja1105_port,
> > > > +                                             xmit_work);
> > > > +     struct sja1105_private *priv = sp->dp->ds->priv;
> > > > +     struct net_device *slave = sp->dp->slave;
> > > > +     struct net_device *master = dsa_slave_to_master(slave);
> > > > +     int port = (uintptr_t)(sp - priv->ports);
> > > > +     struct sk_buff *skb;
> > > > +     int i, rc;
> > > > +
> > > > +     while ((i = sja1105_skb_ring_get(&sp->xmit_ring, &skb)) >= 0) {
> > > > +             struct sja1105_mgmt_entry mgmt_route = { 0 };
> > > > +             struct ethhdr *hdr;
> > > > +             int timeout = 10;
> > > > +             int skb_len;
> > > > +
> > > > +             skb_len = skb->len;
> > > > +             hdr = eth_hdr(skb);
> > > > +
> > > > +             mgmt_route.macaddr = ether_addr_to_u64(hdr->h_dest);
> > > > +             mgmt_route.destports = BIT(port);
> > > > +             mgmt_route.enfport = 1;
> > > > +             mgmt_route.tsreg = 0;
> > > > +             mgmt_route.takets = false;
> > > > +
> > > > +             rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
> > > > +                                               port, &mgmt_route, true);
> > > > +             if (rc < 0) {
> > > > +                     kfree_skb(skb);
> > > > +                     slave->stats.tx_dropped++;
> > > > +                     continue;
> > > > +             }
> > > > +
> > > > +             /* Transfer skb to the host port. */
> > > > +             skb->dev = master;
> > > > +             dev_queue_xmit(skb);
> > > > +
> > > > +             /* Wait until the switch has processed the frame */
> > > > +             do {
> > > > +                     rc = sja1105_dynamic_config_read(priv, BLK_IDX_MGMT_ROUTE,
> > > > +                                                      port, &mgmt_route);
> > > > +                     if (rc < 0) {
> > > > +                             slave->stats.tx_errors++;
> > > > +                             dev_err(priv->ds->dev,
> > > > +                                     "xmit: failed to poll for mgmt route\n");
> > > > +                             continue;
> > > > +                     }
> > > > +
> > > > +                     /* UM10944: The ENFPORT flag of the respective entry is
> > > > +                      * cleared when a match is found. The host can use this
> > > > +                      * flag as an acknowledgment.
> > > > +                      */
> > > > +                     cpu_relax();
> > > > +             } while (mgmt_route.enfport && --timeout);
> > > > +
> > > > +             if (!timeout) {
> > > > +                     dev_err(priv->ds->dev, "xmit timed out\n");
> > > > +                     slave->stats.tx_errors++;
> > > > +                     continue;
> > > > +             }
> > > > +
> > > > +             slave->stats.tx_packets++;
> > > > +             slave->stats.tx_bytes += skb_len;
> > > > +     }
> > > > +}
> > > > +
> > > > +static int sja1105_port_enable(struct dsa_switch *ds, int port,
> > > > +                            struct phy_device *phydev)
> > > > +{
> > > > +     struct sja1105_private *priv = ds->priv;
> > > > +     struct sja1105_port *sp = &priv->ports[port];
> > > > +
> > > > +     sp->dp = &ds->ports[port];
> > > > +     INIT_WORK(&sp->xmit_work, sja1105_xmit_work_handler);
> > > >       return 0;
> > > >  }
> > >
> > > I think i'm missing something here. You have a per port queue of link
> > > local frames which need special handling. And you have a per-port work
> > > queue. To send such a frame, you need to write some register, send the
> > > frame, and then wait until the mgmt_route.enfport is reset.
> > >
> > > Why are you doing this per port? How do you stop two ports/work queues
> > > running at the same time? It seems like one queue, with one work queue
> > > would be a better structure.
> > >
> >
> > See the "port" parameter to this call here:
> >
> >         rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
> >                           *port*, &mgmt_route, true);
> >
> > The switch IP aptly allocates 4 slots for management routes. And it's
> > a 5-port switch where 1 port is the management port. I think the
> > structure is fine.
> >
>
> "How do stop two work queues": if you're talking about contention on
> the hardware management route, I responded to that.
> If you're talking about netif_stop_queue(), I think I'm going to avoid
> that altogether by not having a finite sized ring structure. While
> studying the Marvell 88e6060 driver I found out that sk_buff_head
> exists. Now I'm part of the elite club of wheel reinventors with my
> struct sja1105_skb_ring :)
>
>
> > > Also, please move all this code into the tagger. Just add exports for
> > > sja1105_dynamic_config_write() and sja1105_dynamic_config_read().
> > >
> >
> > Well, you see, the tagger code is part of the dsa_core object. If I
> > export function symbols from the driver, those still won't be there if
> > I compile the driver as a module. On the other hand, the way I'm doing
> > it, I think the schedule_work() gives me a pretty good separation.
> >
> > > > +static void sja1105_port_disable(struct dsa_switch *ds, int port)
> > > > +{
> > > > +     struct sja1105_private *priv = ds->priv;
> > > > +     struct sja1105_port *sp = &priv->ports[port];
> > > > +     struct sk_buff *skb;
> > > > +
> > > > +     cancel_work_sync(&sp->xmit_work);
> > > > +     while (sja1105_skb_ring_get(&sp->xmit_ring, &skb) >= 0)
> > > > +             kfree_skb(skb);
> > > > +}
> > > > +
> > > > diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
> > > > new file mode 100644
> > > > index 000000000000..5c76a06c9093
> > > > --- /dev/null
> > > > +++ b/net/dsa/tag_sja1105.c
> > > > @@ -0,0 +1,148 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
> > > > + */
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
> >
> > > > +
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
> >
> > Ok, let's put this another way.
> > A switch is primarily a device used to offload the forwarding of
> > traffic based on L2 rules. Additionally there may be some management
> > traffic for stuff like STP that needs to be terminated on the host
> > port of the switch. For that, the hardware's job is to filter and tag
> > management frames on their way to the host port, and the software's
> > job is to process the source port and switch id information in a
> > meaningful way.
> > Now both this particular switch hardware, and DSA, are taking the
> > above definitions to extremes.
> > The switch says: "that's all you want to see? ok, so that's all I'm
> > going to give you". So its native (hardware) tagging protocol is to
> > trap link-local traffic and overwrite two bytes of its destination MAC
> > with the switch ID and the source port. No more, no less. It is an
> > incomplete solution, but it does the job for practical use cases.
> > Now DSA says: "I want these to be fully capable net devices, I want
> > the user to not even realize what's going on under the hood". I don't
> > think that terminating iperf traffic through switch ports is a
> > realistic usage scenario. So in a way discussions about performance
> > and optimizations on DSA hotpath are slightly pointless IMO.
> > Now what my driver says is that it offers a bit of both. It speaks the
> > hardware's tagging protocol so it is capable of management traffic,
> > but it also speaks the DSA paradigm, so in a way pushes the hardware
> > to work in a mode it was never intended to, by repurposing VLANs when
> > the user doesn't request them. So on one hand there is some overlap
> > between the hardware tagging protocol and the VLAN one (in standalone
> > mode and in VLAN-unaware bridged mode, management traffic *could* use
> > VLAN tagging but it doesn't rely on it), and on the other hand the
> > reunion of the two tagging protocols is decent, but still doesn't
> > cover the entire spectrum (when put under a VLAN-aware bridge, you
> > lose the ability to decode general traffic). So you'd better not rely
> > on VLANs to decode the management traffic, because you won't be able
> > to always rely on that, and that is a shame since a bridge with both
> > vlan_filtering 1 and stp_state 1 is a real usage scenario, and the
> > hardware is capable of that combination.
> > But all of that is secondary. Let's forget about VLAN tagging for a
> > second and concentrate on the tagging of management traffic. The
> > limiting factor here is the software architecture of DSA, because in
> > order for me to decode that in the driver/tagger, I'd have to drop
> > everything else coming on the master net device (I explained in 13/24
> > why). I believe that DSA being all-or-nothing about switch tagging is
> > turning a blind eye to the devices that don't go overboard with
> > features, and give you what's needed in a real-world design but not
> > much else.
> > What would you improve about this design (assuming you're talking
> > about the filter function)?
> >
> > Thanks,
> > -Vladimir
> >
> >
> >
> >
> >
> > > > +
> > > > +static struct sk_buff *sja1105_xmit(struct sk_buff *skb,
> > > > +                                 struct net_device *netdev)
> > > > +{
> > > > +     struct dsa_port *dp = dsa_slave_to_port(netdev);
> > > > +     struct dsa_switch *ds = dp->ds;
> > > > +     struct sja1105_private *priv = ds->priv;
> > > > +     struct sja1105_port *sp = &priv->ports[dp->index];
> > > > +     struct sk_buff *clone;
> > > > +
> > > > +     if (likely(!sja1105_is_link_local(skb))) {
> > > > +             /* Normal traffic path. */
> > > > +             u16 tx_vid = dsa_tagging_tx_vid(ds, dp->index);
> > > > +             u8 pcp = skb->priority;
> > > > +
> > > > +             /* If we are under a vlan_filtering bridge, IP termination on
> > > > +              * switch ports based on 802.1Q tags is simply too brittle to
> > > > +              * be passable. So just defer to the dsa_slave_notag_xmit
> > > > +              * implementation.
> > > > +              */
> > > > +             if (dp->vlan_filtering)
> > > > +                     return skb;
> > > > +
> > > > +             return dsa_8021q_xmit(skb, netdev, ETH_P_EDSA,
> > > > +                                  ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
> > >
> > > Please don't reuse ETH_P_EDSA. Define an ETH_P_SJA1105.
> > >

I'm receiving contradictory advice on this. Why should I define a new
ethertype, and if I do, what scope should the definition have (local
to the driver and the tagger, local to DSA, UAPI)?

> > > > +     }
> > > > +
> > > > +     /* Code path for transmitting management traffic. This does not rely
> > > > +      * upon switch tagging, but instead SPI-installed management routes.
> > > > +      */
> > > > +     clone = skb_clone(skb, GFP_ATOMIC);
> > > > +     if (!clone) {
> > > > +             dev_err(ds->dev, "xmit: failed to clone skb\n");
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     if (sja1105_skb_ring_add(&sp->xmit_ring, clone) < 0) {
> > > > +             dev_err(ds->dev, "xmit: skb ring full\n");
> > > > +             kfree_skb(clone);
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     if (sp->xmit_ring.count == SJA1105_SKB_RING_SIZE)
> > > > +             /* TODO setup a dedicated netdev queue for management traffic
> > > > +              * so that we can selectively apply backpressure and not be
> > > > +              * required to stop the entire traffic when the software skb
> > > > +              * ring is full. This requires hooking the ndo_select_queue
> > > > +              * from DSA and matching on mac_fltres.
> > > > +              */
> > > > +             dev_err(ds->dev, "xmit: reached maximum skb ring size\n");
> > >
> > > This should be rate limited.
> > >

Again, with sk_buff_head it'll probably completely go away.

> > >      Andrew
> > >
> > > > +
> > > > +     schedule_work(&sp->xmit_work);
> > > > +     /* Let DSA free its reference to the skb and we will free
> > > > +      * the clone in the deferred worker
> > > > +      */
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
> > > > +                                struct net_device *netdev,
> > > > +                                struct packet_type *pt)
> > > > +{
> > > > +     unsigned int source_port, switch_id;
> > > > +     struct ethhdr *hdr = eth_hdr(skb);
> > > > +     struct sk_buff *nskb;
> > > > +     u16 tpid, vid, tci;
> > > > +     bool is_tagged;
> > > > +
> > > > +     nskb = dsa_8021q_rcv(skb, netdev, pt, &tpid, &tci);
> > > > +     is_tagged = (nskb && tpid == ETH_P_EDSA);
> > > > +
> > > > +     skb->priority = (tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
> > > > +     vid = tci & VLAN_VID_MASK;
> > > > +
> > > > +     skb->offload_fwd_mark = 1;
> > > > +
> > > > +     if (likely(!sja1105_is_link_local(skb))) {
> > > > +             /* Normal traffic path. */
> > > > +             source_port = dsa_tagging_rx_source_port(vid);
> > > > +             switch_id = dsa_tagging_rx_switch_id(vid);
> > > > +     } else {
> > > > +             /* Management traffic path. Switch embeds the switch ID and
> > > > +              * port ID into bytes of the destination MAC, courtesy of
> > > > +              * the incl_srcpt options.
> > > > +              */
> > > > +             source_port = hdr->h_dest[3];
> > > > +             switch_id = hdr->h_dest[4];
> > > > +             /* Clear the DMAC bytes that were mangled by the switch */
> > > > +             hdr->h_dest[3] = 0;
> > > > +             hdr->h_dest[4] = 0;
> > > > +     }
> > > > +
> > > > +     skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
> > > > +     if (!skb->dev) {
> > > > +             netdev_warn(netdev, "Couldn't decode source port\n");
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     /* Delete/overwrite fake VLAN header, DSA expects to not find
> > > > +      * it there, see dsa_switch_rcv: skb_push(skb, ETH_HLEN).
> > > > +      */
> > > > +     if (is_tagged)
> > > > +             memmove(skb->data - ETH_HLEN, skb->data - ETH_HLEN - VLAN_HLEN,
> > > > +                     ETH_HLEN - VLAN_HLEN);
> > > > +
> > > > +     return skb;
> > > > +}
> > > > +
> > > > +const struct dsa_device_ops sja1105_netdev_ops = {
> > > > +     .xmit = sja1105_xmit,
> > > > +     .rcv = sja1105_rcv,
> > > > +     .filter = sja1105_filter,
> > > > +     .overhead = VLAN_HLEN,
> > > > +};
> > > > +
> > > > --
> > > > 2.17.1
> > > >
