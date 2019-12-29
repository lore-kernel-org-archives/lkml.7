Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64215C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3DA206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641265;
	bh=sA8eLhluhSMs7/Y3L4AlWclq8bPsmkhxG0GMjZ9tt6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DXnr5PHF4eR6l92NwAnwJlRKH2VIKkmAlSfcjuatThcHHrLheqeaYkjdJdEbCxwOf
	 0eESRLIkCMHa0voQydNnt+tiHaiymcLvrZyvVaiLpYddupN7Pybst+K3fn5NUMtcsQ
	 9GPFfAaxu8XpGVG5QHplSa2mdF3tQ6pXBADiKkPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfL2RlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:41:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbfL2Ra4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:30:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D010207FD;
        Sun, 29 Dec 2019 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640655;
        bh=sA8eLhluhSMs7/Y3L4AlWclq8bPsmkhxG0GMjZ9tt6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoKi6YnnIpGgA8uVyg09coO0q87Vk1W927ZGKF+D8V7a66iHPpdNpxkvWByA0N7vt
         KJT+wNdTX8kvzmxZ3HKJHFNPqvHdKoVOX3OeFKdkmmzJFYyMjnWSq99xQP8bD5ExUs
         1lLvSmEG3kC3BGQc4dX6b2P5SB4bPjefJ9bYZ3do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/219] Bluetooth: hci_core: fix init for HCI_USER_CHANNEL
Date:   Sun, 29 Dec 2019 18:18:05 +0100
Message-Id: <20191229162518.074127450@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mattijs Korpershoek <mkorpershoek@baylibre.com>

[ Upstream commit eb8c101e28496888a0dcfe16ab86a1bee369e820 ]

During the setup() stage, HCI device drivers expect the chip to
acknowledge its setup() completion via vendor specific frames.

If userspace opens() such HCI device in HCI_USER_CHANNEL [1] mode,
the vendor specific frames are never tranmitted to the driver, as
they are filtered in hci_rx_work().

Allow HCI devices which operate in HCI_USER_CHANNEL mode to receive
frames if the HCI device is is HCI_INIT state.

[1] https://www.spinics.net/lists/linux-bluetooth/msg37345.html

Fixes: 23500189d7e0 ("Bluetooth: Introduce new HCI socket channel for user operation")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e0de9a609265..e03faca84919 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4330,7 +4330,14 @@ static void hci_rx_work(struct work_struct *work)
 			hci_send_to_sock(hdev, skb);
 		}
 
-		if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		/* If the device has been opened in HCI_USER_CHANNEL,
+		 * the userspace has exclusive access to device.
+		 * When device is HCI_INIT, we still need to process
+		 * the data packets to the driver in order
+		 * to complete its setup().
+		 */
+		if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    !test_bit(HCI_INIT, &hdev->flags)) {
 			kfree_skb(skb);
 			continue;
 		}
-- 
2.20.1



