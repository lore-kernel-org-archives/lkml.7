Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD750C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CED920863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgABBge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 20:36:34 -0500
Received: from mail.windriver.com ([147.11.1.11]:64632 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgABBgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 20:36:33 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 0021a62e002255
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 1 Jan 2020 17:36:06 -0800 (PST)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.468.0; Wed, 1 Jan 2020
 17:36:06 -0800
Received: by pek-lpggp2 (Postfix, from userid 20544)    id 41CC5720E21; Thu,  2
 Jan 2020 09:35:44 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>
CC:     <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <jiping.ma2@windriver.com>
Subject: [PATCH] stmmac: debugfs entry name is not be changed when udev rename device name.
Date:   Thu, 2 Jan 2020 09:35:44 +0800
Message-ID: <20200102013544.19271-1-jiping.ma2@windriver.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one notifier for udev changes net device name.

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b14f46a57154..3b05cb80eed7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4038,6 +4038,31 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(stmmac_dma_cap);
 
+/* Use network device events to rename debugfs file entries.
+ */
+static int stmmac_device_event(struct notifier_block *unused,
+			       unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	switch (event) {
+	case NETDEV_CHANGENAME:
+		if (priv->dbgfs_dir)
+			priv->dbgfs_dir = debugfs_rename(stmmac_fs_dir,
+							 priv->dbgfs_dir,
+							 stmmac_fs_dir,
+							 dev->name);
+		break;
+	}
+done:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block stmmac_notifier = {
+	.notifier_call = stmmac_device_event,
+};
+
 static int stmmac_init_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4076,6 +4101,8 @@ static int stmmac_init_fs(struct net_device *dev)
 		return -ENOMEM;
 	}
 
+	register_netdevice_notifier(&stmmac_notifier);
+
 	return 0;
 }
 
@@ -4083,6 +4110,7 @@ static void stmmac_exit_fs(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	unregister_netdevice_notifier(&stmmac_notifier);
 	debugfs_remove_recursive(priv->dbgfs_dir);
 }
 #endif /* CONFIG_DEBUG_FS */
-- 
2.23.0

