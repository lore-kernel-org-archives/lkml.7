Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A20C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BC22077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhqYpduB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfDWHXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:23:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34412 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:23:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so7151150pgq.1;
        Tue, 23 Apr 2019 00:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XoGcBhzMOQmRsEUerCGTGxvJxKBI0mfLgUxTBjjEjHY=;
        b=NhqYpduBypo7MY0/4J6+ts3/MGBcud2ymd3IwwIxlql5XqNA7/4OyjDZhGZyTpfNXf
         9/lkv7UON7fm4OOxIvobwfthxWenm40lfay0jxXjqwztcO2aju0UKdzDNtmPd8mtYhg/
         Tpn8+x0uQyiVmrsVY9pI0qxWkJWTWNrfot0GcX/t+KVwLM5GYfYLfxhJmUyLUHwByzK9
         PK3MoZOvqCjU8dY4dG2mLAGUwHfKUmxNiVnQfip1K2V961dl0ir0ZwTBkzvsSeesVCaV
         ttG9+ZSz+VymmQfmA5ENWxvaaZZArsmSA15fRmK6Q9/D9Yl95MLm5KljWPdb8NM9FXwa
         6iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XoGcBhzMOQmRsEUerCGTGxvJxKBI0mfLgUxTBjjEjHY=;
        b=C1uHcf1U0XiFOHsX3U33VXjeCm5sxL2OzgNjMKJbJkyh/MHK55yuVpLPXlKuRTIGjc
         zvdGYtCnAKRtDxw3PQI64ubgFbInPluAlgplCbY61hHabfkGTxTWpn7HaUasz0bRQNzg
         8kP5CgtHTfC4jyRs2kAFPa059ya1VbAGNWyXvYsHVJza1Ku2or1WMFaLKhPdOwJ3EgFN
         G/1aMy0zsj8S+ySFR9JikoteElzh1ZYKH7VDp+sojKg41hxqtSGCMYzSSZl9roHOC8fd
         2N2wZwzNHp7shi0f6ubqOjb8J79ghB7XYvw1gPF2vsDzlCdEDLIrx+TC0lwgDZiEn2O4
         WM0g==
X-Gm-Message-State: APjAAAWsWkeofSbjiGra/BRSW+Wbs0ZD2U+Q1vaKybFZYmqNAMxUbI7g
        Xubj4yCV1uLEkzA1a6KfqsTK9Ei7ZK8MoQ==
X-Google-Smtp-Source: APXvYqyCJJOVlEEYDd8zVWIHZjXKX+/5nEWhloC3WZ23ybn7yMUZ/kyl04xY89H8Ps+h1iZUt2GCDA==
X-Received: by 2002:a63:4a5f:: with SMTP id j31mr21618772pgl.369.1556004181976;
        Tue, 23 Apr 2019 00:23:01 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id p20sm12560594pgj.86.2019.04.23.00.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 00:23:01 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     bgodavar@codeaurora.org, ytkim@qca.qualcomm.com,
        "David S . Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH 1/2] Bluetooth: Create new HCI_QUIRK_WAIT_FOR_MATCHING_CC
Date:   Tue, 23 Apr 2019 15:22:35 +0800
Message-Id: <20190423072236.24999-2-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423072236.24999-1-jprvita@endlessm.com>
References: <20190423072236.24999-1-jprvita@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit creates a new quirk, HCI_QUIRK_WAIT_FOR_MATCHING_CC, which
when set makes the kernel not send the next queued HCI command until a
command complete arrives for the last HCI command sent to the
controller.

This avoids a state of confusion where the kernel believes a passive
scanning procedure is being performed while in fact controller is
performing an active scanning procedure, as requested by userspace and
the kernel.

This state of confusion is achieved when some buggy controllers send an
extra command complete event for the LE_SET_RANDOM_ADDR after the kernel
already sent the next queued command (LE_SET_SCAN_PARAM, for starting an
active scanning procedure), as shown at timestamp 27.420131 on the btmon
logs bellow.

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

In this situation the kernel ends up not processing the command complete
event for LE_SET_SCAN_PARAM, so hdev->le_scan_type is never updated to
active scanning and no device found events are generated for
ADV_SCAN_RSP PDUs. This makes impossible to discover BTLE devices with
these controllers.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 include/net/bluetooth/hci.h      | 4 ++++
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 3 +++
 net/bluetooth/hci_event.c        | 4 ++++
 4 files changed, 12 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fbba43e9bef5..f100e9d566a0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -204,6 +204,10 @@ enum {
 	 *
 	 */
 	HCI_QUIRK_NON_PERSISTENT_SETUP,
+
+	/* When this quirk is set, no pending HCI commands will be sent until a
+	 * matching command complete for the last command is received. */
+	HCI_QUIRK_WAIT_FOR_MATCHING_CC,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 094e61e07030..85bed4e916d3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -364,6 +364,7 @@ struct hci_dev {
 	struct sk_buff_head	cmd_q;
 
 	struct sk_buff		*sent_cmd;
+	__u8			sent_cmd_pending_cc;
 
 	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6b2540ba7f8..95ab8f9f2514 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4383,6 +4383,8 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 		return;
 	}
 
+	hdev->sent_cmd_pending_cc = 0;
+
 	/* If the command succeeded and there's still more commands in
 	 * this request the request is not yet complete.
 	 */
@@ -4493,6 +4495,7 @@ static void hci_cmd_work(struct work_struct *work)
 
 		hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
 		if (hdev->sent_cmd) {
+			hdev->sent_cmd_pending_cc = 1;
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(hdev, skb);
 			if (test_bit(HCI_RESET, &hdev->flags))
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..1abbca8ce1c2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3404,6 +3404,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
 			     req_complete_skb);
 
+	if (hdev->sent_cmd_pending_cc &&
+	    test_bit(HCI_QUIRK_WAIT_FOR_MATCHING_CC, &hdev->quirks))
+		return;
+
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
-- 
2.20.1

