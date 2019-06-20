Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C066AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917932177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7xnBGcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbfFTC1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:27:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47076 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTC1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:27:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so701852pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 19:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rZe0jF1fnIyGnpK652ETkNOA+XkaYNF8CGCQ/FTB5oc=;
        b=O7xnBGcEjc+6HH9FPNRtdKx7U6xpjrgMFnsvTc1id4kCZt6Tdakw3afMiCRoGQ8T76
         HwaIAqNap8G42JmxPCjEWZMkl5dI9TLfvF7oq/gMZpYbEUZ70h0OvOREWZ2skn3uEivp
         BgqGQUhlmKRqeP6dUMPwJXsIonQYHXK/HW+GkGTqL2ZookJlYmxeWxrjzMBdWUVoLdxa
         WtwQBnSWqIWqPa0eIx12RLE2ANaxvFiAy0Gc7We5ixKqnbppoaagD0GUjmh8OB/37Gb+
         m3bm8B6epxzr+EGyPuVn3FUjNI/1MU6usEcP8PzVOQQSAw2+4Od+kP2AwgV3dIN4QvQa
         FS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rZe0jF1fnIyGnpK652ETkNOA+XkaYNF8CGCQ/FTB5oc=;
        b=DpdjWqM4vlCg6lcQ5wawoZxrQhIm2iGWj18QR64mXEAGVGER2+XZUH7FerQ5+HuPn/
         ZggCJpVVnDiPuD2FSMAj6SBc7hYduUfhSaqCj75ydkDRQnrkiI6Hq+eZYL5zgsurqvQ3
         amlobi2jdw2JP7GH7ce/Ugr4svlWNMYE4Z4moKcALacayoWI9gXKXwHNGkwzOSKJ4f1f
         UsI0egaryoC5xShMvv+iIjTOLPluUdYomf7fkurZ3yI9mhVa3a4q5GLtN2T/NjtZU0xc
         RHYk6VHncFToXo6LDJYA+tm0T6IEgSt7agucu6CTPgbtYdt3NGFU4AclH8vaRiMQm6ws
         MzFg==
X-Gm-Message-State: APjAAAV7onhLf/317phDLlEMC1k4Q1poiG794JW/5akVttpYkwB2zBPr
        grvu+NYkxLoSXad9+esndI4=
X-Google-Smtp-Source: APXvYqwdAtGhD5XNJZSHPBwAYoQpJBoDZXZhetbZbQvr4LcPPT8qyQDrJZfAyLiJLcX0ILcYbSi3pw==
X-Received: by 2002:a17:902:e58b:: with SMTP id cl11mr100882004plb.24.1560997653013;
        Wed, 19 Jun 2019 19:27:33 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id j23sm19200394pff.90.2019.06.19.19.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 19:27:31 -0700 (PDT)
Date:   Thu, 20 Jun 2019 07:57:26 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: hal_btcoex: Remove variables
 pHalData and pU1Tmp
Message-ID: <20190620022726.GA19556@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pHalData variable as it is set but unused in function.
Remove pU1Tmp and replace this with pu8

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index fd0be52..e673319 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -560,18 +560,14 @@ static u8 halbtcoutsrc_Set(void *pBtcContext, u8 setType, void *pInBuf)
 {
 	PBTC_COEXIST pBtCoexist;
 	struct adapter *padapter;
-	struct hal_com_data *pHalData;
 	u8 *pu8;
-	u8 *pU1Tmp;
 	u32 *pU4Tmp;
 	u8 ret;
 
 
 	pBtCoexist = (PBTC_COEXIST)pBtcContext;
 	padapter = pBtCoexist->Adapter;
-	pHalData = GET_HAL_DATA(padapter);
 	pu8 = pInBuf;
-	pU1Tmp = pInBuf;
 	pU4Tmp = pInBuf;
 	ret = true;
 
@@ -614,11 +610,11 @@ static u8 halbtcoutsrc_Set(void *pBtcContext, u8 setType, void *pInBuf)
 
 	/*  set some u8 type variables. */
 	case BTC_SET_U1_RSSI_ADJ_VAL_FOR_AGC_TABLE_ON:
-		pBtCoexist->btInfo.rssiAdjustForAgcTableOn = *pU1Tmp;
+		pBtCoexist->btInfo.rssiAdjustForAgcTableOn = *pu8;
 		break;
 
 	case BTC_SET_U1_AGG_BUF_SIZE:
-		pBtCoexist->btInfo.aggBufSize = *pU1Tmp;
+		pBtCoexist->btInfo.aggBufSize = *pu8;
 		break;
 
 	/*  the following are some action which will be triggered */
@@ -633,15 +629,15 @@ static u8 halbtcoutsrc_Set(void *pBtcContext, u8 setType, void *pInBuf)
 	/* 1Ant =========== */
 	/*  set some u8 type variables. */
 	case BTC_SET_U1_RSSI_ADJ_VAL_FOR_1ANT_COEX_TYPE:
-		pBtCoexist->btInfo.rssiAdjustFor1AntCoexType = *pU1Tmp;
+		pBtCoexist->btInfo.rssiAdjustFor1AntCoexType = *pu8;
 		break;
 
 	case BTC_SET_U1_LPS_VAL:
-		pBtCoexist->btInfo.lpsVal = *pU1Tmp;
+		pBtCoexist->btInfo.lpsVal = *pu8;
 		break;
 
 	case BTC_SET_U1_RPWM_VAL:
-		pBtCoexist->btInfo.rpwmVal = *pU1Tmp;
+		pBtCoexist->btInfo.rpwmVal = *pu8;
 		break;
 
 	/*  the following are some action which will be triggered */
-- 
2.7.4

