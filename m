Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6755AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3362184E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2tL3kRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfEWSKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:10:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40724 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbfEWSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:10:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so3060781plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qogrVJOizjXohj66Ojog3iB0x5HKIyjxf0Fb3bKvncg=;
        b=O2tL3kRXSUqWeMsaIAIz1NTqJRh3l/cyn7YerV7qbm6+THbzlsbi95yOKYxOMopA3L
         nEfSIYE7/v9qv+4Nwa1psBbruMtvul0mHzmtkMJQFFzwyyflYgGFKNPVVzM68VbdYmO6
         Yj8+Eq7ORqqp8FddWUBEbAGULiTi9ORD+m+dkKavoXhZRjzA/9jivMtUq/3W0o/6iECv
         WTLASvVl8FrK2u48Exmbf3CKNh7v3x6GkA1EN5VOuCnRrRHW/FdWGigw+w3sicvCVwlu
         t7rwa+C3+XqU3pvyzlSoYuSKsScHUR3oPiagApC2ig7yq34yfOZAYeeP2fwrZkkrTNYl
         FppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qogrVJOizjXohj66Ojog3iB0x5HKIyjxf0Fb3bKvncg=;
        b=J+KiRDSwm8Ibgpi+Oc+fkmM2KLxTdUd4G5TI/ANolcjFn4ZoeXQ9JM8JiUzLHtUsCI
         r1WUCvmonmH+hsDefEuC1gcTPomsTK7ntx2w27u7QphOcl8uUPqsuCu0dLrnOArZd40Z
         aZ7C742fOIJwbFGOVn8l0yta/rNVjlIocX56JWktYP7GBaz62VuY/bs4RrlvSEvEyFqc
         vLhlxb7Mhoah6pnH8NzxFqf4yhDV4ABZmuo7lX/GPusVA4wmDVYiR2Fsy3V4VU6dpBAM
         QguV4VwlMbkca626Fs3+NSZethb2pu3oMYe5pxR0b/Ir2E0fK3EfhhNJlQLnOBD7QMQV
         daWQ==
X-Gm-Message-State: APjAAAVPgmv/LIaO5w77UtsK81psubHgZHOaAuAFnyORP+V8/DYBCxIb
        I4K/QVd3PdRgtDJwVsA/NBI=
X-Google-Smtp-Source: APXvYqwEv3Z6GLKOi7kYkYMl5cifVoL8lQyTtBriohTMME3NoBA5wUHICmi8xxIok439uCzH5N+ijA==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr77764391pls.146.1558635017817;
        Thu, 23 May 2019 11:10:17 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id l20sm95360pff.102.2019.05.23.11.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 11:10:17 -0700 (PDT)
Date:   Thu, 23 May 2019 23:40:09 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Murray McAllister <murray.mcallister@insomniasec.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Michael Straube <straube.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v4] staging: rtl8723bs: core: rtw_ap: fix Unneeded variable:
 "ret". Return "0
Message-ID: <20190523181009.GA9411@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function "rtw_sta_flush" always returns 0 value. So change
 return type of rtw_sta_flush from int to void.

Same thing applies for rtw_hostapd_sta_flush

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
------
 Changes v2 -
       change return type of rtw_sta_flush
 Changes v3 -
       fix indentaion issue
 Changes v4 -
       prepare patch on linux-next
---
---
 drivers/staging/rtl8723bs/core/rtw_ap.c           | 7 ++-----
 drivers/staging/rtl8723bs/include/rtw_ap.h        | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 4 ++--
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 7 +++----
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 912ac2f..7bebb41 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -2189,10 +2189,9 @@ u8 ap_free_sta(
 	return beacon_updated;
 }
 
-int rtw_sta_flush(struct adapter *padapter)
+void rtw_sta_flush(struct adapter *padapter)
 {
 	struct list_head	*phead, *plist;
-	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -2202,7 +2201,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
 
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
-		return ret;
+		return;
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
@@ -2226,8 +2225,6 @@ int rtw_sta_flush(struct adapter *padapter)
 	issue_deauth(padapter, bc_addr, WLAN_REASON_DEAUTH_LEAVING);
 
 	associated_clients_update(padapter, true);
-
-	return ret;
 }
 
 /* called > TSR LEVEL for USB or SDIO Interface*/
diff --git a/drivers/staging/rtl8723bs/include/rtw_ap.h b/drivers/staging/rtl8723bs/include/rtw_ap.h
index fd56c9db..d6f3a3a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_ap.h
+++ b/drivers/staging/rtl8723bs/include/rtw_ap.h
@@ -31,7 +31,7 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta);
 void sta_info_update(struct adapter *padapter, struct sta_info *psta);
 void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta);
 u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta, bool active, u16 reason);
-int rtw_sta_flush(struct adapter *padapter);
+void rtw_sta_flush(struct adapter *padapter);
 void start_ap_mode(struct adapter *padapter);
 void stop_ap_mode(struct adapter *padapter);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 996bd1a..9bc6856 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2870,9 +2870,9 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 
 		flush_all_cam_entry(padapter);	/* clear CAM */
 
-		ret = rtw_sta_flush(padapter);
+		rtw_sta_flush(padapter);
 
-		return ret;
+		return 0;
 	}
 
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index bfbbcf0..236a462 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -3753,7 +3753,7 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 
 }
 
-static int rtw_hostapd_sta_flush(struct net_device *dev)
+static void rtw_hostapd_sta_flush(struct net_device *dev)
 {
 	/* _irqL irqL; */
 	/* struct list_head	*phead, *plist; */
@@ -3765,8 +3765,7 @@ static int rtw_hostapd_sta_flush(struct net_device *dev)
 
 	flush_all_cam_entry(padapter);	/* clear CAM */
 
-	return rtw_sta_flush(padapter);
-
+	rtw_sta_flush(padapter);
 }
 
 static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
@@ -4253,7 +4252,7 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 	switch (param->cmd) {
 	case RTL871X_HOSTAPD_FLUSH:
 
-		ret = rtw_hostapd_sta_flush(dev);
+		rtw_hostapd_sta_flush(dev);
 
 		break;
 
-- 
2.7.4

