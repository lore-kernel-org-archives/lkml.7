Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCDAC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B51F2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlB+0vLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKWPQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 10:16:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40991 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKWPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 10:16:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id b18so12150966wrj.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 07:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/TrPUC3MHLbDZj3FLNVhaKoasoXmU+H+GHGqM8LGHY=;
        b=GlB+0vLNG7e339zd6nPJJuCqwyuni4EvNJZq5VoGqKE3p1pbroyqhD3y6ZtqtofLtd
         eYRyt29J3ZUYmYSUl9cGBDtvNW5okUPM8fJRO1cgvCUyIcAwLoDSMQjTps/lPqLYC6+j
         0lYndECfBK4G9nbEqwG+6Rk/xoPK4TH4fJdjX59fwk7TkBRvPPr2oSTnU04hpxREB1c8
         RH8Daq/7NXRdAzGsVFl8IE/ZUIUbkXzIx3XvAmUR0ttVKehUWwHQ0/FIQIV3MFlwcCPZ
         KRem+bVv91a+Lzn6wFZhJluqye6uN3CnpJF8r2DR5NEl453J62RcSXFVeeXQZuvd78iJ
         6VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/TrPUC3MHLbDZj3FLNVhaKoasoXmU+H+GHGqM8LGHY=;
        b=SAt1sL7IwSSXTk9r0PB4g2P/tDnentCfs0ovbHUzDW9KIM6P2aXxrEnSHQaH11aI9M
         U9O1sVt1CZYlqNJucsvalMZtEKKr99O7LjJa4Q3UzAaWF4jzHIO9U7+VvXj5oVuCyCGG
         ZgWzmALUI1ROu4eiEdsU7+hnF+e1tSucws7ijToAZ/VLEj0pHBc8sVYGvMSKe1Kui/TL
         ovh+1jAVDojqPjEGcJlwnCFLX2w94UCr6Oo1/xZLfRrApZ9b/Zvawe4Qlvh1MZG5+cHR
         HUoAItFPnL/gSvDBYqkjfNR9ZtB+BTb1CBxfxFNjmQHBbeiSnVhXMBXJkWJKzd/RlgXr
         Jhfg==
X-Gm-Message-State: APjAAAVmf7XZcDSIvTPic5E7IFV/GDN8GLUv1QiaDRsCSETPys1CASjn
        BsD7ACPR3loYNrkuFndGuW0=
X-Google-Smtp-Source: APXvYqyiqj4mouUcmStNAu3bkXi35knuWatKHI4lUv6tYQ2bfMpIwjsiTcICWqYerDGwJkzuywqXgA==
X-Received: by 2002:adf:ab4c:: with SMTP id r12mr22456332wrc.3.1574522207041;
        Sat, 23 Nov 2019 07:16:47 -0800 (PST)
Received: from localhost.localdomain (dslb-092-073-054-228.092.073.pools.vodafone-ip.de. [92.73.54.228])
        by smtp.gmail.com with ESMTPSA id p25sm2126311wma.20.2019.11.23.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 07:16:46 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: remove unnecessary parentheses in rtw_pwrctrl.c
Date:   Sat, 23 Nov 2019 16:16:33 +0100
Message-Id: <20191123151635.155138-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 03dc7e5fcc38..010a0cdf7940 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -154,8 +154,8 @@ void ips_enter(struct adapter *padapter)
 int ips_leave(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int result = _SUCCESS;
 	int keyid;
 
@@ -200,7 +200,7 @@ int ips_leave(struct adapter *padapter)
 
 static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 {
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	bool ret = false;
 
 	if (time_after_eq(adapter->pwrctrlpriv.ips_deny_time, jiffies))
@@ -221,7 +221,7 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 void rtw_ps_processor(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	enum rt_rf_power_state rfpwrstate;
 
 	pwrpriv->ps_processing = true;
@@ -336,7 +336,7 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 {
 	unsigned long curr_time, delta_time;
 	struct pwrctrl_priv	*pwrpriv = &padapter->pwrctrlpriv;
-	struct mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
 	curr_time = jiffies;
 	delta_time = curr_time - pwrpriv->DelayLPSLastTimeStamp;
@@ -483,7 +483,7 @@ void LPS_Leave(struct adapter *padapter)
 /*  */
 void LeaveAllPowerSaveMode(struct adapter *Adapter)
 {
-	struct mlme_priv	*pmlmepriv = &(Adapter->mlmepriv);
+	struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
 	u8	enqueue = 0;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED))
-- 
2.24.0

