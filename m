Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B49C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EB2217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544266;
	bh=hl/OAN47ZI2pvB/0h4qSo+T3TDhlaN3EDam5x9FQ3wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yIq0zuNnazoJBm3RnK+D0rleFdLXVr2lKLt59HJWeVZVy8+XO2Pc4VWkf3jyNzSaq
	 6rA1nTAwS6iwn0tQkR7f8086lXOH1SWLEk/8m1vh5GQ4nc8PU0y/8ufexBsff6213p
	 N2njCd1ADGjB7NcjI4dTPTOg4xssVZAPVFzWkNgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfFNUbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfFNUay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:54 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BBC21848;
        Fri, 14 Jun 2019 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544253;
        bh=hl/OAN47ZI2pvB/0h4qSo+T3TDhlaN3EDam5x9FQ3wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGWQ74y+XfhSAy83/XVRWlU1BcDftD4tJ05UoO6XmFp2RbkUUFTQIHeSIGf4/x6Oa
         SI//Sp4puX6lMxzUQud3QcxduURv7K41JG6IP1TH40zqiS9ew+y394ZYBPLlNxEW/B
         XZYk5F2n98GtMLTGObffYAzW3SMfE8SRuR0sYzJs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 05/10] net: hns: Fix loopback test failed at copper ports
Date:   Fri, 14 Jun 2019 16:30:41 -0400
Message-Id: <20190614203046.28077-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614203046.28077-1-sashal@kernel.org>
References: <20190614203046.28077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 2e1f164861e500f4e068a9d909bbd3fcc7841483 ]

When doing a loopback test at copper ports, the serdes loopback
and the phy loopback will fail, because of the adjust link had
not finished, and phy not ready.

Adds sleep between adjust link and test process to fix it.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 4b91eb70c683..a2f2db58b5ab 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -351,6 +351,7 @@ static int __lb_setup(struct net_device *ndev,
 static int __lb_up(struct net_device *ndev,
 		   enum hnae_loop loop_mode)
 {
+#define NIC_LB_TEST_WAIT_PHY_LINK_TIME 300
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 	struct hnae_handle *h = priv->ae_handle;
 	int speed, duplex;
@@ -389,6 +390,9 @@ static int __lb_up(struct net_device *ndev,
 
 	h->dev->ops->adjust_link(h, speed, duplex);
 
+	/* wait adjust link done and phy ready */
+	msleep(NIC_LB_TEST_WAIT_PHY_LINK_TIME);
+
 	return 0;
 }
 
-- 
2.20.1

