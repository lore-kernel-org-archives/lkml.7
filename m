Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC637205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712374;
	bh=R48wGouBOV0zCL52hf+DMxHqO2YryzP7ALOUi+giqvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBO9HmQejzpKGJv1akABEc8CG0Khwts/pzNJnFDGFzSQ6X/rKIUUER0B3fg5kAzCI
	 riXXiUwtt6G7vYgk8tzBPmB9hwdtS13gksGgpmr9uCH3GBiQgasXJMenuiq/7vMSeT
	 e2Aes/AJEmwdCYFwkNLt7Naod5P+6UBOP7vGGcZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbfC0SUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390117AbfC0SUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF47F20449;
        Wed, 27 Mar 2019 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710834;
        bh=R48wGouBOV0zCL52hf+DMxHqO2YryzP7ALOUi+giqvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1sYhG8UbAcOohqgq1pdSLzYsiDkmhrmjxK9ECw7lIAYMFLD6Kx5PML8fDUt/zPyp
         dE2er05faiiUgZqIz1eGnfutxp9UHHhV/4bUTSLj/zZIuBYj5yTltY9VIL5sREHlD3
         NETNMJKikXK9AgTqi6lW30RIYcQRelW6ePsTUEno=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 119/123] clk: rockchip: fix frac settings of GPLL clock for rk3328
Date:   Wed, 27 Mar 2019 14:16:23 -0400
Message-Id: <20190327181628.15899-119-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Katsuhiro Suzuki <katsuhiro@katsuster.net>

[ Upstream commit a0e447b0c50240a90ab84b7126b3c06b0bab4adc ]

This patch fixes settings of GPLL frequency in fractional mode for
rk3328. In this mode, FOUTVCO is calcurated by following formula:
  FOUTVCO = FREF * FBDIV / REFDIV + ((FREF * FRAC / REFDIV) >> 24)

The problem is in FREF * FRAC >> 24 term. This result always lacks
one from target value is specified by rate member. For example first
itme of rk3328_pll_frac_rate originally has
  - rate  : 1016064000
  - refdiv: 3
  - fbdiv : 127
  - frac  : 134217
  - FREF * FBDIV / REFDIV        = 1016000000
  - (FREF * FRAC / REFDIV) >> 24 = 63999
Thus calculated rate is 1016063999. It seems wrong.

If frac has 134218 (it is increased 1 from original value), second
term is 64000. All other items have same situation. So this patch
adds 1 to frac member in all items of rk3328_pll_frac_rate.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Acked-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk-rk3328.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index b04f29774ee7..559abf76891e 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -78,17 +78,17 @@ static struct rockchip_pll_rate_table rk3328_pll_rates[] = {
 
 static struct rockchip_pll_rate_table rk3328_pll_frac_rates[] = {
 	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
-	RK3036_PLL_RATE(1016064000, 3, 127, 1, 1, 0, 134217),
+	RK3036_PLL_RATE(1016064000, 3, 127, 1, 1, 0, 134218),
 	/* vco = 1016064000 */
-	RK3036_PLL_RATE(983040000, 24, 983, 1, 1, 0, 671088),
+	RK3036_PLL_RATE(983040000, 24, 983, 1, 1, 0, 671089),
 	/* vco = 983040000 */
-	RK3036_PLL_RATE(491520000, 24, 983, 2, 1, 0, 671088),
+	RK3036_PLL_RATE(491520000, 24, 983, 2, 1, 0, 671089),
 	/* vco = 983040000 */
-	RK3036_PLL_RATE(61440000, 6, 215, 7, 2, 0, 671088),
+	RK3036_PLL_RATE(61440000, 6, 215, 7, 2, 0, 671089),
 	/* vco = 860156000 */
-	RK3036_PLL_RATE(56448000, 12, 451, 4, 4, 0, 9797894),
+	RK3036_PLL_RATE(56448000, 12, 451, 4, 4, 0, 9797895),
 	/* vco = 903168000 */
-	RK3036_PLL_RATE(40960000, 12, 409, 4, 5, 0, 10066329),
+	RK3036_PLL_RATE(40960000, 12, 409, 4, 5, 0, 10066330),
 	/* vco = 819200000 */
 	{ /* sentinel */ },
 };
-- 
2.19.1

