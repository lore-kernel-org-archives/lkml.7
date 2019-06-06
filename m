Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6617C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A0620872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJAkm1fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfFFOgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:36:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42815 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfFFOgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:36:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so1619402pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXvNJlmMwTwPdGbKMyehc8PYCLGaCInId9R1IyHYjiM=;
        b=aJAkm1fvEI7//g6q0g41p6/0u0AUPs6m8ltpd0hZ+8EQ2emNsV8DapVhl4PPXNx3+4
         Bv2H2mduakfYUzApWZfjXKU52gIptJ7LbcsH9BE0kZExsIY6N0/e6HShNFUqDrK165uW
         db1KiTaOhPwEH0Wq4x5zscnZE2GJYbSfx6K7P41eMz9sem+pFrD3zUUw5CD0/LKZqtfk
         X/olQs0IFfD+cRFGgCSc/Z9G+8uqkBL7HyIIUFF4ejcI2Oa2+lGekIwFL9neA3/vXqgC
         Y11z8PDjuEdJW2IW3fUrCUPtkDoA9eO4m0uo9qjyqIm5XJBFzoPM/HFEH2GSlv7OuI0X
         CXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXvNJlmMwTwPdGbKMyehc8PYCLGaCInId9R1IyHYjiM=;
        b=E0uB59dwNC8y2whIGw6LkHEY48OD5foRndzxA4ERvmrHBOibtqVD648CfryHNCVMwS
         cQI8RZxtoJG4VNjAffvvBmsLeOIJKVcOGKbZuQTrfaPdlr0nYE5gIMB73R0Sfd16H68U
         qL7l1I4zzHU75d4t91pZo18ZiexaSDnB4WA6s8cVu7TQsypLgmpbGimORPgk2/XW4fhg
         sQC5PZBBM+Tb1r8pioPFH3vjZPJPrfuXJWnZA2jmqQD6h9AJfFfVWXgqz7kX8mPcqQTz
         0rgsn1Yi5nRxbyvHhjOEM597hlnOFdTVF973X+KAAwrzZoGLiU0S1xOkGsinW19PI5Hl
         Y1og==
X-Gm-Message-State: APjAAAX47QaLcnsGbbuxLXhMCP+jREJSUrTRNR2zkUpBcT+x+F5dWB2R
        7bjUxFWLyRg49raIEswGPkI=
X-Google-Smtp-Source: APXvYqy91nI8EPyOXu8mD713BnqY4uW9qS79pzkXyHjXhyAs6dtYYH2oTv+Md05TJu6wVSU2VF01Dg==
X-Received: by 2002:a63:c006:: with SMTP id h6mr3622388pgg.368.1559831767213;
        Thu, 06 Jun 2019 07:36:07 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id c10sm2014560pjq.14.2019.06.06.07.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jun 2019 07:36:06 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: Resolve "(foo*)" should be "(foo *)" error reported by checkpatch
Date:   Thu,  6 Jun 2019 07:35:40 -0700
Message-Id: <1559831740-28009-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190606130253.GE1140@kroah.com>
References: <20190606130253.GE1140@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up the code to remove the error "(foo*)" should be "(foo *)"
reported by checkpatch from the file rtl8723bs/os_dep/ioctl_linux.c

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
Changes in v2:
 - Modified commit message to include reported ERROR by checkpatch

 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 236a462..0be8288 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -55,7 +55,7 @@ void rtw_indicate_wx_assoc_event(struct adapter *padapter)
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex*)(&(pmlmeinfo->network));
+	struct wlan_bssid_ex		*pnetwork = (struct wlan_bssid_ex *)(&(pmlmeinfo->network));
 
 	memset(&wrqu, 0, sizeof(union iwreq_data));
 
@@ -946,7 +946,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 	u8          j, blInserted = false;
 	int         intReturn = false;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-        struct iw_pmksa*  pPMK = (struct iw_pmksa*)extra;
+        struct iw_pmksa*  pPMK = (struct iw_pmksa *)extra;
         u8     strZeroMacAddress[ ETH_ALEN ] = { 0x00 };
         u8     strIssueBssid[ ETH_ALEN ] = { 0x00 };
 
@@ -2054,7 +2054,7 @@ static int rtw_wx_set_auth(struct net_device *dev,
 			   union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct iw_param *param = (struct iw_param*)&(wrqu->param);
+	struct iw_param *param = (struct iw_param *)&(wrqu->param);
 	int ret = 0;
 
 	switch (param->flags & IW_AUTH_INDEX) {
@@ -2337,8 +2337,8 @@ static int rtw_wx_read_rf(struct net_device *dev,
 	u32 path, addr, data32;
 
 
-	path = *(u32*)extra;
-	addr = *((u32*)extra + 1);
+	path = *(u32 *)extra;
+	addr = *((u32 *)extra + 1);
 	data32 = rtw_hal_read_rfreg(padapter, path, addr, 0xFFFFF);
 	/*
 	 * IMPORTANT!!
@@ -2358,9 +2358,9 @@ static int rtw_wx_write_rf(struct net_device *dev,
 	u32 path, addr, data32;
 
 
-	path = *(u32*)extra;
-	addr = *((u32*)extra + 1);
-	data32 = *((u32*)extra + 2);
+	path = *(u32 *)extra;
+	addr = *((u32 *)extra + 1);
+	data32 = *((u32 *)extra + 2);
 /* 	DBG_871X("%s: path =%d addr = 0x%02x data = 0x%05x\n", __func__, path, addr, data32); */
 	rtw_hal_write_rfreg(padapter, path, addr, 0xFFFFF, data32);
 
@@ -2584,7 +2584,7 @@ static int rtw_wps_start(struct net_device *dev,
 		goto exit;
 	}
 
-	uintRet = copy_from_user((void*)&u32wps_start, pdata->pointer, 4);
+	uintRet = copy_from_user((void *)&u32wps_start, pdata->pointer, 4);
 	if (u32wps_start == 0)
 		u32wps_start = *extra;
 
@@ -2694,7 +2694,7 @@ static int rtw_dbg_port(struct net_device *dev,
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 
-	pdata = (u32*)&wrqu->data;
+	pdata = (u32 *)&wrqu->data;
 
 	val32 = *pdata;
 	arg = (u16)(val32&0x0000ffff);
@@ -3420,7 +3420,7 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 
 	case IEEE_CMD_SET_WPA_IE:
 		/* ret = wpa_set_wpa_ie(dev, param, p->length); */
-		ret =  rtw_set_wpa_ie((struct adapter *)rtw_netdev_priv(dev), (char*)param->u.wpa_ie.data, (u16)param->u.wpa_ie.len);
+		ret =  rtw_set_wpa_ie((struct adapter *)rtw_netdev_priv(dev), (char *)param->u.wpa_ie.data, (u16)param->u.wpa_ie.len);
 		break;
 
 	case IEEE_CMD_SET_ENCRYPTION:
@@ -3824,7 +3824,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 		if (WLAN_STA_HT&flags) {
 			psta->htpriv.ht_option = true;
 			psta->qos_option = 1;
-			memcpy((void*)&psta->htpriv.ht_cap, (void*)&param->u.add_sta.ht_cap, sizeof(struct rtw_ieee80211_ht_cap));
+			memcpy((void *)&psta->htpriv.ht_cap, (void *)&param->u.add_sta.ht_cap, sizeof(struct rtw_ieee80211_ht_cap));
 		} else {
 			psta->htpriv.ht_option = false;
 		}
@@ -4368,7 +4368,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 	char *ext;
 
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct iw_point *dwrq = (struct iw_point*)awrq;
+	struct iw_point *dwrq = (struct iw_point *)awrq;
 
 	/* RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_notice_, ("+rtw_wx_set_priv\n")); */
 	if (dwrq->length == 0)
@@ -4540,7 +4540,7 @@ static int rtw_test(
 	}
 	DBG_871X("%s: string =\"%s\"\n", __func__, pbuf);
 
-	ptmp = (char*)pbuf;
+	ptmp = (char *)pbuf;
 	pch = strsep(&ptmp, delim);
 	if ((pch == NULL) || (strlen(pch) == 0)) {
 		kfree(pbuf);
@@ -5038,7 +5038,7 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 				str = strsep(&ptr, delim);
 				if (NULL == str) break;
 				sscanf(str, "%i", &temp);
-				((s32*)buffer)[count++] = (s32)temp;
+				((s32 *)buffer)[count++] = (s32)temp;
 			} while (1);
 			buffer_len = count * sizeof(s32);
 
@@ -5177,7 +5177,7 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 		case IW_PRIV_TYPE_INT:
 			/* Display args */
 			for (j = 0; j < n; j++) {
-				sprintf(str, "%d  ", ((__s32*)extra)[j]);
+				sprintf(str, "%d  ", ((__s32 *)extra)[j]);
 				len = strlen(str);
 				output_len = strlen(output);
 				if ((output_len + len + 1) > 4096) {
-- 
2.7.4

