Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE99EC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8667D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDKCgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:36:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfDKCgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:36:17 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0B799636B293CBF9E36;
        Thu, 11 Apr 2019 10:36:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 10:36:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Faiz Abbas <faiz_abbas@ti.com>, Tony Lindgren <tony@atomide.com>,
        "Rob Herring" <robh@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] bus: ti-sysc: Use PTR_ERR_OR_ZERO in sysc_init_resets()
Date:   Thu, 11 Apr 2019 02:47:08 +0000
Message-ID: <20190411024708.123605-1-yuehaibing@huawei.com>
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

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/bus/ti-sysc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index b696f26a3894..2b93be2882f3 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -432,10 +432,7 @@ static int sysc_init_resets(struct sysc *ddata)
 {
 	ddata->rsts =
 		devm_reset_control_array_get_optional_exclusive(ddata->dev);
-	if (IS_ERR(ddata->rsts))
-		return PTR_ERR(ddata->rsts);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ddata->rsts);
 }
 
 /**





