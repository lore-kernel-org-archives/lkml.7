Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAA6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BC42070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qN0UMeXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfCDWwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:52:17 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53671 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:52:15 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 308BB886BC;
        Tue,  5 Mar 2019 11:52:12 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551739932;
        bh=VgTLA33gxM/98byFUXDRiNDTZ0s+tOCQUcCQUzsG2Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qN0UMeXZwq0x4nIj+tjpp8/4D+Uon2V3U5fBUtiZ+1EW8XCApk7mPnD03DqhOyN4G
         TbhB2Oc9Z6z4Q88emAA8zcF8ayGRQZWZGNas6TIO5gPkFE47kZgIYD5bb6UIjwkQSR
         3DEGb/nziHkjjHJzqgKWzbPKho/qtMuG62619xYR5eDBxP3ipD/i2tdxh/aap6fEHv
         xkMf+pFzUbrpWL8NV11yy4vJyXfwxWshnYneXacVLFLpoVHR8YpSWAw/8/CqQxrgXe
         tT4wC+IoERJM0xRXPOt3HnsYdfh9HCc4/y45VvoHjGj1ZOhFR8Sy4XC8fQtwzx/YLn
         LH5taEOq99OBQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c7dac1a0001>; Tue, 05 Mar 2019 11:52:10 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 3DED513ED4A;
        Tue,  5 Mar 2019 11:52:12 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 010571E1D96; Tue,  5 Mar 2019 11:52:11 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        jason@lakedaemon.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] watchdog: orion_wdt: use timer1 as a pretimeout
Date:   Tue,  5 Mar 2019 11:51:52 +1300
Message-Id: <20190304225152.26831-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
References: <20190227230707.GA28635@roeck-us.net>
 <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The orion watchdog can either reset the CPU or generate an interrupt.
The interrupt would be useful for debugging as it provides panic()
output about the watchdog expiry, however if the interrupt is used the
watchdog can't reset the CPU in the event of being stuck in a loop with
interrupts disabled or if the CPU is prevented from accessing memory
(e.g. an unterminated DMA).

All of the orion based CPU cores (at least back as far as Kirkwood) have
spare timers that aren't currently used by the Linux kernel. We can use
timer1 to provide a pre-timeout ahead of the watchdog timer and provide
the possibility of gathering debug before the reset triggers.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-38x.dtsi |  1 +
 drivers/watchdog/orion_wdt.c      | 58 ++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada=
-38x.dtsi
index 929459c42760..fd0caa9714f2 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -376,6 +376,7 @@
 				reg =3D <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
 				clocks =3D <&coreclk 2>, <&refclk>;
 				clock-names =3D "nbclk", "fixed";
+				interrupts-extended =3D <&gic  GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>;
 			};
=20
 			cpurst: cpurst@20800 {
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 8b259c712c52..bf1dc75c2045 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -46,6 +46,10 @@
 #define WDT_AXP_FIXED_ENABLE_BIT BIT(10)
 #define WDT_A370_EXPIRED	BIT(31)
=20
+#define TIMER1_VAL_OFF		0x001c
+#define TIMER1_ENABLE_BIT	BIT(2)
+#define TIMER1_FIXED_ENABLE_BIT	BIT(12)
+
 static bool nowayout =3D WATCHDOG_NOWAYOUT;
 static int heartbeat =3D -1;		/* module parameter (seconds) */
=20
@@ -118,6 +122,7 @@ static int armada375_wdt_clock_init(struct platform_d=
evice *pdev,
 				    struct orion_watchdog *dev)
 {
 	int ret;
+	u32 val;
=20
 	dev->clk =3D of_clk_get_by_name(pdev->dev.of_node, "fixed");
 	if (!IS_ERR(dev->clk)) {
@@ -127,9 +132,8 @@ static int armada375_wdt_clock_init(struct platform_d=
evice *pdev,
 			return ret;
 		}
=20
-		atomic_io_modify(dev->reg + TIMER_CTRL,
-				WDT_AXP_FIXED_ENABLE_BIT,
-				WDT_AXP_FIXED_ENABLE_BIT);
+		val =3D WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT;
+		atomic_io_modify(dev->reg + TIMER_CTRL, val, val);
 		dev->clk_rate =3D clk_get_rate(dev->clk);
=20
 		return 0;
@@ -158,6 +162,7 @@ static int armadaxp_wdt_clock_init(struct platform_de=
vice *pdev,
 				   struct orion_watchdog *dev)
 {
 	int ret;
+	u32 val;
=20
 	dev->clk =3D of_clk_get_by_name(pdev->dev.of_node, "fixed");
 	if (IS_ERR(dev->clk))
@@ -169,38 +174,46 @@ static int armadaxp_wdt_clock_init(struct platform_=
device *pdev,
 	}
=20
 	/* Enable the fixed watchdog clock input */
-	atomic_io_modify(dev->reg + TIMER_CTRL,
-			 WDT_AXP_FIXED_ENABLE_BIT,
-			 WDT_AXP_FIXED_ENABLE_BIT);
+	val =3D WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, val, val);
=20
 	dev->clk_rate =3D clk_get_rate(dev->clk);
+
+
 	return 0;
 }
=20
 static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev =3D watchdog_get_drvdata(wdt_dev);
+
 	/* Reload watchdog duration */
 	writel(dev->clk_rate * wdt_dev->timeout,
 	       dev->reg + dev->data->wdt_counter_offset);
+	writel(dev->clk_rate * (wdt_dev->timeout - wdt_dev->pretimeout),
+	       dev->reg + TIMER1_VAL_OFF);
+
 	return 0;
 }
=20
 static int armada375_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev =3D watchdog_get_drvdata(wdt_dev);
-	u32 reg;
+	u32 reg, val;
=20
 	/* Set watchdog duration */
 	writel(dev->clk_rate * wdt_dev->timeout,
 	       dev->reg + dev->data->wdt_counter_offset);
+	if (wdt_dev->pretimeout)
+		writel(dev->clk_rate * (wdt_dev->timeout - wdt_dev->pretimeout),
+		       dev->reg + TIMER1_VAL_OFF);
=20
 	/* Clear the watchdog expiration bit */
 	atomic_io_modify(dev->reg + TIMER_A370_STATUS, WDT_A370_EXPIRED, 0);
=20
 	/* Enable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
-						dev->data->wdt_enable_bit);
+	val =3D dev->data->wdt_enable_bit | TIMER1_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, val, val);
=20
 	/* Enable reset on watchdog */
 	reg =3D readl(dev->rstout);
@@ -214,7 +227,7 @@ static int armada375_start(struct watchdog_device *wd=
t_dev)
 static int armada370_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev =3D watchdog_get_drvdata(wdt_dev);
-	u32 reg;
+	u32 reg, val;
=20
 	/* Set watchdog duration */
 	writel(dev->clk_rate * wdt_dev->timeout,
@@ -224,8 +237,8 @@ static int armada370_start(struct watchdog_device *wd=
t_dev)
 	atomic_io_modify(dev->reg + TIMER_A370_STATUS, WDT_A370_EXPIRED, 0);
=20
 	/* Enable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
-						dev->data->wdt_enable_bit);
+	val =3D dev->data->wdt_enable_bit | TIMER1_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, val, val);
=20
 	/* Enable reset on watchdog */
 	reg =3D readl(dev->rstout);
@@ -237,14 +250,15 @@ static int armada370_start(struct watchdog_device *=
wdt_dev)
 static int orion_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev =3D watchdog_get_drvdata(wdt_dev);
+	u32 val;
=20
 	/* Set watchdog duration */
 	writel(dev->clk_rate * wdt_dev->timeout,
 	       dev->reg + dev->data->wdt_counter_offset);
=20
 	/* Enable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit,
-						dev->data->wdt_enable_bit);
+	val =3D dev->data->wdt_enable_bit | TIMER1_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, val, val);
=20
 	/* Enable reset on watchdog */
 	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
@@ -264,12 +278,14 @@ static int orion_wdt_start(struct watchdog_device *=
wdt_dev)
 static int orion_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev =3D watchdog_get_drvdata(wdt_dev);
+	u32 mask;
=20
 	/* Disable reset on watchdog */
 	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit, 0);
=20
 	/* Disable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
+	mask =3D dev->data->wdt_enable_bit | TIMER1_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, mask, 0);
=20
 	return 0;
 }
@@ -277,7 +293,7 @@ static int orion_stop(struct watchdog_device *wdt_dev=
)
 static int armada375_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev =3D watchdog_get_drvdata(wdt_dev);
-	u32 reg;
+	u32 reg, mask;
=20
 	/* Disable reset on watchdog */
 	atomic_io_modify(dev->rstout_mask, dev->data->rstout_mask_bit,
@@ -287,7 +303,8 @@ static int armada375_stop(struct watchdog_device *wdt=
_dev)
 	writel(reg, dev->rstout);
=20
 	/* Disable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
+	mask =3D dev->data->wdt_enable_bit | TIMER1_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, mask, 0);
=20
 	return 0;
 }
@@ -295,7 +312,7 @@ static int armada375_stop(struct watchdog_device *wdt=
_dev)
 static int armada370_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev =3D watchdog_get_drvdata(wdt_dev);
-	u32 reg;
+	u32 reg, mask;
=20
 	/* Disable reset on watchdog */
 	reg =3D readl(dev->rstout);
@@ -303,7 +320,8 @@ static int armada370_stop(struct watchdog_device *wdt=
_dev)
 	writel(reg, dev->rstout);
=20
 	/* Disable watchdog timer */
-	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
+	mask =3D dev->data->wdt_enable_bit | TIMER1_ENABLE_BIT;
+	atomic_io_modify(dev->reg + TIMER_CTRL, mask, 0);
=20
 	return 0;
 }
@@ -350,7 +368,7 @@ static unsigned int orion_wdt_get_timeleft(struct wat=
chdog_device *wdt_dev)
 }
=20
 static const struct watchdog_info orion_wdt_info =3D {
-	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE =
| WDIOF_PRETIMEOUT,
 	.identity =3D "Orion Watchdog",
 };
=20
--=20
2.21.0

