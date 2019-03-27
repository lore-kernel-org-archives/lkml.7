Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB7FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDFE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbfC0Io5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:44:57 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34837 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732689AbfC0Iox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:53 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B729D4000C;
        Wed, 27 Mar 2019 08:44:47 +0000 (UTC)
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
Subject: [PATCH net-next 06/18] net: mvpp2: cls: Make the flow definitions const
Date:   Wed, 27 Mar 2019 09:44:10 +0100
Message-Id: <20190327084422.4209-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cls_flow table represent the overall configuration of the
classifier, used to match the different traffic classes in the Parsing
and Classification engines.

This configuration is static, and applies to all PPv2 instances, we must
therefore keep it const so that no modifications of this table are
performed at runtime.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c  | 17 +++++++++--------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h  |  2 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_debugfs.c  | 10 +++++-----
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 853254846f30..bfb6ed5560c3 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -22,7 +22,7 @@
 	}							\
 }
 
-static struct mvpp2_cls_flow cls_flows[MVPP2_N_PRS_FLOWS] = {
+static const struct mvpp2_cls_flow cls_flows[MVPP2_N_PRS_FLOWS] = {
 	/* TCP over IPv4 flows, Not fragmented, no vlan tag */
 	MVPP2_DEF_FLOW(TCP_V4_FLOW, MVPP2_FL_IP4_TCP_NF_UNTAG,
 		       MVPP22_CLS_HEK_IP4_5T,
@@ -463,7 +463,7 @@ static void mvpp2_cls_flow_lu_type_set(struct mvpp2_cls_flow_entry *fe,
 
 /* Initialize the parser entry for the given flow */
 static void mvpp2_cls_flow_prs_init(struct mvpp2 *priv,
-				    struct mvpp2_cls_flow *flow)
+				    const struct mvpp2_cls_flow *flow)
 {
 	mvpp2_prs_add_flow(priv, flow->flow_id, flow->prs_ri.ri,
 			   flow->prs_ri.ri_mask);
@@ -471,7 +471,7 @@ static void mvpp2_cls_flow_prs_init(struct mvpp2 *priv,
 
 /* Initialize the Lookup Id table entry for the given flow */
 static void mvpp2_cls_flow_lkp_init(struct mvpp2 *priv,
-				    struct mvpp2_cls_flow *flow)
+				    const struct mvpp2_cls_flow *flow)
 {
 	struct mvpp2_cls_lookup_entry le;
 
@@ -493,7 +493,8 @@ static void mvpp2_cls_flow_lkp_init(struct mvpp2 *priv,
 }
 
 /* Initialize the flow table entries for the given flow */
-static void mvpp2_cls_flow_init(struct mvpp2 *priv, struct mvpp2_cls_flow *flow)
+static void mvpp2_cls_flow_init(struct mvpp2 *priv,
+				const struct mvpp2_cls_flow *flow)
 {
 	struct mvpp2_cls_flow_entry fe;
 	int i;
@@ -597,7 +598,7 @@ static int mvpp2_flow_set_hek_fields(struct mvpp2_cls_flow_entry *fe,
 	return 0;
 }
 
-struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow)
+const struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow)
 {
 	if (flow >= MVPP2_N_PRS_FLOWS)
 		return NULL;
@@ -619,8 +620,8 @@ struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow)
 static int mvpp2_port_rss_hash_opts_set(struct mvpp2_port *port, int flow_type,
 					u16 requested_opts)
 {
+	const struct mvpp2_cls_flow *flow;
 	struct mvpp2_cls_flow_entry fe;
-	struct mvpp2_cls_flow *flow;
 	int i, engine, flow_index;
 	u16 hash_opts;
 
@@ -708,8 +709,8 @@ u16 mvpp2_flow_get_hek_fields(struct mvpp2_cls_flow_entry *fe)
  */
 static u16 mvpp2_port_rss_hash_opts_get(struct mvpp2_port *port, int flow_type)
 {
+	const struct mvpp2_cls_flow *flow;
 	struct mvpp2_cls_flow_entry fe;
-	struct mvpp2_cls_flow *flow;
 	int i, flow_index;
 	u16 hash_opts = 0;
 
@@ -734,7 +735,7 @@ static u16 mvpp2_port_rss_hash_opts_get(struct mvpp2_port *port, int flow_type)
 
 static void mvpp2_cls_port_init_flows(struct mvpp2 *priv)
 {
-	struct mvpp2_cls_flow *flow;
+	const struct mvpp2_cls_flow *flow;
 	int i;
 
 	for (i = 0; i < MVPP2_N_PRS_FLOWS; i++) {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 22d7d9a587b0..1d439eb469d5 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -223,7 +223,7 @@ int mvpp2_cls_flow_eng_get(struct mvpp2_cls_flow_entry *fe);
 
 u16 mvpp2_flow_get_hek_fields(struct mvpp2_cls_flow_entry *fe);
 
-struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow);
+const struct mvpp2_cls_flow *mvpp2_cls_flow_get(int flow);
 
 u32 mvpp2_cls_flow_hits(struct mvpp2 *priv, int index);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 97e0ef130a61..03f889bf0fb6 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -58,7 +58,7 @@ DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_flow_dec_hits);
 static int mvpp2_dbgfs_flow_type_show(struct seq_file *s, void *unused)
 {
 	struct mvpp2_dbgfs_flow_entry *entry = s->private;
-	struct mvpp2_cls_flow *f;
+	const struct mvpp2_cls_flow *f;
 	const char *flow_name;
 
 	f = mvpp2_cls_flow_get(entry->flow);
@@ -115,8 +115,8 @@ static const struct file_operations mvpp2_dbgfs_flow_type_fops = {
 
 static int mvpp2_dbgfs_flow_id_show(struct seq_file *s, void *unused)
 {
-	struct mvpp2_dbgfs_flow_entry *entry = s->private;
-	struct mvpp2_cls_flow *f;
+	const struct mvpp2_dbgfs_flow_entry *entry = s->private;
+	const struct mvpp2_cls_flow *f;
 
 	f = mvpp2_cls_flow_get(entry->flow);
 	if (!f)
@@ -134,7 +134,7 @@ static int mvpp2_dbgfs_port_flow_hash_opt_show(struct seq_file *s, void *unused)
 	struct mvpp2_dbgfs_port_flow_entry *entry = s->private;
 	struct mvpp2_port *port = entry->port;
 	struct mvpp2_cls_flow_entry fe;
-	struct mvpp2_cls_flow *f;
+	const struct mvpp2_cls_flow *f;
 	int flow_index;
 	u16 hash_opts;
 
@@ -181,7 +181,7 @@ static int mvpp2_dbgfs_port_flow_engine_show(struct seq_file *s, void *unused)
 	struct mvpp2_dbgfs_port_flow_entry *entry = s->private;
 	struct mvpp2_port *port = entry->port;
 	struct mvpp2_cls_flow_entry fe;
-	struct mvpp2_cls_flow *f;
+	const struct mvpp2_cls_flow *f;
 	int flow_index, engine;
 
 	f = mvpp2_cls_flow_get(entry->dbg_fe->flow);
-- 
2.20.1

