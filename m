Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A1C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2948921855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDFHoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:44:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbfDFHop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:44:45 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48271FAEE99888B2F811;
        Sat,  6 Apr 2019 15:44:41 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sat, 6 Apr 2019 15:44:35 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: set vport alive state to default while resetting
Date:   Sat, 6 Apr 2019 15:43:25 +0800
Message-ID: <1554536616-24977-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554536616-24977-1-git-send-email-tanhuazhong@huawei.com>
References: <1554536616-24977-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resetting, the vport alive state should be set to default,
otherwise the alive state of the vport whose driver not running
is wrong before the timer to check it out.

Fixes: a6d818e31d08 ("net: hns3: Add vport alive state checking support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f51e4c0..62e3436d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7732,7 +7732,7 @@ static void hclge_reset_vport_state(struct hclge_dev *hdev)
 	int i;
 
 	for (i = 0; i < hdev->num_alloc_vport; i++) {
-		hclge_vport_start(vport);
+		hclge_vport_stop(vport);
 		vport++;
 	}
 }
-- 
2.7.4

