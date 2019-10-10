Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56666C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AEA2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iStjb67B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfJJNQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:16:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33443 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfJJNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:16:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so2792379pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70AN0OqDspO2s8Cthp/jIG3jQlRGAB2TJGjZJMaVVM4=;
        b=iStjb67BpnfaCK1AKeaw1IM7IISTmzHZ8CZp/2MLvPWikIdHJ3MFl1StXdlIvl3fVc
         mncr2MaoncFRSqwpepuTbB14qxecOsII5dTFAuhu7GNZS2UwoIG7obEM6CFPnDdzSJpG
         h6bnta0aDTmbXrCkSPJ6u4LOIdyZlvCDtEH0sHV4mWKamq8yzmLPILQU1RNiKtmLKDAl
         EcjdyrAZORHVo6VYDIoft3BAV4ao3VTk3WH2Ja+f9T0wgAk6FXaYwop9nddylUFLFMEq
         fsW4uUnGQEQTtYinyyiw0tqBINMnjt8HZV7OssXqYO45c18KMyTY4XgejyWGqpk64ysU
         VeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70AN0OqDspO2s8Cthp/jIG3jQlRGAB2TJGjZJMaVVM4=;
        b=S/iaRxBYvjLIqtMI6Q/gXUDW6NqbKpY8BRvpmvcj8yLZWHOzJX9KTGE1GL+mLS2JSH
         Rl2TgpIxchm1ur3FK3Ilm9lsiR9bswOmKYrN9SaBo4EaaSjuLy2RYmKkF+6RF3zulYUN
         cgwUzMp4Wmx/2f5mLCT0luw+0zKJMQAr+OMBAvCutCg9yET+UNSQS5JL8zJ/Mz7gGubJ
         uo8X3MTHslJBab3MXAlIK9mziT7l27ZwGCXWge7T0rRBWSOUtiQ+UYDB2t4+i8fYr2uh
         9bTE3LepcKFZPcUelZn+HmefCEONxqRupTHNONwGKtyq6I5mztaTjRaO/vwsa5Ms7+BC
         zHIg==
X-Gm-Message-State: APjAAAUzQcHT5xHzKPmRvzOAi1y4yBwazO/b7ypjReNaFFTfKXc97dAI
        zQQF0peTHpZOBgq34WHMSPo=
X-Google-Smtp-Source: APXvYqz/bGr3BnIwTOrSyJwIM8/tAbMpAcxmoM/mXMO2O3wEBsddgTjwWSolQ4JeshXn4JpH3kcvDg==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr8960918plt.187.1570713387507;
        Thu, 10 Oct 2019 06:16:27 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.158])
        by smtp.googlemail.com with ESMTPSA id 2sm8707720pfa.43.2019.10.10.06.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:16:27 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v3 3/4] staging: rtl8723bs: Remove comparisons to booleans in conditionals.
Date:   Thu, 10 Oct 2019 16:15:31 +0300
Message-Id: <d97eaa803566c15a2658df10cf2ca77acddea7fb.1570712632.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570712632.git.wambui.karugax@gmail.com>
References: <cover.1570712632.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comparisons to true and false in multiple if statements in
drivers/staging/rtl8723bs/core/rtw_mlme.c
Issues reported by checkpatch.pl as:
CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 29 +++++++++++------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 52f490d5ebfb..7ec693a38396 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -187,7 +187,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 	if (!pnetwork)
 		return;
 
-	if (pnetwork->fixed == true)
+	if (pnetwork->fixed)
 		return;
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
@@ -222,7 +222,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 	if (!pnetwork)
 		return;
 
-	if (pnetwork->fixed == true)
+	if (pnetwork->fixed)
 		return;
 
 	/* spin_lock_irqsave(&free_queue->lock, irqL); */
@@ -480,7 +480,7 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 
 		pwlan = LIST_CONTAINOR(plist, struct wlan_network, list);
 
-		if (pwlan->fixed != true) {
+		if (!pwlan->fixed) {
 			if (oldest == NULL || time_after(oldest->last_scanned, pwlan->last_scanned))
 				oldest = pwlan;
 		}
@@ -867,7 +867,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
-	if (pmlmepriv->to_join == true) {
+	if (pmlmepriv->to_join) {
 		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
@@ -1368,7 +1368,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 			/* s1. find ptarget_wlan */
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-				if (the_same_macaddr == true) {
+				if (the_same_macaddr) {
 					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
 				} else {
 					pcur_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.MacAddress);
@@ -1843,7 +1843,7 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 				goto exit;
 			}
 
-			if (pmlmepriv->LinkDetectInfo.bBusyTraffic == true) {
+			if (pmlmepriv->LinkDetectInfo.bBusyTraffic) {
 				DBG_871X(FUNC_ADPT_FMT" exit BusyTraffic\n", FUNC_ADPT_ARG(padapter));
 				goto exit;
 			}
@@ -1863,20 +1863,20 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 	if (!adapter)
 		return;
 
-	if (adapter->hw_init_completed == false)
+	if (!adapter->hw_init_completed)
 		return;
 
-	if ((adapter->bDriverStopped == true) || (adapter->bSurpriseRemoved == true))
+	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
 
-	if (adapter->net_closed == true)
+	if (adapter->net_closed)
 		return;
 
 	if (is_primary_adapter(adapter))
 		DBG_871X("IsBtDisabled =%d, IsBtControlLps =%d\n", hal_btcoex_IsBtDisabled(adapter), hal_btcoex_IsBtControlLps(adapter));
 
-	if ((adapter_to_pwrctl(adapter)->bFwCurrentInPSMode == true)
-		&& (hal_btcoex_IsBtControlLps(adapter) == false)
+	if ((adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
+		&& !(hal_btcoex_IsBtControlLps(adapter))
 		) {
 		u8 bEnterPS;
 
@@ -2047,7 +2047,7 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 
 
 	/* check bssid, if needed */
-	if (mlme->assoc_by_bssid == true) {
+	if (mlme->assoc_by_bssid) {
 		if (memcmp(competitor->network.MacAddress, mlme->assoc_bssid, ETH_ALEN))
 			goto exit;
 	}
@@ -2805,7 +2805,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 cbw40_enable = 0;
 
-
 	if (!phtpriv->ht_option)
 		return;
 
@@ -2815,7 +2814,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	DBG_871X("+rtw_update_ht_cap()\n");
 
 	/* maybe needs check if ap supports rx ampdu. */
-	if ((phtpriv->ampdu_enable == false) && (pregistrypriv->ampdu_enable == 1)) {
+	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1) {
 		if (pregistrypriv->wifi_spec == 1) {
 			/* remove this part because testbed AP should disable RX AMPDU */
 			/* phtpriv->ampdu_enable = false; */
@@ -2955,7 +2954,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 	phtpriv = &psta->htpriv;
 
-	if ((phtpriv->ht_option == true) && (phtpriv->ampdu_enable == true)) {
+	if (phtpriv->ht_option && phtpriv->ampdu_enable) {
 		issued = (phtpriv->agg_enable_bitmap>>priority)&0x1;
 		issued |= (phtpriv->candidate_tid_bitmap>>priority)&0x1;
 
-- 
2.23.0

