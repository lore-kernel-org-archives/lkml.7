Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1647C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14E72067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611755;
	bh=t/kBS8ZyburwAEd/tWcHp44RfmpPV30AzLZAShq5ZZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GauGaipchf4S7cp10TvFTJpLVopPRtHbJGjnlfEHCEU315u+IemSpJ28G7xB5w4gm
	 9/jq9bxXahWdGz/m5xPuYX9/z8kAkrZ7MGnEwYsxIVE/0rMIZSKwkTrACZsXRP7DFX
	 VcD5zvj78CamC4vneP1MUNeSQgSATk54X+uEFJR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKMBxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfKMBxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:53:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0524F222CD;
        Wed, 13 Nov 2019 01:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609997;
        bh=t/kBS8ZyburwAEd/tWcHp44RfmpPV30AzLZAShq5ZZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ckoux5DLtGj81GLTtHgJg79eDwDZDUjiIRdlKDcwYDTwG8QIuBwZXnw2ZU2gObCmO
         OvIDPwlCZwgWEH09k1W1SEir/mBrqevNUSqGsj4QoLlyGhv4AEFSQzWpanIgW0oUj5
         FZV1hxAjfNnzCRu5MZT5oZ/83ekYeUO9WUFbWYvg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 106/209] clk: samsung: Use NOIRQ stage for Exynos5433 clocks suspend/resume
Date:   Tue, 12 Nov 2019 20:48:42 -0500
Message-Id: <20191113015025.9685-106-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 70da9ee80228e6d98fd68e3c1db124c4461d283c ]

SoC clock drivers should suspend after every other drivers in the system,
which are using clocks and resume before them. The last stage for calling
suspend device callbacks is NOIRQ stage and there exists driver, which use
that state (dwmmc-exynos), so Exynos5433 clocks driver should also use it.
During the same stage, clocks driver will be always suspended after its
clients as a direct result of proper device probe order (deferred probe
reorders the suspend call sequence).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <snawrocki@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5433.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 162de44df099b..426980514e679 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -5630,7 +5630,7 @@ static const struct of_device_id exynos5433_cmu_of_match[] = {
 static const struct dev_pm_ops exynos5433_cmu_pm_ops = {
 	SET_RUNTIME_PM_OPS(exynos5433_cmu_suspend, exynos5433_cmu_resume,
 			   NULL)
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				     pm_runtime_force_resume)
 };
 
-- 
2.20.1

