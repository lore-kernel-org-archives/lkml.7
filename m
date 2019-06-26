Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E832C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04C321670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHHv5soN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFZRpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:45:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37086 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:45:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so1736669pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2Op3n5iEsvujbWLuRbwUwnaBtFtleYDkesVFXREb9Vo=;
        b=VHHv5soNPZ1wTs+oB5lvnI+GJuZqal0ynwkBCxaFyga1OO+eyxT9pbASC8Nv1TpLtN
         atuN/ZHup1I27DxYX6GqfFjD6LD9/uLHY2rDJ1dMqZmlI/hGCwfB9x/g+A1p2EQjTLQ5
         zewrkWn7u8Vq7fWl8HQQ/CDBAwfC4MlSMrwXfN8n95bffLMoFWIKYhdKXRvJ9REbf5Fi
         36nxophXkAtsWnSHtxkGOG5vKGtiZNZl/IA9P9nBMp5qKQv6BOnKFYoI3EQsP2nZliWT
         Ojk5GSSRod3hpiiLC6tHPReDBdwtpRpXiU/ONFuc07I6v6Aq5s9IfFRiyZzYALeC5j/0
         vWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2Op3n5iEsvujbWLuRbwUwnaBtFtleYDkesVFXREb9Vo=;
        b=UZcdZ6f32GQV3ZiZmmt6iaPQGujWMn5y20lsOv7l6tPP32ZPsS1RFz9qlNlCnTgX6P
         4HaZQjdFDyHml8pLIyzsTuGk6/7QDmshgF3Cf+kn68vJxqdQBL0cTW/oJOwG8uRJDpHh
         Ye0IA6e4xc/k2kYuSb6Sy2vp8Cf3OdvCw9m4KjqzpTPpf5EtwmmJGeTU40yJy/4EyN78
         mf56YPADtVFcBqongYNfHWm0POwTU2XEFyFxakGRAydBbR7lA+dRFCX1zHTCNHzzian4
         HLsxYuZDP5EPT1uzuQkwYdAA+WVvtPHchkSKtNqQDdDhC5+2RMV8GXFOBo8ZXSN5O85J
         bIKQ==
X-Gm-Message-State: APjAAAWjefOe4SVFHeawHoVjFzWFsmwaqWQ8p1FKjvkmLi24cMrWem2U
        tu4fO9GyyAZBNdBx8IXe06Y=
X-Google-Smtp-Source: APXvYqyZy1CyONKS9fNZyPke/BiVRAq19Tnbv8CiP7+babcRcF4BXPN+ELCU3q2aDNXVzS4h5fsTww==
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr263362pje.129.1561571103465;
        Wed, 26 Jun 2019 10:45:03 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id w22sm19712088pfi.175.2019.06.26.10.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 10:45:03 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:14:59 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: sdio_halinit: Remove set but unused
 varilable pHalData
Message-ID: <20190626174459.GA8539@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unsed variable pHalData in below functions

_InitOperationMode
SetHwReg8723BS

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 4d06ab7..9e8bbee 100644
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
@@ -1433,7 +1430,6 @@ static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 #endif
 #endif
 
-	pHalData = GET_HAL_DATA(padapter);
 
 	switch (variable) {
 	case HW_VAR_SET_RPWM:
-- 
2.7.4

