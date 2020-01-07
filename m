Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9BEC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A18208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgAGOP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:15:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727658AbgAGOPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:15:25 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB622E7F510142F69EB6;
        Tue,  7 Jan 2020 22:15:22 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 Jan 2020
 22:15:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <claudiu.manoil@nxp.com>, <davem@davemloft.net>,
        <vladimir.oltean@nxp.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] enetc: Fix inconsistent IS_ERR and PTR_ERR
Date:   Tue, 7 Jan 2020 22:14:54 +0800
Message-ID: <20200107141454.44420-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proper pointer to be passed as argument is hw
Detected using Coccinelle.

Fixes: 6517798dd343 ("enetc: Make MDIO accessors more generic and export to include/linux/fsl")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 87c0e96..ebc635f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -27,7 +27,7 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	}
 
 	hw = enetc_hw_alloc(dev, port_regs);
-	if (IS_ERR(enetc_hw_alloc)) {
+	if (IS_ERR(hw)) {
 		err = PTR_ERR(hw);
 		goto err_hw_alloc;
 	}
-- 
2.7.4


