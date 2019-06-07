Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C59AC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F922089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqM8TSqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfFGHYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:24:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33724 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFGHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:24:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id k187so197258pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXL/TO2ISYq8/butiqBjWgvY1wAMvzv3j7pmifqx/0U=;
        b=XqM8TSqQO2SWcPDZbf2pP51yoc8emUS7eL+s0yqXWjsY/IZUYPqZfc6ciu4i+DYIi0
         CNhoBxyX1rnE2GmUgeBZWdnohN/g/Oum/EFMv1jFSvqUdQ0Y1NXm8BGaIzAN+ZWs1rQb
         1ybw1eLPgGegVYSRZRQC/Db8WKtVZ0tzcAm7X7Fucaljp9H+xVp90WX+Q2oRMVS8kLq0
         PzDHRnI/eXFXd1QK9FQhVvGDlkOY33wiMCc3nkd5ItO8s+0Jh1GEMcV7o34ddhDA40Tz
         e1q8bs+r+4ZZjQPvqrM3Ff8ox8G++zzDjZ8+0mmh3IFqN4mnLydhbW4soibsA1SygsPJ
         myNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXL/TO2ISYq8/butiqBjWgvY1wAMvzv3j7pmifqx/0U=;
        b=Uv3Y5Z6s1NrXOHlVvUyd8Y/0U6gkBeIuOIumAuuipnNghXgrsgxqLDtZ72OxYSh5lr
         RzVvsCxs+3XrTryK7Kr4Aq+E8ZzHPf1vzYiah1TtYGppggOv6eTABFMI2eAc9aCGetdt
         gOE67+D9LxziIrrXTb9F9N/kYng5iiUkxfu2JNfOSo65+Y+mL3O6FWsNCxt7p62uqDdA
         cPTKXGjXDKqLM48CWdGLE4dgZwygtLxFdbArVuuCMZDfAC6/XXTzXcFEm5apogT62o3V
         iZAaF3MGFiBMgwosw61DZVIDQuZcI6HKz5VeezFlabtrAONFS93lsJir4JD0BrQPrMtf
         Umdw==
X-Gm-Message-State: APjAAAVG2lqnE6ZNT68dT5p6JrHf7psV0rtNfJ8ppMQGB3SGcoDJ9jNq
        HmXgjibAwxS5s4MF0LAEPXqbcHec
X-Google-Smtp-Source: APXvYqzp+jvAINFmyLt21EKAT/UJtK1F+tydde9f1RAarxBgk49baJ71b+AXQ9isNd0igYMhVZ791w==
X-Received: by 2002:a62:a509:: with SMTP id v9mr55646875pfm.82.1559892249125;
        Fri, 07 Jun 2019 00:24:09 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id t7sm1032435pjq.20.2019.06.07.00.24.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:24:08 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: hal: sdio_halinit.c: Remove variables
Date:   Fri,  7 Jun 2019 12:53:57 +0530
Message-Id: <20190607072357.28551-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the variables RegRATR and RegRRSR as they are never used after
initialisation and assignment.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 3c65a9c02bbd..55d21aa52e62 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -614,7 +614,6 @@ static void _InitOperationMode(struct adapter *padapter)
 	struct hal_com_data *pHalData;
 	struct mlme_ext_priv *pmlmeext;
 	u8 regBwOpMode = 0;
-	u32 regRATR = 0, regRRSR = 0;
 
 	pHalData = GET_HAL_DATA(padapter);
 	pmlmeext = &padapter->mlmeextpriv;
@@ -626,34 +625,24 @@ static void _InitOperationMode(struct adapter *padapter)
 	switch (pmlmeext->cur_wireless_mode) {
 	case WIRELESS_MODE_B:
 		regBwOpMode = BW_OPMODE_20MHZ;
-		regRATR = RATE_ALL_CCK;
-		regRRSR = RATE_ALL_CCK;
 		break;
 	case WIRELESS_MODE_A:
 /* 			RT_ASSERT(false, ("Error wireless a mode\n")); */
 		break;
 	case WIRELESS_MODE_G:
 		regBwOpMode = BW_OPMODE_20MHZ;
-		regRATR = RATE_ALL_CCK | RATE_ALL_OFDM_AG;
-		regRRSR = RATE_ALL_CCK | RATE_ALL_OFDM_AG;
 		break;
 	case WIRELESS_MODE_AUTO:
 		regBwOpMode = BW_OPMODE_20MHZ;
-		regRATR = RATE_ALL_CCK | RATE_ALL_OFDM_AG | RATE_ALL_OFDM_1SS | RATE_ALL_OFDM_2SS;
-		regRRSR = RATE_ALL_CCK | RATE_ALL_OFDM_AG;
 		break;
 	case WIRELESS_MODE_N_24G:
 		/*  It support CCK rate by default. */
 		/*  CCK rate will be filtered out only when associated AP does not support it. */
 		regBwOpMode = BW_OPMODE_20MHZ;
-		regRATR = RATE_ALL_CCK | RATE_ALL_OFDM_AG | RATE_ALL_OFDM_1SS | RATE_ALL_OFDM_2SS;
-		regRRSR = RATE_ALL_CCK | RATE_ALL_OFDM_AG;
 		break;
 	case WIRELESS_MODE_N_5G:
 /* 			RT_ASSERT(false, ("Error wireless mode")); */
 		regBwOpMode = BW_OPMODE_5G;
-		regRATR = RATE_ALL_OFDM_AG | RATE_ALL_OFDM_1SS | RATE_ALL_OFDM_2SS;
-		regRRSR = RATE_ALL_OFDM_AG;
 		break;
 
 	default: /* for MacOSX compiler warning. */
-- 
2.19.1

