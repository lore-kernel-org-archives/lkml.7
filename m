Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87DDC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7B821019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4K9HkYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfEUTAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:00:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33180 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfEUTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:00:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so798188plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4MZBxNvGtwJNQOCKRNJ0W32Q6ImcL8iXyB/wI559tJU=;
        b=N4K9HkYLbKdsXyle6lkIRWYTwlr3UJMJNZmUHyr/t5ozq2C24VjOg70kUPeGVOeI82
         hvGLDCyr+0vKoN7kPePARsl74cBjgBquoo7tunT9PVFk+2ff2zIGxhp+tZ1wsIrK5Ern
         oafZZBSKRi/L4ow9yXcZhRxS+zYhmvoaD4H6xhFT7uOmfilpNj86A9OjNQDTF7tTjk5k
         0hMJ+KDSoOUSOJ5zPC+hDuKrILgHT2Y7ul4mVIk1RJAFpMRSwRiIBecn7EXhngB8K5Gl
         ZF7jVkyVcAwC3KRrlFAM3YHifxUzyUKmGNl0/cN9X8qJD9KZEkXeBkdQOhet8uok/LRl
         yfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4MZBxNvGtwJNQOCKRNJ0W32Q6ImcL8iXyB/wI559tJU=;
        b=HvISX3ztDY3XTU/pMCXGhxhCNIwfHMW2IrXGi0N2VeQGVS59L3+sn1ekFm4Cc4r2Js
         0SjhF32GWX+0WObLLzPwxlNTtl1sZ9rsd3+dhfc5bY/zuJf3CpMlrw3WOdOgIBi/s/yK
         wzyBlgrM05cWY0zoD+cdFejqdBQ6vMI7jRVdOYPI4PXL6aXzGKxQqdXTPcqxxTrDEMbY
         jKRcxXwWtuUjT3VYLtgVWpJcgdK/XauRlT5ddix90R38DGTer4cyUsOhUAxY/V9jpgIv
         sNVAgfEUSp/pDQ92/ImFWI3B0xfTmgEKWcHCrdwWX3/8B74pPC7JLRBS/1l3sJvDu+V0
         Asyw==
X-Gm-Message-State: APjAAAXvm+H7SvZ0+JA3NPD8rdo/pAF1n0+fZ6Ndl0bzFHfYDFvKZA16
        aDqsK4ltBhk6VbCmSz7HzCE=
X-Google-Smtp-Source: APXvYqyKh/7il576XGHp65eMmC1xfXtJ1/wi2PPl4i1nbhDgkXclyXtNHcK4YDXWQiy14U583qT6aw==
X-Received: by 2002:a17:902:20e2:: with SMTP id v31mr85167668plg.138.1558465241341;
        Tue, 21 May 2019 12:00:41 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id 129sm25481818pff.140.2019.05.21.12.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:00:40 -0700 (PDT)
Date:   Wed, 22 May 2019 00:30:33 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Murray McAllister <murray.mcallister@insomniasec.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Michael Straube <straube.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: rtl8723bs: core: rtw_ap: fix Unneeded variable:
 "ret". Return "0
Message-ID: <20190521190032.GA7486@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function "rtw_sta_flush" always returns 0 value.
So change return type of rtw_sta_flush from int to void.

Same thing applies for rtw_hostapd_sta_flush

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
------
Changes v2 -
	change return type of rtw_sta_flush

-----
 drivers/staging/rtl8723bs/core/rtw_ap.c           | 7 ++-----
 drivers/staging/rtl8723bs/include/rtw_ap.h        | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 4 ++--
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 7 +++----
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index bc02306..19418ea 100644
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
+		return ;
 
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
index db553f2..ce57e0e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2896,9 +2896,9 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 
 		flush_all_cam_entry(padapter);	/* clear CAM */
 
-		ret = rtw_sta_flush(padapter);
+		rtw_sta_flush(padapter);
 
-		return ret;
+		return 0;
 	}
 
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e3d3569..a4d05f2 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -3754,7 +3754,7 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 
 }
 
-static int rtw_hostapd_sta_flush(struct net_device *dev)
+static void rtw_hostapd_sta_flush(struct net_device *dev)
 {
 	/* _irqL irqL; */
 	/* struct list_head	*phead, *plist; */
@@ -3766,8 +3766,7 @@ static int rtw_hostapd_sta_flush(struct net_device *dev)
 
 	flush_all_cam_entry(padapter);	/* clear CAM */
 
-	return rtw_sta_flush(padapter);
-
+	rtw_sta_flush(padapter);
 }
 
 static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
@@ -4254,7 +4253,7 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 	switch (param->cmd) {
 		case RTL871X_HOSTAPD_FLUSH:
 
-			ret = rtw_hostapd_sta_flush(dev);
+			rtw_hostapd_sta_flush(dev);
 
 			break;
 
-- 
2.7.4

