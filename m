Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E47C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BBC204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsCB2O3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfESROh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:14:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45691 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:14:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id a5so5572603pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=onWg9sXJkwr5YDouwUnwMigAm53+6Ypsow5mIz9jnVY=;
        b=DsCB2O3R3rEIST8TFYsL76ySpcSxa2N2xCasptSobJ7Wpiu/A0m518d6+7QBQGFRRe
         qxABKKsMQLE3ZKvSzzNSkx2REVO//M3z/mKDpfR607d35S9GYBB6N5kA581JGnG0E6lj
         CU7RGFMW9ERAIRyjjRthI71b2jjKaLqFt9V5eh83suyYye+DNItxj6Y4E5c9f3BXD2sT
         Mkc5b6dwGR83UGASHefQCGaQ60BpSmDuqnT2v2MQl5Y0YB55O4hz0pN34SosRhf+zf46
         XfvPM1yT9Nm2gR4DiqvwStHv5/LBXhO/nFnI7r6+hMSerChNlgOPhVvFtCVaugpMc7/G
         jp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=onWg9sXJkwr5YDouwUnwMigAm53+6Ypsow5mIz9jnVY=;
        b=h71JJZJ5oYbrxhmZ3cwhdQIeiydnAtm0ADXiNMWIz5AIegNFYWMhizzZGkh5Grt7p3
         OE5dHPw1njNAgNzs19O8SKauRTqEv62zQ+4HcHfL9dPunQm6jCgh9sHO6EQE5XH4YCq3
         exP526fUxkDVSSnrCVt+VOOVml5KeM9x1fYgOW1wgGQ/HHFVkk9e/NEKLUOeHB9bcX6n
         CCXRAHGtT1rJ8Dj3idYR4KuynZk3R8lflZcAfLLRznckiZ3Dq691t9HHFrKydwt+6m75
         at99bUZUDcYxoOu0v73J9l3KiH1xaH6owc1RcHluhBVzk3Mcan/O3DCWVBsVWfYzZ3o6
         l3lA==
X-Gm-Message-State: APjAAAV88zELFnRzhss5WVNYpSzkKaxTEGqKrJbhZp0w2hfPQBnAtDVY
        GSnbAGGdXbUNQ7sK3CpeyKYZfmx/
X-Google-Smtp-Source: APXvYqyLtcTyGcxDncp6K5Uf7tQPnwHwO5gdsxW9nfOf4fMa5PVWAmaLsk5dmK4ctZrfjihhZ8UhOg==
X-Received: by 2002:a17:902:6a83:: with SMTP id n3mr71412894plk.109.1558284291995;
        Sun, 19 May 2019 09:44:51 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id q75sm21542256pfa.175.2019.05.19.09.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 09:44:51 -0700 (PDT)
Date:   Sun, 19 May 2019 22:14:45 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Murray McAllister <murray.mcallister@insomniasec.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: rtw_ap: fix Unneeded variable:
 "ret". Return "0"
Message-ID: <20190519164445.GA5268@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warnings reported by coccicheck

drivers/staging/rtl8723bs/core/rtw_ap.c:1400:5-8: Unneeded variable:
"ret". Return "0" on line 1441
drivers/staging/rtl8723bs/core/rtw_ap.c:2195:5-8: Unneeded variable:
"ret". Return "0" on line 2205

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index bc02306..a1b5ba4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1397,7 +1397,6 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 {
 	struct list_head	*plist, *phead;
-	int ret = 0;
 	struct rtw_wlan_acl_node *paclnode;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
@@ -1438,7 +1437,7 @@ int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 
 	DBG_871X("%s, acl_num =%d\n", __func__, pacl_list->num);
 
-	return ret;
+	return 0;
 }
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
@@ -2192,7 +2191,6 @@ u8 ap_free_sta(
 int rtw_sta_flush(struct adapter *padapter)
 {
 	struct list_head	*phead, *plist;
-	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -2202,7 +2200,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
 
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
-		return ret;
+		return 0;
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
@@ -2227,7 +2225,7 @@ int rtw_sta_flush(struct adapter *padapter)
 
 	associated_clients_update(padapter, true);
 
-	return ret;
+	return 0;
 }
 
 /* called > TSR LEVEL for USB or SDIO Interface*/
-- 
2.7.4

