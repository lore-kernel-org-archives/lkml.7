Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B0C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B52020578
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 09:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNFLt32A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfIHJBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 05:01:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45967 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfIHJBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 05:01:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so8157630lff.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5hoZiMp+CY6V2MQtNA4HHBCXJ44xB0RevxC0GbZ74M=;
        b=FNFLt32AHnefLNgi49Z3RHWcL+NYqoykP1lBPvhVn8ZE6c4me3xdjTw6DkLrHc/Mum
         G/otQJ94JRkvxKFN6sUaGioQtYV11t1pFG/QUy09v5+fEIu3s5LUBPRmkwMQSZuk/ZaC
         Lywh3qBADvt/PbzwMoaWGQFdwOdpPpcKciMWhw0JLhQTtgZgJzAt8z4H+Z5B9/zCBdWe
         T+G2BryZ8pqmgQgZAjg5VmRhHAk9RUOnxgxQ9boaCzVtO13BFhS56IvvQEw5RJTXgsbE
         3SloA//tj1hM56cznpnBjA2fw5IvDnS4dk60NbjwbNAjFCmiIxsRIFNVRrwEvotZ+Cot
         wesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5hoZiMp+CY6V2MQtNA4HHBCXJ44xB0RevxC0GbZ74M=;
        b=Lq2ypy1IgeNaWzRmutNRhpcmjZoCAm55YUClqFeUF2fgp2g9J5wS9NmvH5SgG0Uaax
         xm9URQurWiLn5tqOZmK4GzzPHoP4P2fXoKYUJRozinAPPCXvmrNQJEdAmBEQINnbE8jd
         +81Gd5rSra4+iRUTT8pKkole3GwmEejMyLe7KFrKKyIOiWViWAcqFcJmAVwlTRtLkxFg
         eoeqaRG0n8rkBqSQ2uX2ZzQneBC3Ke6QwAW8LBPfOIystgR+okMR8DEMfXQXVZJnByzJ
         zWeLsBD7B+e5XBDOtEzjpgySpgrQ/nMci5ml2SSpRox3SCsJSlahlgpU752CyZWHzgs1
         J6IQ==
X-Gm-Message-State: APjAAAWFfXa7IIdHwkbJYCxg8P7K4Lip9C4ZA/4VEG3mRgtyl+Xzqg6v
        Mg6epyj7lRlYiW2qCR4gbjc=
X-Google-Smtp-Source: APXvYqydJCaqOLxm7NEFIT/cCRYfeD4m9RV7VkoJw/6jfum3fe49XsdNtZaXAThrGP7zKpFyADk6mQ==
X-Received: by 2002:a19:4912:: with SMTP id w18mr12302133lfa.93.1567933266597;
        Sun, 08 Sep 2019 02:01:06 -0700 (PDT)
Received: from alpha (ppp78-37-236-177.pppoe.avangarddsl.ru. [78.37.236.177])
        by smtp.gmail.com with ESMTPSA id m18sm2147812lfb.73.2019.09.08.02.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 02:01:05 -0700 (PDT)
Received: (nullmailer pid 2701 invoked by uid 1000);
        Sun, 08 Sep 2019 09:01:12 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        =?UTF-8?q?Florian=20B=C3=BCstgens?= <flbue@gmx.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: replace rtw_malloc() with it's definition
Date:   Sun,  8 Sep 2019 12:00:26 +0300
Message-Id: <20190908090026.2656-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_malloc prevents the use of kmemdup/kzalloc and others.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c        |  4 ++--
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c  |  2 +-
 .../staging/rtl8188eu/include/osdep_service.h  |  3 ---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 18 +++++++++---------
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c  |  2 +-
 .../staging/rtl8188eu/os_dep/osdep_service.c   |  7 +------
 6 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 51a5b71f8c25..c9c57379b7a2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -104,7 +104,7 @@ static void update_BCNTIM(struct adapter *padapter)
 	}
 
 	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
+		pbackup_remainder_ie = kmalloc(remainder_ielen, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 		if (pbackup_remainder_ie && premainder_ie)
 			memcpy(pbackup_remainder_ie, premainder_ie,
 			       remainder_ielen);
@@ -1168,7 +1168,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	remainder_ielen = ielen - wps_offset - wps_ielen;
 
 	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = rtw_malloc(remainder_ielen);
+		pbackup_remainder_ie = kmalloc(remainder_ielen, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 		if (pbackup_remainder_ie)
 			memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 	}
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 18dc9fc1c04a..759a37a5a167 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2573,7 +2573,7 @@ static unsigned int OnBeacon(struct adapter *padapter,
 	if (!memcmp(GetAddr3Ptr(pframe), pnetwork->MacAddress, ETH_ALEN)) {
 		if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
 			/* we should update current network before auth, or some IE is wrong */
-			pbss = (struct wlan_bssid_ex *)rtw_malloc(sizeof(struct wlan_bssid_ex));
+			pbss = kmalloc(sizeof(*pbss), in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 			if (pbss) {
 				if (collect_bss_info(padapter, precv_frame, pbss) == _SUCCESS) {
 					update_network(&pmlmepriv->cur_network.network, pbss, padapter, true);
diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/staging/rtl8188eu/include/osdep_service.h
index c0114ad79788..dcaa7917b783 100644
--- a/drivers/staging/rtl8188eu/include/osdep_service.h
+++ b/drivers/staging/rtl8188eu/include/osdep_service.h
@@ -61,9 +61,6 @@ static inline int rtw_netif_queue_stopped(struct net_device *pnetdev)
 		netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 3));
 }
 
-u8 *_rtw_malloc(u32 sz);
-#define rtw_malloc(sz)			_rtw_malloc((sz))
-
 void _rtw_init_queue(struct __queue *pqueue);
 
 struct rtw_netdev_priv_indicator {
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index ec5835d1aa8c..04ec73be0cce 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -392,7 +392,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + offsetof(struct ndis_802_11_wep, KeyMaterial);
-			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
+			pwep = kmalloc(wep_total_len, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 			if (!pwep) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
@@ -1862,7 +1862,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 	int ret = 0;
 
 	param_len = sizeof(struct ieee_param) + pext->key_len;
-	param = (struct ieee_param *)rtw_malloc(param_len);
+	param = kmalloc(param_len, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (!param)
 		return -1;
 
@@ -2027,7 +2027,7 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 		goto out;
 	}
 
-	param = (struct ieee_param *)rtw_malloc(p->length);
+	param = kmalloc(p->length, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (!param) {
 		ret = -ENOMEM;
 		goto out;
@@ -2236,7 +2236,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + offsetof(struct ndis_802_11_wep, KeyMaterial);
-			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
+			pwep = kmalloc(wep_total_len, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 			if (!pwep) {
 				DBG_88E(" r871x_set_encryption: pwep allocate fail !!!\n");
 				goto exit;
@@ -2652,7 +2652,7 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	pmlmepriv->wps_beacon_ie = NULL;
 
 	if (ie_len > 0) {
-		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
+		pmlmepriv->wps_beacon_ie = kmalloc(ie_len, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
 		if (!pmlmepriv->wps_beacon_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
@@ -2686,7 +2686,7 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	pmlmepriv->wps_probe_resp_ie = NULL;
 
 	if (ie_len > 0) {
-		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
+		pmlmepriv->wps_probe_resp_ie = kmalloc(ie_len, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
 		if (!pmlmepriv->wps_probe_resp_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
@@ -2715,7 +2715,7 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	pmlmepriv->wps_assoc_resp_ie = NULL;
 
 	if (ie_len > 0) {
-		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
+		pmlmepriv->wps_assoc_resp_ie = kmalloc(ie_len, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
 		if (!pmlmepriv->wps_assoc_resp_ie) {
 			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
@@ -2814,7 +2814,7 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 		goto out;
 	}
 
-	param = (struct ieee_param *)rtw_malloc(p->length);
+	param = kmalloc(p->length, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (!param) {
 		ret = -ENOMEM;
 		goto out;
@@ -2924,7 +2924,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 			kfree(pmlmepriv->wps_probe_req_ie);
 			pmlmepriv->wps_probe_req_ie = NULL;
 
-			pmlmepriv->wps_probe_req_ie = rtw_malloc(cp_sz);
+			pmlmepriv->wps_probe_req_ie = kmalloc(cp_sz, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 			if (!pmlmepriv->wps_probe_req_ie) {
 				pr_info("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 				ret =  -EINVAL;
diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 321b2c46479c..e6065fff276f 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -93,7 +93,7 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	if (authmode == _WPA_IE_ID_) {
 		RT_TRACE(_module_mlme_osdep_c_, _drv_info_,
 			 ("%s, authmode=%d\n", __func__, authmode));
-		buff = rtw_malloc(IW_CUSTOM_MAX);
+		buff = kmalloc(IW_CUSTOM_MAX, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 		if (!buff)
 			return;
 		memset(buff, 0, IW_CUSTOM_MAX);
diff --git a/drivers/staging/rtl8188eu/os_dep/osdep_service.c b/drivers/staging/rtl8188eu/os_dep/osdep_service.c
index 69d4b1d66b6f..ce6d3929b0d6 100644
--- a/drivers/staging/rtl8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8188eu/os_dep/osdep_service.c
@@ -13,11 +13,6 @@
 #include <linux/vmalloc.h>
 #include <rtw_ioctl_set.h>
 
-u8 *_rtw_malloc(u32 sz)
-{
-	return kmalloc(sz, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
-}
-
 void _rtw_init_queue(struct __queue *pqueue)
 {
 	INIT_LIST_HEAD(&pqueue->queue);
@@ -79,7 +74,7 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
 		goto keep_ori;
 
 	/* duplicate src */
-	dup = rtw_malloc(src_len);
+	dup = kmalloc(src_len, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (dup) {
 		dup_len = src_len;
 		memcpy(dup, src, dup_len);
-- 
2.21.0

