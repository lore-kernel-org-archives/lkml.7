Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ED0C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765E621537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfFNIPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:15:24 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49808 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfFNIPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:15:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9640B1A05C8;
        Fri, 14 Jun 2019 10:15:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E68B91A05D2;
        Fri, 14 Jun 2019 10:15:12 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 23F8D4029F;
        Fri, 14 Jun 2019 16:15:05 +0800 (SGT)
From:   daniel.baluta@nxp.com
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, shengjiu.wang@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, daniel.baluta@nxp.com,
        daniel.baluta@gmail.com, anson.huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, o.rempel@pengutronix.de
Subject: [PATCH 1/2] firmware: imx: Add DSP IPC protocol driver
Date:   Fri, 14 Jun 2019 16:16:49 +0800
Message-Id: <20190614081650.11880-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614081650.11880-1-daniel.baluta@nxp.com>
References: <20190614081650.11880-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Some of i.MX8 processors (e.g i.MX8QM, i.MX8QXP) contain
the Tensilica HiFi4 DSP for advanced pre- and post-audio
processing.

The communication between Host CPU and DSP firmware is
taking place using a shared memory area for message passing
and a dedicated Messaging Unit for notifications.

DSP IPC protocol driver offers a doorbell interface using
imx-mailbox API.

We use 4 MU channels (2 x TXDB, 2 x RXDB) to implement a
request-reply protocol.

Connection 0 (txdb0, rxdb0):
        - Host writes messasge to shared memory [SHMEM]
	- Host sends a request [MU]
	- DSP handles request [SHMEM]
	- DSP sends reply [MU]

Connection 1 (txdb1, rxdb1):
	- DSP writes a message to shared memory [SHMEM]
	- DSP sends a request [MU]
	- Host handles request [SHMEM]
	- Host sends reply [MU]

The protocol driver will be used by a Host client to
communicate with the DSP. First client will be the i.MX8
part from Sound Open Firmware infrastructure.

The protocol drivers offers the following interface:

On Tx:
   - imx_dsp_ring_doorbell, will be called to notify the DSP
   that it needs to handle a request.

On Rx:
   - clients need to provide two callbacks:
	.handle_reply
	.handle_request
  - the callbacks will be used by the protocol driver on
    notification arrival from DSP.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/Kconfig     |  11 ++
 drivers/firmware/imx/Makefile    |   1 +
 drivers/firmware/imx/imx-dsp.c   | 167 +++++++++++++++++++++++++++++++
 include/linux/firmware/imx/dsp.h |  61 +++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 drivers/firmware/imx/imx-dsp.c
 create mode 100644 include/linux/firmware/imx/dsp.h

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 42b566f8903f..383996b679a8 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -1,4 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config IMX_DSP
+	bool "IMX DSP Protocol driver"
+	depends on IMX_MBOX
+	help
+	  This enables DSP IPC protocol between host CPU (Linux)
+	  and the firmware running on DSP.
+	  DSP exists on some i.MX8 processors (e.g i.MX8QM, i.MX8QXP).
+
+          It acts like a doorbell. Client might use shared memory to
+	  exchange information with DSP side.
+
 config IMX_SCU
 	bool "IMX SCU Protocol driver"
 	depends on IMX_MBOX
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 802c4ad8e8f9..08bc9ddfbdfb 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
new file mode 100644
index 000000000000..953fd364ad76
--- /dev/null
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *  Author: Daniel Baluta <daniel.baluta@nxp.com>
+ *
+ * Implementation of the DSP IPC interface (host side)
+ */
+
+#include <linux/firmware/imx/dsp.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+static struct imx_dsp_ipc *imx_dsp_handle;
+
+/*
+ * Get the default handle used by DSP
+ */
+int imx_dsp_get_handle(struct imx_dsp_ipc **ipc)
+{
+	if (!imx_dsp_handle)
+		return -EPROBE_DEFER;
+
+	*ipc = imx_dsp_handle;
+	return 0;
+}
+EXPORT_SYMBOL(imx_dsp_get_handle);
+
+void imx_dsp_set_data(struct imx_dsp_ipc *ipc, void *data)
+{
+	if (!ipc)
+		return;
+
+	ipc->private_data = data;
+}
+EXPORT_SYMBOL(imx_dsp_set_data);
+
+void *imx_dsp_get_data(struct imx_dsp_ipc *ipc)
+{
+	if (!ipc)
+		return NULL;
+
+	return ipc->private_data;
+}
+EXPORT_SYMBOL(imx_dsp_get_data);
+
+/*
+ * imx_dsp_ring_doorbell - triggers an interrupt on the other side (DSP)
+ *
+ * @dsp: DSP IPC handle
+ * @chan_idx: index of the channel where to trigger the interrupt
+ *
+ * Returns non-negative value for success, negative value for error
+ */
+int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc, unsigned int idx)
+{
+	int ret;
+	struct imx_dsp_chan *dsp_chan;
+
+	if (idx > DSP_MU_CHAN_NUM)
+		return -EINVAL;
+
+	dsp_chan = &ipc->chans[idx];
+	ret = mbox_send_message(dsp_chan->ch, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_dsp_ring_doorbell);
+
+/*
+ * imx_dsp_handle_rx - rx callback used by imx mailbox
+ *
+ * @c: mbox client
+ * @msg: message received
+ *
+ * Users of DSP IPC will need to privde handle_reply and handle_request
+ * callbacks.
+ */
+static void imx_dsp_handle_rx(struct mbox_client *c, void *msg)
+{
+	struct imx_dsp_chan *chan = container_of(c, struct imx_dsp_chan, cl);
+
+	if (chan->idx == 0) {
+		chan->ipc->ops->handle_reply(chan->ipc);
+	} else {
+		chan->ipc->ops->handle_request(chan->ipc);
+		imx_dsp_ring_doorbell(chan->ipc, 1);
+	}
+}
+
+static int imx_dsp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_dsp_ipc *dsp_ipc;
+	struct imx_dsp_chan *dsp_chan;
+	struct mbox_client *cl;
+	char *chan_name;
+	int ret;
+	int i;
+
+	dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
+	if (!dsp_ipc)
+		return -ENOMEM;
+
+	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
+		if (i < 2)
+			chan_name = kasprintf(GFP_KERNEL, "txdb%d", i);
+		else
+			chan_name = kasprintf(GFP_KERNEL, "rxdb%d", i - 2);
+
+		if (!chan_name)
+			return -ENOMEM;
+
+		dsp_chan = &dsp_ipc->chans[i];
+		cl = &dsp_chan->cl;
+		cl->dev = dev;
+		cl->tx_block = false;
+		cl->knows_txdone = true;
+		cl->rx_callback = imx_dsp_handle_rx;
+
+		dsp_chan->ipc = dsp_ipc;
+		dsp_chan->idx = i % 2;
+		dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
+		if (IS_ERR(dsp_chan->ch)) {
+			ret = PTR_ERR(dsp_chan->ch);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
+					chan_name, ret);
+			return ret;
+		}
+
+		dev_dbg(dev, "request mbox chan %s\n", chan_name);
+		/* chan_name is not used anymore by framework */
+		kfree(chan_name);
+	}
+
+	dsp_ipc->dev = dev;
+
+	imx_dsp_handle = dsp_ipc;
+
+	dev_info(dev, "NXP i.MX DSP IPC initialized\n");
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id imx_dsp_match[] = {
+	{ .compatible = "fsl,imx-dsp", },
+	{ /* Sentinel */ }
+};
+
+static struct platform_driver imx_dsp_driver = {
+	.driver = {
+		.name = "imx-dsp",
+		.of_match_table = imx_dsp_match,
+	},
+	.probe = imx_dsp_probe,
+};
+builtin_platform_driver(imx_dsp_driver);
+
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
+MODULE_DESCRIPTION("IMX DSP IPC protocol driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/firmware/imx/dsp.h b/include/linux/firmware/imx/dsp.h
new file mode 100644
index 000000000000..75637d8fab34
--- /dev/null
+++ b/include/linux/firmware/imx/dsp.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018 NXP
+ *
+ * Header file for the DSP IPC implementation
+ */
+
+#ifndef _IMX_DSP_IPC_H
+#define _IMX_DSP_IPC_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/mailbox_client.h>
+
+#define DSP_MU_CHAN_NUM		4
+
+struct imx_dsp_chan {
+	struct imx_dsp_ipc *ipc;
+	struct mbox_client cl;
+	struct mbox_chan *ch;
+	int idx;
+};
+
+struct imx_dsp_ops {
+	void (*handle_reply)(struct imx_dsp_ipc *ipc);
+	void (*handle_request)(struct imx_dsp_ipc *ipc);
+};
+
+struct imx_dsp_ipc {
+	/* Host <-> DSP communication uses 2 txdb and 2 rxdb channels */
+	struct imx_dsp_chan chans[DSP_MU_CHAN_NUM];
+	struct device *dev;
+	struct imx_dsp_ops *ops;
+	void *private_data;
+};
+
+#if IS_ENABLED(CONFIG_IMX_DSP)
+
+int imx_dsp_ring_doorbell(struct imx_dsp_ipc *dsp, unsigned int chan_idx);
+int imx_dsp_get_handle(struct imx_dsp_ipc **ipc);
+void imx_dsp_set_data(struct imx_dsp_ipc *ipc, void *data);
+void *imx_dsp_get_data(struct imx_dsp_ipc *ipc);
+
+#else
+
+static inline int imx_dsp_get_handle(struct imx_dsp_ipc **ipc)
+{
+	return -EIO;
+}
+
+static inline int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc,
+					unsigned int chan_idx)
+{
+	return -EIO;
+}
+
+void imx_dsp_set_data(struct imx_dsp_ipc *ipc, void *data) { }
+void *imx_dsp_get_data(struct imx_dsp_ipc *ipc) { return NULL; }
+
+#endif
+#endif /* _IMX_DSP_IPC_H */
-- 
2.17.1

