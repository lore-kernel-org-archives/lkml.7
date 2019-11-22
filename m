Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062E5C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D309720748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420478;
	bh=t/kBS8ZyburwAEd/tWcHp44RfmpPV30AzLZAShq5ZZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l6I36E+Tw/ndM9iyi5QFSFl3+OnvoZ/ZWqUfYQ7DWPlIETHCC8AkJB9FseDZl5xX8
	 PI5+rhLEhjEqs1gctAFsXA3MWj/0iN3GJH1tf5IgDxB3oXKQmyc2/5+mDzmounKEAH
	 p15f0P3tzobaHdGb12SV7l1oCNPJe11R+b6ju4C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfKVLBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731143AbfKVLBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E8820706;
        Fri, 22 Nov 2019 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420475;
        bh=t/kBS8ZyburwAEd/tWcHp44RfmpPV30AzLZAShq5ZZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJYQaQZbRKt9Aj1Km/ZlLRQdqoJdBW/dWSwTIaQkBChP/IlUvZMTZkQO2PnE7xZzk
         h61LrDN4SeAhMIM2v9Qmb9L1UiyVSZbbOc3zFbeFLZfRRT8BGFR1X3Odjz9nrNqgg0
         ASAwKO688ne0PZMA7oSDQ86nm+cwvnLqCjFEuxuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/220] clk: samsung: Use NOIRQ stage for Exynos5433 clocks suspend/resume
Date:   Fri, 22 Nov 2019 11:28:02 +0100
Message-Id: <20191122100921.147300962@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



