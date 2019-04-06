Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F7C282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 03:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA921738
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 03:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDFDAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 23:00:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbfDFDAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 23:00:12 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80242D70F2D5E4E9A762;
        Sat,  6 Apr 2019 11:00:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 6 Apr 2019 11:00:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Nishka Dasgupta" <nishka.dasgupta@yahoo.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: rtlwifi: rtl8822be: Remove set but not used variable 'curtxbw_40mhz'
Date:   Sat, 6 Apr 2019 03:11:18 +0000
Message-ID: <20190406031118.59321-1-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtlwifi/rtl8822be/hw.c: In function 'rtl8822be_update_hal_rate_mask':
drivers/staging/rtlwifi/rtl8822be/hw.c:2144:5: warning:
 variable 'curtxbw_40mhz' set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtlwifi/rtl8822be/hw.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtlwifi/rtl8822be/hw.c b/drivers/staging/rtlwifi/rtl8822be/hw.c
index dac22c21f821..1de4e903a4de 100644
--- a/drivers/staging/rtlwifi/rtl8822be/hw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/hw.c
@@ -2141,8 +2141,6 @@ static void rtl8822be_update_hal_rate_mask(struct ieee80211_hw *hw,
 	u32 ratr_bitmap, ratr_bitmap_msb = 0;
 	u8 ratr_index;
 	enum wireless_mode wirelessmode = 0;
-	u8 curtxbw_40mhz =
-		(sta->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) ? 1 : 0;
 	bool b_shortgi = false;
 	u8 rate_mask[7];
 	u8 macid = 0;
@@ -2153,11 +2151,8 @@ static void rtl8822be_update_hal_rate_mask(struct ieee80211_hw *hw,
 
 	RT_TRACE(rtlpriv, COMP_RATR, DBG_LOUD, "wireless mode = 0x%x\n",
 		 wirelessmode);
-	if (mac->opmode == NL80211_IFTYPE_STATION ||
-	    mac->opmode == NL80211_IFTYPE_MESH_POINT) {
-		curtxbw_40mhz = mac->bw_40;
-	} else if (mac->opmode == NL80211_IFTYPE_AP ||
-		   mac->opmode == NL80211_IFTYPE_ADHOC)
+	if (mac->opmode == NL80211_IFTYPE_AP ||
+	    mac->opmode == NL80211_IFTYPE_ADHOC)
 		macid = sta->aid + 1;
 	if (wirelessmode == WIRELESS_MODE_N_5G ||
 	    wirelessmode == WIRELESS_MODE_AC_5G ||





