Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01F3C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5A8218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzNmHUMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfDYGiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:38:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47068 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfDYGiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:38:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1526126pgg.13;
        Wed, 24 Apr 2019 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UE33d0Ymq1NTCt2baLLnIAWXqXK1Ph+80pSpkWrWxZM=;
        b=DzNmHUMwzqcYW2IiR0nM6Lw0ZOGN1bk0gsLETose7za7zYFG+y3sDTYTkRyLFJE1y0
         q3XrqwC/H6dtJ0+M67INvgdXE53NhoJ41h4Zf4cQ9NbUXnef2xf1bEZlJgB+3k9w2+ZH
         Sj7JDT0cveNNMaGm5nN6zWWY4WC9RrYM3V/fTBEg+bYS2QS7f+QQ/XJzE6G8+te9PQHn
         NjUUTK1vf0FWNlY8RdsTSUvHmKWWcK1Y7Lfch2cNVzpV3AjR661qTnLugT6jIxMpl3Em
         AwJLP0PB+RUfvkKAbBwYs0Ywx9U8w8W0zq4KWYndPuNMuJEgDn8uO7F802rhepBgBvQt
         /M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UE33d0Ymq1NTCt2baLLnIAWXqXK1Ph+80pSpkWrWxZM=;
        b=aykmJCu7fN2tPStpilDNyuO6s+zRVY92HQgh3R5KTd0bBM/aa7zIzg3bz52NARqCQA
         UxMwwpk8k34ZGJlu+ZPPRQFqve47dlf1bYolbouTI9y3zpxUpip3md+9CEkRFyLJoPz4
         FgUqoj6TN1VhyZtNyB9DwuAF2uexojzI3HKgDxVyTJP9KTIwaD8mQZZtSEc+bsE+iejB
         msoATEtuOPq7PXZg1Cdqmm2vvxlT6zL7rdro/qp0ihixKIn6sJtSqXWXcDw35Vxu+Ant
         r8jFOgUOCXUTyVRsY2sNq3NZK/JETU+9pEWSCl0PoCqW1Pq4ufGyQQ+n2QsQGanVrNx8
         Hp/w==
X-Gm-Message-State: APjAAAWw3JIQ3Ei69lEFLyb1nTzaLsZg7m0wFUX/zj3yto+IgwDkrXsj
        SKH8KCMivpM/T5IlAhfMI4BffM8WaUKBMA==
X-Google-Smtp-Source: APXvYqyMZFFHUrb346oRdrwdfOKIStVM1XzcIzf8X4OohMBt+qmDFEs6U7+uJOQm9f8SEElg3XdqTA==
X-Received: by 2002:a62:ed05:: with SMTP id u5mr37500310pfh.63.1556174300219;
        Wed, 24 Apr 2019 23:38:20 -0700 (PDT)
Received: from kiddo.endlessm-sf.com (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id d69sm40705886pfg.24.2019.04.24.23.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 23:38:19 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     bgodavar@codeaurora.org, ytkim@qca.qualcomm.com,
        "David S . Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH] Bluetooth: Ignore CC events not matching the last HCI command
Date:   Thu, 25 Apr 2019 14:38:12 +0800
Message-Id: <20190425063812.14509-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CA+A7VXVa9pFizfQ8C8QUS=3=YDjojmScOKPS=Yhcx-w8G=wsVw@mail.gmail.com>
References: <CA+A7VXVa9pFizfQ8C8QUS=3=YDjojmScOKPS=Yhcx-w8G=wsVw@mail.gmail.com>
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
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 5 +++++
 net/bluetooth/hci_event.c        | 3 +++
 3 files changed, 9 insertions(+)

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
index d6b2540ba7f8..37893b0c6077 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4380,9 +4380,13 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 		if (test_bit(HCI_INIT, &hdev->flags) && opcode == HCI_OP_RESET)
 			hci_resend_last(hdev);
 
+		bt_dev_err(hdev,
+			   "unexpected CC event for opcode 0x%4.4x", opcode);
 		return;
 	}
 
+	hdev->sent_cmd_pending_cc = 0;
+
 	/* If the command succeeded and there's still more commands in
 	 * this request the request is not yet complete.
 	 */
@@ -4493,6 +4497,7 @@ static void hci_cmd_work(struct work_struct *work)
 
 		hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
 		if (hdev->sent_cmd) {
+			hdev->sent_cmd_pending_cc = 1;
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(hdev, skb);
 			if (test_bit(HCI_RESET, &hdev->flags))
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..7541a4bc9444 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3404,6 +3404,9 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
 			     req_complete_skb);
 
+	if (hdev->sent_cmd_pending_cc)
+		return;
+
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
-- 
2.20.1

