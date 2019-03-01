Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8A22084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfCAFi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:38:27 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42743 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732071AbfCAFiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:38:24 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Mar 2019 07:38:20 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x215brYc016903;
        Fri, 1 Mar 2019 07:38:17 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Cc:     parav@mellanox.com
Subject: [RFC net-next 7/8] net/mlx5: Add devlink subdev life cycle command support
Date:   Thu, 28 Feb 2019 23:37:51 -0600
Message-Id: <1551418672-12822-8-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551418672-12822-1-git-send-email-parav@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement devlink device add/del command which cretes dummy subdev
devices that actual driver can bind to using standard device driver
model.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  4 ++
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  4 ++
 drivers/net/ethernet/mellanox/mlx5/core/subdev.c   | 55 ++++++++++++++++++++++
 4 files changed, 64 insertions(+)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/subdev.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 82d636b..f218789 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,6 +16,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o \
 		fs_counters.o rl.o lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o diag/fs_tracepoint.o diag/fw_tracer.o
+mlx5_core-$(CONFIG_SUBDEV) += subdev.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 40d591c..5f8cf0d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1213,6 +1213,10 @@ static int mlx5_unload_one(struct mlx5_core_dev *dev, struct mlx5_priv *priv,
 	.eswitch_encap_mode_set = mlx5_devlink_eswitch_encap_mode_set,
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 #endif
+#if IS_ENABLED(CONFIG_SUBDEV)
+	.dev_add = mlx5_devlink_dev_add,
+	.dev_del = mlx5_devlink_dev_del,
+#endif
 };
 
 #define MLX5_IB_MOD "mlx5_ib"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 9529cf9..2a54148 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -202,4 +202,8 @@ enum {
 
 u8 mlx5_get_nic_state(struct mlx5_core_dev *dev);
 void mlx5_set_nic_state(struct mlx5_core_dev *dev, u8 state);
+
+struct devlink *mlx5_devlink_dev_add(struct devlink *devlink);
+void mlx5_devlink_dev_del(struct devlink *devlink);
+
 #endif /* __MLX5_CORE_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/subdev.c b/drivers/net/ethernet/mellanox/mlx5/core/subdev.c
new file mode 100644
index 0000000..9e78ea01
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/subdev.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2018-19 Mellanox Technologies
+
+#include <linux/subdev_bus.h>
+#include <linux/subdev_ids.h>
+#include <linux/mlx5/driver.h>
+#include <net/devlink.h>
+
+#include "mlx5_core.h"
+
+struct mlx5_subdev {
+	struct subdev subdev;
+	struct devlink dl;
+};
+
+struct devlink *mlx5_devlink_dev_add(struct devlink *devlink)
+{
+	struct mlx5_subdev *subdev;
+	int ret;
+
+	subdev = subdev_alloc_dev(mlx5_subdev, subdev);
+	if (!subdev)
+		return ERR_PTR(-ENOMEM);
+
+	devlink_init(&subdev->dl, NULL);
+
+	ret = subdev_add_dev(&subdev->subdev, devlink->dev,
+			     SUBDEV_VENDOR_ID_MELLANOX,
+			     SUBDEV_DEVICE_ID_MELLANOX_SF);
+	if (ret)
+		goto add_err;
+
+	ret = __devlink_register(&subdev->dl, &subdev->subdev.dev, devlink);
+	if (ret)
+		goto reg_err;
+
+	return &subdev->dl;
+
+reg_err:
+	devlink_cleanup(&subdev->dl);
+add_err:
+	subdev_free_dev(&subdev->subdev);
+	return ERR_PTR(ret);
+}
+
+void mlx5_devlink_dev_del(struct devlink *devlink)
+{
+	struct mlx5_subdev *subdev =
+			container_of(devlink, struct mlx5_subdev, dl);
+
+	__devlink_unregister(devlink);
+	devlink_cleanup(devlink);
+	subdev_delete_dev(&subdev->subdev);
+	subdev_free_dev(&subdev->subdev);
+}
-- 
1.8.3.1

