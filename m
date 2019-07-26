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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421CEC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D4321842
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpC6t+2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfGZSFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:05:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfGZSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:05:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so55339941wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbOUkpeoSDL4iey+UNsUnkFzPleqBP86i8D6OzuyNFo=;
        b=XpC6t+2PUtucF4esx4lgoI9BJQ/Hv8WjmsZjVpOhb04Km4KVb/5bhhQCe4AgpUaxtG
         iyrEDJQRKkNRtAVSaq3VNpvbe2Aj4yo4Il6YHne1dJPBE2LuQy3qzdUnIqz+2JyTmAr5
         +1yRf1GLmOHoVRHw8DNylfInDonwBw95bkpGB8+i1TOJ2t5fc+4v7KG/8D/iiwzmFIwI
         SYS/rKTTnsmQRN7pd2b0C11SCQKC9t/sW8rYQr3NrIPLTmXInyEH1fqGbY/UdbpVDIAn
         SAS+RQqMMxHo0wK9ksxk4CX4Yi2wUb24LF0i6TUkfop/gBsquNa5gpvxmQ+XjvEYAw7S
         vl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbOUkpeoSDL4iey+UNsUnkFzPleqBP86i8D6OzuyNFo=;
        b=QiwWLWub6vzR7HPm16U6msiiK/xhTTkBtLQtgXFtuHN/YRlj21QAVMXtfGTjKNrZnN
         VFCNZpsvsJov7M4pQNLoiHDGdoRWUBpBe3NSWvhsI4RdQ7pWTfMT5cHgdI0aQpcEAuQO
         5MgHR5Fgb8it20Uz7ff3SOfvPnlLdnsEceuwuyXXi4KviWpXB/dvtAGlxukJh7N/0ZKP
         WbnRqx0DkOJ9hQUJARicgeCPpsqhGwrV5w+PNGDHBFHL3rXL9VO4p/8Ixi44N8wn9ltU
         BD0FVKurKAJ5SNeBefA0/CWsirrShaa+P5IP1ivM4/vjiHJDUFhzzdwXcUNaAOxrxu+s
         DxkQ==
X-Gm-Message-State: APjAAAXCxQBDGLv04Dpd7T2ttI63/dT554NxtgcsBvdCfa587vxJ/S10
        iTrPlex5KkR8OxvZNuE3TcM=
X-Google-Smtp-Source: APXvYqwp+s64gp12QK+RRiAUcJNNI1+WwL25Eh901vSPtj0nzOs1Q0jeWfYCRoHWj3KW4cZpQ0b0NQ==
X-Received: by 2002:adf:f28a:: with SMTP id k10mr24983166wro.343.1564164300353;
        Fri, 26 Jul 2019 11:05:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id p14sm43535931wrx.17.2019.07.26.11.04.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 11:04:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: rtl8188eu: add spaces around '+' in usb_halinit.c
Date:   Fri, 26 Jul 2019 20:04:43 +0200
Message-Id: <20190726180448.2290-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+' to improve readability and follow kernel
coding style. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 76 ++++++++++-----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 994392ac249b..c2e1b000cf89 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -183,7 +183,7 @@ static void _InitTxBufferBoundary(struct adapter *Adapter, u8 txpktbuf_bndy)
 	usb_write8(Adapter, REG_TXPKTBUF_MGQ_BDNY, txpktbuf_bndy);
 	usb_write8(Adapter, REG_TXPKTBUF_WMAC_LBK_BF_HD, txpktbuf_bndy);
 	usb_write8(Adapter, REG_TRXFF_BNDY, txpktbuf_bndy);
-	usb_write8(Adapter, REG_TDECTRL+1, txpktbuf_bndy);
+	usb_write8(Adapter, REG_TDECTRL + 1, txpktbuf_bndy);
 }
 
 static void _InitPageBoundary(struct adapter *Adapter)
@@ -504,7 +504,7 @@ static void usb_AggSettingRxUpdate(struct adapter *Adapter)
 	switch (haldata->UsbRxAggMode) {
 	case USB_RX_AGG_DMA:
 		usb_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
-		usb_write8(Adapter, REG_RXDMA_AGG_PG_TH+1, haldata->UsbRxAggPageTimeout);
+		usb_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, haldata->UsbRxAggPageTimeout);
 		break;
 	case USB_RX_AGG_USB:
 		usb_write8(Adapter, REG_USB_AGG_TH, haldata->UsbRxAggBlockCount);
@@ -512,7 +512,7 @@ static void usb_AggSettingRxUpdate(struct adapter *Adapter)
 		break;
 	case USB_RX_AGG_MIX:
 		usb_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
-		usb_write8(Adapter, REG_RXDMA_AGG_PG_TH+1, (haldata->UsbRxAggPageTimeout & 0x1F));/* 0x280[12:8] */
+		usb_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, (haldata->UsbRxAggPageTimeout & 0x1F));/* 0x280[12:8] */
 		usb_write8(Adapter, REG_USB_AGG_TH, haldata->UsbRxAggBlockCount);
 		usb_write8(Adapter, REG_USB_AGG_TO, haldata->UsbRxAggBlockTimeout);
 		break;
@@ -569,9 +569,9 @@ static void _InitBeaconParameters(struct adapter *Adapter)
 
 	haldata->RegBcnCtrlVal = usb_read8(Adapter, REG_BCN_CTRL);
 	haldata->RegTxPause = usb_read8(Adapter, REG_TXPAUSE);
-	haldata->RegFwHwTxQCtrl = usb_read8(Adapter, REG_FWHW_TXQ_CTRL+2);
-	haldata->RegReg542 = usb_read8(Adapter, REG_TBTT_PROHIBIT+2);
-	haldata->RegCR_1 = usb_read8(Adapter, REG_CR+1);
+	haldata->RegFwHwTxQCtrl = usb_read8(Adapter, REG_FWHW_TXQ_CTRL + 2);
+	haldata->RegReg542 = usb_read8(Adapter, REG_TBTT_PROHIBIT + 2);
+	haldata->RegCR_1 = usb_read8(Adapter, REG_CR + 1);
 }
 
 static void _BeaconFunctionEnable(struct adapter *Adapter,
@@ -579,7 +579,7 @@ static void _BeaconFunctionEnable(struct adapter *Adapter,
 {
 	usb_write8(Adapter, REG_BCN_CTRL, (BIT(4) | BIT(3) | BIT(1)));
 
-	usb_write8(Adapter, REG_RD_CTRL+1, 0x6F);
+	usb_write8(Adapter, REG_RD_CTRL + 1, 0x6F);
 }
 
 /*  Set CCK and OFDM Block "ON" */
@@ -770,7 +770,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	value8 = usb_read8(Adapter, REG_TX_RPT_CTRL);
 	usb_write8(Adapter,  REG_TX_RPT_CTRL, (value8 | BIT(1) | BIT(0)));
 	/* Set MAX RPT MACID */
-	usb_write8(Adapter,  REG_TX_RPT_CTRL+1, 2);/* FOR sta mode ,0: bc/mc ,1:AP */
+	usb_write8(Adapter,  REG_TX_RPT_CTRL + 1, 2);/* FOR sta mode ,0: bc/mc ,1:AP */
 	/* Tx RPT Timer. Unit: 32us */
 	usb_write16(Adapter, REG_TX_RPT_TIME, 0xCdf0);
 
@@ -827,10 +827,10 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	pwrctrlpriv->rf_pwrstate = rf_on;
 
 	/*  enable Tx report. */
-	usb_write8(Adapter,  REG_FWHW_TXQ_CTRL+1, 0x0F);
+	usb_write8(Adapter,  REG_FWHW_TXQ_CTRL + 1, 0x0F);
 
 	/*  Suggested by SD1 pisa. Added by tynli. 2011.10.21. */
-	usb_write8(Adapter, REG_EARLY_MODE_CONTROL+3, 0x01);/* Pretx_en, for WEP/TKIP SEC */
+	usb_write8(Adapter, REG_EARLY_MODE_CONTROL + 3, 0x01);/* Pretx_en, for WEP/TKIP SEC */
 
 	/* tynli_test_tx_report. */
 	usb_write16(Adapter, REG_TX_RPT_TIME, 0x3DF0);
@@ -894,9 +894,9 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	val8 = usb_read8(Adapter, REG_MCUFWDL);
 	if ((val8 & RAM_DL_SEL) && Adapter->bFWReady) { /* 8051 RAM code */
 		/*  Reset MCU 0x2[10]=0. */
-		val8 = usb_read8(Adapter, REG_SYS_FUNC_EN+1);
+		val8 = usb_read8(Adapter, REG_SYS_FUNC_EN + 1);
 		val8 &= ~BIT(2);	/*  0x2[10], FEN_CPUEN */
-		usb_write8(Adapter, REG_SYS_FUNC_EN+1, val8);
+		usb_write8(Adapter, REG_SYS_FUNC_EN + 1, val8);
 	}
 
 	/*  reset MCU ready status */
@@ -912,10 +912,10 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 				 Rtl8188E_NIC_DISABLE_FLOW);
 
 	/*  Reset MCU IO Wrapper */
-	val8 = usb_read8(Adapter, REG_RSV_CTRL+1);
-	usb_write8(Adapter, REG_RSV_CTRL+1, (val8&(~BIT(3))));
-	val8 = usb_read8(Adapter, REG_RSV_CTRL+1);
-	usb_write8(Adapter, REG_RSV_CTRL+1, val8 | BIT(3));
+	val8 = usb_read8(Adapter, REG_RSV_CTRL + 1);
+	usb_write8(Adapter, REG_RSV_CTRL + 1, (val8&(~BIT(3))));
+	val8 = usb_read8(Adapter, REG_RSV_CTRL + 1);
+	usb_write8(Adapter, REG_RSV_CTRL + 1, val8 | BIT(3));
 
 	/* YJ,test add, 111207. For Power Consumption. */
 	val8 = usb_read8(Adapter, GPIO_IN);
@@ -924,8 +924,8 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	val8 = usb_read8(Adapter, REG_GPIO_IO_SEL);
 	usb_write8(Adapter, REG_GPIO_IO_SEL, (val8<<4));
-	val8 = usb_read8(Adapter, REG_GPIO_IO_SEL+1);
-	usb_write8(Adapter, REG_GPIO_IO_SEL+1, val8|0x0F);/* Reg0x43 */
+	val8 = usb_read8(Adapter, REG_GPIO_IO_SEL + 1);
+	usb_write8(Adapter, REG_GPIO_IO_SEL + 1, val8|0x0F);/* Reg0x43 */
 	usb_write32(Adapter, REG_BB_PAD_CTRL, 0x00080808);/* set LNA ,TRSW,EX_PA Pin to output mode */
 	Adapter->HalData->bMacPwrCtrlOn = false;
 	Adapter->bFWReady = false;
@@ -1103,11 +1103,11 @@ static void ResumeTxBeacon(struct adapter *adapt)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	usb_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) | BIT(6));
+	usb_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl) | BIT(6));
 	haldata->RegFwHwTxQCtrl |= BIT(6);
-	usb_write8(adapt, REG_TBTT_PROHIBIT+1, 0xff);
+	usb_write8(adapt, REG_TBTT_PROHIBIT + 1, 0xff);
 	haldata->RegReg542 |= BIT(0);
-	usb_write8(adapt, REG_TBTT_PROHIBIT+2, haldata->RegReg542);
+	usb_write8(adapt, REG_TBTT_PROHIBIT + 2, haldata->RegReg542);
 }
 
 static void StopTxBeacon(struct adapter *adapt)
@@ -1117,11 +1117,11 @@ static void StopTxBeacon(struct adapter *adapt)
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
 
-	usb_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) & (~BIT(6)));
+	usb_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl) & (~BIT(6)));
 	haldata->RegFwHwTxQCtrl &= (~BIT(6));
-	usb_write8(adapt, REG_TBTT_PROHIBIT+1, 0x64);
+	usb_write8(adapt, REG_TBTT_PROHIBIT + 1, 0x64);
 	haldata->RegReg542 &= ~(BIT(0));
-	usb_write8(adapt, REG_TBTT_PROHIBIT+2, haldata->RegReg542);
+	usb_write8(adapt, REG_TBTT_PROHIBIT + 2, haldata->RegReg542);
 
 	 /* todo: CheckFwRsvdPageContent(Adapter);  2010.06.23. Added by tynli. */
 }
@@ -1191,7 +1191,7 @@ static void hw_var_set_macaddr(struct adapter *Adapter, u8 variable, u8 *val)
 	reg_macid = REG_MACID;
 
 	for (idx = 0; idx < 6; idx++)
-		usb_write8(Adapter, (reg_macid+idx), val[idx]);
+		usb_write8(Adapter, (reg_macid + idx), val[idx]);
 }
 
 static void hw_var_set_bssid(struct adapter *Adapter, u8 variable, u8 *val)
@@ -1202,7 +1202,7 @@ static void hw_var_set_bssid(struct adapter *Adapter, u8 variable, u8 *val)
 	reg_bssid = REG_BSSID;
 
 	for (idx = 0; idx < 6; idx++)
-		usb_write8(Adapter, (reg_bssid+idx), val[idx]);
+		usb_write8(Adapter, (reg_bssid + idx), val[idx]);
 }
 
 static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
@@ -1274,8 +1274,8 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			BrateCfg |= 0x01; /*  default enable 1M ACK rate */
 			/*  Set RRSR rate table. */
 			usb_write8(Adapter, REG_RRSR, BrateCfg & 0xff);
-			usb_write8(Adapter, REG_RRSR+1, (BrateCfg >> 8) & 0xff);
-			usb_write8(Adapter, REG_RRSR+2, usb_read8(Adapter, REG_RRSR+2)&0xf0);
+			usb_write8(Adapter, REG_RRSR + 1, (BrateCfg >> 8) & 0xff);
+			usb_write8(Adapter, REG_RRSR + 2, usb_read8(Adapter, REG_RRSR + 2)&0xf0);
 
 			/*  Set RTS initial rate */
 			while (BrateCfg > 0x1) {
@@ -1307,7 +1307,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL)&(~BIT(3)));
 
 			usb_write32(Adapter, REG_TSFTR, tsf);
-			usb_write32(Adapter, REG_TSFTR+4, tsf>>32);
+			usb_write32(Adapter, REG_TSFTR + 4, tsf>>32);
 
 			/* enable related TSF function */
 			usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) | BIT(3));
@@ -1432,10 +1432,10 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_RESP_SIFS:
 		/* RESP_SIFS for CCK */
 		usb_write8(Adapter, REG_R2T_SIFS, val[0]); /*  SIFS_T2T_CCK (0x08) */
-		usb_write8(Adapter, REG_R2T_SIFS+1, val[1]); /* SIFS_R2T_CCK(0x08) */
+		usb_write8(Adapter, REG_R2T_SIFS + 1, val[1]); /* SIFS_R2T_CCK(0x08) */
 		/* RESP_SIFS for OFDM */
 		usb_write8(Adapter, REG_T2T_SIFS, val[2]); /* SIFS_T2T_OFDM (0x0a) */
-		usb_write8(Adapter, REG_T2T_SIFS+1, val[3]); /* SIFS_R2T_OFDM(0x0a) */
+		usb_write8(Adapter, REG_T2T_SIFS + 1, val[3]); /* SIFS_R2T_OFDM(0x0a) */
 		break;
 	case HW_VAR_ACK_PREAMBLE:
 		{
@@ -1446,7 +1446,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			if (bShortPreamble)
 				regTmp |= 0x80;
 
-			usb_write8(Adapter, REG_RRSR+2, regTmp);
+			usb_write8(Adapter, REG_RRSR + 2, regTmp);
 		}
 		break;
 	case HW_VAR_SEC_CFG:
@@ -1484,7 +1484,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 				else
 					ulContent = 0;
 				/*  polling bit, and No Write enable, and address */
-				ulCommand = CAM_CONTENT_COUNT*ucIndex+i;
+				ulCommand = CAM_CONTENT_COUNT*ucIndex + i;
 				ulCommand = ulCommand | CAM_POLLINIG|CAM_WRITE;
 				/*  write content 0 is equall to mark invalid */
 				usb_write32(Adapter, WCAMI, ulContent);  /* delay_ms(40); */
@@ -1595,7 +1595,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 					if ((pRegToSet[index] & 0x0f) > FactorToSet)
 						pRegToSet[index] = (pRegToSet[index] & 0xf0) | (FactorToSet);
 
-					usb_write8(Adapter, (REG_AGGLEN_LMT+index), pRegToSet[index]);
+					usb_write8(Adapter, (REG_AGGLEN_LMT + index), pRegToSet[index]);
 				}
 			}
 		}
@@ -1706,8 +1706,8 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 maxMacid = *val;
 
-			DBG_88E("### MacID(%d),Set Max Tx RPT MID(%d)\n", maxMacid, maxMacid+1);
-			usb_write8(Adapter, REG_TX_RPT_CTRL+1, maxMacid+1);
+			DBG_88E("### MacID(%d),Set Max Tx RPT MID(%d)\n", maxMacid, maxMacid + 1);
+			usb_write8(Adapter, REG_TX_RPT_CTRL + 1, maxMacid + 1);
 		}
 		break;
 	case HW_VAR_H2C_MEDIA_STATUS_RPT:
@@ -1715,7 +1715,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2, write 1 to clear, Clear by sw */
-		usb_write8(Adapter, REG_TDECTRL+2, usb_read8(Adapter, REG_TDECTRL+2) | BIT(0));
+		usb_write8(Adapter, REG_TDECTRL + 2, usb_read8(Adapter, REG_TDECTRL + 2) | BIT(0));
 		break;
 	default:
 		break;
@@ -1733,7 +1733,7 @@ void rtw_hal_get_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2 */
-		val[0] = (BIT(0) & usb_read8(Adapter, REG_TDECTRL+2)) ? true : false;
+		val[0] = (BIT(0) & usb_read8(Adapter, REG_TDECTRL + 2)) ? true : false;
 		break;
 	case HW_VAR_FWLPS_RF_ON:
 		{
-- 
2.22.0

