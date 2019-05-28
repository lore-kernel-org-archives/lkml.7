Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD9C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835E92075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfE1JEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:04:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727457AbfE1JEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:04:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7320177CBAF3EBD60590;
        Tue, 28 May 2019 17:04:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 May 2019 17:04:25 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 02/12] net: hns3: fix for HNS3_RXD_GRO_SIZE_M macro
Date:   Tue, 28 May 2019 17:02:52 +0800
Message-ID: <1559034182-24737-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559034182-24737-1-git-send-email-tanhuazhong@huawei.com>
References: <1559034182-24737-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

According to hardware user menual, the GRO_SIZE is 14 bits width,
the HNS3_RXD_GRO_SIZE_M is 10 bits width now, which may cause
hardware GRO received packet error problem.

Fixes: a6d53b97a2e7 ("net: hns3: Adds GRO params to SKB for the stack")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index c14480f..408efd5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -145,7 +145,7 @@ enum hns3_nic_state {
 #define HNS3_RXD_TSIND_M			(0x7 << HNS3_RXD_TSIND_S)
 #define HNS3_RXD_LKBK_B				15
 #define HNS3_RXD_GRO_SIZE_S			16
-#define HNS3_RXD_GRO_SIZE_M			(0x3ff << HNS3_RXD_GRO_SIZE_S)
+#define HNS3_RXD_GRO_SIZE_M			(0x3fff << HNS3_RXD_GRO_SIZE_S)
 
 #define HNS3_TXD_L3T_S				0
 #define HNS3_TXD_L3T_M				(0x3 << HNS3_TXD_L3T_S)
-- 
2.7.4

