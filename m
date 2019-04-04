Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FFEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C8320652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369474;
	bh=kvnlPMiVNhVn9LycacgLUjcdAKTGvR+IF+BURDI4/sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Etipg/da10h5sglJbJd5BKHs2d3tvXeuuB/pQp2p0ljxYvzRWotFoKbSb5o4KQWLB
	 yfmfDYLyARf4gpueAQyOjBlRI7r45Bbl0ZiRMEkHs8q0SAvxV8Ow7gu7YUVOHQIufv
	 WNPjl3QmAMdEFMY/sEgQcWTKgeQWHv1Tg69rLMuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbfDDJRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388283AbfDDJRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3462075E;
        Thu,  4 Apr 2019 09:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369467;
        bh=kvnlPMiVNhVn9LycacgLUjcdAKTGvR+IF+BURDI4/sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuSALumnTs1dkt9jjNV/Rg/8Z1QRN5yxpVl1P9LxWy5wh5Hd3A/ZVQ0TqROijNBGW
         5NOWChlSgKycAZ4gCXfdq1qPERSPrfiTQShOp4zzUyXeoxKReJsThS5EudJrMOzD5D
         hYWeWH6nu9xSnrWhGFKeRz64dWb1SbQXjfRJgSPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 235/246] clk: rockchip: fix frac settings of GPLL clock for rk3328
Date:   Thu,  4 Apr 2019 10:48:55 +0200
Message-Id: <20190404084627.513774759@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index faa94adb2a37..65ab5c2f48b0 100644
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



