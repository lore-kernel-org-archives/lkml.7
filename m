Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF427C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACACC24682
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GrQ/g5y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLTLeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:34:08 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36700 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfLTLeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:34:03 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xBKBW2Wx010984;
        Fri, 20 Dec 2019 20:32:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xBKBW2Wx010984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576841528;
        bh=my3TOmqDy5To4BV9jpt+Keyp543Zjs/fVShQ11GouiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrQ/g5y07vaA+qagWKN4ACyos7dSCu3OP+vo82RhtqmGC1SD66KHa/mcr8g6AdmZD
         vP+JYrQRNB8tyQa/GHNiy9PMwjfoj/Hs9CPu4RWQke/JbJFvCGMyDPnhbJYPkxZ2Gt
         ENEHjS6//KSTMqGFmWPEyG3eR9ZdfYuJ53QCoVVuYGEUFNJHPXviwjpP0809uJLJRE
         GURkaFBN915RVcg5jgbh6wctnpTXPcte0qNUnvt/AlsXcKFXUDO71gXrs0DVL2hk5l
         nALGwybjYsRnFXCiCtaa/L1H7NkXK6e/ppcT8MfY7j5shzl0e3h1kpLlI4hH3B4qck
         o4tEkPUQPE64A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] mtd: rawnand: denali_dt: add reset controlling
Date:   Fri, 20 Dec 2019 20:31:54 +0900
Message-Id: <20191220113155.28177-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220113155.28177-1-yamada.masahiro@socionext.com>
References: <20191220113155.28177-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Denali NAND Flash Memory Controller User's Guide,
this IP has two reset signals.

  rst_n:     reset most of FFs in the controller core
  reg_rst_n: reset all FFs in the register interface, and in the
             initialization sequencer

This commit supports controlling those reset signals.

It is possible to control them separately from the IP point of view
although they might be often tied up together in actual SoC integration.

The IP spec says, asserting only the reg_rst_n without asserting rst_n
will cause unpredictable behavior in the controller. So, the driver
deasserts ->rst_reg and ->rst in this order.

Another thing that should be kept in mind is the automated initialization
sequence (a.k.a. 'bootstrap' process) is kicked off when reg_rst_n is
deasserted.

When the reset is deasserted, the controller issues a RESET command
to the chip select 0, and attempts to read out the chip ID, and further
more, ONFI parameters if it is an ONFI-compliant device. Then, the
controller sets up the relevant registers based on the detected
device parameters.

This process might be useful for tiny boot firmware, but is redundant
for Linux Kernel because nand_scan_ident() probes devices and sets up
parameters accordingly. Rather, this hardware feature is annoying
because it ends up with misdetection due to bugs.

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
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---

Changes in v3: None
Changes in v2:
 - Split into two patches

 drivers/mtd/nand/raw/denali_dt.c | 40 +++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 699255fb2dd8..f08740ae282b 100644
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
@@ -157,6 +161,14 @@ static int denali_dt_probe(struct platform_device *pdev)
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
@@ -172,10 +184,30 @@ static int denali_dt_probe(struct platform_device *pdev)
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
+	 * (bootstrap process). The driver must wait until it finished.
+	 * Otherwise, it will result in unpredictable behavior.
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
@@ -190,6 +222,10 @@ static int denali_dt_probe(struct platform_device *pdev)
 
 out_remove_denali:
 	denali_remove(denali);
+out_assert_rst:
+	reset_control_assert(dt->rst);
+out_assert_rst_reg:
+	reset_control_assert(dt->rst_reg);
 out_disable_clk_ecc:
 	clk_disable_unprepare(dt->clk_ecc);
 out_disable_clk_x:
@@ -205,6 +241,8 @@ static int denali_dt_remove(struct platform_device *pdev)
 	struct denali_dt *dt = platform_get_drvdata(pdev);
 
 	denali_remove(&dt->controller);
+	reset_control_assert(dt->rst);
+	reset_control_assert(dt->rst_reg);
 	clk_disable_unprepare(dt->clk_ecc);
 	clk_disable_unprepare(dt->clk_x);
 	clk_disable_unprepare(dt->clk);
-- 
2.17.1

