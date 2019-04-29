Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB4C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A172067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QbQJ9nLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfD2XVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:21:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37605 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbfD2XVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:21:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so5905610pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbhGzYYnhHF5ZeRWa6OLUpz8tEN0PJq7GYYSb0RjNJg=;
        b=QbQJ9nLlmgPEXDHAUhfEQJ7+Rp/Ze9/aRmRQrHPwu+VtBcrfqkvwv1VPTMi0OnWnuO
         YqiM198R1ZzNwSFg2BvdIBDxVjKv8nJyR2NOBt/6/FTX1YB1dFs7+4f8PU0Qn/zHK9B8
         31Rf1PxuYwZfk5cmbMllS7oPdC37lujKLyZ4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbhGzYYnhHF5ZeRWa6OLUpz8tEN0PJq7GYYSb0RjNJg=;
        b=fbs+zIlqTDWoo+VpZyr/G1FHbyKuzqE+qMUwMCvZx4Y/cVLNSJrcMtnhC14oNgPjuw
         +jECY287KvCd1yjkxt9t2PgWF0x9NZbRRLtikjYTmRcfXMmAAWGDIcZ9tXRN0NacCuFy
         e1Vr7h4SlPlZmmud8cCR7liudb2r+1I/6hpwmIsXcdUblqiounof4Ekpig+eUpyBbuIx
         ZUAcutaS8wHL9MIBZLd/ht5XWLIgGgK0A2F6zi4jdWl7/lUwcPvDMt4JjPuMtyp11Dyu
         RzIhUDI03TrlSeKrrR/L3hnp26zMSlNGu2eh1oz/lny9THSxqOZZ8IbQ+K+SaSltjbWM
         gsNA==
X-Gm-Message-State: APjAAAV8i6v6aSlrBXgj/tGTp5mucJKbndYO0nUhLvYj6u2FvvcuLqPK
        kdhYxosN/RnRUbqfVWLlxKFRPQ==
X-Google-Smtp-Source: APXvYqwNFIfIwYAgoTW/lNg8BKpDIaRiDrn351eYLHa+SPhyCsbCU6O8Y+yAbBn5u5T8ulECg2iwCQ==
X-Received: by 2002:a63:8dc8:: with SMTP id z191mr26749131pgd.9.1556580101013;
        Mon, 29 Apr 2019 16:21:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f20sm70040595pff.176.2019.04.29.16.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 16:21:40 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/2] Bluetooth: hci_qca: Rename STATE_<flags> to QCA_<flags>
Date:   Mon, 29 Apr 2019 16:21:30 -0700
Message-Id: <20190429232131.183049-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IBS_ENABLED. The constant
represents a flag (multiple flags can be set at once), not a unique
state of the controller or driver.

Also make the flag an enum value instead of a pre-processor constant
(more flags will be added to the enum group by another patch).

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IBS_ENABLED

Changes in v2:
- don't use BIT()
- change to enum type
- updated commit message
---
 drivers/bluetooth/hci_qca.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c53ee8d8ca15..57322c42bb2d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -54,9 +54,6 @@
 #define HCI_IBS_WAKE_ACK	0xFC
 #define HCI_MAX_IBS_SIZE	10
 
-/* Controller states */
-#define STATE_IN_BAND_SLEEP_ENABLED	1
-
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
 #define CMD_TRANS_TIMEOUT_MS		100
@@ -67,6 +64,10 @@
 /* Controller debug log header */
 #define QCA_DEBUG_HANDLE	0x2EDC
 
+enum qca_flags {
+	QCA_IBS_ENABLED,
+};
+
 /* HCI_IBS transmit side sleep protocol states */
 enum tx_ibs_states {
 	HCI_IBS_TX_ASLEEP,
@@ -792,7 +793,7 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	/* Don't go to sleep in middle of patch download or
 	 * Out-Of-Band(GPIOs control) sleep is selected.
 	 */
-	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
+	if (!test_bit(QCA_IBS_ENABLED, &qca->flags)) {
 		skb_queue_tail(&qca->txq, skb);
 		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 		return 0;
@@ -1202,7 +1203,7 @@ static int qca_setup(struct hci_uart *hu)
 		return ret;
 
 	/* Patch downloading has to be done without IBS mode */
-	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	clear_bit(QCA_IBS_ENABLED, &qca->flags);
 
 	if (qca_is_wcn399x(soc_type)) {
 		bt_dev_info(hdev, "setting up wcn3990");
@@ -1246,7 +1247,7 @@ static int qca_setup(struct hci_uart *hu)
 	/* Setup patch / NVM configurations */
 	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver);
 	if (!ret) {
-		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+		set_bit(QCA_IBS_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
@@ -1315,7 +1316,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	 * data in skb's.
 	 */
 	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
-	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	clear_bit(QCA_IBS_ENABLED, &qca->flags);
 	qca_flush(hu);
 	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 
-- 
2.21.0.593.g511ec345e18-goog

