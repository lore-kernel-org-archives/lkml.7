Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF4C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BC72073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZICkPQ0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLJJRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:17:19 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50741 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfLJJRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:17:19 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xBA9F3nk002286;
        Tue, 10 Dec 2019 18:15:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xBA9F3nk002286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575969304;
        bh=fZSJ9406U2jMjTj0MJPsSAKAuiCbOY7z777j3BlnS64=;
        h=From:To:Cc:Subject:Date:From;
        b=ZICkPQ0qlKaZ5gvesye64Ajer4Y29LiQHJTthQMyXqWchv1Oz6XlkHQGYD46IHJVb
         oETXHqu+ORXaEeG2zHFMNaJ8eoHO2Vw5BKDohlNsjkKWCdgyYpZPX2e8Y5c05iVQ+J
         lpEEVP48mVGbii42pFZXO41SCVxny/qq5XKolD5ekOkNNKd+jsgDOFzwHfL46T1QbH
         EciXXoHdlaw8FYEn/Qg/Q4d4FhPPrRvw7TM4vumikxXMK6F/dUBL9xdOL3tkht9bc4
         b+iqdsdNEcaOtiy//c13esKtEgHx/A0AvXUDXTgL4nXUWmmHGDA+5F6DeMQ94K1nGw
         HD1IxhqkAZl8Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: denali: add reset controlling
Date:   Tue, 10 Dec 2019 18:14:53 +0900
Message-Id: <20191210091453.26346-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Denali User's Guide, this IP has two reset signals.

  rst_n:     reset most of FFs in the controller core
  reg_rst_n: reset all FFs in the register interface, and in the
             initialization sequence

This commit supports controlling those reset signals, although they
might be often tied up together in actual SoC integration.

One thing that should be kept in mind is the automated initialization
sequence (a.k.a. 'bootstrap' process) is kicked off when reg_rst_n is
deasserted.

When the reset is deasserted, the controller issues a RESET command
to the chip select 0, and attempts to read out the chip ID, and further
more, ONFI parameters if it is an ONFI-compliant device. Then, the
controller sets up the relevant registers based on the detected
device parameters.

This process is just redundant for Linux because nand_scan_ident()
probes devices and sets up parameters accordingly. Rather, this hardware
feature is annoying because it ends up with misdetection due to bugs.

So, commit 0615e7ad5d52 ("mtd: nand: denali: remove Toshiba and Hynix
specific fixup code") changed the driver to not rely on it.

However, there is no way to prevent it from running. The IP provides
the 'bootstrap_inhibit_init' port to suppress this sequence, but it is
usually out of software control, and dependent on SoC implementation.
As for the Socionext UniPhier platform, LD4 always enables it. For the
later SoCs, the bootstrap sequence runs depending on the boot mode.

I added usleep_range() to make the driver wait until the sequence
finishes. Otherwise, the driver would fail to detect the chip due
to the race between the driver and hardware-controlled sequence.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/mtd/denali-nand.txt   |  7 ++++
 drivers/mtd/nand/raw/denali_dt.c              | 40 ++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/denali-nand.txt b/Documentation/devicetree/bindings/mtd/denali-nand.txt
index b32aed1db46d..a48b17fb969a 100644
--- a/Documentation/devicetree/bindings/mtd/denali-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/denali-nand.txt
@@ -14,6 +14,11 @@ Required properties:
     interface clock, and the ECC circuit clock.
   - clock-names: should contain "nand", "nand_x", "ecc"
 
+Optional properties:
+  - resets: may contain phandles to the controller core reset, the register
+ reset
+  - reset-names: may contain "nand", "reg"
+
 Sub-nodes:
   Sub-nodes represent available NAND chips.
 
@@ -46,6 +51,8 @@ nand: nand@ff900000 {
 	reg-names = "nand_data", "denali_reg";
 	clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
 	clock-names = "nand", "nand_x", "ecc";
+	resets = <&nand_rst>, <&nand_reg_rst>;
+	reset-names = "nand", "reg";
 	interrupts = <0 144 4>;
 
 	nand@0 {
diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 8b779a899dcf..132bc6cc066c 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -14,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #include "denali.h"
 
@@ -22,6 +24,8 @@ struct denali_dt {
 	struct clk *clk;	/* core clock */
 	struct clk *clk_x;	/* bus interface clock */
 	struct clk *clk_ecc;	/* ECC circuit clock */
+	struct reset_control *rst;	/* core reset */
+	struct reset_control *rst_reg;	/* register reset */
 };
 
 struct denali_dt_data {
@@ -151,6 +155,14 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (IS_ERR(dt->clk_ecc))
 		return PTR_ERR(dt->clk_ecc);
 
+	dt->rst = devm_reset_control_get_optional_shared(dev, "nand");
+	if (IS_ERR(dt->rst))
+		return PTR_ERR(dt->rst);
+
+	dt->rst_reg = devm_reset_control_get_optional_shared(dev, "reg");
+	if (IS_ERR(dt->rst_reg))
+		return PTR_ERR(dt->rst_reg);
+
 	ret = clk_prepare_enable(dt->clk);
 	if (ret)
 		return ret;
@@ -166,10 +178,30 @@ static int denali_dt_probe(struct platform_device *pdev)
 	denali->clk_rate = clk_get_rate(dt->clk);
 	denali->clk_x_rate = clk_get_rate(dt->clk_x);
 
-	ret = denali_init(denali);
+	/*
+	 * Deassert the register reset, and the core reset in this order.
+	 * Deasserting the core reset while the register reset is asserted
+	 * will cause unpredictable behavior in the controller.
+	 */
+	ret = reset_control_deassert(dt->rst_reg);
 	if (ret)
 		goto out_disable_clk_ecc;
 
+	ret = reset_control_deassert(dt->rst);
+	if (ret)
+		goto out_assert_rst_reg;
+
+	/*
+	 * When the reset is deasserted, the initialization sequence is kicked
+	 * (bootstrap process). This will take a while, and the driver must
+	 * wait until it finished in order to avoid unpredictable behavior.
+	 */
+	usleep_range(200, 1000);
+
+	ret = denali_init(denali);
+	if (ret)
+		goto out_assert_rst;
+
 	for_each_child_of_node(dev->of_node, np) {
 		ret = denali_dt_chip_init(denali, np);
 		if (ret) {
@@ -184,6 +216,10 @@ static int denali_dt_probe(struct platform_device *pdev)
 
 out_remove_denali:
 	denali_remove(denali);
+out_assert_rst:
+	reset_control_assert(dt->rst);
+out_assert_rst_reg:
+	reset_control_assert(dt->rst_reg);
 out_disable_clk_ecc:
 	clk_disable_unprepare(dt->clk_ecc);
 out_disable_clk_x:
@@ -199,6 +235,8 @@ static int denali_dt_remove(struct platform_device *pdev)
 	struct denali_dt *dt = platform_get_drvdata(pdev);
 
 	denali_remove(&dt->controller);
+	reset_control_assert(dt->rst);
+	reset_control_assert(dt->rst_reg);
 	clk_disable_unprepare(dt->clk_ecc);
 	clk_disable_unprepare(dt->clk_x);
 	clk_disable_unprepare(dt->clk);
-- 
2.17.1

