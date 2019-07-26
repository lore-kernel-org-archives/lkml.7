Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C6FC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C616218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIRG9la9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfGZSFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:05:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56245 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfGZSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:05:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so48712580wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/Bdj0w4zilE2dn88/OLN2tRAFIDUIOcrXrBB+fYiPw=;
        b=eIRG9la9xvJMshzZRARYU1QuTIXvhA9ClZDTSeW5KHDsOuuxI02w+kY5Qx0ALZGNDP
         nrxGlG9TRwdc0VrMQdAxOOXo5fnEWv60FCq0GOZsTGZPbPgIu91wbc17VzfmUF5p6czw
         cWANupJNRlOAWejQxmHgRnaW6IVT+vc7cajxCOEzjomM+Q1+IRYWOV5ZoX982rTLCF+f
         wImcUPUjhLhOdUFidygHOlufLakF7eP0891qfdXHGtJznP/YqBa1iSV+WzQc1xXT3qGW
         H+VmTPQK3Q2EADe3ChOifPX70Kwb8eAMYr4QpZpnNra3ywo2KoIyfyIzM8WiONttFhTL
         ScIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/Bdj0w4zilE2dn88/OLN2tRAFIDUIOcrXrBB+fYiPw=;
        b=TUvZGyu8t9TVtV5+f1UdmMV01Xu5cDDp0mf0cMt98gsaXiRF2iajOjKxeG6HrDA97O
         au6iu4c2eNa+eurJHVM0+xyPlOvHha4j08Nf5BGYeJLMPM/irpx49kbAGSG9oLATnk6x
         TpDgzMX4NnyNh21s8TfhZjwSP+Of3YW/hJlAOmT58/VKHtdTs/1HQcqC2HWeRNMZZOFP
         /BtUfS66zkjLZXhTrdmW1Lcyz+npYMrq6bTJCJJlmonjrQlVquNO93nABbfuu2Z+8OHE
         V7r/QJ0LWl4m0McwgE/4qcBfuCZ1+oTCDrjxEI8pYM/Ztb4gbNEgLlU27zbABjOebhVv
         VDrA==
X-Gm-Message-State: APjAAAX7DK68nQsfJsrv5FQ+LKe2GS3zJ/7orHc1ub3jyDVg+K59RQmO
        2OvS+oTCBDioEW8DAJor3lw=
X-Google-Smtp-Source: APXvYqyfSP9HphmkChAzSqY7yd6VArjniOZ/FPKkZFq6rexTp4zpejIIp95+4G7/rRVAsg9tylPwDg==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr80142442wmk.136.1564164303026;
        Fri, 26 Jul 2019 11:05:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id p14sm43535931wrx.17.2019.07.26.11.05.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 11:05:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: rtl8188eu: add spaces around '<<' and '>>' in usb_halinit.c
Date:   Fri, 26 Jul 2019 20:04:46 +0200
Message-Id: <20190726180448.2290-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726180448.2290-1-straube.linux@gmail.com>
References: <20190726180448.2290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '<<' and '>>' to improve readability and follow
kernel coding style. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 9fa34c5c11c4..40162f111195 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -923,7 +923,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	usb_write8(Adapter, GPIO_IO_SEL, 0xFF);/* Reg0x46 */
 
 	val8 = usb_read8(Adapter, REG_GPIO_IO_SEL);
-	usb_write8(Adapter, REG_GPIO_IO_SEL, (val8<<4));
+	usb_write8(Adapter, REG_GPIO_IO_SEL, (val8 << 4));
 	val8 = usb_read8(Adapter, REG_GPIO_IO_SEL + 1);
 	usb_write8(Adapter, REG_GPIO_IO_SEL + 1, val8 | 0x0F);/* Reg0x43 */
 	usb_write32(Adapter, REG_BB_PAD_CTRL, 0x00080808);/* set LNA ,TRSW,EX_PA Pin to output mode */
@@ -1307,7 +1307,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) & (~BIT(3)));
 
 			usb_write32(Adapter, REG_TSFTR, tsf);
-			usb_write32(Adapter, REG_TSFTR + 4, tsf>>32);
+			usb_write32(Adapter, REG_TSFTR + 4, tsf >> 32);
 
 			/* enable related TSF function */
 			usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) | BIT(3));
@@ -1442,7 +1442,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			u8 regTmp;
 			u8 bShortPreamble = *((bool *)val);
 			/*  Joseph marked out for Netgear 3500 TKIP channel 7 issue.(Temporarily) */
-			regTmp = (haldata->nCur40MhzPrimeSC)<<5;
+			regTmp = (haldata->nCur40MhzPrimeSC) << 5;
 			if (bShortPreamble)
 				regTmp |= 0x80;
 
@@ -1480,7 +1480,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			for (i = 0; i < CAM_CONTENT_COUNT; i++) {
 				/*  filled id in CAM config 2 byte */
 				if (i == 0)
-					ulContent |= (ucIndex & 0x03) | ((u16)(ulEncAlgo)<<2);
+					ulContent |= (ucIndex & 0x03) | ((u16)(ulEncAlgo) << 2);
 				else
 					ulContent = 0;
 				/*  polling bit, and No Write enable, and address */
@@ -1590,8 +1590,8 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 					FactorToSet = 0xf;
 
 				for (index = 0; index < 4; index++) {
-					if ((pRegToSet[index] & 0xf0) > (FactorToSet<<4))
-						pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet<<4);
+					if ((pRegToSet[index] & 0xf0) > (FactorToSet << 4))
+						pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet << 4);
 
 					if ((pRegToSet[index] & 0x0f) > FactorToSet)
 						pRegToSet[index] = (pRegToSet[index] & 0xf0) | (FactorToSet);
-- 
2.22.0

