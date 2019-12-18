Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D54DC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC66621582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576638291;
	bh=ZBVlMQS3Efo5A+DA0zxAHU4x5O/v5668a6b5on5I/xk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FBl5XlsDIARNRPnbYkgSiHyQ1a6+i/XsqIefy2UzqAp5hLO27ObCPl8bpSiYeRssb
	 4M7zibG1FwFxRGhkOp/JjWTm9VWIDlnKTZuWDmmavmpHtcS4MDGMf3uzQeRs8KXSi7
	 guKQacFADnmiRtEiURSI2l4ipVAjFgx/lQKV3Tvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfLRDEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfLRDEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:04:50 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD318206D8;
        Wed, 18 Dec 2019 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576638289;
        bh=ZBVlMQS3Efo5A+DA0zxAHU4x5O/v5668a6b5on5I/xk=;
        h=From:To:Cc:Subject:Date:From;
        b=krx8BswHUf6o4YajouOrHUh+piYDKsRsVCZpNtiv6gGJn+V/5NRcAV/ISeepIfjjr
         QR1Uvr0fx+onmwSIvdYspUG3+SPOPkl9H+MD6g7VdhakzrHXn6hBIwMnd23ebxnWY6
         q+cCrsq0mdoEGNqXsO+4NpXD7hW4mgfmho1UrxCE=
Received: by wens.tw (Postfix, from userid 1000)
        id CD7765FCD0; Wed, 18 Dec 2019 11:04:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: [PATCH] clk: sunxi-ng: r40: Allow setting parent rate for external clock outputs
Date:   Wed, 18 Dec 2019 11:04:31 +0800
Message-Id: <20191218030431.14578-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

One of the uses of the external clock outputs is to provide a stable
32768 Hz clock signal to WiFi and Bluetooth chips. On the R40, the RTC
has an internal RC oscillator that is muxed with the external crystal.

Allow setting the parent rate for the external clock outputs so that
requests for 32768 Hz get passed to the RTC's clock driver to mux in
the external crystal if it isn't already muxed correctly.

Fixes: cd030a78f7aa ("clk: sunxi-ng: support R40 SoC")
Fixes: 01a7ea763fc4 ("clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output")
Cc: <stable@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 897490800102..23bfe1d12f21 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -761,7 +761,8 @@ static struct ccu_mp outa_clk = {
 		.reg		= 0x1f0,
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("outa", out_parents,
-						      &ccu_mp_ops, 0),
+						      &ccu_mp_ops,
+						      CLK_SET_RATE_PARENT),
 	}
 };
 
@@ -779,7 +780,8 @@ static struct ccu_mp outb_clk = {
 		.reg		= 0x1f4,
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("outb", out_parents,
-						      &ccu_mp_ops, 0),
+						      &ccu_mp_ops,
+						      CLK_SET_RATE_PARENT),
 	}
 };
 
-- 
2.24.0

