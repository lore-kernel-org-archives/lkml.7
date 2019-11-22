Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8A6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F222070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419983;
	bh=mBWSYqzntZrRXyv64akBAkmmXnttEMUiQhS1mPu6nLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=evHAfBsiZ+y3T/uqImrg5vOeZjU7qeqlfir6znr35KQbc6zx3u/3uGExVHl77DVQP
	 LnyZBro2Zfcc0ME8InVXrB6eeNeCmqO6StSPMb5esYhhArB0KUyhV+JbdS5s5knEGH
	 z70Qoj3JqokGaZ9SyegaYnB9UqccYAP4ezpIcu6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfKVKxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbfKVKw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:52:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECFAD2070E;
        Fri, 22 Nov 2019 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419977;
        bh=mBWSYqzntZrRXyv64akBAkmmXnttEMUiQhS1mPu6nLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZWJpA5fLJg+GtToBs0HRMifwewvsnSGW5yDkykjB0fxx7XQ7vgAIOwPKCrlWu4zc
         1v4GuG/puJqlzTvion3m+bfSmnPFnXF5vDVOszQKJwGnnfOzIdOiuBsQfvrtuoLqzc
         CVcYqRcvO+FLoV7KCuGstCW1jdI5vVxVFWlglZU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 071/122] clk: samsung: Use clk_hw API for calling clk framework from clk notifiers
Date:   Fri, 22 Nov 2019 11:28:44 +0100
Message-Id: <20191122100812.169654382@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 1da220e3a5d22fccda0bc8542997abc1d1741268 ]

clk_notifier_register() documentation states, that the provided notifier
callbacks associated with the notifier must not re-enter into the clk
framework by calling any top-level clk APIs. Fix this by replacing
clk_get_rate() calls with clk_hw_get_rate(), which is safe in this
context.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <snawrocki@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-cpu.c | 6 +++---
 drivers/clk/samsung/clk-cpu.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 6686e8ba61f9f..82f023f29a61f 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -152,7 +152,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 			struct exynos_cpuclk *cpuclk, void __iomem *base)
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
-	unsigned long alt_prate = clk_get_rate(cpuclk->alt_parent);
+	unsigned long alt_prate = clk_hw_get_rate(cpuclk->alt_parent);
 	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
 	unsigned long div0, div1 = 0, mux_reg;
 	unsigned long flags;
@@ -280,7 +280,7 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 			struct exynos_cpuclk *cpuclk, void __iomem *base)
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
-	unsigned long alt_prate = clk_get_rate(cpuclk->alt_parent);
+	unsigned long alt_prate = clk_hw_get_rate(cpuclk->alt_parent);
 	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
 	unsigned long div0, div1 = 0, mux_reg;
 	unsigned long flags;
@@ -432,7 +432,7 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	else
 		cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
 
-	cpuclk->alt_parent = __clk_lookup(alt_parent);
+	cpuclk->alt_parent = __clk_get_hw(__clk_lookup(alt_parent));
 	if (!cpuclk->alt_parent) {
 		pr_err("%s: could not lookup alternate parent %s\n",
 				__func__, alt_parent);
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index d4b6b517fe1b4..bd38c6aa38970 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -49,7 +49,7 @@ struct exynos_cpuclk_cfg_data {
  */
 struct exynos_cpuclk {
 	struct clk_hw				hw;
-	struct clk				*alt_parent;
+	struct clk_hw				*alt_parent;
 	void __iomem				*ctrl_base;
 	spinlock_t				*lock;
 	const struct exynos_cpuclk_cfg_data	*cfg;
-- 
2.20.1



