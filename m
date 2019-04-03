Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A9A21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDCIwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:52:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:44841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDCIwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:52:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 01:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="333332365"
Received: from rajeev-desktop.iind.intel.com ([10.223.84.39])
  by fmsmga006.fm.intel.com with ESMTP; 03 Apr 2019 01:52:11 -0700
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     srinivas.pandruvada@linux.intel.com, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     ncrews@chromium.org, jettrink@chromium.org, gwendal@google.com,
        rushikesh.s.kadam@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform: chrome: Add ChromeOS EC ISHTP driver
Date:   Wed,  3 Apr 2019 14:22:09 +0530
Message-Id: <1554281529-11131-1-git-send-email-rushikesh.s.kadam@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ChromeOS EC ISHTP driver.

Sends ChromeOS EC host commands over ISHTP to ISH firmware.

Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
---

v2
 - Dropped unused "reset" parameter in function cros_ec_init()
 - Change driver name to cros_ec_ishtp to be consistent with other
   references in the code.
 - Fixed a few typos. 

v1
 - Initial version

 drivers/platform/chrome/Kconfig         |  13 +
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_ishtp.c | 792 ++++++++++++++++++++++++++++++++
 3 files changed, 806 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_ishtp.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 16b1615..92a339a 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -84,6 +84,19 @@ config CROS_EC_LPC
           To compile this driver as a module, choose M here: the
           module will be called cros_ec_lpc.
 
+config CROS_EC_ISHTP
+	tristate "ChromeOS Embedded Controller (ISHTP)"
+	depends on MFD_CROS_EC
+	depends on INTEL_ISH_HID
+	help
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  firmware running on Intel Integrated Sensor Hub (ISH), using the
+	  ISH Transport protocol (ISH-TP). This uses a simple byte-level
+	  protocol with a checksum.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_ishtp.
+
 config CROS_EC_LPC_MEC
 	bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
 	depends on CROS_EC_LPC
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index cd591bf..fb2639e 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -12,4 +12,5 @@ cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
 cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
+obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
new file mode 100644
index 0000000..10e8237
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -0,0 +1,792 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ISHTP client driver for talking to the Chrome OS EC firmware running
+ * on Intel Integrated Sensor Hub (ISH) using the ISH Transport protocol
+ * (ISH-TP).
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ */
+
+#include <linux/delay.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/intel-ish-client-if.h>
+
+/*
+ * ISH TX/RX ring buffer pool size
+ *
+ * The AP->ISH messages and corresponding ISH->AP responses are
+ * serialized. We need 1 TX and 1 RX buffer for these.
+ *
+ * The MKBP ISH->AP events are serialized. We need one additional RX
+ * buffer for them.
+ */
+#define CROS_ISH_CL_TX_RING_SIZE		1
+#define CROS_ISH_CL_RX_RING_SIZE		2
+
+/* ISH CrOS EC Host Commands */
+enum cros_ec_ish_channel {
+	CROS_EC_COMMAND = 1,			/* AP->ISH message */
+	CROS_MKBP_EVENT = 2,			/* ISH->AP events */
+};
+
+/*
+ * ISH firmware timeout for 1 message send failure is 1Hz, and the
+ * firmware will retry 2 times, so 3Hz is used for timeout.
+ */
+#define ISHTP_SEND_TIMEOUT			(3 * HZ)
+
+/* ISH Transport CrOS EC ISH client unique GUID */
+static const guid_t cros_ish_guid =
+	GUID_INIT(0x7b7154d0, 0x56f4, 0x4bdc,
+		  0xb0, 0xd8, 0x9e, 0x7c, 0xda,	0xe0, 0xd6, 0xa0);
+
+struct header {
+	u8 channel;
+	u8 status;
+	u8 reserved[2];
+} __packed;
+
+struct cros_ish_out_msg {
+	struct header hdr;
+	struct ec_host_request ec_request;
+} __packed;
+
+struct cros_ish_in_msg {
+	struct header hdr;
+	struct ec_host_response ec_response;
+} __packed;
+
+#define IN_MSG_EC_RESPONSE_PREAMBLE					\
+	offsetof(struct cros_ish_in_msg, ec_response)
+
+#define OUT_MSG_EC_REQUEST_PREAMBLE					\
+	offsetof(struct cros_ish_out_msg, ec_request)
+
+#define cl_data_to_dev(client_data) ishtp_device((client_data)->cl_device)
+
+/*
+ * The Read-Write Semaphore is used to prevent message TX or RX while
+ * the ishtp client is being initialized or undergoing reset.
+ *
+ * The readers are the kernel function calls responsible for IA->ISH
+ * and ISH->AP messaging.
+ *
+ * The writers are .reset() and .probe() function.
+ */
+DECLARE_RWSEM(init_lock);
+
+/**
+ * struct response_info - Encapsulate firmware response related
+ *			information for passing between function
+ *			ish_send() and process_recv() callback.
+ * @data:		Copy the data received from firmware here.
+ * @max_size:		Max size allocated for the @data buffer. If the
+ *			received data exceeds this value, we log an
+ *			error.
+ * @size:		Actual size of data received from firmware.
+ * @error:		Returns 0 for success, negative error code for a
+ *			failure in function process_recv().
+ * @received:		Set to true on receiving a valid firmware
+ *			response to host command
+ * @wait_queue:		Wait queue for Host firmware loading where the
+ *			client sends message to ISH firmware and waits
+ *			for response
+ */
+struct response_info {
+	void *data;
+	size_t max_size;
+	size_t size;
+	int error;
+	bool received;
+	wait_queue_head_t wait_queue;
+};
+
+/**
+ * struct ishtp_cl_data - Encapsulate per ISH TP Client.
+ * @cros_ish_cl:	ISHTP firmware client instance.
+ * @cl_device:		ISHTP client device instance.
+ * @response:		Firmware response information for passing
+ *			between function ish_send() and process_recv()
+ *			callback.
+ * @work_ishtp_reset:	Work queue reset handling.
+ * @work_ec_evt:	Work queue for EC events.
+ * @ec_dev:		CrOS EC MFD device.
+ *
+ * This structure is used to store per client data.
+ */
+struct ishtp_cl_data {
+	struct ishtp_cl *cros_ish_cl;
+	struct ishtp_cl_device *cl_device;
+
+	/*
+	 * Used for passing firmware response information between
+	 * ish_send() and process_recv() callback.
+	 */
+	struct response_info response;
+
+	struct work_struct work_ishtp_reset;
+	struct work_struct work_ec_evt;
+	struct cros_ec_device *ec_dev;
+};
+
+/**
+ * ish_evt_handler - ISH to AP event handler
+ * @work:		Work struct
+ */
+static void ish_evt_handler(struct work_struct *work)
+{
+	struct ishtp_cl_data *client_data =
+		container_of(work, struct ishtp_cl_data, work_ec_evt);
+	struct cros_ec_device *ec_dev = client_data->ec_dev;
+
+	if (cros_ec_get_next_event(ec_dev, NULL) > 0) {
+		blocking_notifier_call_chain(&ec_dev->event_notifier,
+					     0, ec_dev);
+	}
+}
+
+/**
+ * ish_send() - Send message from host to firmware
+ * @client_data:	Client data instance
+ * @out_msg:		Message buffer to be sent to firmware
+ * @out_size:		Size of out going message
+ * @in_msg:		Message buffer where the incoming data copied.
+ *			This buffer is allocated by calling
+ * @in_size:		Max size of incoming message
+ *
+ * Return: Number of bytes copied in the in_msg on success, negative
+ * error code on failure.
+ */
+static int ish_send(struct ishtp_cl_data *client_data,
+		    u8 *out_msg, size_t out_size,
+		    u8 *in_msg, size_t in_size)
+{
+	int rv;
+	struct header *out_hdr = (struct header *)out_msg;
+	struct ishtp_cl *cros_ish_cl = client_data->cros_ish_cl;
+
+	dev_dbg(cl_data_to_dev(client_data),
+		"%s: channel=%02u status=%02u\n",
+		__func__, out_hdr->channel, out_hdr->status);
+
+	/* Setup for incoming response */
+	client_data->response.data = in_msg;
+	client_data->response.max_size = in_size;
+	client_data->response.error = 0;
+	client_data->response.received = false;
+
+	rv = ishtp_cl_send(cros_ish_cl, out_msg, out_size);
+	if (rv) {
+		dev_err(cl_data_to_dev(client_data),
+			"ishtp_cl_send error %d\n", rv);
+		return rv;
+	}
+
+	wait_event_interruptible_timeout(client_data->response.wait_queue,
+					 client_data->response.received,
+					 ISHTP_SEND_TIMEOUT);
+	if (!client_data->response.received) {
+		dev_err(cl_data_to_dev(client_data),
+			"Timed out for response to host message\n");
+		return -ETIMEDOUT;
+	}
+
+	if (client_data->response.error < 0)
+		return client_data->response.error;
+
+	return client_data->response.size;
+}
+
+/**
+ * process_recv() -	Received and parse incoming packet
+ * @cros_ish_cl:	Client instance to get stats
+ * @rb_in_proc:		Host interface message buffer
+ *
+ * Parse the incoming packet. If it is a response packet then it will
+ * update per instance flags and wake up the caller waiting to for the
+ * response. If it is an event packet then it will schedule event work.
+ */
+static void process_recv(struct ishtp_cl *cros_ish_cl,
+			 struct ishtp_cl_rb *rb_in_proc)
+{
+	size_t data_len = rb_in_proc->buf_idx;
+	struct ishtp_cl_data *client_data =
+		ishtp_get_client_data(cros_ish_cl);
+	struct cros_ish_in_msg *in_msg =
+		(struct cros_ish_in_msg *)rb_in_proc->buffer.data;
+
+	/* Proceed only if reset or init is not in progress */
+	if (!down_read_trylock(&init_lock)) {
+		dev_warn(cl_data_to_dev(client_data),
+			 "Host is not ready to receive incoming messages\n");
+		return;
+	}
+
+	/*
+	 * All firmware messages contain a header. Check the buffer size
+	 * before accessing elements inside.
+	 */
+	if (!rb_in_proc->buffer.data) {
+		dev_warn(cl_data_to_dev(client_data),
+			 "rb_in_proc->buffer.data returned null");
+		client_data->response.error = -EBADMSG;
+		goto end_error;
+	}
+
+	if (data_len < sizeof(struct header)) {
+		dev_err(cl_data_to_dev(client_data),
+			"data size %zu is less than header %zu\n",
+			data_len, sizeof(struct header));
+		client_data->response.error = -EMSGSIZE;
+		goto end_error;
+	}
+
+	dev_dbg(cl_data_to_dev(client_data),
+		"channel=%02u status=%02u\n",
+		in_msg->hdr.channel, in_msg->hdr.status);
+
+	switch (in_msg->hdr.channel) {
+	case CROS_EC_COMMAND:
+		/* Sanity check */
+		if (!client_data->response.data) {
+			dev_err(cl_data_to_dev(client_data),
+				"Receiving buffer is null. Should be allocated by calling function\n");
+			client_data->response.error = -EINVAL;
+			goto error_wake_up;
+		}
+
+		if (client_data->response.received) {
+			dev_err(cl_data_to_dev(client_data),
+				"Previous firmware message not yet processed\n");
+			client_data->response.error = -EINVAL;
+			goto error_wake_up;
+		}
+
+		if (data_len > client_data->response.max_size) {
+			dev_err(cl_data_to_dev(client_data),
+				"Received buffer size %zu is larger than allocated buffer %zu\n",
+				data_len, client_data->response.max_size);
+			client_data->response.error = -EMSGSIZE;
+			goto error_wake_up;
+		}
+
+		if (in_msg->hdr.status) {
+			dev_err(cl_data_to_dev(client_data),
+				"firmware returned status %d\n",
+				in_msg->hdr.status);
+			client_data->response.error = -EIO;
+			goto error_wake_up;
+		}
+
+		/* Update the actual received buffer size */
+		client_data->response.size = data_len;
+
+		/*
+		 * Copy the buffer received in firmware response for the
+		 * calling thread.
+		 */
+		memcpy(client_data->response.data,
+		       rb_in_proc->buffer.data, data_len);
+
+		/* Set flag before waking up the caller */
+		client_data->response.received = true;
+error_wake_up:
+		/* Wake the calling thread */
+		wake_up_interruptible(&client_data->response.wait_queue);
+
+		break;
+
+	case CROS_MKBP_EVENT:
+		/* The event system doesn't send any data in buffer */
+		schedule_work(&client_data->work_ec_evt);
+
+		break;
+
+	default:
+		dev_err(cl_data_to_dev(client_data),
+			"Invalid channel=%02d\n", in_msg->hdr.channel);
+	}
+
+end_error:
+	/* Free the buffer */
+	ishtp_cl_io_rb_recycle(rb_in_proc);
+	rb_in_proc = NULL;
+
+	up_read(&init_lock);
+}
+
+/**
+ * ish_event_cb() - bus driver callback for incoming
+ *			message
+ * @cl_device:		ISHTP client device for which this message is
+ *			targeted.
+ *
+ * Remove the packet from the list and process the message by calling
+ * process_recv.
+ */
+static void ish_event_cb(struct ishtp_cl_device *cl_device)
+{
+	struct ishtp_cl_rb *rb_in_proc;
+	struct ishtp_cl_data *client_data;
+	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
+
+	client_data = ishtp_get_client_data(cros_ish_cl);
+
+	while ((rb_in_proc = ishtp_cl_rx_get_rb(cros_ish_cl)) != NULL) {
+		/* Decide what to do with received data */
+		process_recv(cros_ish_cl, rb_in_proc);
+	}
+}
+
+/**
+ * cros_ish_init() - Init function for ISHTP client
+ * @cros_ish_cl:	ISHTP client instance
+ *
+ * This function complete the initializtion of the client.
+ *
+ * Return: 0 on success, non zero on error
+ */
+static int cros_ish_init(struct ishtp_cl *cros_ish_cl)
+{
+	int rv;
+	struct ishtp_device *dev;
+	struct ishtp_fw_client *fw_client;
+	struct ishtp_cl_data *client_data =
+		ishtp_get_client_data(cros_ish_cl);
+
+	rv = ishtp_cl_link(cros_ish_cl);
+	if (rv) {
+		dev_err(cl_data_to_dev(client_data),
+			"ishtp_cl_link failed\n");
+		return rv;
+	}
+
+	dev = ishtp_get_ishtp_device(cros_ish_cl);
+
+	/* Connect to firmware client */
+	ishtp_set_tx_ring_size(cros_ish_cl, CROS_ISH_CL_TX_RING_SIZE);
+	ishtp_set_rx_ring_size(cros_ish_cl, CROS_ISH_CL_RX_RING_SIZE);
+
+	fw_client = ishtp_fw_cl_get_client(dev, &cros_ish_guid);
+	if (!fw_client) {
+		dev_err(cl_data_to_dev(client_data),
+			"ish client uuid not found\n");
+		rv = -ENOENT;
+		goto err_cl_unlink;
+	}
+
+	ishtp_cl_set_fw_client_id(cros_ish_cl,
+				  ishtp_get_fw_client_id(fw_client));
+	ishtp_set_connection_state(cros_ish_cl, ISHTP_CL_CONNECTING);
+
+	rv = ishtp_cl_connect(cros_ish_cl);
+	if (rv) {
+		dev_err(cl_data_to_dev(client_data),
+			"client connect fail\n");
+		goto err_cl_unlink;
+	}
+
+	dev_dbg(cl_data_to_dev(client_data), "client connected\n");
+
+	ishtp_register_event_cb(client_data->cl_device, ish_event_cb);
+	return 0;
+
+err_cl_unlink:
+	ishtp_cl_unlink(cros_ish_cl);
+	return rv;
+}
+
+/**
+ * cros_ish_deinit() - Deinit function for ISHTP client
+ * @cros_ish_cl:	ISHTP client instance
+ *
+ * Unlink and free cros_ec client
+ */
+static void cros_ish_deinit(struct ishtp_cl *cros_ish_cl)
+{
+	ishtp_set_connection_state(cros_ish_cl, ISHTP_CL_DISCONNECTING);
+	ishtp_cl_disconnect(cros_ish_cl);
+	ishtp_cl_unlink(cros_ish_cl);
+	ishtp_cl_flush_queues(cros_ish_cl);
+
+	/* Disband and free all Tx and Rx client-level rings */
+	ishtp_cl_free(cros_ish_cl);
+}
+
+static int prepare_cros_ec_rx(struct cros_ec_device *ec_dev,
+			      const struct cros_ish_in_msg *in_msg,
+			      struct cros_ec_command *msg)
+{
+	u8 sum = 0;
+	int i, rv, offset;
+
+	/* Check response error code */
+	msg->result = in_msg->ec_response.result;
+	rv = cros_ec_check_result(ec_dev, msg);
+	if (rv < 0)
+		return rv;
+
+	if (in_msg->ec_response.data_len > msg->insize) {
+		dev_err(ec_dev->dev, "Packet too long (%d bytes, expected %d)",
+			in_msg->ec_response.data_len, msg->insize);
+		return -ENOSPC;
+	}
+
+	/* Copy response packet payload and compute checksum */
+	for (i = 0; i < sizeof(struct ec_host_response); i++)
+		sum += ((u8 *)in_msg)[IN_MSG_EC_RESPONSE_PREAMBLE + i];
+
+	offset = sizeof(struct cros_ish_in_msg);
+	for (i = 0; i < in_msg->ec_response.data_len; i++)
+		sum += msg->data[i] = ((u8 *)in_msg)[offset + i];
+
+	if (sum) {
+		dev_err(ec_dev->dev, "Bad received packet checksum %d\n", sum);
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
+static int cros_ec_pkt_xfer_ish(struct cros_ec_device *ec_dev,
+				struct cros_ec_command *msg)
+{
+	int rv;
+	struct ishtp_cl *cros_ish_cl = ec_dev->priv;
+	struct ishtp_cl_data *client_data =
+		ishtp_get_client_data(cros_ish_cl);
+	struct cros_ish_in_msg *in_msg =
+		(struct cros_ish_in_msg *)ec_dev->din;
+	struct cros_ish_out_msg *out_msg =
+		(struct cros_ish_out_msg *)ec_dev->dout;
+	size_t in_size = sizeof(struct cros_ish_in_msg) + msg->insize;
+	size_t out_size = sizeof(struct cros_ish_out_msg) + msg->outsize;
+
+	/* Proceed only if reset-init is not in progress */
+	if (!down_read_trylock(&init_lock)) {
+		dev_warn(cl_data_to_dev(client_data),
+			 "Host is not ready to send messages to ISH. Try again\n");
+		return -EAGAIN;
+	}
+
+	/* Sanity checks */
+	if (in_size > ec_dev->din_size) {
+		dev_err(cl_data_to_dev(client_data),
+			"Incoming payload size %zu is too large for ec_dev->din_size %d\n",
+			in_size, ec_dev->din_size);
+		return -EMSGSIZE;
+	}
+
+	if (out_size > ec_dev->dout_size) {
+		dev_err(cl_data_to_dev(client_data),
+			"Outgoing payload size %zu is too large for ec_dev->dout_size %d\n",
+			out_size, ec_dev->dout_size);
+		return -EMSGSIZE;
+	}
+
+	/* Prepare the package to be sent over ISH TP */
+	out_msg->hdr.channel = CROS_EC_COMMAND;
+	out_msg->hdr.status = 0;
+
+	ec_dev->dout += OUT_MSG_EC_REQUEST_PREAMBLE;
+	cros_ec_prepare_tx(ec_dev, msg);
+	ec_dev->dout -= OUT_MSG_EC_REQUEST_PREAMBLE;
+
+	dev_dbg(cl_data_to_dev(client_data),
+		"out_msg: struct_ver=0x%x checksum=0x%x command=0x%x command_ver=0x%x data_len=0x%x\n",
+		out_msg->ec_request.struct_version,
+		out_msg->ec_request.checksum,
+		out_msg->ec_request.command,
+		out_msg->ec_request.command_version,
+		out_msg->ec_request.data_len);
+
+	/* Send command to ISH EC firmware and read response */
+	rv = ish_send(client_data,
+		      (u8 *)out_msg, out_size,
+		      (u8 *)in_msg, in_size);
+	if (rv < 0)
+		goto end_error;
+
+	rv = prepare_cros_ec_rx(ec_dev, in_msg, msg);
+	if (rv)
+		goto end_error;
+
+	rv = in_msg->ec_response.data_len;
+
+	dev_dbg(cl_data_to_dev(client_data),
+		"in_msg: struct_ver=0x%x checksum=0x%x result=0x%x data_len=0x%x\n",
+		in_msg->ec_response.struct_version,
+		in_msg->ec_response.checksum,
+		in_msg->ec_response.result,
+		in_msg->ec_response.data_len);
+
+end_error:
+	if (msg->command == EC_CMD_REBOOT_EC)
+		msleep(EC_REBOOT_DELAY_MS);
+
+	up_read(&init_lock);
+
+	return rv;
+}
+
+static int cros_ec_dev_init(struct ishtp_cl_data *client_data)
+{
+	int rv;
+	struct cros_ec_device *ec_dev;
+	struct device *dev = cl_data_to_dev(client_data);
+
+	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
+	if (!ec_dev)
+		return -ENOMEM;
+
+	client_data->ec_dev = ec_dev;
+	dev->driver_data = ec_dev;
+
+	ec_dev->dev = dev;
+	ec_dev->priv = client_data->cros_ish_cl;
+	ec_dev->irq = 0;
+	ec_dev->cmd_xfer = NULL;
+	ec_dev->pkt_xfer = cros_ec_pkt_xfer_ish;
+	ec_dev->phys_name = dev_name(dev);
+	ec_dev->din_size = sizeof(struct cros_ish_in_msg) +
+			   sizeof(struct ec_response_get_protocol_info);
+	ec_dev->dout_size = sizeof(struct cros_ish_out_msg);
+
+	rv = cros_ec_register(ec_dev);
+	if (rv) {
+		dev_err(dev, "cannot register EC\n");
+		return rv;
+	}
+
+	return 0;
+}
+
+static void reset_handler(struct work_struct *work)
+{
+	int rv;
+	struct device *dev;
+	struct ishtp_cl_data *client_data;
+	struct ishtp_cl *cros_ish_cl;
+	struct ishtp_cl_device *cl_device;
+
+	client_data = container_of(work, struct ishtp_cl_data,
+				   work_ishtp_reset);
+
+	/* Lock for reset to complete */
+	down_write(&init_lock);
+
+	cros_ish_cl = client_data->cros_ish_cl;
+	cl_device = client_data->cl_device;
+
+	dev_dbg(cl_data_to_dev(client_data), "%s\n", __func__);
+
+	/* Unlink, flush queues & start again */
+	ishtp_cl_unlink(cros_ish_cl);
+	ishtp_cl_flush_queues(cros_ish_cl);
+	ishtp_cl_free(cros_ish_cl);
+
+	cros_ish_cl = ishtp_cl_allocate(cl_device);
+	if (!cros_ish_cl) {
+		up_write(&init_lock);
+		return;
+	}
+
+	ishtp_set_drvdata(cl_device, cros_ish_cl);
+	ishtp_set_client_data(cros_ish_cl, client_data);
+	client_data->cros_ish_cl = cros_ish_cl;
+
+	rv = cros_ish_init(cros_ish_cl);
+	if (rv) {
+		ishtp_cl_free(cros_ish_cl);
+		dev_err(cl_data_to_dev(client_data), "Reset Failed\n");
+		up_write(&init_lock);
+		return;
+	}
+
+	/* Refresh ec_dev device pointers */
+	client_data->ec_dev->priv = client_data->cros_ish_cl;
+	dev = cl_data_to_dev(client_data);
+	dev->driver_data = client_data->ec_dev;
+
+	dev_info(cl_data_to_dev(client_data), "Chrome EC ISH reset done\n");
+
+	up_write(&init_lock);
+}
+
+/**
+ * cros_ec_ishtp_probe() - ISHTP client driver probe callback
+ * @cl_device:		ISHTP client device instance
+ *
+ * Return: 0 on success, non zero on error
+ */
+static int cros_ec_ishtp_probe(struct ishtp_cl_device *cl_device)
+{
+	int rv;
+	struct ishtp_cl *cros_ish_cl;
+	struct ishtp_cl_data *client_data;
+
+	client_data = devm_kzalloc(ishtp_device(cl_device),
+				   sizeof(*client_data), GFP_KERNEL);
+	if (!client_data)
+		return -ENOMEM;
+
+	/* Lock for initialization to complete */
+	down_write(&init_lock);
+
+	cros_ish_cl = ishtp_cl_allocate(cl_device);
+	if (!cros_ish_cl) {
+		rv = -ENOMEM;
+		goto end_ishtp_cl_alloc_error;
+	}
+
+	ishtp_set_drvdata(cl_device, cros_ish_cl);
+	ishtp_set_client_data(cros_ish_cl, client_data);
+	client_data->cros_ish_cl = cros_ish_cl;
+	client_data->cl_device = cl_device;
+
+	init_waitqueue_head(&client_data->response.wait_queue);
+
+	INIT_WORK(&client_data->work_ishtp_reset,
+		  reset_handler);
+	INIT_WORK(&client_data->work_ec_evt,
+		  ish_evt_handler);
+
+	rv = cros_ish_init(cros_ish_cl);
+	if (rv)
+		goto end_ishtp_cl_init_error;
+
+	ishtp_get_device(cl_device);
+
+	up_write(&init_lock);
+
+	/* Register croc_ec_dev mfd */
+	rv = cros_ec_dev_init(client_data);
+	if (rv)
+		goto end_cros_ec_dev_init_error;
+
+	return 0;
+
+end_cros_ec_dev_init_error:
+	ishtp_set_connection_state(cros_ish_cl, ISHTP_CL_DISCONNECTING);
+	ishtp_cl_disconnect(cros_ish_cl);
+	ishtp_put_device(cl_device);
+	cros_ish_deinit(cros_ish_cl);
+	return rv;
+
+end_ishtp_cl_init_error:
+	ishtp_cl_free(cros_ish_cl);
+end_ishtp_cl_alloc_error:
+	up_write(&init_lock);
+	return rv;
+}
+
+/**
+ * cros_ec_ishtp_remove() - ISHTP client driver remove callback
+ * @cl_device:		ISHTP client device instance
+ *
+ * Return: 0
+ */
+static int cros_ec_ishtp_remove(struct ishtp_cl_device *cl_device)
+{
+	struct ishtp_cl_data *client_data;
+	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
+
+	client_data = ishtp_get_client_data(cros_ish_cl);
+
+	cancel_work_sync(&client_data->work_ishtp_reset);
+	cancel_work_sync(&client_data->work_ec_evt);
+	ishtp_set_connection_state(cros_ish_cl, ISHTP_CL_DISCONNECTING);
+	ishtp_cl_disconnect(cros_ish_cl);
+	ishtp_put_device(cl_device);
+	cros_ish_deinit(cros_ish_cl);
+
+	return 0;
+}
+
+/**
+ * cros_ec_ishtp_reset() - ISHTP client driver reset callback
+ * @cl_device:		ISHTP client device instance
+ *
+ * Return: 0
+ */
+static int cros_ec_ishtp_reset(struct ishtp_cl_device *cl_device)
+{
+	struct ishtp_cl_data *client_data;
+	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
+
+	client_data = ishtp_get_client_data(cros_ish_cl);
+
+	schedule_work(&client_data->work_ishtp_reset);
+
+	return 0;
+}
+
+/**
+ * cros_ec_ishtp_suspend() - ISHTP client driver suspend callback
+ * @device:	device instance
+ *
+ * Return: 0 for success, negative error code for failure.
+ */
+static int __maybe_unused cros_ec_ishtp_suspend(struct device *device)
+{
+	struct ishtp_cl_data *client_data;
+	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
+	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
+
+	client_data = ishtp_get_client_data(cros_ish_cl);
+
+	return cros_ec_suspend(client_data->ec_dev);
+}
+
+/**
+ * cros_ec_ishtp_resume() - ISHTP client driver resume callback
+ * @device:	device instance
+ *
+ * Return: 0 for success, negative error code for failure.
+ */
+static int __maybe_unused cros_ec_ishtp_resume(struct device *device)
+{
+	struct ishtp_cl_data *client_data;
+	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
+	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
+
+	client_data = ishtp_get_client_data(cros_ish_cl);
+
+	return cros_ec_resume(client_data->ec_dev);
+}
+
+static SIMPLE_DEV_PM_OPS(cros_ec_ishtp_pm_ops, cros_ec_ishtp_suspend,
+			 cros_ec_ishtp_resume);
+
+static struct ishtp_cl_driver	cros_ec_ishtp_driver = {
+	.name = "cros_ec_ishtp",
+	.guid = &cros_ish_guid,
+	.probe = cros_ec_ishtp_probe,
+	.remove = cros_ec_ishtp_remove,
+	.reset = cros_ec_ishtp_reset,
+	.driver = {
+		.pm = &cros_ec_ishtp_pm_ops,
+	},
+};
+
+static int __init cros_ec_ishtp_mod_init(void)
+{
+	return ishtp_cl_driver_register(&cros_ec_ishtp_driver, THIS_MODULE);
+}
+
+static void __exit cros_ec_ishtp_mod_exit(void)
+{
+	ishtp_cl_driver_unregister(&cros_ec_ishtp_driver);
+}
+
+late_initcall(cros_ec_ishtp_mod_init);
+module_exit(cros_ec_ishtp_mod_exit);
+
+MODULE_DESCRIPTION("ChromeOS EC ISHTP Client Driver");
+MODULE_AUTHOR("Rushikesh S Kadam <rushikesh.s.kadam@intel.com>");
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("ishtp:*");
-- 
1.9.1

