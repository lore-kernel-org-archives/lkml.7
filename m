Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D02C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71922089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJKFZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:25:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfJKFZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:25:21 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 317B86ADC63DE4083DD0;
        Fri, 11 Oct 2019 13:25:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 11 Oct 2019 13:25:03 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] soc: ti: omap-prm: fix return value check in omap_prm_probe()
Date:   Fri, 11 Oct 2019 05:24:36 +0000
Message-ID: <20191011052436.76075-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: 3e99cb214f03 ("soc: ti: add initial PRM driver with reset control support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/ti/omap_prm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index db47a8bceb87..96c6f777519c 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -375,8 +375,8 @@ static int omap_prm_probe(struct platform_device *pdev)
 	prm->data = data;
 
 	prm->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!prm->base)
-		return -ENOMEM;
+	if (IS_ERR(prm->base))
+		return PTR_ERR(prm->base);
 
 	return omap_prm_reset_init(pdev, prm);
 }



