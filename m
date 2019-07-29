Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EE0C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C90A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbfG2MWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbfG2MWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:22:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69DD94E83E;
        Mon, 29 Jul 2019 12:22:41 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.43.2.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D39B4600F8;
        Mon, 29 Jul 2019 12:22:37 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     marcel@holtmann.org
Cc:     bgodavar@codeaurora.org, frederic.danis@linux.intel.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.poulain@intel.com,
        suraj@atheros.com, syzkaller@googlegroups.com, vdronov@redhat.com
Subject: [PATCH v3] Bluetooth: hci_uart: check for missing tty operations
Date:   Mon, 29 Jul 2019 14:22:15 +0200
Message-Id: <20190729122215.9948-1-vdronov@redhat.com>
In-Reply-To: <62A82405-46E2-4921-BA52-D1660FC2DDDB@holtmann.org>
References: <62A82405-46E2-4921-BA52-D1660FC2DDDB@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 29 Jul 2019 12:22:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain ttys operations (pty_unix98_ops) lack tiocmget() and tiocmset()
functions which are called by the certain HCI UART protocols (hci_ath,
hci_bcm, hci_intel, hci_mrvl, hci_qca) via hci_uart_set_flow_control()
or directly. This leads to an execution at NULL and can be triggered by
an unprivileged user. Fix this by adding a helper function and a check
for the missing tty operations in the protocols code.

This fixes CVE-2019-10207. The Fixes: lines list commits where calls to
tiocm[gs]et() or hci_uart_set_flow_control() were added to the HCI UART
protocols.

Link: https://syzkaller.appspot.com/bug?id=1b42faa2848963564a5b1b7f8c837ea7b55ffa50
Reported-by: syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org # v2.6.36+
Fixes: b3190df62861 ("Bluetooth: Support for Atheros AR300x serial chip")
Fixes: 118612fb9165 ("Bluetooth: hci_bcm: Add suspend/resume PM functions")
Fixes: ff2895592f0f ("Bluetooth: hci_intel: Add Intel baudrate configuration support")
Fixes: 162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")
Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---

out-of-commit-message-note:

it is possible that a HCI UART protocol uses serial device's
operations and not a tty ones. i made hci_uart_has_flow_control() to
check this also, hence the name. serial device's code checks if
the needed operations are present itself.

i believe, hci_h5 does not need this check, as it uses serial device
functions only (as of now):

    serdev_device_set_flow_control(h5->hu->serdev, false);
    serdev_device_set_baudrate(h5->hu->serdev, 115200);

 drivers/bluetooth/hci_ath.c   | 3 +++
 drivers/bluetooth/hci_bcm.c   | 3 +++
 drivers/bluetooth/hci_intel.c | 3 +++
 drivers/bluetooth/hci_ldisc.c | 7 +++++++
 drivers/bluetooth/hci_mrvl.c  | 3 +++
 drivers/bluetooth/hci_qca.c   | 3 +++
 drivers/bluetooth/hci_uart.h  | 1 +
 7 files changed, 23 insertions(+)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index a55be205b91a..dbfe34664633 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -98,6 +98,9 @@ static int ath_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	if (!hci_uart_has_flow_control(hu))
+		return -EOPNOTSUPP;
+
 	ath = kzalloc(sizeof(*ath), GFP_KERNEL);
 	if (!ath)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 8905ad2edde7..ae2624fce913 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -406,6 +406,9 @@ static int bcm_open(struct hci_uart *hu)
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
+	if (!hci_uart_has_flow_control(hu))
+		return -EOPNOTSUPP;
+
 	bcm = kzalloc(sizeof(*bcm), GFP_KERNEL);
 	if (!bcm)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 207bae5e0d46..31f25153087d 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -391,6 +391,9 @@ static int intel_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	if (!hci_uart_has_flow_control(hu))
+		return -EOPNOTSUPP;
+
 	intel = kzalloc(sizeof(*intel), GFP_KERNEL);
 	if (!intel)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 8950e07889fe..11049e2336f3 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -292,6 +292,13 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+/* Check the underlying device or tty has flow control support */
+bool hci_uart_has_flow_control(struct hci_uart *hu)
+{
+	return hu->serdev ||
+		(hu->tty->driver->ops->tiocmget && hu->tty->driver->ops->tiocmset);
+}
+
 /* Flow control or un-flow control the device */
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 {
diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index f98e5cc343b2..fbc3f7c3a5c7 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -59,6 +59,9 @@ static int mrvl_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	if (!hci_uart_has_flow_control(hu))
+		return -EOPNOTSUPP;
+
 	mrvl = kzalloc(sizeof(*mrvl), GFP_KERNEL);
 	if (!mrvl)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9a5c9c1f9484..82a0a3691a63 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -473,6 +473,9 @@ static int qca_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p qca_open", hu);
 
+	if (!hci_uart_has_flow_control(hu))
+		return -EOPNOTSUPP;
+
 	qca = kzalloc(sizeof(struct qca_data), GFP_KERNEL);
 	if (!qca)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index f11af3912ce6..6ab631101019 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -104,6 +104,7 @@ int hci_uart_wait_until_sent(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
 void hci_uart_init_work(struct work_struct *work);
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
+bool hci_uart_has_flow_control(struct hci_uart *hu);
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 			 unsigned int oper_speed);
-- 
2.20.1
