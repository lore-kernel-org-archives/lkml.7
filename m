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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1504C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B245221842
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNvX7BbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfGZSFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:05:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56244 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfGZSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:05:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so48712549wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30KR1z382qjHLHiyLHKr/LrLJjSnHNnO4pqNGLXSJsY=;
        b=nNvX7BbWYrKqfPuSYEwqJaDquN5OEfPSCQP6pDFUprJ1j35DRpmswzy8BwLWRgisDM
         teNkwR4CWoPrL2LLUEStStJZVdoV9WlZTQTYiIyAKsviQy7ZVWmwMV7u8iiSHCh1ytmi
         RGDpYnNoY3HYwtOXOTXgTCJ0YIslrSG66jzzc67gx8YDTx0Fsjr+TRJ6dqdBV+kBERjZ
         ipTVAWKiz8lz0Fux7W271EwHr1JGonCv7120pnM1NuNA5mRehmW1dpM2QVL85L8HWSo7
         AAQbxATp0nClJ+jYHkoyNzro0shNwAtd0khT2fI3rlu1lEHB3f0g+qTEPHJnH1rlTyNV
         Gtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30KR1z382qjHLHiyLHKr/LrLJjSnHNnO4pqNGLXSJsY=;
        b=VFpvivqyomyU4gCFYeDUD3PNgXAzDF6R1cxvIwefGvEDPa22quqfFFLkk8qju1X6uQ
         p7cR7LcvpoxcIByKQj7Rugl8tHhd9P7ZvHxwWyctWktZUjRx94OthRUXKTehxIySK9+U
         lnz7d2B9Mfd7kM2Jx32+Tmru5x1QP2auHEEUzmmjh11yaN8w5lENzzZwvH0wr5NqwJGa
         badveIensB2b7dpu0eekqIsyTJJ4N0KrWxTmToQU0Bavuh+TFf9pT2SJjJ4XsAjZDh8H
         Uj8zTVzMezRdEUtrUM8eufctfjf2OK+GmdQt2NT+5FTZgYYVDodb+McTObHWoDt0SNGO
         XnpA==
X-Gm-Message-State: APjAAAXx6eRHXgY43ynm5pAml80+z1Sl8xmRBZ/S/DpHROgC5e2bW4F+
        O2wzqMc7WbGA56PzuC09i99R5Cx1
X-Google-Smtp-Source: APXvYqz72dbiJe8NZIJ8Yseq5IRJmsmDu1Py26xhiCbx6yz1jDsZ8FduGuTBp/IuD+5/CSxzq3lpXw==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr89687542wmi.78.1564164302220;
        Fri, 26 Jul 2019 11:05:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id p14sm43535931wrx.17.2019.07.26.11.05.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 11:05:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: rtl8188eu: add spaces around '|' in usb_halinit.c
Date:   Fri, 26 Jul 2019 20:04:45 +0200
Message-Id: <20190726180448.2290-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726180448.2290-1-straube.linux@gmail.com>
References: <20190726180448.2290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '|' to improve readability and follow kernel
coding style. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index fe68af7eaf85..9fa34c5c11c4 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -925,7 +925,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	val8 = usb_read8(Adapter, REG_GPIO_IO_SEL);
 	usb_write8(Adapter, REG_GPIO_IO_SEL, (val8<<4));
 	val8 = usb_read8(Adapter, REG_GPIO_IO_SEL + 1);
-	usb_write8(Adapter, REG_GPIO_IO_SEL + 1, val8|0x0F);/* Reg0x43 */
+	usb_write8(Adapter, REG_GPIO_IO_SEL + 1, val8 | 0x0F);/* Reg0x43 */
 	usb_write32(Adapter, REG_BB_PAD_CTRL, 0x00080808);/* set LNA ,TRSW,EX_PA Pin to output mode */
 	Adapter->HalData->bMacPwrCtrlOn = false;
 	Adapter->bFWReady = false;
@@ -1176,7 +1176,7 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 
 		/* enable BCN0 Function for if1 */
 		/* don't enable update TSF0 for if1 (due to TSF update when beacon/probe rsp are received) */
-		usb_write8(Adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP|EN_BCN_FUNCTION | BIT(1)));
+		usb_write8(Adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP | EN_BCN_FUNCTION | BIT(1)));
 
 		/* dis BCN1 ATIM  WND if if2 is station */
 		usb_write8(Adapter, REG_BCN_CTRL_1, usb_read8(Adapter, REG_BCN_CTRL_1) | BIT(0));
@@ -1318,7 +1318,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_CHECK_BSSID:
 		if (*((u8 *)val)) {
-			usb_write32(Adapter, REG_RCR, usb_read32(Adapter, REG_RCR)|RCR_CBSSID_DATA|RCR_CBSSID_BCN);
+			usb_write32(Adapter, REG_RCR, usb_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 		} else {
 			u32 val32;
 
@@ -1369,7 +1369,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 				usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
 			}
 
-			usb_write32(Adapter, REG_RCR, usb_read32(Adapter, REG_RCR)|RCR_CBSSID_BCN);
+			usb_write32(Adapter, REG_RCR, usb_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
 		}
 		break;
 	case HW_VAR_MLME_JOIN:
@@ -1382,7 +1382,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 				/* enable to rx data frame.Accept all data frame */
 				usb_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 
-				usb_write32(Adapter, REG_RCR, usb_read32(Adapter, REG_RCR)|RCR_CBSSID_DATA|RCR_CBSSID_BCN);
+				usb_write32(Adapter, REG_RCR, usb_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 
 				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 					RetryLimit = (haldata->CustomerID == RT_CID_CCX) ? 7 : 48;
@@ -1396,7 +1396,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 				/* enable update TSF */
 				usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
 
-				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE))
+				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))
 					RetryLimit = 0x7;
 			}
 			usb_write16(Adapter, REG_RL, RetryLimit << RETRY_LIMIT_SHORT_SHIFT | RetryLimit << RETRY_LIMIT_LONG_SHIFT);
@@ -1485,7 +1485,8 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 					ulContent = 0;
 				/*  polling bit, and No Write enable, and address */
 				ulCommand = CAM_CONTENT_COUNT*ucIndex + i;
-				ulCommand = ulCommand | CAM_POLLINIG|CAM_WRITE;
+				ulCommand = ulCommand | CAM_POLLINIG |
+					    CAM_WRITE;
 				/*  write content 0 is equall to mark invalid */
 				usb_write32(Adapter, WCAMI, ulContent);  /* delay_ms(40); */
 				usb_write32(Adapter, RWCAM, ulCommand);  /* delay_ms(40); */
@@ -1681,7 +1682,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 
 			if (!pwrpriv->bkeepfwalive) {
 				/* RX DMA stop */
-				usb_write32(Adapter, REG_RXPKT_NUM, (usb_read32(Adapter, REG_RXPKT_NUM)|RW_RELEASE_EN));
+				usb_write32(Adapter, REG_RXPKT_NUM, (usb_read32(Adapter, REG_RXPKT_NUM) | RW_RELEASE_EN));
 				do {
 					if (!(usb_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
 						break;
-- 
2.22.0

