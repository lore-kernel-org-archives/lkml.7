Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFABC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04DA21E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZmBDgEbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfHGKoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:44:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38371 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbfHGKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:44:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id m12so1597734plt.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aLHnVIwpIVGxDqRzxHV/wNTJAERS5/j0oQeqUDz6hs=;
        b=ZmBDgEbj8vm3FB9ZPPZP5LuMQT5VJsX95HQL3WOflC7xCsnq0oEJk++n59efQuCmlK
         7sJrv0ejwStE5oIe/q/j4MQ/2fDddwrgcqNfOBbula4XPdzOTW+wwmt6SE8Ybbu9+I7X
         oPqxu2NBTW9gboC5l/woQx5OPaCXSiccowojg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aLHnVIwpIVGxDqRzxHV/wNTJAERS5/j0oQeqUDz6hs=;
        b=HX1r9doOzz/+3zn0CPHrFAmrum94N59bYkFjdwjLO0gCNt/WVgYYzRK+h4AlL9QUDZ
         TdrW2b43a5Cxq/sl2UWqT/04p/yQEgwjB1L/ticPbQ1KiG6DElhC46tNw5NBX6mUm5Gr
         2VSmPuR2TdXFVoveEumeI5J5Iu2TzuWCR0wFRxzgPLzzhOPUQ5KVmG0FfgRnMVnQTw9+
         LLibJL6sPvtBnlbQNcW5Ip2GKcvCPYfGp96zXJqHuPVpkuHNg6qSbYTRiXFEe0QAIpdB
         l7Eov9QS3M4d8vossEREFPdVN6WExqvoGKgbvqf1lP0OSh2pen4Z2ExiCLkQJxw5zfDD
         Nipw==
X-Gm-Message-State: APjAAAWbLUj0oTHUYSydQv+HNTa9TVN9df8HMBTpWCkuMrZ94eABexM9
        LE8YlrfQV0vJKGuFUZij5Eshfg==
X-Google-Smtp-Source: APXvYqyoOR+dmCJzjYMVfEKERX14grDwxoRVW6wSlLa3ieRWzZ8A0T3vGaT5APZV4pVJ/VwcStJfJg==
X-Received: by 2002:a63:cc14:: with SMTP id x20mr7280504pgf.142.1565174657090;
        Wed, 07 Aug 2019 03:44:17 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id a3sm24747697pje.3.2019.08.07.03.44.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:44:16 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v15 4/5] rpmsg: add rpmsg support for mt8183 SCP.
Date:   Wed,  7 Aug 2019 18:43:45 +0800
Message-Id: <20190807104352.259767-5-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807104352.259767-1-pihsun@chromium.org>
References: <20190807104352.259767-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple rpmsg support for mt8183 SCP, that use IPI / IPC directly.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v14:
 - Change year on Copyright header to 2019.

Changes from v13:
 - No change.

Changes from v12:
 - Use strscpy instead of strncpy.

Changes from v11:
 - Fix a bug that when rproc_boot fails, the ns_ept won't be properly
   destroyed, causing memory leak.
 - Add documentation for mtk_rpmsg_info.

Changes from v10, v9, v8, v7:
 - No change.

Changes from v6:
 - Decouple mtk_rpmsg from mtk_scp by putting all necessary informations
   (name service IPI id, register/unregister/send functions) into a
   struct, and pass it to the mtk_rpmsg_create_rproc_subdev function.

Changes from v5:
 - CONFIG_MTK_SCP now selects CONFIG_RPMSG_MTK_SCP, and the dummy
   implementation for mtk_rpmsg_{create,destroy}_rproc_subdev when
   CONFIG_RPMSG_MTK_SCP is not defined is removed.

Changes from v4:
 - Match and fill the device tree node to the created rpmsg subdevice,
   so the rpmsg subdevice can utilize the properties and subnodes on
   device tree (This is similar to what drivers/rpmsg/qcom_smd.c does).

Changes from v3:
 - Change from unprepare to stop, to stop the rpmsg driver before the
   rproc is stopped, avoiding problem that some rpmsg would fail after
   rproc is stopped.
 - Add missing spin_lock_init, and use destroy_ept instead of kref_put.

Changes from v2:
 - Unregiser IPI handler on unprepare.
 - Lock the channel list on operations.
 - Move SCP_IPI_NS_SERVICE to 0xFF.

Changes from v1:
 - Do cleanup properly in mtk_rpmsg.c, which also removes the problem of
   short-lived work items.
 - Fix several issues checkpatch found.
---
 drivers/remoteproc/Kconfig         |   1 +
 drivers/remoteproc/mtk_common.h    |   2 +
 drivers/remoteproc/mtk_scp.c       |  38 ++-
 drivers/remoteproc/mtk_scp_ipi.c   |   1 +
 drivers/rpmsg/Kconfig              |   9 +
 drivers/rpmsg/Makefile             |   1 +
 drivers/rpmsg/mtk_rpmsg.c          | 414 +++++++++++++++++++++++++++++
 include/linux/remoteproc/mtk_scp.h |   4 +-
 include/linux/rpmsg/mtk_rpmsg.h    |  38 +++
 9 files changed, 503 insertions(+), 5 deletions(-)
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index ea71cad399f7..cff3a9fa817b 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -26,6 +26,7 @@ config IMX_REMOTEPROC
 config MTK_SCP
 	tristate "Mediatek SCP support"
 	depends on ARCH_MEDIATEK
+	select RPMSG_MTK_SCP
 	help
 	  Say y here to support Mediatek's System Companion Processor (SCP) via
 	  the remote processor framework.
diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index e213039543ec..dbf9b339a0b7 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -69,6 +69,8 @@ struct mtk_scp {
 	void __iomem *cpu_addr;
 	phys_addr_t phys_addr;
 	size_t dram_size;
+
+	struct rproc_subdev *rpmsg_subdev;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index ae820a35bd52..33d98903c195 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 #include <linux/remoteproc/mtk_scp.h>
+#include <linux/rpmsg/mtk_rpmsg.h>
 
 #include "mtk_common.h"
 #include "remoteproc_internal.h"
@@ -541,6 +542,31 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 	return 0;
 }
 
+static struct mtk_rpmsg_info mtk_scp_rpmsg_info = {
+	.send_ipi = scp_ipi_send,
+	.register_ipi = scp_ipi_register,
+	.unregister_ipi = scp_ipi_unregister,
+	.ns_ipi_id = SCP_IPI_NS_SERVICE,
+};
+
+static void scp_add_rpmsg_subdev(struct mtk_scp *scp)
+{
+	scp->rpmsg_subdev =
+		mtk_rpmsg_create_rproc_subdev(to_platform_device(scp->dev),
+					      &mtk_scp_rpmsg_info);
+	if (scp->rpmsg_subdev)
+		rproc_add_subdev(scp->rproc, scp->rpmsg_subdev);
+}
+
+static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
+{
+	if (scp->rpmsg_subdev) {
+		rproc_remove_subdev(scp->rproc, scp->rpmsg_subdev);
+		mtk_rpmsg_destroy_rproc_subdev(scp->rpmsg_subdev);
+		scp->rpmsg_subdev = NULL;
+	}
+}
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -623,22 +649,25 @@ static int scp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&scp->run.wq);
 	init_waitqueue_head(&scp->ack_wq);
 
+	scp_add_rpmsg_subdev(scp);
+
 	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
 					scp_irq_handler, IRQF_ONESHOT,
 					pdev->name, scp);
 
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		goto destroy_mutex;
+		goto remove_subdev;
 	}
 
 	ret = rproc_add(rproc);
 	if (ret)
-		goto destroy_mutex;
+		goto remove_subdev;
 
-	return ret;
+	return 0;
 
-destroy_mutex:
+remove_subdev:
+	scp_remove_rpmsg_subdev(scp);
 	mutex_destroy(&scp->desc_lock);
 	mutex_destroy(&scp->send_lock);
 free_rproc:
@@ -651,6 +680,7 @@ static int scp_remove(struct platform_device *pdev)
 {
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
 
+	scp_remove_rpmsg_subdev(scp);
 	mutex_destroy(&scp->desc_lock);
 	mutex_destroy(&scp->send_lock);
 	rproc_del(scp->rproc);
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index 59f797f9f007..a39458a0b788 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -99,6 +99,7 @@ int scp_ipi_send(struct platform_device *pdev,
 	int ret;
 
 	if (WARN_ON(id <= SCP_IPI_INIT) || WARN_ON(id >= SCP_IPI_MAX) ||
+	    WARN_ON(id == SCP_IPI_NS_SERVICE) ||
 	    WARN_ON(len > sizeof(send_obj->share_buf)) || WARN_ON(!buf))
 		return -EINVAL;
 
diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b41eca5..85e3cc075cb4 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -15,6 +15,15 @@ config RPMSG_CHAR
 	  in /dev. They make it possible for user-space programs to send and
 	  receive rpmsg packets.
 
+config RPMSG_MTK_SCP
+	tristate "MediaTek SCP"
+	depends on MTK_SCP
+	select RPMSG
+	help
+	  Say y here to enable support providing communication channels to
+	  remote processors in MediaTek platforms.
+	  This use IPI and IPC to communicate with remote processors.
+
 config RPMSG_QCOM_GLINK_NATIVE
 	tristate
 	select RPMSG
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 9aa859502d27..ae92a7fb08f6 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
+obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
new file mode 100644
index 000000000000..ebe52c302734
--- /dev/null
+++ b/drivers/rpmsg/mtk_rpmsg.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2019 Google LLC.
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/rpmsg/mtk_rpmsg.h>
+#include <linux/workqueue.h>
+
+#include "rpmsg_internal.h"
+
+struct mtk_rpmsg_rproc_subdev {
+	struct platform_device *pdev;
+	struct mtk_rpmsg_info *info;
+	struct rpmsg_endpoint *ns_ept;
+	struct rproc_subdev subdev;
+
+	struct work_struct register_work;
+	struct list_head channels;
+	struct mutex channels_lock;
+};
+
+#define to_mtk_subdev(d) container_of(d, struct mtk_rpmsg_rproc_subdev, subdev)
+
+struct mtk_rpmsg_channel_info {
+	struct rpmsg_channel_info info;
+	bool registered;
+	struct list_head list;
+};
+
+/**
+ * struct rpmsg_ns_msg - dynamic name service announcement message
+ * @name: name of remote service that is published
+ * @addr: address of remote service that is published
+ *
+ * This message is sent across to publish a new service. When we receive these
+ * messages, an appropriate rpmsg channel (i.e device) is created. In turn, the
+ * ->probe() handler of the appropriate rpmsg driver will be invoked
+ *  (if/as-soon-as one is registered).
+ */
+struct rpmsg_ns_msg {
+	char name[RPMSG_NAME_SIZE];
+	u32 addr;
+} __packed;
+
+struct mtk_rpmsg_device {
+	struct rpmsg_device rpdev;
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev;
+};
+
+struct mtk_rpmsg_endpoint {
+	struct rpmsg_endpoint ept;
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev;
+};
+
+#define to_mtk_rpmsg_device(r) container_of(r, struct mtk_rpmsg_device, rpdev)
+#define to_mtk_rpmsg_endpoint(r) container_of(r, struct mtk_rpmsg_endpoint, ept)
+
+static const struct rpmsg_endpoint_ops mtk_rpmsg_endpoint_ops;
+
+static void __ept_release(struct kref *kref)
+{
+	struct rpmsg_endpoint *ept = container_of(kref, struct rpmsg_endpoint,
+						  refcount);
+	kfree(to_mtk_rpmsg_endpoint(ept));
+}
+
+static void mtk_rpmsg_ipi_handler(void *data, unsigned int len, void *priv)
+{
+	struct mtk_rpmsg_endpoint *mept = priv;
+	struct rpmsg_endpoint *ept = &mept->ept;
+	int ret;
+
+	ret = (*ept->cb)(ept->rpdev, data, len, ept->priv, ept->addr);
+	if (ret)
+		dev_warn(&ept->rpdev->dev, "rpmsg handler return error = %d",
+			 ret);
+}
+
+static struct rpmsg_endpoint *
+__rpmsg_create_ept(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
+		   struct rpmsg_device *rpdev, rpmsg_rx_cb_t cb, void *priv,
+		   u32 id)
+{
+	struct mtk_rpmsg_endpoint *mept;
+	struct rpmsg_endpoint *ept;
+	struct platform_device *pdev = mtk_subdev->pdev;
+	int ret;
+
+	mept = kzalloc(sizeof(*mept), GFP_KERNEL);
+	if (!mept)
+		return NULL;
+	mept->mtk_subdev = mtk_subdev;
+
+	ept = &mept->ept;
+	kref_init(&ept->refcount);
+
+	ept->rpdev = rpdev;
+	ept->cb = cb;
+	ept->priv = priv;
+	ept->ops = &mtk_rpmsg_endpoint_ops;
+	ept->addr = id;
+
+	ret = mtk_subdev->info->register_ipi(pdev, id, mtk_rpmsg_ipi_handler,
+					     mept);
+	if (ret) {
+		dev_err(&pdev->dev, "IPI register failed, id = %d", id);
+		kref_put(&ept->refcount, __ept_release);
+		return NULL;
+	}
+
+	return ept;
+}
+
+static struct rpmsg_endpoint *
+mtk_rpmsg_create_ept(struct rpmsg_device *rpdev, rpmsg_rx_cb_t cb, void *priv,
+		     struct rpmsg_channel_info chinfo)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev =
+		to_mtk_rpmsg_device(rpdev)->mtk_subdev;
+
+	return __rpmsg_create_ept(mtk_subdev, rpdev, cb, priv, chinfo.src);
+}
+
+static void mtk_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev =
+		to_mtk_rpmsg_endpoint(ept)->mtk_subdev;
+
+	mtk_subdev->info->unregister_ipi(mtk_subdev->pdev, ept->addr);
+	kref_put(&ept->refcount, __ept_release);
+}
+
+static int mtk_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev =
+		to_mtk_rpmsg_endpoint(ept)->mtk_subdev;
+
+	return mtk_subdev->info->send_ipi(mtk_subdev->pdev, ept->addr, data,
+					  len, 0);
+}
+
+static int mtk_rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev =
+		to_mtk_rpmsg_endpoint(ept)->mtk_subdev;
+
+	/*
+	 * TODO: This currently is same as mtk_rpmsg_send, and wait until SCP
+	 * received the last command.
+	 */
+	return mtk_subdev->info->send_ipi(mtk_subdev->pdev, ept->addr, data,
+					  len, 0);
+}
+
+static const struct rpmsg_endpoint_ops mtk_rpmsg_endpoint_ops = {
+	.destroy_ept = mtk_rpmsg_destroy_ept,
+	.send = mtk_rpmsg_send,
+	.trysend = mtk_rpmsg_trysend,
+};
+
+static void mtk_rpmsg_release_device(struct device *dev)
+{
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
+	struct mtk_rpmsg_device *mdev = to_mtk_rpmsg_device(rpdev);
+
+	kfree(mdev);
+}
+
+static const struct rpmsg_device_ops mtk_rpmsg_device_ops = {
+	.create_ept = mtk_rpmsg_create_ept,
+};
+
+static struct device_node *
+mtk_rpmsg_match_device_subnode(struct device_node *node, const char *channel)
+{
+	struct device_node *child;
+	const char *name;
+	int ret;
+
+	for_each_available_child_of_node(node, child) {
+		ret = of_property_read_string(child, "mtk,rpmsg-name", &name);
+		if (ret)
+			continue;
+
+		if (strcmp(name, channel) == 0)
+			return child;
+	}
+
+	return NULL;
+}
+
+static int mtk_rpmsg_register_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
+				     struct rpmsg_channel_info *info)
+{
+	struct rpmsg_device *rpdev;
+	struct mtk_rpmsg_device *mdev;
+	struct platform_device *pdev = mtk_subdev->pdev;
+	int ret;
+
+	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
+	if (!mdev)
+		return -ENOMEM;
+
+	mdev->mtk_subdev = mtk_subdev;
+
+	rpdev = &mdev->rpdev;
+	rpdev->ops = &mtk_rpmsg_device_ops;
+	rpdev->src = info->src;
+	rpdev->dst = info->dst;
+	strscpy(rpdev->id.name, info->name, RPMSG_NAME_SIZE);
+
+	rpdev->dev.of_node =
+		mtk_rpmsg_match_device_subnode(pdev->dev.of_node, info->name);
+	rpdev->dev.parent = &pdev->dev;
+	rpdev->dev.release = mtk_rpmsg_release_device;
+
+	ret = rpmsg_register_device(rpdev);
+	if (ret) {
+		kfree(mdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mtk_register_device_work_function(struct work_struct *register_work)
+{
+	struct mtk_rpmsg_rproc_subdev *subdev = container_of(
+		register_work, struct mtk_rpmsg_rproc_subdev, register_work);
+	struct platform_device *pdev = subdev->pdev;
+	struct mtk_rpmsg_channel_info *info;
+	int ret;
+
+	mutex_lock(&subdev->channels_lock);
+	list_for_each_entry(info, &subdev->channels, list) {
+		if (info->registered)
+			continue;
+
+		ret = mtk_rpmsg_register_device(subdev, &info->info);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't create rpmsg_device\n");
+			continue;
+		}
+
+		info->registered = true;
+	}
+	mutex_unlock(&subdev->channels_lock);
+}
+
+static int mtk_rpmsg_create_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
+				   char *name, u32 addr)
+{
+	struct mtk_rpmsg_channel_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	strscpy(info->info.name, name, RPMSG_NAME_SIZE);
+	info->info.src = addr;
+	info->info.dst = RPMSG_ADDR_ANY;
+	mutex_lock(&mtk_subdev->channels_lock);
+	list_add(&info->list, &mtk_subdev->channels);
+	mutex_unlock(&mtk_subdev->channels_lock);
+
+	schedule_work(&mtk_subdev->register_work);
+	return 0;
+}
+
+static int mtk_rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
+			   void *priv, u32 src)
+{
+	struct rpmsg_ns_msg *msg = data;
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = priv;
+	struct device *dev = &mtk_subdev->pdev->dev;
+
+	int ret;
+
+	if (len != sizeof(*msg)) {
+		dev_err(dev, "malformed ns msg (%d)\n", len);
+		return -EINVAL;
+	}
+
+	/*
+	 * the name service ept does _not_ belong to a real rpmsg channel,
+	 * and is handled by the rpmsg bus itself.
+	 * for sanity reasons, make sure a valid rpdev has _not_ sneaked
+	 * in somehow.
+	 */
+	if (rpdev) {
+		dev_err(dev, "anomaly: ns ept has an rpdev handle\n");
+		return -EINVAL;
+	}
+
+	/* don't trust the remote processor for null terminating the name */
+	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
+
+	dev_info(dev, "creating channel %s addr 0x%x\n", msg->name, msg->addr);
+
+	ret = mtk_rpmsg_create_device(mtk_subdev, msg->name, msg->addr);
+	if (ret) {
+		dev_err(dev, "create rpmsg device failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int mtk_rpmsg_prepare(struct rproc_subdev *subdev)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+
+	/* a dedicated endpoint handles the name service msgs */
+	if (mtk_subdev->info->ns_ipi_id >= 0) {
+		mtk_subdev->ns_ept =
+			__rpmsg_create_ept(mtk_subdev, NULL, mtk_rpmsg_ns_cb,
+					   mtk_subdev,
+					   mtk_subdev->info->ns_ipi_id);
+		if (!mtk_subdev->ns_ept) {
+			dev_err(&mtk_subdev->pdev->dev,
+				"failed to create name service endpoint\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+void mtk_rpmsg_unprepare(struct rproc_subdev *subdev)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+
+	if (mtk_subdev->ns_ept) {
+		mtk_rpmsg_destroy_ept(mtk_subdev->ns_ept);
+		mtk_subdev->ns_ept = NULL;
+	}
+}
+
+void mtk_rpmsg_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct mtk_rpmsg_channel_info *info, *next;
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+	struct device *dev = &mtk_subdev->pdev->dev;
+
+	/*
+	 * Destroy the name service endpoint here, to avoid new channel being
+	 * created after the rpmsg_unregister_device loop below.
+	 */
+	if (mtk_subdev->ns_ept) {
+		mtk_rpmsg_destroy_ept(mtk_subdev->ns_ept);
+		mtk_subdev->ns_ept = NULL;
+	}
+
+	cancel_work_sync(&mtk_subdev->register_work);
+
+	mutex_lock(&mtk_subdev->channels_lock);
+	list_for_each_entry(info, &mtk_subdev->channels, list) {
+		if (!info->registered)
+			continue;
+		if (rpmsg_unregister_device(dev, &info->info)) {
+			dev_warn(
+				dev,
+				"rpmsg_unregister_device failed for %s.%d.%d\n",
+				info->info.name, info->info.src,
+				info->info.dst);
+		}
+	}
+
+	list_for_each_entry_safe(info, next,
+				 &mtk_subdev->channels, list) {
+		list_del(&info->list);
+		kfree(info);
+	}
+	mutex_unlock(&mtk_subdev->channels_lock);
+}
+
+struct rproc_subdev *
+mtk_rpmsg_create_rproc_subdev(struct platform_device *pdev,
+			      struct mtk_rpmsg_info *info)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev;
+
+	mtk_subdev = kzalloc(sizeof(*mtk_subdev), GFP_KERNEL);
+	if (!mtk_subdev)
+		return NULL;
+
+	mtk_subdev->pdev = pdev;
+	mtk_subdev->subdev.prepare = mtk_rpmsg_prepare;
+	mtk_subdev->subdev.stop = mtk_rpmsg_stop;
+	mtk_subdev->subdev.unprepare = mtk_rpmsg_unprepare;
+	mtk_subdev->info = info;
+	INIT_LIST_HEAD(&mtk_subdev->channels);
+	INIT_WORK(&mtk_subdev->register_work,
+		  mtk_register_device_work_function);
+	mutex_init(&mtk_subdev->channels_lock);
+
+	return &mtk_subdev->subdev;
+}
+EXPORT_SYMBOL_GPL(mtk_rpmsg_create_rproc_subdev);
+
+void mtk_rpmsg_destroy_rproc_subdev(struct rproc_subdev *subdev)
+{
+	struct mtk_rpmsg_rproc_subdev *mtk_subdev = to_mtk_subdev(subdev);
+
+	kfree(mtk_subdev);
+}
+EXPORT_SYMBOL_GPL(mtk_rpmsg_destroy_rproc_subdev);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MediaTek scp rpmsg driver");
diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
index 707556f6b899..67ae6674397b 100644
--- a/include/linux/remoteproc/mtk_scp.h
+++ b/include/linux/remoteproc/mtk_scp.h
@@ -40,9 +40,11 @@ enum scp_ipi_id {
 	SCP_IPI_ISP_FRAME,
 	SCP_IPI_FD_CMD,
 	SCP_IPI_CROS_HOST_CMD,
-	SCP_IPI_MAX,
+	SCP_IPI_NS_SERVICE = 0xFF,
+	SCP_IPI_MAX = 0x100,
 };
 
+
 /**
  * scp_ipi_register - register an ipi function
  *
diff --git a/include/linux/rpmsg/mtk_rpmsg.h b/include/linux/rpmsg/mtk_rpmsg.h
new file mode 100644
index 000000000000..861c1cbea523
--- /dev/null
+++ b/include/linux/rpmsg/mtk_rpmsg.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018 Google LLC.
+ */
+
+#ifndef __LINUX_RPMSG_MTK_RPMSG_H
+#define __LINUX_RPMSG_MTK_RPMSG_H
+
+#include <linux/device.h>
+#include <linux/remoteproc.h>
+
+typedef void (*ipi_handler_t)(void *data, unsigned int len, void *priv);
+
+/*
+ * struct mtk_rpmsg_info - IPI functions tied to the rpmsg device.
+ * @register_ipi: register IPI handler for an IPI id.
+ * @unregister_ipi: unregister IPI handler for a registered IPI id.
+ * @send_ipi: send IPI to an IPI id. wait is the timeout (in msecs) to wait
+ *            until response, or 0 if there's no timeout.
+ * @ns_ipi_id: the IPI id used for name service, or -1 if name service isn't
+ *             supported.
+ */
+struct mtk_rpmsg_info {
+	int (*register_ipi)(struct platform_device *pdev, u32 id,
+			    ipi_handler_t handler, void *priv);
+	void (*unregister_ipi)(struct platform_device *pdev, u32 id);
+	int (*send_ipi)(struct platform_device *pdev, u32 id,
+			void *buf, unsigned int len, unsigned int wait);
+	int ns_ipi_id;
+};
+
+struct rproc_subdev *
+mtk_rpmsg_create_rproc_subdev(struct platform_device *pdev,
+			      struct mtk_rpmsg_info *info);
+
+void mtk_rpmsg_destroy_rproc_subdev(struct rproc_subdev *subdev);
+
+#endif
-- 
2.22.0.770.g0f2c4a37fd-goog

