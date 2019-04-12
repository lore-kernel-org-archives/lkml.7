Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18808C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92A22084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555111270;
	bh=AE9f2pHcHkK0L4rZHgqYjhFucbpRz971YcYWLtEL7IE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hRreEIUwyr2KKlQIgA2CdaPTbpzp1vGFXqPjrKyQ4GhEqyixKUhlzQYfsHlEPf8ar
	 X44RqOY/anilkruLsMbg0+w5FyhYQBJ3i4kmdgepoqtBbmOk7BFbA3JIFKdPWh+4cq
	 fF57a3m8tiN3CM1hJm11hqddjLXHODeyGhm4JVPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDLXVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfDLXVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 19:21:09 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3582084D;
        Fri, 12 Apr 2019 23:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555111268;
        bh=AE9f2pHcHkK0L4rZHgqYjhFucbpRz971YcYWLtEL7IE=;
        h=From:To:Cc:Subject:Date:From;
        b=Z5tcUlxGHYRlKeVNM5uuOV3KhTr+P2SMI3Ln93RBAP8aEFMBwDGiz7+lAMWGG35kj
         FN6Ol+e47AyGXhQkx5YB+As2pOaRA/F6eajGxs/rnDfq7i3YNCTPacqGjrhydcpa2c
         eKRf9olqk0ASq91lATuMT4F9AugX9ygLpZcE6pPo=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.1-rc4
Date:   Fri, 12 Apr 2019 16:21:07 -0700
Message-Id: <20190412232107.26830-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to f89b9e1be7da8bb0aac667a0206a00975cefe6d3:

  clk: imx: Fix PLL_1416X not rounding rates (2019-04-12 14:21:43 -0700)

----------------------------------------------------------------
Here's more than a handful of clk driver fixes for changes that came in
during the merge window:

 - Fix the AT91 sama5d2 programmable clk prescaler formula

 - A bunch of Amlogic meson clk driver fixes for the VPU clks

 - A DMI quirk for Intel's Bay Trail SoC's driver to properly mark
   pmc clks as critical only when really needed

 - Stop overwriting CLK_SET_RATE_PARENT flag in mediatek's clk gate
   implementation

 - Use the right structure to test for a frequency table in i.MX's
   PLL_1416x driver

----------------------------------------------------------------
David Müller (1):
      clk: x86: Add system specific quirk to mark clocks as critical

Leonard Crestez (1):
      clk: imx: Fix PLL_1416X not rounding rates

Martin Blumenstingl (1):
      clk: meson: pll: fix rounding and setting a rate that matches precisely

Matthias Wieloch (1):
      clk: at91: fix programmable clock for sama5d2

Maxime Jourdan (2):
      clk: meson-gxbb: round the vdec dividers to closest
      clk: meson: g12a: fix VPU clock muxes mask

Neil Armstrong (2):
      clk: meson-g12a: fix VPU clock parents
      clk: meson: vid-pll-div: remove warning and return 0 on invalid config

Stephen Boyd (3):
      Merge tag 'meson-clk-fixes-for-5.1' of https://github.com/BayLibre/clk-meson into clk-fixes
      Merge tag 'meson-clk-fixes-for-5.1-v2' of https://github.com/BayLibre/clk-meson into clk-fixes
      platform/x86: pmc_atom: Drop __initconst on dmi table

Weiyi Lu (1):
      clk: mediatek: fix clk-gate flag setting

 drivers/clk/at91/clk-programmable.c            | 57 +++++++++++++++++++-------
 drivers/clk/at91/pmc.h                         |  2 +
 drivers/clk/at91/sama5d2.c                     | 10 ++++-
 drivers/clk/imx/clk-pll14xx.c                  |  2 +-
 drivers/clk/mediatek/clk-gate.c                |  3 +-
 drivers/clk/meson/clk-pll.c                    |  2 +-
 drivers/clk/meson/g12a.c                       |  6 +--
 drivers/clk/meson/gxbb.c                       |  2 +
 drivers/clk/meson/vid-pll-div.c                |  4 +-
 drivers/clk/x86/clk-pmc-atom.c                 | 14 +++++--
 drivers/platform/x86/pmc_atom.c                | 21 ++++++++++
 include/linux/platform_data/x86/clk-pmc-atom.h |  3 ++
 12 files changed, 99 insertions(+), 27 deletions(-)

-- 
Sent by a computer through tubes
