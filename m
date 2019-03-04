Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D7220835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1qz3qmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCDUX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:23:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41030 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:23:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25so5488857ljk.8;
        Mon, 04 Mar 2019 12:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EP7kobiM7i4e4gTW+ePMwIQha5ZXCOzWcTEoP21tTEU=;
        b=h1qz3qmBkYPQeHVKfsDHE4SKAU+VhuBM7V9cMpwWDsaet8DspyTG+QAxd3F8n7Ijwh
         6NmBvONNCKkTjulbv7Iu77j6TcVB4Ou3/N2Y6a/S0oHCn5kRsaugCgNRanv7nkK0b6Il
         xXNgdKnWavVx6KWSgADhUWAf3bBWGqX7c4BkIf0+cbFRgnm41Z695LYFPlxu0v084Tpx
         gBMS72j8eCpwR0rSHBP5aLTVLfHg8C+OtYJUGNOt4te8Xc73p8+NqH+KIaj5hj4HHKra
         7PZdHGijIb9TFbZ8qRct3jNLgxiFwcX8NZ4aoQFfFVZajRBZ22ubbMBdQbm4QGPQa6O5
         MtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EP7kobiM7i4e4gTW+ePMwIQha5ZXCOzWcTEoP21tTEU=;
        b=SXn6Pa4/cqrvrzb7Gw4P1gTkfLWf+H4sRxIOw1bYvlv5P4xAnqI04f7hmotd9GFQxO
         g/5Hf19QggZ3zUX4BD1sWLwsaDOA1QZwFei+BtGpabghHlnO8cb2VXL1CbW74JXBBwJ6
         FG4TA1SG31pAUi6kiKVhIA8omIy9HZQbQcE8TJSTvsGs7kDC2mjCS7ooAvMpGA3mCmrT
         D682zJhaZPaLzozlyxAm/rUwZ9zfCNbmYrGe3ktVsTR8PqH973TsZ8EZBTHEqzoBxb5p
         Bn7Meu4oC3jX85+YnHyKz8z7hPA9nHJC0Q6izm1NNJfYfUch1fVpHu057WzQIqFRPYSF
         0W7g==
X-Gm-Message-State: APjAAAVY9jmvuyDkuKGVvS3EBwcFtPvdhwHpdIwb7ersxYXFCck3V7Q2
        hukdXHEozUyCaRCydAnb4ps=
X-Google-Smtp-Source: APXvYqwM2NRmI3pKBUBaf/ym7D1EZWV4Sb2kp6SZZrDHSWK9d0IzYUkJSN9Upf/PxKBc3jokfc4AXw==
X-Received: by 2002:a2e:980e:: with SMTP id a14mr11458897ljj.177.1551731005196;
        Mon, 04 Mar 2019 12:23:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa7:4000:561e:3eff:d48d:3612:5c09])
        by smtp.gmail.com with ESMTPSA id e23sm1699976ljj.3.2019.03.04.12.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 12:23:24 -0800 (PST)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] net/bluetooth: Fix bound check in event handling
Date:   Mon,  4 Mar 2019 21:20:43 +0100
Message-Id: <20190304202043.3691-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190228195939.30685-1-tomasbortoli@gmail.com>
References: <20190228195939.30685-1-tomasbortoli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hci_inquiry_result_with_rssi_evt() can perform out of bound reads
on skb->data as a bound check is missing.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
Reported-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com
---
v2: 
 - changed sizeof(info) into sizeof(*info), as it should be. 
 - simplified expression in if

 net/bluetooth/hci_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2826ce162b..4cbad1e1a322 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3978,11 +3978,15 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
 		struct inquiry_info_with_rssi_and_pscan_mode *info;
+		void *data_end = (void *)skb->data + skb->len;
 		info = (void *) (skb->data + 1);
 
 		for (; num_rsp; num_rsp--, info++) {
 			u32 flags;
 
+			if ((void *)info + sizeof(*info) > data_end)
+				break;
+
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
-- 
2.11.0

