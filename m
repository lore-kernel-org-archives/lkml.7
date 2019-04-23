Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA8DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0147720645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfDWHuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:50:55 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42317 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:50:54 -0400
X-Originating-IP: 90.88.160.238
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 3130EC000A;
        Tue, 23 Apr 2019 07:50:39 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2] net: mvpp2: cls: Add Classification offload support
Date:   Tue, 23 Apr 2019 09:50:31 +0200
Message-Id: <20190423075031.26074-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces basic classification offloading support for the
PPv2 controller.

The PPv2 classifier has many classification engines, for now we only use
the C2 TCAM match engine.

This engine allows to perform ternary lookups on 64 bits keys (called
Header Extracted Key), that are built by extracting fields from the packet
header and concatenating them. At most 4 fields can be extracted for a
single lookup.

This basic implementation allows to build the HEK from the following
fields :
 - L4 source and destination ports (for UDP and TCP)

More fields are to be added in the future.

Classification flows are added through the ethtool interface, using the
newly introduced flow_rule infrastructure as an internal rule
representation, allowing to more easily implement tc flower rules if
need be.

Flows are separated based on their flow-type (supported flow-types are
tcp4, udp4, tcp6, udp6, ip4, ip6 and ether), each type can contain up to
7 classification rules. Note that the most specific flow-type is always
used, meaning that a rule in the tcp4 flow will superseed a rule in the
ip4 flow matching the same key)

When inserting a rule in a given flow, the location given is relative to
the flow :

ethtool -N eth0 flow-type udp4 dst-port 1234 action 2 loc 0

ethtool -N eth0 flow-type tcp4 dst-port 1234 action 3 loc 0

However when removing a rule, the global location is to be used. This
location can be retrieved by using ethtool -n <interface>.

This commit only introduces support for the "steer to rxq" action.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: - Re-arranged struct mvpp2_rfs_rule to minimize gaps on 64 bits systems,
    as suggested by David.

    - Fixed a smatch error indicating a possible out-of-bound array access
    when accessing the internal list of rules.

    - Other smatch warnings saying that some indices can't be negatived were
      not fixed on purpose, even though no path leads to these indicies being
      negative right now, future work could lead to cases where indices aren't
      valid.

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  50 ++
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    | 458 +++++++++++++++++-
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    |  56 ++-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  24 +-
 4 files changed, 573 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 67cce2736806..dcb93afb6569 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -14,6 +14,7 @@
 #include <linux/netdevice.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <net/flow_offload.h>
 
 /* Fifo Registers */
 #define MVPP2_RX_DATA_FIFO_SIZE_REG(port)	(0x00 + 4 * (port))
@@ -126,6 +127,7 @@
 #define MVPP22_CLS_C2_TCAM_DATA4		0x1b20
 #define     MVPP22_CLS_C2_LU_TYPE(lu)		((lu) & 0x3f)
 #define     MVPP22_CLS_C2_PORT_ID(port)		((port) << 8)
+#define     MVPP22_CLS_C2_PORT_MASK		(0xff << 8)
 #define MVPP22_CLS_C2_TCAM_INV			0x1b24
 #define     MVPP22_CLS_C2_TCAM_INV_BIT		BIT(31)
 #define MVPP22_CLS_C2_HIT_CTR			0x1b50
@@ -615,6 +617,10 @@
 #define MVPP2_BIT_IN_WORD(bit)		((bit) % 32)
 
 #define MVPP2_N_PRS_FLOWS		52
+#define MVPP2_N_RFS_ENTRIES_PER_FLOW	7
+
+/* There are 7 supported high-level flows */
+#define MVPP2_N_RFS_RULES		(MVPP2_N_RFS_ENTRIES_PER_FLOW * 7)
 
 /* RSS constants */
 #define MVPP22_RSS_TABLE_ENTRIES	32
@@ -812,6 +818,46 @@ struct mvpp2_queue_vector {
 	struct cpumask *mask;
 };
 
+/* Internal represention of a Flow Steering rule */
+struct mvpp2_rfs_rule {
+	/* Rule location inside the flow*/
+	int loc;
+
+	/* Flow type, such as TCP_V4_FLOW, IP6_FLOW, etc. */
+	int flow_type;
+
+	/* The lookup type used by this flow. This allows the classification
+	 * engines to differentiate between entries that match the same
+	 * parameters
+	 */
+	int lu_type;
+
+	/* Index of the entry handling this rule in the flow table */
+	int flt_index;
+
+	/* Index of the C2 TCAM entry handling this rule */
+	int c2_index;
+
+	/* Header fields that needs to be extracted to match this flow */
+	u16 hek_fields;
+
+	/* CLS engine : only c2 is supported for now. */
+	u8 engine;
+
+	/* TCAM key and mask for C2-based steering. These fields should be
+	 * encapsulated in a union should we add more engines.
+	 */
+	u64 c2_tcam;
+	u64 c2_tcam_mask;
+
+	struct flow_rule *flow;
+};
+
+struct mvpp2_ethtool_fs {
+	struct mvpp2_rfs_rule rule;
+	struct ethtool_rxnfc rxnfc;
+};
+
 struct mvpp2_port {
 	u8 id;
 
@@ -883,6 +929,10 @@ struct mvpp2_port {
 
 	/* RSS indirection table */
 	u32 indir[MVPP22_RSS_TABLE_ENTRIES];
+
+	/* List of steering rules active on that port */
+	struct mvpp2_ethtool_fs *rfs_rules[MVPP2_N_RFS_RULES];
+	int n_rfs_rules;
 };
 
 /* The mvpp2_tx_desc and mvpp2_rx_desc structures describe the
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 1087974d3b98..7457e2ab57eb 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -448,6 +448,17 @@ static void mvpp2_cls_flow_port_add(struct mvpp2_cls_flow_entry *fe,
 	fe->data[0] |= MVPP2_CLS_FLOW_TBL0_PORT_ID(port);
 }
 
+static void mvpp2_cls_flow_port_remove(struct mvpp2_cls_flow_entry *fe,
+				       u32 port)
+{
+	fe->data[0] &= ~MVPP2_CLS_FLOW_TBL0_PORT_ID(port);
+}
+
+static u8 mvpp2_cls_flow_pmap_get(struct mvpp2_cls_flow_entry *fe)
+{
+	return (fe->data[0] >> 4) & MVPP2_CLS_FLOW_TBL0_PORT_ID_MASK;
+}
+
 static void mvpp2_cls_flow_lu_type_set(struct mvpp2_cls_flow_entry *fe,
 				       u8 lu_type)
 {
@@ -455,6 +466,12 @@ static void mvpp2_cls_flow_lu_type_set(struct mvpp2_cls_flow_entry *fe,
 	fe->data[1] |= MVPP2_CLS_FLOW_TBL1_LU_TYPE(lu_type);
 }
 
+static u8 mvpp2_cls_flow_lu_type_get(struct mvpp2_cls_flow_entry *fe)
+{
+	return (fe->data[1] &
+		MVPP2_CLS_FLOW_TBL1_LU_TYPE(MVPP2_CLS_LU_TYPE_MASK)) >> 3;
+}
+
 /* Initialize the parser entry for the given flow */
 static void mvpp2_cls_flow_prs_init(struct mvpp2 *priv,
 				    const struct mvpp2_cls_flow *flow)
@@ -539,6 +556,35 @@ void mvpp2_cls_c2_read(struct mvpp2 *priv, int index,
 	c2->valid = !(val & MVPP22_CLS_C2_TCAM_INV_BIT);
 }
 
+static int mvpp2_cls_c2_port_flow_get_type(int flow_type)
+{
+	switch (flow_type) {
+	case TCP_V4_FLOW:
+		return MVPP22_FLOW_TCP4;
+	case TCP_V6_FLOW:
+		return MVPP22_FLOW_TCP6;
+	case UDP_V4_FLOW:
+		return MVPP22_FLOW_UDP4;
+	case UDP_V6_FLOW:
+		return MVPP22_FLOW_UDP6;
+	case IPV4_FLOW:
+		return MVPP22_FLOW_IP4;
+	case IPV6_FLOW:
+		return MVPP22_FLOW_IP6;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mvpp2_cls_c2_port_flow_index(struct mvpp2_port *port, int lu_type,
+					int loc)
+{
+	if (loc >= MVPP22_CLS_C2_PORT_N_RFS)
+		return -EINVAL;
+
+	return MVPP22_CLS_C2_RFS_LOC(port->id, lu_type, loc);
+}
+
 /* Initialize the flow table entries for the given flow */
 static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 				const struct mvpp2_cls_flow *flow)
@@ -565,7 +611,7 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 
 	mvpp2_cls_flow_eng_set(&fe, MVPP22_CLS_ENGINE_C2);
 	mvpp2_cls_flow_port_id_sel(&fe, true);
-	mvpp2_cls_flow_lu_type_set(&fe, MVPP2_CLS_LU_ALL);
+	mvpp2_cls_flow_lu_type_set(&fe, MVPP22_FLOW_ETHER);
 
 	/* Add all ports */
 	for (i = 0; i < MVPP2_MAX_PORTS; i++)
@@ -652,6 +698,26 @@ static int mvpp2_flow_set_hek_fields(struct mvpp2_cls_flow_entry *fe,
 	return 0;
 }
 
+/* Returns the size, in bits, of the corresponding HEK field */
+static int mvpp2_cls_hek_field_size(u32 field)
+{
+	switch (field) {
+	case MVPP22_CLS_HEK_OPT_MAC_DA:
+		return 48;
+	case MVPP22_CLS_HEK_OPT_IP4SA:
+	case MVPP22_CLS_HEK_OPT_IP4DA:
+		return 32;
+	case MVPP22_CLS_HEK_OPT_IP6SA:
+	case MVPP22_CLS_HEK_OPT_IP6DA:
+		return 128;
+	case MVPP22_CLS_HEK_OPT_L4SIP:
+	case MVPP22_CLS_HEK_OPT_L4DIP:
+		return 16;
+	default:
+		return -1;
+	}
+}
+
 const struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow)
 {
 	if (flow >= MVPP2_N_PRS_FLOWS)
@@ -810,7 +876,7 @@ static void mvpp2_port_c2_cls_init(struct mvpp2_port *port)
 
 	/* Match on Lookup Type */
 	c2.tcam[4] |= MVPP22_CLS_C2_TCAM_EN(MVPP22_CLS_C2_LU_TYPE(MVPP2_CLS_LU_TYPE_MASK));
-	c2.tcam[4] |= MVPP22_CLS_C2_LU_TYPE(MVPP2_CLS_LU_ALL);
+	c2.tcam[4] |= MVPP22_CLS_C2_LU_TYPE(MVPP22_FLOW_ETHER);
 
 	/* Update RSS status after matching this entry */
 	c2.act = MVPP22_CLS_C2_ACT_RSS_EN(MVPP22_C2_UPD_LOCK);
@@ -944,6 +1010,18 @@ void mvpp22_port_rss_disable(struct mvpp2_port *port)
 	mvpp2_rss_port_c2_disable(port);
 }
 
+static void mvpp22_port_c2_lookup_disable(struct mvpp2_port *port, int entry)
+{
+	struct mvpp2_cls_c2_entry c2;
+
+	mvpp2_cls_c2_read(port->priv, entry, &c2);
+
+	/* Clear the port map so that the entry doesn't match anymore */
+	c2.tcam[4] &= ~(MVPP22_CLS_C2_PORT_ID(BIT(port->id)));
+
+	mvpp2_cls_c2_write(port->priv, &c2);
+}
+
 /* Set CPU queue number for oversize packets */
 void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port)
 {
@@ -960,6 +1038,382 @@ void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port)
 	mvpp2_write(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG, val);
 }
 
+static int mvpp2_port_c2_tcam_rule_add(struct mvpp2_port *port,
+				       struct mvpp2_rfs_rule *rule)
+{
+	struct flow_action_entry *act;
+	struct mvpp2_cls_c2_entry c2;
+	u8 qh, ql, pmap;
+
+	memset(&c2, 0, sizeof(c2));
+
+	c2.index = mvpp2_cls_c2_port_flow_index(port, rule->lu_type, rule->loc);
+	if (c2.index < 0)
+		return -EINVAL;
+
+	act = &rule->flow->action.entries[0];
+
+	rule->c2_index = c2.index;
+
+	c2.tcam[0] = (rule->c2_tcam & 0xffff) |
+		     ((rule->c2_tcam_mask & 0xffff) << 16);
+	c2.tcam[1] = ((rule->c2_tcam >> 16) & 0xffff) |
+		     (((rule->c2_tcam_mask >> 16) & 0xffff) << 16);
+	c2.tcam[2] = ((rule->c2_tcam >> 32) & 0xffff) |
+		     (((rule->c2_tcam_mask >> 32) & 0xffff) << 16);
+	c2.tcam[3] = ((rule->c2_tcam >> 48) & 0xffff) |
+		     (((rule->c2_tcam_mask >> 48) & 0xffff) << 16);
+
+	pmap = BIT(port->id);
+	c2.tcam[4] = MVPP22_CLS_C2_PORT_ID(pmap);
+	c2.tcam[4] |= MVPP22_CLS_C2_TCAM_EN(MVPP22_CLS_C2_PORT_ID(pmap));
+
+	/* Match on Lookup Type */
+	c2.tcam[4] |= MVPP22_CLS_C2_TCAM_EN(MVPP22_CLS_C2_LU_TYPE(MVPP2_CLS_LU_TYPE_MASK));
+	c2.tcam[4] |= MVPP22_CLS_C2_LU_TYPE(rule->lu_type);
+
+	/* Mark packet as "forwarded to software", needed for RSS */
+	c2.act |= MVPP22_CLS_C2_ACT_FWD(MVPP22_C2_FWD_SW_LOCK);
+
+	c2.act |= MVPP22_CLS_C2_ACT_QHIGH(MVPP22_C2_UPD_LOCK) |
+		   MVPP22_CLS_C2_ACT_QLOW(MVPP22_C2_UPD_LOCK);
+
+	qh = ((act->queue.index + port->first_rxq) >> 3) & MVPP22_CLS_C2_ATTR0_QHIGH_MASK;
+	ql = (act->queue.index + port->first_rxq) & MVPP22_CLS_C2_ATTR0_QLOW_MASK;
+
+	c2.attr[0] = MVPP22_CLS_C2_ATTR0_QHIGH(qh) |
+		      MVPP22_CLS_C2_ATTR0_QLOW(ql);
+
+	c2.valid = true;
+
+	mvpp2_cls_c2_write(port->priv, &c2);
+
+	return 0;
+}
+
+static int mvpp2_port_c2_rfs_rule_insert(struct mvpp2_port *port,
+					 struct mvpp2_rfs_rule *rule)
+{
+	return mvpp2_port_c2_tcam_rule_add(port, rule);
+}
+
+static int mvpp2_port_flow_table_find(struct mvpp2 *priv, int flow_id,
+				      u8 engine, u8 lu_type, u16 hek_fields)
+{
+	struct mvpp2_cls_flow_entry fe;
+	u16 flow_hek_fields;
+	int i, flow_engine;
+	u8 flow_lu_type;
+
+	/* Iterate on all flow table entries for this ID */
+	for (i = MVPP2_CLS_FLT_FIRST(flow_id);
+	     i < MVPP2_CLS_FLT_LAST(flow_id); i++) {
+		mvpp2_cls_flow_read(priv, i, &fe);
+
+		flow_hek_fields = mvpp2_flow_get_hek_fields(&fe);
+		if (flow_hek_fields != hek_fields)
+			continue;
+
+		flow_engine = mvpp2_cls_flow_eng_get(&fe);
+		if (flow_engine != engine)
+			continue;
+
+		flow_lu_type = mvpp2_cls_flow_lu_type_get(&fe);
+		if (flow_lu_type != lu_type)
+			continue;
+
+		return i;
+	}
+
+	return -1;
+}
+
+static int mvpp2_port_flow_table_find_free(struct mvpp2 *priv, int flow_id)
+{
+	struct mvpp2_cls_flow_entry fe;
+	u8 pmap;
+	int i;
+
+	memset(&fe, 0, sizeof(fe));
+	for (i = 0; i < MVPP2_N_RFS_ENTRIES_PER_FLOW; i++) {
+		mvpp2_cls_flow_read(priv, MVPP2_CLS_FLT_C2_RFS(flow_id, i),
+				    &fe);
+
+		/* get pmap */
+		pmap = mvpp2_cls_flow_pmap_get(&fe);
+		if (!pmap)
+			return MVPP2_CLS_FLT_C2_RFS(flow_id, i);
+	}
+
+	return -1;
+}
+
+/**
+ * It's possible that multiple different rfs rules use the same flow_table
+ * entry, if the rules use the same key and the same engine. In that case,
+ * we must make sure not to delete this flow_table entry when removing the
+ * rule, unless it's the last rule that uses this entry.
+ */
+static bool mvpp2_port_flt_has_siblings(struct mvpp2_port *port,
+					struct mvpp2_rfs_rule *rule)
+{
+	struct mvpp2_ethtool_fs *efs;
+	int i;
+
+	for (i = 0; i < MVPP2_N_RFS_RULES; i++) {
+		efs = port->rfs_rules[i];
+		if (!efs)
+			continue;
+		/* Skip the entry we are trying to find the sibling of */
+		if (efs->rule.loc == rule->loc)
+			continue;
+		if (efs->rule.flt_index == rule->flt_index)
+			return true;
+	}
+
+	return false;
+}
+
+static int mvpp2_port_cls_rfs_rule_remove(struct mvpp2_port *port,
+					  struct mvpp2_rfs_rule *rule)
+{
+	struct mvpp2_cls_flow_entry fe;
+
+	if (rule->flt_index >= 0 &&
+	    !mvpp2_port_flt_has_siblings(port, rule)) {
+		mvpp2_cls_flow_read(port->priv, rule->flt_index, &fe);
+		mvpp2_cls_flow_port_remove(&fe, BIT(port->id));
+		mvpp2_cls_flow_write(port->priv, &fe);
+	}
+
+	if (rule->c2_index >= 0)
+		mvpp22_port_c2_lookup_disable(port, rule->c2_index);
+
+	return 0;
+}
+
+static int mvpp2_port_flt_rfs_rule_insert(struct mvpp2_port *port,
+					  struct mvpp2_rfs_rule *rule)
+{
+	const struct mvpp2_cls_flow *flow;
+	struct mvpp2 *priv = port->priv;
+	struct mvpp2_cls_flow_entry fe;
+	int index, ret, i;
+
+	if (rule->engine != MVPP22_CLS_ENGINE_C2)
+		return -EOPNOTSUPP;
+
+	ret = mvpp2_port_c2_rfs_rule_insert(port, rule);
+	if (ret)
+		return ret;
+
+	for_each_cls_flow_id_with_type(i, rule->flow_type) {
+		flow = mvpp2_cls_flow_get(i);
+		if (!flow)
+			return 0;
+
+		/* Don't perform steering on HEK fields that aren't relevant
+		 * for this flow, e.g. steering on VLAN tag when in an untagged
+		 * flow.
+		 */
+		if ((rule->hek_fields | flow->supported_hash_opts) !=
+		    flow->supported_hash_opts)
+			return 0;
+
+		index = mvpp2_port_flow_table_find(priv, flow->flow_id,
+						   rule->engine, rule->lu_type,
+						   rule->hek_fields);
+
+		/* If there already is a flow entry that matches our
+		 * parameters
+		 */
+		if (index >= 0) {
+			rule->flt_index = index;
+			mvpp2_cls_flow_read(priv, index, &fe);
+			mvpp2_cls_flow_port_add(&fe, BIT(port->id));
+			mvpp2_cls_flow_write(priv, &fe);
+			continue;
+		} else {
+			index = mvpp2_port_flow_table_find_free(priv,
+								flow->flow_id);
+			if (index < 0)
+				return -EOPNOTSUPP;
+		}
+
+		/* Create entry */
+		rule->flt_index = index;
+		mvpp2_cls_flow_read(priv, index, &fe);
+
+		mvpp2_cls_flow_eng_set(&fe, rule->engine);
+		mvpp2_cls_flow_port_id_sel(&fe, true);
+		mvpp2_flow_set_hek_fields(&fe, rule->hek_fields);
+		mvpp2_cls_flow_lu_type_set(&fe, rule->lu_type);
+		mvpp2_cls_flow_port_add(&fe, 0xf);
+
+		mvpp2_cls_flow_write(priv, &fe);
+	}
+
+	return 0;
+}
+
+static int mvpp2_cls_c2_build_match(struct mvpp2_rfs_rule *rule)
+{
+	struct flow_rule *flow = rule->flow;
+	struct flow_action_entry *act;
+	int offs = 64;
+
+	act = &flow->action.entries[0];
+
+	if (flow_rule_match_key(flow, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports match;
+
+		flow_rule_match_ports(flow, &match);
+		if (match.mask->src) {
+			rule->hek_fields |= MVPP22_CLS_HEK_OPT_L4SIP;
+			offs -= mvpp2_cls_hek_field_size(MVPP22_CLS_HEK_OPT_L4SIP);
+
+			rule->c2_tcam |= ((u64)ntohs(match.key->src)) << offs;
+			rule->c2_tcam_mask |= ((u64)ntohs(match.mask->src)) << offs;
+		}
+
+		if (match.mask->dst) {
+			rule->hek_fields |= MVPP22_CLS_HEK_OPT_L4DIP;
+			offs -= mvpp2_cls_hek_field_size(MVPP22_CLS_HEK_OPT_L4DIP);
+
+			rule->c2_tcam |= ((u64)ntohs(match.key->dst)) << offs;
+			rule->c2_tcam_mask |= ((u64)ntohs(match.mask->dst)) << offs;
+		}
+	}
+
+	if (hweight16(rule->hek_fields) > MVPP2_FLOW_N_FIELDS)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int mvpp2_cls_rfs_parse_rule(struct mvpp2_rfs_rule *rule)
+{
+	struct flow_rule *flow = rule->flow;
+	struct flow_action_entry *act;
+
+	act = &flow->action.entries[0];
+	if (act->id != FLOW_ACTION_QUEUE)
+		return -EOPNOTSUPP;
+
+	/* For now, only use the C2 engine which has a HEK size limited to 64
+	 * bits for TCAM matching.
+	 */
+	rule->engine = MVPP22_CLS_ENGINE_C2;
+
+	if (mvpp2_cls_c2_build_match(rule))
+		return -EINVAL;
+
+	return 0;
+}
+
+int mvpp2_ethtool_cls_rule_get(struct mvpp2_port *port,
+			       struct ethtool_rxnfc *rxnfc)
+{
+	struct mvpp2_ethtool_fs *efs;
+
+	if (rxnfc->fs.location >= MVPP2_N_RFS_RULES)
+		return -EINVAL;
+
+	efs = port->rfs_rules[rxnfc->fs.location];
+	if (!efs)
+		return -ENOENT;
+
+	memcpy(rxnfc, &efs->rxnfc, sizeof(efs->rxnfc));
+
+	return 0;
+}
+
+int mvpp2_ethtool_cls_rule_ins(struct mvpp2_port *port,
+			       struct ethtool_rxnfc *info)
+{
+	struct ethtool_rx_flow_spec_input input = {};
+	struct ethtool_rx_flow_rule *ethtool_rule;
+	struct mvpp2_ethtool_fs *efs, *old_efs;
+	int ret = 0, index;
+
+	if (info->fs.location >= MVPP22_CLS_C2_PORT_N_RFS ||
+	    info->fs.location < 0)
+		return -EINVAL;
+
+	efs = kzalloc(sizeof(*efs), GFP_KERNEL);
+	if (!efs)
+		return -ENOMEM;
+
+	input.fs = &info->fs;
+
+	ethtool_rule = ethtool_rx_flow_rule_create(&input);
+	if (IS_ERR(ethtool_rule)) {
+		ret = PTR_ERR(ethtool_rule);
+		goto clean_rule;
+	}
+
+	efs->rule.flow = ethtool_rule->rule;
+	efs->rule.flow_type = info->fs.flow_type & ~(FLOW_EXT | FLOW_MAC_EXT |
+						     FLOW_RSS);
+	efs->rule.lu_type = mvpp2_cls_c2_port_flow_get_type(efs->rule.flow_type);
+
+	ret = mvpp2_cls_rfs_parse_rule(&efs->rule);
+	if (ret)
+		goto clean_eth_rule;
+
+	efs->rule.loc = info->fs.location;
+
+	index = (efs->rule.lu_type - 1) * MVPP22_CLS_C2_PORT_N_FLOWS +
+		efs->rule.loc;
+
+	/* Replace an already existing rule */
+	if (port->rfs_rules[index]) {
+		old_efs = port->rfs_rules[index];
+		ret = mvpp2_port_cls_rfs_rule_remove(port, &old_efs->rule);
+		if (ret)
+			goto clean_eth_rule;
+		kfree(old_efs);
+	}
+
+	ret = mvpp2_port_flt_rfs_rule_insert(port, &efs->rule);
+	if (ret)
+		goto clean_eth_rule;
+
+	info->fs.location = index;
+
+	memcpy(&efs->rxnfc, info, sizeof(*info));
+	port->rfs_rules[index] = efs;
+	port->n_rfs_rules++;
+
+clean_eth_rule:
+	ethtool_rx_flow_rule_destroy(ethtool_rule);
+clean_rule:
+	kfree(efs);
+	return ret;
+}
+
+int mvpp2_ethtool_cls_rule_del(struct mvpp2_port *port,
+			       struct ethtool_rxnfc *info)
+{
+	struct mvpp2_ethtool_fs *efs;
+	int ret;
+
+	efs = port->rfs_rules[info->fs.location];
+	if (!efs)
+		return -EINVAL;
+
+	/* Remove the rule from the engines. */
+	ret = mvpp2_port_cls_rfs_rule_remove(port, &efs->rule);
+	if (ret)
+		return ret;
+
+	port->n_rfs_rules--;
+	port->rfs_rules[info->fs.location] = NULL;
+	kfree(efs);
+
+	return 0;
+}
+
 static inline u32 mvpp22_rxfh_indir(struct mvpp2_port *port, u32 rxq)
 {
 	int nrxqs, cpu, cpus = num_possible_cpus();
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 96304ffc5d49..1d91d5d3b0e1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -107,15 +107,43 @@ struct mvpp2_cls_c2_entry {
 	u8 valid;
 };
 
+enum mvpp2_lu_type {
+	/* LU Type 0 is the default value, it shouldn't be used, to avoid
+	 * spurious matches.
+	 */
+	MVPP22_FLOW_TCP4 = 1,
+	MVPP22_FLOW_TCP6,
+	MVPP22_FLOW_UDP4,
+	MVPP22_FLOW_UDP6,
+	MVPP22_FLOW_IP4,
+	MVPP22_FLOW_IP6,
+	MVPP22_FLOW_ETHER,
+	MVPP22_FLOW_LAST = MVPP22_FLOW_ETHER,
+};
+
 /* Classifier C2 engine entries */
 #define MVPP22_CLS_C2_N_ENTRIES		256
 
 /* Number of per-port dedicated entries in the C2 TCAM */
-#define MVPP22_CLS_C2_PORT_RANGE	8
+#define MVPP22_CLS_C2_PORT_FLOW_RANGE	8
+#define MVPP22_CLS_C2_PORT_N_RFS	MVPP2_N_RFS_ENTRIES_PER_FLOW
+
+/* We have one C2 range per supported flow type : ip4, i6, tcp4, tcp6, udp4, udp6 */
+#define MVPP22_CLS_C2_PORT_N_FLOWS	(MVPP22_FLOW_LAST)
+
+/* Each port has oen range per flow type + one entry controling the global RSS
+ * setting and the default rx queue
+ */
+#define MVPP22_CLS_C2_PORT_RANGE	(MVPP22_CLS_C2_PORT_FLOW_RANGE * \
+					 MVPP22_CLS_C2_PORT_N_FLOWS + 1)
+
+#define MVPP22_CLS_C2_PORT_FIRST(p)	((p) * MVPP22_CLS_C2_PORT_RANGE)
+#define MVPP22_CLS_C2_RSS_ENTRY(p)	(MVPP22_CLS_C2_PORT_FIRST((p) + 1) - 1)
 
-#define MVPP22_CLS_C2_PORT_FIRST(p)	(MVPP22_CLS_C2_N_ENTRIES - \
-					((p) * MVPP22_CLS_C2_PORT_RANGE))
-#define MVPP22_CLS_C2_RSS_ENTRY(p)	(MVPP22_CLS_C2_PORT_FIRST(p) - 1)
+#define MVPP22_CLS_C2_PORT_FLOW_FIRST(p, f)	(MVPP22_CLS_C2_PORT_FIRST(p) + \
+						 ((f) - 1) * MVPP22_CLS_C2_PORT_FLOW_RANGE)
+
+#define MVPP22_CLS_C2_RFS_LOC(p, f, loc)	(MVPP22_CLS_C2_PORT_FLOW_FIRST(p, f) + (loc))
 
 /* Packet flow ID */
 enum mvpp2_prs_flow {
@@ -145,10 +173,6 @@ enum mvpp2_prs_flow {
 	MVPP2_FL_LAST,
 };
 
-enum mvpp2_cls_lu_type {
-	MVPP2_CLS_LU_ALL = 0,
-};
-
 /* LU Type defined for all engines, and specified in the flow table */
 #define MVPP2_CLS_LU_TYPE_MASK			0x3f
 
@@ -168,11 +192,12 @@ struct mvpp2_cls_flow {
 	struct mvpp2_prs_result_info prs_ri;
 };
 
-#define MVPP2_CLS_FLT_ENTRIES_PER_FLOW		(MVPP2_MAX_PORTS + 1)
+#define MVPP2_CLS_FLT_ENTRIES_PER_FLOW		(MVPP2_MAX_PORTS + 1 + MVPP2_N_RFS_ENTRIES_PER_FLOW)
 #define MVPP2_CLS_FLT_FIRST(id)			(((id) - MVPP2_FL_START) * \
 						 MVPP2_CLS_FLT_ENTRIES_PER_FLOW)
-#define MVPP2_CLS_FLT_C2_RSS_ENTRY(id)		(MVPP2_CLS_FLT_FIRST(id))
-#define MVPP2_CLS_FLT_HASH_ENTRY(port, id)	(MVPP2_CLS_FLT_C2_RSS_ENTRY(id) + (port) + 1)
+#define MVPP2_CLS_FLT_C2_RFS(id, rfs_n)		(MVPP2_CLS_FLT_FIRST(id) + (rfs_n))
+#define MVPP2_CLS_FLT_C2_RSS_ENTRY(id)		(MVPP2_CLS_FLT_C2_RFS(id, MVPP2_N_RFS_ENTRIES_PER_FLOW))
+#define MVPP2_CLS_FLT_HASH_ENTRY(port, id)	(MVPP2_CLS_FLT_C2_RSS_ENTRY(id) + 1 + (port))
 #define MVPP2_CLS_FLT_LAST(id)			(MVPP2_CLS_FLT_FIRST(id) + \
 						 MVPP2_CLS_FLT_ENTRIES_PER_FLOW - 1)
 
@@ -246,4 +271,13 @@ u32 mvpp2_cls_c2_hit_count(struct mvpp2 *priv, int c2_index);
 void mvpp2_cls_c2_read(struct mvpp2 *priv, int index,
 		       struct mvpp2_cls_c2_entry *c2);
 
+int mvpp2_ethtool_cls_rule_get(struct mvpp2_port *port,
+			       struct ethtool_rxnfc *rxnfc);
+
+int mvpp2_ethtool_cls_rule_ins(struct mvpp2_port *port,
+			       struct ethtool_rxnfc *info);
+
+int mvpp2_ethtool_cls_rule_del(struct mvpp2_port *port,
+			       struct ethtool_rxnfc *info);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f128ea22b339..d38952eb7aa9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3937,7 +3937,7 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 				   struct ethtool_rxnfc *info, u32 *rules)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
-	int ret = 0;
+	int ret = 0, i, loc = 0;
 
 	if (!mvpp22_rss_is_supported())
 		return -EOPNOTSUPP;
@@ -3949,6 +3949,18 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 	case ETHTOOL_GRXRINGS:
 		info->data = port->nrxqs;
 		break;
+	case ETHTOOL_GRXCLSRLCNT:
+		info->rule_cnt = port->n_rfs_rules;
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		ret = mvpp2_ethtool_cls_rule_get(port, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		for (i = 0; i < MVPP2_N_RFS_RULES; i++) {
+			if (port->rfs_rules[i])
+				rules[loc++] = i;
+		}
+		break;
 	default:
 		return -ENOTSUPP;
 	}
@@ -3969,6 +3981,12 @@ static int mvpp2_ethtool_set_rxnfc(struct net_device *dev,
 	case ETHTOOL_SRXFH:
 		ret = mvpp2_ethtool_rxfh_set(port, info);
 		break;
+	case ETHTOOL_SRXCLSRLINS:
+		ret = mvpp2_ethtool_cls_rule_ins(port, info);
+		break;
+	case ETHTOOL_SRXCLSRLDEL:
+		ret = mvpp2_ethtool_cls_rule_del(port, info);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -5040,8 +5058,10 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	dev->hw_features |= features | NETIF_F_RXCSUM | NETIF_F_GRO |
 			    NETIF_F_HW_VLAN_CTAG_FILTER;
 
-	if (mvpp22_rss_is_supported())
+	if (mvpp22_rss_is_supported()) {
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->features |= NETIF_F_NTUPLE;
+	}
 
 	if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {
 		dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
-- 
2.20.1

