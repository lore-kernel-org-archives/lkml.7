Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331AEC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038A620656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fajK3tVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfF0SDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:03:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40140 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF0SDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:03:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so1367194pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1mhPYTvcTMkLr+r7i1/bipLacTCuZ27SECVhqtgV4Ww=;
        b=fajK3tVfVu0hc2KnwP+O/QcY4Esv2sFB6mxeSNSyrq1qttpTpId4y06ovuQhh1c8Ek
         vaoUQeJzAcss7zi7buBf6vBH87225tPeYsOTq66E1iGyM6LQLKfcsCEmWRuU3nYHMydO
         Y6ogyZtXa4D1dMoDU+WBwRkjXAmwD3jTIWDdtlkWiBllJxxWe4sLLXrHiKJJ8piel4oN
         0TZKzPdrr21D84oo1SGZNAxz4TWDRK36DBKi4XfRE5Jwob+0y9vRIew6xpNQunVjnr/A
         RNki7tINVGnT3su0GXUs+gmUF9FvKiK1qXEedpGoY0ieaEPZdm7I6yoXJP2d4HWtJahz
         z+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1mhPYTvcTMkLr+r7i1/bipLacTCuZ27SECVhqtgV4Ww=;
        b=KSlby0Fm3llPS3UIPk2VOKBrGGUkPIzqBn4/OTPWin57mWKZZd/QRncWPI2ADWVuZe
         bCU36qKeOLUDeaVYixVpp2kcJxWTiFyHtG2mGOU/RnjkmrXfTNUQSpSceg3C6gX8jnG/
         vI6zdjhvzf2cv02m65/2W5d05X8UF9Jn7YtMof8NaXbCGbgX74qvd2dDR1sA+66dY+UE
         ngTZ/vFWP79Ewus49CPwIkf33cDoAkKa7rPbm19QqpKjZn+QqFyGjn8gnjzbRBeTY+5y
         NbsWPoKpjaVhhqTXm+S4A4HtEHMD8/AtTEGK3gEKfL9p6wP/0x56ybfOaG4Ar+e9JL67
         Fs/A==
X-Gm-Message-State: APjAAAVWTsCyFr97zCBMKdklUXgPgn3Yv/FW+ie34wxJu1bksIgTk3LR
        JPYWJTyKwAwRyStYhW80BeQ=
X-Google-Smtp-Source: APXvYqwkmG4Fnb/yeONev9B1/STo5fOP7Mn3YGfEssUkBeNvLaiz9N1RzrSaJixFX2ShvAT0E5/Jpw==
X-Received: by 2002:a63:4e58:: with SMTP id o24mr4861689pgl.366.1561658587793;
        Thu, 27 Jun 2019 11:03:07 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id l1sm2548655pgi.91.2019.06.27.11.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 11:03:06 -0700 (PDT)
Date:   Thu, 27 Jun 2019 23:33:02 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: rtl8723bs: hal: sdio_halinit: Remove set but
 unused varilable pHalData
Message-ID: <20190627180302.GA3186@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unsed variable pHalData in below functions
_InitOperationMode, SetHwReg8723BS.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 4d06ab7..5b72d61 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -606,11 +606,9 @@ static void _initSdioAggregationSetting(struct adapter *padapter)
 
 static void _InitOperationMode(struct adapter *padapter)
 {
-	struct hal_com_data *pHalData;
 	struct mlme_ext_priv *pmlmeext;
 	u8 regBwOpMode = 0;
 
-	pHalData = GET_HAL_DATA(padapter);
 	pmlmeext = &padapter->mlmeextpriv;
 
 	/* 1 This part need to modified according to the rate set we filtered!! */
@@ -1413,7 +1411,6 @@ static void ReadAdapterInfo8723BS(struct adapter *padapter)
  */
 static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 {
-	struct hal_com_data *pHalData;
 	u8 val8;
 
 #if defined(CONFIG_WOWLAN) || defined(CONFIG_AP_WOWLAN)
@@ -1433,8 +1430,6 @@ static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 #endif
 #endif
 
-	pHalData = GET_HAL_DATA(padapter);
-
 	switch (variable) {
 	case HW_VAR_SET_RPWM:
 		/*  rpwm value only use BIT0(clock bit) , BIT6(Ack bit), and BIT7(Toggle bit) */
-- 
2.7.4

