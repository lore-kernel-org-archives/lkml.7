Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A41C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EC1217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH/TQwok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDJA6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:58:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35404 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfDJA5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so826194wrp.2;
        Tue, 09 Apr 2019 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VU8aJi31gGQBgpM4Hg5ZPOYR6qybUybox5E4R5LzzZs=;
        b=nH/TQwokOb4uUsx5dva/+ogJqEuwdC7+cqGR6AiO9Dyo/C9lHDKxyfMHHxXvieye6d
         guwrbbxCSbXAbAyBj5AJ1K3lkLwiw5AL7bN1vrC82Kz/zipJKq7d7Oi2x9jZnTqE+rsb
         b5zon5lUtd+4zlIpLqfCIbf57Je64P0Fmn44AZb9yPjHG/LMjRqREuzEt+y4rUc9/RcF
         Q/rfvfGQLgCF+9IWu4CoarRoeAmke1sIi/WRO2HlJb/CSSC1cJueuRpOj9GfEVAhzsVj
         lXrUDholxiPeB6/ADyU69W2pNk0L8yYPm2gc9++XB6Eef8LnJpNjZQB0sQZ1Kn66/ElE
         XjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VU8aJi31gGQBgpM4Hg5ZPOYR6qybUybox5E4R5LzzZs=;
        b=rin2E84VInrj+ub77miWg0ZI0W5nUmWHtACqSCl64dDJyhrPMxOzyKfdZzJz3CTFu+
         ecvGRUIp+C3MiuPIlqBDyhTiyM/mZaTeqOV5QrhINkm2k+FahVbb8YOsjrNEs9YCqWYj
         u7llq/bXLtCqwq6xDG84a8489Ugw8wlhvzJxUqxEzhYcdmo8mbEAfvyfD0ZlwehoX+Cm
         Rh5xKFxeDsWiNcnSv6z/txAZLBuL8K3umE4JofokXmoqRMcqpW4a/slY/Ef2FnWDR6yi
         JHq0vrnrifW+bRE9Osg8NUgkYKwRj3A4Nakb/+F4VbqkbiC40SFlbqUGtmVPtyF6zo2o
         ZCBA==
X-Gm-Message-State: APjAAAWn1vI2uKverqro6iirgmcjyAfOuGHNYXdSrAXkdTMsF4+I1WVq
        4aBXrLXGzH5gq/Mjt0qJVwg=
X-Google-Smtp-Source: APXvYqxx1+N9ijdzSl/yr0XlKlEYpNcuLAC8rwm59H5bImdBDDvvD2zkhrMWY3bsoVKkoNkSo4YBPw==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr24845844wrn.148.1554857859219;
        Tue, 09 Apr 2019 17:57:39 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:38 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 16/22] net: dsa: sja1105: Add support for traffic through standalone ports
Date:   Wed, 10 Apr 2019 03:56:54 +0300
Message-Id: <20190410005700.31582-17-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support this, we are creating a make-shift switch tag out of
a VLAN trunk configured on the CPU port. Termination on switch ports
only works when not under a vlan_filtering bridge. We are making use of
the generic CONFIG_NET_DSA_TAG_8021Q code and leveraging it from our own
CONFIG_NET_DSA_TAG_SJA1105.

There are two types of traffic: regular and link-local.
The link-local traffic received on the CPU port is trapped from the
switch's regular forwarding decisions because it matched one of the two
DMAC filters for management traffic.
On transmission, the switch requires special massaging for these
link-local frames. Due to a weird implementation of the switching IP, by
default it drops link-local frames that originate on the CPU port. It
needs to be told where to forward them to, through an SPI command
("management route") that is valid for only a single frame.
So when we're sending link-local traffic, we need to clone skb's from
DSA and send them in our custom xmit worker that also performs SPI access.

For that purpose, the DSA xmit handler and the xmit worker communicate
through a per-port "skb ring" software structure, with a producer and a
consumer index. At the moment this structure is rather fragile
(ping-flooding to a link-local DMAC would cause most of the frames to
get dropped). I would like to move the management traffic on a separate
netdev queue that I can stop when the skb ring got full and hardware is
busy processing, so that we are not forced to drop traffic.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
Fixed a mistake with a missing ntohs(), which was not caught because
the previously used EtherType (0xDADA) was endian-agnostic.

 drivers/net/dsa/sja1105/sja1105.h      |   8 ++
 drivers/net/dsa/sja1105/sja1105_main.c | 127 ++++++++++++++++++++-
 include/linux/dsa/sja1105.h            |  52 +++++++++
 include/net/dsa.h                      |   1 +
 net/dsa/Kconfig                        |   3 +
 net/dsa/Makefile                       |   1 +
 net/dsa/dsa.c                          |   6 +
 net/dsa/dsa_priv.h                     |   3 +
 net/dsa/tag_sja1105.c                  | 148 +++++++++++++++++++++++++
 9 files changed, 347 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/dsa/sja1105.h
 create mode 100644 net/dsa/tag_sja1105.c

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 80b20bdd8f9c..b7e745c0bb3a 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -5,6 +5,7 @@
 #ifndef _SJA1105_H
 #define _SJA1105_H
 
+#include <linux/dsa/sja1105.h>
 #include <net/dsa.h>
 #include "sja1105_static_config.h"
 
@@ -19,6 +20,12 @@
 #define SJA1105_NUM_TC			8
 #define SJA1105ET_FDB_BIN_SIZE		4
 
+struct sja1105_port {
+	struct dsa_port *dp;
+	struct work_struct xmit_work;
+	struct sja1105_skb_ring xmit_ring;
+};
+
 /* Keeps the different addresses between E/T and P/Q/R/S */
 struct sja1105_regs {
 	u64 device_id;
@@ -63,6 +70,7 @@ struct sja1105_private {
 	struct gpio_desc *reset_gpio;
 	struct spi_device *spidev;
 	struct dsa_switch *ds;
+	struct sja1105_port ports[SJA1105_NUM_PORTS];
 };
 
 #include "sja1105_dynamic_config.h"
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index c31c5a79251d..399469bbb5c4 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1112,10 +1112,25 @@ static int sja1105_vlan_apply(struct sja1105_private *priv, int port, u16 vid,
 	return 0;
 }
 
+static int sja1105_setup_8021q_tagging(struct dsa_switch *ds, bool enabled)
+{
+	int rc, i;
+
+	for (i = 0; i < SJA1105_NUM_PORTS; i++) {
+		rc = dsa_port_setup_8021q_tagging(ds, i, enabled);
+		if (rc < 0) {
+			dev_err(ds->dev, "Failed to setup VLAN tagging for port %d: %d\n",
+				i, rc);
+			return rc;
+		}
+	}
+	return 0;
+}
+
 static enum dsa_tag_protocol
 sja1105_get_tag_protocol(struct dsa_switch *ds, int port)
 {
-	return DSA_TAG_PROTO_NONE;
+	return DSA_TAG_PROTO_SJA1105;
 }
 
 /* This callback needs to be present */
@@ -1127,6 +1142,9 @@ static int sja1105_vlan_prepare(struct dsa_switch *ds, int port,
 
 static int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled)
 {
+	/* Violate some const pointers here */
+	struct dsa_port *dp = (struct dsa_port *)dsa_to_port(ds, port);
+	struct dsa_port *cpu_dp = (struct dsa_port *)dp->cpu_dp;
 	struct sja1105_private *priv = ds->priv;
 	int rc;
 
@@ -1142,7 +1160,12 @@ static int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled)
 	if (rc)
 		dev_err(ds->dev, "Failed to change VLAN Ethertype\n");
 
-	return rc;
+	/* Switch port identification based on 802.1Q is only passable
+	 * if we are not under a vlan_filtering bridge. So make sure
+	 * the two configurations are mutually exclusive.
+	 */
+	cpu_dp->uses_tag_protocol = !enabled;
+	return sja1105_setup_8021q_tagging(ds, !enabled);
 }
 
 static void sja1105_vlan_add(struct dsa_switch *ds, int port,
@@ -1235,9 +1258,107 @@ static int sja1105_setup(struct dsa_switch *ds)
 	 */
 	ds->vlan_filtering_is_global = true;
 
+	/* The DSA/switchdev model brings up switch ports in standalone mode by
+	 * default, and that means vlan_filtering is 0 since they're not under
+	 * a bridge, so it's safe to set up switch tagging at this time.
+	 */
+	return sja1105_setup_8021q_tagging(ds, true);
+}
+
+#include "../../../net/dsa/dsa_priv.h"
+/* Deferred work is unfortunately necessary because setting up the management
+ * route cannot be done from atomit context (SPI transfer takes a sleepable
+ * lock on the bus)
+ */
+static void sja1105_xmit_work_handler(struct work_struct *work)
+{
+	struct sja1105_port *sp = container_of(work, struct sja1105_port,
+						xmit_work);
+	struct sja1105_private *priv = sp->dp->ds->priv;
+	struct net_device *slave = sp->dp->slave;
+	struct net_device *master = dsa_slave_to_master(slave);
+	int port = (uintptr_t)(sp - priv->ports);
+	struct sk_buff *skb;
+	int i, rc;
+
+	while ((i = sja1105_skb_ring_get(&sp->xmit_ring, &skb)) >= 0) {
+		struct sja1105_mgmt_entry mgmt_route = { 0 };
+		struct ethhdr *hdr;
+		int timeout = 10;
+		int skb_len;
+
+		skb_len = skb->len;
+		hdr = eth_hdr(skb);
+
+		mgmt_route.macaddr = ether_addr_to_u64(hdr->h_dest);
+		mgmt_route.destports = BIT(port);
+		mgmt_route.enfport = 1;
+		mgmt_route.tsreg = 0;
+		mgmt_route.takets = false;
+
+		rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
+						  port, &mgmt_route, true);
+		if (rc < 0) {
+			kfree_skb(skb);
+			slave->stats.tx_dropped++;
+			continue;
+		}
+
+		/* Transfer skb to the host port. */
+		skb->dev = master;
+		dev_queue_xmit(skb);
+
+		/* Wait until the switch has processed the frame */
+		do {
+			rc = sja1105_dynamic_config_read(priv, BLK_IDX_MGMT_ROUTE,
+							 port, &mgmt_route);
+			if (rc < 0) {
+				slave->stats.tx_errors++;
+				dev_err(priv->ds->dev,
+					"xmit: failed to poll for mgmt route\n");
+				continue;
+			}
+
+			/* UM10944: The ENFPORT flag of the respective entry is
+			 * cleared when a match is found. The host can use this
+			 * flag as an acknowledgment.
+			 */
+			cpu_relax();
+		} while (mgmt_route.enfport && --timeout);
+
+		if (!timeout) {
+			dev_err(priv->ds->dev, "xmit timed out\n");
+			slave->stats.tx_errors++;
+			continue;
+		}
+
+		slave->stats.tx_packets++;
+		slave->stats.tx_bytes += skb_len;
+	}
+}
+
+static int sja1105_port_enable(struct dsa_switch *ds, int port,
+			       struct phy_device *phydev)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct sja1105_port *sp = &priv->ports[port];
+
+	sp->dp = &ds->ports[port];
+	INIT_WORK(&sp->xmit_work, sja1105_xmit_work_handler);
 	return 0;
 }
 
+static void sja1105_port_disable(struct dsa_switch *ds, int port)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct sja1105_port *sp = &priv->ports[port];
+	struct sk_buff *skb;
+
+	cancel_work_sync(&sp->xmit_work);
+	while (sja1105_skb_ring_get(&sp->xmit_ring, &skb) >= 0)
+		kfree_skb(skb);
+}
+
 static const struct dsa_switch_ops sja1105_switch_ops = {
 	.get_tag_protocol	= sja1105_get_tag_protocol,
 	.setup			= sja1105_setup,
@@ -1257,6 +1378,8 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.port_mdb_prepare	= sja1105_mdb_prepare,
 	.port_mdb_add		= sja1105_mdb_add,
 	.port_mdb_del		= sja1105_mdb_del,
+	.port_enable		= sja1105_port_enable,
+	.port_disable		= sja1105_port_disable,
 };
 
 static int sja1105_check_device_id(struct sja1105_private *priv)
diff --git a/include/linux/dsa/sja1105.h b/include/linux/dsa/sja1105.h
new file mode 100644
index 000000000000..dd40ffa475cc
--- /dev/null
+++ b/include/linux/dsa/sja1105.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+
+/* Included by drivers/net/dsa/sja1105/sja1105.h and net/dsa/tag_sja1105.c */
+
+#ifndef _NET_DSA_SJA1105_H
+#define _NET_DSA_SJA1105_H
+
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+
+#define SJA1105_SKB_RING_SIZE	20
+
+struct sja1105_skb_ring {
+	struct sk_buff *skb[SJA1105_SKB_RING_SIZE];
+	int count;
+	int pi; /* Producer index */
+	int ci; /* Consumer index */
+};
+
+static inline int sja1105_skb_ring_add(struct sja1105_skb_ring *ring,
+				       struct sk_buff *skb)
+{
+	int index;
+
+	if (ring->count == SJA1105_SKB_RING_SIZE)
+		return -1;
+
+	index = ring->pi;
+	ring->skb[index] = skb;
+	ring->pi = (index + 1) % SJA1105_SKB_RING_SIZE;
+	ring->count++;
+	return index;
+}
+
+static inline int sja1105_skb_ring_get(struct sja1105_skb_ring *ring,
+				       struct sk_buff **skb)
+{
+	int index;
+
+	if (ring->count == 0)
+		return -1;
+
+	index = ring->ci;
+	*skb = ring->skb[index];
+	ring->ci = (index + 1) % SJA1105_SKB_RING_SIZE;
+	ring->count--;
+	return index;
+}
+
+#endif /* _NET_DSA_SJA1105_H */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 97325a412156..9308c0747d5f 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -41,6 +41,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ9893,
 	DSA_TAG_PROTO_LAN9303,
 	DSA_TAG_PROTO_MTK,
+	DSA_TAG_PROTO_SJA1105,
 	DSA_TAG_PROTO_QCA,
 	DSA_TAG_PROTO_TRAILER,
 	DSA_TAG_LAST,		/* MUST BE LAST */
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index b2fc07de8bcb..18deab52890f 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -65,6 +65,9 @@ config NET_DSA_TAG_LAN9303
 config NET_DSA_TAG_MTK
 	bool
 
+config NET_DSA_TAG_SJA1105
+	bool
+
 config NET_DSA_TAG_TRAILER
 	bool
 
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index d7fc3253d497..8c294cdb895a 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -15,4 +15,5 @@ dsa_core-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 dsa_core-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 dsa_core-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
 dsa_core-$(CONFIG_NET_DSA_TAG_QCA) += tag_qca.o
+dsa_core-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 dsa_core-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 36de4f2a3366..4b5d7cd0294a 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -65,6 +65,9 @@ const struct dsa_device_ops *dsa_device_ops[DSA_TAG_LAST] = {
 #ifdef CONFIG_NET_DSA_TAG_MTK
 	[DSA_TAG_PROTO_MTK] = &mtk_netdev_ops,
 #endif
+#ifdef CONFIG_NET_DSA_TAG_SJA1105
+	[DSA_TAG_PROTO_SJA1105] = &sja1105_netdev_ops,
+#endif
 #ifdef CONFIG_NET_DSA_TAG_QCA
 	[DSA_TAG_PROTO_QCA] = &qca_netdev_ops,
 #endif
@@ -102,6 +105,9 @@ const char *dsa_tag_protocol_to_str(const struct dsa_device_ops *ops)
 #ifdef CONFIG_NET_DSA_TAG_MTK
 		[DSA_TAG_PROTO_MTK] = "mtk",
 #endif
+#ifdef CONFIG_NET_DSA_TAG_SJA1105
+		[DSA_TAG_PROTO_SJA1105] = "sja1105",
+#endif
 #ifdef CONFIG_NET_DSA_TAG_QCA
 		[DSA_TAG_PROTO_QCA] = "qca",
 #endif
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index cc5ec3759952..d58a749c8b5b 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -236,6 +236,9 @@ extern const struct dsa_device_ops lan9303_netdev_ops;
 /* tag_mtk.c */
 extern const struct dsa_device_ops mtk_netdev_ops;
 
+/* tag_sja1105.c */
+extern const struct dsa_device_ops sja1105_netdev_ops;
+
 /* tag_qca.c */
 extern const struct dsa_device_ops qca_netdev_ops;
 
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
new file mode 100644
index 000000000000..ea4c2ff4db07
--- /dev/null
+++ b/net/dsa/tag_sja1105.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/dsa/sja1105.h>
+#include "../../drivers/net/dsa/sja1105/sja1105.h"
+
+#include "dsa_priv.h"
+
+/* Similar to is_link_local_ether_addr(hdr->h_dest) but also covers PTP */
+static inline bool sja1105_is_link_local(struct sk_buff *skb)
+{
+	struct ethhdr *hdr = eth_hdr(skb);
+	u64 dmac = ether_addr_to_u64(hdr->h_dest);
+
+	if ((dmac & SJA1105_LINKLOCAL_FILTER_A_MASK) ==
+		    SJA1105_LINKLOCAL_FILTER_A)
+		return true;
+	if ((dmac & SJA1105_LINKLOCAL_FILTER_B_MASK) ==
+		    SJA1105_LINKLOCAL_FILTER_B)
+		return true;
+	return false;
+}
+
+static struct sk_buff *sja1105_xmit(struct sk_buff *skb,
+				    struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	struct dsa_switch *ds = dp->ds;
+	struct sja1105_private *priv = ds->priv;
+	struct sja1105_port *sp = &priv->ports[dp->index];
+	struct sk_buff *clone;
+
+	if (likely(!sja1105_is_link_local(skb))) {
+		/* Normal traffic path. */
+		u16 tx_vid = dsa_tagging_tx_vid(ds, dp->index);
+		u8 pcp = skb->priority;
+
+		/* If we are under a vlan_filtering bridge, IP termination on
+		 * switch ports based on 802.1Q tags is simply too brittle to
+		 * be passable. So just defer to the dsa_slave_notag_xmit
+		 * implementation.
+		 */
+		if (dp->vlan_filtering)
+			return skb;
+
+		return dsa_8021q_xmit(skb, netdev, ETH_P_DSA_8021Q,
+				     ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
+	}
+
+	/* Code path for transmitting management traffic. This does not rely
+	 * upon switch tagging, but instead SPI-installed management routes.
+	 */
+	clone = skb_clone(skb, GFP_ATOMIC);
+	if (!clone) {
+		dev_err(ds->dev, "xmit: failed to clone skb\n");
+		return NULL;
+	}
+
+	if (sja1105_skb_ring_add(&sp->xmit_ring, clone) < 0) {
+		dev_err(ds->dev, "xmit: skb ring full\n");
+		kfree_skb(clone);
+		return NULL;
+	}
+
+	if (sp->xmit_ring.count == SJA1105_SKB_RING_SIZE)
+		/* TODO setup a dedicated netdev queue for management traffic
+		 * so that we can selectively apply backpressure and not be
+		 * required to stop the entire traffic when the software skb
+		 * ring is full. This requires hooking the ndo_select_queue
+		 * from DSA and matching on mac_fltres.
+		 */
+		dev_err(ds->dev, "xmit: reached maximum skb ring size\n");
+
+	schedule_work(&sp->xmit_work);
+	/* Let DSA free its reference to the skb and we will free
+	 * the clone in the deferred worker
+	 */
+	return NULL;
+}
+
+static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
+				   struct net_device *netdev,
+				   struct packet_type *pt)
+{
+	unsigned int source_port, switch_id;
+	struct ethhdr *hdr = eth_hdr(skb);
+	u16 tpid, vid, tci;
+
+	skb = dsa_8021q_rcv(skb, netdev, pt, &tpid, &tci);
+	if (unlikely(!skb)) {
+		netdev_warn(netdev, "Failed to pull VLAN header\n");
+		return NULL;
+	}
+	/* There's something deeply wrong if we ever get to print this. This
+	 * packet_type callback got invoked based on our driver's setting of
+	 * cpu_dp->uses_tag_protocol from within sja1105_vlan_filtering. And
+	 * that's also where we set the TPID to ETH_P_DSA_8021Q.
+	 */
+	if (unlikely(tpid != ETH_P_DSA_8021Q)) {
+		netdev_warn(netdev, "TPID 0x%04x not for tagging\n", tpid);
+		return NULL;
+	}
+
+	skb->priority = (tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+	vid = tci & VLAN_VID_MASK;
+
+	skb->offload_fwd_mark = 1;
+
+	if (likely(!sja1105_is_link_local(skb))) {
+		/* Normal traffic path. */
+		source_port = dsa_tagging_rx_source_port(vid);
+		switch_id = dsa_tagging_rx_switch_id(vid);
+	} else {
+		/* Management traffic path. Switch embeds the switch ID and
+		 * port ID into bytes of the destination MAC, courtesy of
+		 * the incl_srcpt options.
+		 */
+		source_port = hdr->h_dest[3];
+		switch_id = hdr->h_dest[4];
+		/* Clear the DMAC bytes that were mangled by the switch */
+		hdr->h_dest[3] = 0;
+		hdr->h_dest[4] = 0;
+	}
+
+	skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+	if (!skb->dev) {
+		netdev_warn(netdev, "Packet with invalid switch id %u and source port %u\n",
+			    switch_id, source_port);
+		return NULL;
+	}
+
+	/* Delete/overwrite fake VLAN header, DSA expects to not find
+	 * it there, see dsa_switch_rcv: skb_push(skb, ETH_HLEN).
+	 */
+	memmove(skb->data - ETH_HLEN, skb->data - ETH_HLEN - VLAN_HLEN,
+		ETH_HLEN - VLAN_HLEN);
+
+	return skb;
+}
+
+const struct dsa_device_ops sja1105_netdev_ops = {
+	.xmit = sja1105_xmit,
+	.rcv = sja1105_rcv,
+	.overhead = VLAN_HLEN,
+};
+
-- 
2.17.1

