Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D3C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 11:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACE121D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 11:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLOLiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 06:38:55 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:38039 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfLOLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 06:38:55 -0500
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1CEFD200003;
        Sun, 15 Dec 2019 11:38:51 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2] clk: meson: pll: Fix by 0 division in __pll_params_to_rate()
Date:   Sun, 15 Dec 2019 12:47:05 +0100
Message-Id: <20191215114705.24401-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some meson pll registers can be initialized with 0 as N value, introducing
the following division by 0 when computing rate :

  UBSAN: Undefined behaviour in drivers/clk/meson/clk-pll.c:75:9
  division by zero
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc3-608075-g86c9af8630e1-dirty #400
  Call trace:
   dump_backtrace+0x0/0x1c0
   show_stack+0x14/0x20
   dump_stack+0xc4/0x100
   ubsan_epilogue+0x14/0x68
   __ubsan_handle_divrem_overflow+0x98/0xb8
   __pll_params_to_rate+0xdc/0x140
   meson_clk_pll_recalc_rate+0x278/0x3a0
   __clk_register+0x7c8/0xbb0
   devm_clk_hw_register+0x54/0xc0
   meson_eeclkc_probe+0xf4/0x1a0
   platform_drv_probe+0x54/0xd8
   really_probe+0x16c/0x438
   driver_probe_device+0xb0/0xf0
   device_driver_attach+0x94/0xa0
   __driver_attach+0x70/0x108
   bus_for_each_dev+0xd8/0x128
   driver_attach+0x30/0x40
   bus_add_driver+0x1b0/0x2d8
   driver_register+0xbc/0x1d0
   __platform_driver_register+0x78/0x88
   axg_driver_init+0x18/0x20
   do_one_initcall+0xc8/0x24c
   kernel_init_freeable+0x2b0/0x344
   kernel_init+0x10/0x128
   ret_from_fork+0x10/0x18

This checks if N is null before doing the division.

Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
Changes since v1:
  - Change Fix tag
  - Move null test to .recalc_rate()
---
 drivers/clk/meson/clk-pll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index ddb1e5634739..4d3a8003ca20 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -77,6 +77,10 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 	unsigned int m, n, frac;
 
 	n = meson_parm_read(clk->map, &pll->n);
+	/* Some hw may have n set to 0 at init, avoid div by 0 in that case */
+	if (n == 0)
+		return 0;
+
 	m = meson_parm_read(clk->map, &pll->m);
 
 	frac = MESON_PARM_APPLICABLE(&pll->frac) ?
-- 
2.24.0

