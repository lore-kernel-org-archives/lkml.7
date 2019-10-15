Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C99C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FD4205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCnleJWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbfJOPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:45:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35147 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:45:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id v8so18514770eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yW8xr8iEic65XnjxnmqB+HKy0i7WjaAMK2VRQT1VESQ=;
        b=jCnleJWNSIE6p0EcgwHM3yORVXMJoYM/2LPUBJjrKgux6TXMBSTKOSPnGXf8NFx2Cc
         s2eimFJRZDKbwhktq7J7s3MJQgYlJH1uuuoKWAnQWEKn7oatw7PEGZ33hUIMy5LEJGOQ
         V3vnNOwgKGUFXOZ7ii2HeSUT91GMcSuMAjjFqM+JLWg1MpGB7mIYYBd0UXP8a7z/zBD5
         /dHXdiSIPMvASWDL8Yks1QpPQ5S+8UvzP4CBNzmvzNtvdzpckOfb4biOKZ2Fq0j8MZY7
         48LFtRHc7k9o9iYc1Q6N5VYfjxmxd66Hq9IjF3vH2joUFSmAk3ryw8jX25DxcvXQ60jq
         UUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yW8xr8iEic65XnjxnmqB+HKy0i7WjaAMK2VRQT1VESQ=;
        b=UruKwaEy5tA39/THhFrtKWYwP0Z4W9Vl2QHMEtVzkKlOyfSfLLhxPQO3b/5LMrZeCE
         nlTUOZ/Mk4jpvxJviWFEZI0+OpZ+1VL5UrTu3e1Zu3nrkf2z7/hYJRBXDN1vgFoqxbDP
         Mpe6nuV8r00SqnlN+HQEecICLPfRzsdJAy27XrO/ifXdF3JnxatwQiE8lXivvQqHWDGV
         DRR5T2A2TJvOQzfmv69/QdE7oRkIWUEYWh033OzIL0tKYv28wPmCRPVV1mL9niHhwa57
         uZFlmfDQK7MMJzg6Fob6xHPs++owj0+nsdEY2YSDoS8d5PBmLMHUQxhiSizJJ20VDweF
         BHZA==
X-Gm-Message-State: APjAAAWY/EKHRWoOmyN+yH5U+pju/YtFn27SOenxHOCjgjLjYz7HM/F7
        nutKkG8oU8SWbjRNSCLp4mc=
X-Google-Smtp-Source: APXvYqwg1840dcStG/Lyyi7CGNktO56vi0k0C8rD7IJp4SzHStR1FGBIcW+3VqNE9H8E6ugcq93UfQ==
X-Received: by 2002:a50:ace1:: with SMTP id x88mr34603745edc.132.1571154348846;
        Tue, 15 Oct 2019 08:45:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id nq1sm2807787ejb.75.2019.10.15.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:45:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: rename variables to avoid mixed case
Date:   Tue, 15 Oct 2019 17:45:33 +0200
Message-Id: <20191015154535.27979-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename local variables to avoid mixed case.

max_AMPDU_len -> max_ampdu_len
min_MPDU_spacing -> min_mpdu_spacing

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index c985b1468d41..6d56ca7ee7b4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -667,7 +667,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var
 void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 {
 	unsigned int i;
-	u8 max_AMPDU_len, min_MPDU_spacing;
+	u8 max_ampdu_len, min_mpdu_spacing;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -689,16 +689,16 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 		} else {
 			/* modify from  fw by Thomas 2010/11/17 */
 			if ((pmlmeinfo->HT_caps.ampdu_params_info & 0x3) > (pIE->data[i] & 0x3))
-				max_AMPDU_len = pIE->data[i] & 0x3;
+				max_ampdu_len = pIE->data[i] & 0x3;
 			else
-				max_AMPDU_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x3;
+				max_ampdu_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x3;
 
 			if ((pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) > (pIE->data[i] & 0x1c))
-				min_MPDU_spacing = pmlmeinfo->HT_caps.ampdu_params_info & 0x1c;
+				min_mpdu_spacing = pmlmeinfo->HT_caps.ampdu_params_info & 0x1c;
 			else
-				min_MPDU_spacing = pIE->data[i] & 0x1c;
+				min_mpdu_spacing = pIE->data[i] & 0x1c;
 
-			pmlmeinfo->HT_caps.ampdu_params_info = max_AMPDU_len | min_MPDU_spacing;
+			pmlmeinfo->HT_caps.ampdu_params_info = max_ampdu_len | min_mpdu_spacing;
 		}
 	}
 
@@ -729,8 +729,8 @@ void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 
 void HTOnAssocRsp(struct adapter *padapter)
 {
-	unsigned char max_AMPDU_len;
-	unsigned char min_MPDU_spacing;
+	unsigned char max_ampdu_len;
+	unsigned char min_mpdu_spacing;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
@@ -748,13 +748,13 @@ void HTOnAssocRsp(struct adapter *padapter)
 	 * AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
 	 * AMPDU_para [4:2]:Min MPDU Start Spacing
 	 */
-	max_AMPDU_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
+	max_ampdu_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
 
-	min_MPDU_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
+	min_mpdu_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, (u8 *)(&min_MPDU_spacing));
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, (u8 *)(&min_mpdu_spacing));
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_AMPDU_len));
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_ampdu_len));
 }
 
 void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
-- 
2.23.0

