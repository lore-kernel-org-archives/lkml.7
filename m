Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D30FC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7B2207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rubne3a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFGDK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 23:10:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34087 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFGDK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 23:10:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so255432plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WDhw+eAgLM5AT/4N10m4uBp8IUkFKeIWWDX2t9FopMg=;
        b=Rubne3a8bo3lLNZqXpWyu4eQr2bbgv90zhzbIpUjAxUN1EVS3NoIvHjzBlKjjXwSzg
         BSBKKDMUIchhCCsdG/hkiwqUP9quQycwXSk486ZSMS8ZXTDoVjd2oZtKTqTB5QPM8eJy
         Rh+8X6V0y/SRyIZDGNmsIhH3WuOcsi9uZBkBDxprxoUWmBlyhezwDirygMwQgovyDApV
         3MlRY682DOCihpGwkSWCVD7tudTch4AB2OxBgcTZfsjw6+gLPa85j0vHHoP+ZeQMLNl+
         99zkuY4Q2aXEwGqIZmdAp8BmZwhbSsCoDGxiEx6kknY9yWtR02/34FbcQ1ba+R1lqMaq
         fsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WDhw+eAgLM5AT/4N10m4uBp8IUkFKeIWWDX2t9FopMg=;
        b=W4+FtnR6vHLRLAqsk/j/FFZUwxZ7T31SNgiwAcnqpQ5wwBL9erbpNBZvAY9Cxtcf2T
         8j3Dg/AH/fHKQ/CdkdFS9z16TJK1QrNNzSnnhcKEBhH8nsKtJasfMwHVKp5QhcXwhLzG
         DgJ6y55h9tZc8KNEYlJ/nHIR8L79sB5xq7UEvKh9iuXp8PSMXuZmdDL5gGUkB07+RRtt
         nxWrMYoBGSpKowri4+kERUmGwrZF5cnWlnPJj/5AFJQpC7usZIm2jbbHrljFo4M7A2d9
         orRWzx0aiqlyzUKVafkWo9uPgSFfaRfB/ElidxUv/jTOHc5+gNv0DcTem0YgWMRStRug
         ilvQ==
X-Gm-Message-State: APjAAAWQX7OSDiiUgBebl8VbTIvvil+JmyzFXRz78et0fsmkWGwnAP1k
        vuNJy9OyuCpI+iQl3edgyMg=
X-Google-Smtp-Source: APXvYqxY9Lwp/AoQFktEEK2OZh5HhrarwcZh+km/uPOTNoEDEI0sI8RDcTlES8cNSuAW3WBJBOgB3w==
X-Received: by 2002:a17:902:4906:: with SMTP id u6mr54171843pld.220.1559877055239;
        Thu, 06 Jun 2019 20:10:55 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id k3sm403781pju.27.2019.06.06.20.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 20:10:54 -0700 (PDT)
Date:   Thu, 6 Jun 2019 20:10:52 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] staging: rtl8723bs: Fix Unneeded variable: "ret". Return "0"
Message-ID: <20190607031049.GA30138@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck reported Unneeded variable ret at rtl8723bs/core/rtw_ap.c:1400.
Function "rtw_acl_remove_sta" always returns 0. Modified return type of the
function to void.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c        | 4 +---
 drivers/staging/rtl8723bs/include/rtw_ap.h     | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 3 ++-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 7bebb41..87b201a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1394,10 +1394,9 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 	return ret;
 }
 
-int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
+void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 {
 	struct list_head	*plist, *phead;
-	int ret = 0;
 	struct rtw_wlan_acl_node *paclnode;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
@@ -1438,7 +1437,6 @@ int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 
 	DBG_871X("%s, acl_num =%d\n", __func__, pacl_list->num);
 
-	return ret;
 }
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
diff --git a/drivers/staging/rtl8723bs/include/rtw_ap.h b/drivers/staging/rtl8723bs/include/rtw_ap.h
index d6f3a3a..4a1ed9e 100644
--- a/drivers/staging/rtl8723bs/include/rtw_ap.h
+++ b/drivers/staging/rtl8723bs/include/rtw_ap.h
@@ -19,7 +19,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len);
 void rtw_ap_restore_network(struct adapter *padapter);
 void rtw_set_macaddr_acl(struct adapter *padapter, int mode);
 int rtw_acl_add_sta(struct adapter *padapter, u8 *addr);
-int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr);
+void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr);
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta);
 int rtw_ap_set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 236a462..9da1fd2 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4174,7 +4174,8 @@ static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *p
 		return -EINVAL;
 	}
 
-	return rtw_acl_remove_sta(padapter, param->sta_addr);
+	rtw_acl_remove_sta(padapter, param->sta_addr);
+	return 0;
 
 }
 
-- 
2.7.4

