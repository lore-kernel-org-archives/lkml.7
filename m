Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA6AC10F00
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF62206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fa65DUiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCGAlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:41:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42689 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCGAlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:41:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so9984157pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bzyw/FtnJm42S211Z4jwpMLy///sVqYqjHEjihMGnWc=;
        b=Fa65DUiPt0OKc5L+El+Ke/snQVMtahC81LLsTp2Yx7P+ktf6X/+hKfugvViZm6XpSS
         YKq8EE59N54UfN0K9yAy1YwNcGdKdXGiulKCjd5fXQp7K+GjAq4iBTXVoO6tlID6MrKh
         VFDeCTYKHIZuZ6WitSatIciXiw6PrPBJ1Weik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bzyw/FtnJm42S211Z4jwpMLy///sVqYqjHEjihMGnWc=;
        b=CQ3WQMc3UXQu2NY75i26QYWFRGnm5F2KPvDlEFoYiF/qxCrDy23n4B0CF2zkJ+Lm8n
         1eMFNrPBHcMDRdgY+XRO+OB7zb9/mjqw5TqDZ28h3uQLzfmpWuo/OJup7vjrSZFhBuyB
         GuTnvUbk8xrGEBrv0Yl0zC6vL59PFqzvsco46dEss+SdP1X1FwPOe24HktBKT8Plwwau
         7208ED4K43t2E8zusGxOf6tPnz6kozhJ6oZlx6oH7miktmu3la75r4sYtAiYrC0ycBu8
         /VUaUi5JUCUAIHu9Pe5Z2CNjpXSzmMokUivfd9EORWs7S1JyWtRJbWSEl4qEHCDXqz9f
         9N5w==
X-Gm-Message-State: APjAAAVaU3iCYX958qkUv6zHlpXRdBaRUVnajOJfPAWpwuK4J0/iFWCc
        TCrhUMIS3Tz/P/nCDb2kCTXdYQ==
X-Google-Smtp-Source: APXvYqyl4Ipm7+UwH5VAS93wtw/ofppGV4lp9xy8BeSyWqlwFcDZefFTBHkd3V0KMB5W7tGhGlapqA==
X-Received: by 2002:aa7:8051:: with SMTP id y17mr10021766pfm.92.1551919261248;
        Wed, 06 Mar 2019 16:41:01 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o76sm8361985pfa.156.2019.03.06.16.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 16:41:00 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] Bluetooth: hci_qca: Rename STATE_<flags> to QCA_<flags>
Date:   Wed,  6 Mar 2019 16:40:40 -0800
Message-Id: <20190307004041.38059-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190307004041.38059-1-mka@chromium.org>
References: <20190307004041.38059-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IN_BAND_SLEEP_ENABLED.
The constant represents a flag (multiple flags can be set at once),
not a unique state of the controller or driver. Also use the BIT()
macro to specify the position of the flag instead of an integer
literal.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 237aea34b69f1..ab8e59419dbc4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -54,8 +54,7 @@
 #define HCI_IBS_WAKE_ACK	0xFC
 #define HCI_MAX_IBS_SIZE	10
 
-/* Controller states */
-#define STATE_IN_BAND_SLEEP_ENABLED	1
+#define QCA_IN_BAND_SLEEP_ENABLED	BIT(0)
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
@@ -775,7 +774,7 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	/* Don't go to sleep in middle of patch download or
 	 * Out-Of-Band(GPIOs control) sleep is selected.
 	 */
-	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
+	if (!test_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
 		skb_queue_tail(&qca->txq, skb);
 		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 		return 0;
@@ -1192,7 +1191,7 @@ static int qca_setup(struct hci_uart *hu)
 		return ret;
 
 	/* Patch downloading has to be done without IBS mode */
-	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	clear_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
 
 	if (qcadev->btsoc_type == QCA_WCN3990) {
 		bt_dev_info(hdev, "setting up wcn3990");
@@ -1236,7 +1235,7 @@ static int qca_setup(struct hci_uart *hu)
 	/* Setup patch / NVM configurations */
 	ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, soc_ver);
 	if (!ret) {
-		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+		set_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
@@ -1294,7 +1293,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	 * data in skb's.
 	 */
 	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
-	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	clear_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
 	qca_flush(hu);
 	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 
-- 
2.21.0.352.gf09ad66450-goog

