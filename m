Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BEDECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F18C206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYt29wLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJIIvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:51:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42679 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:51:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so1171902pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In7lAtEYz40LWfmW5FUqo3PU26fK6KeFFUXZm6ciSko=;
        b=dYt29wLqZTFg8WlcHAi/6yG/WQQcQ8I0R93gGpxHkNHDIIqsICqRvc0kAZF94I4kMy
         fBraO+UARhK7ZoZ6I2WmK2snoiEqgdxt49h8/+ZJTzYGyKWOTPx910pLLY/TMAb4Am3u
         b20ydM1OvAcs7lv131FiryRJI2gJ3lTeOoSmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In7lAtEYz40LWfmW5FUqo3PU26fK6KeFFUXZm6ciSko=;
        b=IPie6vVS1AR/t+5b6GpSp3xSb7NHwCwiIs4fRCelE1WMevU0Xs29vSHzPE3oXhvjtJ
         hjR/zUlYMf7t7WdyPx4/H0ISWHGNvs3SffzM5bznouztiteOo4GZI3umnQNxmlD5hPv/
         C/k4MXV/j73qDsW6MRm+unQmUbFMKBxRumj0J3xsNVQ4/R8q3VZphOTiiHdVhrhSnHNc
         kB+qcl8u4q06XXrk5LZ8S5/lDpa1Breg4ZyyAXHfisLQoW6MoZJ9nr4NJYsT9XO3kWhB
         qht1MWXH8W4q7Jy91rC5UKWnQFVJhCmNF0jx/dkXByQhn37VkyNsHVmXt33wnDYqgNkD
         J5Jw==
X-Gm-Message-State: APjAAAW8qpDA0brC6N85GRWaq2Kd3r6j5PLa7ZL8lHvHtWr7cTydH8rG
        nh6YXDTPreWWsilR8jJm5YnnQQ==
X-Google-Smtp-Source: APXvYqw+p6lVwH/R34JigHtj9JxYN6M1A5y1JJmqaZ+wjVVzbJzlOboDC6D/oNEY9AWUlK9aARTFdQ==
X-Received: by 2002:aa7:92c9:: with SMTP id k9mr2588834pfa.215.1570611082215;
        Wed, 09 Oct 2019 01:51:22 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id g7sm2479081pfm.176.2019.10.09.01.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:51:21 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjliao@codeaurora.org, rongchi@codeaurora.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_qca: fix in-band sleep enablement
Date:   Wed,  9 Oct 2019 16:51:16 +0800
Message-Id: <20191009085116.199922-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling in-band sleep when there is no patch/nvm-config found and
bluetooth is running with the original fw/config.

Fixes: ba8f35979002 ("Bluetooth: hci_qca: Avoid setup failure on missing rampatch")
Fixes: 7dc5fe0814c3 ("Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw loader")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e3164c200eac..367eef893a11 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1291,10 +1291,8 @@ static int qca_setup(struct hci_uart *hu)
 	/* Setup patch / NVM configurations */
 	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver,
 			firmware_name);
-	if (!ret) {
-		set_bit(QCA_IBS_ENABLED, &qca->flags);
-		qca_debugfs_init(hdev);
-	} else if (ret == -ENOENT) {
+
+	if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		ret = 0;
 	} else if (ret == -EAGAIN) {
@@ -1305,6 +1303,11 @@ static int qca_setup(struct hci_uart *hu)
 		ret = 0;
 	}
 
+	if (!ret) {
+		set_bit(QCA_IBS_ENABLED, &qca->flags);
+		qca_debugfs_init(hdev);
+	}
+
 	/* Setup bdaddr */
 	if (qca_is_wcn399x(soc_type))
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
-- 
2.23.0.581.g78d2f28ef7-goog

