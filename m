Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D040DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9466D20643
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ftqgoRyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfDEHyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:54:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1311 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729861AbfDEHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:53:59 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x357pFZj020168;
        Fri, 5 Apr 2019 09:53:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=zGDcTqkNrj1R4+LTGr3C2kM85QAdJ7nCCJf6AGnkc+k=;
 b=ftqgoRyUf2kopiopKBp4661iAlHMTd9mffDBuv+BhzvnAdmaYwNAjhH6ujh6u7Bs/Ldp
 1/DVod5cSf17AILIVA8MfOB5C8tC4JFmJmR+YpVAmFPxcDKtNibxUbbkt7KsggSYK2GQ
 PiYThJEgFXstviGYeGTpnAn+6Z+RXbm6r7+hjVdkg0UEyuM6XrDFzpyabO4meBZjqRcn
 6Fn07Dz8mYzMVhs5R9P1IHeQTe4qbxZP93xEgNsTBTcsHM5XQ+GtANiu6c3oOU6E//TC
 mAZidQ0yY3vWw95uC5XkeEZNAmxGIVAvk0A6U807Q5cPbh9V+Jl7yB9/AxjAmetVqhOZ VQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgevfrf4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 09:53:50 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC91938;
        Fri,  5 Apr 2019 07:53:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 778EA1E06;
        Fri,  5 Apr 2019 07:53:49 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr 2019 09:53:48
 +0200
From:   Gabriel Fernandez <gabriel.fernandez@st.com>
To:     michael turquette <mturquette@baylibre.com>,
        stephen boyd <sboyd@kernel.org>,
        rob herring <robh+dt@kernel.org>,
        mark rutland <mark.rutland@arm.com>,
        maxime coquelin <mcoquelin.stm32@gmail.com>,
        alexandre torgue <alexandre.torgue@st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH 1/2] clk: stm32: Introduce clocks of STM32F769 board
Date:   Fri, 5 Apr 2019 09:53:31 +0200
Message-ID: <20190405075332.28530-2-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405075332.28530-1-gabriel.fernandez@st.com>
References: <20190405075332.28530-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32F769 clocks are derived from STM32746 clocks.
main differences are:
- new source clock for SAI1 and SAI2 (HSI or HSE)
- Add DFSDM & DSI clocks

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 .../bindings/clock/st,stm32-rcc.txt           |   6 +
 drivers/clk/clk-stm32f4.c                     | 307 +++++++++++++++++-
 include/dt-bindings/clock/stm32fx-clock.h     |   7 +-
 3 files changed, 310 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
index b240121d2ac9..cfa04b614d8a 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
+++ b/Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
@@ -11,6 +11,8 @@ Required properties:
   "st,stm32f42xx-rcc"
   "st,stm32f469-rcc"
   "st,stm32f746-rcc"
+  "st,stm32f769-rcc"
+
 - reg: should be register base and length as documented in the
   datasheet
 - #reset-cells: 1, see below
@@ -102,6 +104,10 @@ The secondary index is bound with the following magic numbers:
 	28	CLK_I2C3
 	29	CLK_I2C4
 	30	CLK_LPTIMER	(LPTimer1 clock)
+	31	CLK_PLL_SRC
+	32	CLK_DFSDM1
+	33	CLK_ADFSDM1
+	34	CLK_F769_DSI
 )
 
 Example:
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index cdaa567c8042..fdac33a9be2f 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -300,6 +300,85 @@ static const struct stm32f4_gate_data stm32f746_gates[] __initconst = {
 	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
 };
 
+static const struct stm32f4_gate_data stm32f769_gates[] __initconst = {
+	{ STM32F4_RCC_AHB1ENR,  0,	"gpioa",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  1,	"gpiob",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  2,	"gpioc",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  3,	"gpiod",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  4,	"gpioe",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  5,	"gpiof",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  6,	"gpiog",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  7,	"gpioh",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  8,	"gpioi",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR,  9,	"gpioj",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 10,	"gpiok",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 12,	"crc",		"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 18,	"bkpsra",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 20,	"dtcmram",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 21,	"dma1",		"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 22,	"dma2",		"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 23,	"dma2d",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 25,	"ethmac",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 26,	"ethmactx",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 27,	"ethmacrx",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 28,	"ethmacptp",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 29,	"otghs",	"ahb_div" },
+	{ STM32F4_RCC_AHB1ENR, 30,	"otghsulpi",	"ahb_div" },
+
+	{ STM32F4_RCC_AHB2ENR,  0,	"dcmi",		"ahb_div" },
+	{ STM32F4_RCC_AHB2ENR,  1,	"jpeg",		"ahb_div" },
+	{ STM32F4_RCC_AHB2ENR,  4,	"cryp",		"ahb_div" },
+	{ STM32F4_RCC_AHB2ENR,  5,	"hash",		"ahb_div" },
+	{ STM32F4_RCC_AHB2ENR,  6,	"rng",		"pll48"   },
+	{ STM32F4_RCC_AHB2ENR,  7,	"otgfs",	"pll48"   },
+
+	{ STM32F4_RCC_AHB3ENR,  0,	"fmc",		"ahb_div",
+		CLK_IGNORE_UNUSED },
+	{ STM32F4_RCC_AHB3ENR,  1,	"qspi",		"ahb_div",
+		CLK_IGNORE_UNUSED },
+
+	{ STM32F4_RCC_APB1ENR,  0,	"tim2",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  1,	"tim3",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  2,	"tim4",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  3,	"tim5",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  4,	"tim6",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  5,	"tim7",		"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  6,	"tim12",	"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  7,	"tim13",	"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR,  8,	"tim14",	"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR, 10,	"rtcapb",	"apb1_mul" },
+	{ STM32F4_RCC_APB1ENR, 11,	"wwdg",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 13,	"can3",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 14,	"spi2",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 15,	"spi3",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 16,	"spdifrx",	"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 25,	"can1",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 26,	"can2",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 27,	"cec",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 28,	"pwr",		"apb1_div" },
+	{ STM32F4_RCC_APB1ENR, 29,	"dac",		"apb1_div" },
+
+	{ STM32F4_RCC_APB2ENR,  0,	"tim1",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR,  1,	"tim8",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR,  7,	"sdmmc2",	"sdmux2" },
+	{ STM32F4_RCC_APB2ENR,  8,	"adc1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR,  9,	"adc2",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 10,	"adc3",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 11,	"sdmmc1",	"sdmux1" },
+	{ STM32F4_RCC_APB2ENR, 12,	"spi1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 13,	"spi4",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 14,	"syscfg",	"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 16,	"tim9",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 17,	"tim10",	"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 18,	"tim11",	"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR, 20,	"spi5",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 21,	"spi6",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 22,	"sai1",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 23,	"sai2",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 26,	"ltdc",		"apb2_div" },
+	{ STM32F4_RCC_APB2ENR, 30,	"mdio",		"apb2_div" },
+};
+
 /*
  * This bitmask tells us which bit offsets (0..192) on STM32F4[23]xxx
  * have gate bits associated with them. Its combined hweight is 71.
@@ -318,6 +397,10 @@ static const u64 stm32f746_gate_map[MAX_GATE_MAP] = { 0x000000f17ef417ffull,
 						      0x0000000000000003ull,
 						      0x04f77f833e01c9ffull };
 
+static const u64 stm32f769_gate_map[MAX_GATE_MAP] = { 0x000000f37ef417ffull,
+						      0x0000000000000003ull,
+						      0x44F77F833E01EDFFull };
+
 static const u64 *stm32f4_gate_map;
 
 static struct clk_hw **clks;
@@ -1048,6 +1131,10 @@ static const char *rtc_parents[4] = {
 	"no-clock", "lse", "lsi", "hse-rtc"
 };
 
+static const char *pll_src = "pll-src";
+
+static const char *pllsrc_parent[2] = { "hsi", NULL };
+
 static const char *dsi_parent[2] = { NULL, "pll-r" };
 
 static const char *lcd_parent[1] = { "pllsai-r-div" };
@@ -1072,6 +1159,9 @@ static const char *uart_parents2[4] = { "apb1_div", "sys", "hsi", "lse" };
 
 static const char *i2c_parents[4] = { "apb1_div", "sys", "hsi", "no-clock" };
 
+static const char * const dfsdm1_src[] = { "apb2_div", "sys" };
+static const char * const adsfdm1_parent[] = { "sai1_clk", "sai2_clk" };
+
 struct stm32_aux_clk {
 	int idx;
 	const char *name;
@@ -1313,6 +1403,177 @@ static const struct stm32_aux_clk stm32f746_aux_clk[] = {
 	},
 };
 
+static const struct stm32_aux_clk stm32f769_aux_clk[] = {
+	{
+		CLK_LCD, "lcd-tft", lcd_parent, ARRAY_SIZE(lcd_parent),
+		NO_MUX, 0, 0,
+		STM32F4_RCC_APB2ENR, 26,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_I2S, "i2s", i2s_parents, ARRAY_SIZE(i2s_parents),
+		STM32F4_RCC_CFGR, 23, 1,
+		NO_GATE, 0,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_SAI1, "sai1_clk", sai_parents, ARRAY_SIZE(sai_parents),
+		STM32F4_RCC_DCKCFGR, 20, 3,
+		STM32F4_RCC_APB2ENR, 22,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_SAI2, "sai2_clk", sai_parents, ARRAY_SIZE(sai_parents),
+		STM32F4_RCC_DCKCFGR, 22, 3,
+		STM32F4_RCC_APB2ENR, 23,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		NO_IDX, "pll48", pll48_parents, ARRAY_SIZE(pll48_parents),
+		STM32F7_RCC_DCKCFGR2, 27, 1,
+		NO_GATE, 0,
+		0
+	},
+	{
+		NO_IDX, "sdmux1", sdmux_parents, ARRAY_SIZE(sdmux_parents),
+		STM32F7_RCC_DCKCFGR2, 28, 1,
+		NO_GATE, 0,
+		0
+	},
+	{
+		NO_IDX, "sdmux2", sdmux_parents, ARRAY_SIZE(sdmux_parents),
+		STM32F7_RCC_DCKCFGR2, 29, 1,
+		NO_GATE, 0,
+		0
+	},
+	{
+		CLK_HDMI_CEC, "hdmi-cec",
+		hdmi_parents, ARRAY_SIZE(hdmi_parents),
+		STM32F7_RCC_DCKCFGR2, 26, 1,
+		NO_GATE, 0,
+		0
+	},
+	{
+		CLK_SPDIF, "spdif-rx",
+		spdif_parent, ARRAY_SIZE(spdif_parent),
+		STM32F7_RCC_DCKCFGR2, 22, 3,
+		STM32F4_RCC_APB2ENR, 23,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_USART1, "usart1",
+		uart_parents1, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 0, 3,
+		STM32F4_RCC_APB2ENR, 4,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_USART2, "usart2",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 2, 3,
+		STM32F4_RCC_APB1ENR, 17,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_USART3, "usart3",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 4, 3,
+		STM32F4_RCC_APB1ENR, 18,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_UART4, "uart4",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 6, 3,
+		STM32F4_RCC_APB1ENR, 19,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_UART5, "uart5",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 8, 3,
+		STM32F4_RCC_APB1ENR, 20,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_USART6, "usart6",
+		uart_parents1, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 10, 3,
+		STM32F4_RCC_APB2ENR, 5,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_UART7, "uart7",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 12, 3,
+		STM32F4_RCC_APB1ENR, 30,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_UART8, "uart8",
+		uart_parents2, ARRAY_SIZE(uart_parents1),
+		STM32F7_RCC_DCKCFGR2, 14, 3,
+		STM32F4_RCC_APB1ENR, 31,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_I2C1, "i2c1",
+		i2c_parents, ARRAY_SIZE(i2c_parents),
+		STM32F7_RCC_DCKCFGR2, 16, 3,
+		STM32F4_RCC_APB1ENR, 21,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_I2C2, "i2c2",
+		i2c_parents, ARRAY_SIZE(i2c_parents),
+		STM32F7_RCC_DCKCFGR2, 18, 3,
+		STM32F4_RCC_APB1ENR, 22,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_I2C3, "i2c3",
+		i2c_parents, ARRAY_SIZE(i2c_parents),
+		STM32F7_RCC_DCKCFGR2, 20, 3,
+		STM32F4_RCC_APB1ENR, 23,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_I2C4, "i2c4",
+		i2c_parents, ARRAY_SIZE(i2c_parents),
+		STM32F7_RCC_DCKCFGR2, 22, 3,
+		STM32F4_RCC_APB1ENR, 24,
+		CLK_SET_RATE_PARENT,
+	},
+	{
+		CLK_LPTIMER, "lptim1",
+		lptim_parent, ARRAY_SIZE(lptim_parent),
+		STM32F7_RCC_DCKCFGR2, 24, 3,
+		STM32F4_RCC_APB1ENR, 9,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_F769_DSI, "dsi",
+		dsi_parent, ARRAY_SIZE(dsi_parent),
+		STM32F7_RCC_DCKCFGR2, 0, 1,
+		STM32F4_RCC_APB2ENR, 27,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_DFSDM1, "dfsdm1",
+		dfsdm1_src, ARRAY_SIZE(dfsdm1_src),
+		STM32F4_RCC_DCKCFGR, 25, 1,
+		STM32F4_RCC_APB2ENR, 29,
+		CLK_SET_RATE_PARENT
+	},
+	{
+		CLK_ADFSDM1, "adfsdm1",
+		adsfdm1_parent, ARRAY_SIZE(adsfdm1_parent),
+		STM32F4_RCC_DCKCFGR, 26, 1,
+		STM32F4_RCC_APB2ENR, 29,
+		CLK_SET_RATE_PARENT
+	},
+};
+
 static const struct stm32f4_clk_data stm32f429_clk_data = {
 	.end_primary	= END_PRIMARY_CLK,
 	.gates_data	= stm32f429_gates,
@@ -1343,6 +1604,16 @@ static const struct stm32f4_clk_data stm32f746_clk_data = {
 	.aux_clk_num	= ARRAY_SIZE(stm32f746_aux_clk),
 };
 
+static const struct stm32f4_clk_data stm32f769_clk_data = {
+	.end_primary	= END_PRIMARY_CLK_F7,
+	.gates_data	= stm32f769_gates,
+	.gates_map	= stm32f769_gate_map,
+	.gates_num	= ARRAY_SIZE(stm32f769_gates),
+	.pll_data	= stm32f469_pll,
+	.aux_clk	= stm32f769_aux_clk,
+	.aux_clk_num	= ARRAY_SIZE(stm32f769_aux_clk),
+};
+
 static const struct of_device_id stm32f4_of_match[] = {
 	{
 		.compatible = "st,stm32f42xx-rcc",
@@ -1356,6 +1627,10 @@ static const struct of_device_id stm32f4_of_match[] = {
 		.compatible = "st,stm32f746-rcc",
 		.data = &stm32f746_clk_data
 	},
+	{
+		.compatible = "st,stm32f769-rcc",
+		.data = &stm32f769_clk_data
+	},
 	{}
 };
 
@@ -1427,9 +1702,8 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	int n;
 	const struct of_device_id *match;
 	const struct stm32f4_clk_data *data;
-	unsigned long pllcfgr;
-	const char *pllsrc;
 	unsigned long pllm;
+	struct clk_hw *pll_src_hw;
 
 	base = of_iomap(np, 0);
 	if (!base) {
@@ -1460,21 +1734,33 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 
 	hse_clk = of_clk_get_parent_name(np, 0);
 	dsi_parent[0] = hse_clk;
+	pllsrc_parent[1] = hse_clk;
 
 	i2s_in_clk = of_clk_get_parent_name(np, 1);
 
 	i2s_parents[1] = i2s_in_clk;
 	sai_parents[2] = i2s_in_clk;
 
+	if (of_device_is_compatible(np, "st,stm32f769-rcc")) {
+		clk_hw_register_gate(NULL, "dfsdm1_apb", "apb2_div", 0,
+				     base + STM32F4_RCC_APB2ENR, 29,
+				     CLK_IGNORE_UNUSED, &stm32f4_clk_lock);
+		dsi_parent[0] = pll_src;
+		sai_parents[3] = pll_src;
+	}
+
 	clks[CLK_HSI] = clk_hw_register_fixed_rate_with_accuracy(NULL, "hsi",
 			NULL, 0, 16000000, 160000);
 
-	pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
-	pllsrc = pllcfgr & BIT(22) ? hse_clk : "hsi";
-	pllm = pllcfgr & 0x3f;
+	pll_src_hw = clk_hw_register_mux(NULL, pll_src, pllsrc_parent,
+					 ARRAY_SIZE(pllsrc_parent), 0,
+					 base + STM32F4_RCC_PLLCFGR, 22, 1, 0,
+					 &stm32f4_clk_lock);
+
+	pllm = readl(base + STM32F4_RCC_PLLCFGR) & 0x3f;
 
-	clk_hw_register_fixed_factor(NULL, "vco_in", pllsrc,
-					       0, 1, pllm);
+	clk_hw_register_fixed_factor(NULL, "vco_in", pll_src,
+				     0, 1, pllm);
 
 	stm32f4_rcc_register_pll("vco_in", &data->pll_data[0],
 			&stm32f4_clk_lock);
@@ -1612,12 +1898,16 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 			clks[aux_clk->idx] = hw;
 	}
 
-	if (of_device_is_compatible(np, "st,stm32f746-rcc"))
+	if (of_device_is_compatible(np, "st,stm32f746-rcc")) {
 
 		clk_hw_register_fixed_factor(NULL, "hsi_div488", "hsi", 0,
 				1, 488);
 
+		clks[CLK_PLL_SRC] = pll_src_hw;
+	}
+
 	of_clk_add_hw_provider(np, stm32f4_rcc_lookup_clk, NULL);
+
 	return;
 fail:
 	kfree(clks);
@@ -1626,3 +1916,4 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 CLK_OF_DECLARE_DRIVER(stm32f42xx_rcc, "st,stm32f42xx-rcc", stm32f4_rcc_init);
 CLK_OF_DECLARE_DRIVER(stm32f46xx_rcc, "st,stm32f469-rcc", stm32f4_rcc_init);
 CLK_OF_DECLARE_DRIVER(stm32f746_rcc, "st,stm32f746-rcc", stm32f4_rcc_init);
+CLK_OF_DECLARE_DRIVER(stm32f769_rcc, "st,stm32f769-rcc", stm32f4_rcc_init);
diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
index 58d8b515be55..7d34e297049c 100644
--- a/include/dt-bindings/clock/stm32fx-clock.h
+++ b/include/dt-bindings/clock/stm32fx-clock.h
@@ -54,7 +54,10 @@
 #define CLK_I2C3		28
 #define CLK_I2C4		29
 #define CLK_LPTIMER		30
-
-#define END_PRIMARY_CLK_F7	31
+#define CLK_PLL_SRC		31
+#define CLK_DFSDM1		32
+#define CLK_ADFSDM1		33
+#define CLK_F769_DSI		34
+#define END_PRIMARY_CLK_F7	35
 
 #endif
-- 
2.17.1

