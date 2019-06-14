Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9957CC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC9C2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfFNHYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:24:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44339 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfFNHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:24:11 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgYz-0000qU-R9; Fri, 14 Jun 2019 09:23:53 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgYz-0006Nj-35; Fri, 14 Jun 2019 09:23:53 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@intel.com>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/3] Bluetooth: hci_ldisc: Add function to wait for characters to be sent
Date:   Fri, 14 Jun 2019 09:23:49 +0200
Message-Id: <20190614072351.17390-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614072351.17390-1-s.hauer@pengutronix.de>
References: <20190614072351.17390-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hci UART line discipline sends its characters in a workqueue. Some
devices like the Marvell Bluetooth chips need to make sure that all
queued characters are sent before switching the baudrate. This adds
a function to synchronize with the workqueue.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/bluetooth/hci_ldisc.c | 8 ++++++++
 drivers/bluetooth/hci_uart.h  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c84f985f348d..8950e07889fe 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -178,6 +178,7 @@ static void hci_uart_write_work(struct work_struct *work)
 		goto restart;
 
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
 }
 
 void hci_uart_init_work(struct work_struct *work)
@@ -213,6 +214,13 @@ int hci_uart_init_ready(struct hci_uart *hu)
 	return 0;
 }
 
+int hci_uart_wait_until_sent(struct hci_uart *hu)
+{
+	return wait_on_bit_timeout(&hu->tx_state, HCI_UART_SENDING,
+				   TASK_INTERRUPTIBLE,
+				   msecs_to_jiffies(2000));
+}
+
 /* ------- Interface to HCI layer ------ */
 /* Reset device */
 static int hci_uart_flush(struct hci_dev *hdev)
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index d8cf005e3c5d..f11af3912ce6 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -100,6 +100,7 @@ int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_proto *p
 void hci_uart_unregister_device(struct hci_uart *hu);
 
 int hci_uart_tx_wakeup(struct hci_uart *hu);
+int hci_uart_wait_until_sent(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
 void hci_uart_init_work(struct work_struct *work);
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
-- 
2.20.1

