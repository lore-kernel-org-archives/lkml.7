Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7109B21873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfCUImj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:42:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56832 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfCUImj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:42:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD7CBC2C4B610DF8AE31;
        Thu, 21 Mar 2019 16:42:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Mar 2019 16:42:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] phy: tegra: xusb: fix typo in tegra186_usb2_pad_probe()
Date:   Thu, 21 Mar 2019 08:54:36 +0000
Message-ID: <20190321085436.94975-1-weiyongjun1@huawei.com>
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

Fix a typo in tegra186_usb2_pad_probe(), 'usb2->clk' should be
'priv->usb2_trk_clk'.

Fixes: b8998e928030 ("phy: tegra: xusb: Add Tegra186 support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 11ad6e4e4711..a627fe0b8e54 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -467,8 +467,8 @@ tegra186_usb2_pad_probe(struct tegra_xusb_padctl *padctl,
 	}
 
 	priv->usb2_trk_clk = devm_clk_get(&pad->dev, "trk");
-	if (IS_ERR(usb2->clk)) {
-		err = PTR_ERR(usb2->clk);
+	if (IS_ERR(priv->usb2_trk_clk)) {
+		err = PTR_ERR(priv->usb2_trk_clk);
 		dev_dbg(&pad->dev, "failed to get usb2 trk clock: %d\n", err);
 		goto unregister;
 	}



