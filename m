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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5E7C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51133218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmL97F6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfGZSFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:05:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36339 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfGZSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:05:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so55390708wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qr/tVRHimbuQXcEAGTxIyxSWW0oV4v68EkRQtT+1XB8=;
        b=PmL97F6P0tadb+qIzTM4YdJ9w3HPpN1vTkVFxrYq4B0pS2LuhsNQv6k9kxgaCbZCb+
         OFAAFoHAk/AyC8Ot6RRiX20YdQm6YHh8ZiPR4DXmQsdoADCUPr9gfFDvGSUzL/f5ElzF
         +HHXvwEhmSEscg1sM9y3lLrTW7RgBZ76ejsFPu5hwtY44Z8XNm88U7Ij4V2axc8d9TLf
         Tlj09qjoyXr6kjsyyYd2xLHCWoPsu+wVn9QoXPdNE5xOXcqzSzWKFApUyihiKDRDCtta
         FRcoxvTok3Q0LtBbjT0mxtsulKD5ZVh+0PTi5bYHUSOVQ/S0Qf3OF/5Pmv6bicaQs71K
         ZDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qr/tVRHimbuQXcEAGTxIyxSWW0oV4v68EkRQtT+1XB8=;
        b=UiPeA36XL/doJCBGJfcBK/Hoxjp7gYkQm8MM62DGVY9Kdma3rmsEB9zoYPQGpNQwdE
         YXAQ8ld26EYaY4kbCzTWA09wkyI8/NIXjCHuPL59e52XOmHgXBqX64lAYwIgFTwYfIZb
         Vaj9RuwKDQQeaR5dmVt5598Ux5ji/4cvI+VIbfl0XMbnPM8U/MziZz6wmGdYEhgsF3k4
         lbXnop+rWlwQ2y3BlS1u7JEJZ0vCY/dT3/um7Dw6JMegzXFaACljo+JR/kbintSLiJfv
         u4/z60A5+vPjKozIvlrP9J4PVUISEB0diQT3+69izs9M4Gr+ckLPCY5mK+giw3h0kzN2
         AAPg==
X-Gm-Message-State: APjAAAVyKjONR72d+M4BBniYU/ey2NNH1LBdkWW/qVXpMUn4mptpFhoN
        nfM4DZVYkIc/NRncjnhVrswz1Wbo
X-Google-Smtp-Source: APXvYqx5YfN9KBzr/kb8wjRvXGK+It5lgf9QTGXhEfPOOVA/3BLXt8opvxb0L81QvbVbnrNPGKh8XA==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr101277048wrl.344.1564164301265;
        Fri, 26 Jul 2019 11:05:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id p14sm43535931wrx.17.2019.07.26.11.05.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 11:05:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: rtl8188eu: add spaces around '&' in usb_halinit.c
Date:   Fri, 26 Jul 2019 20:04:44 +0200
Message-Id: <20190726180448.2290-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726180448.2290-1-straube.linux@gmail.com>
References: <20190726180448.2290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '&' to improve readability and follow kernel
coding style. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 38 ++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index c2e1b000cf89..fe68af7eaf85 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -633,7 +633,7 @@ enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
 		DBG_88E("pwrdown, 0x5c(BIT(7))=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(7)) ? rf_off : rf_on;
 	} else { /*  rf on/off */
-		usb_write8(adapt, REG_MAC_PINMUX_CFG, usb_read8(adapt, REG_MAC_PINMUX_CFG)&~(BIT(3)));
+		usb_write8(adapt, REG_MAC_PINMUX_CFG, usb_read8(adapt, REG_MAC_PINMUX_CFG) & ~(BIT(3)));
 		val8 = usb_read8(adapt, REG_GPIO_IO_SEL);
 		DBG_88E("GPIO_IN=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(3)) ? rf_on : rf_off;
@@ -880,7 +880,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
 	val8 = usb_read8(Adapter, REG_TX_RPT_CTRL);
-	usb_write8(Adapter, REG_TX_RPT_CTRL, val8&(~BIT(1)));
+	usb_write8(Adapter, REG_TX_RPT_CTRL, val8 & (~BIT(1)));
 
 	/*  stop rx */
 	usb_write8(Adapter, REG_CR, 0x0);
@@ -905,7 +905,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	/* YJ,add,111212 */
 	/* Disable 32k */
 	val8 = usb_read8(Adapter, REG_32K_CTRL);
-	usb_write8(Adapter, REG_32K_CTRL, val8&(~BIT(0)));
+	usb_write8(Adapter, REG_32K_CTRL, val8 & (~BIT(0)));
 
 	/*  Card disable power action flow */
 	rtl88eu_pwrseqcmdparsing(Adapter, PWR_CUT_ALL_MSK,
@@ -913,7 +913,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	/*  Reset MCU IO Wrapper */
 	val8 = usb_read8(Adapter, REG_RSV_CTRL + 1);
-	usb_write8(Adapter, REG_RSV_CTRL + 1, (val8&(~BIT(3))));
+	usb_write8(Adapter, REG_RSV_CTRL + 1, (val8 & (~BIT(3))));
 	val8 = usb_read8(Adapter, REG_RSV_CTRL + 1);
 	usb_write8(Adapter, REG_RSV_CTRL + 1, val8 | BIT(3));
 
@@ -1135,7 +1135,7 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 	usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) | BIT(4));
 
 	/*  set net_type */
-	val8 = usb_read8(Adapter, MSR)&0x0c;
+	val8 = usb_read8(Adapter, MSR) & 0x0c;
 	val8 |= mode;
 	usb_write8(Adapter, MSR, val8);
 
@@ -1214,7 +1214,7 @@ static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
 	if (*((u8 *)val))
 		usb_write8(Adapter, bcn_ctrl_reg, (EN_BCN_FUNCTION | EN_TXBCN_RPT));
 	else
-		usb_write8(Adapter, bcn_ctrl_reg, usb_read8(Adapter, bcn_ctrl_reg)&(~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
+		usb_write8(Adapter, bcn_ctrl_reg, usb_read8(Adapter, bcn_ctrl_reg) & (~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
 }
 
 void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
@@ -1228,7 +1228,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 val8;
 
-			val8 = usb_read8(Adapter, MSR)&0x0c;
+			val8 = usb_read8(Adapter, MSR) & 0x0c;
 			val8 |= *((u8 *)val);
 			usb_write8(Adapter, MSR, val8);
 		}
@@ -1275,7 +1275,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			/*  Set RRSR rate table. */
 			usb_write8(Adapter, REG_RRSR, BrateCfg & 0xff);
 			usb_write8(Adapter, REG_RRSR + 1, (BrateCfg >> 8) & 0xff);
-			usb_write8(Adapter, REG_RRSR + 2, usb_read8(Adapter, REG_RRSR + 2)&0xf0);
+			usb_write8(Adapter, REG_RRSR + 2, usb_read8(Adapter, REG_RRSR + 2) & 0xf0);
 
 			/*  Set RTS initial rate */
 			while (BrateCfg > 0x1) {
@@ -1300,11 +1300,11 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 
 			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval*1024)) - 1024; /* us */
 
-			if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE))
+			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
 				StopTxBeacon(Adapter);
 
 			/* disable related TSF function */
-			usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL)&(~BIT(3)));
+			usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) & (~BIT(3)));
 
 			usb_write32(Adapter, REG_TSFTR, tsf);
 			usb_write32(Adapter, REG_TSFTR + 4, tsf>>32);
@@ -1312,7 +1312,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			/* enable related TSF function */
 			usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) | BIT(3));
 
-			if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE))
+			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
 				ResumeTxBeacon(Adapter);
 		}
 		break;
@@ -1357,16 +1357,16 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 			if ((is_client_associated_to_ap(Adapter)) ||
-			    ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE)) {
+			    ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)) {
 				/* enable to rx data frame */
 				usb_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 
 				/* enable update TSF */
-				usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
-			} else if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+				usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
+			} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 				usb_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 				/* enable update TSF */
-				usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
+				usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
 			}
 
 			usb_write32(Adapter, REG_RCR, usb_read32(Adapter, REG_RCR)|RCR_CBSSID_BCN);
@@ -1394,7 +1394,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			} else if (type == 2) {
 				/* sta add event call back */
 				/* enable update TSF */
-				usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
+				usb_write8(Adapter, REG_BCN_CTRL, usb_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
 
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE))
 					RetryLimit = 0x7;
@@ -1683,7 +1683,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 				/* RX DMA stop */
 				usb_write32(Adapter, REG_RXPKT_NUM, (usb_read32(Adapter, REG_RXPKT_NUM)|RW_RELEASE_EN));
 				do {
-					if (!(usb_read32(Adapter, REG_RXPKT_NUM)&RXDMA_IDLE))
+					if (!(usb_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
 						break;
 				} while (trycnt--);
 				if (trycnt == 0)
@@ -1764,7 +1764,7 @@ void rtw_hal_get_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 		*val = Adapter->HalData->bMacPwrCtrlOn;
 		break;
 	case HW_VAR_CHK_HI_QUEUE_EMPTY:
-		*val = ((usb_read32(Adapter, REG_HGQ_INFORMATION)&0x0000ff00) == 0) ? true : false;
+		*val = ((usb_read32(Adapter, REG_HGQ_INFORMATION) & 0x0000ff00) == 0) ? true : false;
 		break;
 	default:
 		break;
@@ -1925,7 +1925,7 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 
 	mask &= rate_bitmap;
 
-	init_rate = get_highest_rate_idx(mask)&0x3f;
+	init_rate = get_highest_rate_idx(mask) & 0x3f;
 
 	ODM_RA_UpdateRateInfo_8188E(odmpriv, mac_id, raid, mask, shortGIrate);
 
-- 
2.22.0

