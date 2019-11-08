Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE8C17440
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B14214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfKHWlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:41:03 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51798 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfKHWlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:41:02 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 436B91A03DF;
        Fri,  8 Nov 2019 23:41:01 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A32A1A03CA;
        Fri,  8 Nov 2019 23:41:01 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2D4F140CB6;
        Fri,  8 Nov 2019 15:41:00 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, Biwen Li <biwen.li@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH] rtc: fsl-ftm-alarm: remove select FSL_RCPM and default y from Kconfig
Date:   Fri,  8 Nov 2019 16:40:56 -0600
Message-Id: <1573252856-11759-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Flextimer alarm is primarily used as a wakeup source for system
power management.  But it shouldn't select the power management driver
as they don't really have dependency of each other.

Also remove the default y as it is not a critical feature for the
systems.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/rtc/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 1adf9f815652..b33b80243143 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1337,8 +1337,6 @@ config RTC_DRV_IMXDI
 config RTC_DRV_FSL_FTM_ALARM
 	tristate "Freescale FlexTimer alarm timer"
 	depends on ARCH_LAYERSCAPE || SOC_LS1021A
-	select FSL_RCPM
-	default y
 	help
 	   For the FlexTimer in LS1012A, LS1021A, LS1028A, LS1043A, LS1046A,
 	   LS1088A, LS208xA, we can use FTM as the wakeup source.
-- 
2.17.1

