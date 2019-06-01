Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011ECC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF43F273D6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395620;
	bh=4GRY0/H2V57ByO7mCQ0w4deIe8grY418zVAyg2cu77w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DJ/sVZEBBKqAtWcD1SNrb5oZTG3QJO5osoIrGMrlLHu+Z2utRahHehU260bPTM008
	 zw5b0Fy3uJ68PpmJWW6HHtHNfa1w8Rtt2ijoF+SR6Oqv21LOhThK03fGLEBIoyW5OO
	 ImKJ+dJQeedlLdqx/VzJN5KnEBrkn7EkqYhssf3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfFAN06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbfFAN05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:26:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31432273BD;
        Sat,  1 Jun 2019 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395616;
        bh=4GRY0/H2V57ByO7mCQ0w4deIe8grY418zVAyg2cu77w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs3ZguG9HTI6IfFAgaC2rfrjpLsm3CUYw7EKGEp6X51iOBpk3tmuY2q2YalcH5EHv
         KDyAB6mpplbKK3DO+qP/Bt3GxfVeAX6khVoymqwpmMCi6zNVrcO173NZGfPZoshjRY
         8Fb1cOE8ae5+y4rpeBXh+6mI+UKhQ+spYFkFgPmc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 32/56] clk: rockchip: Turn on "aclk_dmac1" for suspend on rk3288
Date:   Sat,  1 Jun 2019 09:25:36 -0400
Message-Id: <20190601132600.27427-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 57a20248ef3e429dc822f0774bc4e00136c46c83 ]

Experimentally it can be seen that going into deep sleep (specifically
setting PMU_CLR_DMA and PMU_CLR_BUS in RK3288_PMU_PWRMODE_CON1)
appears to fail unless "aclk_dmac1" is on.  The failure is that the
system never signals that it made it into suspend on the GLOBAL_PWROFF
pin and it just hangs.

NOTE that it's confirmed that it's the actual suspend that fails, not
one of the earlier calls to read/write registers.  Specifically if you
comment out the "PMU_GLOBAL_INT_DISABLE" setting in
rk3288_slp_mode_set() and then comment out the "cpu_do_idle()" call in
rockchip_lpmode_enter() then you can exercise the whole suspend path
without any crashing.

This is currently not a problem with suspend upstream because there is
no current way to exercise the deep suspend code.  However, anyone
trying to make it work will run into this issue.

This was not a problem on shipping rk3288-based Chromebooks because
those devices all ran on an old kernel based on 3.14.  On that kernel
"aclk_dmac1" appears to be left on all the time.

There are several ways to skin this problem.

A) We could add "aclk_dmac1" to the list of critical clocks and that
apperas to work, but presumably that wastes power.

B) We could keep a list of "struct clk" objects to enable at suspend
time in clk-rk3288.c and use the standard clock APIs.

C) We could make the rk3288-pmu driver keep a list of clocks to enable
at suspend time.  Presumably this would require a dts and bindings
change.

D) We could just whack the clock on in the existing syscore suspend
function where we whack a bunch of other clocks.  This is particularly
easy because we know for sure that the clock's only parent
("aclk_cpu") is a critical clock so we don't need to do anything more
than ungate it.

In this case I have chosen D) because it seemed like the least work,
but any of the other options would presumably also work fine.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk-rk3288.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 9040878e3e2b6..a6cda84b67da5 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -797,6 +797,9 @@ static const int rk3288_saved_cru_reg_ids[] = {
 	RK3288_CLKSEL_CON(10),
 	RK3288_CLKSEL_CON(33),
 	RK3288_CLKSEL_CON(37),
+
+	/* We turn aclk_dmac1 on for suspend; this will restore it */
+	RK3288_CLKGATE_CON(10),
 };
 
 static u32 rk3288_saved_cru_regs[ARRAY_SIZE(rk3288_saved_cru_reg_ids)];
@@ -812,6 +815,14 @@ static int rk3288_clk_suspend(void)
 				readl_relaxed(rk3288_cru_base + reg_id);
 	}
 
+	/*
+	 * Going into deep sleep (specifically setting PMU_CLR_DMA in
+	 * RK3288_PMU_PWRMODE_CON1) appears to fail unless
+	 * "aclk_dmac1" is on.
+	 */
+	writel_relaxed(1 << (12 + 16),
+		       rk3288_cru_base + RK3288_CLKGATE_CON(10));
+
 	/*
 	 * Switch PLLs other than DPLL (for SDRAM) to slow mode to
 	 * avoid crashes on resume. The Mask ROM on the system will
-- 
2.20.1

