Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E367C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E11A2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHQCYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:24:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbfHQCYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:24:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3B87198C6DC8978AF07;
        Sat, 17 Aug 2019 10:24:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Sat, 17 Aug 2019 10:24:23 +0800
From:   Yonglong Liu <liuyonglong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH net-next] net: hns: add phy_attached_info() to the hns driver
Date:   Sat, 17 Aug 2019 10:21:17 +0800
Message-ID: <1566008477-16554-1-git-send-email-liuyonglong@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the call to phy_attached_info() to the hns driver
to identify which exact PHY drivers is in use.

Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 1545536..a48396d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1182,6 +1182,8 @@ int hns_nic_init_phy(struct net_device *ndev, struct hnae_handle *h)
 	if (unlikely(ret))
 		return -ENODEV;
 
+	phy_attached_info(phy_dev);
+
 	return 0;
 }
 
-- 
2.8.1

