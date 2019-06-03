Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB06C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A998427AC0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfFCCLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 22:11:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbfFCCLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:11:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06953753F379BBA51B8D;
        Mon,  3 Jun 2019 10:11:01 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 3 Jun 2019 10:10:52 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 08/10] net: hns3: remove setting bit of reset_requests when handling mac tunnel interrupts
Date:   Mon, 3 Jun 2019 10:09:20 +0800
Message-ID: <1559527762-22931-9-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559527762-22931-1-git-send-email-tanhuazhong@huawei.com>
References: <1559527762-22931-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

We shouldn't set HNAE3_NONE_RESET bit of the variable that represents a
reset request during handling of MSI-X errors, or may cause issue when
trigger reset.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 55c4a1b..83b07ce 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1783,7 +1783,6 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		ret = hclge_clear_mac_tnl_int(hdev);
 		if (ret)
 			dev_err(dev, "clear mac tnl int failed (%d)\n", ret);
-		set_bit(HNAE3_NONE_RESET, reset_requests);
 	}
 
 msi_error:
-- 
2.7.4

