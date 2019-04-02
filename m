Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3305C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD6B20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfDBNq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:46:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43102 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731412AbfDBNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:04 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0002oY-0J; Tue, 02 Apr 2019 14:40:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0004tt-FI; Tue, 02 Apr 2019 14:40:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Saeed Mahameed" <saeedm@mellanox.com>,
        "Leon Romanovsky" <leonro@mellanox.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.320275898@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 43/99] net/mlx5: Continue driver initialization
 despite debugfs failure
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 199fa087dc6b503baad06712716fac645a983e8a upstream.

The failure to create debugfs entry is unpleasant event, but not enough
to abort drier initialization. Align the mlx5_core code to debugfs design
and continue execution whenever debugfs_create_dir() successes or not.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -313,9 +313,9 @@ int mlx5_dev_init(struct mlx5_core_dev *
 	INIT_LIST_HEAD(&priv->pgdir_list);
 	spin_lock_init(&priv->mkey_lock);
 
-	priv->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), mlx5_debugfs_root);
-	if (!priv->dbg_root)
-		return -ENOMEM;
+	if (mlx5_debugfs_root)
+		priv->dbg_root =
+			debugfs_create_dir(pci_name(pdev), mlx5_debugfs_root);
 
 	err = pci_enable_device(pdev);
 	if (err) {

