Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32158C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143322070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKWUi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:38:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:34394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbfKWUiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 15:38:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84761B166;
        Sat, 23 Nov 2019 20:38:12 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 8/8] ARM: realtek: Enable RTD1195 arch timer
Date:   Sat, 23 Nov 2019 21:37:59 +0100
Message-Id: <20191123203759.20708-9-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191123203759.20708-1-afaerber@suse.de>
References: <20191123203759.20708-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this magic write the timer doesn't work and boot gets stuck.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 What is the name of the register 0xff018000?
 Is 0x1 a BIT(0) write, or how are the register bits defined?
 Is this a reset or a clock gate? How should we model it in DT?
 
 v3 -> v4:
 * Use writel_relaxed() instead of writel()
 
 v2 -> v3: Unchanged
 
 v2: New
 
 arch/arm/mach-realtek/rtd1195.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-realtek/rtd1195.c b/arch/arm/mach-realtek/rtd1195.c
index 0381a4447384..8d4de0c2308d 100644
--- a/arch/arm/mach-realtek/rtd1195.c
+++ b/arch/arm/mach-realtek/rtd1195.c
@@ -5,6 +5,9 @@
  * Copyright (c) 2017-2019 Andreas Färber
  */
 
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/io.h>
 #include <linux/memblock.h>
 #include <asm/mach/arch.h>
 
@@ -27,6 +30,18 @@ static void __init rtd1195_reserve(void)
 	rtd1195_memblock_remove(0x18100000, 0x01000000);
 }
 
+static void __init rtd1195_init_time(void)
+{
+	void __iomem *base;
+
+	base = ioremap(0xff018000, 4);
+	writel_relaxed(0x1, base);
+	iounmap(base);
+
+	of_clk_init(NULL);
+	timer_probe();
+}
+
 static const char *const rtd1195_dt_compat[] __initconst = {
 	"realtek,rtd1195",
 	NULL
@@ -34,6 +49,7 @@ static const char *const rtd1195_dt_compat[] __initconst = {
 
 DT_MACHINE_START(rtd1195, "Realtek RTD1195")
 	.dt_compat = rtd1195_dt_compat,
+	.init_time = rtd1195_init_time,
 	.reserve = rtd1195_reserve,
 	.l2c_aux_val = 0x0,
 	.l2c_aux_mask = ~0x0,
-- 
2.16.4

