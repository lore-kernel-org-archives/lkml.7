Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D01EECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABA720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfJJUa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:30:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40223 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfJJUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:30:57 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M76jv-1iA7xr2etz-008WlZ; Thu, 10 Oct 2019 22:30:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 01/36] ARM: samsung: make S3C24XX_MISCCR access indirect
Date:   Thu, 10 Oct 2019 22:29:45 +0200
Message-Id: <20191010203043.1241612-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010202802.1132272-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ePLzvj7/CcvBZWd9/hVzvTOtmqd1jBEPawLsZLAlTOvjHU9Blp0
 tvxX+UeVAWK0nrC7dGI+hFjF8ptcLrjrkZNrN1/uNRe+uaNHpuu2BxrAFpK9lILdg4Kj5GH
 JUyKX7A09rEBq4diiC18Z0WoqEb+HshWV0vBBd3lWJmlI9+0Kf3EIUQ1g4JogJyATj7uv+x
 eMo6Lt9LmrEqY9ZyRGCZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p+vtab0Sm4g=:GZ7JjxHd28lp/BUZHy55/p
 b9I5JvBFzQsD16r9zrfKLjJ5zalwgRAiq/aD/2IFvOdvFT72F5T/lS/DlazeTamoLZsSS/X04
 mKee0zxPCOxG1iYddhlMCoHPUsmBSRePPJIvvWvLhieiH9YW0+BlgMGVG/6Wr+IceowcHuRxZ
 yQHylOXnOnpDglBkIRt6/qpzw39wUuLc1zI6hrFH420KpQzYVrB5lJsaE/ojDI9RnzIky8U9G
 4fvej/0S799sglaZhKk1G0PSEKgYy8GJSBwrO1/urLdKdj/hxgOUaesBjta4gi7AFk3XNzxnK
 c6evzMifq7jGzWo48d+THy66ClEQuqbFZhxZEoQQLoYNka0K5pdwhgdMVevI4Zs4v5Pg04LlK
 X0MvJQ5fy8ogANXieli/NIJH15cHvdR4YuAT2hSdW+wCjNbJNQzO1CVSkPpxRQvxgXwQvNpaU
 TuOz6XyrB8bqiOdKiIWgi94Uc4Ts07dgo8znCybeGKJgKpJ75gfhCCrSR+xKs8DbJyopza9um
 Hv6aI1VN1XK1MJ06/ESbj+wrKSh9THAhq2P098AbLclaTHFYy4enQZQ9T5Te0tl+q+6/DueLe
 8CY4X3pswccFQeZtOtRqOLZ/AekCpg0LiFMi6TBAZYP1yz2lkYTmigk1LOKDqPApclK+8PoQ3
 87kIeHnio6OFfq5FCtr/hN4bwvr3ttcBvyd1tJdYKGk99bLPLRWK8cRwAmdbVCYlnNbslk9kw
 8u4vrXdL8NT3UWlX90wxJSbcUoKF9+lTxFan3Cuv4EVvPVlUsnYW/ckcLtE/FrNPVbHEORV+7
 3yoOX40qgdQvdqA4yek9OrFe07/3c1B0m5RpVzCb6JjARIHKrdj/tB7SbtKinMz6keJyuwGMl
 nMMhZ3QF99zmHauGWf8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk driver uses both a function call into an exported
platform file and a direct register access to a hardcoded
virtual address for accessing the MISCCR register, both
become are a problem for a multiplatform kernel because
of the header file dependency.

Make this an indirect function call through platform data
instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/common.c         |  3 +++
 drivers/clk/samsung/clk-s3c2410-dclk.c | 10 ++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 3dc029c2d2cb..ebf6bde67816 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -667,5 +667,8 @@ struct platform_device s3c2410_device_dclk = {
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s3c2410_dclk_resource),
 	.resource	= s3c2410_dclk_resource,
+	.dev		= {
+		.platform_data = s3c2410_modify_misccr,
+	},
 };
 #endif
diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 1281672cb00e..fbcec0252c45 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -14,10 +14,6 @@
 #include <linux/module.h>
 #include "clk.h"
 
-/* legacy access to misccr, until dt conversion is finished */
-#include <mach/hardware.h>
-#include <mach/regs-gpio.h>
-
 #define MUX_DCLK0	0
 #define MUX_DCLK1	1
 #define DIV_DCLK0	2
@@ -52,6 +48,7 @@ struct s3c24xx_clkout {
 	struct clk_hw		hw;
 	u32			mask;
 	u8			shift;
+	unsigned int (*modify_misccr)(unsigned int clr, unsigned int chg);
 };
 
 #define to_s3c24xx_clkout(_hw) container_of(_hw, struct s3c24xx_clkout, hw)
@@ -62,7 +59,7 @@ static u8 s3c24xx_clkout_get_parent(struct clk_hw *hw)
 	int num_parents = clk_hw_get_num_parents(hw);
 	u32 val;
 
-	val = readl_relaxed(S3C24XX_MISCCR) >> clkout->shift;
+	val = clkout->modify_misccr(0, 0) >> clkout->shift;
 	val >>= clkout->shift;
 	val &= clkout->mask;
 
@@ -76,7 +73,7 @@ static int s3c24xx_clkout_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct s3c24xx_clkout *clkout = to_s3c24xx_clkout(hw);
 
-	s3c2410_modify_misccr((clkout->mask << clkout->shift),
+	clkout->modify_misccr((clkout->mask << clkout->shift),
 			      (index << clkout->shift));
 
 	return 0;
@@ -110,6 +107,7 @@ static struct clk_hw *s3c24xx_register_clkout(struct device *dev,
 	clkout->shift = shift;
 	clkout->mask = mask;
 	clkout->hw.init = &init;
+	clkout->modify_misccr = dev->platform_data;
 
 	ret = clk_hw_register(dev, &clkout->hw);
 	if (ret)
-- 
2.20.0

