Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF12C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DFC204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561412865;
	bh=lrV+vHr/Cl6rboCMsGhRtTeiNYrSNTIN5EgPwuSMd58=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lIA50OxV9kB5k4XTRwbwx2ocAVYDFPRzS0DTEkAH/ZFvg4DVodcvr8XQR9ELI8SO6
	 Dv1157UKtDoVBDAomkzeMtN9M0RGTXK7FhE7BY2hMV6KXPwzrd8Q1u7jmQADjt/UD5
	 x2u0DvS2oMSsZhjBJbgLgZKsheXScvOhXizgvFUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfFXVro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbfFXVrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:47:41 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBCF204FD;
        Mon, 24 Jun 2019 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561412860;
        bh=lrV+vHr/Cl6rboCMsGhRtTeiNYrSNTIN5EgPwuSMd58=;
        h=From:To:Cc:Subject:Date:From;
        b=kKiWtpB0asUuauN3Ec3RZ4exalwiTqmQMfyE9GPaVgR9xEDKL/zdhc6pel/Q7GmZm
         bOIKF0eYHIe4W9wsUqEZ2Jo5IHqv0eolX5orh4wwOuRlJYeUv6qOv0h7nBe3LzXIES
         wR4lHDyJBEVgSaf2+j4HDhkac9Gqxta4w4PGU/CY=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     sboyd@kernel.org
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: socfpga: stratix10: add additional clocks needed for the NAND IP
Date:   Mon, 24 Jun 2019 16:47:10 -0500
Message-Id: <20190624214710.11836-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nand_clk is actually called the nand_x_clk and the parent is the
l4_mp_clk, not the l4_main_clk. The nand_clk is a child of the
nand_x_clk and has a fixed divider of 4. The same is true for the
nand_ecc_clk.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-s10.c               | 6 +++++-
 include/dt-bindings/clock/stratix10-clock.h | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index 8281dfbf38c2..609dd722675e 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -161,8 +161,12 @@ static const struct stratix10_gate_clock s10_gate_clks[] = {
 	  8, 0, 0, 0, 0, 0, 0},
 	{ STRATIX10_SPI_M_CLK, "spi_m_clk", "l4_mp_clk", NULL, 1, 0, 0xA4,
 	  9, 0, 0, 0, 0, 0, 0},
-	{ STRATIX10_NAND_CLK, "nand_clk", "l4_main_clk", NULL, 1, 0, 0xA4,
+	{ STRATIX10_NAND_X_CLK, "nand_x_clk", "l4_mp_clk", NULL, 1, 0, 0xA4,
 	  10, 0, 0, 0, 0, 0, 0},
+	{ STRATIX10_NAND_CLK, "nand_clk", "nand_x_clk", NULL, 1, 0, 0xA4,
+	  10, 0, 0, 0, 0, 0, 4},
+	{ STRATIX10_NAND_ECC_CLK, "nand_ecc_clk", "nand_x_clk", NULL, 1, 0, 0xA4,
+	  10, 0, 0, 0, 0, 0, 4},
 };
 
 static int s10_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
diff --git a/include/dt-bindings/clock/stratix10-clock.h b/include/dt-bindings/clock/stratix10-clock.h
index 0ac1c90a18bf..08b98e20b7cc 100644
--- a/include/dt-bindings/clock/stratix10-clock.h
+++ b/include/dt-bindings/clock/stratix10-clock.h
@@ -79,6 +79,8 @@
 #define STRATIX10_USB_CLK		59
 #define STRATIX10_SPI_M_CLK		60
 #define STRATIX10_NAND_CLK		61
-#define STRATIX10_NUM_CLKS		62
+#define STRATIX10_NAND_X_CLK		62
+#define STRATIX10_NAND_ECC_CLK		63
+#define STRATIX10_NUM_CLKS		64
 
 #endif	/* __STRATIX10_CLOCK_H */
-- 
2.20.0

