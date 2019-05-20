Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA376C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA49320656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558339655;
	bh=xnei+IQeBrteeMu2IJuJYcNap1qcD8QFf+i0AMgPxKE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eXhazNYl/lkPq97Omaz8ddUCn4s8x0658hUw4aQwlbKoh99pGIjh6uJniZkPowDH2
	 NuxUgcuMYFHOtv7jT9qyUL9aiPpSVcFF7FyQ1Iex1pRsFKE2nedsi03uPQwaJH1AuU
	 LHhPLaQB4Ctw9e3rkGItC8BDfWJWe/+LyL31hUAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfETIHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbfETIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:35 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19C12081C;
        Mon, 20 May 2019 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339534;
        bh=xnei+IQeBrteeMu2IJuJYcNap1qcD8QFf+i0AMgPxKE=;
        h=From:To:Cc:Subject:Date:From;
        b=R5xwEHoXcgt6AHWxLLDlnReqAu7XtRw5r/L0naoRuPEeCBEq+TfNcB6+H8o9brqq9
         aR1zQCoWIQUXGhqhJX4Gn6WHnTYltLUhGG7XJITetHRjMTOsNqBpYtyIqmvQvqrp5L
         4pmV+3E/MIHh0qBJiSNhrpmipkxUCHJbn+L6L2Lg=
Received: by wens.tw (Postfix, from userid 1000)
        id 1B4765FCE3; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] clk: sunxi-ng: clk parent rewrite part 1
Date:   Mon, 20 May 2019 16:03:56 +0800
Message-Id: <20190520080421.12575-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

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

I realize this is going to be many patches every time I convert a clock
type. Going forward would the people involved prefer I send out
individual patches like this series, or squash them all together?

Stephen, would it make sense for you to pick up the first 7 patches that
touch the clk core? And then we can base our clk branch on top of those?


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

 drivers/clk/clk.c                        |  10 ++-
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
 include/linux/clk-provider.h             |  84 ++++++++++++++++++
 18 files changed, 487 insertions(+), 223 deletions(-)

-- 
2.20.1

