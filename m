Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB52DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B99A2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xh8dh4Iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfD2XVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:21:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43454 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbfD2XVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:21:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so2889795pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ys873ywirGVfMT/YCEKzYxLu+4Erwu9Uma7Wucmwrc=;
        b=Xh8dh4IvtF54cPcYGuQeZw/ARvY4ffReUSCe2yhSayUn6Th8Nzdq85Oa52evHtodTs
         xpCQc0DCFVTIkSExmfJNGP7IF05afUxqbgMVp4A5VjG3NgvKnqZrgEJiGerqbLkO4sLR
         GWJ9WHULiVJfb81+748xa1ORn3dLNGHcs2GvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ys873ywirGVfMT/YCEKzYxLu+4Erwu9Uma7Wucmwrc=;
        b=oLj2xDYBW9yT7qHGQwhJlrb3KSgYfcqixMHjVZo5peb5xnpJ07ZS57CxmfjDfbi3DI
         RM9aPhpunPsmG0YePyygiQX4MNOD13i7UXf53vUpE0xl5xpxYaFdk6zWcWEQiTRBcoLY
         U1Mn6txSc6YTQRl5/JNOpphmd3y96ctwpdjUskHckfcJ8NapEw7LjcNCxFV6GzFGU9NA
         4q5C4eL5qUPZWaMDWx4/mAms32SjqndWyAfahOjofXqUiUEEgF3XTJNK2Pwzfvle8Q7n
         lweP8r4fv+UTtAMGClFlx7twDu1pUeTcsyQ5sDk8+7t0VqdagdTz9MaGEA0TR1IuXrHO
         Ympg==
X-Gm-Message-State: APjAAAWtWn1sIEw+Vy9jLEJLHNdaAWz3/Hf90eWC6HTVDV6hvqYwJ52K
        9PVtth9k1ujljfjdAZVHr2gke7mqKJEx3w==
X-Google-Smtp-Source: APXvYqxPN02VaHUGyZ+ycgCAtKUqfeCgjXAsMnONg6Gddqweu4Nh87Gm6+1s8Rwsy+kqaGv0VuMkcg==
X-Received: by 2002:a65:6546:: with SMTP id a6mr17911552pgw.5.1556580102327;
        Mon, 29 Apr 2019 16:21:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g4sm57880688pfc.75.2019.04.29.16.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 16:21:41 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event
Date:   Mon, 29 Apr 2019 16:21:31 -0700
Message-Id: <20190429232131.183049-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190429232131.183049-1-mka@chromium.org>
References: <20190429232131.183049-1-mka@chromium.org>
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
baudrate change and is later interpreted as response to the firmware
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
Changes in v3:
- rebased on latest bluetooth-next/master
- removed barrier calls again, bit routines include barriers

Changes in v2:
- make QCA_DROP_VENDOR_EVENT an enum value and don't use BIT()
- free skb in qca_recv_event()
- add barriers to ensure qca_recv_event() sees updated flags
- return -ETIMEDOUT instead of -EPROTO if the vendor event isn't
  received in time
---
 drivers/bluetooth/hci_qca.c | 56 +++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 57322c42bb2d..5b57d897d8b5 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -30,6 +30,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -66,6 +67,7 @@
 
 enum qca_flags {
 	QCA_IBS_ENABLED,
+	QCA_DROP_VENDOR_EVENT,
 };
 
 /* HCI_IBS transmit side sleep protocol states */
@@ -110,6 +112,7 @@ struct qca_data {
 	struct work_struct ws_rx_vote_off;
 	struct work_struct ws_tx_vote_off;
 	unsigned long flags;
+	struct completion drop_ev_comp;
 
 	/* For debugging purpose */
 	u64 ibs_sent_wacks;
@@ -491,6 +494,7 @@ static int qca_open(struct hci_uart *hu)
 	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
 
 	qca->hu = hu;
+	init_completion(&qca->drop_ev_comp);
 
 	/* Assume we start with both sides asleep -- extra wakes OK */
 	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
@@ -885,6 +889,35 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
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
+		 * be dropped, otherwise it can be misinterpreted as
+		 * response to a later firmware download command (also a
+		 * vendor command).
+		 */
+
+		if (hdr->evt == HCI_EV_VENDOR)
+			complete(&qca->drop_ev_comp);
+
+		kfree(skb);
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
@@ -909,7 +942,7 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
 static const struct h4_recv_pkt qca_recv_pkts[] = {
 	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
 	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
-	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
+	{ H4_RECV_EVENT,           .recv = qca_recv_event    },
 	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
 	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
 	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
@@ -1104,6 +1137,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
+	struct qca_data *qca = hu->priv;
 	int ret = 0;
 
 	if (speed_type == QCA_INIT_SPEED) {
@@ -1120,8 +1154,11 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		/* Disable flow control for wcn3990 to deassert RTS while
 		 * changing the baudrate of chip and host.
 		 */
-		if (qca_is_wcn399x(soc_type))
+		if (qca_is_wcn399x(soc_type)) {
 			hci_uart_set_flow_control(hu, true);
+			reinit_completion(&qca->drop_ev_comp);
+			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+		}
 
 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
@@ -1132,8 +1169,21 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		host_set_baudrate(hu, speed);
 
 error:
-		if (qca_is_wcn399x(soc_type))
+		if (qca_is_wcn399x(soc_type)) {
 			hci_uart_set_flow_control(hu, false);
+
+			/* Wait for the controller to send the vendor event
+			 * for the baudrate change command.
+			 */
+			if (!wait_for_completion_timeout(&qca->drop_ev_comp,
+						 msecs_to_jiffies(100))) {
+				bt_dev_err(hu->hdev,
+					   "Failed to change controller baudrate\n");
+				ret = -ETIMEDOUT;
+			}
+
+			clear_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+		}
 	}
 
 	return ret;
-- 
2.21.0.593.g511ec345e18-goog

