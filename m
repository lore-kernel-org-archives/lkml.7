Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C3FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EDE2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214990;
	bh=bxAO4w5X5zEmrbHOpKpbvHsXKjaiz0sk0Z5cc1tOT0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VNLHkoiObSFBXJMrIZx07ZnyxASRep7yrb0m9Hk5otP+Z+CTcugL/Pi+Kjz8dM7WF
	 +xLjzJ6xpnSaMBgJL4YN2wkfyWSLEcJa6/rTS2qZegapx2WGVcccNPLhdgRgIvE90N
	 MJUEqhpX+jhULK2Ou3YhLMiU++8FXr1k8AOBFdkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfKHLjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387899AbfKHLjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:39:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C344521D6C;
        Fri,  8 Nov 2019 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213183;
        bh=bxAO4w5X5zEmrbHOpKpbvHsXKjaiz0sk0Z5cc1tOT0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+g3NQT14QfPk77ELNbBD1xl0kw8VbYnp/2xhjqYb12RkXejwPnexwWDPYXeTS1Uh
         GKRRfKJzk8KBvT5XQe0GTzNJJzgStjilahwLsS+lR/4bmxepTRUR4sBVdez3I8lIBx
         I6SI93XQA1aMvT+pqEalHTbDM3CLYzxx1PLfQOro=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 074/205] net: hns3: Change the dst mac addr of loopback packet
Date:   Fri,  8 Nov 2019 06:35:41 -0500
Message-Id: <20191108113752.12502-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 7f7d9e501f4123e64b130576621d24f9379adc8f ]

Currently, the dst mac addr of loopback packet is the same as
the host' mac addr, the SSU component may loop back the packet
to host before the packet reaches mac or serdes, which will defect
the purpose of mac or serdes selftest.

This patch changes it by adding 0x1f to the last byte of dst mac
addr.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 5bdcd92d86122..0c34ea1223580 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -137,6 +137,7 @@ static void hns3_lp_setup_skb(struct sk_buff *skb)
 	packet = skb_put(skb, HNS3_NIC_LB_TEST_PACKET_SIZE);
 
 	memcpy(ethh->h_dest, ndev->dev_addr, ETH_ALEN);
+	ethh->h_dest[5] += 0x1f;
 	eth_zero_addr(ethh->h_source);
 	ethh->h_proto = htons(ETH_P_ARP);
 	skb_reset_mac_header(skb);
-- 
2.20.1

