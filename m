Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05333C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D425E20896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfDVSbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:31:11 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54920 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfDVSbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:31:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 88A1C1A0039;
        Mon, 22 Apr 2019 20:31:09 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D43C1A001C;
        Mon, 22 Apr 2019 20:31:09 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.32.93])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 762B240CB0;
        Mon, 22 Apr 2019 11:31:08 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Grant Likely <grant.likely@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH] arm64: defconfig: Enable FSL_EDMA driver
Date:   Mon, 22 Apr 2019 13:30:56 -0500
Message-Id: <20190422183056.16375-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the FSL EDMA driver by default.  This also works around an issue
that imx-i2c driver keeps deferring the probe because of the DMA is not
ready.  And currently the DMA engine framework can not correctly tell
if the DMA channels will truly become available later (it will never be
available if the DMA driver is not enabled).

This will cause indefinite messages like below:
[    3.335829] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
[    3.344455] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000 uOhm)
[    3.350917] lm90 0-004c: 0-004c supply vcc not found, using dummy regulator
[    3.362089] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
[    3.370741] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000 uOhm)
[    3.377205] lm90 0-004c: 0-004c supply vcc not found, using dummy regulator
[    3.388455] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
..... 

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..430e1d7e5497 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -617,6 +617,7 @@ CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
+CONFIG_FSL_EDMA=y
 CONFIG_DMA_BCM2835=m
 CONFIG_K3_DMA=y
 CONFIG_MV_XOR_V2=y
-- 
2.17.1

