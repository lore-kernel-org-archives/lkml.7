Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F52C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41372173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfLKJ0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:26:04 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42470 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfLKJ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:26:04 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 295812008DD;
        Wed, 11 Dec 2019 10:26:02 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B830200987;
        Wed, 11 Dec 2019 10:26:02 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9715620568;
        Wed, 11 Dec 2019 10:26:01 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v2 00/11] clk: imx: Trivial cleanups for clk_hw based API
Date:   Wed, 11 Dec 2019 11:25:39 +0200
Message-Id: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn, just rebased on your clk/imx branch as requested.

Abel Vesa (11):
  clk: imx: Add correct failure handling for clk based helpers
  clk: imx: Rename the SCCG to SSCG
  clk: imx: Replace all the clk based helpers with macros
  clk: imx: pllv1: Switch to clk_hw based API
  clk: imx: pllv2: Switch to clk_hw based API
  clk: imx: imx7ulp composite: Rename to show is clk_hw based
  clk: imx: Rename sccg and frac pll register to suggest clk_hw
  clk: imx: Rename the imx_clk_pllv4 to imply it's clk_hw based
  clk: imx: Rename the imx_clk_pfdv2 to imply it's clk_hw based
  clk: imx: Rename the imx_clk_divider_gate to imply it's clk_hw based
  clk: imx7up: Rename the clks to hws

 drivers/clk/imx/Makefile             |   2 +-
 drivers/clk/imx/clk-composite-7ulp.c |   2 +-
 drivers/clk/imx/clk-divider-gate.c   |   2 +-
 drivers/clk/imx/clk-frac-pll.c       |   7 +-
 drivers/clk/imx/clk-imx7ulp.c        | 182 ++++++------
 drivers/clk/imx/clk-imx8mq.c         |   6 +-
 drivers/clk/imx/clk-pfdv2.c          |   2 +-
 drivers/clk/imx/clk-pllv1.c          |  14 +-
 drivers/clk/imx/clk-pllv2.c          |  14 +-
 drivers/clk/imx/clk-pllv4.c          |   2 +-
 drivers/clk/imx/clk-sccg-pll.c       | 549 -----------------------------------
 drivers/clk/imx/clk-sscg-pll.c       | 549 +++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h                | 102 ++++---
 13 files changed, 724 insertions(+), 709 deletions(-)
 delete mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 drivers/clk/imx/clk-sscg-pll.c

-- 
2.7.4

