Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA147C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F42205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfHVGab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:30:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731704AbfHVGa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:30:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 992F78137E4BCBF7F2E6;
        Thu, 22 Aug 2019 14:30:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 22 Aug 2019 14:30:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] phy: tegra: Use PTR_ERR_OR_ZERO in tegra_p2u_probe()
Date:   Thu, 22 Aug 2019 06:34:07 +0000
Message-ID: <20190822063407.71148-1-yuehaibing@huawei.com>
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
 drivers/phy/tegra/phy-tegra194-p2u.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
index 7042bed9feaa..42394d27f4cb 100644
--- a/drivers/phy/tegra/phy-tegra194-p2u.c
+++ b/drivers/phy/tegra/phy-tegra194-p2u.c
@@ -92,10 +92,7 @@ static int tegra_p2u_probe(struct platform_device *pdev)
 	phy_set_drvdata(generic_phy, phy);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (IS_ERR(phy_provider))
-		return PTR_ERR(phy_provider);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
 static const struct of_device_id tegra_p2u_id_table[] = {





