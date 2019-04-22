Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E926C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAE220811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963914;
	bh=xWgWZ3Lmtlok9IAC7abCqCuxyR2pJ+8a5auV0DHO3zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OtTq1eh06P49u96+hC482jYicp1JvvpA2hZ0a2bDPLzeDg4RIP5iTeL9yLLf//hYs
	 tlBzelvyoX3FoqNsvgmJzFg+mHXkjJH+vQQi0++qMuchkBVGKWBQjLr+xUDuorvhyU
	 qaQLYq2Vx/v7KitqPriBi2pLfDrGTXFsaM5r4QiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfDVTmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfDVTmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3475621738;
        Mon, 22 Apr 2019 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962129;
        bh=xWgWZ3Lmtlok9IAC7abCqCuxyR2pJ+8a5auV0DHO3zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AE0C6KewJy5bRSQgMDawalVCG77T0QonlU0QOCD3tBbxf0q/tZBx2xZgO40thlxXA
         AtQCG0NONqhL+ywHF+WP9/EJQXzE4VfjVYN/GvigQ4yc3O1GfbqBo/reE0SvDQRRnP
         xZGvE1iWQ4vhg2wY4Gw0Z29q9kZMgyyXS0SacJK0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 04/98] mt76x02: fix hdr pointer in write txwi for USB
Date:   Mon, 22 Apr 2019 15:40:31 -0400
Message-Id: <20190422194205.10404-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislaw Gruszka <sgruszka@redhat.com>

[ Upstream commit 7b25d3b8e485c7721cba9c71b44d1c286e61c8e7 ]

Since we add txwi at the begining of skb->data, it no longer point
to ieee80211_hdr. This breaks settings TS bit for probe response and
beacons.

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 81970cf777c0..8cafa5a749ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -81,8 +81,9 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 
 	mt76x02_insert_hdr_pad(skb);
 
-	txwi = skb_push(skb, sizeof(struct mt76x02_txwi));
+	txwi = (struct mt76x02_txwi *)(skb->data - sizeof(struct mt76x02_txwi));
 	mt76x02_mac_write_txwi(dev, txwi, skb, wcid, sta, len);
+	skb_push(skb, sizeof(struct mt76x02_txwi));
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, skb);
 	txwi->pktid = pid;
-- 
2.19.1

