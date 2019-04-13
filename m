Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5201BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC1A214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3+EbH4RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfDMQin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:38:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60337 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfDMQil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mZfNWZVZ5qkI2mQvEmBzSpTA7j0xEfiDXYawaAF2vxY=; b=3+EbH4RPmNFA5TYpigx20UPWZi
        67b0v0ShalUr96lWS3stIEWejSmkECn2B8Jk7e+xb8Cpi2XdQHyIv/HE3nt4QqLCA/QwQpnpE2okO
        T+KmYjYDAaE0VpZNsWxnQxMRPNIMebx7Z6uGdPbwzPyIobKtlDrm+TWJFpOnik86mH/0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFLf8-0005ME-3C; Sat, 13 Apr 2019 18:37:54 +0200
Date:   Sat, 13 Apr 2019 18:37:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
Message-ID: <20190413163754.GG17901@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-19-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-19-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 04:28:16AM +0300, Vladimir Oltean wrote:
> In order to support this, we are creating a make-shift switch tag out of
> a VLAN trunk configured on the CPU port. Termination of normal traffic
> on switch ports only works when not under a vlan_filtering bridge.
> Termination of management (PTP, BPDU) traffic works under all
> circumstances because it uses a different tagging mechanism
> (incl_srcpt). We are making use of the generic CONFIG_NET_DSA_TAG_8021Q
> code and leveraging it from our own CONFIG_NET_DSA_TAG_SJA1105.
> 
> There are two types of traffic: regular and link-local.
> The link-local traffic received on the CPU port is trapped from the
> switch's regular forwarding decisions because it matched one of the two
> DMAC filters for management traffic.
> On transmission, the switch requires special massaging for these
> link-local frames. Due to a weird implementation of the switching IP, by
> default it drops link-local frames that originate on the CPU port. It
> needs to be told where to forward them to, through an SPI command
> ("management route") that is valid for only a single frame.
> So when we're sending link-local traffic, we need to clone skb's from
> DSA and send them in our custom xmit worker that also performs SPI access.
> 
> For that purpose, the DSA xmit handler and the xmit worker communicate
> through a per-port "skb ring" software structure, with a producer and a
> consumer index. At the moment this structure is rather fragile
> (ping-flooding to a link-local DMAC would cause most of the frames to
> get dropped). I would like to move the management traffic on a separate
> netdev queue that I can stop when the skb ring got full and hardware is
> busy processing, so that we are not forced to drop traffic.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v3:
> Made management traffic be receivable on the DSA netdevices even when
> switch tagging is disabled, as well as regular traffic be receivable on
> the master netdevice in the same scenario. Both are accomplished using
> the sja1105_filter() function and some small touch-ups in the .rcv
> callback.

It seems like you made major changes to this. When you do that, you
should drop any reviewed-by tags you have. They are no longer valid
because of the major changes.

>  /* This callback needs to be present */
> @@ -1141,7 +1158,11 @@ static int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled)
>  	if (rc)
>  		dev_err(ds->dev, "Failed to change VLAN Ethertype\n");
>  
> -	return rc;
> +	/* Switch port identification based on 802.1Q is only passable

possible, not passable.

> +	 * if we are not under a vlan_filtering bridge. So make sure
> +	 * the two configurations are mutually exclusive.
> +	 */
> +	return sja1105_setup_8021q_tagging(ds, !enabled);
>  }
>  
>  static void sja1105_vlan_add(struct dsa_switch *ds, int port,
> @@ -1233,9 +1254,107 @@ static int sja1105_setup(struct dsa_switch *ds)
>  	 */
>  	ds->vlan_filtering_is_global = true;
>  
> +	/* The DSA/switchdev model brings up switch ports in standalone mode by
> +	 * default, and that means vlan_filtering is 0 since they're not under
> +	 * a bridge, so it's safe to set up switch tagging at this time.
> +	 */
> +	return sja1105_setup_8021q_tagging(ds, true);
> +}
> +
> +#include "../../../net/dsa/dsa_priv.h"

No. Don't use relative includes like this.

What do you need from the header? Maybe move it into
include/linux/net/dsa.h

> +/* Deferred work is unfortunately necessary because setting up the management
> + * route cannot be done from atomit context (SPI transfer takes a sleepable
> + * lock on the bus)
> + */
> +static void sja1105_xmit_work_handler(struct work_struct *work)
> +{
> +	struct sja1105_port *sp = container_of(work, struct sja1105_port,
> +						xmit_work);
> +	struct sja1105_private *priv = sp->dp->ds->priv;
> +	struct net_device *slave = sp->dp->slave;
> +	struct net_device *master = dsa_slave_to_master(slave);
> +	int port = (uintptr_t)(sp - priv->ports);
> +	struct sk_buff *skb;
> +	int i, rc;
> +
> +	while ((i = sja1105_skb_ring_get(&sp->xmit_ring, &skb)) >= 0) {
> +		struct sja1105_mgmt_entry mgmt_route = { 0 };
> +		struct ethhdr *hdr;
> +		int timeout = 10;
> +		int skb_len;
> +
> +		skb_len = skb->len;
> +		hdr = eth_hdr(skb);
> +
> +		mgmt_route.macaddr = ether_addr_to_u64(hdr->h_dest);
> +		mgmt_route.destports = BIT(port);
> +		mgmt_route.enfport = 1;
> +		mgmt_route.tsreg = 0;
> +		mgmt_route.takets = false;
> +
> +		rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
> +						  port, &mgmt_route, true);
> +		if (rc < 0) {
> +			kfree_skb(skb);
> +			slave->stats.tx_dropped++;
> +			continue;
> +		}
> +
> +		/* Transfer skb to the host port. */
> +		skb->dev = master;
> +		dev_queue_xmit(skb);
> +
> +		/* Wait until the switch has processed the frame */
> +		do {
> +			rc = sja1105_dynamic_config_read(priv, BLK_IDX_MGMT_ROUTE,
> +							 port, &mgmt_route);
> +			if (rc < 0) {
> +				slave->stats.tx_errors++;
> +				dev_err(priv->ds->dev,
> +					"xmit: failed to poll for mgmt route\n");
> +				continue;
> +			}
> +
> +			/* UM10944: The ENFPORT flag of the respective entry is
> +			 * cleared when a match is found. The host can use this
> +			 * flag as an acknowledgment.
> +			 */
> +			cpu_relax();
> +		} while (mgmt_route.enfport && --timeout);
> +
> +		if (!timeout) {
> +			dev_err(priv->ds->dev, "xmit timed out\n");
> +			slave->stats.tx_errors++;
> +			continue;
> +		}
> +
> +		slave->stats.tx_packets++;
> +		slave->stats.tx_bytes += skb_len;
> +	}
> +}
> +
> +static int sja1105_port_enable(struct dsa_switch *ds, int port,
> +			       struct phy_device *phydev)
> +{
> +	struct sja1105_private *priv = ds->priv;
> +	struct sja1105_port *sp = &priv->ports[port];
> +
> +	sp->dp = &ds->ports[port];
> +	INIT_WORK(&sp->xmit_work, sja1105_xmit_work_handler);
>  	return 0;
>  }

I think i'm missing something here. You have a per port queue of link
local frames which need special handling. And you have a per-port work
queue. To send such a frame, you need to write some register, send the
frame, and then wait until the mgmt_route.enfport is reset.

Why are you doing this per port? How do you stop two ports/work queues
running at the same time? It seems like one queue, with one work queue
would be a better structure.

Also, please move all this code into the tagger. Just add exports for 
sja1105_dynamic_config_write() and sja1105_dynamic_config_read().

> +static void sja1105_port_disable(struct dsa_switch *ds, int port)
> +{
> +	struct sja1105_private *priv = ds->priv;
> +	struct sja1105_port *sp = &priv->ports[port];
> +	struct sk_buff *skb;
> +
> +	cancel_work_sync(&sp->xmit_work);
> +	while (sja1105_skb_ring_get(&sp->xmit_ring, &skb) >= 0)
> +		kfree_skb(skb);
> +}
> +
> diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
> new file mode 100644
> index 000000000000..5c76a06c9093
> --- /dev/null
> +++ b/net/dsa/tag_sja1105.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
> + */
> +#include <linux/etherdevice.h>
> +#include <linux/if_vlan.h>
> +#include <linux/dsa/sja1105.h>
> +#include "../../drivers/net/dsa/sja1105/sja1105.h"

Again, no, don't do this.

> +
> +#include "dsa_priv.h"
> +
> +/* Similar to is_link_local_ether_addr(hdr->h_dest) but also covers PTP */
> +static inline bool sja1105_is_link_local(const struct sk_buff *skb)
> +{
> +	const struct ethhdr *hdr = eth_hdr(skb);
> +	u64 dmac = ether_addr_to_u64(hdr->h_dest);
> +
> +	if ((dmac & SJA1105_LINKLOCAL_FILTER_A_MASK) ==
> +		    SJA1105_LINKLOCAL_FILTER_A)
> +		return true;
> +	if ((dmac & SJA1105_LINKLOCAL_FILTER_B_MASK) ==
> +		    SJA1105_LINKLOCAL_FILTER_B)
> +		return true;
> +	return false;
> +}
> +
> +static bool sja1105_filter(const struct sk_buff *skb, struct net_device *dev)
> +{
> +	if (sja1105_is_link_local(skb))
> +		return true;
> +	if (!dev->dsa_ptr->vlan_filtering)
> +		return true;
> +	return false;
> +}

Please add a comment here about what frames cannot be handled by the
tagger. However, i'm not too happy about this design...

> +
> +static struct sk_buff *sja1105_xmit(struct sk_buff *skb,
> +				    struct net_device *netdev)
> +{
> +	struct dsa_port *dp = dsa_slave_to_port(netdev);
> +	struct dsa_switch *ds = dp->ds;
> +	struct sja1105_private *priv = ds->priv;
> +	struct sja1105_port *sp = &priv->ports[dp->index];
> +	struct sk_buff *clone;
> +
> +	if (likely(!sja1105_is_link_local(skb))) {
> +		/* Normal traffic path. */
> +		u16 tx_vid = dsa_tagging_tx_vid(ds, dp->index);
> +		u8 pcp = skb->priority;
> +
> +		/* If we are under a vlan_filtering bridge, IP termination on
> +		 * switch ports based on 802.1Q tags is simply too brittle to
> +		 * be passable. So just defer to the dsa_slave_notag_xmit
> +		 * implementation.
> +		 */
> +		if (dp->vlan_filtering)
> +			return skb;
> +
> +		return dsa_8021q_xmit(skb, netdev, ETH_P_EDSA,
> +				     ((pcp << VLAN_PRIO_SHIFT) | tx_vid));

Please don't reuse ETH_P_EDSA. Define an ETH_P_SJA1105.

> +	}
> +
> +	/* Code path for transmitting management traffic. This does not rely
> +	 * upon switch tagging, but instead SPI-installed management routes.
> +	 */
> +	clone = skb_clone(skb, GFP_ATOMIC);
> +	if (!clone) {
> +		dev_err(ds->dev, "xmit: failed to clone skb\n");
> +		return NULL;
> +	}
> +
> +	if (sja1105_skb_ring_add(&sp->xmit_ring, clone) < 0) {
> +		dev_err(ds->dev, "xmit: skb ring full\n");
> +		kfree_skb(clone);
> +		return NULL;
> +	}
> +
> +	if (sp->xmit_ring.count == SJA1105_SKB_RING_SIZE)
> +		/* TODO setup a dedicated netdev queue for management traffic
> +		 * so that we can selectively apply backpressure and not be
> +		 * required to stop the entire traffic when the software skb
> +		 * ring is full. This requires hooking the ndo_select_queue
> +		 * from DSA and matching on mac_fltres.
> +		 */
> +		dev_err(ds->dev, "xmit: reached maximum skb ring size\n");

This should be rate limited.

     Andrew

> +
> +	schedule_work(&sp->xmit_work);
> +	/* Let DSA free its reference to the skb and we will free
> +	 * the clone in the deferred worker
> +	 */
> +	return NULL;
> +}
> +
> +static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
> +				   struct net_device *netdev,
> +				   struct packet_type *pt)
> +{
> +	unsigned int source_port, switch_id;
> +	struct ethhdr *hdr = eth_hdr(skb);
> +	struct sk_buff *nskb;
> +	u16 tpid, vid, tci;
> +	bool is_tagged;
> +
> +	nskb = dsa_8021q_rcv(skb, netdev, pt, &tpid, &tci);
> +	is_tagged = (nskb && tpid == ETH_P_EDSA);
> +
> +	skb->priority = (tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
> +	vid = tci & VLAN_VID_MASK;
> +
> +	skb->offload_fwd_mark = 1;
> +
> +	if (likely(!sja1105_is_link_local(skb))) {
> +		/* Normal traffic path. */
> +		source_port = dsa_tagging_rx_source_port(vid);
> +		switch_id = dsa_tagging_rx_switch_id(vid);
> +	} else {
> +		/* Management traffic path. Switch embeds the switch ID and
> +		 * port ID into bytes of the destination MAC, courtesy of
> +		 * the incl_srcpt options.
> +		 */
> +		source_port = hdr->h_dest[3];
> +		switch_id = hdr->h_dest[4];
> +		/* Clear the DMAC bytes that were mangled by the switch */
> +		hdr->h_dest[3] = 0;
> +		hdr->h_dest[4] = 0;
> +	}
> +
> +	skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
> +	if (!skb->dev) {
> +		netdev_warn(netdev, "Couldn't decode source port\n");
> +		return NULL;
> +	}
> +
> +	/* Delete/overwrite fake VLAN header, DSA expects to not find
> +	 * it there, see dsa_switch_rcv: skb_push(skb, ETH_HLEN).
> +	 */
> +	if (is_tagged)
> +		memmove(skb->data - ETH_HLEN, skb->data - ETH_HLEN - VLAN_HLEN,
> +			ETH_HLEN - VLAN_HLEN);
> +
> +	return skb;
> +}
> +
> +const struct dsa_device_ops sja1105_netdev_ops = {
> +	.xmit = sja1105_xmit,
> +	.rcv = sja1105_rcv,
> +	.filter = sja1105_filter,
> +	.overhead = VLAN_HLEN,
> +};
> +
> -- 
> 2.17.1
> 
