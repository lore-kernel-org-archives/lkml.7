Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE7620684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nNz7CBxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfCGAlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:41:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41457 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfCGAlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:41:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id d25so9983708pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MthmIBJFwwjcmfi1mqDbs2C1CNaXAwGGv8neZZfCz18=;
        b=nNz7CBxV06a4YhD0Cf+C/tC4pov2TuTIyH3Su1sgjZr+v0SXKMehF7AF7LqaJFN1QE
         kItSnoiPjVbVbmiSlWaSYUieZ3XWkGtWxReAzbuzgYrbkKHTUPZhqmB1zg2d8IiZhivq
         JIrqsWcVj9+RXAuWbmaGH1NPap5tkQBKyfjE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MthmIBJFwwjcmfi1mqDbs2C1CNaXAwGGv8neZZfCz18=;
        b=glZ720hN5wGS7awNPbYsW1AzVK4XP+2b4rnY31gjzK+FiPqxTANGF0RAUhN0eKxuqO
         lFf9iJjFGzMJp5+skRmZMUAbjVcm1Iy6tWIaDBJlNFjRjxCL42jR/4evy/BwPKsmI4Q9
         b9d4WzzK0yVCPlYYUkToeZEmFfZzlNFU2mjipWpzkaKc1kVbr8UBVFeiez/2NEh2n+jy
         oT9/UUKgw6f9yVhWUxp3qSINwUCngP+u/Z/S5ir62twLlPhUBWpPmcDKeUdQbbKhscRN
         Fq+P8bpNAlnL75VqkSjxM0mkpj5VRo3Av/2ZUf+59YfP++xnqtWPnXw4PbUyCv6eIK/B
         eBhw==
X-Gm-Message-State: APjAAAXJuyFoj0M86B6qe2fs5FT/EtseUcjsXLxuQfcbjdaf3VnCa6N9
        f1zvTAX9W/NYCvcAMEQZDKD0Aw==
X-Google-Smtp-Source: APXvYqyJB6DSL7PVApjNuCSex4T2W7mcBkCjz2GGpfsjDhKKY/4WLvm7MW34X3NIHKe/JlU+oeL2RQ==
X-Received: by 2002:aa7:918b:: with SMTP id x11mr10476498pfa.228.1551919261979;
        Wed, 06 Mar 2019 16:41:01 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o76sm8361985pfa.156.2019.03.06.16.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:41:01 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event
Date:   Wed,  6 Mar 2019 16:40:41 -0800
Message-Id: <20190307004041.38059-3-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190307004041.38059-1-mka@chromium.org>
References: <20190307004041.38059-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware download to the WCN3990 often fails with a 'TLV response size
mismatch' error:

[  133.064659] Bluetooth: hci0: setting up wcn3990
[  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
[  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
[  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)

This is caused by a vendor event that corresponds to an earlier command
to change the baudrate. The event is not processed in the context of the
baudrate change and later interpreted as response to the firmware
download command (which is also a vendor command), but the driver detects
that the event doesn't have the expected amount of associated data.

More details:

For the WCN3990 the vendor command for a baudrate change isn't sent as
synchronous HCI command, because the controller sends the corresponding
vendor event with the new baudrate. The event is received and decoded
after the baudrate change of the host port.

Identify the 'unused' event when it is received and don't add it to
the queue of RX frames.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 54 ++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ab8e59419dbc4..565681a6a1167 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -30,6 +30,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -55,6 +56,7 @@
 #define HCI_MAX_IBS_SIZE	10
 
 #define QCA_IN_BAND_SLEEP_ENABLED	BIT(0)
+#define QCA_DROP_VENDOR_EVENT		BIT(1)
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
@@ -108,6 +110,7 @@ struct qca_data {
 	struct work_struct ws_rx_vote_off;
 	struct work_struct ws_tx_vote_off;
 	unsigned long flags;
+	struct completion drop_ev_comp;
 
 	/* For debugging purpose */
 	u64 ibs_sent_wacks;
@@ -474,6 +477,7 @@ static int qca_open(struct hci_uart *hu)
 	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
 
 	qca->hu = hu;
+	init_completion(&qca->drop_ev_comp);
 
 	/* Assume we start with both sides asleep -- extra wakes OK */
 	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
@@ -866,6 +870,33 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
+static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+
+	if (test_bit(QCA_DROP_VENDOR_EVENT, &qca->flags)) {
+		struct hci_event_hdr *hdr = (void *)skb->data;
+
+		/* For the WCN3990 the vendor command for a baudrate change
+		 * isn't sent as synchronous HCI command, because the
+		 * controller sends the corresponding vendor event with the
+		 * new baudrate. The event is received and properly decoded
+		 * after changing the baudrate of the host port. It needs to
+		 * be dropped, otherwise it can be mis-interpreted as
+		 * response to a later firmware download command (also a
+		 * vendor command).
+		 */
+
+		if (hdr->evt == HCI_EV_VENDOR)
+			complete(&qca->drop_ev_comp);
+
+		return 0;
+	}
+
+	return hci_recv_frame(hdev, skb);
+}
+
 #define QCA_IBS_SLEEP_IND_EVENT \
 	.type = HCI_IBS_SLEEP_IND, \
 	.hlen = 0, \
@@ -890,7 +921,7 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
 static const struct h4_recv_pkt qca_recv_pkts[] = {
 	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
 	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
-	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
+	{ H4_RECV_EVENT,           .recv = qca_recv_event    },
 	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
 	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
 	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
@@ -1091,6 +1122,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
 	struct qca_serdev *qcadev;
+	struct qca_data *qca = hu->priv;
 	int ret = 0;
 
 	if (speed_type == QCA_INIT_SPEED) {
@@ -1106,8 +1138,11 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		 * changing the baudrate of chip and host.
 		 */
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (qcadev->btsoc_type == QCA_WCN3990) {
 			hci_uart_set_flow_control(hu, true);
+			reinit_completion(&qca->drop_ev_comp);
+			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+		}
 
 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
@@ -1118,8 +1153,21 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		host_set_baudrate(hu, speed);
 
 error:
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (qcadev->btsoc_type == QCA_WCN3990) {
 			hci_uart_set_flow_control(hu, false);
+
+			/* Wait for the controller to send the vendor event
+			 * for the baudrate change command.
+			 */
+			if (!wait_for_completion_timeout(&qca->drop_ev_comp,
+						 msecs_to_jiffies(100))) {
+				bt_dev_err(hu->hdev,
+					   "Failed to change controller baudrate\n");
+				ret = -EPROTO;
+			}
+
+			clear_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+		}
 	}
 
 	return ret;
-- 
2.21.0.352.gf09ad66450-goog

