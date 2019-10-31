Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D86CCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374EA208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D0NkfeKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfJaKqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:46:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43581 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfJaKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:46:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so3793063pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utrKGlYR+m7/7C9HmV6JkZNg5i12WWJPbM++6P+gk7s=;
        b=D0NkfeKcFVjXhyu3AzvYQXKVkIbJC28/hVXlsGhcpkrFwy+occy30vn6ySlSalgOra
         hWydFhPR6Nke+WUJkq0gKNHlmW2CLE9l1WZmjr/bz/7M0Q/sI83gVHkdsUOYjRfvbEOD
         l5tppnDtvyceUCg4Wncpx2mnwhjAzqYNcYq5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utrKGlYR+m7/7C9HmV6JkZNg5i12WWJPbM++6P+gk7s=;
        b=q2W+68eM/F3QiROyB4q0tFxDHAoSNRO6yeGR+0p8UC/cpvtwnFBwPfH6KHUzyNPaSZ
         y7KL+/frlNt+FaZFTA+nBUISBqjd8HF1eoTufxFcia+fp/He/1TsvTDZ3ootg7VP1KC3
         uWT6B6LeBUbL8GXtl171wLnQmJuedvzr4Ro98BK26mLsHdUhcGxtYtP6JaDPVro0XNWz
         qlUWrUnXHWEX+bINjRzcwT/QEAc+sSswEcgzeAbV+oKl7zr7Gw4sseXKBef+acNztdZ5
         wHLEEAft1UD8KvRAxREL/PjfPmbTE7FpumK+MjO3tTszvWd2umxlBgk1V+ubsIg5DtNK
         Qygw==
X-Gm-Message-State: APjAAAXQA9O8ywetJgb1png67qdjyWn6V59a2rj2LY1km+uOVy+++5VG
        otuAynoIYe0T4iEufjmgjdqDJA==
X-Google-Smtp-Source: APXvYqyvd2OSu4rq8vukR4jKs79hobgb0t1RVO/4jv2WoXLY+fhlECmIMqamKJOOYhodr7dYgOxxBQ==
X-Received: by 2002:aa7:86c7:: with SMTP id h7mr5525837pfo.150.1572518780311;
        Thu, 31 Oct 2019 03:46:20 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id t4sm4853732pjy.10.2019.10.31.03.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 03:46:19 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     bgodavar@codeaurora.org, rjliao@codeaurora.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_qca: add PM support
Date:   Thu, 31 Oct 2019 18:46:14 +0800
Message-Id: <20191031104614.165120-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PM suspend/resume callbacks for hci_qca driver.

BT host will make sure both Rx and Tx go into sleep state in
qca_suspend. Without this, Tx may still remain in awake state, which
prevents BTSOC from entering deep sleep. For example, BlueZ will send
Set Event Mask to device when suspending and this will wake the device
Rx up. However, the Tx idle timeout on the host side is 2000 ms. If the
host is suspended before its Tx idle times out, it won't send
HCI_IBS_SLEEP_IND to the device and the device Rx will remain awake.

We implement this by canceling relevant work in workqueue, sending
HCI_IBS_SLEEP_IND to the device and then waiting HCI_IBS_SLEEP_IND sent
by the device.

In order to prevent the device from being awaken again after qca_suspend
is called, we introduce QCA_SUSPEND flag. QCA_SUSPEND is set in the
beginning of qca_suspend to indicate system is suspending and that we'd
like to ignore any further wake events.

With QCA_SUSPEND and spinlock, we can avoid race condition, e.g. if
qca_enqueue acquires qca->hci_ibs_lock before qca_suspend calls
cancel_work_sync and then qca_enqueue adds a new qca->ws_awake_device
work after the previous one is cancelled.

If BTSOC wants to wake the whole system up after qca_suspend is called,
it will keep sending HCI_IBS_WAKE_IND and uart driver will take care of
waking the system. For example, uart driver will reconfigure its Rx pin
to a normal GPIO pin and enable irq wake on that pin when suspending.
Once host detects Rx falling, the system will begin resuming. Then, the
BT host clears QCA_SUSPEND flag in qca_resume and begins dealing with
normal HCI packets. By doing so, only a few HCI_IBS_WAKE_IND packets are
lost and there is no data packet loss.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 127 +++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c591a8ba9d93..c2062087b46b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -43,7 +43,8 @@
 #define HCI_MAX_IBS_SIZE	10
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
-#define IBS_TX_IDLE_TIMEOUT_MS		2000
+#define IBS_BTSOC_TX_IDLE_TIMEOUT_MS	40
+#define IBS_HOST_TX_IDLE_TIMEOUT_MS	2000
 #define CMD_TRANS_TIMEOUT_MS		100
 
 /* susclk rate */
@@ -55,6 +56,7 @@
 enum qca_flags {
 	QCA_IBS_ENABLED,
 	QCA_DROP_VENDOR_EVENT,
+	QCA_SUSPENDING,
 };
 
 /* HCI_IBS transmit side sleep protocol states */
@@ -100,6 +102,7 @@ struct qca_data {
 	struct work_struct ws_tx_vote_off;
 	unsigned long flags;
 	struct completion drop_ev_comp;
+	wait_queue_head_t suspend_wait_q;
 
 	/* For debugging purpose */
 	u64 ibs_sent_wacks;
@@ -437,6 +440,12 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
 	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
 				 flags, SINGLE_DEPTH_NESTING);
 
+	/* Don't retransmit the HCI_IBS_WAKE_IND when suspending. */
+	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
+		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+		return;
+	}
+
 	switch (qca->tx_ibs_state) {
 	case HCI_IBS_TX_WAKING:
 		/* No WAKE_ACK, retransmit WAKE */
@@ -496,6 +505,8 @@ static int qca_open(struct hci_uart *hu)
 	INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
 	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
 
+	init_waitqueue_head(&qca->suspend_wait_q);
+
 	qca->hu = hu;
 	init_completion(&qca->drop_ev_comp);
 
@@ -532,7 +543,7 @@ static int qca_open(struct hci_uart *hu)
 	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
 
 	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
-	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
+	qca->tx_idle_delay = IBS_HOST_TX_IDLE_TIMEOUT_MS;
 
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
 	       qca->tx_idle_delay, qca->wake_retrans);
@@ -647,6 +658,12 @@ static void device_want_to_wakeup(struct hci_uart *hu)
 
 	qca->ibs_recv_wakes++;
 
+	/* Don't wake the rx up when suspending. */
+	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
+		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+		return;
+	}
+
 	switch (qca->rx_ibs_state) {
 	case HCI_IBS_RX_ASLEEP:
 		/* Make sure clock is on - we may have turned clock off since
@@ -711,6 +728,8 @@ static void device_want_to_sleep(struct hci_uart *hu)
 		break;
 	}
 
+	wake_up_interruptible(&qca->suspend_wait_q);
+
 	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 }
 
@@ -728,6 +747,12 @@ static void device_woke_up(struct hci_uart *hu)
 
 	qca->ibs_recv_wacks++;
 
+	/* Don't react to the wake-up-acknowledgment when suspending. */
+	if (test_bit(QCA_SUSPENDING, &qca->flags)) {
+		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+		return;
+	}
+
 	switch (qca->tx_ibs_state) {
 	case HCI_IBS_TX_AWAKE:
 		/* Expect one if we send 2 WAKEs */
@@ -780,8 +805,10 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 
 	/* Don't go to sleep in middle of patch download or
 	 * Out-Of-Band(GPIOs control) sleep is selected.
+	 * Don't wake the device up when suspending.
 	 */
-	if (!test_bit(QCA_IBS_ENABLED, &qca->flags)) {
+	if (!test_bit(QCA_IBS_ENABLED, &qca->flags) ||
+	    test_bit(QCA_SUSPENDING, &qca->flags)) {
 		skb_queue_tail(&qca->txq, skb);
 		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 		return 0;
@@ -1539,6 +1566,99 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 }
 
+static int __maybe_unused qca_suspend(struct device *dev)
+{
+	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	unsigned long flags;
+	int ret = 0;
+	u8 cmd;
+
+	set_bit(QCA_SUSPENDING, &qca->flags);
+
+	/* Device is downloading patch or doesn't support in-band sleep. */
+	if (!test_bit(QCA_IBS_ENABLED, &qca->flags))
+		return 0;
+
+	cancel_work_sync(&qca->ws_awake_device);
+	cancel_work_sync(&qca->ws_awake_rx);
+
+	spin_lock_irqsave_nested(&qca->hci_ibs_lock,
+				 flags, SINGLE_DEPTH_NESTING);
+
+	switch (qca->tx_ibs_state) {
+	case HCI_IBS_TX_WAKING:
+		del_timer(&qca->wake_retrans_timer);
+		/* Fall through */
+	case HCI_IBS_TX_AWAKE:
+		del_timer(&qca->tx_idle_timer);
+
+		serdev_device_write_flush(hu->serdev);
+		cmd = HCI_IBS_SLEEP_IND;
+		ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
+
+		if (ret < 0) {
+			BT_ERR("Failed to send SLEEP to device");
+			break;
+		}
+
+		qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
+		qca->ibs_sent_slps++;
+
+		qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
+		break;
+
+	case HCI_IBS_TX_ASLEEP:
+		break;
+
+	default:
+		BT_ERR("Spurious tx state %d", qca->tx_ibs_state);
+		ret = -EINVAL;
+		break;
+	}
+
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+
+	if (ret < 0)
+		goto error;
+
+	serdev_device_wait_until_sent(hu->serdev,
+				      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+
+	/* Wait for HCI_IBS_SLEEP_IND sent by device to indicate its Tx is going
+	 * to sleep, so that the packet does not wake the system later.
+	 */
+
+	ret = wait_event_interruptible_timeout(qca->suspend_wait_q,
+			qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
+			msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
+
+	if (ret > 0)
+		return 0;
+
+	if (ret == 0)
+		ret = -ETIMEDOUT;
+
+error:
+	clear_bit(QCA_SUSPENDING, &qca->flags);
+
+	return ret;
+}
+
+static int __maybe_unused qca_resume(struct device *dev)
+{
+	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+
+	clear_bit(QCA_SUSPENDING, &qca->flags);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
+
 static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
 	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
@@ -1553,6 +1673,7 @@ static struct serdev_device_driver qca_serdev_driver = {
 	.driver = {
 		.name = "hci_uart_qca",
 		.of_match_table = qca_bluetooth_of_match,
+		.pm = &qca_pm_ops,
 	},
 };
 
-- 
2.24.0.rc0.303.g954a862665-goog

