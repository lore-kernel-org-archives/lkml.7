Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7951C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F324218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962335;
	bh=XAzFXlP87E7U02nFKK6K6OOe5SvtJALvL1QYzYr23jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7AvEiTeK5MKqB5sPp/6H0Qve4lwRf7cUHDWk4Qb7GFYteJE+4LrWka5X/0ZCpjfM
	 t4BMHkhicJpN2oAuQQKVJp8Dz2SJESqx/PHLE1Nmc9tAKbcqOEBVUCEA1Y5nl2bTSL
	 LpN8FNg1H6ocn+fM4HRwKCFbVW+DpdylasgNRXSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfDVTpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbfDVTp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8BB21904;
        Mon, 22 Apr 2019 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962327;
        bh=XAzFXlP87E7U02nFKK6K6OOe5SvtJALvL1QYzYr23jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPghD89ILPixmHttRQTp8F0PGCCUCByenA8XJUvHVUQ85e2z9qSZIhf2vFm9xvpFj
         F1Oz3plIXM4IqRHsiQV9+mLRlocsu5tDXgr0poWuIooID7hAwRawmatOCyGJf1uJa4
         ns4gWnLn6IWgTDDZxhmS3Qmbioe9KQSTzFvvC5+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/68] qlcnic: Avoid potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:44:14 -0400
Message-Id: <20190422194516.11634-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
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
index 3b0adda7cc9c..a4cd6f2cfb86 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
@@ -1048,6 +1048,8 @@ int qlcnic_do_lb_test(struct qlcnic_adapter *adapter, u8 mode)
 
 	for (i = 0; i < QLCNIC_NUM_ILB_PKT; i++) {
 		skb = netdev_alloc_skb(adapter->netdev, QLCNIC_ILB_PKT_SIZE);
+		if (!skb)
+			break;
 		qlcnic_create_loopback_buff(skb->data, adapter->mac_addr);
 		skb_put(skb, QLCNIC_ILB_PKT_SIZE);
 		adapter->ahw->diag_cnt = 0;
-- 
2.19.1

