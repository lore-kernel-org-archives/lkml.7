Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD94C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE732075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbfC0Io7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:44:59 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38361 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbfC0Ioz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:55 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3311140003;
        Wed, 27 Mar 2019 08:44:50 +0000 (UTC)
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
Subject: [PATCH net-next 07/18] net: mvpp2: debugfs: Store debugfs entries data in mvpp2 struct
Date:   Wed, 27 Mar 2019 09:44:11 +0100
Message-Id: <20190327084422.4209-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current way to store the required private data needed to access
various debugfs entries is to alloc them on the fly, share them within
the entries that need to access them, and finally have one entry free
that data upon closing. This leads to hard to maintain code, and is very
error-prone.

This commit stores all debugfs related data in the same place, making
sure this is allocated only when the debugfs directory is successfully
created, so that we don't waste memory when we don't use this feature.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  4 +
 .../ethernet/marvell/mvpp2/mvpp2_debugfs.c    | 94 +++++--------------
 2 files changed, 26 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 6220284798b1..04d140218f45 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -714,6 +714,7 @@ enum mvpp2_prs_l3_cast {
 #define MVPP2_DESC_DMA_MASK	DMA_BIT_MASK(40)
 
 /* Definitions */
+struct mvpp2_dbgfs_entries;
 
 /* Shared Packet Processor resources */
 struct mvpp2 {
@@ -775,6 +776,9 @@ struct mvpp2 {
 
 	/* Debugfs root entry */
 	struct dentry *dbgfs_dir;
+
+	/* Debugfs entries private data */
+	struct mvpp2_dbgfs_entries *dbgfs_entries;
 };
 
 struct mvpp2_pcpu_stats {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 03f889bf0fb6..5c2f84a2741e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -28,6 +28,17 @@ struct mvpp2_dbgfs_port_flow_entry {
 	struct mvpp2_dbgfs_flow_entry *dbg_fe;
 };
 
+struct mvpp2_dbgfs_entries {
+	/* Entries for Header Parser debug info */
+	struct mvpp2_dbgfs_prs_entry prs_entries[MVPP2_PRS_TCAM_SRAM_SIZE];
+
+	/* Entries for Classifier flows debug info */
+	struct mvpp2_dbgfs_flow_entry flow_entries[MVPP2_N_PRS_FLOWS];
+
+	/* Entries for per-port flows debug info */
+	struct mvpp2_dbgfs_port_flow_entry port_flow_entries[MVPP2_MAX_PORTS];
+};
+
 static int mvpp2_dbgfs_flow_flt_hits_show(struct seq_file *s, void *unused)
 {
 	struct mvpp2_dbgfs_flow_entry *entry = s->private;
@@ -93,25 +104,7 @@ static int mvpp2_dbgfs_flow_type_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int mvpp2_dbgfs_flow_type_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvpp2_dbgfs_flow_type_show, inode->i_private);
-}
-
-static int mvpp2_dbgfs_flow_type_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq = file->private_data;
-	struct mvpp2_dbgfs_flow_entry *flow_entry = seq->private;
-
-	kfree(flow_entry);
-	return single_release(inode, file);
-}
-
-static const struct file_operations mvpp2_dbgfs_flow_type_fops = {
-	.open = mvpp2_dbgfs_flow_type_open,
-	.read = seq_read,
-	.release = mvpp2_dbgfs_flow_type_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_flow_type);
 
 static int mvpp2_dbgfs_flow_id_show(struct seq_file *s, void *unused)
 {
@@ -153,28 +146,7 @@ static int mvpp2_dbgfs_port_flow_hash_opt_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int mvpp2_dbgfs_port_flow_hash_opt_open(struct inode *inode,
-					       struct file *file)
-{
-	return single_open(file, mvpp2_dbgfs_port_flow_hash_opt_show,
-			   inode->i_private);
-}
-
-static int mvpp2_dbgfs_port_flow_hash_opt_release(struct inode *inode,
-						  struct file *file)
-{
-	struct seq_file *seq = file->private_data;
-	struct mvpp2_dbgfs_port_flow_entry *flow_entry = seq->private;
-
-	kfree(flow_entry);
-	return single_release(inode, file);
-}
-
-static const struct file_operations mvpp2_dbgfs_port_flow_hash_opt_fops = {
-	.open = mvpp2_dbgfs_port_flow_hash_opt_open,
-	.read = seq_read,
-	.release = mvpp2_dbgfs_port_flow_hash_opt_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_port_flow_hash_opt);
 
 static int mvpp2_dbgfs_port_flow_engine_show(struct seq_file *s, void *unused)
 {
@@ -456,25 +428,7 @@ static int mvpp2_dbgfs_prs_valid_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int mvpp2_dbgfs_prs_valid_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvpp2_dbgfs_prs_valid_show, inode->i_private);
-}
-
-static int mvpp2_dbgfs_prs_valid_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq = file->private_data;
-	struct mvpp2_dbgfs_prs_entry *entry = seq->private;
-
-	kfree(entry);
-	return single_release(inode, file);
-}
-
-static const struct file_operations mvpp2_dbgfs_prs_valid_fops = {
-	.open = mvpp2_dbgfs_prs_valid_open,
-	.read = seq_read,
-	.release = mvpp2_dbgfs_prs_valid_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvpp2_dbgfs_prs_valid);
 
 static int mvpp2_dbgfs_flow_port_init(struct dentry *parent,
 				      struct mvpp2_port *port,
@@ -487,10 +441,7 @@ static int mvpp2_dbgfs_flow_port_init(struct dentry *parent,
 	if (IS_ERR(port_dir))
 		return PTR_ERR(port_dir);
 
-	/* This will be freed by 'hash_opts' release op */
-	port_entry = kmalloc(sizeof(*port_entry), GFP_KERNEL);
-	if (!port_entry)
-		return -ENOMEM;
+	port_entry = &port->priv->dbgfs_entries->port_flow_entries[port->id];
 
 	port_entry->port = port;
 	port_entry->dbg_fe = entry;
@@ -518,10 +469,7 @@ static int mvpp2_dbgfs_flow_entry_init(struct dentry *parent,
 	if (!flow_entry_dir)
 		return -ENOMEM;
 
-	/* This will be freed by 'type' release op */
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
+	entry = &priv->dbgfs_entries->flow_entries[flow];
 
 	entry->flow = flow;
 	entry->priv = priv;
@@ -582,10 +530,7 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
 	if (!prs_entry_dir)
 		return -ENOMEM;
 
-	/* The 'valid' entry's ops will free that */
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
+	entry = &priv->dbgfs_entries->prs_entries[tid];
 
 	entry->tid = tid;
 	entry->priv = priv;
@@ -663,6 +608,8 @@ static int mvpp2_dbgfs_port_init(struct dentry *parent,
 void mvpp2_dbgfs_cleanup(struct mvpp2 *priv)
 {
 	debugfs_remove_recursive(priv->dbgfs_dir);
+
+	kfree(priv->dbgfs_entries);
 }
 
 void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name)
@@ -682,6 +629,9 @@ void mvpp2_dbgfs_init(struct mvpp2 *priv, const char *name)
 		return;
 
 	priv->dbgfs_dir = mvpp2_dir;
+	priv->dbgfs_entries = kzalloc(sizeof(*priv->dbgfs_entries), GFP_KERNEL);
+	if (!priv->dbgfs_entries)
+		goto err;
 
 	ret = mvpp2_dbgfs_prs_init(mvpp2_dir, priv);
 	if (ret)
-- 
2.20.1

