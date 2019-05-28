Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A393C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAAC2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfE1NqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:46:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbfE1NqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:46:17 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AFBA132D07E88EBBD51B;
        Tue, 28 May 2019 21:46:09 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 21:46:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <patrice.chotard@st.com>, <stern@rowland.harvard.edu>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: host: ehci-st: Remove set but not used variable 'ehci'
Date:   Tue, 28 May 2019 21:45:29 +0800
Message-ID: <20190528134529.17612-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/usb/host/ehci-st.c: In function st_ehci_platform_probe:
drivers/usb/host/ehci-st.c:155:19: warning: variable ehci set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/host/ehci-st.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index dc42981047c9..ccb4e611001d 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -152,7 +152,6 @@ static int st_ehci_platform_probe(struct platform_device *dev)
 	struct resource *res_mem;
 	struct usb_ehci_pdata *pdata = &ehci_platform_defaults;
 	struct st_ehci_platform_priv *priv;
-	struct ehci_hcd *ehci;
 	int err, irq, clk = 0;
 
 	if (usb_disabled())
@@ -177,7 +176,6 @@ static int st_ehci_platform_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, hcd);
 	dev->dev.platform_data = pdata;
 	priv = hcd_to_ehci_priv(hcd);
-	ehci = hcd_to_ehci(hcd);
 
 	priv->phy = devm_phy_get(&dev->dev, "usb");
 	if (IS_ERR(priv->phy)) {
-- 
2.17.1


