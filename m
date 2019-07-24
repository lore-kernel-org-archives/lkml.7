Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA72C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000435;
	bh=Ic/A8kNZeS40Gc0OvdGwgwwBx7unIcFf4oygHMb8BtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uzTE33dQ3dyO5RWChh4Xcs2uWlW8BdcTGU/8OsjO1cxuV8V9ZFac5X3Gb/fr6ZsLk
	 4Y4nnMcrPS0IVknNtPt4icoX8yHiQQA8RLZHH4w7t/XXFNfJL4eMKeVGE4ds9P2tdE
	 r0mUG3WLN1AtgGaUpZLCgODp/wSP+3nTiQENG4uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfGXUdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbfGXT1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:27:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F126E229F3;
        Wed, 24 Jul 2019 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996457;
        bh=Ic/A8kNZeS40Gc0OvdGwgwwBx7unIcFf4oygHMb8BtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xKKjID04RdVsntC3MYGfAwTUwfDjJjX5nfKtdQU4KZKjfSFc4vdPDoxAcHjPGd3Z6
         FH+Vqv8KxXByrOs3RkMxVci27EKSntrNz8knvnCBGTG1l04B7aaNcFEi3ZZODCPKRw
         1Fkq8xZATG4lhnJFppSLRXlxPy+ZG7dOasDCUIsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 103/413] net: hns3: fix for skb leak when doing selftest
Date:   Wed, 24 Jul 2019 21:16:34 +0200
Message-Id: <20190724191742.593413313@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8f9eed1a8791b83eb1c54c261d68424717e4111e ]

If hns3_nic_net_xmit does not return NETDEV_TX_BUSY when doing
a loopback selftest, the skb is not freed in hns3_clean_tx_ring
or hns3_nic_net_xmit, which causes skb not freed problem.

This patch fixes it by freeing skb when hns3_nic_net_xmit does
not return NETDEV_TX_OK.

Fixes: c39c4d98dc65 ("net: hns3: Add mac loopback selftest support in hns3 driver")

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index d1588ea6132c..24fce343e7fc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -243,11 +243,13 @@ static int hns3_lp_run_test(struct net_device *ndev, enum hnae3_loop mode)
 
 		skb_get(skb);
 		tx_ret = hns3_nic_net_xmit(skb, ndev);
-		if (tx_ret == NETDEV_TX_OK)
+		if (tx_ret == NETDEV_TX_OK) {
 			good_cnt++;
-		else
+		} else {
+			kfree_skb(skb);
 			netdev_err(ndev, "hns3_lb_run_test xmit failed: %d\n",
 				   tx_ret);
+		}
 	}
 	if (good_cnt != HNS3_NIC_LB_TEST_PKT_NUM) {
 		ret_val = HNS3_NIC_LB_TEST_TX_CNT_ERR;
-- 
2.20.1



