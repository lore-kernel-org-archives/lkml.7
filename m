Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B93C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9370E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564595417;
	bh=sXeNaRjTVOLrGCPtcQjJUIQeddouKntQ/oheDEB8pG4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Qrm4Bn5XviLoeKISI1/ccj/5EA77gJZAWrsWtrp46T+sdc7NGE+P0GKCoZw3nDxzc
	 lXjkebeQlxdyrHqQ+Ut6H70yFLnNj8a3WdcTHPwb97n8TmBKxTKeOEmCrsR20/cJph
	 QPYpx/45ajUTHV8GCLO3Iv2A6yS6/J3xtl6onze0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfGaRuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:50:16 -0400
Received: from foss.arm.com ([217.140.110.172]:52780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGaRuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:50:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4DE7169E;
        Wed, 31 Jul 2019 10:50:15 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252333F71F;
        Wed, 31 Jul 2019 10:50:12 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 5.3-rc3
Date:   Wed, 31 Jul 2019 18:50:00 +0100
Message-Id: <20190731175000.12948-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small bunch of fixes from the irqchip department. Nothing
major, just a number of fixes for error paths, a GPCv2 irq_set_type()
fix, and a bunch of /* fall-though */ annotation to keep the build
quiet.

Please pull.

	M.

The following changes since commit 3dae67ce600caaa92c9af6e0cb6cad2db2632a0a:

  irqchip/gic-pm: Remove PM_CLK dependency (2019-07-03 09:33:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.3

for you to fetch changes up to b5fa9fc9e809f84bb20439730162eccfed906a76:

  irqchip/renesas-rza1: Fix an use-after-free in rza1_irqc_probe() (2019-07-26 14:40:01 +0100)

----------------------------------------------------------------
irqchip fixes for 5.3

- Fix a couple of UAF on error paths (RZA1, GICv3 ITS)
- Fix iMX GPCv2 trigger setting
- Add missing of_node_put on error path in MBIGEN
- Add another bunch of /* fall-through */ to silence warnings

----------------------------------------------------------------
Anders Roxell (1):
      irqchip/gic-v3: Mark expected switch fall-through

Lucas Stach (1):
      irqchip/irq-imx-gpcv2: Forward irq type to parent

Nianyao Tang (1):
      irqchip/gic-v3-its: Free unused vpt_page when alloc vpe table fail

Nishka Dasgupta (1):
      irqchip/irq-mbigen: Add of_node_put() before return

Wen Yang (1):
      irqchip/renesas-rza1: Fix an use-after-free in rza1_irqc_probe()

 drivers/irqchip/irq-gic-v3-its.c   |  2 +-
 drivers/irqchip/irq-gic-v3.c       |  4 ++++
 drivers/irqchip/irq-imx-gpcv2.c    |  1 +
 drivers/irqchip/irq-mbigen.c       |  9 +++++++--
 drivers/irqchip/irq-renesas-rza1.c | 15 ++++++++-------
 5 files changed, 21 insertions(+), 10 deletions(-)
