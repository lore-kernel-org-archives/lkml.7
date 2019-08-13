Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BC2C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F59F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsKl2vlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfHMXJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:09:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40252 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMXJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:09:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id e8so7675283qtp.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hv2isiJenWQyT12o3watD+tY/7Ygm9vkR2zjjYtok08=;
        b=hsKl2vlDgxqQ5Q9sk2KeYl+d6Gryj2SwwOimr279q+ghP0qYNXQ1elZ7GRnmkh18Fu
         19mznmwd5DWRSudkWSBgd6oORUZNVHL++mK8qJpkdUZVtx8G6fMx5qzFnEl+sjvaSpXR
         Du3D+cQNkH1nscElUrHrXouURmnsBMeduHQZ6JhV/41SkBHlnOorgiDrh8Hw0lhIxGpT
         3180P0USV1sN+SOBy3ua/QZ9qgtYonqyWuCBcIPMZqm7X0hJ5Y7rRdXnP8K1OiT7LhO6
         4ttfQDtjMIo0fT9FpSD8rkBQI+smO4omGcCN/xH56dE4He4ku2z9aSKFQWSa19LOPAVE
         EUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hv2isiJenWQyT12o3watD+tY/7Ygm9vkR2zjjYtok08=;
        b=dv2fw2DbMp22Yy9J2lnCeFhSozvDJyfee8xlVZdAthfp1+LJ8fDY1FWXCwm7s+Bqff
         8lQ4dXllPJsVZfIlOFSx1FcbsaFy03DAqhxrW5n948TtKj3qQmF8SH4YvEg3SSHm+arX
         NqUZzO/lcg65YXiQvQyowtnsSESWN8Wc7ZdTxSYRa2A8rn83lhVbM9syArTXU/UiM0tP
         GyhjleKG+IB+zJhsJvDVpNWOKZf3f1eMGcDb7fwWvTBQm/98NBqZ3ETZP5zQ1Z8DKQ9w
         3tCCLgO0QntgwbTi79wEPJ46XtwFR1jN5XvUv/U70sYR5PMl+Itu2R8bIDVllhIk+KV6
         6CQA==
X-Gm-Message-State: APjAAAUO9aoZhJAE0jvt+zkeVugGdEtqLlxchzHvghbQjFmxHC5sXml3
        xw+xPVi87zTNiBy/OaxIOAS+6/doJ7I=
X-Google-Smtp-Source: APXvYqzHIqBJyztwggP9HLwpHaVf+PRUHgIXo2hVIAf5LFqE7x4Nafu233QZzBGa3Ru5z804OiHtdg==
X-Received: by 2002:ac8:4794:: with SMTP id k20mr28183862qtq.2.1565737781391;
        Tue, 13 Aug 2019 16:09:41 -0700 (PDT)
Received: from localhost.localdomain (minicloud.parqtec.unicamp.br. [143.106.167.126])
        by smtp.gmail.com with ESMTPSA id t29sm42891385qtt.42.2019.08.13.16.09.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 16:09:40 -0700 (PDT)
From:   hugoziviani <hugoziviani@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     hugoziviani@gmail.com
Subject: [PATCH v1] staging: drivers: rtl8712: removing unnecessary parenthesis
Date:   Tue, 13 Aug 2019 19:09:30 -0400
Message-Id: <20190813230930.8040-1-hugoziviani@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error "CHECK: Remove unecessary parenthesis in drivers/staging/rtl8712/rtl871x_mlme.c"

Signed-off-by: hugoziviani <hugoziviani@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 84 +++++++++++++-------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 3f17ef6f7..e017fa511 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -44,10 +44,10 @@ static sint _init_mlme_priv(struct _adapter *padapter)
 				 Ndis802_11AutoUnknown;
 	/* Maybe someday we should rename this variable to "active_mode"(Jeff)*/
 	pmlmepriv->passive_mode = 1; /* 1: active, 0: passive. */
-	spin_lock_init(&(pmlmepriv->lock));
-	spin_lock_init(&(pmlmepriv->lock2));
-	_init_queue(&(pmlmepriv->free_bss_pool));
-	_init_queue(&(pmlmepriv->scanned_queue));
+	spin_lock_init(&pmlmepriv->lock);
+	spin_lock_init(&pmlmepriv->lock2);
+	_init_queue(&pmlmepriv->free_bss_pool);
+	_init_queue(&pmlmepriv->scanned_queue);
 	set_scanned_network_val(pmlmepriv, 0);
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 	pbuf = kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
@@ -57,9 +57,9 @@ static sint _init_mlme_priv(struct _adapter *padapter)
 	pmlmepriv->free_bss_buf = pbuf;
 	pnetwork = (struct wlan_network *)pbuf;
 	for (i = 0; i < MAX_BSS_CNT; i++) {
-		INIT_LIST_HEAD(&(pnetwork->list));
-		list_add_tail(&(pnetwork->list),
-				 &(pmlmepriv->free_bss_pool.queue));
+		INIT_LIST_HEAD(&pnetwork->list);
+		list_add_tail(&pnetwork->list,
+				 &pmlmepriv->free_bss_pool.queue);
 		pnetwork++;
 	}
 	pmlmepriv->sitesurveyctrl.last_rx_pkts = 0;
@@ -93,7 +93,7 @@ static void _free_network(struct mlme_priv *pmlmepriv,
 {
 	u32 curr_time, delta_time;
 	unsigned long irqL;
-	struct  __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct  __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (pnetwork == NULL)
 		return;
@@ -244,8 +244,8 @@ int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pnetwork)
 	int ret = true;
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
-	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == cpu_to_le32(0)))
+	if (psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_ &&
+		    pnetwork->network.Privacy == cpu_to_le32(0))
 		ret = false;
 	else if ((psecuritypriv->PrivacyAlgrthm == _NO_PRIVACY_) &&
 		 (pnetwork->network.Privacy == cpu_to_le32(1)))
@@ -310,7 +310,7 @@ static void update_network(struct wlan_bssid_ex *dst,
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
 	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) &&
-	    is_same_network(&(padapter->mlmepriv.cur_network.network), src)) {
+	    is_same_network(&padapter->mlmepriv.cur_network.network, src)) {
 		if (padapter->recvpriv.signal_qual_data.total_num++ >=
 		    PHY_LINKQUALITY_SLID_WIN_MAX) {
 			padapter->recvpriv.signal_qual_data.total_num =
@@ -342,8 +342,8 @@ static void update_current_network(struct _adapter *adapter,
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	if (is_same_network(&(pmlmepriv->cur_network.network), pnetwork)) {
-		update_network(&(pmlmepriv->cur_network.network),
+	if (is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
+		update_network(&pmlmepriv->cur_network.network,
 			       pnetwork, adapter);
 		r8712_update_protection(adapter,
 			       (pmlmepriv->cur_network.network.IEs) +
@@ -452,8 +452,8 @@ static int is_desired_network(struct _adapter *adapter,
 			return true;
 		return false;
 	}
-	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == 0))
+	if (psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_ &&
+		    pnetwork->network.Privacy == 0)
 		bselected = false;
 	if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode !=
@@ -510,7 +510,7 @@ void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
 	spin_lock_irqsave(&pmlmepriv->lock2, flags);
 	/* update IBSS_network 's timestamp */
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress),
+		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress,
 		    pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
@@ -564,7 +564,7 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 						  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
 				} else {
 					struct wlan_bssid_ex *pdev_network =
-					  &(adapter->registrypriv.dev_network);
+					  &adapter->registrypriv.dev_network;
 					u8 *pibss =
 						 adapter->registrypriv.
 							dev_network.MacAddress;
@@ -626,8 +626,8 @@ void r8712_free_assoc_resources(struct _adapter *adapter)
 	if (pwlan)
 		pwlan->fixed = false;
 
-	if (((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) &&
-	     (adapter->stapriv.asoc_sta_count == 1)))
+	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) &&
+	     adapter->stapriv.asoc_sta_count == 1)
 		free_network_nolock(pmlmepriv, pwlan);
 }
 
@@ -898,7 +898,7 @@ void r8712_stassoc_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
 	unsigned long irqL;
 	struct sta_info *psta;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct stassoc_event *pstassoc	= (struct stassoc_event *)pbuf;
 
 	/* to do: */
@@ -967,7 +967,7 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 				free_network_nolock(pmlmepriv, pwlan);
 			}
 			/*re-create ibss*/
-			pdev_network = &(adapter->registrypriv.dev_network);
+			pdev_network = &adapter->registrypriv.dev_network;
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 			memcpy(pdev_network, &tgt_network->network,
 				r8712_get_wlan_bssid_ex_sz(&tgt_network->
@@ -1043,8 +1043,8 @@ void _r8712_sitesurvey_ctrl_handler(struct _adapter *adapter)
 			  (psitesurveyctrl->last_rx_pkts);
 	psitesurveyctrl->last_tx_pkts = adapter->xmitpriv.tx_pkts;
 	psitesurveyctrl->last_rx_pkts = adapter->recvpriv.rx_pkts;
-	if ((current_tx_pkts > pregistrypriv->busy_thresh) ||
-	    (current_rx_pkts > pregistrypriv->busy_thresh))
+	if (current_tx_pkts > pregistrypriv->busy_thresh ||
+	    current_rx_pkts > pregistrypriv->busy_thresh)
 		psitesurveyctrl->traffic_busy = true;
 	else
 		psitesurveyctrl->traffic_busy = false;
@@ -1111,8 +1111,8 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 	pmlmepriv->pscanned = phead->next;
 	while (1) {
 		if (end_of_queue_search(phead, pmlmepriv->pscanned)) {
-			if ((pmlmepriv->assoc_by_rssi) &&
-			    (pnetwork_max_rssi != NULL)) {
+			if (pmlmepriv->assoc_by_rssi &&
+			    pnetwork_max_rssi != NULL) {
 				pnetwork = pnetwork_max_rssi;
 				goto ask_for_joinbss;
 			}
@@ -1148,8 +1148,8 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 		}
 		dst_ssid = pnetwork->network.Ssid.Ssid;
 		src_ssid = pmlmepriv->assoc_ssid.Ssid;
-		if ((pnetwork->network.Ssid.SsidLength ==
-		    pmlmepriv->assoc_ssid.SsidLength) &&
+		if (pnetwork->network.Ssid.SsidLength ==
+		    pmlmepriv->assoc_ssid.SsidLength &&
 		    (!memcmp(dst_ssid, src_ssid,
 		     pmlmepriv->assoc_ssid.SsidLength))) {
 			if (pmlmepriv->assoc_by_rssi) {
@@ -1355,15 +1355,15 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 	uint ndisauthmode = psecuritypriv->ndisauthtype;
 	uint ndissecuritytype = psecuritypriv->ndisencryptstatus;
 
-	if ((ndisauthmode == Ndis802_11AuthModeWPA) ||
-	    (ndisauthmode == Ndis802_11AuthModeWPAPSK)) {
+	if (ndisauthmode == Ndis802_11AuthModeWPA ||
+	    ndisauthmode == Ndis802_11AuthModeWPAPSK) {
 		authmode = _WPA_IE_ID_;
 		uncst_oui[0] = 0x0;
 		uncst_oui[1] = 0x50;
 		uncst_oui[2] = 0xf2;
 	}
-	if ((ndisauthmode == Ndis802_11AuthModeWPA2) ||
-	    (ndisauthmode == Ndis802_11AuthModeWPA2PSK)) {
+	if (ndisauthmode == Ndis802_11AuthModeWPA2 ||
+	    ndisauthmode == Ndis802_11AuthModeWPA2PSK) {
 		authmode = _WPA2_IE_ID_;
 		uncst_oui[0] = 0x0;
 		uncst_oui[1] = 0x0f;
@@ -1390,7 +1390,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 	match = false;
 	while (cnt < in_len) {
 		if (in_ie[cnt] == authmode) {
-			if ((authmode == _WPA_IE_ID_) &&
+			if (authmode == _WPA_IE_ID_ &&
 			    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 				memcpy(&sec_ie[0], &in_ie[cnt],
 					in_ie[cnt + 1] + 2);
@@ -1403,9 +1403,9 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 				match = true;
 				break;
 			}
-			if (((authmode == _WPA_IE_ID_) &&
-			     (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) ||
-			     (authmode == _WPA2_IE_ID_))
+			if (authmode == _WPA_IE_ID_ &&
+			     (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4)) ||
+			      authmode == _WPA2_IE_ID_)
 				memcpy(&bkup_ie[0], &in_ie[cnt],
 					in_ie[cnt + 1] + 2);
 		}
@@ -1423,7 +1423,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					match = false;
 					break;
 				}
-				if ((sec_ie[6] != 0x01) || (sec_ie[7] != 0x0)) {
+				if (sec_ie[6] != 0x01 || sec_ie[7] != 0x0) {
 					/*IE Ver error*/
 					match = false;
 					break;
@@ -1490,7 +1490,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 			 * algorithm, and set the bc/mc encryption algorithm
 			 */
 			while (true) {
-				if ((sec_ie[2] != 0x01) || (sec_ie[3] != 0x0)) {
+				if (sec_ie[2] != 0x01 || sec_ie[3] != 0x0) {
 					/*IE Ver error*/
 					match = false;
 					break;
@@ -1549,7 +1549,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 			}
 		}
 	}
-	if ((authmode == _WPA_IE_ID_) || (authmode == _WPA2_IE_ID_)) {
+	if (authmode == _WPA_IE_ID_ || authmode == _WPA2_IE_ID_) {
 		/*copy fixed ie*/
 		memcpy(out_ie, in_ie, 12);
 		ielength = 12;
@@ -1684,7 +1684,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 
 	phtpriv->ht_option = 0;
 	p = r8712_get_ie(in_ie + 12, _HT_CAPABILITY_IE_, &ielen, in_len - 12);
-	if (p && (ielen > 0)) {
+	if (p && ielen > 0) {
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
 			r8712_set_ie(out_ie + out_len, _VENDOR_SPECIFIC_IE_,
@@ -1721,13 +1721,13 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct wlan_network *pcur_network = &(pmlmepriv->cur_network);
+	struct wlan_network *pcur_network = &pmlmepriv->cur_network;
 
 	if (!phtpriv->ht_option)
 		return;
 	/* maybe needs check if ap supports rx ampdu. */
 	if (!phtpriv->ampdu_enable &&
-	    (pregistrypriv->ampdu_enable == 1))
+	    pregistrypriv->ampdu_enable == 1)
 		phtpriv->ampdu_enable = true;
 	/*check Max Rx A-MPDU Size*/
 	len = 0;
@@ -1776,7 +1776,7 @@ void r8712_issue_addbareq_cmd(struct _adapter *padapter, int priority)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv	 *phtpriv = &pmlmepriv->htpriv;
 
-	if ((phtpriv->ht_option == 1) && (phtpriv->ampdu_enable)) {
+	if (phtpriv->ht_option == 1 && phtpriv->ampdu_enable) {
 		if (!phtpriv->baddbareq_issued[priority]) {
 			r8712_addbareq_cmd(padapter, (u8)priority);
 			phtpriv->baddbareq_issued[priority] = true;
-- 
2.20.1

