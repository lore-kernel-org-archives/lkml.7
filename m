Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55DC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C638F2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j2WyRwkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfDER3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56328 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbfDER3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HT21U131011;
        Fri, 5 Apr 2019 12:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485342;
        bh=ctSIEeXKSrrC8w6FdzD/aTttmPpgbuAUBueVxeXVSk4=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=j2WyRwkTOIZ3Mpgel3BNOHZsPCRDkmD6NOZs+t+ZdbXjI6hxFehsqUjI7LL/TQh9H
         WFSZoqejQbNsdPPFk3VdHpbMHd2x2Rg+0jeKJL2mSSKY5qsC+PRYn3RoUC9liuV6Kp
         5xSm01xqhAeTJx9LbGhbpJZD95uPz7xpnrXvpXIo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HT2eU096566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:29:02 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:29:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:29:02 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsua095744;
        Fri, 5 Apr 2019 12:29:01 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 13/14] net: hsr: add debugfs support for display node list
Date:   Fri, 5 Apr 2019 13:31:35 -0400
Message-ID: <20190405173136.18050-14-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190405173136.18050-1-m-karicheri2@ti.com>
References: <20190405173136.18050-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a debugfs interface to allow display the nodes learned
by the hsr master.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/Makefile          |   1 +
 net/hsr/hsr_device.c      |   5 ++
 net/hsr/hsr_framereg.c    |  12 ----
 net/hsr/hsr_framereg.h    |  12 ++++
 net/hsr/hsr_main.h        |  17 ++++++
 net/hsr/hsr_prp_debugfs.c | 120 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 155 insertions(+), 12 deletions(-)
 create mode 100644 net/hsr/hsr_prp_debugfs.c

diff --git a/net/hsr/Makefile b/net/hsr/Makefile
index 9ae972a820f4..d74d89d013b0 100644
--- a/net/hsr/Makefile
+++ b/net/hsr/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_HSR)	+= hsr.o
 
 hsr-y			:= hsr_main.o hsr_framereg.o hsr_device.o \
 			   hsr_netlink.o hsr_slave.o hsr_forward.o
+hsr-$(CONFIG_DEBUG_FS) += hsr_prp_debugfs.o
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index bb7bf2002040..b47a621e3f4e 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -354,6 +354,8 @@ static void hsr_dev_destroy(struct net_device *hsr_dev)
 
 	hsr = netdev_priv(hsr_dev);
 
+	hsr_prp_debugfs_term(hsr);
+
 	rtnl_lock();
 	hsr_for_each_port(hsr, port)
 		hsr_del_port(port);
@@ -483,6 +485,9 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 		goto fail;
 
 	mod_timer(&hsr->prune_timer, jiffies + msecs_to_jiffies(PRUNE_PERIOD));
+	res = hsr_prp_debugfs_init(hsr);
+	if (res)
+		goto fail;
 
 	return 0;
 
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 22203562821f..a3cc30ac8a5a 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -18,18 +18,6 @@
 #include "hsr_framereg.h"
 #include "hsr_netlink.h"
 
-struct hsr_node {
-	struct list_head	mac_list;
-	unsigned char		macaddress_A[ETH_ALEN];
-	unsigned char		macaddress_B[ETH_ALEN];
-	/* Local slave through which AddrB frames are received from this node */
-	enum hsr_port_type	addr_B_port;
-	unsigned long		time_in[HSR_PT_PORTS];
-	bool			time_in_stale[HSR_PT_PORTS];
-	u16			seq_out[HSR_PT_PORTS];
-	struct rcu_head		rcu_head;
-};
-
 /*	TODO: use hash lists for mac addresses (linux/jhash.h)?    */
 
 /* seq_nr_after(a, b) - return true if a is after (higher in sequence than) b,
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 5f515d4cd088..a3bdcdab469d 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -48,4 +48,16 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 		      int *if2_age,
 		      u16 *if2_seq);
 
+struct hsr_node {
+	struct list_head	mac_list;
+	unsigned char		macaddress_A[ETH_ALEN];
+	unsigned char		macaddress_B[ETH_ALEN];
+	/* Local slave through which AddrB frames are received from this node */
+	enum hsr_port_type	addr_B_port;
+	unsigned long		time_in[HSR_PT_PORTS];
+	bool			time_in_stale[HSR_PT_PORTS];
+	u16			seq_out[HSR_PT_PORTS];
+	struct rcu_head		rcu_head;
+};
+
 #endif /* __HSR_FRAMEREG_H */
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 1e49675ca186..778213f07fe0 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -163,6 +163,10 @@ struct hsr_priv {
 	u8 prot_version;		/* Indicate if HSRv0 or HSRv1. */
 	spinlock_t seqnr_lock;			/* locking for sequence_nr */
 	unsigned char		sup_multicast_addr[ETH_ALEN];
+#ifdef	CONFIG_DEBUG_FS
+	struct dentry *node_tbl_root;
+	struct dentry *node_tbl_file;
+#endif
 };
 
 #define hsr_for_each_port(hsr, port) \
@@ -179,4 +183,17 @@ static inline u16 hsr_get_skb_sequence_nr(struct sk_buff *skb)
 	return ntohs(hsr_ethhdr->hsr_tag.sequence_nr);
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+int hsr_prp_debugfs_init(struct hsr_priv *priv);
+void hsr_prp_debugfs_term(struct hsr_priv *priv);
+#else
+static inline int hsr_prp_debugfs_init(struct hsr_priv *priv)
+{
+	return 0;
+}
+
+static inline void hsr_prp_debugfs_term(struct hsr_priv *priv)
+{}
+#endif
+
 #endif /*  __HSR_PRIVATE_H */
diff --git a/net/hsr/hsr_prp_debugfs.c b/net/hsr/hsr_prp_debugfs.c
new file mode 100644
index 000000000000..b30e98734c61
--- /dev/null
+++ b/net/hsr/hsr_prp_debugfs.c
@@ -0,0 +1,120 @@
+/*
+ * hsr_prp_debugfs code
+ * Copyright (C) 2017 Texas Instruments Incorporated
+ *
+ * Author(s):
+ *	Murali Karicheri <m-karicheri2@ti.com?
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/debugfs.h>
+#include "hsr_main.h"
+#include "hsr_framereg.h"
+
+static void print_mac_address(struct seq_file *sfp, unsigned char *mac)
+{
+	seq_printf(sfp, "%02x:%02x:%02x:%02x:%02x:%02x:",
+		   mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+}
+
+/* hsr_prp_node_table_show - Formats and prints node_table entries */
+static int
+hsr_prp_node_table_show(struct seq_file *sfp, void *data)
+{
+	struct hsr_priv *priv = (struct hsr_priv *)sfp->private;
+	struct hsr_node *node;
+
+	seq_puts(sfp, "Node Table entries\n");
+	seq_puts(sfp, "MAC-Address-A,   MAC-Address-B, time_in[A], ");
+	seq_puts(sfp, "time_in[B], Address-B port\n");
+	rcu_read_lock();
+	list_for_each_entry_rcu(node, &priv->node_db, mac_list) {
+		/* skip self node */
+		if (hsr_addr_is_self(priv, node->macaddress_A))
+			continue;
+		print_mac_address(sfp, &node->macaddress_A[0]);
+		seq_puts(sfp, " ");
+		print_mac_address(sfp, &node->macaddress_B[0]);
+		seq_printf(sfp, "0x%lx, ", node->time_in[HSR_PT_SLAVE_A]);
+		seq_printf(sfp, "0x%lx ", node->time_in[HSR_PT_SLAVE_B]);
+		seq_printf(sfp, "0x%x\n", node->addr_B_port);
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+/* hsr_prp_node_table_open - Open the node_table file
+ *
+ * Description:
+ * This routine opens a debugfs file node_table of specific hsr device
+ */
+static int
+hsr_prp_node_table_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hsr_prp_node_table_show, inode->i_private);
+}
+
+static const struct file_operations hsr_prp_fops = {
+	.owner	= THIS_MODULE,
+	.open	= hsr_prp_node_table_open,
+	.read	= seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/* hsr_prp_debugfs_init - create hsr-prp node_table file for dumping
+ * the node table
+ *
+ * Description:
+ * When debugfs is configured this routine sets up the node_table file per
+ * hsr/prp device for dumping the node_table entries
+ */
+int hsr_prp_debugfs_init(struct hsr_priv *priv)
+{
+	int rc = -1;
+	struct dentry *de = NULL;
+
+	de = debugfs_create_dir("hsr", NULL);
+	if (!de) {
+		pr_err("Cannot create hsr-prp debugfs root\n");
+		return rc;
+	}
+
+	priv->node_tbl_root = de;
+
+	de = debugfs_create_file("node_table", S_IFREG | 0444,
+				 priv->node_tbl_root, priv,
+				 &hsr_prp_fops);
+	if (!de) {
+		pr_err("Cannot create hsr-prp node_table directory\n");
+		return rc;
+	}
+	priv->node_tbl_file = de;
+	rc = 0;
+
+	return rc;
+}
+
+/* hsr_prp_debugfs_term - Tear down debugfs intrastructure
+ *
+ * Description:
+ * When Debufs is configured this routine removes debugfs file system
+ * elements that are specific to hsr-prp
+ */
+void
+hsr_prp_debugfs_term(struct hsr_priv *priv)
+{
+	debugfs_remove(priv->node_tbl_file);
+	priv->node_tbl_file = NULL;
+	debugfs_remove(priv->node_tbl_root);
+	priv->node_tbl_root = NULL;
+}
-- 
2.17.0

