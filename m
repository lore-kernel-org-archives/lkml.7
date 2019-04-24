Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4AFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A7420685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E33uz/07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfDXGH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:07:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36723 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfDXGH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:07:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so8726944pfn.3;
        Tue, 23 Apr 2019 23:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OBCxPpDNlfLikJPHkq8su0X6sCDwSJYZOlK2co5u+M=;
        b=E33uz/07emgzHUi2w76zkAoa45DJQFQwMsFr81jDCSyXBtJGJ1AnV0OE5rY9TFi1th
         y4ypA8bCG2C6ZFGyyWjO52whqWNqSEn/vr0UlhT4NRKfJMjVHH2Z03VCSwv+KG8qv3A/
         5UA9YeeLY9wN4JJBP8Bxpiu1Js8R2WCrrGu1TQ3AA6zzxZNCK3V0Ujpjv/OygUVC7lC5
         SfHYepuOc/cnjCdePrfCRnQU/hLoaHXb3yMn7WEczaPPv1femO5ijMX40i1llZCTEoqD
         qio787j5jDuUO0D05LdEuS4YwgUcbY3AEOr5UcnGXMBF6YBx94JkVxKTHZq4OOjXIdF3
         smcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OBCxPpDNlfLikJPHkq8su0X6sCDwSJYZOlK2co5u+M=;
        b=JqehEVxqoSUX5c8nB3ElbnO0IaSnlSWxWzl/sWdItFJtnSWVdFMYAUsiwfw2FvEeWC
         QTqJ4IEB5CFMoV9VChJ7wZP7X1vy7hKRCu0wrQkRxM1lTZs+dGrSwQp5q2aHOFlqGY1N
         mVwdX3/GKJafNPbS6x/tFxPJSznZxRE4P4Nn2BUBkiSzCvCUj7f2QQr3Fb76bGV5F6pB
         kixOoI8x8enznBQxdWhcnjcLS/+q8hw/A2VcOGqDpBr/dZsA0q9pjNUOQJyVbtn+IYy+
         h6r5mh3BKYgL8zLh9mUdA76XhKbzBwbFSU322wN6xalU61mrvPIktAjoMxFD+ju8F+5a
         sJcA==
X-Gm-Message-State: APjAAAWr1rqcWdUZpSQ2Z87tD2kspkuR+6pdEKQ4WOnZhnkz7kyqhRpj
        rZ3gu5mY6cCtmLwIC7f8Ndk=
X-Google-Smtp-Source: APXvYqy/O0JQzjjblqGNotUsLpJ9R0WzVy8grdM23q6+D9NAtlZZPC1YdA/HLkx4YrsgWl7Z8cYwOw==
X-Received: by 2002:a63:e048:: with SMTP id n8mr28984710pgj.41.1556086046324;
        Tue, 23 Apr 2019 23:07:26 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id d67sm1607621pfa.35.2019.04.23.23.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 23:07:25 -0700 (PDT)
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
Date:   Wed, 24 Apr 2019 14:07:04 +0800
Message-Id: <20190424060704.22721-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424054335.30044-1-jprvita@endlessm.com>
References: <20190424054335.30044-1-jprvita@endlessm.com>
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
 net/bluetooth/hci_event.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..b349fc2b4123 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3071,6 +3071,19 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	*opcode = __le16_to_cpu(ev->opcode);
 	*status = skb->data[sizeof(*ev)];
 
+	if (*opcode != HCI_OP_RESET && !hci_sent_cmd_data(hdev, *opcode)) {
+		/* Some buggy controllers generate an extra command complete
+		 * event for the previous command after a new commend was
+		 * already sent, so if the opcode does not match the last sent
+		 * command we should ignore this event.
+		 *
+		 * HCI_OP_RESET is a special case handled in
+		 * hci_req_cmd_complete.
+		 */
+		bt_dev_err(hdev, "unexpected CC event opcode 0x%4.4x", *opcode);
+		return;
+	}
+
 	skb_pull(skb, sizeof(*ev));
 
 	switch (*opcode) {
-- 
2.20.1

