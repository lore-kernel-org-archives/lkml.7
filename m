Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F67420855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfCHWIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:08:25 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42845 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbfCHWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:08:18 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Mar 2019 00:08:12 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x28M83SW002296;
        Sat, 9 Mar 2019 00:08:10 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com, kwankhede@nvidia.com
Cc:     parav@mellanox.com, alex.williamson@redhat.com,
        vuhuong@mellanox.com, yuvalav@mellanox.com,
        jakub.kicinski@netronome.com, kvm@vger.kernel.org
Subject: [RFC net-next v1 2/3] net/mlx5: Add mdev sub device life cycle command support
Date:   Fri,  8 Mar 2019 16:07:55 -0600
Message-Id: <1552082876-60228-3-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1552082876-60228-1-git-send-email-parav@mellanox.com>
References: <1552082876-60228-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mdev hooks to to create mediated devices using mdev driver.
Actual mlx5_core driver in the host is expected to bind to these devices
using standard device driver model.

mdev devices are created using sysfs file as below example.

$ uuidgen
49d0e9ac-61b8-4c91-957e-6f6dbc42557d

$ echo 49d0e9ac-61b8-4c91-957e-6f6dbc42557d > \
./bus/pci/devices/0000:05:00.0/mdev_supported_types/mlx5_core-mgmt/create

$ echo 49d0e9ac-61b8-4c91-957e-6f6dbc42557d >
/sys/bus/mdev/drivers/vfio_mdev/unbind

Once mlx5 core driver is registered as mdev driver, mdev can be attached
to mlx5_core driver as below.

$ echo 49d0e9ac-61b8-4c91-957e-6f6dbc42557d >
/sys/bus/mdev/drivers/mlx5_core/bind

devlink output:
$ devlink dev show
pci/0000:05:00.0
mdev/69ea1551-d054-46e9-974d-8edae8f0aefe

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |   9 ++
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   9 ++
 drivers/net/ethernet/mellanox/mlx5/core/mdev.c     | 120 +++++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  15 +++
 include/linux/mlx5/driver.h                        |   5 +
 6 files changed, 163 insertions(+)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/mdev.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 37a5514..881ae1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -117,3 +117,12 @@ config MLX5_EN_TLS
 	  Build support for TLS cryptography-offload accelaration in the NIC.
 	  Note: Support for hardware with this capability needs to be selected
 	  for this option to become available.
+
+config MLX5_MDEV
+	bool "Mellanox Technologies Mediated device support"
+	depends on MLX5_CORE
+	depends on VFIO_MDEV
+	default y
+	help
+	  Build support for mediated devices. Mediated devices allow creating
+	  multiple netdev and/or rdma device(s) on single PCI function.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 82d636b..e5c0822c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -58,4 +58,9 @@ mlx5_core-$(CONFIG_MLX5_EN_IPSEC) += en_accel/ipsec.o en_accel/ipsec_rxtx.o \
 
 mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/tls.o en_accel/tls_rxtx.o en_accel/tls_stats.o
 
+#
+# Mdev basic
+#
+mlx5_core-$(CONFIG_MLX5_MDEV) += mdev.o
+
 CFLAGS_tracepoint.o := -I$(src)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 40d591c..72b0072 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -851,10 +851,18 @@ static int mlx5_init_once(struct mlx5_core_dev *dev, struct mlx5_priv *priv)
 		goto err_sriov_cleanup;
 	}
 
+	err = mlx5_mdev_init(dev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to init mdev device %d\n", err);
+		goto err_fpga_cleanup;
+	}
+
 	dev->tracer = mlx5_fw_tracer_create(dev);
 
 	return 0;
 
+err_fpga_cleanup:
+	mlx5_fpga_cleanup(dev);
 err_sriov_cleanup:
 	mlx5_sriov_cleanup(dev);
 err_eswitch_cleanup:
@@ -881,6 +889,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev, struct mlx5_priv *priv)
 static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 {
 	mlx5_fw_tracer_destroy(dev->tracer);
+	mlx5_mdev_cleanup(dev);
 	mlx5_fpga_cleanup(dev);
 	mlx5_sriov_cleanup(dev);
 	mlx5_eswitch_cleanup(dev->priv.eswitch);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mdev.c b/drivers/net/ethernet/mellanox/mlx5/core/mdev.c
new file mode 100644
index 0000000..e8e4aac
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mdev.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018-19 Mellanox Technologies
+
+#include <net/devlink.h>
+#include <linux/mdev.h>
+
+#include "mlx5_core.h"
+
+#define MLX5_MAX_MDEVS 1
+
+struct mlx5_mdev {
+	struct mlx5_core_dev *dev;
+};
+
+static int mlx5_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
+{
+	struct mlx5_core_dev *mlx5_dev;
+	struct device *parent_dev;
+	struct mlx5_mdev *mmdev;
+	struct devlink *devlink;
+	bool added;
+	int err;
+
+	parent_dev = mdev_parent_dev(mdev);
+	mlx5_dev = pci_get_drvdata(to_pci_dev(parent_dev));
+
+	added = atomic_add_unless(&mlx5_dev->mdev_info.cnt, 1, MLX5_MAX_MDEVS);
+	if (!added)
+		return -ENOSPC;
+
+	devlink = devlink_alloc(NULL, sizeof(*mmdev));
+	if (!devlink) {
+		atomic_dec(&mlx5_dev->mdev_info.cnt);
+		return -ENOMEM;
+	}
+	mmdev = devlink_priv(devlink);
+	mmdev->dev = mlx5_dev;
+	mdev_set_drvdata(mdev, mmdev);
+
+	/* TODO: create a mediated device hw object that driver
+	 * can work on later on to enable interrupts, create queues etc.
+	 */
+	err = devlink_register(devlink, mdev_dev(mdev));
+	if (err) {
+		devlink_free(devlink);
+		atomic_dec(&mlx5_dev->mdev_info.cnt);
+	}
+	return err;
+}
+
+static int mlx5_mdev_remove(struct mdev_device *mdev)
+{
+	struct mlx5_core_dev *mlx5_dev;
+	struct device *parent_dev;
+	struct mlx5_mdev *mmdev;
+	struct devlink *devlink;
+
+	parent_dev = mdev_parent_dev(mdev);
+	mlx5_dev = pci_get_drvdata(to_pci_dev(parent_dev));
+
+	mmdev = mdev_get_drvdata(mdev);
+	devlink = priv_to_devlink(mmdev);
+
+	devlink_unregister(devlink);
+	devlink_free(devlink);
+	atomic_dec(&mlx5_dev->mdev_info.cnt);
+	return 0;
+}
+
+static ssize_t
+num_mdevs_show(struct kobject *kobj, struct device *dev, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct mlx5_core_dev *mlx5_dev;
+
+	mlx5_dev = pci_get_drvdata(pdev);
+
+	return sprintf(buf, "%d\n", atomic_read(&mlx5_dev->mdev_info.cnt));
+}
+MDEV_TYPE_ATTR_RO(num_mdevs);
+
+static ssize_t
+available_instances_show(struct kobject *kobj, struct device *dev, char *buf)
+{
+	return sprintf(buf, "%d\n", MLX5_MAX_MDEVS);
+}
+MDEV_TYPE_ATTR_RO(available_instances);
+
+static struct attribute *mdev_dev_attrs[] = {
+	&mdev_type_attr_num_mdevs.attr,
+	&mdev_type_attr_available_instances.attr,
+	NULL,
+};
+
+static struct attribute_group mdev_mgmt_group = {
+	.name  = "mgmt",
+	.attrs = mdev_dev_attrs,
+};
+
+struct attribute_group *mlx5_mdev_groups[] = {
+	&mdev_mgmt_group,
+	NULL,
+};
+
+const struct mdev_parent_ops mlx5_mdev_ops = {
+	.create = mlx5_mdev_create,
+	.remove = mlx5_mdev_remove,
+	.supported_type_groups = mlx5_mdev_groups,
+};
+
+int mlx5_mdev_init(struct mlx5_core_dev *dev)
+{
+	return mdev_register_device(&dev->pdev->dev, &mlx5_mdev_ops);
+}
+
+void mlx5_mdev_cleanup(struct mlx5_core_dev *dev)
+{
+	mdev_unregister_device(&dev->pdev->dev);
+}
+
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 9529cf9..0605a63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -202,4 +202,19 @@ enum {
 
 u8 mlx5_get_nic_state(struct mlx5_core_dev *dev);
 void mlx5_set_nic_state(struct mlx5_core_dev *dev, u8 state);
+
+#ifdef CONFIG_MLX5_MDEV
+int mlx5_mdev_init(struct mlx5_core_dev *mdev);
+void mlx5_mdev_cleanup(struct mlx5_core_dev *mdev);
+#else
+static inline int mlx5_mdev_init(struct mlx5_core_dev *mdev)
+{
+	return 0;
+}
+
+static inline void mlx5_mdev_cleanup(struct mlx5_core_dev *mdev)
+{
+}
+#endif
+
 #endif /* __MLX5_CORE_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index c2de50f..6836ab9 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -637,6 +637,10 @@ struct mlx5_clock {
 struct mlx5_fw_tracer;
 struct mlx5_vxlan;
 
+struct mlx5_mdevs_info {
+	atomic_t cnt;
+};
+
 struct mlx5_core_dev {
 	struct pci_dev	       *pdev;
 	/* sync pci state */
@@ -679,6 +683,7 @@ struct mlx5_core_dev {
 	struct mlx5_ib_clock_info  *clock_info;
 	struct page             *clock_info_page;
 	struct mlx5_fw_tracer   *tracer;
+	struct mlx5_mdevs_info mdev_info;
 };
 
 struct mlx5_db {
-- 
1.8.3.1

