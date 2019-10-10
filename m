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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6792064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADvVYlJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbfJJNQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:16:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36589 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbfJJNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:16:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so3666378pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIJMVh8wrotQtz/zERpg7h3s4iBqQ0bG66y42SxddKc=;
        b=ADvVYlJxO0fxoUtY+NMBPBYmgi2E7jzKwoL8Q5kwW2s9SHCmg7Npog1udG0/kMwjzY
         sNjXuX7TA3gqWO7pX7jMjLtPN/ACJO67vvKazrsntrpYNfgVeXwqRH4jIAHEaM3Ova9X
         hBLQHORy4utzsPFtaSCMzNA/l787Jo15wMVl8vUilakpUq1YiUH3OFkzVZRwua+PI9Ej
         KxdML/r+oC81QAoYtYUn9iN8HWaZ2s4fRh6uWqUNCWgRtisG31SAbXyckWiX2sOYkB6M
         O7yUuuokm3+4+IkpPp/Ssqecn234x4/nG5F+nv1TssKTOPfQALWukyH2F37lb1dMptus
         DFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIJMVh8wrotQtz/zERpg7h3s4iBqQ0bG66y42SxddKc=;
        b=ZfAXHRRhXaKrKsPG11N8Cm9TgyVIoT9y8V7Fz8gJnO7qVIkhP/PgoDrLA8bZaYt5h7
         usq7HtZXOsSUp5F//xQ2OPgFn7mvbMnaCzX5aFLD8IO6P+XwYZCn7ynumm7pfMA2J/QT
         m0quMca0gpW6uRQx4vp6GKEc65q4HiYUAbE4Axa7De822HMMmJS4NjTz2hrtgcsodKn8
         66TsDttsXTYs2NtFx1RjE/PYowaNnLzVTS5PVZrkSOvor22Vj2JctQ4l23XnpE6as9Av
         +Dsgbl2D5bzHRXv1vzNqpgM8/XTgce4yGnuZSmd1H69cd5zrBgo8Webv6Hg+v0S5HzYD
         qciA==
X-Gm-Message-State: APjAAAVfc8HaAfbXujxE5H5XrgROM7sikDGE+2uSkhKr1nQ0ZO35Y3w2
        HSGFRSfMcpg2uLQK3ZPTtko=
X-Google-Smtp-Source: APXvYqxKFaQbuaTApZugdq4LoaoJnMzHPRDKZFlZJO9hLicFP2Tj3eX+mM6XItZnxiojDI90ZBESAg==
X-Received: by 2002:a63:155e:: with SMTP id 30mr11369252pgv.204.1570713367363;
        Thu, 10 Oct 2019 06:16:07 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.158])
        by smtp.googlemail.com with ESMTPSA id 2sm8707720pfa.43.2019.10.10.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:16:06 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v3 1/4] staging: rtl8723bs: Remove comparisons to NULL in conditionals
Date:   Thu, 10 Oct 2019 16:15:29 +0300
Message-Id: <f4752d3a49e02193ed7b47a353e18e56d94b5a68.1570712632.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570712632.git.wambui.karugax@gmail.com>
References: <cover.1570712632.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove most comparisons to NULL in conditionals in
drivers/staging/rtl8723bs/core/rtw_mlme.c
Issues reported by checkpatch.pl as:
CHECK: Comparison to NULL could be written

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 50 +++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index a03cc005f053..b0018fe7bae3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -40,7 +40,7 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 
 	pbuf = vzalloc(array_size(MAX_BSS_CNT, sizeof(struct wlan_network)));
 
-	if (pbuf == NULL) {
+	if (!pbuf) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -185,7 +185,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 /* 	_irqL irqL; */
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
-	if (pnetwork == NULL)
+	if (!pnetwork)
 		return;
 
 	if (pnetwork->fixed == true)
@@ -220,7 +220,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
-	if (pnetwork == NULL)
+	if (!pnetwork)
 		return;
 
 	if (pnetwork->fixed == true)
@@ -633,7 +633,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* If there are no more slots, expire the oldest */
 			/* list_del_init(&oldest->list); */
 			pnetwork = oldest;
-			if (pnetwork == NULL) {
+			if (!pnetwork) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
 				goto exit;
 			}
@@ -654,7 +654,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
-			if (pnetwork == NULL) {
+			if (!pnetwork) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
 				goto exit;
 			}
@@ -738,7 +738,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	privacy = pnetwork->network.Privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen) != NULL)
+		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -1166,7 +1166,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	psta = rtw_get_stainfo(pstapriv, pnetwork->network.MacAddress);
-	if (psta == NULL) {
+	if (!psta) {
 		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
 	}
 
@@ -1413,7 +1413,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			/* s3. find ptarget_sta & update ptarget_sta after update cur_network only for station mode */
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
-				if (ptarget_sta == NULL) {
+				if (!ptarget_sta) {
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
 					spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 					goto ignore_joinbss_callback;
@@ -1503,7 +1503,7 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta, u3
 {
 	u16 media_status_rpt;
 
-	if (psta == NULL)
+	if (!psta)
 		return;
 
 	media_status_rpt = (u16)((psta->mac_id<<8)|mstatus); /*   MACID|OPMODE:1 connect */
@@ -1561,7 +1561,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 
 	/* for AD-HOC mode */
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta != NULL) {
+	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
 
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
@@ -1570,7 +1570,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	}
 
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta == NULL) {
+	if (!psta) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
 		return;
 	}
@@ -1993,7 +1993,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
 
-	if (mlme->cur_network_scanned == NULL) {
+	if (!mlme->cur_network_scanned) {
 		rtw_warn_on(1);
 		return ret;
 	}
@@ -2006,7 +2006,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	while (phead != mlme->pscanned) {
 
 		pnetwork = LIST_CONTAINOR(mlme->pscanned, struct wlan_network, list);
-		if (pnetwork == NULL) {
+		if (!pnetwork) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
@@ -2024,7 +2024,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 
 	}
 
-	if (candidate == NULL) {
+	if (!candidate) {
 		DBG_871X("%s: return _FAIL(candidate == NULL)\n", __func__);
 		ret = _FAIL;
 		goto exit;
@@ -2141,7 +2141,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	while (phead != pmlmepriv->pscanned) {
 
 		pnetwork = LIST_CONTAINOR(pmlmepriv->pscanned, struct wlan_network, list);
-		if (pnetwork == NULL) {
+		if (!pnetwork) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
@@ -2159,7 +2159,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 	}
 
-	if (candidate == NULL) {
+	if (!candidate) {
 		DBG_871X("%s: return _FAIL(candidate == NULL)\n", __func__);
 #ifdef CONFIG_WOWLAN
 		_clr_fwstate_(pmlmepriv, _FW_LINKED|_FW_UNDER_LINKING);
@@ -2200,14 +2200,14 @@ sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 	sint		res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
 
 	psetauthparm = rtw_zmalloc(sizeof(struct setauth_parm));
-	if (psetauthparm == NULL) {
-		kfree(pcmd);
+	if (!psetauthparm) {
+		kfree((unsigned char *)pcmd);
 		res = _FAIL;
 		goto exit;
 	}
@@ -2240,7 +2240,7 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
 	sint	res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
-	if (psetkeyparm == NULL) {
+	if (!psetkeyparm) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -2291,8 +2291,8 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
 
 	if (enqueue) {
 		pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (pcmd == NULL) {
-			kfree(psetkeyparm);
+		if (!pcmd) {
+			kfree((unsigned char *)psetkeyparm);
 			res = _FAIL;  /* try again */
 			goto exit;
 		}
@@ -2672,7 +2672,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_SGI_20);
 
 	/* Get HT BW */
-	if (in_ie == NULL) {
+	if (!in_ie) {
 		/* TDLS: TODO 20/40 issue */
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 			operation_bw = padapter->mlmeextpriv.cur_bwmode;
@@ -2787,7 +2787,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	phtpriv->ht_option = true;
 
-	if (in_ie != NULL) {
+	if (in_ie) {
 		p = rtw_get_ie(in_ie, _HT_ADD_INFO_IE_, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			out_len = *pout_len;
@@ -2954,7 +2954,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		return;
 	}
 
-	if (psta == NULL) {
+	if (!psta) {
 		DBG_871X("%s, psta ==NUL\n", __func__);
 		return;
 	}
-- 
2.23.0

