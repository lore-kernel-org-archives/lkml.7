Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ACAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67C0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LwNUNNBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCLUm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:42:27 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41621 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfCLUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:42:24 -0400
Received: by mail-yw1-f68.google.com with SMTP id q128so3260097ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=JaK612gvyyoT3yWBLZqVv+dEIOvgi622j5LSc4aZqvg=;
        b=LwNUNNBM8mbs1Al3k0l1dg0rJYf6Fn5LgbHrwmQZAj7ak3jgoQgoYL2xUZzukrvfF0
         kLi+Oq3DCy3zD51RBDnEUmMw/3YQmb3VnL+2OoPrUOMB5C2+LzQ6Fg7r7xIRldglTBFS
         YGdFH/JgrZRma9g/VznL/L7K3IhnvBLP3BXT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=JaK612gvyyoT3yWBLZqVv+dEIOvgi622j5LSc4aZqvg=;
        b=kMdxjRSd2Ao6gtZ7N3aHNlCi/TLQ6focpakq2aazmcQmFiFVLgSzZ4BZyGAkCeLkmi
         lxoBN16lUS3N5i9VH34QLylfuSIWJz0yr+xMGHXIZnmjIKbbE3yn61xXNNLFMEq52M6f
         15fctHP6p+hreI3W/otYUPRQYrzKWS9SXMj1sHLYKGqW8LuRo9mAXWDydPNUdgx/LQ0S
         Hqf+RMeHH004tdWekzaHDhTnB8edRCZSub400aPb/WS2b41mfm3w3dcnusIQyyhAK7LK
         99DdniKSSkCKN3rtRJ4moQI5gv66xaCKb1kZSTo6tr5hCH1W/e1alG0iQlqUdpQ4neki
         z2QQ==
X-Gm-Message-State: APjAAAXy/VC8wZiHUWsESfzQvQjQsfXsixpeYht0BOdeV8TMtKbRo5Ff
        yCNj1jsEwVxiR97ktoUoNSvizDqYBTo0utXZHFl0eg==
X-Google-Smtp-Source: APXvYqz01//9rVtPNsDTeZImG88H7MIMNeMEgAJlBuFGNMSulTJys6C5Lb2JQ3lop7mEx8IX1IFAz1Pn2KXfOwSgLyA=
X-Received: by 2002:a81:2f03:: with SMTP id v3mr31701857ywv.136.1552423343453;
 Tue, 12 Mar 2019 13:42:23 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Mar 2019 13:42:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190312204217.73296-1-mka@chromium.org>
References: <20190312204217.73296-1-mka@chromium.org>
MIME-Version: 1.0
Date:   Tue, 12 Mar 2019 13:42:22 -0700
Message-ID: <CAG5bF+S1u5T+E_zEh4=FUZ1c6LC3k+8LiqMedCFCAEdOq7q7Jw@mail.gmail.com>
Subject: [PATCH v2 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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
Changes in v2:
- make QCA_DROP_VENDOR_EVENT an enum value and don't use BIT()
- free skb in qca_recv_event()
- add barriers to ensure qca_recv_event() sees updated flags
- return -ETIMEDOUT instead of -EPROTO if the vendor event isn't
  received in time
---
 drivers/bluetooth/hci_qca.c | 58 +++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1b7ba9e9e08a..99963ec4f565 100644
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
 	QCA_IN_BAND_SLEEP_ENABLED,
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
@@ -476,6 +479,7 @@ static int qca_open(struct hci_uart *hu)
 	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);

 	qca->hu = hu;
+	init_completion(&qca->drop_ev_comp);

 	/* Assume we start with both sides asleep -- extra wakes OK */
 	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
@@ -868,6 +872,35 @@ static int qca_recv_acl_data(struct hci_dev
*hdev, struct sk_buff *skb)
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
@@ -892,7 +925,7 @@ static int qca_recv_acl_data(struct hci_dev *hdev,
struct sk_buff *skb)
 static const struct h4_recv_pkt qca_recv_pkts[] = {
 	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
 	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
-	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
+	{ H4_RECV_EVENT,           .recv = qca_recv_event    },
 	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
 	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
 	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
@@ -1093,6 +1126,7 @@ static int qca_set_speed(struct hci_uart *hu,
enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
 	struct qca_serdev *qcadev;
+	struct qca_data *qca = hu->priv;
 	int ret = 0;

 	if (speed_type == QCA_INIT_SPEED) {
@@ -1108,8 +1142,12 @@ static int qca_set_speed(struct hci_uart *hu,
enum qca_speed_type speed_type)
 		 * changing the baudrate of chip and host.
 		 */
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (qcadev->btsoc_type == QCA_WCN3990) {
 			hci_uart_set_flow_control(hu, true);
+			reinit_completion(&qca->drop_ev_comp);
+			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+			smp_mb__after_atomic();
+		}

 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
@@ -1120,8 +1158,22 @@ static int qca_set_speed(struct hci_uart *hu,
enum qca_speed_type speed_type)
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
+				ret = -ETIMEDOUT;
+			}
+
+			clear_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+			smp_mb__after_atomic();
+		}
 	}

 	return ret;
-- 
2.21.0.360.g471c308f928-goog
