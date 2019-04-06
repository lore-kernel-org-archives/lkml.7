Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F47C282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 03:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731EE21738
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 03:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDFDBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 23:01:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfDFDBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 23:01:18 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 77A913E2155A04185A86;
        Sat,  6 Apr 2019 11:01:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Sat, 6 Apr 2019 11:01:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Sohil Ladhani <supertakumi86@gmail.com>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Luke Triantafyllidis <ltriant@cpan.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luca Coelho <luciano.coelho@intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: rtlwifi: base: Remove set but not used variables
Date:   Sat, 6 Apr 2019 03:12:25 +0000
Message-ID: <20190406031225.60088-1-yuehaibing@huawei.com>
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

drivers/staging/rtlwifi/base.c: In function 'rtl_tx_agg_stop':
drivers/staging/rtlwifi/base.c:1733:23: warning:
 variable 'tid_data' set but not used [-Wunused-but-set-variable]

drivers/staging/rtlwifi/base.c: In function 'rtl_check_beacon_key':
drivers/staging/rtlwifi/base.c:2474:5: warning:
 variable 'ds_param_len' set but not used [-Wunused-but-set-variable]

drivers/staging/rtlwifi/base.c:2472:5: warning:
 variable 'ht_oper_len' set but not used [-Wunused-but-set-variable]

drivers/staging/rtlwifi/base.c:2470:5: warning:
 variable 'ht_cap_len' set but not used [-Wunused-but-set-variable]

They are never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtlwifi/base.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtlwifi/base.c b/drivers/staging/rtlwifi/base.c
index b8358ebbf912..b8b89e4c54d4 100644
--- a/drivers/staging/rtlwifi/base.c
+++ b/drivers/staging/rtlwifi/base.c
@@ -1730,7 +1730,6 @@ int rtl_tx_agg_stop(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    struct ieee80211_sta *sta, u16 tid)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_tid_data *tid_data;
 	struct rtl_sta_info *sta_entry = NULL;
 
 	if (!sta)
@@ -1743,7 +1742,6 @@ int rtl_tx_agg_stop(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return -EINVAL;
 
 	sta_entry = (struct rtl_sta_info *)sta->drv_priv;
-	tid_data = &sta_entry->tids[tid];
 	sta_entry->tids[tid].agg.agg_state = RTL_AGG_STOP;
 
 	ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
@@ -2467,11 +2465,8 @@ bool rtl_check_beacon_key(struct ieee80211_hw *hw, void *data, unsigned int len)
 	struct rtl_beacon_keys bcn_key = {};
 	struct rtl_beacon_keys *cur_bcn_key;
 	u8 *ht_cap;
-	u8 ht_cap_len;
 	u8 *ht_oper;
-	u8 ht_oper_len;
 	u8 *ds_param;
-	u8 ds_param_len;
 
 	if (mac->opmode != NL80211_IFTYPE_STATION)
 		return false;
@@ -2502,18 +2497,15 @@ bool rtl_check_beacon_key(struct ieee80211_hw *hw, void *data, unsigned int len)
 	/***** Parsing DS Param IE ******/
 	ds_param = rtl_find_ie(data, len - FCS_LEN, WLAN_EID_DS_PARAMS);
 
-	if (ds_param && !(ds_param[1] < sizeof(*ds_param))) {
-		ds_param_len = ds_param[1];
+	if (ds_param && !(ds_param[1] < sizeof(*ds_param)))
 		bcn_key.bcn_channel = ds_param[2];
-	} else {
+	else
 		ds_param = NULL;
-	}
 
 	/***** Parsing HT Cap. IE ******/
 	ht_cap = rtl_find_ie(data, len - FCS_LEN, WLAN_EID_HT_CAPABILITY);
 
 	if (ht_cap && !(ht_cap[1] < sizeof(*ht_cap))) {
-		ht_cap_len = ht_cap[1];
 		ht_cap_ie = (struct ieee80211_ht_cap *)&ht_cap[2];
 		bcn_key.ht_cap_info = ht_cap_ie->cap_info;
 	} else  {
@@ -2523,12 +2515,10 @@ bool rtl_check_beacon_key(struct ieee80211_hw *hw, void *data, unsigned int len)
 	/***** Parsing HT Info. IE ******/
 	ht_oper = rtl_find_ie(data, len - FCS_LEN, WLAN_EID_HT_OPERATION);
 
-	if (ht_oper && !(ht_oper[1] < sizeof(*ht_oper))) {
-		ht_oper_len = ht_oper[1];
+	if (ht_oper && !(ht_oper[1] < sizeof(*ht_oper)))
 		ht_oper_ie = (struct ieee80211_ht_operation *)&ht_oper[2];
-	} else {
+	else
 		ht_oper = NULL;
-	}
 
 	/* update bcn_key */
 





