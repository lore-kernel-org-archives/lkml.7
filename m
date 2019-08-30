Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8566C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5772341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177766;
	bh=urqI24R4Tky6Gl0utQFu04g6HRXBk4eUkS4cN9ptgqE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=crSTRZ7p/2HK/4UQlR2jOIUsBdZtO8LBlRRqn3K8vcjMh1Q8vRmBQ9Vjv5tnESjoN
	 U6TfvgtGW4rdXBAM3qPfdO0JefxsU170Vf18JLkmeW4T5dcyCgfbRahB+cqwI7EzSG
	 zwymZ3aUUuL7JXhl6cFGBYfP6UrmDhUgPV+BtPmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfH3PJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfH3PJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:25 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E21D523407;
        Fri, 30 Aug 2019 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177764;
        bh=urqI24R4Tky6Gl0utQFu04g6HRXBk4eUkS4cN9ptgqE=;
        h=From:To:Cc:Subject:Date:From;
        b=nIt7IS5UstXqE2AIgqF915TRB0tiOWUjSeLWr+jeroLIuyWfNjb7/qhyGi+bWi03r
         Fn8pgtY+IRy3SOn3d0g27EWRLoc4bxgvk1zcPgqdF9DE+VqK0xopnlprkAbQtyvvq7
         xOC+X48s/txWo5ahh/NmKmwkR1z6gt3NXvcwfgwA=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Simon Horman <horms@verge.net.au>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/12] Convert some basic type clks to new parent way
Date:   Fri, 30 Aug 2019 08:09:11 -0700
Message-Id: <20190830150923.259497-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts most of the basic clk types to support the new way
of specifying parents. There's still the composite and fixed-factor
types to convert. Sending now because I'm internally debating having the
big multiplexer function take only arguments that would correspond to
the parent_data structure instead of passing down the three different
ways of specifying parents.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Simon Horman <horms@verge.net.au>
Cc: Tony Lindgren <tony@atomide.com>

Stephen Boyd (12):
  clk: gpio: Use DT way of specifying parents
  clk: fixed-rate: Convert to clk_hw based APIs
  clk: fixed-rate: Remove clk_register_fixed_rate_with_accuracy()
  clk: fixed-rate: Move to_clk_fixed_rate() to C file
  clk: fixed-rate: Document accuracy member
  clk: fixed-rate: Add support for specifying parents via DT/pointers
  clk: fixed-rate: Add clk flags for parent accuracy
  clk: fixed-rate: Document that accuracy isn't a rate
  clk: asm9260: Use parent accuracy in fixed rate clk
  clk: mux: Add support for specifying parents via DT/pointers
  clk: gate: Add support for specifying parents via DT/pointers
  clk: divider: Add support for specifying parents via DT/pointers

 drivers/clk/clk-asm9260.c                  |   8 +-
 drivers/clk/clk-divider.c                  |  84 +----
 drivers/clk/clk-fixed-rate.c               | 113 +++---
 drivers/clk/clk-gate.c                     |  35 +-
 drivers/clk/clk-gpio.c                     | 171 +++------
 drivers/clk/clk-mux.c                      |  58 +--
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c |   4 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c |   4 +-
 include/linux/clk-provider.h               | 416 +++++++++++++++++----
 9 files changed, 490 insertions(+), 403 deletions(-)


base-commit: 5f9e832c137075045d15cd6899ab0505cfb2ca4b
-- 
Sent by a computer through tubes

