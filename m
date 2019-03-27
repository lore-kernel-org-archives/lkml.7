Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6520B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfC0IqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:46:24 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45741 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbfC0Io4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:56 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BA9254000B;
        Wed, 27 Mar 2019 08:44:52 +0000 (UTC)
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
Subject: [PATCH net-next 08/18] net: mvpp2: debugfs: Allow reading the flow table from debugfs
Date:   Wed, 27 Mar 2019 09:44:12 +0100
Message-Id: <20190327084422.4209-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Classifier flow table is the central part of the PPv2 Classifier,
since it describes all classification steps performed for each flow.

It has 512 entries, shared between all ports, which are divided into
sequences that are pointed-to by the decoding table. Being able to see
which entries in the flow table were hit is a key point when
implementing and debugging classification offload.

This commit allows reading each flow table entry's hit count
independently, with a clear-on-read behaviour.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../ethernet/marvell/mvpp2/mvpp2_debugfs.c    | 69 +++++++++++++++++--
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 5c2f84a2741e..4100d82eca75 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -23,6 +23,11 @@ struct mvpp2_dbgfs_flow_entry {
 	struct mvpp2 *priv;
 };
 
+struct mvpp2_dbgfs_flow_tbl_entry {
+	int id;
+	struct mvpp2 *priv;
+};
+
 struct mvpp2_dbgfs_port_flow_entry {
 	struct mvpp2_port *port;
 	struct mvpp2_dbgfs_flow_entry *dbg_fe;
@@ -32,6 +37,9 @@ struct mvpp2_dbgfs_entries {
 	/* Entries for Header Parser debug info */
 	struct mvpp2_dbgfs_prs_entry prs_entries[MVPP2_PRS_TCAM_SRAM_SIZE];
 
+	/* Entries for Classifier Flow Table debug info */
+	struct mvpp2_dbgfs_flow_tbl_entry flt_entries[MVPP2_CLS_FLOWS_TBL_SIZE];
+
 	/* Entries for Classifier flows debug info */
 	struct mvpp2_dbgfs_flow_entry flow_entries[MVPP2_N_PRS_FLOWS];
 
@@ -41,10 +49,9 @@ struct mvpp2_dbgfs_entries {
 
 static int mvpp2_dbgfs_flow_flt_hits_show(struct seq_file *s, void *unused)
 {
-	struct mvpp2_dbgfs_flow_entry *entry = s->private;
-	int id = MVPP2_FLOW_C2_ENTRY(entry->flow);
+	struct mvpp2_dbgfs_flow_tbl_entry *entry = s->private;
 
-	u32 hits = mvpp2_cls_flow_hits(entry->priv, id);
+	u32 hits = mvpp2_cls_flow_hits(entry->priv, entry->id);
 
 	seq_printf(s, "%u\n", hits);
 
@@ -474,9 +481,6 @@ static int mvpp2_dbgfs_flow_entry_init(struct dentry *parent,
 	entry->flow = flow;
 	entry->priv = priv;
 
-	debugfs_create_file("flow_hits", 0444, flow_entry_dir, entry,
-			    &mvpp2_dbgfs_flow_flt_hits_fops);
-
 	debugfs_create_file("dec_hits", 0444, flow_entry_dir, entry,
 			    &mvpp2_dbgfs_flow_dec_hits_fops);
 
@@ -575,6 +579,55 @@ static int mvpp2_dbgfs_prs_init(struct dentry *parent, struct mvpp2 *priv)
 	return 0;
 }
 
+static int mvpp2_dbgfs_flow_tbl_entry_init(struct dentry *parent,
+					   struct mvpp2 *priv, int id)
+{
+	struct mvpp2_dbgfs_flow_tbl_entry *entry;
+	struct dentry *flow_tbl_entry_dir;
+	char flow_tbl_entry_name[10];
+
+	if (id >= MVPP2_CLS_FLOWS_TBL_SIZE)
+		return -EINVAL;
+
+	sprintf(flow_tbl_entry_name, "%03d", id);
+
+	flow_tbl_entry_dir = debugfs_create_dir(flow_tbl_entry_name, parent);
+	if (!flow_tbl_entry_dir)
+		return -ENOMEM;
+
+	entry = &priv->dbgfs_entries->flt_entries[id];
+
+	entry->id = id;
+	entry->priv = priv;
+
+	debugfs_create_file("hits", 0444, flow_tbl_entry_dir, entry,
+			    &mvpp2_dbgfs_flow_flt_hits_fops);
+
+	return 0;
+}
+
+static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
+{
+	struct dentry *cls_dir, *flow_tbl_dir;
+	int i, ret;
+
+	cls_dir = debugfs_create_dir("classifier", parent);
+	if (!cls_dir)
+		return -ENOMEM;
+
+	flow_tbl_dir = debugfs_create_dir("flow_table", cls_dir);
+	if (!flow_tbl_dir)
+		return -ENOMEM;
+
+	for (i = 0; i < MVPP2_CLS_FLOWS_TBL_SIZE; i++) {
+		ret = mvpp2_dbgfs_flow_tbl_entry_init(flow_tbl_dir, priv, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int mvpp2_dbgfs_port_init(struct dentry *parent,
 				 struct mvpp2_port *port)
 {
@@ -637,6 +690,10 @@ void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name)
 	if (ret)
 		goto err;
 
+	ret = mvpp2_dbgfs_cls_init(mvpp2_dir, priv);
+	if (ret)
+		goto err;
+
 	for (i = 0; i < priv->port_count; i++) {
 		ret = mvpp2_dbgfs_port_init(mvpp2_dir, priv->port_list[i]);
 		if (ret)
-- 
2.20.1

