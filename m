Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A78C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 04:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F37021927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 04:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576901393;
	bh=6Jtau3362NuZSeWe5mH+jT+l23lapVjJ8jUZD8wIpxA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zJOciEdcYkTWOvJ03/lfwE9ks88K5bvdBE9bV4wxoxcrddRvPXf4Fqb5YE2UhTONC
	 Qz6ZytOjNWc6xoJzaLDZZRMVokFRpTTwClnfMI452hdtJ36777ADEYaEOD6nbpheF5
	 ZrIwZmJLzq0nWlCbMy2Pk6+eaRGeq2xVfPyQpXkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLUEJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 23:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfLUEJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 23:09:52 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6EB206DA;
        Sat, 21 Dec 2019 04:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576901391;
        bh=6Jtau3362NuZSeWe5mH+jT+l23lapVjJ8jUZD8wIpxA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZN3XOClbWPo40aA0hKMpG9HzC8D+R+6d5aYlKEJBoo8Nk6yF9LZHdK9yC4rYc1uh5
         k7QSqVcem80v++yTBo5Rt7dMDjrZD7JFT10+g5ro9nDJFHWqpkaK9ckRUJBqmGjIqe
         I20PVGNqnzxNrc/NmtSEsYQ81FHR0rGZxxl7iLjo=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.5-rc2
Date:   Fri, 20 Dec 2019 20:09:50 -0800
Message-Id: <20191221040950.59130-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 781d8cea68ac41d11a80df2a5f5babd584f86447:

  clk: qcom: Avoid SMMU/cx gdsc corner cases (2019-12-18 22:02:27 -0800)

----------------------------------------------------------------
One core framework fix to walk the orphan list and match up clks to
parents when clk providers register the DT provider after registering
all their clks (as they should). Then a handful of driver fixes for the
qcom, imx, and at91 drivers. The driver fixes are relatively small fixes
for incorrect register settings or missing locks causing race
conditions.

----------------------------------------------------------------
Alexandre Belloni (1):
      clk: at91: fix possible deadlock

Jeffrey Hugo (1):
      clk: qcom: Avoid SMMU/cx gdsc corner cases

Jerome Brunet (1):
      clk: walk orphan list on clock provider registration

Matthias Kaehlcke (1):
      clk: qcom: gcc-sc7180: Fix setting flag for votable GDSCs

Olof Johansson (1):
      clk: Move clk_core_reparent_orphans() under CONFIG_OF

Peng Fan (3):
      clk: imx: clk-composite-8m: add lock to gate/mux
      clk: imx: clk-imx7ulp: Add missing sentinel of ulp_div_table
      clk: imx: pll14xx: fix clk_pll14xx_wait_lock

Stephen Boyd (1):
      Merge tag 'imx-clk-fixes-5.5' of git://git.kernel.org/.../shawnguo/linux into clk-fixes

 drivers/clk/at91/at91sam9260.c     |  2 +-
 drivers/clk/at91/at91sam9rl.c      |  2 +-
 drivers/clk/at91/at91sam9x5.c      |  2 +-
 drivers/clk/at91/pmc.c             |  2 +-
 drivers/clk/at91/sama5d2.c         |  2 +-
 drivers/clk/at91/sama5d4.c         |  2 +-
 drivers/clk/clk.c                  | 62 ++++++++++++++++++++++++--------------
 drivers/clk/imx/clk-composite-8m.c |  2 ++
 drivers/clk/imx/clk-imx7ulp.c      |  1 +
 drivers/clk/imx/clk-pll14xx.c      |  2 +-
 drivers/clk/qcom/gcc-sc7180.c      |  6 ++--
 drivers/clk/qcom/gpucc-msm8998.c   |  2 ++
 12 files changed, 56 insertions(+), 31 deletions(-)

-- 
Sent by a computer, using git, on the internet
