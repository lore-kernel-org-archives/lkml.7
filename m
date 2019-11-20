Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCF6222B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKTBmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:42:42 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:53632 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfKTBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:42:42 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAK1gKWO013363, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (ms1.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAK1gKWO013363
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 20 Nov 2019 09:42:22 +0800
Received: from localhost (172.29.40.150) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 09:40:07 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH v3] misc: rtsx: Fix impossible condition
Date:   Wed, 20 Nov 2019 09:40:06 +0800
Message-ID: <1574214006-13540-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

A u8 can only go up to 255, condition n > 396 is
impossible, so change u8 to u16.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
v3:remove useless cast.

 drivers/misc/cardreader/rts5261.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 32dcec2..bc4967a 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -628,7 +628,8 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		u8 ssc_depth, bool initial_mode, bool double_clk, bool vpclk)
 {
 	int err, clk;
-	u8 n, clk_divider, mcu_cnt, div;
+	u16 n;
+	u8 clk_divider, mcu_cnt, div;
 	static const u8 depth[] = {
 		[RTSX_SSC_DEPTH_4M] = RTS5261_SSC_DEPTH_4M,
 		[RTSX_SSC_DEPTH_2M] = RTS5261_SSC_DEPTH_2M,
@@ -661,13 +662,13 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		return 0;
 
 	if (pcr->ops->conv_clk_and_div_n)
-		n = (u8)pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
+		n = pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
 	else
-		n = (u8)(clk - 4);
+		n = clk - 4;
 	if ((clk <= 4) || (n > 396))
 		return -EINVAL;
 
-	mcu_cnt = (u8)(125/clk + 3);
+	mcu_cnt = 125/clk + 3;
 	if (mcu_cnt > 15)
 		mcu_cnt = 15;
 
@@ -676,7 +677,7 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		if (pcr->ops->conv_clk_and_div_n) {
 			int dbl_clk = pcr->ops->conv_clk_and_div_n(n,
 					DIV_N_TO_CLK) * 2;
-			n = (u8)pcr->ops->conv_clk_and_div_n(dbl_clk,
+			n = pcr->ops->conv_clk_and_div_n(dbl_clk,
 					CLK_TO_DIV_N);
 		} else {
 			n = (n + 4) * 2 - 4;
-- 
1.9.1

