Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1887A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfC0IpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:45:16 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58983 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733076AbfC0IpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:45:14 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 660204001E;
        Wed, 27 Mar 2019 08:45:10 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 15/18] net: mvpp2: cls: Rename the flow table macros
Date:   Wed, 27 Mar 2019 09:44:19 +0100
Message-Id: <20190327084422.4209-16-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Flow Table dictates what lookups will be issued for each flow type.
The lookup sequence for each flow is similar, and the index of each
lookup is computed by some macros.

There are similar mechanisms for the C2 TCAM lookups, so in order to
avoid confusion, rename the flow table index computing macros with a
common prefix.

The only difference in behaviour is that we now use the very first entry
in the flow for the RSS lookup (the first entry was previously unused).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     | 12 +++++-------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h     | 13 +++++++------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c |  4 ++--
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index e50154e03141..482de582f994 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -478,7 +478,7 @@ static void mvpp2_cls_flow_lkp_init(struct mvpp2 *priv,
 	/* We point on the first lookup in the sequence for the flow, that is
 	 * the C2 lookup.
 	 */
-	le.data |= MVPP2_CLS_LKP_FLOW_PTR(MVPP2_FLOW_C2_ENTRY(flow->flow_id));
+	le.data |= MVPP2_CLS_LKP_FLOW_PTR(MVPP2_CLS_FLT_FIRST(flow->flow_id));
 
 	/* CLS is always enabled, RSS is enabled/disabled in C2 lookup */
 	le.data |= MVPP2_CLS_LKP_TBL_LOOKUP_EN_MASK;
@@ -536,7 +536,7 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 
 	/* C2 lookup */
 	memset(&fe, 0, sizeof(fe));
-	fe.index = MVPP2_FLOW_C2_ENTRY(flow->flow_id);
+	fe.index = MVPP2_CLS_FLT_C2_RSS_ENTRY(flow->flow_id);
 
 	mvpp2_cls_flow_eng_set(&fe, MVPP22_CLS_ENGINE_C2);
 	mvpp2_cls_flow_port_id_sel(&fe, true);
@@ -553,7 +553,7 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 	/* C3Hx lookups */
 	for (i = 0; i < MVPP2_MAX_PORTS; i++) {
 		memset(&fe, 0, sizeof(fe));
-		fe.index = MVPP2_PORT_FLOW_HASH_ENTRY(i, flow->flow_id);
+		fe.index = MVPP2_CLS_FLT_HASH_ENTRY(i, flow->flow_id);
 
 		mvpp2_cls_flow_port_id_sel(&fe, true);
 		mvpp2_cls_flow_pri_set(&fe, i + 1);
@@ -661,8 +661,7 @@ static int mvpp2_port_rss_hash_opts_set(struct mvpp2_port *port, int flow_type,
 		if (!flow)
 			return -EINVAL;
 
-		flow_index = MVPP2_PORT_FLOW_HASH_ENTRY(port->id,
-							flow->flow_id);
+		flow_index = MVPP2_CLS_FLT_HASH_ENTRY(port->id, flow->flow_id);
 
 		mvpp2_cls_flow_read(port->priv, flow_index, &fe);
 
@@ -747,8 +746,7 @@ static u16 mvpp2_port_rss_hash_opts_get(struct mvpp2_port *port, int flow_type)
 		if (!flow)
 			return 0;
 
-		flow_index = MVPP2_PORT_FLOW_HASH_ENTRY(port->id,
-							flow->flow_id);
+		flow_index = MVPP2_CLS_FLT_HASH_ENTRY(port->id, flow->flow_id);
 
 		mvpp2_cls_flow_read(port->priv, flow_index, &fe);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 9a4796fc0219..36299b57599c 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -177,12 +177,13 @@ struct mvpp2_cls_flow {
 	struct mvpp2_prs_result_info prs_ri;
 };
 
-
-#define MVPP2_ENTRIES_PER_FLOW			(MVPP2_MAX_PORTS + 1)
-#define MVPP2_FLOW_C2_ENTRY(id)			((((id) - MVPP2_FL_START) * \
-						 MVPP2_ENTRIES_PER_FLOW) + 1)
-#define MVPP2_PORT_FLOW_HASH_ENTRY(port, id)	(MVPP2_FLOW_C2_ENTRY(id) + \
-						 1 + (port))
+#define MVPP2_CLS_FLT_ENTRIES_PER_FLOW		(MVPP2_MAX_PORTS + 1)
+#define MVPP2_CLS_FLT_FIRST(id)			(((id) - MVPP2_FL_START) * \
+						 MVPP2_CLS_FLT_ENTRIES_PER_FLOW)
+#define MVPP2_CLS_FLT_C2_RSS_ENTRY(id)		(MVPP2_CLS_FLT_FIRST(id))
+#define MVPP2_CLS_FLT_HASH_ENTRY(port, id)	(MVPP2_CLS_FLT_C2_RSS_ENTRY(id) + (port) + 1)
+#define MVPP2_CLS_FLT_LAST(id)			(MVPP2_CLS_FLT_FIRST(id) + \
+						 MVPP2_CLS_FLT_ENTRIES_PER_FLOW - 1)
 
 /* Iterate on each classifier flow id. Sets 'i' to be the index of the first
  * entry in the cls_flows table for each different flow_id.
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 302d3e9513be..0ee39ea47b6b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -150,7 +150,7 @@ static int mvpp2_dbgfs_port_flow_hash_opt_show(struct seq_file *s, void *unused)
 	if (!f)
 		return -EINVAL;
 
-	flow_index = MVPP2_PORT_FLOW_HASH_ENTRY(entry->port->id, f->flow_id);
+	flow_index = MVPP2_CLS_FLT_HASH_ENTRY(entry->port->id, f->flow_id);
 
 	mvpp2_cls_flow_read(port->priv, flow_index, &fe);
 
@@ -175,7 +175,7 @@ static int mvpp2_dbgfs_port_flow_engine_show(struct seq_file *s, void *unused)
 	if (!f)
 		return -EINVAL;
 
-	flow_index = MVPP2_PORT_FLOW_HASH_ENTRY(entry->port->id, f->flow_id);
+	flow_index = MVPP2_CLS_FLT_HASH_ENTRY(entry->port->id, f->flow_id);
 
 	mvpp2_cls_flow_read(port->priv, flow_index, &fe);
 
-- 
2.20.1

