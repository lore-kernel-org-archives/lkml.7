Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE47C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755F820862
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SGfrsyY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfEUTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:53:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41961 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfEUTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:53:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id f12so8923023plt.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5en3B87zK/4VazsqiZmHLFO6MbzLjXfyqWcOx9dZCE=;
        b=SGfrsyY74QwS05AVbYOjGpC44seW+JDzir2e90yqgIHn6nkk1qt1Xgn5NuVf86chmu
         ZKECyamxsNo1fzenvO30dSJ1UlgXe75BEic8go4uqLhdYh2MZLYI2/w97m87FQSb6wZa
         pbY7AY5LokSXXmpxAnRoRrW/hLXDWESToREgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5en3B87zK/4VazsqiZmHLFO6MbzLjXfyqWcOx9dZCE=;
        b=kITIm1/bejzVSMSqz85I+lgwF4QuBZDKWLsTIbEdcH2Kmg8JD+ZQFKbVU/NP6/D+sa
         9WbQPSIV6Ai8Q9enWeK0nRBDK5M+2ehlSVHALFVbgfQovyd06h9PJvmFdPxoq75ToeOb
         KqH9GLGEzqYYq9Gn8YgTy1zpqumOF36Zx/+S7IX43OcplZKasWo+tCffvFj6QWxGaWYh
         3e2vlwrND38bwMyEEdRRI1D5QkRI9n15EQWVw7/j+KLIsZQVLWWsNchKMN5xmtC5Udyw
         Nq0/LeFuyfSFKnFd4fidE4QR2t/W9rSxOcBrn6Gspi0oY/D1lDE0lwphZbtpjwe6OVMS
         W+3g==
X-Gm-Message-State: APjAAAX/zJ3Qp8DDuUDI/+HaU4Qn/uR4e09sNJpSl4IOI6qbGEtJ1+9n
        XHGgt9/i1fxbbC3qM9XYnSahTg==
X-Google-Smtp-Source: APXvYqx1uHAyfmTOdXedq2iAytyQ25gZxc1C0b8FHp+XHNHralWXboo5bCfsatnW8dqRglswYU+gyw==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr35751651plz.242.1558468392056;
        Tue, 21 May 2019 12:53:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s77sm43723346pfa.63.2019.05.21.12.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:53:11 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4] Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event
Date:   Tue, 21 May 2019 12:53:07 -0700
Message-Id: <20190521195307.23874-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
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
Changes in v4:
- limit the fix to WCN3990 instead of applying it to all WCN399x.
  Harish Bandi <c-hbandi@codeaurora.org> reported frame reassembly
  errors with WCN3998 and v3. At this point it is unknown in how far
  WCN3998 behaves different from WCN3990, we can revisit
  it later if it turns that it has the same problem.

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
 drivers/bluetooth/hci_qca.c | 55 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 57322c42bb2d..09d03783d2cd 100644
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
@@ -1123,6 +1157,11 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		if (qca_is_wcn399x(soc_type))
 			hci_uart_set_flow_control(hu, true);
 
+		if (soc_type == QCA_WCN3990) {
+			reinit_completion(&qca->drop_ev_comp);
+			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
+		}
+
 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
 		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
@@ -1134,6 +1173,20 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 error:
 		if (qca_is_wcn399x(soc_type))
 			hci_uart_set_flow_control(hu, false);
+
+		if (soc_type == QCA_WCN3990) {
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
2.21.0.1020.gf2820cf01a-goog

