Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9060CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DB0208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355367;
	bh=cOvdCOcKRIUMA17RsSGKk8JBcOVGa9f5VjXMvf73OFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QK8g05ouNhKp+zQF1PjoW96BOh7k7x6qhiF310dBcaSBIhXibmTbERYEY5683Ct6Y
	 g+KK9/1wAwCJNU2r+Bx+aNfSPmUAs8k/ufC1P7s76XaQt/SxVjWaJWOtJQkGwT+geJ
	 BRprK9y7q3V4nXKEDCKEqQzu8YuyEFKnIrpOUINY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfKJDJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbfKJCoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:44:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB3321850;
        Sun, 10 Nov 2019 02:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353877;
        bh=cOvdCOcKRIUMA17RsSGKk8JBcOVGa9f5VjXMvf73OFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaEIL+Qk+easAasPKTvVz/VfgbQ9qQ7vSQiUuOvUFYxN6XzS05z5nnIVxMcWOQGMJ
         y841AtFviWFJizRNmFOtIcBDXiTZdcqa40tKbCmGAHZJvqRdVSCOVCZJB6OFw+X9m5
         mNnQIbZRil0ULyCO7gMTBMArTKa9uT4spBUkQo3A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 155/191] Bluetooth: btrsi: fix bt tx timeout issue
Date:   Sat,  9 Nov 2019 21:39:37 -0500
Message-Id: <20191110024013.29782-155-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>

[ Upstream commit 7cbfd1e2aad410d96fa6162aeb3f9cff1fecfc58 ]

observed sometimes data is coming with unaligned address from kernel
BT stack. If unaligned address is passed, some data in payload is
stripped when packet is loading to firmware and this results, BT
connection timeout is happening.

sh# hciconfig hci0 up
Can't init device hci0: hci0 command 0x0c03 tx timeout

Fixed this by moving the data to aligned address.

Signed-off-by: Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>
Signed-off-by: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btrsi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
index 60d1419590bab..3951f7b238404 100644
--- a/drivers/bluetooth/btrsi.c
+++ b/drivers/bluetooth/btrsi.c
@@ -21,8 +21,9 @@
 #include <net/rsi_91x.h>
 #include <net/genetlink.h>
 
-#define RSI_HEADROOM_FOR_BT_HAL	16
+#define RSI_DMA_ALIGN	8
 #define RSI_FRAME_DESC_SIZE	16
+#define RSI_HEADROOM_FOR_BT_HAL	(RSI_FRAME_DESC_SIZE + RSI_DMA_ALIGN)
 
 struct rsi_hci_adapter {
 	void *priv;
@@ -70,6 +71,16 @@ static int rsi_hci_send_pkt(struct hci_dev *hdev, struct sk_buff *skb)
 		bt_cb(new_skb)->pkt_type = hci_skb_pkt_type(skb);
 		kfree_skb(skb);
 		skb = new_skb;
+		if (!IS_ALIGNED((unsigned long)skb->data, RSI_DMA_ALIGN)) {
+			u8 *skb_data = skb->data;
+			int skb_len = skb->len;
+
+			skb_push(skb, RSI_DMA_ALIGN);
+			skb_pull(skb, PTR_ALIGN(skb->data,
+						RSI_DMA_ALIGN) - skb->data);
+			memmove(skb->data, skb_data, skb_len);
+			skb_trim(skb, skb_len);
+		}
 	}
 
 	return h_adapter->proto_ops->coex_send_pkt(h_adapter->priv, skb,
-- 
2.20.1

