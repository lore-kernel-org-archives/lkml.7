Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441BA2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfCHWIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:08:23 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42851 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726521AbfCHWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:08:19 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Mar 2019 00:08:15 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x28M83SX002296;
        Sat, 9 Mar 2019 00:08:12 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com, kwankhede@nvidia.com
Cc:     parav@mellanox.com, alex.williamson@redhat.com,
        vuhuong@mellanox.com, yuvalav@mellanox.com,
        jakub.kicinski@netronome.com, kvm@vger.kernel.org
Subject: [RFC net-next v1 3/3] net/mlx5: Add mdev driver to bind to mdev devices
Date:   Fri,  8 Mar 2019 16:07:56 -0600
Message-Id: <1552082876-60228-4-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1552082876-60228-1-git-send-email-parav@mellanox.com>
References: <1552082876-60228-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mdev driver to probe the mdev devices and create fake
netdevice for it.
Similar to pci driver, when new mdev are created/removed or when user
triggers binding a mdev to mlx5_core driver by writing
mdev device id to /sys/bus/mdev/drivers/mlx5_core/bind,unbind files,

mlx5_core driver's probe(), remove() are invokes to handle life cycle
of netdev and rdma device associated with the mdev.

Current RFC patch only creates one fake netdev, but in subsequent non
RFC patch, it will create related hw objects and netdev.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  18 ++++
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  13 +++
 .../net/ethernet/mellanox/mlx5/core/mdev_driver.c  | 106 +++++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   4 +
 5 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/mdev_driver.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index e5c0822c..bded136a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -61,6 +61,6 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/tls.o en_accel/tls_rxtx.o en_accel/t
 #
 # Mdev basic
 #
-mlx5_core-$(CONFIG_MLX5_MDEV) += mdev.o
+mlx5_core-$(CONFIG_MLX5_MDEV) += mdev.o mdev_driver.o
 
 CFLAGS_tracepoint.o := -I$(src)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index ebc046f..91b8d8ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -321,3 +321,21 @@ int mlx5_dev_list_trylock(void)
 {
 	return mutex_trylock(&mlx5_intf_mutex);
 }
+
+struct mlx5_core_dev *mlx5_get_core_dev(const struct device *dev)
+{
+	struct mlx5_core_dev *found = NULL;
+	struct mlx5_core_dev *tmp_dev;
+	struct mlx5_priv *priv;
+
+	mutex_lock(&mlx5_intf_mutex);
+	list_for_each_entry(priv, &mlx5_dev_list, dev_list) {
+		tmp_dev = container_of(priv, struct mlx5_core_dev, priv);
+		if (&tmp_dev->pdev->dev == dev) {
+			found = tmp_dev;
+			break;
+		}
+	}
+	mutex_unlock(&mlx5_intf_mutex);
+	return found;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 72b0072..c1fc0f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -40,6 +40,7 @@
 #include <linux/io-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/mdev.h>
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/cq.h>
 #include <linux/mlx5/qp.h>
@@ -1553,7 +1554,15 @@ static int __init init(void)
 	mlx5e_init();
 #endif
 
+#if IS_ENABLED(CONFIG_VFIO_MDEV)
+	err = mdev_register_driver(&mlx5_mdev_driver, THIS_MODULE);
+	if (err) {
+		pci_unregister_driver(&mlx5_core_driver);
+		goto err_debug;
+	}
+#else
 	return 0;
+#endif
 
 err_debug:
 	mlx5_unregister_debugfs();
@@ -1562,6 +1571,10 @@ static int __init init(void)
 
 static void __exit cleanup(void)
 {
+#if IS_ENABLED(CONFIG_VFIO_MDEV)
+	mdev_unregister_driver(&mlx5_mdev_driver);
+#endif
+
 #ifdef CONFIG_MLX5_CORE_EN
 	mlx5e_cleanup();
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mdev_driver.c b/drivers/net/ethernet/mellanox/mlx5/core/mdev_driver.c
new file mode 100644
index 0000000..7618c5e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mdev_driver.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018-19 Mellanox Technologies
+
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <net/devlink.h>
+#include <linux/mdev.h>
+
+#include "mlx5_core.h"
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
+static int mlx5e_mdev_open(struct net_device *netdev)
+{
+	return 0;
+}
+
+static int mlx5e_mdev_close(struct net_device *netdev)
+{
+	return 0;
+}
+
+static netdev_tx_t
+mlx5e_mdev_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	return NETDEV_TX_BUSY;
+}
+
+const struct net_device_ops mlx5e_mdev_netdev_ops = {
+	.ndo_open                = mlx5e_mdev_open,
+	.ndo_stop                = mlx5e_mdev_close,
+	.ndo_start_xmit          = mlx5e_mdev_xmit,
+};
+
+static int mlx5_mdev_probe(struct device *dev)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct device *parent_dev = mdev_parent_dev(mdev);
+	struct mlx5_core_dev *mlx5_dev;
+	int err;
+
+	mlx5_dev = mlx5_get_core_dev(parent_dev);
+	if (!mlx5_dev)
+		return -ENODEV;
+
+	mlx5_dma_test(dev);
+
+	ndev = alloc_etherdev_mqs(sizeof(struct mlx5_subdev_ndev), 1, 1);
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, dev);
+	ndev->netdev_ops = &mlx5e_mdev_netdev_ops;
+
+	/* TODO:
+	 * init_hca().
+	 * create eqs, cqs.
+	 * attach to irq of parent pci device.
+	 */
+	err = register_netdev(ndev);
+	if (err) {
+		free_netdev(ndev);
+		ndev = NULL;
+	}
+	return err;
+}
+
+static void mlx5_mdev_remove(struct device *dev)
+{
+	if (ndev) {
+		unregister_netdev(ndev);
+		free_netdev(ndev);
+		ndev = NULL;
+	}
+}
+
+struct mdev_driver mlx5_mdev_driver = {
+	.name	= KBUILD_MODNAME,
+	.probe	= mlx5_mdev_probe,
+	.remove	= mlx5_mdev_remove,
+};
+
+int __init mlx5_mdev_driver_init(void)
+{
+	return mdev_register_driver(&mlx5_mdev_driver, THIS_MODULE);
+}
+
+void __exit mlx5_mdev_exit(void)
+{
+	mdev_unregister_driver(&mlx5_mdev_driver);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 0605a63..2e2b8b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -47,6 +47,8 @@
 
 extern uint mlx5_core_debug_mask;
 
+extern struct mdev_driver mlx5_mdev_driver;
+
 #define mlx5_core_dbg(__dev, format, ...)				\
 	dev_dbg(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
 		 __func__, __LINE__, current->pid,			\
@@ -217,4 +219,6 @@ static inline void mlx5_mdev_cleanup(struct mlx5_core_dev *mdev)
 }
 #endif
 
+struct mlx5_core_dev *mlx5_get_core_dev(const struct device *dev);
+
 #endif /* __MLX5_CORE_H__ */
-- 
1.8.3.1

