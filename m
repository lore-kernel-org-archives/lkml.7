Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ABD22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfHUM0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:26:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbfHUM0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:26:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F38ABCF1108F8A60286B;
        Wed, 21 Aug 2019 20:26:18 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 20:26:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <colin.king@canonical.com>,
        <puranjay12@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8192e: remove two set but not used variables
Date:   Wed, 21 Aug 2019 20:25:56 +0800
Message-ID: <20190821122556.37636-1-yuehaibing@huawei.com>
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

 In function '_rtl92e_dm_tx_power_tracking_callback_tssi':
drivers/staging/rtl8192e/rtl8192e/rtl_dm.c:621:7:
 warning: variable 'bHighpowerstate' set but not used [-Wunused-but-set-variable]
 In function '_rtl92e_dm_rx_path_sel_byrssi':
drivers/staging/rtl8192e/rtl8192e/rtl_dm.c:1904:32:
 warning: variable 'cck_rx_ver2_min_index' set but not used [-Wunused-but-set-variable]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 1b7e3fd..20e4941 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -618,7 +618,7 @@ static void _rtl92e_dm_tx_update_tssi_strong_signal(struct net_device *dev,
 static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	bool	bHighpowerstate, viviflag = false;
+	bool	viviflag = false;
 	struct dcmd_txcmd tx_cmd;
 	u8	powerlevelOFDM24G;
 	int	i = 0, j = 0, k = 0;
@@ -632,7 +632,6 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	rtl92e_writeb(dev, Pw_Track_Flag, 0);
 	rtl92e_writeb(dev, FW_Busy_Flag, 0);
 	priv->rtllib->bdynamic_txpower_enable = false;
-	bHighpowerstate = priv->bDynamicTxHighPower;
 
 	powerlevelOFDM24G = (u8)(priv->Pwr_Track>>24);
 	RF_Type = priv->rf_type;
@@ -1901,7 +1900,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	u8 cck_default_Rx = 0x2;
 	u8 cck_optional_Rx = 0x3;
 	long tmp_cck_max_pwdb = 0, tmp_cck_min_pwdb = 0, tmp_cck_sec_pwdb = 0;
-	u8 cck_rx_ver2_max_index = 0, cck_rx_ver2_min_index = 0;
+	u8 cck_rx_ver2_max_index = 0;
 	u8 cck_rx_ver2_sec_index = 0;
 	u8 cur_rf_rssi;
 	long cur_cck_pwdb;
@@ -1984,7 +1983,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 
 				if (rf_num == 1) {
 					cck_rx_ver2_max_index = i;
-					cck_rx_ver2_min_index = i;
 					cck_rx_ver2_sec_index = i;
 					tmp_cck_max_pwdb = cur_cck_pwdb;
 					tmp_cck_min_pwdb = cur_cck_pwdb;
@@ -1997,7 +1995,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 						tmp_cck_sec_pwdb = cur_cck_pwdb;
 						tmp_cck_min_pwdb = cur_cck_pwdb;
 						cck_rx_ver2_sec_index = i;
-						cck_rx_ver2_min_index = i;
 					}
 				} else {
 					if (cur_cck_pwdb > tmp_cck_max_pwdb) {
@@ -2027,13 +2024,10 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 						   (cur_cck_pwdb > tmp_cck_min_pwdb)) {
 						;
 					} else if (cur_cck_pwdb == tmp_cck_min_pwdb) {
-						if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb) {
+						if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb)
 							tmp_cck_min_pwdb = cur_cck_pwdb;
-							cck_rx_ver2_min_index = i;
-						}
 					} else if (cur_cck_pwdb < tmp_cck_min_pwdb) {
 						tmp_cck_min_pwdb = cur_cck_pwdb;
-						cck_rx_ver2_min_index = i;
 					}
 				}
 
-- 
2.7.4


