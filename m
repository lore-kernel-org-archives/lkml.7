Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678282186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfCAFic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:38:32 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42766 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732492AbfCAFi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:38:29 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Mar 2019 07:38:23 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x215brYd016903;
        Fri, 1 Mar 2019 07:38:20 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Cc:     parav@mellanox.com
Subject: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev devices
Date:   Thu, 28 Feb 2019 23:37:52 -0600
Message-Id: <1551418672-12822-9-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551418672-12822-1-git-send-email-parav@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a subdev driver to probe the subdev devices and create fake
netdevice for it.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  8 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  3 +
 .../ethernet/mellanox/mlx5/core/subdev_driver.c    | 93 ++++++++++++++++++++++
 4 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/subdev_driver.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index f218789..c8aeaf1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,7 +16,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o \
 		fs_counters.o rl.o lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o diag/fs_tracepoint.o diag/fw_tracer.o
-mlx5_core-$(CONFIG_SUBDEV) += subdev.o
+mlx5_core-$(CONFIG_SUBDEV) += subdev.o subdev_driver.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 5f8cf0d..7dfa8c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1548,7 +1548,11 @@ static int __init init(void)
 	mlx5e_init();
 #endif
 
-	return 0;
+	err = subdev_register_driver(&mlx5_subdev_driver);
+	if (err)
+		pci_unregister_driver(&mlx5_core_driver);
+
+	return err;
 
 err_debug:
 	mlx5_unregister_debugfs();
@@ -1557,6 +1561,8 @@ static int __init init(void)
 
 static void __exit cleanup(void)
 {
+	subdev_unregister_driver(&mlx5_subdev_driver);
+
 #ifdef CONFIG_MLX5_CORE_EN
 	mlx5e_cleanup();
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 2a54148..1b733c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -41,12 +41,15 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/mlx5/cq.h>
 #include <linux/mlx5/fs.h>
+#include <linux/subdev_bus.h>
 
 #define DRIVER_NAME "mlx5_core"
 #define DRIVER_VERSION "5.0-0"
 
 extern uint mlx5_core_debug_mask;
 
+extern struct subdev_driver mlx5_subdev_driver;
+
 #define mlx5_core_dbg(__dev, format, ...)				\
 	dev_dbg(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
 		 __func__, __LINE__, current->pid,			\
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/subdev_driver.c b/drivers/net/ethernet/mellanox/mlx5/core/subdev_driver.c
new file mode 100644
index 0000000..880aa4f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/subdev_driver.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018-19 Mellanox Technologies
+
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/subdev_bus.h>
+#include <linux/subdev_ids.h>
+#include <linux/etherdevice.h>
+
+struct mlx5_subdev_ndev {
+	struct net_device ndev;
+};
+
+static void mlx5_dma_test(struct device *dev)
+{
+	dma_addr_t pa;
+	void *va;
+
+	va = dma_alloc_coherent(dev, 4096, &pa, GFP_KERNEL);
+	if (va)
+		dma_free_coherent(dev, 4096, va, pa);
+}
+
+static struct net_device *ndev;
+
+static int mlx5e_subdev_open(struct net_device *netdev)
+{
+	return 0;
+}
+
+static int mlx5e_subdev_close(struct net_device *netdev)
+{
+	return 0;
+}
+
+static netdev_tx_t
+mlx5e_subdev_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	return NETDEV_TX_BUSY;
+}
+
+const struct net_device_ops mlx5e_subdev_netdev_ops = {
+	.ndo_open                = mlx5e_subdev_open,
+	.ndo_stop                = mlx5e_subdev_close,
+	.ndo_start_xmit          = mlx5e_subdev_xmit,
+};
+
+static int mlx5_subdev_probe(struct device *dev)
+{
+	int err;
+
+	mlx5_dma_test(dev);
+	/* Only one device supported in rfc */
+	if (ndev)
+		return 0;
+
+	ndev = alloc_etherdev_mqs(sizeof(struct mlx5_subdev_ndev), 1, 1);
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, dev);
+	ndev->netdev_ops = &mlx5e_subdev_netdev_ops;
+	err = register_netdev(ndev);
+	if (err) {
+		free_netdev(ndev);
+		ndev = NULL;
+	}
+	return err;
+}
+
+static int mlx5_subdev_remove(struct device *dev)
+{
+	if (ndev) {
+		unregister_netdev(ndev);
+		free_netdev(ndev);
+		ndev = NULL;
+	}
+	return 0;
+}
+
+static const struct subdev_id mlx5_subdev_id_table[] = {
+	{ .vendor_id = SUBDEV_VENDOR_ID_MELLANOX,
+	  .device_id = SUBDEV_DEVICE_ID_MELLANOX_SF },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(subdev, mlx5_subdev_id_table);
+
+struct subdev_driver mlx5_subdev_driver = {
+	.id_table = mlx5_subdev_id_table,
+	.driver.name = "mlx5_subdev_driver",
+	.driver.probe = mlx5_subdev_probe,
+	.driver.remove = mlx5_subdev_remove,
+};
-- 
1.8.3.1

