Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8708ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C901222C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsB6NmgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfJZMMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:12:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54912 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfJZML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:11:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so4837750wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfPUIgUWgffxKXgP3/ETgSqjZhUKnyysDpsFlHetnSw=;
        b=FsB6NmgAB6uqLYV1kF+yiHpbLc8zuklmoFwAVexNabfQWgO37sS1UZAI0fQrFBcedh
         litNEBRtuSxCuIs5VcD64zubXmdEiPf1xNoMvCNcJzzT+Rrj9QAVLDrX3UPHXYnmFjO4
         kKJmVl5mAEZattFbYXfjY2xAjO21RKv1BXKDz/YV2eHMzjg5XjNw5zTJPwe1Z5KT8op+
         KTGb2eOqQmmrz1Y9cPcn0sM45rufdLAFDpRp9Sibo0fnP/+UDlkVfziN0B4MTADsBYyd
         vO711VhJqGrjk+WMQ5sHMaAn9BwADKzx/FcphpV6xaRtMTIPzrFwrfqfrnvZ/4AqkdZN
         u/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfPUIgUWgffxKXgP3/ETgSqjZhUKnyysDpsFlHetnSw=;
        b=kONH2oeEO+hRMlmzvt1R1jk+8Pi1CejQ7Co81vH9sFVAQi3Y7kHiuFOMDp+xF9TZGA
         WuD9mBtqS33G9Fnlz5evZJh1Y6MlVlcFGr8zkXmD37OdT6wHeUSDWL//4Bw3a+UDQaqQ
         9TBknpNhSvI/avOuRx2KU8+pWM1Donm/NIVOM/92gqxxMuXdZOljWHL6+gct48jnJHDW
         Z51xrfAg7GBSitibamUy0sTwPtqQhu3/euRG3JHt0IbBjxMRHCTsXT55twG/LbVuAzP1
         bIknSWnKfRYnGbQDqyq9Zvw1vyzSOQaabz394CKVgKMQaovdEDJcG7IH3NL4O2jgos9v
         y3Pg==
X-Gm-Message-State: APjAAAWOrX9xX5Jv+Zj6ZCLc5rc0+kBcm9+mkK/4vAoaYppJFffpZh1Y
        +AgKzgIQHAvH2ssMC8frvXk=
X-Google-Smtp-Source: APXvYqzywJ6DRD/YjmbGjQhwLO6eRyQLLH/++2xr0UR8QeRkEvXX633XUFDDIqL7MaWn7btxnVdMaw==
X-Received: by 2002:a1c:a657:: with SMTP id p84mr7158331wme.35.1572091916488;
        Sat, 26 Oct 2019 05:11:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id v8sm5789906wra.79.2019.10.26.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 05:11:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/7] staging: rtl8188eu: cleanup long lines in rtw_sta_mgt.c
Date:   Sat, 26 Oct 2019 14:11:34 +0200
Message-Id: <20191026121135.181897-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026121135.181897-1-straube.linux@gmail.com>
References: <20191026121135.181897-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup lines over 80 characters in rtw_sta_mgt.c by adding line
breaks where appropriate.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 3cadc46836e1..43925b1f43ef 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -83,7 +83,8 @@ u32 _rtw_init_sta_priv(struct sta_priv *pstapriv)
 
 		INIT_LIST_HEAD(&pstapriv->sta_hash[i]);
 
-		list_add_tail(&psta->list, get_list_head(&pstapriv->free_sta_queue));
+		list_add_tail(&psta->list,
+			      get_list_head(&pstapriv->free_sta_queue));
 
 		psta++;
 	}
@@ -186,9 +187,11 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		_rtw_init_stainfo(psta);
 		memcpy(psta->hwaddr, hwaddr, ETH_ALEN);
 		index = wifi_mac_hash(hwaddr);
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_, ("%s: index=%x", __func__, index));
+		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
+			 ("%s: index=%x", __func__, index));
 		if (index >= NUM_STA) {
-			RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("ERROR => %s: index >= NUM_STA", __func__));
+			RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
+				 ("ERROR => %s: index >= NUM_STA", __func__));
 			psta = NULL;
 			goto exit;
 		}
@@ -208,7 +211,8 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		 */
 
 		for (i = 0; i < 16; i++)
-			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i], &wRxSeqInitialValue, 2);
+			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i],
+			       &wRxSeqInitialValue, 2);
 
 		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
 			 ("alloc number_%d stainfo  with hwaddr = %pM\n",
@@ -457,7 +461,8 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 	if (!psta) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("rtw_alloc_stainfo fail"));
+		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
+			 ("rtw_alloc_stainfo fail"));
 		goto exit;
 	}
 
-- 
2.23.0

