Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E7CC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E952178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573195687;
	bh=5ehIjc5Yy9N8ZK9Q22S7SU88rwFhRt5pj5lJ4r51De8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NABIKrU60jqaHjZEjN84pruEJQge6p86Qc6/GP6+nA7J/S3fRIZB5GOxVUhTnWVuQ
	 yUG6rjVrGeuatc2w/lbvNqnURyayZu8U/uIKWHjLIB4z97ApPeEuV+DK5hO28w9Bza
	 DuTzZBxBNJKYSVgAjSpJaEoqB4KFarbz+yEt5NrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfKHGsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 01:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfKHGsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 01:48:05 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E902178F;
        Fri,  8 Nov 2019 06:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573195684;
        bh=5ehIjc5Yy9N8ZK9Q22S7SU88rwFhRt5pj5lJ4r51De8=;
        h=From:To:Cc:Subject:Date:From;
        b=xHTT5zciUTcsjZ1uqLDo2Mlfr0mJau4kuRcQsOwuhFUapsbAwzmk5JZcwzhM+CbUm
         VTTqR9DJEhTUbEt99Ks+w4DuXaV8kj/rhkxN0tfEp0f5lVP3vyXaAG3UQ96bieaiAx
         bU7Bo8OOpLIdSgFN7ocGc+RZ+ta/zERmdOyM2218=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.4-rc6
Date:   Thu,  7 Nov 2019 22:48:03 -0800
Message-Id: <20191108064803.9977-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 5a60b5aa96e8619baf02865e3002704fc2897731:

  Merge tag 'clk-v5.4-samsung-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk into clk-fixes (2019-11-04 09:59:33 -0800)

----------------------------------------------------------------
Fixes for various clk driver issues that happened because of code we
merged this merge window. The Amlogic driver was missing some flags
causing rates to be rounded improperly or clk_set_rate() to fail. The
Samsung driver wasn't freeing everything on error paths and improperly
saving/restoring PLL state across suspend/resume. The at91 driver was
calling msleep() too early when scheduling hadn't started, so we put in
place a quick solution until we can handle this sort of problem in the
core framework. There were also problems with the Allwinner driver and
operator precedence being incorrect causing subtle bugs. Finally, the TI
driver was duplicating aliases and not delaying long enough leading to
some unexpected timeouts.

----------------------------------------------------------------
Alexandre Belloni (1):
      clk: at91: avoid sleeping early

Colin Ian King (1):
      clk: sunxi-ng: a80: fix the zero'ing of bits 16 and 18

Eugen Hristev (1):
      clk: at91: sam9x60: fix programmable clock

Joel Stanley (1):
      clk: ast2600: Fix enabling of clocks

Leonard Crestez (1):
      clk: imx8m: Use SYS_PLL1_800M as intermediate parent of CLK_ARM

Marek Szyprowski (3):
      clk: samsung: exynos5433: Fix error paths
      clk: samsung: exynos542x: Move G3D subsystem clocks to its sub-CMU
      clk: samsung: exynos5420: Preserve PLL configuration during suspend/resume

Martin Blumenstingl (1):
      clk: meson: gxbb: let sar_adc_clk_div set the parent clock rate

Nathan Chancellor (1):
      clk: sunxi: Fix operator precedence in sunxi_divs_clk_setup

Neil Armstrong (2):
      clk: meson: g12a: fix cpu clock rate setting
      clk: meson: g12a: set CLK_MUX_ROUND_CLOSEST on the cpu clock muxes

Peter Ujfalusi (1):
      clk: ti: dra7-atl-clock: Remove ti_clk_add_alias call

Stephen Boyd (3):
      Merge tag 'clk-meson-fixes-v5.4-1' of https://github.com/BayLibre/clk-meson into clk-fixes
      Merge tag 'sunxi-clk-fixes-for-5.4-1' of https://git.kernel.org/.../sunxi/linux into clk-fixes
      Merge tag 'clk-v5.4-samsung-fixes' of https://git.kernel.org/.../snawrocki/clk into clk-fixes

Tony Lindgren (1):
      clk: ti: clkctrl: Fix failed to enable error with double udelay timeout

 drivers/clk/at91/clk-main.c          |  5 ++++-
 drivers/clk/at91/sam9x60.c           |  1 +
 drivers/clk/at91/sckc.c              | 20 ++++++++++++++++----
 drivers/clk/clk-ast2600.c            |  7 ++++---
 drivers/clk/imx/clk-imx8mm.c         |  2 +-
 drivers/clk/imx/clk-imx8mn.c         |  2 +-
 drivers/clk/meson/g12a.c             | 13 +++++++++++--
 drivers/clk/meson/gxbb.c             |  1 +
 drivers/clk/samsung/clk-exynos5420.c | 27 +++++++++++++++++++++++++--
 drivers/clk/samsung/clk-exynos5433.c | 14 ++++++++++++--
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c |  2 +-
 drivers/clk/sunxi/clk-sunxi.c        |  4 ++--
 drivers/clk/ti/clk-dra7-atl.c        |  6 ------
 drivers/clk/ti/clkctrl.c             |  5 +++--
 14 files changed, 82 insertions(+), 27 deletions(-)

-- 
Sent by a computer through tubes
