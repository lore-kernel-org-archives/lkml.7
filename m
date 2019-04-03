Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E57C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8632084A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfDCDJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:09:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfDCDJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:09:20 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 138EFDA103D3E8451D60;
        Wed,  3 Apr 2019 11:09:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Apr 2019 11:09:07 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: check 1000M half for hns3_ethtool_ops.set_link_ksettings
Date:   Wed, 3 Apr 2019 11:07:50 +0800
Message-ID: <1554260881-44948-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
References: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

Hip08 SOC does not support 1000M half, this patch adds 1000M half
check for hns3_ethtool_ops.set_link_ksettings, so the user can not
set 1000M half by ethtool.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 359d473..0c05807 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -648,6 +648,10 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 static int hns3_set_link_ksettings(struct net_device *netdev,
 				   const struct ethtool_link_ksettings *cmd)
 {
+	/* Chip don't support this mode. */
+	if (cmd->base.speed == SPEED_1000 && cmd->base.duplex == DUPLEX_HALF)
+		return -EINVAL;
+
 	/* Only support ksettings_set for netdev with phy attached for now */
 	if (netdev->phydev)
 		return phy_ethtool_ksettings_set(netdev->phydev, cmd);
-- 
2.7.4

