Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E5C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8952176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfDQHfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:35:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60999 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfDQHfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:35:33 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x3H7ZHr5006556, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x3H7ZHr5006556
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 17 Apr 2019 15:35:17 +0800
Received: from localhost (172.22.88.128) by RTITCASV01.realtek.com.tw
 (172.21.6.18) with Microsoft SMTP Server id 14.3.408.0; Wed, 17 Apr 2019
 15:35:16 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <kai.heng.feng@canonical.com>
CC:     RickyWu <ricky_wu@realtek.com>
Subject: [PATCH v2] misc: rtsx: Fixed rts5260 power saving parameter and sd glitch
Date:   Wed, 17 Apr 2019 15:35:08 +0800
Message-ID: <20190417073508.12389-1-ricky_wu@realtek.com>
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
 drivers/misc/cardreader/rts5260.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index da22bcb62b04..52c95add56f0 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
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

