Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E49C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CFE20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCDC64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:58:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbfCDC6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:58:55 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 78CFC7663C9E86319486;
        Mon,  4 Mar 2019 10:58:53 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 10:58:42 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/hns: Use GFP_ATOMIC in hns_roce_v2_modify_qp
Date:   Mon, 4 Mar 2019 10:56:20 +0800
Message-ID: <20190304025620.27224-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

In commit 0425e3e6e0c7, hns_roce_v2_modify_qp called inside
spinlock which using GFP_KERNEL, it may sleep with holding
the spinlock, so we should use GFP_ATOMIC instead.

Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8795266..1c54390 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4027,7 +4027,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	struct device *dev = hr_dev->dev;
 	int ret = -EINVAL;
 
-	context = kcalloc(2, sizeof(*context), GFP_KERNEL);
+	context = kcalloc(2, sizeof(*context), GFP_ATOMIC);
 	if (!context)
 		return -ENOMEM;
 
-- 
2.7.0


