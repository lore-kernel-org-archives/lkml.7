Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EF32087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbfC0IpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:45:04 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47199 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbfC0IpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:45:02 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B529D4000C;
        Wed, 27 Mar 2019 08:44:57 +0000 (UTC)
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
Subject: [PATCH net-next 10/18] net: mvpp2: cls: Use iterators to go through the cls_table
Date:   Wed, 27 Mar 2019 09:44:14 +0100
Message-Id: <20190327084422.4209-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cls_table is a global read-only table containing the different
parameters that are used by various tables in the classifier. It
describes the links between the Header Parser, the decoding table and
the flow_table.

There are several possible way we want to iterate over that table,
depending on wich classifier engine we want to configure. For the Header
Parser, we want to iterate over each entry. For the Decoding table, we
want to iterate over each entry having a unique flow_id. Finally, when
configuring an ethtool flow, we want to iterate over each entry having a
unique flow_id and that has a given flow_type.

This commit introduces some iterator to both provide syntactic sugar and
also clarify the way we want to iterate over the table.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    | 10 ++------
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index bfb6ed5560c3..96358efcc018 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -625,14 +625,11 @@ static int mvpp2_port_rss_hash_opts_set(struct mvpp2_port *port, int flow_type,
 	int i, engine, flow_index;
 	u16 hash_opts;
 
-	for (i = 0; i < MVPP2_N_PRS_FLOWS; i++) {
+	for_each_cls_flow_id_with_type(i, flow_type) {
 		flow = mvpp2_cls_flow_get(i);
 		if (!flow)
 			return -EINVAL;
 
-		if (flow->flow_type != flow_type)
-			continue;
-
 		flow_index = MVPP2_PORT_FLOW_HASH_ENTRY(port->id,
 							flow->flow_id);
 
@@ -714,14 +711,11 @@ static u16 mvpp2_port_rss_hash_opts_get(struct mvpp2_port *port, int flow_type)
 	int i, flow_index;
 	u16 hash_opts = 0;
 
-	for (i = 0; i < MVPP2_N_PRS_FLOWS; i++) {
+	for_each_cls_flow_id_with_type(i, flow_type) {
 		flow = mvpp2_cls_flow_get(i);
 		if (!flow)
 			return 0;
 
-		if (flow->flow_type != flow_type)
-			continue;
-
 		flow_index = MVPP2_PORT_FLOW_HASH_ENTRY(port->id,
 							flow->flow_id);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 1d439eb469d5..fd38d80eaff1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -192,6 +192,29 @@ struct mvpp2_cls_flow {
 #define MVPP2_PORT_FLOW_HASH_ENTRY(port, id)	(MVPP2_FLOW_C2_ENTRY(id) + \
 						 1 + (port))
 
+/* Iterate on each classifier flow id. Sets 'i' to be the index of the first
+ * entry in the cls_flows table for each different flow_id.
+ * This relies on entries having the same flow_id in the cls_flows table being
+ * contiguous.
+ */
+#define for_each_cls_flow_id(i)						      \
+	for ((i) = 0; (i) < MVPP2_N_PRS_FLOWS; (i)++)			      \
+		if ((i) > 0 &&						      \
+		    cls_flows[(i)].flow_id == cls_flows[(i) - 1].flow_id)       \
+			continue;					      \
+		else
+
+/* Iterate on each classifier flow that has a given flow_type. Sets 'i' to be
+ * the index of the first entry in the cls_flow table for each different flow_id
+ * that has the given flow_type. This allows to operate on all flows that
+ * matches a given ethtool flow type.
+ */
+#define for_each_cls_flow_id_with_type(i, type)				      \
+	for_each_cls_flow_id((i))					      \
+		if (cls_flows[(i)].flow_type != (type))			      \
+			continue;					      \
+		else
+
 struct mvpp2_cls_flow_entry {
 	u32 index;
 	u32 data[MVPP2_CLS_FLOWS_TBL_DATA_WORDS];
-- 
2.20.1

