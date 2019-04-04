Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B918321738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368148;
	bh=nBCghCJs2oxezPUJSJLbW9HkdKldw+llrwr2IrmC/Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gyp64IPKKcWNiRBYKmTW9k/s2GVoyN6vsQZeHxLELDMZQRflOpQBAs/q5cpmhm+Re
	 C5kMaPDOvsmB3G0mWyyX10wYjeccgmKnHJ/3vYTZB9d6TnUu/jOCE1J4LpoB5ZAUPX
	 l84bCqhxaWV3C3MMiuTNcNMRZrmQu7Ab7BPHCBmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfDDIzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbfDDIzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E78921738;
        Thu,  4 Apr 2019 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368141;
        bh=nBCghCJs2oxezPUJSJLbW9HkdKldw+llrwr2IrmC/Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMOg7IXj033IU6q6xoAncE8zHM8bKPsnCVYR9dqWW52+NqMvVXnwX5+gGw4aDQEM+
         2qQquNZFzf8IS9A1pnY6H1E/YbIRBUjiMHJcqnXsVgytWQid8eSB8Te7cmK2Dy+siU
         7+vrdXZvst98NzHoZB+3r903kKU+XNuagzxO039E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 052/121] clk: fractional-divider: check parent rate only if flag is set
Date:   Thu,  4 Apr 2019 10:47:20 +0200
Message-Id: <20190404084548.076099791@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 2f4e79fe7b86..3eb3376f1cc8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -743,6 +743,9 @@ unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
 unsigned long clk_hw_get_flags(const struct clk_hw *hw);
+#define clk_hw_can_set_rate_parent(hw) \
+	(clk_hw_get_flags((hw)) & CLK_SET_RATE_PARENT)
+
 bool clk_hw_is_prepared(const struct clk_hw *hw);
 bool clk_hw_is_enabled(const struct clk_hw *hw);
 bool __clk_is_enabled(struct clk *clk);
-- 
2.19.1



