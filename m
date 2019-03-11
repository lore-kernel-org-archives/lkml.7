Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC54C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA532075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BbExRcaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfCKGfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:35:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43402 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfCKGfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:35:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so3260482pgq.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4W1AofX/f0D38JNXFXKnQtzj9nx964Whhep5y+EAcqg=;
        b=BbExRcaCaYGEsqhst5DUZi0amzO76lyMj8G0FmzKZHypFLC9IWhkkUtCgLOiKKqC0x
         9EBp3az6EjElBRON1tj/IPTBvn5jDDhuXAVXKzSfDGsCdqOMRxfKqc3QjBN7Ag3I9J96
         WbN7UIaavoSFcZ+4Y6ZRD+o08hx7Hr+4jjEK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4W1AofX/f0D38JNXFXKnQtzj9nx964Whhep5y+EAcqg=;
        b=Rz/ujMsdYWWX9Kx0nk7mUjvLFB9gGGaEs/GEiENgws19x/HLMbmerofKcGtaBInq55
         Yg/Pggo5dmw+o5mu1k0P5stf5F1dfG3lg6X7iaQzgL2Pyk7rh/xuqpxYyzktiqniQd1y
         Zxkk5eQcbjYC62AQz+7WlVqoCXkD2JPW8oRvA/Eb+P1HZO90tZrIKe4EEs4b+vQLbywM
         4dLZpqNplpnMLhlnnk7LKTyrtXtcSBU/K8yxUg3QGGL81m1Bq7T01Og4BzFyg6teMcUA
         9JCw4sNosXUW3PNcphfE39bPt0rg5DI+JowDC4GOfABYLfsz5IJxPjbgCu1mNrGXVCX4
         IxNA==
X-Gm-Message-State: APjAAAU/SykMUWdn66ikEnyV3LILEKXTBrHXdMCHg7yRCqMDJJdcWdWR
        wmGufmKnFWkapB/HYkgeujZeQQ==
X-Google-Smtp-Source: APXvYqxFX+JkkPVgvH0jYl7iBBSzMywURISZBv8ttL0s09HatpMJB0ZypvGJnEc9ieoECv7QbrhCvg==
X-Received: by 2002:a62:4815:: with SMTP id v21mr30971363pfa.167.1552286141954;
        Sun, 10 Mar 2019 23:35:41 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id p5sm6573040pfn.154.2019.03.10.23.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:35:41 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 6/7] platform/chrome: cros_ec: add EC host command support using rpmsg.
Date:   Mon, 11 Mar 2019 14:34:57 +0800
Message-Id: <20190311063458.137473-7-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190311063458.137473-1-pihsun@chromium.org>
References: <20190311063458.137473-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EC host command support through rpmsg.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
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
index 000000000000..a1c45b2b4e15
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
+	u8 data[];
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
+	len--;
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
2.21.0.360.g471c308f928-goog

