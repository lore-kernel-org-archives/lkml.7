Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FD4C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E761E2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAp3Pi7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKWPQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 10:16:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44996 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 10:16:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so12103324wrn.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 07:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXrw9xXYn/OrnTMQI0ZQZW1/tehCBcD8aPYFJY2zdsc=;
        b=BAp3Pi7ZbAErJYMdHKzkv248C07xpb9NP8LhvRrXE9WQyBp6pfdnrM/kEPPGz+hQLa
         DWlgovKy8A1lisOW9+GenWY3WJFN6AOoPTr9ZONWGhdRQQgrm508nxwvqXxZXRQwcf1v
         N3kkXiR96ZDbvUc2xtijjdr37ex/ScCcati3uBbcNfIpzTfhIlgsU7aziDEiJB6bHUU1
         IkBFdKPQRGjF7mkA71fqovH4nUIddVgvcQyYvU6Wgp0LiW6XX8kuBBYGecJ9Ok2APRLF
         mp8GJ/LDOVKn5Ew1yn9kp4KjR7PnJsm/e5SqtGCGFPZTBcLCrgu6a4FC88tMgTtf1WJo
         etQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXrw9xXYn/OrnTMQI0ZQZW1/tehCBcD8aPYFJY2zdsc=;
        b=UGLZiFVNaAK2yoghX247FpmdpAVGGTk3qp+KljWbmJ2tnd+QDa1IkrV8368asKAkTb
         ViWFvTMcQM47BBcNsN2udwoedwAsl8VeIex4C887J4CWea+ZEAQRgUBIYbgsxUmgtgvN
         ufrxi0L03C9BcImSF/Oie5AaTRfmkxzxZWFO84y0aVUfWhTOnz1m/Hh8ReUhZBHZsT37
         LMKDUVbxrfI6dcWhOAxpbhcdAK9v73QziCsrvgGhYvLz5WBYyBoIcolqmAZPm5JctM03
         DLGqBOiEGv5R6esDXk6MEdzHmBsKgakELyiNSOftXazCgNeDRXMY6hnaoB8t7uG75MzQ
         wTSQ==
X-Gm-Message-State: APjAAAWqzIz2yGQQ7JpDDpx37EgpfGWtuRFe679QUCKNvw1nMCfqStqw
        32rPqp4pB5XfThTUGA/ulj0=
X-Google-Smtp-Source: APXvYqwR6NdHeDdjqDCeHHsiCZkALxbVSxcPUcWl6l3Inm0oheacR0ozm2tMlOtrrnn9ZZ9KFFj1Fw==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr13430458wrr.172.1574522207969;
        Sat, 23 Nov 2019 07:16:47 -0800 (PST)
Received: from localhost.localdomain (dslb-092-073-054-228.092.073.pools.vodafone-ip.de. [92.73.54.228])
        by smtp.gmail.com with ESMTPSA id p25sm2126311wma.20.2019.11.23.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 07:16:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: cleanup declarations in rtw_pwrctrl.c
Date:   Sat, 23 Nov 2019 16:16:34 +0100
Message-Id: <20191123151635.155138-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123151635.155138-1-straube.linux@gmail.com>
References: <20191123151635.155138-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in declarations to cleanup whitespace.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 010a0cdf7940..8e99e10c1fd4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -282,7 +282,7 @@ static void pwr_state_check_handler(struct timer_list *t)
  */
 void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 {
-	u8	rpwm;
+	u8 rpwm;
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
 	pslv = PS_STATE(pslv);
@@ -335,8 +335,8 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 static u8 PS_RDY_CHECK(struct adapter *padapter)
 {
 	unsigned long curr_time, delta_time;
-	struct pwrctrl_priv	*pwrpriv = &padapter->pwrctrlpriv;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	curr_time = jiffies;
 	delta_time = curr_time - pwrpriv->DelayLPSLastTimeStamp;
@@ -437,7 +437,7 @@ s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 /*  */
 void LPS_Enter(struct adapter *padapter)
 {
-	struct pwrctrl_priv	*pwrpriv = &padapter->pwrctrlpriv;
+	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
 	if (!PS_RDY_CHECK(padapter))
 		return;
@@ -463,7 +463,7 @@ void LPS_Enter(struct adapter *padapter)
 /*		Leave the leisure power save mode. */
 void LPS_Leave(struct adapter *padapter)
 {
-	struct pwrctrl_priv	*pwrpriv = &padapter->pwrctrlpriv;
+	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
 	if (pwrpriv->bLeisurePs) {
 		if (pwrpriv->pwr_mode != PS_MODE_ACTIVE) {
@@ -483,8 +483,8 @@ void LPS_Leave(struct adapter *padapter)
 /*  */
 void LeaveAllPowerSaveMode(struct adapter *Adapter)
 {
-	struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
-	u8	enqueue = 0;
+	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
+	u8 enqueue = 0;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		rtw_lps_ctrl_wk_cmd(Adapter, LPS_CTRL_LEAVE, enqueue);
@@ -611,7 +611,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 
 int rtw_pm_set_lps(struct adapter *padapter, u8 mode)
 {
-	int	ret = 0;
+	int ret = 0;
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
 	if (mode < PS_MODE_NUM) {
-- 
2.24.0

