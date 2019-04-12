Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1F020850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yQl5xGDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDLUK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:10:57 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34504 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDLUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:10:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CKAoMG127390;
        Fri, 12 Apr 2019 15:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555099850;
        bh=H3LKlIrfRwgmq5pVnhzc/VGMX7Hhbcyy0jI90TfgWyU=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=yQl5xGDdgJTx4NGwHfk2izRhhvfBA3rtGjK7rAUKOJZIhkxumY4w9qylt0VRvAR5i
         6tPb2z7D1IM6mwxdGu0g3CAbhQCwcOY411Hek7k/4UKPsBQ/KQKD518eLqiPeGIsd0
         RK9ECWyuChNYVnqk5lLCXTMjuu4HzSio5O3HhNtc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CKAofT031255
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 15:10:50 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 15:10:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 15:10:50 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CKAnc8059487;
        Fri, 12 Apr 2019 15:10:49 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <arvid.brodin@alten.se>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next PATCH 2/3] net: hsr: fix debugfs path to support multiple interfaces
Date:   Fri, 12 Apr 2019 16:13:24 -0400
Message-ID: <20190412201325.29001-3-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190412201325.29001-1-m-karicheri2@ti.com>
References: <20190412201325.29001-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the path of hsr debugfs root directory to use the net device
name so that it can work with multiple interfaces. While at it,
also fix some typos.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_debugfs.c | 11 +++++------
 net/hsr/hsr_device.c  |  2 +-
 net/hsr/hsr_main.h    |  5 +++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/hsr/hsr_debugfs.c b/net/hsr/hsr_debugfs.c
index b5a955013976..94447974a3c0 100644
--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -1,9 +1,9 @@
 /*
  * hsr_debugfs code
- * Copyright (C) 2017 Texas Instruments Incorporated
+ * Copyright (C) 2019 Texas Instruments Incorporated
  *
  * Author(s):
- *	Murali Karicheri <m-karicheri2@ti.com?
+ *	Murali Karicheri <m-karicheri2@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -78,12 +78,12 @@ static const struct file_operations hsr_fops = {
  * When debugfs is configured this routine sets up the node_table file per
  * hsr device for dumping the node_table entries
  */
-int hsr_debugfs_init(struct hsr_priv *priv)
+int hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev)
 {
 	int rc = -1;
 	struct dentry *de = NULL;
 
-	de = debugfs_create_dir("hsr", NULL);
+	de = debugfs_create_dir(hsr_dev->name, NULL);
 	if (!de) {
 		pr_err("Cannot create hsr debugfs root\n");
 		return rc;
@@ -99,9 +99,8 @@ int hsr_debugfs_init(struct hsr_priv *priv)
 		return rc;
 	}
 	priv->node_tbl_file = de;
-	rc = 0;
 
-	return rc;
+	return 0;
 }
 
 /* hsr_debugfs_term - Tear down debugfs intrastructure
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 58cf500ebf94..15c72065df79 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -485,7 +485,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 		goto fail;
 
 	mod_timer(&hsr->prune_timer, jiffies + msecs_to_jiffies(PRUNE_PERIOD));
-	res = hsr_debugfs_init(hsr);
+	res = hsr_debugfs_init(hsr, hsr_dev);
 	if (res)
 		goto fail;
 
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 6cd4dff58727..96fac696a1e1 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -184,10 +184,11 @@ static inline u16 hsr_get_skb_sequence_nr(struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-int hsr_debugfs_init(struct hsr_priv *priv);
+int hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev);
 void hsr_debugfs_term(struct hsr_priv *priv);
 #else
-static inline int hsr_debugfs_init(struct hsr_priv *priv)
+static inline int hsr_debugfs_init(struct hsr_priv *priv,
+				   struct net_device *hsr_dev)
 {
 	return 0;
 }
-- 
2.17.0

