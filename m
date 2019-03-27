Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0858C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D332087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mv3jIhg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfC0FPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:15:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732421AbfC0FPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:15:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so9356624pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEE8RjkQNzgZd8+cLO1AlOlN3E5o1nb52DSm8gKdaMk=;
        b=Mv3jIhg/IPdPOGx5au/t7jOD2ajutCVVVQrqOVeCgWWvDokPabHGPA6e1nucmsR4KO
         0jv1YWajqAY9E0yZtFT8sUSZVXIYVMJPoTFZuLpC4Tpjbf+RkT5RAO4J9qBR25z1241j
         MMbTO3chJpN+8z932pHOKk91HUFMrlTK1DViM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEE8RjkQNzgZd8+cLO1AlOlN3E5o1nb52DSm8gKdaMk=;
        b=r+TqOAAYek909zdKAG/+WjGJJeYWFFJXhRDUiiOKHXyPLkRYlilOlKHZhW3yDy9VTI
         qFoZ9sS3H3nz5yV9odwYFjgMzxy3NrGq4IlE9ke1ItJM8MmX28AmtXaLOlLWR60Z14wm
         B/DYgDw2XtMSXwhz3F9U++EXsTu23E9GsIMhorGMmzcwlJI7i+yhyrAIHmgyJ3x2n3kt
         08ZXI6NokWudt3wom5R7szHeeXcMngLsEHMa7cOkceZW5m+omTXEeYuK8K4FZ7sKoqe2
         NwjyNlFnMY/t1k4EC3AffP5dpUdPrxDkjKFJe8qC++aJ5zUR3OCzwsuGRgXauYqM0HU2
         0k9w==
X-Gm-Message-State: APjAAAV4u6Agkuv0ncSLEcRQ1RBNlb2eGkeJ0qAETFRP3phk1YBS4sGV
        8wJ6TxnROr+bO7B9hUmuWtJLVw==
X-Google-Smtp-Source: APXvYqx59IgiDsBBB32Zpgam5s++n5KP0rk3fE9bUyyAIRXhdlNgZzbd81WGX8DbLCtP7lrj28uL1g==
X-Received: by 2002:aa7:914d:: with SMTP id 13mr10986066pfi.149.1553663731028;
        Tue, 26 Mar 2019 22:15:31 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id k72sm58622609pfb.122.2019.03.26.22.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:15:30 -0700 (PDT)
From:   Peter Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 6/7] platform/chrome: cros_ec: add EC host command support using rpmsg.
Date:   Wed, 27 Mar 2019 13:14:48 +0800
Message-Id: <20190327051450.16222-7-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190327051450.16222-1-pihsun@chromium.org>
References: <20190327051450.16222-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pi-Hsun Shih <pihsun@chromium.org>

Add EC host command support through rpmsg.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v6:
 - Make data for response aligned to 4 bytes.

Changes from v5:
 - Change commit title.
 - Add documents for some structs, and fix all warning from
   scripts/kernel-doc.
 - Miscellaneous fixes based on feedback.

Changes from v4:
 - Change from work queue to completion.
 - Change from matching using rpmsg id to device tree compatible, to
   support EC subdevices.

Changes from v3:
 - Add host event support by adding an extra bytes at the start of IPC
   message to indicate the type of the message (host event or host
   command), since there's no additional irq that can be used for host
   event.

Changes from v2:
 - Wait for ipi ack instead of depends on the behavior in mtk-rpmsg.

Changes from v1:
 - Code format fix based on feedback for cros_ec_rpmsg.c.
 - Extract feature detection for SCP into separate patch (Patch 6).
---
 drivers/platform/chrome/Kconfig         |   9 +
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c | 265 ++++++++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 9186d81a51cc..5c48aa6da2f8 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -59,6 +59,15 @@ config CROS_EC_I2C
 	  a checksum. Failing accesses will be retried three times to
 	  improve reliability.
 
+config CROS_EC_RPMSG
+	tristate "ChromeOS Embedded Controller (rpmsg)"
+	depends on MFD_CROS_EC && RPMSG && OF
+	help
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  through rpmsg. This uses a simple byte-level protocol with a
+	  checksum. Also since there's no addition EC-to-host interrupt, this
+	  use a byte in message to distinguish host event from host command.
+
 config CROS_EC_SPI
 	tristate "ChromeOS Embedded Controller (SPI)"
 	depends on MFD_CROS_EC && SPI
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 1e2f0029b597..4b69d795720d 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
+obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
 cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
new file mode 100644
index 000000000000..2ecae806cfc5
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2018 Google LLC.
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rpmsg.h>
+#include <linux/slab.h>
+
+#define EC_MSG_TIMEOUT_MS 200
+#define HOST_COMMAND_MARK 1
+#define HOST_EVENT_MARK 2
+
+/**
+ * struct cros_ec_rpmsg_response - rpmsg message format from from EC.
+ *
+ * @type:	The type of message, should be either HOST_COMMAND_MARK or
+ *		HOST_EVENT_MARK, representing that the message is a response to
+ *		host command, or a host event.
+ * @data:	ec_host_response for host command.
+ */
+struct cros_ec_rpmsg_response {
+	u8 type;
+	u8 data[] __aligned(4);
+};
+
+/**
+ * struct cros_ec_rpmsg - information about a EC over rpmsg.
+ *
+ * @rpdev:	rpmsg device we are connected to
+ * @xfer_ack:	completion for host command transfer.
+ * @host_event_work:	Work struct for pending host event.
+ */
+struct cros_ec_rpmsg {
+	struct rpmsg_device *rpdev;
+	struct completion xfer_ack;
+	struct work_struct host_event_work;
+};
+
+/**
+ * cros_ec_cmd_xfer_rpmsg - Transfer a message over rpmsg and receive the reply
+ *
+ * @ec_dev: ChromeOS EC device
+ * @ec_msg: Message to transfer
+ *
+ * This is only used for old EC proto version, and is not supported for this
+ * driver.
+ *
+ * Return: number of bytes of the reply on success or negative error code.
+ */
+static int cros_ec_cmd_xfer_rpmsg(struct cros_ec_device *ec_dev,
+				  struct cros_ec_command *ec_msg)
+{
+	return -EINVAL;
+}
+
+/**
+ * cros_ec_pkt_xfer_rpmsg - Transfer a packet over rpmsg and receive the reply
+ *
+ * @ec_dev: ChromeOS EC device
+ * @ec_msg: Message to transfer
+ *
+ * Return: number of bytes of the reply on success or negative error code.
+ */
+static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
+				  struct cros_ec_command *ec_msg)
+{
+	struct ec_host_response *response;
+	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
+	struct rpmsg_device *rpdev = ec_rpmsg->rpdev;
+	int len;
+	u8 sum;
+	int ret;
+	int i;
+	unsigned long timeout;
+
+	ec_msg->result = 0;
+	len = cros_ec_prepare_tx(ec_dev, ec_msg);
+	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
+
+	reinit_completion(&ec_rpmsg->xfer_ack);
+	ret = rpmsg_send(rpdev->ept, ec_dev->dout, len);
+	if (ret) {
+		dev_err(ec_dev->dev, "rpmsg send failed\n");
+		return ret;
+	}
+
+	timeout = msecs_to_jiffies(EC_MSG_TIMEOUT_MS);
+	ret = wait_for_completion_timeout(&ec_rpmsg->xfer_ack, timeout);
+	if (!ret) {
+		dev_err(ec_dev->dev, "rpmsg send timeout\n");
+		return -EIO;
+	}
+
+	/* check response error code */
+	response = (struct ec_host_response *)ec_dev->din;
+	ec_msg->result = response->result;
+
+	ret = cros_ec_check_result(ec_dev, ec_msg);
+	if (ret)
+		goto exit;
+
+	if (response->data_len > ec_msg->insize) {
+		dev_err(ec_dev->dev, "packet too long (%d bytes, expected %d)",
+			response->data_len, ec_msg->insize);
+		ret = -EMSGSIZE;
+		goto exit;
+	}
+
+	/* copy response packet payload and compute checksum */
+	memcpy(ec_msg->data, ec_dev->din + sizeof(*response),
+	       response->data_len);
+
+	sum = 0;
+	for (i = 0; i < sizeof(*response) + response->data_len; i++)
+		sum += ec_dev->din[i];
+
+	if (sum) {
+		dev_err(ec_dev->dev, "bad packet checksum, calculated %x\n",
+			sum);
+		ret = -EBADMSG;
+		goto exit;
+	}
+
+	ret = response->data_len;
+exit:
+	if (ec_msg->command == EC_CMD_REBOOT_EC)
+		msleep(EC_REBOOT_DELAY_MS);
+
+	return ret;
+}
+
+static void
+cros_ec_rpmsg_host_event_function(struct work_struct *host_event_work)
+{
+	struct cros_ec_rpmsg *ec_rpmsg = container_of(
+		host_event_work, struct cros_ec_rpmsg, host_event_work);
+	struct cros_ec_device *ec_dev = dev_get_drvdata(&ec_rpmsg->rpdev->dev);
+	bool wake_event = true;
+	int ret;
+
+	ret = cros_ec_get_next_event(ec_dev, &wake_event);
+
+	/*
+	 * Signal only if wake host events or any interrupt if
+	 * cros_ec_get_next_event() returned an error (default value for
+	 * wake_event is true)
+	 */
+	if (wake_event && device_may_wakeup(ec_dev->dev))
+		pm_wakeup_event(ec_dev->dev, 0);
+
+	if (ret > 0)
+		blocking_notifier_call_chain(&ec_dev->event_notifier,
+					     0, ec_dev);
+}
+
+static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
+				  int len, void *priv, u32 src)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
+	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
+	struct cros_ec_rpmsg_response *resp;
+
+	if (!len) {
+		dev_warn(ec_dev->dev, "rpmsg received empty response");
+		return -EINVAL;
+	}
+
+	resp = data;
+	len -= offsetof(struct cros_ec_rpmsg_response, data);
+	if (resp->type == HOST_COMMAND_MARK) {
+		if (len > ec_dev->din_size) {
+			dev_warn(
+				ec_dev->dev,
+				"received length %d > din_size %d, truncating",
+				len, ec_dev->din_size);
+			len = ec_dev->din_size;
+		}
+
+		memcpy(ec_dev->din, resp->data, len);
+		complete(&ec_rpmsg->xfer_ack);
+	} else if (resp->type == HOST_EVENT_MARK) {
+		schedule_work(&ec_rpmsg->host_event_work);
+	} else {
+		dev_warn(ec_dev->dev, "rpmsg received invalid type = %d",
+			 resp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+	struct cros_ec_device *ec_dev;
+	struct cros_ec_rpmsg *ec_rpmsg;
+	int ret;
+
+	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
+	if (!ec_dev)
+		return -ENOMEM;
+
+	ec_rpmsg = devm_kzalloc(dev, sizeof(*ec_rpmsg), GFP_KERNEL);
+	if (!ec_rpmsg)
+		return -ENOMEM;
+
+	ec_dev->dev = dev;
+	ec_dev->priv = ec_rpmsg;
+	ec_dev->cmd_xfer = cros_ec_cmd_xfer_rpmsg;
+	ec_dev->pkt_xfer = cros_ec_pkt_xfer_rpmsg;
+	ec_dev->phys_name = dev_name(&rpdev->dev);
+	ec_dev->din_size = sizeof(struct ec_host_response) +
+			   sizeof(struct ec_response_get_protocol_info);
+	ec_dev->dout_size = sizeof(struct ec_host_request);
+	dev_set_drvdata(dev, ec_dev);
+
+	ec_rpmsg->rpdev = rpdev;
+	init_completion(&ec_rpmsg->xfer_ack);
+	INIT_WORK(&ec_rpmsg->host_event_work,
+		  cros_ec_rpmsg_host_event_function);
+
+	ret = cros_ec_register(ec_dev);
+	if (ret) {
+		dev_err(dev, "cannot register EC\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
+	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
+
+	cancel_work_sync(&ec_rpmsg->host_event_work);
+}
+
+static const struct of_device_id cros_ec_rpmsg_of_match[] = {
+	{ .compatible = "google,cros-ec-rpmsg", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cros_ec_rpmsg_of_match);
+
+static struct rpmsg_driver cros_ec_driver_rpmsg = {
+	.drv = {
+		.name   = KBUILD_MODNAME,
+		.of_match_table = cros_ec_rpmsg_of_match,
+	},
+	.probe		= cros_ec_rpmsg_probe,
+	.remove		= cros_ec_rpmsg_remove,
+	.callback	= cros_ec_rpmsg_callback,
+};
+
+module_rpmsg_driver(cros_ec_driver_rpmsg);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ChromeOS EC multi function device (rpmsg)");
-- 
2.21.0.392.gf8f6787159e-goog

