Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48797C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019892173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGQOuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:50:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfGQOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:50:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C24388FE867EE1C592AC;
        Wed, 17 Jul 2019 22:34:54 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 22:34:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <payal.s.kshirsagar.98@gmail.com>,
        <hariprasad.kelam@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] staging: rtl8723bs: remove set but not used variable 'cck_highpwr'
Date:   Wed, 17 Jul 2019 22:20:14 +0800
Message-ID: <20190717142014.43216-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtl8723bs/hal/odm_HWConfig.c:
 In function odm_RxPhyStatus92CSeries_Parsing:
drivers/staging/rtl8723bs/hal/odm_HWConfig.c:92:5: warning:
 variable cck_highpwr set but not used [-Wunused-but-set-variable]

It is never used and can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 49fa81406..71919a3 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -89,7 +89,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 	u8 RSSI, total_rssi = 0;
 	bool isCCKrate = false;
 	u8 rf_rx_num = 0;
-	u8 cck_highpwr = 0;
 	u8 LNA_idx, VGA_idx;
 	PPHY_STATUS_RPT_8192CD_T pPhyStaRpt = (PPHY_STATUS_RPT_8192CD_T)pPhyStatus;
 
@@ -107,16 +106,10 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
 		/*  */
 
-		/* if (pHalData->eRFPowerState == eRfOn) */
-		cck_highpwr = pDM_Odm->bCckHighPower;
-		/* else */
-		/* cck_highpwr = false; */
-
 		cck_agc_rpt =  pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a ;
 
 		/* 2011.11.28 LukeLee: 88E use different LNA & VGA gain table */
 		/* The RSSI formula should be modified according to the gain table */
-		/* In 88E, cck_highpwr is always set to 1 */
 		LNA_idx = ((cck_agc_rpt & 0xE0)>>5);
 		VGA_idx = (cck_agc_rpt & 0x1F);
 		rx_pwr_all = odm_CCKRSSI_8723B(LNA_idx, VGA_idx);
-- 
2.7.4


