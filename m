Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D3C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B852C205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeqMnVa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfF0Rl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:41:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37190 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfF0Rlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:41:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so1674999plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2VYDCnCkjTc4D1Rc+1yi7URn+GvuL8YDs5hLnh987G4=;
        b=PeqMnVa90eH6XmW4Pwsb1MXiobPzsonXWvpMiumT1y2ej23Ow+SoW62w2O/LDbeO1e
         3h1DOn9wKWrO5nmTyyVmso448pE11L8us2+8iCzL/7A1aO3jxIxznGrXNdl46RhED/A+
         j4pOnE2yggAaQFq2Yv6FiPvuNC1PrcGRl0tdgfpSMjSsvIVaaOIkA+7I4hyiLaI6Twsa
         EKUj4NTKisERy29J50AR4MqEybp12UGPbYKAT1/hBLmbwlLZ0OXQt7MOk89G53T0OkR5
         cPnJYlUlSPDxgkzaXmQMW6OwAjnUmqAUYW6aIhZmyLL7nKZ73H4RHzhfYYIc1BHA2z4r
         tu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2VYDCnCkjTc4D1Rc+1yi7URn+GvuL8YDs5hLnh987G4=;
        b=JwXzYKMyyl4Yqg44a+8HIEfTgflqdk8bzXMwVLS1Je7YAMAWvW/1de3Nf1IkRkxivz
         dcqvzeCLzY2CkY7uqUsGXntfaG5i6XMZW+wnUC4Dzu5YeK5wfM2AetSIyyLsFvqCe0lT
         dMcoeXGwrXC0S3Fb77XsiwaMQKEEh12LyhTZzQC0NYLNeZ8MRnnjQrXC9F6lkgjvLftK
         XpxWX8/L31jAQnVOMIeB/5rspXMgK6+rey7gTj9ytRRzIqHewEWl2A6O3cEapsVfDAj8
         4Hq9t+CnS8ojLirH4IDGzN2iaZCv1jh8Kux8qVcZG7EJkHdZa4qVpmsP/y6Q80ujbWD9
         BxvA==
X-Gm-Message-State: APjAAAXb6XNH2N//SlBsmuc+xq9xY7tXwGc2mCQwSF9Mawb92Zrvfa56
        prV5ZcRJpUXXKuoDM7rpOE8=
X-Google-Smtp-Source: APXvYqzy/YIr9pHDGrFuSAuRUcPDT3AJwGJ65uBsd/zz3swNtVS7UMhIo+cnDoLJAxvfN4wspOSY3w==
X-Received: by 2002:a17:902:2ec5:: with SMTP id r63mr5946757plb.21.1561657314951;
        Thu, 27 Jun 2019 10:41:54 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id l44sm5656206pje.29.2019.06.27.10.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:41:54 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 48/87] rtl8723bs: os_dep: replace rtw_malloc and memset with rtw_zmalloc
Date:   Fri, 28 Jun 2019 01:41:44 +0800
Message-Id: <20190627174147.4504-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_malloc + memset(0) -> rtw_zmalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 ++------
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 12 +++---------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index db553f2e4c0b..f8e0723f5d1f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1078,12 +1078,10 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	DBG_871X("pairwise =%d\n", pairwise);
 
 	param_len = sizeof(struct ieee_param) + params->key_len;
-	param = rtw_malloc(param_len);
+	param = rtw_zmalloc(param_len);
 	if (param == NULL)
 		return -1;
 
-	memset(param, 0, param_len);
-
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
 	memset(param->sta_addr, 0xff, ETH_ALEN);
 
@@ -2167,15 +2165,13 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 		{
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = rtw_malloc(wep_total_len);
+			pwep = rtw_zmalloc(wep_total_len);
 			if (pwep == NULL) {
 				DBG_871X(" wpa_set_encryption: pwep allocate fail !!!\n");
 				ret = -ENOMEM;
 				goto exit;
 			}
 
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e3d356952875..1491d420929c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -478,14 +478,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = rtw_malloc(wep_total_len);
+			pwep = rtw_zmalloc(wep_total_len);
 			if (pwep == NULL) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
 			}
 
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 
@@ -2144,12 +2142,10 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 	int ret = 0;
 
 	param_len = sizeof(struct ieee_param) + pext->key_len;
-	param = rtw_malloc(param_len);
+	param = rtw_zmalloc(param_len);
 	if (param == NULL)
 		return -1;
 
-	memset(param, 0, param_len);
-
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
 	memset(param->sta_addr, 0xff, ETH_ALEN);
 
@@ -3522,14 +3518,12 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = rtw_malloc(wep_total_len);
+			pwep = rtw_zmalloc(wep_total_len);
 			if (pwep == NULL) {
 				DBG_871X(" r871x_set_encryption: pwep allocate fail !!!\n");
 				goto exit;
 			}
 
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 
-- 
2.11.0

