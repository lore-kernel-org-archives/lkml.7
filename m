Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C8C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9D820828
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL2O8oB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGUR54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 13:57:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56104 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfGUR54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 13:57:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so32989799wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gjz8oNblawby7NklpmeeuAckSeUwNIdtjSj6EpDbQhY=;
        b=qL2O8oB1PXS16WRxxiM9a1vbGYVj6aVczfn279cC+F/TtmeOOFTpLWkE9JlH0ezlIM
         RkelZzcfs+JyJR4bbZ7Fe17oNxySg8ya7JNEM8obrKeIP6UdIC/skiizt7MLBUhUlK7t
         1rZD5hcJ+LmBjGXN1LKnYQjb80X6lMn3lkF0INIajpS6sginzcCYOUeVP9wHW+jhoMmm
         uSf54dVRNI2HNExRd6lkH0lBIG+wLY+aQlIXTTTeaCTnOCFcHqhz8jCH2bVjNni9yp5W
         LGw//SI+/GmthRJVPOqxh/Pxlf7malNEkNmKRE9En9nfmR3KnQM23CAgZS4VxPHhB92a
         TLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gjz8oNblawby7NklpmeeuAckSeUwNIdtjSj6EpDbQhY=;
        b=AbDtfQwrqk4LtbIL0VKI7snUaVVxH+e7p7MLiaBeOnMIuQ+1mxZjDkk2M4OH4JJOyt
         ggWsHancMVGqgMHvFj2o1QAUDzbITkCGcyxIsr/cBIZnXZBNi3ffl60HcQYKoF3Q8x5Z
         36o0x7/7cFuyUm31EuCkqnMiS7o785JFetCZo5MjP0tVIIekA1CBnBsn345oipAJQ2fn
         DQ+BMIQXoPZhFh12AQgFgsfkQFOHJ1NJMJTjZaIpXyyqHZvTtES3PXsXiCYC3ZSQZ6K+
         FifX/jd+qsLCnwV6KPepbMcmBOdIfw3OBdqAIsIxTXhZW7mB+p99LTSzhBDepfjY/SxC
         Gqaw==
X-Gm-Message-State: APjAAAVrwJ9fRIwwIonM96EiKlq78/CPIND1Z2SR1dudAafkgrJx7pNo
        p6feQ2ajH0ynkp7lPJliyXtlg2rd
X-Google-Smtp-Source: APXvYqzzJYi6iPUvUrauccDdZBKCmHSGu7o701tN6QkPVBPi4B0GzcHytMDJIqQKv3uuMejz6al+bw==
X-Received: by 2002:a1c:7a02:: with SMTP id v2mr59433539wmc.159.1563731873815;
        Sun, 21 Jul 2019 10:57:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id o4sm28999864wmh.35.2019.07.21.10.57.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 10:57:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove unused file hal_phy.c
Date:   Sun, 21 Jul 2019 19:57:35 +0200
Message-Id: <20190721175735.24173-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused file hal_phy.c. No function from this file is used
in the driver code and it is not listed in the Makefile.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_phy.c | 157 ------------------------
 1 file changed, 157 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/hal_phy.c

diff --git a/drivers/staging/rtl8723bs/hal/hal_phy.c b/drivers/staging/rtl8723bs/hal/hal_phy.c
deleted file mode 100644
index 24a9d8f783f0..000000000000
--- a/drivers/staging/rtl8723bs/hal/hal_phy.c
+++ /dev/null
@@ -1,157 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#define _HAL_PHY_C_
-
-#include <drv_types.h>
-
-/*  */
-/*  ==> RF shadow Operation API Code Section!!! */
-/*  */
-/*-----------------------------------------------------------------------------
- * Function:	PHY_RFShadowRead
- *			PHY_RFShadowWrite
- *			PHY_RFShadowCompare
- *			PHY_RFShadowRecorver
- *			PHY_RFShadowCompareAll
- *			PHY_RFShadowRecorverAll
- *			PHY_RFShadowCompareFlagSet
- *			PHY_RFShadowRecorverFlagSet
- *
- * Overview:	When we set RF register, we must write shadow at first.
- *		When we are running, we must compare shadow abd locate error addr.
- *		Decide to recorver or not.
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/20/2008	MHC		Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-u32 PHY_RFShadowRead(IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset)
-{
-	return	RF_Shadow[eRFPath][Offset].Value;
-
-}	/* PHY_RFShadowRead */
-
-
-void PHY_RFShadowWrite(
-	IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset, IN u32 Data
-)
-{
-	RF_Shadow[eRFPath][Offset].Value = (Data & bRFRegOffsetMask);
-	RF_Shadow[eRFPath][Offset].Driver_Write = true;
-
-}	/* PHY_RFShadowWrite */
-
-
-bool PHY_RFShadowCompare(IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset)
-{
-	u32 reg;
-	/*  Check if we need to check the register */
-	if (RF_Shadow[eRFPath][Offset].Compare == true) {
-		reg = rtw_hal_read_rfreg(Adapter, eRFPath, Offset, bRFRegOffsetMask);
-		/*  Compare shadow and real rf register for 20bits!! */
-		if (RF_Shadow[eRFPath][Offset].Value != reg) {
-			/*  Locate error position. */
-			RF_Shadow[eRFPath][Offset].ErrorOrNot = true;
-			/* RT_TRACE(COMP_INIT, DBG_LOUD, */
-			/* PHY_RFShadowCompare RF-%d Addr%02lx Err = %05lx\n", */
-			/* eRFPath, Offset, reg)); */
-		}
-		return RF_Shadow[eRFPath][Offset].ErrorOrNot;
-	}
-	return false;
-}	/* PHY_RFShadowCompare */
-
-
-void PHY_RFShadowRecorver(IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset)
-{
-	/*  Check if the address is error */
-	if (RF_Shadow[eRFPath][Offset].ErrorOrNot == true) {
-		/*  Check if we need to recorver the register. */
-		if (RF_Shadow[eRFPath][Offset].Recorver == true) {
-			rtw_hal_write_rfreg(Adapter, eRFPath, Offset, bRFRegOffsetMask,
-							RF_Shadow[eRFPath][Offset].Value);
-			/* RT_TRACE(COMP_INIT, DBG_LOUD, */
-			/* PHY_RFShadowRecorver RF-%d Addr%02lx=%05lx", */
-			/* eRFPath, Offset, RF_Shadow[eRFPath][Offset].Value)); */
-		}
-	}
-
-}	/* PHY_RFShadowRecorver */
-
-
-void PHY_RFShadowCompareAll(IN PADAPTER Adapter)
-{
-	u8 eRFPath = 0;
-	u32 Offset = 0, maxReg = GET_RF6052_REAL_MAX_REG(Adapter);
-
-	for (eRFPath = 0; eRFPath < RF6052_MAX_PATH; eRFPath++) {
-		for (Offset = 0; Offset < maxReg; Offset++) {
-			PHY_RFShadowCompare(Adapter, eRFPath, Offset);
-		}
-	}
-
-}	/* PHY_RFShadowCompareAll */
-
-
-void PHY_RFShadowRecorverAll(IN PADAPTER Adapter)
-{
-	u8 eRFPath = 0;
-	u32 Offset = 0, maxReg = GET_RF6052_REAL_MAX_REG(Adapter);
-
-	for (eRFPath = 0; eRFPath < RF6052_MAX_PATH; eRFPath++) {
-		for (Offset = 0; Offset < maxReg; Offset++) {
-			PHY_RFShadowRecorver(Adapter, eRFPath, Offset);
-		}
-	}
-
-}	/* PHY_RFShadowRecorverAll */
-
-
-void
-PHY_RFShadowCompareFlagSet(
-	IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset, IN u8 Type
-)
-{
-	/*  Set True or False!!! */
-	RF_Shadow[eRFPath][Offset].Compare = Type;
-
-}	/* PHY_RFShadowCompareFlagSet */
-
-
-void PHY_RFShadowRecorverFlagSet(
-	IN PADAPTER Adapter, IN u8 eRFPath, IN u32 Offset, IN u8 Type
-)
-{
-	/*  Set True or False!!! */
-	RF_Shadow[eRFPath][Offset].Recorver = Type;
-
-}	/* PHY_RFShadowRecorverFlagSet */
-
-
-void PHY_RFShadowCompareFlagSetAll(IN PADAPTER Adapter)
-{
-	u8 eRFPath = 0;
-	u32 Offset = 0, maxReg = GET_RF6052_REAL_MAX_REG(Adapter);
-
-	for (eRFPath = 0; eRFPath < RF6052_MAX_PATH; eRFPath++) {
-		for (Offset = 0; Offset < maxReg; Offset++) {
-			/*  2008/11/20 MH For S3S4 test, we only check reg 26/27 now!!!! */
-			if (Offset != 0x26 && Offset != 0x27)
-				PHY_RFShadowCompareFlagSet(Adapter, eRFPath, Offset, false);
-			else
-				PHY_RFShadowCompareFlagSet(Adapter, eRFPath, Offset, true);
-		}
-	}
-
-}	/* PHY_RFShadowCompareFlagSetAll */
-- 
2.22.0

