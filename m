Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C147EC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BD7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZdyOese+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfDWSRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:17:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33332 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfDWSRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:17:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so7906271pfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67uVuMgweM7hUxYBRr+BCXFyj4G9EQBA3cdpWpXKaUY=;
        b=ZdyOese++U6yeDFK4JwiA7/1PzuxGxjnF0t2+t+qEzOFW47+bQRmtSe/6Z1e9d8EQR
         tFzSSJCcVyNk2k/gv/7GZffJOL8w/kYZwUbko77BbllKGrBxzXZ6M5o23b1tLu2QJl7x
         LetVKFxM1fdJur996HbIIM8x0RNfqQsJoBQbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67uVuMgweM7hUxYBRr+BCXFyj4G9EQBA3cdpWpXKaUY=;
        b=cp3UQzTspumh33rcRgzgqR3s/A9RurCiSKxMjey888iZzlnZB/ZYanwPuZYy24Wvmp
         T7PHz5ijc4clEowyAhAd8vBOcQPL48zL7bH7BaK9UwqD+Fl2m7qi2QOX6XVduZqEBsoq
         i2/ipYCufLwIGT/8EZwGMjWA/f5WoBTVGFO2ncGXTqA/JeI1fKNDOoYOMjM10ViTh7n0
         C3+axyV4o4juM2wY+eVtv3iEopzmaAjYP26Gu+RH94DuB2OLYLsQWPO/FMpS1XNtOLaq
         05VvTa4QwBRxIbZQtf5FweFQQd2CLJnnEMjCAkQdk+Vobn7BXRDHKg0o6weK2xjTkvGe
         0CMg==
X-Gm-Message-State: APjAAAVAlj5PpSoucL6CujMOvRSqyzYdv0BSQoR77v6bd5mefCVe1J0A
        N+yo3X5YdPUiCVOUzgaBKKHBIg==
X-Google-Smtp-Source: APXvYqzD46PxqMHlhoWOEjSl1bU63TPbnxkk8L1P/uaVGwlvas59aOEYHWzRDpRvUGVntBoDEjx0Yg==
X-Received: by 2002:a63:5057:: with SMTP id q23mr26246814pgl.30.1556043425076;
        Tue, 23 Apr 2019 11:17:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z21sm22805381pfn.139.2019.04.23.11.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 11:17:04 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] Bluetooth: hci_qca: Fix crash with non-serdev devices
Date:   Tue, 23 Apr 2019 11:16:52 -0700
Message-Id: <20190423181653.147804-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qca_set_baudrate() calls serdev_device_wait_until_sent() assuming that
the HCI is always associated with a serdev device. This isn't true for
ROME controllers instantiated through ldisc, where the call causes a
crash due to a NULL pointer dereferentiation. Only call the function
when we have a serdev device. The timeout for ROME devices at the end
of qca_set_baudrate() is long enough to be reasonably sure that the
command was sent.

Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
Reported-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reported-by: Rocky Liao <rjliao@codeaurora.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Rocky Liao <rjliao@codeaurora.org>
Tested-by: Rocky Liao <rjliao@codeaurora.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v2:
- first version got corrupted for some reason, this should apply
- added 'Reviewed-by' tags from Rocky abd Balakrishna
- added 'Tested-by' tag from Rocky
---
 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a80c3bc90904..7f75652686fe 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1006,7 +1006,8 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	while (!skb_queue_empty(&qca->txq))
 		usleep_range(100, 200);
 
-	serdev_device_wait_until_sent(hu->serdev,
+	if (hu->serdev)
+		serdev_device_wait_until_sent(hu->serdev,
 		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
 
 	/* Give the controller time to process the request */
-- 
2.21.0.593.g511ec345e18-goog

