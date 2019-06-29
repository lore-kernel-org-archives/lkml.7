Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97C0C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 18:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D5214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 18:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7k9iNR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfF2S05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 14:26:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45347 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfF2S05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 14:26:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so5032409plb.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0AQq5+Vp+iXDTeJ3o4QHOhInjIIqHgZpcbiK10bqgAM=;
        b=D7k9iNR7pd51jAEyBLiLrYZjx2Oio8czS27/BNqc7Bi2lJR7CCbpGnLt9mcSGaZ8tZ
         MMWwgA1dTkZZkZht4IS5ITJP/FlXuPAn0Fm0tzCEkuaZoxLQemw6lJ9tAeabX4iFcPx8
         yMIqWnSzVZ9vXqSNXL96ePGr4DKVtP1TYZYiWVrrfprg/b+SJu+JvjYfPCG89UtrpUl1
         n2jp9j8M6hSlBS36mbWfwAIXeqcncOz/5pA7N0/YzjMhWs8Sj7IcTNlBC70lCaZDkXKw
         oCFMEL35oKPaO2H9o7cr9PHl1Yz71vDBDFYmieTUqHQsaGHpuiUZ13Zc47+/zA6GE6Hd
         ZGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0AQq5+Vp+iXDTeJ3o4QHOhInjIIqHgZpcbiK10bqgAM=;
        b=cNBvZVnZCTWTa21MkJw70KuGvHe652Q9bsGk+Lwhp9lOKt6beyTYO9daqa51hK8RSO
         GgQf6kDRd1agKX3CL4eA8y21hlsI77gK0bYQfmCGAz5nAwyRMqISf6TBpXlJCdKKnvqc
         4bFeTsnsiudQpaIPEK2L5GRvOqh5ZYaxWAIKxS7ADpkQWvrAkcnnaPgIXG4vQuLxbR3O
         HMgZERGZQqmG4lyqiMVfjibaw/pZi7B2QpXEmc+JvaWkOK0Mgm55s+T4uc3nenrQuVql
         ggziC26J9J/GkrlB/bVuNWiEUwiNGR2UaojNDV5EwYT7zSDv6FXezELdI7AhL1k7HWE5
         ucrw==
X-Gm-Message-State: APjAAAUKbbBAlnVnZSwHUGdvcyEJ38XCeXwdoCB/3R9ztSetffBaqaU2
        FeOiAk77dtbulS+X4qtNMOU=
X-Google-Smtp-Source: APXvYqxRjI+V0IAfuEbzIaM5/WnOj2f/0ZA5jYjT/GrCALlOUwdqdF1xnPoyYbOQqQmWdKsNswhu3w==
X-Received: by 2002:a17:902:b093:: with SMTP id p19mr18443296plr.141.1561832816301;
        Sat, 29 Jun 2019 11:26:56 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id z20sm12267284pfk.72.2019.06.29.11.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 11:26:55 -0700 (PDT)
Date:   Sat, 29 Jun 2019 23:56:50 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Florian =?iso-8859-1?Q?B=FCstgens?= <flbue@gmx.de>,
        Bhaskar Singh <bhaskar.kernel@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/rtl8188eu/os_dep: Remove unneeded variable ret
Message-ID: <20190629182650.GA9138@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below list of functions returns 0 in success and -EINVAL in failure. So
directly return 0 on Success.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index eaa4adb..d9d0462 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -2508,7 +2508,6 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 
 static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 {
-	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
@@ -2538,7 +2537,7 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 		DBG_88E("rtw_del_sta(), sta has already been removed or never been added\n");
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *param, int len)
@@ -2636,7 +2635,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 
 static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param, int len)
 {
-	int ret = 0;
 	unsigned char wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
@@ -2668,12 +2666,11 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 		pmlmeext->bstart_bss = true;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *param, int len)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	int ie_len;
@@ -2698,12 +2695,11 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *param, int len)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	int ie_len;
@@ -2729,12 +2725,11 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param, int len)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
@@ -2754,7 +2749,7 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 		value = 0;
 	DBG_88E("%s value(%u)\n", __func__, value);
 	pmlmeinfo->hidden_ssid_mode = value;
-	return ret;
+	return 0;
 }
 
 static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *param, int len)
@@ -2787,7 +2782,6 @@ static int rtw_ioctl_acl_add_sta(struct net_device *dev, struct ieee_param *para
 
 static int rtw_ioctl_set_macaddr_acl(struct net_device *dev, struct ieee_param *param, int len)
 {
-	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
@@ -2796,7 +2790,7 @@ static int rtw_ioctl_set_macaddr_acl(struct net_device *dev, struct ieee_param *
 
 	rtw_set_macaddr_acl(padapter, param->u.mlme.command);
 
-	return ret;
+	return 0;
 }
 
 static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
-- 
2.7.4

