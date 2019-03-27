Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1857EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB2A206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713557;
	bh=pY3sqJTrXeIpvAdywDAVsE79ly4q8wvGhTNHP5E/1g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q8exnpNSFNiTJ8F/LhTp7Zjn/n9td34gctjJWlbeaZE/4/biDfg6cSzKsYCo0Tqk8
	 D9dkHcoKIEqTMwOwNj5v5en6wvwRnE0Oa6joPZfv56QgsxKvY+saBgxfnn8GJYZa6g
	 179kVZ6zthrPWti7L+3HKyDSKcD7mA5qbXDfnGH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbfC0SMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389203AbfC0SM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:12:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33011217D9;
        Wed, 27 Mar 2019 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710345;
        bh=pY3sqJTrXeIpvAdywDAVsE79ly4q8wvGhTNHP5E/1g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBi78RMZVCZh85wAnfVKgkU80AxMwRZa1VcQIHlJ0CDUiwQYZapJ9o5lV/ZSha3NL
         MUP1JTvtZEJbqmMkS5XflR9phomFDcIdKvn8fxtPHxM+Pax1TFVBmBCx1otasK1lRt
         ZvTITfHhZy8jv3gWEHLVTnrJeJruKAmCVmPO5CV8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 070/192] clk: fractional-divider: check parent rate only if flag is set
Date:   Wed, 27 Mar 2019 14:08:22 -0400
Message-Id: <20190327181025.13507-70-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Katsuhiro Suzuki <katsuhiro@katsuster.net>

[ Upstream commit d13501a2bedfbea0983cc868d3f1dc692627f60d ]

Custom approximation of fractional-divider may not need parent clock
rate checking. For example Rockchip SoCs work fine using grand parent
clock rate even if target rate is greater than parent.

This patch checks parent clock rate only if CLK_SET_RATE_PARENT flag
is set.

For detailed example, clock tree of Rockchip I2S audio hardware.
  - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
  - i2s1_div is integer divider can divide N (N is 1~128).
    Input clock is CPLL or GPLL. Initial divider value is N = 1.
    Ex) PLL = CPLL, N = 10, i2s1_div output rate is
      CPLL / 10 = 1.2GHz / 10 = 120MHz
  - i2s1_frac is fractional divider can divide input to x/y, x and
    y are 16bit integer.

CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
GPLL --> |          | ,--------------'    |          |
                      `--> i2s1_frac ---> |          |

Clock mux system try to choose suitable one from i2s1_div and
i2s1_frac for master clock (MCLK) of I2S1.

Bad scenario as follows:
  - Try to set MCLK to 8.192MHz (32kHz audio replay)
    Candidate setting is
    - i2s1_div: GPLL / 60 = 8.192MHz
    i2s1_div candidate is exactly same as target clock rate, so mux
    choose this clock source. i2s1_div output rate is changed
    491.52MHz -> 8.192MHz

  - After that try to set to 11.2896MHz (44.1kHz audio replay)
    Candidate settings are
    - i2s1_div : CPLL / 107 = 11.214945MHz
    - i2s1_frac: i2s1_div   = 8.192MHz
      This is because clk_fd_round_rate() thinks target rate
      (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
      and returns parent clock rate.

Above is current upstreamed behavior. Clock mux system choose
i2s1_div, but this clock rate is not acceptable for I2S driver, so
users cannot replay audio.

Expected behavior is:
  - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
    Candidate settings are
    - i2s1_div : CPLL / 107          = 11.214945MHz
    - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
                 Change i2s1_div to GPLL / 1 = 491.52MHz at same
                 time.

If apply this commit, clk_fd_round_rate() calls custom approximate
function of Rockchip even if target rate is higher than parent.
Custom function changes both grand parent (i2s1_div) and parent
(i2s_frac) settings at same time. Clock mux system can choose
i2s1_frac and audio works fine.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
[sboyd@kernel.org: Make function into a macro instead]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-fractional-divider.c | 2 +-
 include/linux/clk-provider.h         | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index fdf625fb10fa..083daa293280 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -77,7 +77,7 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long m, n;
 	u64 ret;
 
-	if (!rate || rate >= *parent_rate)
+	if (!rate || (!clk_hw_can_set_rate_parent(hw) && rate >= *parent_rate))
 		return *parent_rate;
 
 	if (fd->approximation)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa70a38d..d1b6d2c3ada6 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -782,6 +782,9 @@ unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
 unsigned long clk_hw_get_flags(const struct clk_hw *hw);
+#define clk_hw_can_set_rate_parent(hw) \
+	(clk_hw_get_flags((hw)) & CLK_SET_RATE_PARENT)
+
 bool clk_hw_is_prepared(const struct clk_hw *hw);
 bool clk_hw_rate_is_protected(const struct clk_hw *hw);
 bool clk_hw_is_enabled(const struct clk_hw *hw);
-- 
2.19.1

