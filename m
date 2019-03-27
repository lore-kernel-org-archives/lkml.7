Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B84C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C30F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbfC0Iqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:46:39 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52829 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbfC0Iot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:49 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6974E4000B;
        Wed, 27 Mar 2019 08:44:45 +0000 (UTC)
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
Subject: [PATCH net-next 05/18] net: mvpp2: cls: Rename MVPP2_N_FLOWS to MVPP2_N_PRS_FLOWS
Date:   Wed, 27 Mar 2019 09:44:09 +0100
Message-Id: <20190327084422.4209-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro definition MVPP2_N_FLOWS is ambiguous because it really
represents the number of entries in the Header Parser that are used to
identify the classification flows.

Rename the macro to clearly state that we represent the number of flows
in the Header Parser.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |  2 ++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     | 10 +++++-----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h     |  3 ++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c |  2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 1356fc4fbccb..6220284798b1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -612,6 +612,8 @@
 #define MVPP2_BIT_TO_WORD(bit)		((bit) / 32)
 #define MVPP2_BIT_IN_WORD(bit)		((bit) % 32)
 
+#define MVPP2_N_PRS_FLOWS		52
+
 /* RSS constants */
 #define MVPP22_RSS_TABLE_ENTRIES	32
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 9e3b9036b75a..853254846f30 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -22,7 +22,7 @@
 	}							\
 }
 
-static struct mvpp2_cls_flow cls_flows[MVPP2_N_FLOWS] = {
+static struct mvpp2_cls_flow cls_flows[MVPP2_N_PRS_FLOWS] = {
 	/* TCP over IPv4 flows, Not fragmented, no vlan tag */
 	MVPP2_DEF_FLOW(TCP_V4_FLOW, MVPP2_FL_IP4_TCP_NF_UNTAG,
 		       MVPP22_CLS_HEK_IP4_5T,
@@ -599,7 +599,7 @@ static int mvpp2_flow_set_hek_fields(struct mvpp2_cls_flow_entry *fe,
 
 struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow)
 {
-	if (flow >= MVPP2_N_FLOWS)
+	if (flow >= MVPP2_N_PRS_FLOWS)
 		return NULL;
 
 	return &cls_flows[flow];
@@ -624,7 +624,7 @@ static int mvpp2_port_rss_hash_opts_set(struct mvpp2_port *port, int flow_type,
 	int i, engine, flow_index;
 	u16 hash_opts;
 
-	for (i = 0; i < MVPP2_N_FLOWS; i++) {
+	for (i = 0; i < MVPP2_N_PRS_FLOWS; i++) {
 		flow = mvpp2_cls_flow_get(i);
 		if (!flow)
 			return -EINVAL;
@@ -713,7 +713,7 @@ static u16 mvpp2_port_rss_hash_opts_get(struct mvpp2_port *port, int flow_type)
 	int i, flow_index;
 	u16 hash_opts = 0;
 
-	for (i = 0; i < MVPP2_N_FLOWS; i++) {
+	for (i = 0; i < MVPP2_N_PRS_FLOWS; i++) {
 		flow = mvpp2_cls_flow_get(i);
 		if (!flow)
 			return 0;
@@ -737,7 +737,7 @@ static void mvpp2_cls_port_init_flows(struct mvpp2 *priv)
 	struct mvpp2_cls_flow *flow;
 	int i;
 
-	for (i = 0; i < MVPP2_N_FLOWS; i++) {
+	for (i = 0; i < MVPP2_N_PRS_FLOWS; i++) {
 		flow = mvpp2_cls_flow_get(i);
 		if (!flow)
 			break;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 9ffbb4f4675d..22d7d9a587b0 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -169,6 +169,8 @@ enum mvpp2_cls_lu_type {
 /* LU Type defined for all engines, and specified in the flow table */
 #define MVPP2_CLS_LU_TYPE_MASK			0x3f
 
+#define MVPP2_N_FLOWS		(MVPP2_FL_LAST - MVPP2_FL_START)
+
 struct mvpp2_cls_flow {
 	/* The L2-L4 traffic flow type */
 	int flow_type;
@@ -183,7 +185,6 @@ struct mvpp2_cls_flow {
 	struct mvpp2_prs_result_info prs_ri;
 };
 
-#define MVPP2_N_FLOWS	52
 
 #define MVPP2_ENTRIES_PER_FLOW			(MVPP2_MAX_PORTS + 1)
 #define MVPP2_FLOW_C2_ENTRY(id)			((((id) - MVPP2_FL_START) * \
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index f9744a61e5dd..97e0ef130a61 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -557,7 +557,7 @@ static int mvpp2_dbgfs_flow_init(struct dentry *parent, struct mvpp2 *priv)
 	if (!flow_dir)
 		return -ENOMEM;
 
-	for (i = 0; i < MVPP2_N_FLOWS; i++) {
+	for (i = 0; i < MVPP2_N_PRS_FLOWS; i++) {
 		ret = mvpp2_dbgfs_flow_entry_init(flow_dir, priv, i);
 		if (ret)
 			return ret;
-- 
2.20.1

