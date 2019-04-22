Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65722C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3975820685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfDVJUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:20:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34254 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfDVJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:20:41 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hIV7u-00027X-Pv; Mon, 22 Apr 2019 09:20:39 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] Bluetooth: Add helpers to enable or disable LE Advertising
Date:   Mon, 22 Apr 2019 17:20:33 +0800
Message-Id: <20190422092034.21461-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helpers to enable or disable LE Advertising.
To be used by later patch.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 include/net/bluetooth/hci_core.h |  3 ++
 net/bluetooth/hci_core.c         | 47 ++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5ea633ea368..ef92dd12f816 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -269,6 +269,7 @@ struct hci_dev {
 	__u16		le_max_rx_time;
 	__u8		le_max_key_size;
 	__u8		le_min_key_size;
+	__u8		le_events[8];
 	__u16		discov_interleaved_timeout;
 	__u16		conn_info_min_age;
 	__u16		conn_info_max_age;
@@ -1141,6 +1142,8 @@ void hci_init_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
+int hci_enable_le_advertising(struct hci_dev *hdev);
+int hci_disable_le_advertising(struct hci_dev *hdev);
 
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7352fe85674b..0bed66908588 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -411,6 +412,53 @@ static void hci_setup_event_mask(struct hci_request *req)
 	hci_req_add(req, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
 }
 
+static int hci_enable_le_advertising_req(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+	u8 events[8];
+
+	memcpy(events, hdev->le_events, sizeof(events));
+
+	hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
+		    events);
+
+	return 0;
+}
+
+static int hci_disable_le_advertising_req(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	u8 events[8];
+
+	memcpy(events, hdev->le_events, sizeof(events));
+
+	events[0] &= ~(u8)0x02;	/* LE Advertising Report */
+
+	hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
+		    events);
+
+	return 0;
+}
+
+int hci_enable_le_advertising(struct hci_dev *hdev)
+{
+	if (!lmp_le_capable(hdev))
+		return 0;
+
+	return __hci_req_sync(hdev, hci_enable_le_advertising_req, 0, HCI_CMD_TIMEOUT, NULL);
+}
+EXPORT_SYMBOL(hci_enable_le_advertising);
+
+int hci_disable_le_advertising(struct hci_dev *hdev)
+{
+	if (!lmp_le_capable(hdev))
+		return 0;
+
+	return __hci_req_sync(hdev, hci_disable_le_advertising_req, 0, HCI_CMD_TIMEOUT, NULL);
+}
+EXPORT_SYMBOL(hci_disable_le_advertising);
+
 static int hci_init2_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -771,6 +818,8 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 		}
 
 		hci_set_le_support(req);
+
+		memcpy(hdev->le_events, events, sizeof(events));
 	}
 
 	/* Read features beyond page 1 if available */
-- 
2.17.1

