Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9739FC004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7261F20665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561667152;
	bh=I9NSv9sbBhwgKZQjsXY6lP1+iWLSMecAorV7s1EJEfU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LOcjdUx9TIuXX+YA3cqScOak7i5L7ol4fkNN0pG8R2ltOMVx9A5XPgGJy84D9iY9b
	 fANInh/6KDXnVYuV1SGyl+/bZmu0pe0IW7SoTp/i8of9QvdjTQxowA7cf/F3j18sF3
	 EtrrWzThGSVzdJX0HF/93aBnRXUVjvWtzwyQtYKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfF0UZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfF0UZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:25:50 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8148820665;
        Thu, 27 Jun 2019 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561667149;
        bh=I9NSv9sbBhwgKZQjsXY6lP1+iWLSMecAorV7s1EJEfU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ym7msgxzEJB1mvNZbYNhb2tCXlGFP2wQ/LhbO2+Or6fksQcvqQjGjvw2zfGS+Qq0o
         bKZCgjGCh8ND7DAU0NqDm27NzBrkG+C6s5v2xKyoAiPnnSS/KG+u2rbkr0vytSoBge
         wdF4IM+oXFxm1Hzi4cFT0wm+1QoqNV5WM0eLd9Lo=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.2-rc6
Date:   Thu, 27 Jun 2019 13:25:49 -0700
Message-Id: <20190627202549.45667-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1cc54078d104f5b4d7e9f8d55362efa5a8daffdb:

  clk: ti: clkctrl: Fix clkdm_clk handling (2019-05-21 11:43:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 74684cce5ebd567b01e9bc0e9a1945c70a32f32f:

  clk: socfpga: stratix10: fix divider entry for the emac clocks (2019-06-25 13:40:05 -0700)

----------------------------------------------------------------
A handful of clk driver fixes and one core framework fix

 - Do a DT/firmware lookup in clk_core_get() even when the DT index is a
   nonsensical value

 - Fix some clk data typos in the Amlogic DT headers/code

 - Avoid returning junk in the TI clk driver when an invalid clk is
   looked for

 - Fix dividers for the emac clks on Stratix10 SoCs

 - Fix default HDA rates on Tegra210 to correct distorted audio

----------------------------------------------------------------
Dinh Nguyen (1):
      clk: socfpga: stratix10: fix divider entry for the emac clocks

Jerome Brunet (1):
      clk: meson: fix MPLL 50M binding id typo

Jon Hunter (1):
      clk: tegra210: Fix default rates for HDA clocks

Martin Blumenstingl (1):
      clk: meson: meson8b: fix a typo in the VPU parent names array variable

Stephen Boyd (2):
      Merge tag 'clk-meson-5.2-1-fixes' of https://github.com/BayLibre/clk-meson into clk-fixes
      clk: Do a DT parent lookup even when index < 0

Tony Lindgren (1):
      clk: ti: clkctrl: Fix returning uninitialized data

 drivers/clk/clk.c                     |  2 +-
 drivers/clk/meson/g12a.c              |  4 ++--
 drivers/clk/meson/g12a.h              |  2 +-
 drivers/clk/meson/meson8b.c           | 10 +++++-----
 drivers/clk/socfpga/clk-s10.c         |  4 ++--
 drivers/clk/tegra/clk-tegra210.c      |  2 ++
 drivers/clk/ti/clkctrl.c              |  7 +++++--
 include/dt-bindings/clock/g12a-clkc.h |  2 +-
 8 files changed, 19 insertions(+), 14 deletions(-)

-- 
Sent by a computer through tubes
