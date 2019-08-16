Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41873C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2A2206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfHPODI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:03:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbfHPODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:03:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A93EDD54471FD4DF712A;
        Fri, 16 Aug 2019 22:02:40 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 22:02:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregory.clement@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: armada-xp: remove unused code
Date:   Fri, 16 Aug 2019 22:02:00 +0800
Message-ID: <20190816140200.55040-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/mvebu/armada-xp.c:171:38: warning:
 mv98dx3236_coreclks defined but not used [-Wunused-const-variable=]
drivers/clk/mvebu/armada-xp.c:213:41: warning:
 mv98dx3236_gating_desc defined but not used [-Wunused-const-variable=]

They are never used, so can be remove. Also remove
the related functions.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/mvebu/armada-xp.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index fa15682..4566565 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -50,12 +50,6 @@ static u32 __init axp_get_tclk_freq(void __iomem *sar)
 	return 250000000;
 }
 
-/* MV98DX3236 TCLK frequency is fixed to 200MHz */
-static u32 __init mv98dx3236_get_tclk_freq(void __iomem *sar)
-{
-	return 200000000;
-}
-
 static const u32 axp_cpu_freqs[] __initconst = {
 	1000000000,
 	1066000000,
@@ -93,12 +87,6 @@ static u32 __init axp_get_cpu_freq(void __iomem *sar)
 	return cpu_freq;
 }
 
-/* MV98DX3236 CLK frequency is fixed to 800MHz */
-static u32 __init mv98dx3236_get_cpu_freq(void __iomem *sar)
-{
-	return 800000000;
-}
-
 static const int axp_nbclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 2}, {2, 2},
 	{1, 2}, {1, 2}, {1, 1}, {2, 3},
@@ -168,11 +156,6 @@ static const struct coreclk_soc_desc axp_coreclks = {
 	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
 };
 
-static const struct coreclk_soc_desc mv98dx3236_coreclks = {
-	.get_tclk_freq = mv98dx3236_get_tclk_freq,
-	.get_cpu_freq = mv98dx3236_get_cpu_freq,
-};
-
 /*
  * Clock Gating Control
  */
@@ -210,15 +193,6 @@ static const struct clk_gating_soc_desc axp_gating_desc[] __initconst = {
 	{ }
 };
 
-static const struct clk_gating_soc_desc mv98dx3236_gating_desc[] __initconst = {
-	{ "ge1", NULL, 3, 0 },
-	{ "ge0", NULL, 4, 0 },
-	{ "pex00", NULL, 5, 0 },
-	{ "sdio", NULL, 17, 0 },
-	{ "xor0", NULL, 22, 0 },
-	{ }
-};
-
 static void __init axp_clk_init(struct device_node *np)
 {
 	struct device_node *cgnp =
-- 
2.7.4


