Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F01C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605CE20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfDBI4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:56:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41063 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbfDBI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:56:24 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x328uEn3032403, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x328uEn3032403
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Tue, 2 Apr 2019 16:56:14 +0800
Received: from localhost (172.22.88.128) by RTITCASV01.realtek.com.tw
 (172.21.6.18) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 16:56:14 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     RickyWu <ricky_wu@realtek.com>
Subject: [PATCH] misc: rtsx: Fixed rts5260 power saving parameter and sd glitch
Date:   Tue, 2 Apr 2019 16:56:07 +0800
Message-ID: <20190402085607.32165-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.128]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RickyWu <ricky_wu@realtek.com>

this patch fixes rts5260 power saving parameter
make power saving function work on L1.1, L1.2

Signed-off-by: RickyWu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5260.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index da22bcb62b04..b510d3f46587 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -195,7 +195,7 @@ static int sd_set_sample_push_timing_sd30(struct rtsx_pcr *pcr)
 		| SD_ASYNC_FIFO_NOT_RST, SD_30_MODE | SD_ASYNC_FIFO_NOT_RST);
 	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, CLK_LOW_FREQ);
 	rtsx_pci_write_register(pcr, CARD_CLK_SOURCE, 0xFF,
-			CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+		CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
 	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, 0);
 
 	return 0;
@@ -238,8 +238,8 @@ static int rts5260_card_power_on(struct rtsx_pcr *pcr, int card)
 	/* Reset SD_CFG3 register */
 	rtsx_pci_write_register(pcr, SD_CFG3, SD30_CLK_END_EN, 0);
 	rtsx_pci_write_register(pcr, REG_SD_STOP_SDCLK_CFG,
-			SD30_CLK_STOP_CFG_EN | SD30_CLK_STOP_CFG1 |
-			SD30_CLK_STOP_CFG0, 0);
+				SD30_CLK_STOP_CFG_EN | SD30_CLK_STOP_CFG1 |
+				SD30_CLK_STOP_CFG0, 0);
 
 	rtsx_pci_write_register(pcr, REG_PRE_RW_MODE, EN_INFINITE_MODE, 0);
 
@@ -315,12 +315,12 @@ static void rts5260_init_ocp(struct rtsx_pcr *pcr)
 
 
 		rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
-				RTS5260_DVCC_OCP_THD_MASK,
-				option->sd_800mA_ocp_thd);
+					RTS5260_DVCC_OCP_THD_MASK,
+					option->sd_800mA_ocp_thd);
 
 		rtsx_pci_write_register(pcr, RTS5260_DV331812_CFG,
-				RTS5260_DV331812_OCP_THD_MASK,
-				RTS5260_DV331812_OCP_THD_270);
+					RTS5260_DV331812_OCP_THD_MASK,
+					RTS5260_DV331812_OCP_THD_270);
 
 		mask = SD_OCP_GLITCH_MASK;
 		val = pcr->hw_param.ocp_glitch;
@@ -451,6 +451,7 @@ static void rts5260_pwr_saving_setting(struct rtsx_pcr *pcr)
 	lss_l1_2 = rtsx_check_dev_flag(pcr, ASPM_L1_2_EN)
 			| rtsx_check_dev_flag(pcr, PM_L1_2_EN);
 
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0xFF, 0);
 	if (lss_l1_2) {
 		pcr_dbg(pcr, "Set parameters for L1.2.");
 		rtsx_pci_write_register(pcr, PWR_GLOBAL_CTRL,
@@ -573,10 +574,10 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 	 * to drive low, and we forcibly request clock.
 	 */
 	if (option->force_clkreq_0)
-		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
+		rtsx_pci_write_register(pcr, PETXCFG,
 				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
-		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
+		rtsx_pci_write_register(pcr, PETXCFG,
 				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
 
 	return 0;
@@ -704,7 +705,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
 	option->ocp_en = 1;
 	if (option->ocp_en)
 		hw_param->interrupt_en |= SD_OC_INT_EN;
-	hw_param->ocp_glitch =  SDVIO_OCP_GLITCH_800U | SDVIO_OCP_GLITCH_800U;
+	hw_param->ocp_glitch =  SD_OCP_GLITCH_100U | SDVIO_OCP_GLITCH_800U;
 	option->sd_400mA_ocp_thd = RTS5260_DVCC_OCP_THD_550;
 	option->sd_800mA_ocp_thd = RTS5260_DVCC_OCP_THD_970;
 }
-- 
2.17.1

