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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0DC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7712086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF0VaPfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfF2KYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:24:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40412 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2KYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:24:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so4204201pfp.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RptfxyB7O7iR3X6CW3MwQJ/ahOEa3Z1ayV5mK7lrjQk=;
        b=fF0VaPfIGIcDL/ZgcVy2LKBto6YZEi5UuSXzCBZbCzBs0paO1D5hprlcQLqntKmavh
         5i8RhZYkzuZF2ZDNGXXcc0HVHIz4p/k7ANCxlMUq6PtMB4R/oSCVzZ25vqpcZSyM0Is7
         68HJTCEet/aJjlXM+5jUzXgBHrtSZh0YbXMTFy0MpzEgFyOp6QHKE/28o2wAgBiznUGO
         gS4ZRwnw5bLr8GCFBfZB7OqhkIChbXjKz5Aqp75kxPCz/mhWw+58huGoHiwqhlEEc9HI
         RZ8G7EyrOGatRX6kfuCtAtHPJKn/KOrKWJfGIjle9kfJNFeFKP+6Dnh/8TpoJwTLUQ3I
         UCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RptfxyB7O7iR3X6CW3MwQJ/ahOEa3Z1ayV5mK7lrjQk=;
        b=FoVMRiOv7AgRtdsCicPv4xeDr9++I3DP7a/esgcXYbeMkretZSAkKoeqWxYCYOHkBR
         rdB5157RNXgdevCBQV8Unx3PpWNKbKb+MHsbRI+cDafuQcSNjvXHZoVn60fRRgyGG6ch
         sK/Dvbb0+ZsKFDtWM1X6mHs76nd/Jtm6KMpypHk0wIeDstP1PJ6ao5w7nH4bO/xdc5SI
         Dduf7yhSCpWI8rJyG+Znj95J7aar3KiTSO2wGJbEVpukT6TVY979VJDFes8qc+87hqcT
         PZa5E3IsZ5izHvlJ0O4Bh4XkGYrEKSgLWf+BqqNEcXCMRg7OK6fdpzfcY2IuUU4vi2CY
         toIw==
X-Gm-Message-State: APjAAAXCqpDaPEYUvxcCg5WlQTjD9CtukvWYqXhHwoPRj4L5KWVAngZx
        3OH2YQHbpi0NSoQ7sliZOws=
X-Google-Smtp-Source: APXvYqz15+NrOPPHfwMmYvQZdC4xMg7YmZgaWZl9Z+Vggiiqms6QByTgmHK7ZFXnpmDo2Hwy4M1TPQ==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr8952131pjo.47.1561803851887;
        Sat, 29 Jun 2019 03:24:11 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id m101sm4234630pjb.7.2019.06.29.03.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:24:11 -0700 (PDT)
Date:   Sat, 29 Jun 2019 15:54:07 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629102407.GA15143@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_DIG.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index 70d98c5..dbfb05e 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -95,7 +95,7 @@ void odm_NHMBB(void *pDM_VOID)
 
 
 	if ((pDM_Odm->NHMCurTxOkcnt) + 1 > (u64)(pDM_Odm->NHMCurRxOkcnt<<2) + 1) { /* Tx > 4*Rx possible for adaptivity test */
-		if (pDM_Odm->NHM_cnt_0 >= 190 || pDM_Odm->adaptivity_flag == true) {
+		if (pDM_Odm->NHM_cnt_0 >= 190 || pDM_Odm->adaptivity_flag) {
 			/* Enable EDCCA since it is possible running Adaptivity testing */
 			/* test_status = 1; */
 			pDM_Odm->adaptivity_flag = true;
@@ -112,7 +112,7 @@ void odm_NHMBB(void *pDM_VOID)
 			}
 		}
 	} else { /*  TX<RX */
-		if (pDM_Odm->adaptivity_flag == true && pDM_Odm->NHM_cnt_0 <= 200) {
+		if (pDM_Odm->adaptivity_flag && pDM_Odm->NHM_cnt_0 <= 200) {
 			/* test_status = 2; */
 			pDM_Odm->tolerance_cnt = 0;
 		} else {
@@ -207,7 +207,7 @@ void odm_AdaptivityInit(void *pDM_VOID)
 {
 	PDM_ODM_T pDM_Odm = (PDM_ODM_T)pDM_VOID;
 
-	if (pDM_Odm->Carrier_Sense_enable == false)
+	if (!pDM_Odm->Carrier_Sense_enable)
 		pDM_Odm->TH_L2H_ini = 0xf7; /*  -7 */
 	else
 		pDM_Odm->TH_L2H_ini = 0xa;
@@ -257,7 +257,7 @@ void odm_Adaptivity(void *pDM_VOID, u8 IGI)
 	pDM_Odm->IGI_target = (u8) IGI_target;
 
 	/* Search pwdB lower bound */
-	if (pDM_Odm->TxHangFlg == true) {
+	if (pDM_Odm->TxHangFlg) {
 		PHY_SetBBReg(pDM_Odm->Adapter, ODM_REG_DBG_RPT_11N, bMaskDWord, 0x208);
 		odm_SearchPwdBLowerBound(pDM_Odm, pDM_Odm->IGI_target);
 	}
@@ -456,7 +456,7 @@ bool odm_DigAbort(void *pDM_VOID)
 	}
 
 	/* add by Neil Chen to avoid PSD is processing */
-	if (pDM_Odm->bDMInitialGainEnable == false) {
+	if (!pDM_Odm->bDMInitialGainEnable) {
 		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Return: PSD is Processing\n"));
 		return	true;
 	}
@@ -525,7 +525,7 @@ void odm_DIG(void *pDM_VOID)
 
 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG() ===========================>\n\n"));
 
-	if (pDM_Odm->adaptivity_flag == true)
+	if (pDM_Odm->adaptivity_flag)
 		Adap_IGI_Upper = pDM_Odm->Adaptivity_IGI_upper;
 
 
-- 
2.7.4

