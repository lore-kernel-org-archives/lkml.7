Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46375C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED53020874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI2ubTNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfDJA7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:59:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40657 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfDJA5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so784827wre.7;
        Tue, 09 Apr 2019 17:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Y/pZ6gZ08oObHeXgXPwh7d+YsA/vhNhfV8lOehoLBo=;
        b=DI2ubTNx2t4j0HkR3j2yoj9eOmf7YKjJ2/mTfaQB+CuRmhK9RrJej4XrEfCKyZhVUz
         3zrGZbXWWLClOCOU+rmcm1AAOx4jvw0LkDg3PZy4FBOMlLYvSGszM28rxPQYIKRZuj+0
         3+P0iFxZ5lb+w2Tu6FH1e2efJp4ANbRNXNM3JIAic1IDBmGSsxG1icHyF81hv+lQ3LrD
         q/zawyXa1gvMMjVx8O0+q6wZhjlL3RlsLSxfrNgjogo1fFfXc5Y3ym7jioYeJzL/GH+u
         aXOH/pOUGdXWrtN54Tasus2lI6wAHEL4KyHCrISvg7RRN65lesNfspsm/MnbmhHYTP9L
         udPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Y/pZ6gZ08oObHeXgXPwh7d+YsA/vhNhfV8lOehoLBo=;
        b=a49R9uNe5QXb7cz8pUx5b7Ocp2Eb0mDJ6nTvTugYRxOyM0BzIlRz+JZc+fAGJpWbup
         3v8w+I61CuU8+Y//DoWeTEoadKf/tsTYj+x3gKVQATlAyL9+PZSaN5Q+4kRSoMtlntDZ
         5pdqOb83Df5Zp0AS3SOEOPofaCjJXfJ6r70h/7v3zxabc81Yx3bDSGaaTcDk9Rds4XLU
         JfvbYTCOh6bTO+OKvgN/9c+wfZu6nmKvVjOCQrYdHmkpHrrxsPPsos0VeLcSrPUldpQx
         dzrTLhVelEVJFgokNkeKNoo8bqW9W+sBQeUnRfdAs9AXpLu1uZ0fHOKYKDeMpB60rPMu
         QwTQ==
X-Gm-Message-State: APjAAAU2yU7aeXzz11TzDNsl5CpfV80Z2l58niQqzZe0VB+8jMcLVuSx
        6kKp3C39pUvoa210lVg587Q=
X-Google-Smtp-Source: APXvYqyxvbCzq8dFinkdtz7xlg253vGyOMnF3OpcNHXdJt/6g+cRjEQXSMl/omRNPhzMFh1XCvXZFg==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr24718345wrr.275.1554857849052;
        Tue, 09 Apr 2019 17:57:29 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:28 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 08/22] net: dsa: Optional VLAN-based port separation for switches without tagging
Date:   Wed, 10 Apr 2019 03:56:46 +0300
Message-Id: <20190410005700.31582-9-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides generic DSA code for using VLAN (802.1Q) tags for
the same purpose as a dedicated switch tag for injection/extraction.
It is based on the discussions and interest that has been so far
expressed in https://www.spinics.net/lists/netdev/msg556125.html.

Unlike all other DSA-supported tagging protocols, CONFIG_NET_DSA_TAG_8021Q
does not offer a complete solution for drivers (nor can it). Instead, it
provides generic code that driver can opt into calling:
- dsa_8021q_xmit: Inserts a VLAN header with the specified contents.
  Can be called from another tagging protocol's xmit function.
  Currently the LAN9303 driver is inserting headers that are simply
  802.1Q with custom fields, so this is an opportunity for code reuse.
- dsa_8021q_rcv: Retrieves the TPID and TCI from a VLAN-tagged skb.
  Removing the VLAN header is left as a decision for the caller to make.
- dsa_port_setup_8021q_tagging: For each user port, installs an Rx VID
  and a Tx VID, for proper untagged traffic identification on ingress
  and steering on egress. Also sets up the VLAN trunk on the upstream
  (CPU or DSA) port. Drivers are intentionally left to call this
  function explicitly, depending on the context and hardware support.
  The expected switch behavior and VLAN semantics should not be violated
  under any conditions. That is, after calling
  dsa_port_setup_8021q_tagging, the hardware should still pass all
  ingress traffic, be it tagged or untagged.

This only works when switch ports are standalone, or when they are added
to a VLAN-unaware bridge. It will probably remain this way for the
reasons below.

When added to a bridge that has vlan_filtering 1, the bridge core will
install its own VLANs and reset the pvids through switchdev. For the
bridge core, switchdev is a write-only pipe. All VLAN-related state is
kept in the bridge core and nothing is read from DSA/switchdev or from
the driver. So the bridge core will break this port separation because
it will install the vlan_default_pvid into all switchdev ports.

Even if we could teach the bridge driver about switchdev preference of a
certain vlan_default_pvid (task difficult in itself since the current
setting is per-bridge but we would need it per-port), there would still
exist many other challenges.

Firstly, in the DSA rcv callback, a driver would have to perform an
iterative reverse lookup to find the correct switch port. That is
because the port is a bridge slave, so its Rx VID (port PVID) is subject
to user configuration. How would we ensure that the user doesn't reset
the pvid to a different value (which would make an O(1) translation
impossible), or to a non-unique value within this DSA switch tree (which
would make any translation impossible)?

Finally, not all switch ports are equal in DSA, and that makes it
difficult for the bridge to be completely aware of this anyway.
The CPU port needs to transmit tagged packets (VLAN trunk) in order for
the DSA rcv code to be able to decode source information.
But the bridge code has absolutely no idea which switch port is the CPU
port, if nothing else then just because there is no netdevice registered
by DSA for the CPU port.
Also DSA does not currently allow the user to specify that they want the
CPU port to do VLAN trunking anyway. VLANs are added to the CPU port
using the same flags as they were added on the user port.

So the VLANs installed by dsa_port_setup_8021q_tagging per driver
request should remain private from the bridge's and user's perspective,
and should not alter the VLAN semantics observed by the user.

In the current implementation a VLAN range ending at 4095 (VLAN_N_VID)
is reserved for this purpose. Each port receives a unique Rx VLAN and a
unique Tx VLAN. Separate VLANs are needed for Rx and Tx because they
serve different purposes: on Rx the switch must process traffic as
untagged and process it with a port-based VLAN, but with care not to
hinder bridging. On the other hand, the Tx VLAN is where the
reachability restrictions are imposed, since by tagging frames in the
xmit callback we are telling the switch onto which port to steer the
frame.

Some general guidance on how this support might be employed for
real-life hardware (some comments made by Florian Fainelli):

- If the hardware supports VLAN tag stacking, it should somehow back
  up its private VLAN settings when the bridge tries to override them.
  Then the driver could re-apply them as outer tags. Dedicating an outer
  tag per bridge device would allow identical inner tag VID numbers to
  co-exist, yet preserve broadcast domain isolation.

- If the switch cannot handle VLAN tag stacking, it should disable this
  port separation when added as slave to a vlan_filtering bridge, in
  that case having reduced functionality.

- Drivers for old switches that don't support the entire VLAN_N_VID
  range will need to rework the current range selection mechanism.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
Made NET_DSA_TAG_8021Q select VLAN_8021Q
More verbiage in commit message
More comments
Adapted to the function name change from 05/22.

 include/net/dsa.h   |   4 +
 net/dsa/Kconfig     |  10 +++
 net/dsa/Makefile    |   1 +
 net/dsa/dsa_priv.h  |  10 +++
 net/dsa/tag_8021q.c | 203 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 net/dsa/tag_8021q.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index a16fd577349b..b22c350c40f0 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -574,5 +574,9 @@ int dsa_port_get_phy_strings(struct dsa_port *dp, uint8_t *data);
 int dsa_port_get_ethtool_phy_stats(struct dsa_port *dp, uint64_t *data);
 int dsa_port_get_phy_sset_count(struct dsa_port *dp);
 void dsa_port_phylink_mac_change(struct dsa_switch *ds, int port, bool up);
+#ifdef CONFIG_NET_DSA_TAG_8021Q
+int dsa_port_setup_8021q_tagging(struct dsa_switch *ds, int index,
+				 bool enabled);
+#endif
 
 #endif
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index b695170795c2..b2fc07de8bcb 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -27,6 +27,16 @@ config NET_DSA_LEGACY
 	  This feature is scheduled for removal in 4.17.
 
 # tagging formats
+config NET_DSA_TAG_8021Q
+	select VLAN_8021Q
+	bool
+	help
+	  Unlike the other tagging protocols, the 802.1Q config option simply
+	  provides helpers for other tagging implementations that might rely on
+	  VLAN in one way or another. It is not a complete solution.
+
+	  Drivers which use these helpers should select this as dependency.
+
 config NET_DSA_TAG_BRCM
 	bool
 
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 6e721f7a2947..d7fc3253d497 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -5,6 +5,7 @@ dsa_core-y += dsa.o dsa2.o master.o port.o slave.o switch.o
 dsa_core-$(CONFIG_NET_DSA_LEGACY) += legacy.o
 
 # tagging formats
+dsa_core-$(CONFIG_NET_DSA_TAG_8021Q) += tag_8021q.o
 dsa_core-$(CONFIG_NET_DSA_TAG_BRCM) += tag_brcm.o
 dsa_core-$(CONFIG_NET_DSA_TAG_BRCM_PREPEND) += tag_brcm.o
 dsa_core-$(CONFIG_NET_DSA_TAG_DSA) += tag_dsa.o
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 4246523e3133..cc5ec3759952 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -203,6 +203,16 @@ dsa_slave_to_master(const struct net_device *dev)
 int dsa_switch_register_notifier(struct dsa_switch *ds);
 void dsa_switch_unregister_notifier(struct dsa_switch *ds);
 
+/* tag_8021q.c */
+struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
+			       u16 tpid, u16 tci);
+struct sk_buff *dsa_8021q_rcv(struct sk_buff *skb, struct net_device *netdev,
+			      struct packet_type *pt, u16 *tpid, u16 *tci);
+u16 dsa_tagging_tx_vid(struct dsa_switch *ds, int port);
+u16 dsa_tagging_rx_vid(struct dsa_switch *ds, int port);
+int dsa_tagging_rx_switch_id(u16 vid);
+int dsa_tagging_rx_source_port(u16 vid);
+
 /* tag_brcm.c */
 extern const struct dsa_device_ops brcm_netdev_ops;
 extern const struct dsa_device_ops brcm_prepend_netdev_ops;
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
new file mode 100644
index 000000000000..3eb2d5a43837
--- /dev/null
+++ b/net/dsa/tag_8021q.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
+
+#include "dsa_priv.h"
+
+/* Allocating two VLAN tags per port - one for the Rx VID and
+ * the other for the Tx VID - see below
+ */
+#define DSA_TAGGING_VID_RANGE    (DSA_MAX_SWITCHES * DSA_MAX_PORTS)
+#define DSA_TAGGING_VID_BASE     (VLAN_N_VID - 2 * DSA_TAGGING_VID_RANGE - 1)
+#define DSA_TAGGING_RX_VID_BASE  (DSA_TAGGING_VID_BASE)
+#define DSA_TAGGING_TX_VID_BASE  (DSA_TAGGING_VID_BASE + DSA_TAGGING_VID_RANGE)
+
+/* Returns the VID to be inserted into the frame from xmit for switch steering
+ * instructions on egress. Encodes switch ID and port ID.
+ */
+u16 dsa_tagging_tx_vid(struct dsa_switch *ds, int port)
+{
+	return DSA_TAGGING_TX_VID_BASE + (DSA_MAX_PORTS * ds->index) + port;
+}
+
+/* Returns the VID that will be installed as pvid for this switch port, sent as
+ * tagged egress towards the CPU port and decoded by the rcv function.
+ */
+u16 dsa_tagging_rx_vid(struct dsa_switch *ds, int port)
+{
+	return DSA_TAGGING_RX_VID_BASE + (DSA_MAX_PORTS * ds->index) + port;
+}
+
+/* Returns the decoded switch ID from the Rx VID. */
+int dsa_tagging_rx_switch_id(u16 vid)
+{
+	return ((vid - DSA_TAGGING_RX_VID_BASE) / DSA_MAX_PORTS);
+}
+
+/* Returns the decoded port ID from the Rx VID. */
+int dsa_tagging_rx_source_port(u16 vid)
+{
+	return ((vid - DSA_TAGGING_RX_VID_BASE) % DSA_MAX_PORTS);
+}
+
+/* Rx VLAN tagging (left) and Tx VLAN tagging (right) setup shown for a single
+ * front-panel switch port (here swp0).
+ *
+ * Port identification through VLAN (802.1Q) tags has different requirements
+ * for it to work effectively:
+ *  - On Rx (ingress from network): each front-panel port must have a pvid
+ *    that uniquely identifies it, and the egress of this pvid must be tagged
+ *    towards the CPU port, so that software can recover the source port based
+ *    on the VID in the frame. But this would only work for standalone ports;
+ *    if bridged, this VLAN setup would break autonomous forwarding and would
+ *    force all switched traffic to pass through the CPU. So we must also make
+ *    the other front-panel ports members of this VID we're adding, albeit
+ *    we're not making it their PVID (they'll still have their own).
+ *    By the way - just because we're installing the same VID in multiple
+ *    switch ports doesn't mean that they'll start to talk to one another, even
+ *    while not bridged: the final forwarding decision is still an AND between
+ *    the L2 forwarding information (which is limiting forwarding in this case)
+ *    and the VLAN-based restrictions (of which there are none in this case,
+ *    since all ports are members).
+ *  - On Tx (ingress from CPU and towards network) we are faced with a problem.
+ *    If we were to tag traffic (from within DSA) with the port's pvid, all
+ *    would be well, assuming the switch ports were standalone. Frames would
+ *    have no choice but to be directed towards the correct front-panel port.
+ *    But because we also want the Rx VLAN to not break bridging, then
+ *    inevitably that means that we have to give them a choice (of what
+ *    front-panel port to go out on), and therefore we cannot steer traffic
+ *    based on the Rx VID. So what we do is simply install one more VID on the
+ *    front-panel and CPU ports, and profit off of the fact that steering will
+ *    work just by virtue of the fact that there is only one other port that's
+ *    a member of the VID we're tagging the traffic with - the desired one.
+ *
+ * So at the end, each front-panel port will have one Rx VID (also the PVID),
+ * the Rx VID of all other front-panel ports, and one Tx VID. Whereas the CPU
+ * port will have the Rx and Tx VIDs of all front-panel ports, and on top of
+ * that, is also tagged-input and tagged-output (VLAN trunk).
+ *
+ *               CPU port                               CPU port
+ * +-------------+-----+-------------+    +-------------+-----+-------------+
+ * |  Rx VID     |     |             |    |  Tx VID     |     |             |
+ * |  of swp0    |     |             |    |  of swp0    |     |             |
+ * |             +-----+             |    |             +-----+             |
+ * |                ^ T              |    |                | Tagged         |
+ * |                |                |    |                | ingress        |
+ * |    +-------+---+---+-------+    |    |    +-----------+                |
+ * |    |       |       |       |    |    |    | Untagged                   |
+ * |    |     U v     U v     U v    |    |    v egress                     |
+ * | +-----+ +-----+ +-----+ +-----+ |    | +-----+ +-----+ +-----+ +-----+ |
+ * | |     | |     | |     | |     | |    | |     | |     | |     | |     | |
+ * | |PVID | |     | |     | |     | |    | |     | |     | |     | |     | |
+ * +-+-----+-+-----+-+-----+-+-----+-+    +-+-----+-+-----+-+-----+-+-----+-+
+ *   swp0    swp1    swp2    swp3           swp0    swp1    swp2    swp3
+ */
+int dsa_port_setup_8021q_tagging(struct dsa_switch *ds, int port, bool enabled)
+{
+	int upstream = dsa_upstream_port(ds, port);
+	struct dsa_port *dp = &ds->ports[port];
+	struct dsa_port *upstream_dp = &ds->ports[upstream];
+	u16 rx_vid = dsa_tagging_rx_vid(ds, port);
+	u16 tx_vid = dsa_tagging_tx_vid(ds, port);
+	int i, err;
+
+	/* The CPU port is implicitly configured by
+	 * configuring the front-panel ports
+	 */
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
+	/* Add this user port's Rx VID to the membership list of all others
+	 * (including itself). This is so that bridging will not be hindered.
+	 * L2 forwarding rules still take precedence when there are no VLAN
+	 * restrictions, so there are no concerns about leaking traffic.
+	 */
+	for (i = 0; i < ds->num_ports; i++) {
+		struct dsa_port *other_dp = &ds->ports[i];
+		u16 flags;
+
+		if (i == upstream)
+			/* CPU port needs to see this port's Rx VID
+			 * as tagged egress.
+			 */
+			flags = 0;
+		else if (i == port)
+			/* The Rx VID is pvid on this port */
+			flags = BRIDGE_VLAN_INFO_UNTAGGED |
+				BRIDGE_VLAN_INFO_PVID;
+		else
+			/* The Rx VID is a regular VLAN on all others */
+			flags = BRIDGE_VLAN_INFO_UNTAGGED;
+
+		if (enabled)
+			err = dsa_port_vid_add(other_dp, rx_vid, flags);
+		else
+			err = dsa_port_vid_del(other_dp, rx_vid);
+		if (err) {
+			dev_err(ds->dev, "Failed to apply Rx VID %d to port %d: %d\n",
+				rx_vid, port, err);
+			return err;
+		}
+	}
+	/* Finally apply the Tx VID on this port and on the CPU port */
+	if (enabled)
+		err = dsa_port_vid_add(dp, tx_vid, BRIDGE_VLAN_INFO_UNTAGGED);
+	else
+		err = dsa_port_vid_del(dp, tx_vid);
+	if (err) {
+		dev_err(ds->dev, "Failed to apply Tx VID %d on port %d: %d\n",
+			tx_vid, port, err);
+		return err;
+	}
+	if (enabled)
+		err = dsa_port_vid_add(upstream_dp, tx_vid, 0);
+	else
+		err = dsa_port_vid_del(upstream_dp, tx_vid);
+	if (err) {
+		dev_err(ds->dev, "Failed to apply Tx VID %d on port %d: %d\n",
+			tx_vid, upstream, err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dsa_port_setup_8021q_tagging);
+
+struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
+			       u16 tpid, u16 tci)
+{
+	/* skb->data points at skb_mac_header, which
+	 * is fine for vlan_insert_tag.
+	 */
+	return vlan_insert_tag(skb, htons(tpid), tci);
+}
+EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
+
+struct sk_buff *dsa_8021q_rcv(struct sk_buff *skb, struct net_device *netdev,
+			      struct packet_type *pt, u16 *tpid, u16 *tci)
+{
+	struct vlan_ethhdr *tag;
+
+	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN)))
+		return NULL;
+
+	tag = vlan_eth_hdr(skb);
+	*tpid = ntohs(tag->h_vlan_proto);
+	*tci = ntohs(tag->h_vlan_TCI);
+
+	/* skb->data points in the middle of the VLAN tag,
+	 * after tpid and before tci. This is because so far,
+	 * ETH_HLEN (DMAC, SMAC, EtherType) bytes were pulled.
+	 * There are 2 bytes of VLAN tag left in skb->data, and upper
+	 * layers expect the 'real' EtherType to be consumed as well.
+	 * Coincidentally, a VLAN header is also of the same size as
+	 * the number of bytes that need to be pulled.
+	 */
+	skb_pull_rcsum(skb, VLAN_HLEN);
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(dsa_8021q_rcv);
+
-- 
2.17.1

