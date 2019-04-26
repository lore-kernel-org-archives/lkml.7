Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EC5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9568920684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqmKBfsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfDZI5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:57:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32902 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZI5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:57:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id y3so399489plp.0;
        Fri, 26 Apr 2019 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCoIp7clOgQjuHvUqFblg39QgeSiMww8nZ4z9GZhPNg=;
        b=QqmKBfsNXLnIXdFom+GF8yWp5mw8ZUpB7iXR4QbNM4z89uOrci7264obdOP0gwRHP7
         xr+uWRYhe/BXdTyIrf9W9s021M5yoqAvaHC51UgHGVzt8YRzkEc7XW8KUG+88fdGhnth
         9SE5kIxTFqQux6QweH4AAsIJu/cY0BiZwh8iDYDl0ZYBof0yKMAzI8LaT3gC0KKcMaW0
         xTGSX15q5Fucj1etckDbqQ/KxhCxy6Ny/isK4G0EJHF8qYzvAWEg1YYQszcVii6H92bn
         aJhrUN0YTrWx6pspDlFTrmcXdrZUbcWE5KuRdDoZ9hUE0QktjiVROMxVShUQuegQx9jZ
         kPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCoIp7clOgQjuHvUqFblg39QgeSiMww8nZ4z9GZhPNg=;
        b=bMZtQuXvXePD1tjBc/OZudhPo89ynU6d5m9z4TYx56b7xu8wsdz51CwP0q5IZdCO8p
         wTBUI+gb4qHde7aGPBxr4ZqP3w0timBLTbwoqqjBZurNA5lORC+HN/Aq5r6/UeMxW/3p
         f0bY+8CV05o6guel3jQG0hD/qWhpFgkhLUWnqn1awqlL9ybuB5zIVBr26JaMS8cNoScD
         ljQsfQYu1pajbE0I2NREKgC9dVWQxRHqpD2GA2X20DSdLSMoPeh8/SlXhubysz/P9xo8
         zZ1fSi0EQfjhf1orAmeaWmFDVp/vGfIWwRW8CxPXT9olIWl+y1UpQ0kT/wB7Uj5p4vCd
         FR3g==
X-Gm-Message-State: APjAAAXzBYmzjsgFqtAJC0Ly6rUoBd7jc6Bzkut8Yrt6eVtL2easKsrp
        EeYsd1p6Qo5/Uwb9nnvaS9Y=
X-Google-Smtp-Source: APXvYqxZMtMtB819B9VhfXJBUDUhiqa8ooYnOQQCuQm53gVan3h0/LmCk28GDfBdBekI/1TZGE+WXg==
X-Received: by 2002:a17:902:28a9:: with SMTP id f38mr44139830plb.295.1556269022163;
        Fri, 26 Apr 2019 01:57:02 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id x128sm45801842pfx.103.2019.04.26.01.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 01:57:01 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     bgodavar@codeaurora.org, ytkim@qca.qualcomm.com,
        "David S . Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH v3] Bluetooth: Ignore CC events not matching the last HCI command
Date:   Fri, 26 Apr 2019 16:56:35 +0800
Message-Id: <20190426085635.3363-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CA+A7VXWss=RAXMYb9FfWi=xPCF4Fg+A5tAbYX594HPX2b151fQ@mail.gmail.com>
References: <CA+A7VXWss=RAXMYb9FfWi=xPCF4Fg+A5tAbYX594HPX2b151fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the kernel not send the next queued HCI command until
a command complete arrives for the last HCI command sent to the
controller. This change avoids a problem with some buggy controllers
(seen on two SKUs of QCA9377) that send an extra command complete event
for the previous command after the kernel had already sent a new HCI
command to the controller.

The problem was reproduced when starting an active scanning procedure,
where an extra command complete event arrives for the LE_SET_RANDOM_ADDR
command. When this happends the kernel ends up not processing the
command complete for the following commmand, LE_SET_SCAN_PARAM, and
ultimately behaving as if a passive scanning procedure was being
performed, when in fact controller is performing an active scanning
procedure. This makes it impossible to discover BLE devices as no device
found events are sent to userspace.

This problem is reproducible on 100% of the attempts on the affected
controllers. The extra command complete event can be seen at timestamp
27.420131 on the btmon logs bellow.

Bluetooth monitor ver 5.50
= Note: Linux version 5.0.0+ (x86_64)                                  0.352340
= Note: Bluetooth subsystem version 2.22                               0.352343
= New Index: 80:C5:F2:8F:87:84 (Primary,USB,hci0)               [hci0] 0.352344
= Open Index: 80:C5:F2:8F:87:84                                 [hci0] 0.352345
= Index Info: 80:C5:F2:8F:87:84 (Qualcomm)                      [hci0] 0.352346
@ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.352347
@ MGMT Open: btmon (privileged) version 1.14                  {0x0002} 0.352366
@ MGMT Open: btmgmt (privileged) version 1.14                {0x0003} 27.302164
@ MGMT Command: Start Discovery (0x0023) plen 1       {0x0003} [hci0] 27.302310
        Address type: 0x06
          LE Public
          LE Random
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6   #1 [hci0] 27.302496
        Address: 15:60:F2:91:B2:24 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                 #2 [hci0] 27.419117
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7  #3 [hci0] 27.419244
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                 #4 [hci0] 27.420131
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2      #5 [hci0] 27.420259
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                 #6 [hci0] 27.420969
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
> HCI Event: Command Complete (0x0e) plen 4                 #7 [hci0] 27.421983
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4        {0x0003} [hci0] 27.422059
      Start Discovery (0x0023) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2             {0x0003} [hci0] 27.422067
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2             {0x0002} [hci0] 27.422067
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2             {0x0001} [hci0] 27.422067
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_core.c    |  5 +++++
 net/bluetooth/hci_event.c   | 12 ++++++++++++
 net/bluetooth/hci_request.c |  4 ----
 net/bluetooth/hci_request.h |  4 ++++
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fbba43e9bef5..883a8c25ccfb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -221,6 +221,8 @@ enum {
 	HCI_RAW,
 
 	HCI_RESET,
+
+	HCI_CMD_PENDING,
 };
 
 /* HCI socket flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6b2540ba7f8..4b7f20286e1a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4383,6 +4383,9 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 		return;
 	}
 
+	/* If we reach this point this event matches the last command sent */
+	clear_bit(HCI_CMD_PENDING, &hdev->flags);
+
 	/* If the command succeeded and there's still more commands in
 	 * this request the request is not yet complete.
 	 */
@@ -4493,6 +4496,8 @@ static void hci_cmd_work(struct work_struct *work)
 
 		hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
 		if (hdev->sent_cmd) {
+			if (hdev->req_status == HCI_REQ_PEND)
+				set_bit(HCI_CMD_PENDING, &hdev->flags);
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(hdev, skb);
 			if (test_bit(HCI_RESET, &hdev->flags))
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..cac13f674474 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3404,6 +3404,12 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
 			     req_complete_skb);
 
+	if (test_bit(HCI_CMD_PENDING, &hdev->flags)) {
+		bt_dev_err(hdev,
+			   "unexpected event for opcode 0x%4.4x", *opcode);
+		return;
+	}
+
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
@@ -3511,6 +3517,12 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_req_cmd_complete(hdev, *opcode, ev->status, req_complete,
 				     req_complete_skb);
 
+	if (test_bit(HCI_CMD_PENDING, &hdev->flags)) {
+		bt_dev_err(hdev,
+			   "unexpected event for opcode 0x%4.4x", *opcode);
+		return;
+	}
+
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ca73d36cc149..5b3838a3bdc1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -30,10 +30,6 @@
 #include "smp.h"
 #include "hci_request.h"
 
-#define HCI_REQ_DONE	  0
-#define HCI_REQ_PEND	  1
-#define HCI_REQ_CANCELED  2
-
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 {
 	skb_queue_head_init(&req->cmd_q);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 692cc8b13368..d0cea517d66e 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -22,6 +22,10 @@
 
 #include <asm/unaligned.h>
 
+#define HCI_REQ_DONE	  0
+#define HCI_REQ_PEND	  1
+#define HCI_REQ_CANCELED  2
+
 #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
 #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
 
-- 
2.20.1

