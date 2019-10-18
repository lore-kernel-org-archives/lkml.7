Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C75CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658E0222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505450AbfJRPoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:44:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505173AbfJRPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:42 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKKhF-1icBMt0kyF-00Lr5G; Fri, 18 Oct 2019 17:42:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 36/46] ARM: pxa: move smemc register access from clk to platform
Date:   Fri, 18 Oct 2019 17:41:51 +0200
Message-Id: <20191018154201.1276638-36-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vefQot4mM/0/KYwj0mbh8WEhS5x+08tf6SqzVPoLMRckoj1TaZG
 Vmi0PsagSv/2LRwp0sEc+15xtovMNpgpDoqj8Bg8w3FKPpRM3FaM/xK4YDBqW1mAr2iC4Rq
 AiDCa5KPtF5teLtE0M65WNK44qdFPc8+SSEwZIYMoWc0g8TdkAHDoZQyXsucZjAj7qdMz9i
 RvMJQMVmXQAahPjTwh6sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pA+dVlrwV1Y=:ui1MqPPZZTimHhl5Pkc88T
 YvCNDWJkOYT6V684/HX74gsOM3kj0MDIFSzoZmPi5j/uhdjs0lf6+16XWWpZW2op20dkU01yz
 +nyVeU1wl8H9GdipDrpil7co63x9SvYYVhbrY8sP+p75rDJ5iz5hTu8UWaGR3l1YI0lO2igRv
 SCv1ZRQtoNPZLjrZ6CutMKa+o2FhZOX+1pbMacYUc29ue6WqbWgUU5xv+3znie6SWYTET5nOA
 yxhOQ+CPBIZu/AG0gRSGCif1j2+5tz9PbN51RpwPe9I08vaYpFNMxbitng33XPlOUy6u5kGTA
 PmTvcXnoDi/CXigGRbCTJBK/sbJGm+w36Qaxiz2/DmJrAhavsyql2nr4IZv+fpqhfwdK761T9
 0Lhn1q5N3zmdHf3Zf5vm2ARavMMa01SHTUruKTygxKojTyMr8VjiQ5zYIWJ45AO3JO8XGu9NE
 OrpnHVyKvSAaMaF/uWUSlRcyP1PGPrOkkDhF1pvOTKSoa161rZVUrZJV9OnQkoJgswWGdRxTU
 HXVPgcen+NdiWlHrcAmNcOw9uoO11p8tzFtILlaxe6vS4lTJSqJiVtsIDL8sydcEoljIzRui7
 e5ZxB5Vc4U69NZkJ1qAhWQBeQOhamWwt/C0PEiCoGtnExAm0xPxBr6Q8XmeNblO4089g0j6vI
 zQ7OTQuEUn0gJwUt09q2kBaji2oFs+Bd1Msf+PqhXStsUnkw+k62dw4YeLUZBk/4U9reo0f7e
 XBIisssmryIlx+n5PgX3J+VkGa6J+mMoGTpX50lkaJJYqAU9TtFTdrLrmXw+BqicOKiUgafrX
 nf09M8phDFe9EcFGZjt8gHqKdzIZQrlUb0mp2vyXLUlGdnFQk2a+G5iI7VhheFsKdgGd1EJ7b
 MDs1597H9aZS/zUGSOoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_sdram_rows() and get_memclkdiv() helpers need smemc
register that are separate from the clk registers, move
them out of the clk driver, and use an extern declaration
instead.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/generic.c   | 30 ++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa3xx.c    |  4 ++++
 arch/arm/mach-pxa/smemc.c     |  9 +++++++++
 drivers/clk/pxa/clk-pxa.c     |  4 +++-
 drivers/clk/pxa/clk-pxa.h     |  5 +++--
 drivers/clk/pxa/clk-pxa25x.c  | 30 +++---------------------------
 drivers/clk/pxa/clk-pxa27x.c  | 31 +++----------------------------
 drivers/clk/pxa/clk-pxa3xx.c  |  8 +++-----
 include/linux/soc/pxa/smemc.h |  3 +++
 9 files changed, 61 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 2c2c82fcf9cb..942af8946a73 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/soc/pxa/cpu.h>
+#include <linux/soc/pxa/smemc.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
@@ -84,6 +85,35 @@ void pxa_smemc_set_pcmcia_socket(int nr)
 }
 EXPORT_SYMBOL_GPL(pxa_smemc_set_pcmcia_socket);
 
+#define MDCNFG_DRAC2(mdcnfg)	(((mdcnfg) >> 21) & 0x3)
+#define MDCNFG_DRAC0(mdcnfg)	(((mdcnfg) >> 5) & 0x3)
+
+int pxa_smemc_get_sdram_rows(void)
+{
+	static int sdram_rows;
+	unsigned int drac2 = 0, drac0 = 0;
+	u32 mdcnfg;
+
+	if (sdram_rows)
+		return sdram_rows;
+
+	mdcnfg = readl_relaxed(MDCNFG);
+
+	if (mdcnfg & (MDCNFG_DE2 | MDCNFG_DE3))
+		drac2 = MDCNFG_DRAC2(mdcnfg);
+
+	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
+		drac0 = MDCNFG_DRAC0(mdcnfg);
+
+	sdram_rows = 1 << (11 + max(drac0, drac2));
+	return sdram_rows;
+}
+
+void __iomem *pxa_smemc_get_mdrefr(void)
+{
+	return MDREFR;
+}
+
 /*
  * Intel PXA2xx internal register mapping.
  *
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index f4657f4edb3b..d486efb79dcd 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -52,6 +52,10 @@ extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
 #define NDCR_ND_ARB_EN		(1 << 12)
 #define NDCR_ND_ARB_CNTL	(1 << 19)
 
+#define CKEN_BOOT  		11      /* < Boot rom clock enable */
+#define CKEN_TPM   		19      /* < TPM clock enable */
+#define CKEN_HSIO2 		41      /* < HSIO2 clock enable */
+
 #ifdef CONFIG_PM
 
 #define ISRAM_START	0x5c000000
diff --git a/arch/arm/mach-pxa/smemc.c b/arch/arm/mach-pxa/smemc.c
index 47b99549d616..da0eeafdb5a0 100644
--- a/arch/arm/mach-pxa/smemc.c
+++ b/arch/arm/mach-pxa/smemc.c
@@ -69,4 +69,13 @@ static int __init smemc_init(void)
 	return 0;
 }
 subsys_initcall(smemc_init);
+
 #endif
+
+static const unsigned int df_clkdiv[4] = { 1, 2, 4, 1 };
+unsigned int pxa3xx_smemc_get_memclkdiv(void)
+{
+	unsigned long memclkcfg = __raw_readl(MEMCLKCFG);
+
+	return	df_clkdiv[(memclkcfg >> 16) & 0x3];
+}
diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index cfc79f942b07..831180360069 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -11,6 +11,7 @@
 #include <linux/clkdev.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/soc/pxa/smemc.h>
 
 #include <dt-bindings/clock/pxa-clock.h>
 #include "clk-pxa.h"
@@ -150,12 +151,13 @@ void pxa2xx_core_turbo_switch(bool on)
 }
 
 void pxa2xx_cpll_change(struct pxa2xx_freq *freq,
-			u32 (*mdrefr_dri)(unsigned int), void __iomem *mdrefr,
+			u32 (*mdrefr_dri)(unsigned int),
 			void __iomem *cccr)
 {
 	unsigned int clkcfg = freq->clkcfg;
 	unsigned int unused, preset_mdrefr, postset_mdrefr;
 	unsigned long flags;
+	void __iomem *mdrefr = pxa_smemc_get_mdrefr();
 
 	local_irq_save(flags);
 
diff --git a/drivers/clk/pxa/clk-pxa.h b/drivers/clk/pxa/clk-pxa.h
index f131d2834af4..d81fbec42004 100644
--- a/drivers/clk/pxa/clk-pxa.h
+++ b/drivers/clk/pxa/clk-pxa.h
@@ -146,12 +146,13 @@ static inline int dummy_clk_set_parent(struct clk_hw *hw, u8 index)
 
 extern void clkdev_pxa_register(int ckid, const char *con_id,
 				const char *dev_id, struct clk *clk);
-extern int clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks);
+extern int clk_pxa_cken_init(const struct desc_clk_cken *clks,
+			     int nb_clks);
 void clk_pxa_dt_common_init(struct device_node *np);
 
 void pxa2xx_core_turbo_switch(bool on);
 void pxa2xx_cpll_change(struct pxa2xx_freq *freq,
-			u32 (*mdrefr_dri)(unsigned int), void __iomem *mdrefr,
+			u32 (*mdrefr_dri)(unsigned int),
 			void __iomem *cccr);
 int pxa2xx_determine_rate(struct clk_rate_request *req,
 			  struct pxa2xx_freq *freqs,  int nb_freqs);
diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index d0f957996acb..65807f000c6a 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -15,7 +15,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <mach/pxa2xx-regs.h>
-#include <mach/smemc.h>
+#include <linux/soc/pxa/smemc.h>
 
 #include <dt-bindings/clock/pxa-clock.h>
 #include "clk-pxa.h"
@@ -33,9 +33,6 @@ enum {
 	 ((T) ? CLKCFG_TURBO : 0))
 #define PXA25x_CCCR(N2, M, L) (N2 << 7 | M << 5 | L)
 
-#define MDCNFG_DRAC2(mdcnfg)	(((mdcnfg) >> 21) & 0x3)
-#define MDCNFG_DRAC0(mdcnfg)	(((mdcnfg) >> 5) & 0x3)
-
 /* Define the refresh period in mSec for the SDRAM and the number of rows */
 #define SDRAM_TREF	64	/* standard 64ms SDRAM */
 
@@ -57,30 +54,9 @@ static const char * const get_freq_khz[] = {
 	"core", "run", "cpll", "memory"
 };
 
-static int get_sdram_rows(void)
-{
-	static int sdram_rows;
-	unsigned int drac2 = 0, drac0 = 0;
-	u32 mdcnfg;
-
-	if (sdram_rows)
-		return sdram_rows;
-
-	mdcnfg = readl_relaxed(MDCNFG);
-
-	if (mdcnfg & (MDCNFG_DE2 | MDCNFG_DE3))
-		drac2 = MDCNFG_DRAC2(mdcnfg);
-
-	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
-		drac0 = MDCNFG_DRAC0(mdcnfg);
-
-	sdram_rows = 1 << (11 + max(drac0, drac2));
-	return sdram_rows;
-}
-
 static u32 mdrefr_dri(unsigned int freq_khz)
 {
-	u32 interval = freq_khz * SDRAM_TREF / get_sdram_rows();
+	u32 interval = freq_khz * SDRAM_TREF / pxa_smemc_get_sdram_rows();
 
 	return interval / 32;
 }
@@ -268,7 +244,7 @@ static int clk_pxa25x_cpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (i >= ARRAY_SIZE(pxa25x_freqs))
 		return -EINVAL;
 
-	pxa2xx_cpll_change(&pxa25x_freqs[i], mdrefr_dri, MDREFR, CCCR);
+	pxa2xx_cpll_change(&pxa25x_freqs[i], mdrefr_dri, CCCR);
 
 	return 0;
 }
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 287fdeae7c7c..eac67d425bee 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -12,8 +12,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/of.h>
-
-#include <mach/smemc.h>
+#include <linux/soc/pxa/smemc.h>
 
 #include <dt-bindings/clock/pxa-clock.h>
 #include "clk-pxa.h"
@@ -50,9 +49,6 @@ enum {
 	 ((T)  ? CLKCFG_TURBO : 0))
 #define PXA27x_CCCR(A, L, N2) (A << 25 | N2 << 7 | L)
 
-#define MDCNFG_DRAC2(mdcnfg)	(((mdcnfg) >> 21) & 0x3)
-#define MDCNFG_DRAC0(mdcnfg)	(((mdcnfg) >> 5) & 0x3)
-
 /* Define the refresh period in mSec for the SDRAM and the number of rows */
 #define SDRAM_TREF	64	/* standard 64ms SDRAM */
 
@@ -61,30 +57,9 @@ static const char * const get_freq_khz[] = {
 	"system_bus"
 };
 
-static int get_sdram_rows(void)
-{
-	static int sdram_rows;
-	unsigned int drac2 = 0, drac0 = 0;
-	u32 mdcnfg;
-
-	if (sdram_rows)
-		return sdram_rows;
-
-	mdcnfg = readl_relaxed(MDCNFG);
-
-	if (mdcnfg & (MDCNFG_DE2 | MDCNFG_DE3))
-		drac2 = MDCNFG_DRAC2(mdcnfg);
-
-	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
-		drac0 = MDCNFG_DRAC0(mdcnfg);
-
-	sdram_rows = 1 << (11 + max(drac0, drac2));
-	return sdram_rows;
-}
-
 static u32 mdrefr_dri(unsigned int freq_khz)
 {
-	u32 interval = freq_khz * SDRAM_TREF / get_sdram_rows();
+	u32 interval = freq_khz * SDRAM_TREF / pxa_smemc_get_sdram_rows();
 
 	return (interval - 31) / 32;
 }
@@ -260,7 +235,7 @@ static int clk_pxa27x_cpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (i >= ARRAY_SIZE(pxa27x_freqs))
 		return -EINVAL;
 
-	pxa2xx_cpll_change(&pxa27x_freqs[i], mdrefr_dri, MDREFR, CCCR);
+	pxa2xx_cpll_change(&pxa27x_freqs[i], mdrefr_dri, CCCR);
 	return 0;
 }
 
diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 60a0db4f3790..08594fc899e2 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -15,7 +15,7 @@
 #include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/soc/pxa/cpu.h>
-#include <mach/smemc.h>
+#include <linux/soc/pxa/smemc.h>
 #include <linux/clk/pxa.h>
 #include <mach/pxa3xx-regs.h>
 
@@ -41,8 +41,6 @@ static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
 
 /* crystal frequency to static memory controller multiplier (SMCFS) */
 static unsigned int smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
-static unsigned int df_clkdiv[4] = { 1, 2, 4, 1 };
-
 static const char * const get_freq_khz[] = {
 	"core", "ring_osc_60mhz", "run", "cpll", "system_bus"
 };
@@ -118,10 +116,10 @@ static unsigned long clk_pxa3xx_smemc_get_rate(struct clk_hw *hw,
 					      unsigned long parent_rate)
 {
 	unsigned long acsr = ACSR;
-	unsigned long memclkcfg = __raw_readl(MEMCLKCFG);
 
 	return (parent_rate / 48)  * smcfs_mult[(acsr >> 23) & 0x7] /
-		df_clkdiv[(memclkcfg >> 16) & 0x3];
+		pxa3xx_smemc_get_memclkdiv();
+
 }
 PARENTS(clk_pxa3xx_smemc) = { "spll_624mhz" };
 RATE_RO_OPS(clk_pxa3xx_smemc, "smemc");
diff --git a/include/linux/soc/pxa/smemc.h b/include/linux/soc/pxa/smemc.h
index cbf1a2d8af29..9283e5642b19 100644
--- a/include/linux/soc/pxa/smemc.h
+++ b/include/linux/soc/pxa/smemc.h
@@ -6,5 +6,8 @@
 
 void pxa_smemc_set_pcmcia_timing(int sock, u32 mcmem, u32 mcatt, u32 mcio);
 void pxa_smemc_set_pcmcia_socket(int nr);
+int pxa_smemc_get_sdram_rows(void);
+unsigned int pxa3xx_smemc_get_memclkdiv(void);
+void __iomem *pxa_smemc_get_mdrefr(void);
 
 #endif
-- 
2.20.0

