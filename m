Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F830C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7A7206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO7Q045V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfGaSVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:21:10 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:43883 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbfGaSVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:21:10 -0400
Received: by mail-pl1-f178.google.com with SMTP id 4so23851021pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dkFZjVxhLg5nUBZBwLUZXfe8WesR8N6+UbConjepUGg=;
        b=XO7Q045V4NUHekNM727e11s2Hin3uH7R4fJpX+7PKmq38/QWde10CmJmFUmTRQsI29
         R3DbbjSCtF3a0Jbg/Wv9rqkpNMxRa79EoadaxLOnd9KCQ2AMCOpjl0DTikacHfaB4uMZ
         9EC3ZW0mjMiWAAl1R51R49k9MnxgPjFjJYGorT90WubZ5QMUDD2SPuxkVwFVFCMtL3a/
         AVrekYjGzush1DEPMnpVdtWieFvV2jsLVehLmuakdZCJ6/+W/CN3ZQwOWz4VxA+hxe4v
         ow7kxUPcGHT/M4F6z5hkqJXfseD7k3EFsllDrMt3zL4NYsUzydkf0PU/trD2yJzE8Dcj
         VGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dkFZjVxhLg5nUBZBwLUZXfe8WesR8N6+UbConjepUGg=;
        b=WjEgC8Xm6cMJpM8p1un33fWHqV+Ej/bAb3nKqPK6rZ9O5za8+d5Qkp5PMNXWfieTDx
         2D+wj3dqhi/2JdSW2rCBl7AM/LNQ3NefmbxFOqthw0kdC4EQgNKBAWmdwV7VF31/z2/q
         5IDz51Qh6S7wVsTlx9yvGhN0WLjeXJCiLGaK3I/FqzpX8cgLDwOYLGsL9he7SdiaikRc
         TSXWmaiv15kADCPWGV/4E8V2xc3JIiYRIwV1SH4nYmna6cuMbYOWL+Me/srZhADPiTyi
         BrfIYAUA0sVDlAZCP5L53HsEmCKgRraMca6yorR2YeUBaO2t/AbB9RwPwHcAMbyhfrzL
         ov2Q==
X-Gm-Message-State: APjAAAViMZ1ykMz8dWoPffk+qvbo+OayxrhLp8XkXR/7O+3f/fVaTZEk
        Y1RWgagTaetf6ZS1OlBvJS4=
X-Google-Smtp-Source: APXvYqxhc6rBwB828OfKzoKZKB44oQViEuHs5TVaTW4pjaA0GRwu0HIXWKsdrv3YY6rp6WF/vWLkFA==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr113868926plb.299.1564597269551;
        Wed, 31 Jul 2019 11:21:09 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id k6sm78719059pfi.12.2019.07.31.11.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:21:09 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:51:03 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Subject: [Patch v2 07/10] staging: rtl8723bs: Remove unneeded function
 argument for init_addba_retry_timer
Message-ID: <20190731182103.GA9617@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_addba_retry_timer does not use padapter, so only keep psta

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v2 - Add patch number

 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c     | 2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index bdc52d8..39c3482 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -262,7 +262,7 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 			)
 		);
 
-		init_addba_retry_timer(pstapriv->padapter, psta);
+		init_addba_retry_timer(psta);
 
 		/* for A-MPDU Rx reordering buffer control */
 		for (i = 0; i < 16 ; i++) {
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index fd3cf95..bdbf15f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -539,7 +539,7 @@ void init_mlme_ext_priv(struct adapter *padapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv (struct mlme_ext_priv *pmlmeext);
 extern void init_mlme_ext_timer(struct adapter *padapter);
-extern void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta);
+extern void init_addba_retry_timer(struct sta_info *psta);
 extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
 
 /* void fill_fwpriv(struct adapter *padapter, struct fw_priv *pfwpriv); */
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 52a5b31..038036d 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -179,7 +179,7 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	}
 }
 
-void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
+void init_addba_retry_timer(struct sta_info *psta)
 {
 	timer_setup(&psta->addba_retry_timer, addba_timer_hdl, 0);
 }
-- 
2.7.4

