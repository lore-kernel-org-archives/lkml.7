Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E0C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81EB23BED
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfE2PPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:15:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfE2PPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:15:14 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE78CCC4E649143F95DF;
        Wed, 29 May 2019 23:10:30 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 29 May 2019
 23:10:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: phy: mv-usb: Remove set but not used variable 'phy'
Date:   Wed, 29 May 2019 23:09:39 +0800
Message-ID: <20190529150939.24368-1-yuehaibing@huawei.com>
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

drivers/usb/phy/phy-mv-usb.c: In function mv_otg_work:
drivers/usb/phy/phy-mv-usb.c:404:18: warning: variable phy set but not used [-Wunused-but-set-variable]

It's no used since commit e47d92545c29 ("usb: move
the OTG state from the USB PHY to the OTG structure")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/phy/phy-mv-usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
index cfd9add10bf4..cf7ecdc9a9d4 100644
--- a/drivers/usb/phy/phy-mv-usb.c
+++ b/drivers/usb/phy/phy-mv-usb.c
@@ -401,7 +401,6 @@ static void mv_otg_update_state(struct mv_otg *mvotg)
 static void mv_otg_work(struct work_struct *work)
 {
 	struct mv_otg *mvotg;
-	struct usb_phy *phy;
 	struct usb_otg *otg;
 	int old_state;
 
@@ -409,7 +408,6 @@ static void mv_otg_work(struct work_struct *work)
 
 run:
 	/* work queue is single thread, or we need spin_lock to protect */
-	phy = &mvotg->phy;
 	otg = mvotg->phy.otg;
 	old_state = otg->state;
 
-- 
2.17.1


