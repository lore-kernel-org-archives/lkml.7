Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D31BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7EA21D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640219;
	bh=YYJYdFm48ZsJMUlQy0NaxXt6BO854VGqsxoxQjZveWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mjeAn9+RBvqd4Y0jd1qCBSQdLkw71ZdyMyEDjVuPAH9n5R8sm8yYYSkvISt66C5WP
	 cDCiB449ZMuT5N/JCYQ0jXcCjapKLm3U2LBJh2PI4D8fY+rqhovrjmIxdczPeg2vSk
	 jafikpd8DccP8z/57OnYo41pN4Z8ThwzJ+fC4lgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfL2RXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfL2RXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:23:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B1A208E4;
        Sun, 29 Dec 2019 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640214;
        bh=YYJYdFm48ZsJMUlQy0NaxXt6BO854VGqsxoxQjZveWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lakirUxGO9NxHAHhDHCDCjZdHgwwNicGXduMuaekGFgpbwxPT3VXKcwYF0GC3v4sE
         vYNlxZnto0qS3bZxFhG5NlQ9rosrHHKPc2aEnZQd85S07dsThZxIKX8yZEB8Dg1gsb
         G6X0YAQJmm9DVGdtS0XLUXXTNu38ZL6j32EckqWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/161] Bluetooth: hci_core: fix init for HCI_USER_CHANNEL
Date:   Sun, 29 Dec 2019 18:18:33 +0100
Message-Id: <20191229162419.014024111@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
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
index d6d7364838f4..ff80a9d41ce1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4215,7 +4215,14 @@ static void hci_rx_work(struct work_struct *work)
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



