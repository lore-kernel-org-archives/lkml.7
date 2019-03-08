Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B18BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2231920851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfCHVHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:07:41 -0500
Received: from anholt.net ([50.246.234.109]:54376 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCHVHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:07:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4CA4510A2E2B;
        Fri,  8 Mar 2019 13:07:40 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zFAHRxYfKsnn; Fri,  8 Mar 2019 13:07:39 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3807310A2BEE;
        Fri,  8 Mar 2019 13:07:39 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id C85682FE4653; Fri,  8 Mar 2019 13:07:38 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH] arm64: bcm2835: Add missing dependency on MFD_CORE.
Date:   Fri,  8 Mar 2019 13:07:38 -0800
Message-Id: <20190308210738.10666-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding the MFD dependency for power domains and WDT in bcm2835, I
added it only on the arm32 side and missed it for arm64.

Fixes: 5e6acc3e678e ("bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.")
Signed-off-by: Eric Anholt <eric@anholt.net>
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
---

This fix is for the bcm2835-drivers-next branch that has been pulled
to Florian's drivers-next branch.

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf34cb02..50f9fb562059 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -27,6 +27,7 @@ config ARCH_BCM2835
 	bool "Broadcom BCM2835 family"
 	select TIMER_OF
 	select GPIOLIB
+	select MFD_CORE
 	select PINCTRL
 	select PINCTRL_BCM2835
 	select ARM_AMBA
-- 
2.20.1

