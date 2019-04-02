Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B03C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234442133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfDBNkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43804 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731551AbfDBNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:14 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe7-0002oJ-C6; Tue, 02 Apr 2019 14:40:11 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0004um-PL; Tue, 02 Apr 2019 14:40:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms+renesas@verge.net.au>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.233472490@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 54/99] pinctrl: sh-pfc: sh7734: Fix shifted values in
 IPSR10
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 054f2400f706327f96770219c3065b5131f8f154 upstream.

Some values in the Peripheral Function Select Register 10 descriptor are
shifted by one position, which may cause a peripheral function to be
programmed incorrectly.

Fixing this makes all HSCIF0 pins use Function 4 (value 3), like was
already the case for the HSCK0 pin in field IP10[5:3].

Fixes: ac1ebc2190f575fc ("sh-pfc: Add sh7734 pinmux support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2218,22 +2218,22 @@ static const struct pinmux_cfg_reg pinmu
 	    /* IP10_22 [1] */
 		FN_CAN_CLK_A, FN_RX4_D,
 	    /* IP10_21_19 [3] */
-		FN_AUDIO_CLKOUT, FN_TX1_E, FN_HRTS0_C, FN_FSE_B,
-		FN_LCD_M_DISP_B, 0, 0, 0,
+		FN_AUDIO_CLKOUT, FN_TX1_E, 0, FN_HRTS0_C, FN_FSE_B,
+		FN_LCD_M_DISP_B, 0, 0,
 	    /* IP10_18_16 [3] */
-		FN_AUDIO_CLKC, FN_SCK1_E, FN_HCTS0_C, FN_FRB_B,
-		FN_LCD_VEPWC_B, 0, 0, 0,
+		FN_AUDIO_CLKC, FN_SCK1_E, 0, FN_HCTS0_C, FN_FRB_B,
+		FN_LCD_VEPWC_B, 0, 0,
 	    /* IP10_15 [1] */
 		FN_AUDIO_CLKB_A, FN_LCD_CLK_B,
 	    /* IP10_14_12 [3] */
 		FN_AUDIO_CLKA_A, FN_VI1_CLK_B, FN_SCK1_D, FN_IECLK_B,
 		FN_LCD_FLM_B, 0, 0, 0,
 	    /* IP10_11_9 [3] */
-		FN_SSI_SDATA3, FN_VI1_7_B, FN_HTX0_C, FN_FWE_B,
-		FN_LCD_CL2_B, 0, 0, 0,
+		FN_SSI_SDATA3, FN_VI1_7_B, 0, FN_HTX0_C, FN_FWE_B,
+		FN_LCD_CL2_B, 0, 0,
 	    /* IP10_8_6 [3] */
-		FN_SSI_SDATA2, FN_VI1_6_B, FN_HRX0_C, FN_FRE_B,
-		FN_LCD_CL1_B, 0, 0, 0,
+		FN_SSI_SDATA2, FN_VI1_6_B, 0, FN_HRX0_C, FN_FRE_B,
+		FN_LCD_CL1_B, 0, 0,
 	    /* IP10_5_3 [3] */
 		FN_SSI_WS23, FN_VI1_5_B, FN_TX1_D, FN_HSCK0_C, FN_FALE_B,
 		FN_LCD_DON_B, 0, 0,

