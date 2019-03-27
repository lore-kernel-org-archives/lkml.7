Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DBCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26062087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbfC0IpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:45:00 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50545 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732836AbfC0Io7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:59 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3AB8B40014;
        Wed, 27 Mar 2019 08:44:54 +0000 (UTC)
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
Subject: [PATCH net-next 09/18] net: mvpp2: debugfs: Allow reading the C2 engine table from debugfs
Date:   Wed, 27 Mar 2019 09:44:13 +0100
Message-Id: <20190327084422.4209-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPv2's Classifier uses multiple engines to perform classification. So
far, only the C2 engine is used, which has a 256 entries TCAM.

So far, we only accessed the relevant entries from the C2 engines, which
are the one implementing RSS. To implement and debug ntuple
classification offload, beaing able to see the hit count for each C2
entry is helpful, so this commit moves the logic to a dedicated
directory allowing to access each entry.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../ethernet/marvell/mvpp2/mvpp2_debugfs.c    | 76 ++++++++++++++-----
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 4100d82eca75..302d3e9513be 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -18,6 +18,11 @@ struct mvpp2_dbgfs_prs_entry {
 	struct mvpp2 *priv;
 };
 
+struct mvpp2_dbgfs_c2_entry {
+	int id;
+	struct mvpp2 *priv;
+};
+
 struct mvpp2_dbgfs_flow_entry {
 	int flow;
 	struct mvpp2 *priv;
@@ -37,6 +42,9 @@ struct mvpp2_dbgfs_entries {
 	/* Entries for Header Parser debug info */
 	struct mvpp2_dbgfs_prs_entry prs_entries[MVPP2_PRS_TCAM_SRAM_SIZE];
 
+	/* Entries for Classifier C2 engine debug info */
+	struct mvpp2_dbgfs_c2_entry c2_entries[MVPP22_CLS_C2_N_ENTRIES];
+
 	/* Entries for Classifier Flow Table debug info */
 	struct mvpp2_dbgfs_flow_tbl_entry flt_entries[MVPP2_CLS_FLOWS_TBL_SIZE];
 
@@ -182,11 +190,10 @@ DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_port_flow_engine);
 
 static int mvpp2_dbgfs_flow_c2_hits_show(struct seq_file *s, void *unused)
 {
-	struct mvpp2_port *port = s->private;
+	struct mvpp2_dbgfs_c2_entry *entry = s->private;
 	u32 hits;
 
-	hits = mvpp2_cls_c2_hit_count(port->priv,
-				      MVPP22_CLS_C2_RSS_ENTRY(port->id));
+	hits = mvpp2_cls_c2_hit_count(entry->priv, entry->id);
 
 	seq_printf(s, "%u\n", hits);
 
@@ -197,11 +204,11 @@ DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_flow_c2_hits);
 
 static int mvpp2_dbgfs_flow_c2_rxq_show(struct seq_file *s, void *unused)
 {
-	struct mvpp2_port *port = s->private;
+	struct mvpp2_dbgfs_c2_entry *entry = s->private;
 	struct mvpp2_cls_c2_entry c2;
 	u8 qh, ql;
 
-	mvpp2_cls_c2_read(port->priv, MVPP22_CLS_C2_RSS_ENTRY(port->id), &c2);
+	mvpp2_cls_c2_read(entry->priv, entry->id, &c2);
 
 	qh = (c2.attr[0] >> MVPP22_CLS_C2_ATTR0_QHIGH_OFFS) &
 	     MVPP22_CLS_C2_ATTR0_QHIGH_MASK;
@@ -218,11 +225,11 @@ DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_flow_c2_rxq);
 
 static int mvpp2_dbgfs_flow_c2_enable_show(struct seq_file *s, void *unused)
 {
-	struct mvpp2_port *port = s->private;
+	struct mvpp2_dbgfs_c2_entry *entry = s->private;
 	struct mvpp2_cls_c2_entry c2;
 	int enabled;
 
-	mvpp2_cls_c2_read(port->priv, MVPP22_CLS_C2_RSS_ENTRY(port->id), &c2);
+	mvpp2_cls_c2_read(entry->priv, entry->id, &c2);
 
 	enabled = !!(c2.attr[2] & MVPP22_CLS_C2_ATTR2_RSS_EN);
 
@@ -497,6 +504,7 @@ static int mvpp2_dbgfs_flow_entry_init(struct dentry *parent,
 		if (ret)
 			return ret;
 	}
+
 	return 0;
 }
 
@@ -579,6 +587,39 @@ static int mvpp2_dbgfs_prs_init(struct dentry *parent, struct mvpp2 *priv)
 	return 0;
 }
 
+static int mvpp2_dbgfs_c2_entry_init(struct dentry *parent,
+				     struct mvpp2 *priv, int id)
+{
+	struct mvpp2_dbgfs_c2_entry *entry;
+	struct dentry *c2_entry_dir;
+	char c2_entry_name[10];
+
+	if (id >= MVPP22_CLS_C2_N_ENTRIES)
+		return -EINVAL;
+
+	sprintf(c2_entry_name, "%03d", id);
+
+	c2_entry_dir = debugfs_create_dir(c2_entry_name, parent);
+	if (!c2_entry_dir)
+		return -ENOMEM;
+
+	entry = &priv->dbgfs_entries->c2_entries[id];
+
+	entry->id = id;
+	entry->priv = priv;
+
+	debugfs_create_file("hits", 0444, c2_entry_dir, entry,
+			    &mvpp2_dbgfs_flow_c2_hits_fops);
+
+	debugfs_create_file("default_rxq", 0444, c2_entry_dir, entry,
+			    &mvpp2_dbgfs_flow_c2_rxq_fops);
+
+	debugfs_create_file("rss_enable", 0444, c2_entry_dir, entry,
+			    &mvpp2_dbgfs_flow_c2_enable_fops);
+
+	return 0;
+}
+
 static int mvpp2_dbgfs_flow_tbl_entry_init(struct dentry *parent,
 					   struct mvpp2 *priv, int id)
 {
@@ -608,13 +649,23 @@ static int mvpp2_dbgfs_flow_tbl_entry_init(struct dentry *parent,
 
 static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
 {
-	struct dentry *cls_dir, *flow_tbl_dir;
+	struct dentry *cls_dir, *c2_dir, *flow_tbl_dir;
 	int i, ret;
 
 	cls_dir = debugfs_create_dir("classifier", parent);
 	if (!cls_dir)
 		return -ENOMEM;
 
+	c2_dir = debugfs_create_dir("c2", cls_dir);
+	if (!c2_dir)
+		return -ENOMEM;
+
+	for (i = 0; i < MVPP22_CLS_C2_N_ENTRIES; i++) {
+		ret = mvpp2_dbgfs_c2_entry_init(c2_dir, priv, i);
+		if (ret)
+			return ret;
+	}
+
 	flow_tbl_dir = debugfs_create_dir("flow_table", cls_dir);
 	if (!flow_tbl_dir)
 		return -ENOMEM;
@@ -646,15 +697,6 @@ static int mvpp2_dbgfs_port_init(struct dentry *parent,
 	debugfs_create_file("vid_filter", 0444, port_dir, port,
 			    &mvpp2_dbgfs_port_vid_fops);
 
-	debugfs_create_file("c2_hits", 0444, port_dir, port,
-			    &mvpp2_dbgfs_flow_c2_hits_fops);
-
-	debugfs_create_file("default_rxq", 0444, port_dir, port,
-			    &mvpp2_dbgfs_flow_c2_rxq_fops);
-
-	debugfs_create_file("rss_enable", 0444, port_dir, port,
-			    &mvpp2_dbgfs_flow_c2_enable_fops);
-
 	return 0;
 }
 
-- 
2.20.1

