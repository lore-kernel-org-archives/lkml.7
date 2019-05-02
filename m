Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F114C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F0C2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556830003;
	bh=+iqD5SnNrrJIdoo7MTK34t9LYNPBy0FRPLXiJ6oRojU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SXzxR9I3bpNQzKLmmEOkOba2+PdHFUj1j9/Mu710EtzIQjOGNWLpFADlPva2lrxBi
	 mz8Rjhg2p+/Hx0ygcMhaL2LQN1LP3VobC2w+no7DctAWZhZkIOp7RQ2M9ZUoPnrh4Y
	 CyIHlS/U/q67c0gIccwa2hpnV7hDoyz4UJxsVPvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEBUql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBUql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:46:41 -0400
Received: from mail.kernel.org (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4102081C;
        Thu,  2 May 2019 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556830000;
        bh=+iqD5SnNrrJIdoo7MTK34t9LYNPBy0FRPLXiJ6oRojU=;
        h=From:To:Cc:Subject:Date:From;
        b=f4IlykwBG55mpJCrj5NizV8957nyprp6IG1ARqmQm9I+/q0q+FgFsUMG+LzUnLsC+
         ERBDsrTPwZNMdeE/4JRDAln9CevEk9EuoZ6IGydWhpalC7HzNXMzXxynvdK1NE8LFu
         cRgbp2RmVX7Ero0bzGbnF5APxLXAVyWx2J+E3OIY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.1-rc7
Date:   Thu,  2 May 2019 13:46:40 -0700
Message-Id: <20190502204640.26046-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f89b9e1be7da8bb0aac667a0206a00975cefe6d3:

  clk: imx: Fix PLL_1416X not rounding rates (2019-04-12 14:21:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to b88c9f4129dcec941e5a26508e991c08051ed1ac:

  clk: Add missing stubs for a few functions (2019-04-25 08:19:15 -0700)

----------------------------------------------------------------
Two fixes for the NKMP clks on Allwinner SoCs, a locking fix for clkdev
where we forgot to hold a lock while iterating a list that can change,
and finally a build fix that adds some stubs for clk APIs that are used
by devfreq drivers on platforms without the clk APIs.

----------------------------------------------------------------
Dmitry Osipenko (1):
      clk: Add missing stubs for a few functions

Jernej Skrabec (2):
      clk: sunxi-ng: nkmp: Avoid GENMASK(-1, 0)
      clk: sunxi-ng: nkmp: Explain why zero width check is needed

Stephen Boyd (2):
      clkdev: Hold clocks_mutex while iterating clocks list
      Merge tag 'clk-fixes-for-5.1' of https://git.kernel.org/.../sunxi/linux into clk-fixes

 drivers/clk/clkdev.c            |  5 +++++
 drivers/clk/sunxi-ng/ccu_nkmp.c | 24 +++++++++++++++++++-----
 include/linux/clk.h             | 16 ++++++++++++++++
 3 files changed, 40 insertions(+), 5 deletions(-)

-- 
Sent by a computer through tubes
