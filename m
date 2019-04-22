Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72F0C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E522075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962731;
	bh=i/Hk42MjRmEKOufWAx5j5IUON21NA4y3ONE3MnQ3DZU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PkJnu3U2/1CZU1SmT2eAIXqt4pAcOmtEQ/Z53WKZoJENUFzwquVR2b1EdS2RDveWX
	 f7+Wq2L8ZW9UQdPKespZOQw46D+ByZWCRbCMyHbtzGgdoAN5SMkVWaPGE42wjTI03u
	 R1q3uKQn0H1JqJNpI0Oi6rkTFbOIMxVBtqCadRKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfDVTwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbfDVTuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:50:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C39A204EC;
        Mon, 22 Apr 2019 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962624;
        bh=i/Hk42MjRmEKOufWAx5j5IUON21NA4y3ONE3MnQ3DZU=;
        h=From:To:Cc:Subject:Date:From;
        b=Rie3GtlL6w6URfDZNF2mCww5Lw7Qk/7js8AHVaedzhSu95cAlkiM+U450O6eCT3y8
         7zHBO0m00MrZoCqY9FSzBQaJP2EbrYS0kD1Sqjdn1j5Jb1TAY8iDG7r0g75ObWKIdU
         Rqj6gFY2IIsTwAxnoY56fs98qZQh48fOObotsl9U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 01/15] qlcnic: Avoid potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:50:08 -0400
Message-Id: <20190422195022.13760-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 5bf7295fe34a5251b1d241b9736af4697b590670 ]

netdev_alloc_skb can fail and return a NULL pointer which is
dereferenced without a check. The patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
index 0a2318cad34d..63ebc491057b 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
@@ -1038,6 +1038,8 @@ int qlcnic_do_lb_test(struct qlcnic_adapter *adapter, u8 mode)
 
 	for (i = 0; i < QLCNIC_NUM_ILB_PKT; i++) {
 		skb = netdev_alloc_skb(adapter->netdev, QLCNIC_ILB_PKT_SIZE);
+		if (!skb)
+			break;
 		qlcnic_create_loopback_buff(skb->data, adapter->mac_addr);
 		skb_put(skb, QLCNIC_ILB_PKT_SIZE);
 		adapter->ahw->diag_cnt = 0;
-- 
2.19.1

