Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB0AECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964E22133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF4fIg5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfJBLqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:46:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39395 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfJBLqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:46:42 -0400
Received: by mail-io1-f68.google.com with SMTP id a1so56155334ioc.6;
        Wed, 02 Oct 2019 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MxrgXf4bBeDJrrdv2WJ+UVqApLMeyLGXJ9L8ysXJGbk=;
        b=EF4fIg5Xs0nJuDMrrQnn4/SRoDQXdZK8BjD5+4zTAIrp0V5t/guNPEHzWdJH9jiAgk
         rkSCTSdXb2pTD8v1NW7de3zPo30yC3Dtugxre7t3nLGHNsBEvs4uorhdPpnJxq3lch0U
         Ci8vNipDs7PHZKquBoBgaEvWiWQxTBMxX+W97QjzVw1OdPNeLBZegpoILC8QDdGMf8NK
         ScmR4ZqYhR5Gawp+MWnlY0gw5zk9dIVyb5L1hxcMNIoqNamEjDZUZMwmaBrgzLo7tU3n
         oqhsek26gnFspR+Db28/ZkpOx6zEodS3tH5dCtJu8ph3m2NhUEwGCzo1gL3eVfzGrnl9
         YEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MxrgXf4bBeDJrrdv2WJ+UVqApLMeyLGXJ9L8ysXJGbk=;
        b=CTIsYLWzLUgznpkRWbbsJ77M5Hlc2X2xw6l283Z0tRwfPZp7Zfejb/hzttd2Zb+EVs
         4akSpb9AqYANQsWK241R9md+L2F83nNc49JtQ72aAg+QzlSY11pogkgVsb2Wcl5AjYLC
         3/gj1u1h6/6i0AIhVklGf1noKP8W9Dh3+R5W9EYrVEmQHKRaiIBaq/EOeg7lXG1QeKpQ
         CAaJGgFwt6bH5obEF9tRxFXbqIkEjwrLNt/1dWmyr9MKJ2FTCXwM1DqQmUB5A3f+LYpQ
         1oV3PAajqQkS3+26aMwiH+R9kMmz8f2fIQvdxPQdpzSsAL5375RyxGKG+gQStCmX85pF
         P7jQ==
X-Gm-Message-State: APjAAAWE6szTD9KUf1AYtQz3fD/0r3eguiAZG0WxYH1VGlM4FiNV9+/f
        BgtMhhOGXnQpiUU3ZsBJpLajpDO3WTE=
X-Google-Smtp-Source: APXvYqz8wuC6/XtwqRJYQslLuTV7yK4YZunZA/ofKXDuwdBwWg04n8dO6ZDl5PiMsAo6wTtAQQMUqA==
X-Received: by 2002:a92:ce48:: with SMTP id a8mr3247802ilr.281.1570016800917;
        Wed, 02 Oct 2019 04:46:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id o26sm7765702ioo.61.2019.10.02.04.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 04:46:40 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, adam.ford@logicpd.com,
        sre@kernel.org, Adam Ford <aford173@gmail.com>
Subject: [PATCH] Revert "Bluetooth: hci_ll: set operational frequency earlier"
Date:   Wed,  2 Oct 2019 06:46:26 -0500
Message-Id: <20191002114626.12407-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As nice as it would be to update firmware faster, that patch broke
at least two different boards, an OMAP4+WL1285 based Motorola Droid
4, as reported by Sebasian Reichel and the Logic PD i.MX6Q +
WL1837MOD.

This reverts commit a2e02f38eff84f199c8e32359eb213f81f270047.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 285706618f8a..d9a4c6c691e0 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -621,13 +621,6 @@ static int ll_setup(struct hci_uart *hu)
 
 	serdev_device_set_flow_control(serdev, true);
 
-	if (hu->oper_speed)
-		speed = hu->oper_speed;
-	else if (hu->proto->oper_speed)
-		speed = hu->proto->oper_speed;
-	else
-		speed = 0;
-
 	do {
 		/* Reset the Bluetooth device */
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
@@ -639,20 +632,6 @@ static int ll_setup(struct hci_uart *hu)
 			return err;
 		}
 
-		if (speed) {
-			__le32 speed_le = cpu_to_le32(speed);
-			struct sk_buff *skb;
-
-			skb = __hci_cmd_sync(hu->hdev,
-					     HCI_VS_UPDATE_UART_HCI_BAUDRATE,
-					     sizeof(speed_le), &speed_le,
-					     HCI_INIT_TIMEOUT);
-			if (!IS_ERR(skb)) {
-				kfree_skb(skb);
-				serdev_device_set_baudrate(serdev, speed);
-			}
-		}
-
 		err = download_firmware(lldev);
 		if (!err)
 			break;
@@ -677,7 +656,25 @@ static int ll_setup(struct hci_uart *hu)
 	}
 
 	/* Operational speed if any */
+	if (hu->oper_speed)
+		speed = hu->oper_speed;
+	else if (hu->proto->oper_speed)
+		speed = hu->proto->oper_speed;
+	else
+		speed = 0;
+
+	if (speed) {
+		__le32 speed_le = cpu_to_le32(speed);
+		struct sk_buff *skb;
 
+		skb = __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
+				     sizeof(speed_le), &speed_le,
+				     HCI_INIT_TIMEOUT);
+		if (!IS_ERR(skb)) {
+			kfree_skb(skb);
+			serdev_device_set_baudrate(serdev, speed);
+		}
+	}
 
 	return 0;
 }
-- 
2.17.1

