Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D3DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51E120880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdzkLE5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfHBVAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:00:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39118 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfHBVAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:00:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id w190so55875787qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwE3+6BcTglZ7l+bRUlKAeLgMYqdZqdhQZew+tyQBhc=;
        b=VdzkLE5tcD+dAKnnkMn/COI3GEV/C5NjE6tmJRXRJKWi5GAG0puvA/kPUC50iX7wQq
         m8uJxenXH0BbjwttGAHYOl2uLptkC3NexdiIq78LQldakVzrKcCN8O5Y/ziIZPSFezD7
         64qaA1Y3pjuzdWKzTdLWCWwhK6SI9zsFEpSHSY4OM71aTy7p7tdHhu+87YlMwojHfof/
         jjFKW2w7xz2h60Q5ujQQ7/7ktFAN8OOiYRwcetFS54IRZVuIisb7PxTBncOMrCuq3elE
         Li+ygXFhjaP8i8BOSD1jhOcoP12+vB5IF8JFjd00cmAvif5pGdQHExMlXAS87sc6ZeyI
         +Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwE3+6BcTglZ7l+bRUlKAeLgMYqdZqdhQZew+tyQBhc=;
        b=t7WlrJbBI8mC0uCoxXHVCxtBAo8lnsuLOMlyMQ2mhJwMuCHTyXY+LCvKS1n3YgVukn
         6k2NihrRbHqjORfa0mfaeWUWafiaW9NNLuOsp7sEaNpFHmTq8U5/6VqLkN0fScaBx2/u
         mtbi6VT8dEBM8IKZn4CZpotmadbquMHDEP3uHLJvEhORGvxRNUnTsfqQoVzxGgEpeLoo
         sCGrTwvKxXXD2SdxItmmO30g9F64MqS1XSljvbVLCljcYlQpdMunaHJ/oWndpchLrQ5Q
         IS6nMM3U0Szhd4dQbNnpfL2g1F6mQAcSLZVJka0OQSbgZ2iRe8LcPLhq+j+BOGqLJyK5
         x/XA==
X-Gm-Message-State: APjAAAWWEeOxGBBRrL0aDyAfvYm13eIiYvR05S+7+dfbgE/EQtxtbH0H
        e57+Bqxrs81ukBJ22/7ExrXOU+z3+dxIuw==
X-Google-Smtp-Source: APXvYqxQK78E2PZwOIgAdfjgcQ3w55xhTiXKNqtO/lRNK3LgnMSywCpvG0K93f8iU1aAbCHZjTMi1A==
X-Received: by 2002:ae9:f107:: with SMTP id k7mr28181289qkg.215.1564779623127;
        Fri, 02 Aug 2019 14:00:23 -0700 (PDT)
Received: from 0366fb520575.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o50sm2129600qtj.17.2019.08.02.14.00.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 14:00:22 -0700 (PDT)
From:   Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] rtl8188eu: hal: phy.c
Date:   Fri,  2 Aug 2019 21:00:18 +0000
Message-Id: <20190802210018.29251-1-joseespiriki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a lot of checkpath errors of the type:
	-CHECK: spaces preferred around that
	-CHECK: Alignment should match open parenthesis

Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
---
 My second commit to the kernel, I know you ppl don't like these kind of commits
 fixing style-only erros pointed by the checkpath, but I'm doing this just to learn
 Thanks!
 drivers/staging/rtl8188eu/hal/phy.c | 54 ++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 51c40abfa..f0d242dec 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -52,7 +52,7 @@ void phy_set_bb_reg(struct adapter *adapt, u32 regaddr, u32 bitmask, u32 data)
 }
 
 static u32 rf_serial_read(struct adapter *adapt,
-			enum rf_radio_path rfpath, u32 offset)
+			  enum rf_radio_path rfpath, u32 offset)
 {
 	u32 ret = 0;
 	struct bb_reg_def *phyreg = &adapt->HalData->PHYRegDef[rfpath];
@@ -69,10 +69,10 @@ static u32 rf_serial_read(struct adapter *adapt,
 					    bMaskDWord);
 
 	tmplong2 = (tmplong2 & (~bLSSIReadAddress)) |
-		   (offset<<23) | bLSSIReadEdge;
+		   (offset << 23) | bLSSIReadEdge;
 
 	phy_set_bb_reg(adapt, rFPGA0_XA_HSSIParameter2, bMaskDWord,
-		       tmplong&(~bLSSIReadEdge));
+		       tmplong & (~bLSSIReadEdge));
 	udelay(10);
 
 	phy_set_bb_reg(adapt, phyreg->rfHSSIPara2, bMaskDWord, tmplong2);
@@ -102,12 +102,12 @@ static void rf_serial_write(struct adapter *adapt,
 	struct bb_reg_def *phyreg = &adapt->HalData->PHYRegDef[rfpath];
 
 	offset &= 0xff;
-	data_and_addr = ((offset<<20) | (data&0x000fffff)) & 0x0fffffff;
+	data_and_addr = ((offset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	phy_set_bb_reg(adapt, phyreg->rf3wireOffset, bMaskDWord, data_and_addr);
 }
 
 u32 rtw_hal_read_rfreg(struct adapter *adapt, enum rf_radio_path rf_path,
-		     u32 reg_addr, u32 bit_mask)
+		       u32 reg_addr, u32 bit_mask)
 {
 	u32 original_value, bit_shift;
 
@@ -117,7 +117,7 @@ u32 rtw_hal_read_rfreg(struct adapter *adapt, enum rf_radio_path rf_path,
 }
 
 void phy_set_rf_reg(struct adapter *adapt, enum rf_radio_path rf_path,
-		     u32 reg_addr, u32 bit_mask, u32 data)
+		    u32 reg_addr, u32 bit_mask, u32 data)
 {
 	u32 original_value, bit_shift;
 
@@ -143,20 +143,20 @@ static void get_tx_power_index(struct adapter *adapt, u8 channel, u8 *cck_pwr,
 	for (TxCount = 0; TxCount < path_nums; TxCount++) {
 		if (TxCount == RF_PATH_A) {
 			cck_pwr[TxCount] = hal_data->Index24G_CCK_Base[TxCount][index];
-			ofdm_pwr[TxCount] = hal_data->Index24G_BW40_Base[RF_PATH_A][index]+
+			ofdm_pwr[TxCount] = hal_data->Index24G_BW40_Base[RF_PATH_A][index] +
 					    hal_data->OFDM_24G_Diff[TxCount][RF_PATH_A];
 
-			bw20_pwr[TxCount] = hal_data->Index24G_BW40_Base[RF_PATH_A][index]+
+			bw20_pwr[TxCount] = hal_data->Index24G_BW40_Base[RF_PATH_A][index] +
 					    hal_data->BW20_24G_Diff[TxCount][RF_PATH_A];
 			bw40_pwr[TxCount] = hal_data->Index24G_BW40_Base[TxCount][index];
 		} else if (TxCount == RF_PATH_B) {
 			cck_pwr[TxCount] = hal_data->Index24G_CCK_Base[TxCount][index];
-			ofdm_pwr[TxCount] = hal_data->Index24G_BW40_Base[RF_PATH_A][index]+
-			hal_data->BW20_24G_Diff[RF_PATH_A][index]+
+			ofdm_pwr[TxCount] = hal_data->Index24G_BW40_Base[RF_PATH_A][index] +
+			hal_data->BW20_24G_Diff[RF_PATH_A][index] +
 			hal_data->BW20_24G_Diff[TxCount][index];
 
-			bw20_pwr[TxCount] = hal_data->Index24G_BW40_Base[RF_PATH_A][index]+
-			hal_data->BW20_24G_Diff[TxCount][RF_PATH_A]+
+			bw20_pwr[TxCount] = hal_data->Index24G_BW40_Base[RF_PATH_A][index] +
+			hal_data->BW20_24G_Diff[TxCount][RF_PATH_A] +
 			hal_data->BW20_24G_Diff[TxCount][index];
 			bw40_pwr[TxCount] = hal_data->Index24G_BW40_Base[TxCount][index];
 		}
@@ -190,7 +190,7 @@ void phy_set_tx_power_level(struct adapter *adapt, u8 channel)
 
 	rtl88eu_phy_rf6052_set_cck_txpower(adapt, &cck_pwr[0]);
 	rtl88eu_phy_rf6052_set_ofdm_txpower(adapt, &ofdm_pwr[0], &bw20_pwr[0],
-					  &bw40_pwr[0], channel);
+					    &bw40_pwr[0], channel);
 }
 
 static void phy_set_bw_mode_callback(struct adapter *adapt)
@@ -903,13 +903,13 @@ static bool simularity_compare(struct adapter *adapt, s32 resulta[][8],
 		if (diff > MAX_TOLERANCE) {
 			if ((i == 2 || i == 6) && !sim_bitmap) {
 				if (resulta[c1][i] + resulta[c1][i+1] == 0)
-					final_candidate[(i/4)] = c2;
+					final_candidate[(i / 4)] = c2;
 				else if (resulta[c2][i] + resulta[c2][i+1] == 0)
-					final_candidate[(i/4)] = c1;
+					final_candidate[(i / 4)] = c1;
 				else
-					sim_bitmap = sim_bitmap | (1<<i);
+					sim_bitmap = sim_bitmap | (1 << i);
 			} else {
-				sim_bitmap = sim_bitmap | (1<<i);
+				sim_bitmap = sim_bitmap | (1 << i);
 			}
 		}
 	}
@@ -1074,19 +1074,19 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 			path_b_ok = phy_path_b_iqk(adapt);
 			if (path_b_ok == 0x03) {
 				result[t][4] = (phy_query_bb_reg(adapt, rTx_Power_Before_IQK_B,
-								 bMaskDWord)&0x3FF0000)>>16;
+								 bMaskDWord)&0x3FF0000) >> 16;
 				result[t][5] = (phy_query_bb_reg(adapt, rTx_Power_After_IQK_B,
-								 bMaskDWord)&0x3FF0000)>>16;
+								 bMaskDWord)&0x3FF0000) >> 16;
 				result[t][6] = (phy_query_bb_reg(adapt, rRx_Power_Before_IQK_B_2,
-								 bMaskDWord)&0x3FF0000)>>16;
+								 bMaskDWord)&0x3FF0000) >> 16;
 				result[t][7] = (phy_query_bb_reg(adapt, rRx_Power_After_IQK_B_2,
-								 bMaskDWord)&0x3FF0000)>>16;
+								 bMaskDWord)&0x3FF0000) >> 16;
 				break;
 			} else if (i == (retry_count - 1) && path_b_ok == 0x01) {	/* Tx IQK OK */
 				result[t][4] = (phy_query_bb_reg(adapt, rTx_Power_Before_IQK_B,
-								 bMaskDWord)&0x3FF0000)>>16;
+								 bMaskDWord)&0x3FF0000) >> 16;
 				result[t][5] = (phy_query_bb_reg(adapt, rTx_Power_After_IQK_B,
-								 bMaskDWord)&0x3FF0000)>>16;
+								 bMaskDWord)&0x3FF0000) >> 16;
 			}
 		}
 
@@ -1158,12 +1158,12 @@ static void phy_lc_calibrate(struct adapter *adapt, bool is2t)
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
 		phy_set_rf_reg(adapt, RF_PATH_A, RF_AC, bMask12Bits,
-			       (rf_a_mode&0x8FFFF)|0x10000);
+			       (rf_a_mode&0x8FFFF) | 0x10000);
 
 		/* Path-B */
 		if (is2t)
 			phy_set_rf_reg(adapt, RF_PATH_B, RF_AC, bMask12Bits,
-				       (rf_b_mode&0x8FFFF)|0x10000);
+				       (rf_b_mode&0x8FFFF) | 0x10000);
 	}
 
 	/* 3. Read RF reg18 */
@@ -1171,12 +1171,12 @@ static void phy_lc_calibrate(struct adapter *adapt, bool is2t)
 
 	/* 4. Set LC calibration begin bit15 */
 	phy_set_rf_reg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits,
-		       lc_cal|0x08000);
+		       lc_cal | 0x08000);
 
 	msleep(100);
 
 	/* Restore original situation */
-	if ((tmpreg&0x70) != 0) {
+	if ((tmpreg & 0x70) != 0) {
 		/* Deal with continuous TX case */
 		/* Path-A */
 		usb_write8(adapt, 0xd03, tmpreg);
-- 
2.20.1

