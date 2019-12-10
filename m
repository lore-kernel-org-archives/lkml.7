Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21205C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB0C246A3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012164;
	bh=3GPtx5pUqQWxEANxlsUwjXgjJlKI6nkAA0UcNLDxKqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ejsB8hdZ7GYw3m3biiRm5TYFHSswByB7hGUIoXt2n7QiVghxKQeIABFd4JtW+HCFT
	 7/HjiHBVJ9GqXOB0YposzLxULMrN0y1WcvK6AF1nWdDDR17OSMtXxxT5+2ijQgy+rO
	 3cRD288VJmVRv779/cIvRqHeL3Z6cjdb0eXVUZt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfLJVJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:09:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbfLJVJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857F824687;
        Tue, 10 Dec 2019 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012159;
        bh=3GPtx5pUqQWxEANxlsUwjXgjJlKI6nkAA0UcNLDxKqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3X9VgnGFfvms8rtexKBhMnvCmAEfFpBFX3P8YJf9WNhnvNAcmgKRhVJB6TwvHiR4
         exozn3Z9Wkzm4dlyXn6hsUC3y9BFTJjSya/CJSqiDxzn8EiIVBkySVgzgifftTswsw
         rU8kqChtjrvXXuh7c42c5p+WDpdD2hPxRq05+/v4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 121/350] Bluetooth: hci_core: fix init for HCI_USER_CHANNEL
Date:   Tue, 10 Dec 2019 16:03:46 -0500
Message-Id: <20191210210735.9077-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index b2559d4bed815..0cc9ce9172229 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4440,7 +4440,14 @@ static void hci_rx_work(struct work_struct *work)
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

