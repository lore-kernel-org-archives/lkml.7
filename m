Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42468C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175FD208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560248346;
	bh=ECxRPjnnyOauLHhaZ2dGgISLKOhjT/mVaqEpGjVMnh0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nOQgIl7cGQt8HWtP2O8xdRd/q6RaRYR0mwn4YSjKhqreDvjfRXGy4eyqXNgoqEhMc
	 wmdiaMP5QIn4HFOhhmUol5ihU8ZHqI1IHobaiKlxRTRQODjyMsqB2RCIy7iOmaV2IT
	 hvnaOV0qfJfMVV2mSQBRv0qAvADhxp+tVxUlqoZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405613AbfFKKTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405104AbfFKKRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:22 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26ED72146E;
        Tue, 11 Jun 2019 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248241;
        bh=ECxRPjnnyOauLHhaZ2dGgISLKOhjT/mVaqEpGjVMnh0=;
        h=From:To:Cc:Subject:Date:From;
        b=K/6bUhwaYp9/MWjk2zZJtPZ8uEqONxLXgvGkOchuijFaSBSSr0b38F6VzmafLosY4
         NNHC8feiwpsi1pFLMlGJ88Kcl37Ht2W+yGRhGa5L+yTDweHtJ5XH/kaH4QYEPtPRtY
         e6C3Xo32z1ZqyJSL3c2n+7t2hiLliYvdYMQMjRVQ=
Received: by wens.tw (Postfix, from userid 1000)
        id 0A2275FBB7; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/25] clk: sunxi-ng: clk parent rewrite part 1
Date:   Tue, 11 Jun 2019 18:16:33 +0800
Message-Id: <20190611101658.23855-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v2 of the sunxi-ng clk parent rewrite part 1.

Changes since v1:

  - Collected Maxime's Acked-by for sunxi patches
  - Expanded possible_parents_show() to cover most cases
  - Added comment to CLK_HW_INIT_HWS detailing usage for sharing
    compound literal

As mentioned in my reply to the cover letter of v1, I can merge all the
patches through the sunxi tree and send a combined (with other sunxi
stuff) PR, or as an independent branch, whichever is preferred.

Excerpt from original cover letter follows:

This is series is the first part of a large series (I haven't done the
rest) of patches to rewrite the clk parent relationship handling within
the sunxi-ng clk driver. This is based on Stephen's recent work allowing
clk drivers to specify clk parents using struct clk_hw * or parsing DT
phandles in the clk node.

This series can be split into a few major parts:

1) The first patch is a small fix for clk debugfs representation. This
   was done before commit 1a079560b145 ("clk: Cache core in 
   clk_fetch_parent_index() without names") was posted, so it might or
   might not be needed. Found this when checking my work using
   clk_possible_parents.

2) A bunch of CLK_HW_INIT_* helper macros are added. These cover the
   situations I encountered, or assume I will encounter, such as single
   internal (struct clk_hw *) parent, single DT (struct clk_parent_data
   .fw_name), multiple internal parents, and multiple mixed (internal +
   DT) parents. A special variant for just an internal single parent is
   added, CLK_HW_INIT_HWS, which lets the driver share the singular
   list, instead of having the compiler create a compound literal every
   time. It might even make sense to only keep this variant.

3) A bunch of CLK_FIXED_FACTOR_* helper macros are added. The rationale
   is the same as the single parent CLK_HW_INIT_* helpers.

4) Bulk conversion of CLK_FIXED_FACTOR to use local parent references,
   either struct clk_hw * or DT .fw_name types, whichever the hardware
   requires.

5) The beginning of SUNXI_CCU_GATE conversion to local parent
   references. This part is not done. They are included as justification
   and examples for the shared list of clk parents case.


Thanks
ChenYu


Chen-Yu Tsai (25):
  clk: Fix debugfs clk_possible_parents for clks without parent string
    names
  clk: Add CLK_HW_INIT_* macros using .parent_hws
  clk: Add CLK_HW_INIT_FW_NAME macro using .fw_name in .parent_data
  clk: Add CLK_HW_INIT_PARENT_DATA macro using .parent_data
  clk: fixed-factor: Add CLK_FIXED_FACTOR_HW which takes clk_hw pointer
    as parent
  clk: fixed-factor: Add CLK_FIXED_FACTOR_HWS which takes list of struct
    clk_hw *
  clk: fixed-factor: Add CLK_FIXED_FACTOR_FW_NAME for DT clock-names
    parent
  clk: sunxi-ng: switch to of_clk_hw_register() for registering clks
  clk: sunxi-ng: sun8i-r: Use local parent references for CLK_HW_INIT_*
  clk: sunxi-ng: a10: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: sun5i: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: a31: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: a23: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: a33: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: h3: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: r40: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: v3s: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: sun8i-r: Use local parent references for
    CLK_FIXED_FACTOR
  clk: sunxi-ng: f1c100s: Use local parent references for
    CLK_FIXED_FACTOR
  clk: sunxi-ng: a64: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: h6: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: h6-r: Use local parent references for CLK_FIXED_FACTOR
  clk: sunxi-ng: gate: Add macros for referencing local clock parents
  clk: sunxi-ng: a80-usb: Use local parent references for SUNXI_CCU_GATE
  clk: sunxi-ng: sun8i-r: Use local parent references for SUNXI_CCU_GATE

 drivers/clk/clk.c                        |  44 +++++++++-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c     |  39 ++++++---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c    |  41 +++++----
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   |   2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c     |  69 +++++++++------
 drivers/clk/sunxi-ng/ccu-sun5i.c         |  34 +++++---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c     |  39 ++++++---
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c     |  34 +++++---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c     |  34 +++++---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c      |  29 ++++---
 drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 104 +++++++++++------------
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c     |  46 ++++++----
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     |  29 ++++---
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c |  32 ++++---
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c |  29 ++++---
 drivers/clk/sunxi-ng/ccu_common.c        |   2 +-
 drivers/clk/sunxi-ng/ccu_gate.h          |  53 ++++++++++++
 include/linux/clk-provider.h             |  89 +++++++++++++++++++
 18 files changed, 526 insertions(+), 223 deletions(-)

-- 
2.20.1

