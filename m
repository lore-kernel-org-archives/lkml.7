Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE543C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4642083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfQngJAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFFB74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:59:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41182 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFFB74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:59:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id s24so248903plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ihuU9o0Zl2KI3nbD0zaYT33XRxk7WVqlzlc7x/X37f0=;
        b=vfQngJAF7ezWRAJlfy24nqd/+e++EjO3IKe084/HH7pctHknHL0wX1i/6pJKF/XDeN
         yVrhbpBGpPYGND6QMbCXQfNj09Ua4603AIr6Ip7soE5YAPZPBaU2srxWXuYKs+Fru33b
         UnuYSQRwgBhP6bPowozYPQihg2tsOSmBvQoKjhleWHoV8KZEks9eO1dizEgjeAWAsF7S
         /PWbyPfk5yLX7Ix2jZA3eZHasDSIcy4M4kfgW1sDqzHTYuihV41Aj+4AlBPJ7hs/U5Un
         czldH6ozd2y0FxciEff8fS+IxBEua+gTob2Vfu1EGf5g1OAEf2MWcPFgmpiHT3BSF64f
         8i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ihuU9o0Zl2KI3nbD0zaYT33XRxk7WVqlzlc7x/X37f0=;
        b=GL5QRn/hOJ0wlJGBNGkzxVJ5M/fxI3P+upFvtfh8kjOG9sjk88yMA5iRpLbHNqlmbJ
         OyyKnoe5GmkMT4B0VsNTyDTvGgwVuauqu0jr9D6x2sKBqzw3ofcMRIiCqMEE6V2/s59Q
         TresMAt0L8OjOZT9DIsjNfoN+TFRrk+So8J821uzopyC3/3nXZt8PtG4j7H/SlXMHYGO
         y0HlbmKdT7PECdIYqJ9V3bB9/kxnwooxRMIo9vWarKZzMQlobIHKPehunKA5t+S1WAOw
         YssWqOTmo3wEMEkoe34wjxQ4gBsWjts/1u/9l52DNxEcEPA/2MDLrdKKFi6G0EZFdcsv
         LnMQ==
X-Gm-Message-State: APjAAAWGrD0yrejl9VZAtWU7cX9vqxaFpvR5bsmXnLwkWgZEMNr5Hp2j
        FohR5mojG2TtFa//48tHX/4=
X-Google-Smtp-Source: APXvYqz6iL57SOstwByQJwB7G/p/Z2547VWkonZ7YBzhPg2Y5xw2MOGiFbEyuyFw3gZrwv3kL58WyQ==
X-Received: by 2002:a17:902:7e0e:: with SMTP id b14mr22529317plm.257.1559786395303;
        Wed, 05 Jun 2019 18:59:55 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id u2sm253814pjv.9.2019.06.05.18.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 18:59:54 -0700 (PDT)
Date:   Wed, 5 Jun 2019 18:59:52 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Cc:     shobhitkukreti@gmail.com
Subject: [PATCH] staging: rtl8723bs: CleanUp to remove the error reported by
 checkpatch
Message-ID: <20190606015949.GA2275@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up the code to remove the error "(foo*)" should be "(foo *)"
reported by checkpatch from the file rtl8723bs/os_dep/ioctl_linux.c

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
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

