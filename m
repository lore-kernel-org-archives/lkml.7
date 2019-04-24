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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C51C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97AA20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH8ytm+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfDXFoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:44:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39453 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfDXFoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:44:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so6903970plb.6;
        Tue, 23 Apr 2019 22:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiXtlO6niFYpM6EjXh62i96EKrFWcQNkd8zOBC+aQvw=;
        b=FH8ytm+a1E8I7taWaFH/M2z1nw06+/TaGKbUInJRL/5lWb+cunnbIt9ozET8c2KkWb
         QD0mmetNb7a7oA3R5Re4KPTDqYVPrRMyD+BcbyCIQ7O9xWJ5Q0T8P1ApBnknp8Ns3eWj
         YW2tR8Nlw9hgzZVlFX2qXmldkA4sdPnDzeYSywCejoH91HVLocydkAAq9AmmBH4/cASo
         QtAT+acowsKM+x3E57sqTjJACPqJifzMNijsC2PKsvFZAyxp0+ublI9On7jYw0BB2SN7
         4aQeorLzO53t96fmGsxqM+H+6P6lHchnjGDT0kbCMR8yuKYa3TnszdBQs9LkiIJ/JTb7
         1fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiXtlO6niFYpM6EjXh62i96EKrFWcQNkd8zOBC+aQvw=;
        b=bljQduu5TWQuDqQQjyJ5t8+EozyhIlXFKvclaOeQNnPL08tbNd6ohQofu8D/et21AH
         hbN5yJfzPIKyJ/QehSvdKKr8IaFm9uvmOkSdNwgmX624Ze6PsAdBKVey9RjhuQOXGWgG
         wALnyv3rUKM/AsvmGV0IgIpLbp6Opm89ZiJl+E809XM4Bbvl8QHyxNfIXRzPSUOXP/VL
         aXxmxEpWV1segjuY6muocdMY+gAQl3irRNlJeG0z1ZRARdDRKHrOwFAtx3po5Mv/G9Qx
         kEH52BtXj0RAArLxiAjMIzBlwW6d9hmUheH4wC9/c/pWIjN59kvMYzS55C8bHywGV926
         78UQ==
X-Gm-Message-State: APjAAAWcf3hKgOwadMAKdws9cnmhzHBdywHzRIStgSTqgV/eGfI7nlQB
        3YaLFGMRN0+QGQmrvzrEnEA=
X-Google-Smtp-Source: APXvYqx48dOkQmEm1tNCTqDI4mtaxlvHziD9+umgMT12Os+WeD+ehjYsoNK61nzXA01l9vvfedGn3g==
X-Received: by 2002:a17:902:102a:: with SMTP id b39mr30745264pla.188.1556084645103;
        Tue, 23 Apr 2019 22:44:05 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id b14sm22871913pfi.92.2019.04.23.22.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 22:44:04 -0700 (PDT)
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
Date:   Wed, 24 Apr 2019 13:43:35 +0800
Message-Id: <20190424054335.30044-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CA+A7VXWMgx44=747MES=EvkLdrtQgyF3e+h5v7vQaAsHxbcedw@mail.gmail.com>
References: <CA+A7VXWMgx44=747MES=EvkLdrtQgyF3e+h5v7vQaAsHxbcedw@mail.gmail.com>
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
index 609fd6871c5a..13fb124d04a4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3071,6 +3071,19 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	*opcode = __le16_to_cpu(ev->opcode);
 	*status = skb->data[sizeof(*ev)];
 
+	if (opcode != HCI_OP_RESET && !hci_sent_cmd_data(hdev, *opcode)) {
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

