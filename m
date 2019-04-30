Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA82C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F9820835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfD3JZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:25:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfD3JZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:25:50 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hLP1I-0007Sc-4i; Tue, 30 Apr 2019 09:25:48 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 1/2] Bluetooth: Disable LE Advertising in hci_suspend_dev()
Date:   Tue, 30 Apr 2019 17:25:43 +0800
Message-Id: <20190430092544.13653-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LE Advertising may wake up system during system-wide sleep, disable it
to prevent this issue from happening.

Do the reverse in hci_resume_dev().

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Abstract away enabling/disabling LE advertising from btusb.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 47 ++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 094e61e07030..65574943131d 100644
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
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6b2540ba7f8..7c19e3b9294c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -412,6 +412,49 @@ static void hci_setup_event_mask(struct hci_request *req)
 	hci_req_add(req, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
 }
 
+static int hci_enable_le_advertising_req(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+	u8 events[8];
+	memcpy(events, hdev->le_events, sizeof(events));
+
+	hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
+			events);
+
+	return 0;
+}
+
+static int hci_disable_le_advertising_req(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	u8 events[8];
+	memcpy(events, hdev->le_events, sizeof(events));
+
+	events[0] &= ~(u8)0x02;	/* LE Advertising Report */
+
+	hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
+			events);
+
+	return 0;
+}
+
+static int hci_enable_le_advertising(struct hci_dev *hdev)
+{
+	if (!lmp_le_capable(hdev))
+		return 0;
+
+	return __hci_req_sync(hdev, hci_enable_le_advertising_req, 0, HCI_CMD_TIMEOUT, NULL);
+}
+
+static int hci_disable_le_advertising(struct hci_dev *hdev)
+{
+	if (!lmp_le_capable(hdev))
+		return 0;
+
+	return __hci_req_sync(hdev, hci_disable_le_advertising_req, 0, HCI_CMD_TIMEOUT, NULL);
+}
+
 static int hci_init2_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -772,6 +815,8 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 		}
 
 		hci_set_le_support(req);
+
+		memcpy(hdev->le_events, events, sizeof(events));
 	}
 
 	/* Read features beyond page 1 if available */
@@ -3431,6 +3476,7 @@ EXPORT_SYMBOL(hci_unregister_dev);
 /* Suspend HCI device */
 int hci_suspend_dev(struct hci_dev *hdev)
 {
+	hci_disable_le_advertising(hdev);
 	hci_sock_dev_event(hdev, HCI_DEV_SUSPEND);
 	return 0;
 }
@@ -3440,6 +3486,7 @@ EXPORT_SYMBOL(hci_suspend_dev);
 int hci_resume_dev(struct hci_dev *hdev)
 {
 	hci_sock_dev_event(hdev, HCI_DEV_RESUME);
+	hci_enable_le_advertising(hdev);
 	return 0;
 }
 EXPORT_SYMBOL(hci_resume_dev);
-- 
2.17.1

