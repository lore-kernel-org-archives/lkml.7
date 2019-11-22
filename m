Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557BAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CEB20721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420484;
	bh=221mBZOSqyC1aa3HHmVpBQpmE2Dgo0l8iN1fqn2XFIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IGv3gn/bDIXyDqAx13vXLwyy9J9DJkN8Y9x6jYdvZzFDs+AB20+ru0JJe/h5LYI6s
	 /5JKfxrc2fDwAUVzIvO766Tj4yuDQl1UZ2mknyCfss1MrqJym1YUSYcA++5SVypciT
	 Lstia/vsd4sqhTMb/v8/PF6u+r8Zu0Ela8EeLlCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfKVLBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731164AbfKVLBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED5C720706;
        Fri, 22 Nov 2019 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420478;
        bh=221mBZOSqyC1aa3HHmVpBQpmE2Dgo0l8iN1fqn2XFIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGWyxjbxxFiVQZeNYBWVrvpRES6kMvfWfhM1BNr6Yhh+sFek2INTqXiZzeM4iD+07
         byW8DW86JuvloVcV+ugc/xfIbxaRXV0ZvezirUIsuRiri499KpuieuLAClzW2h9VKm
         i0XQWx5Dn/S3sQMASUW/rSKgUW8OTT1mofPFXe44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 118/220] clk: samsung: exynos5420: Define CLK_SECKEY gate clock only or Exynos5420
Date:   Fri, 22 Nov 2019 11:28:03 +0100
Message-Id: <20191122100921.215277501@linuxfoundation.org>
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

From: Joonyoung Shim <jy0922.shim@samsung.com>

[ Upstream commit d32dd2a1a0f80edad158c9a1ba5f47650d9504a0 ]

The bit of GATE_BUS_PERIS1 for CLK_SECKEY is just reserved on
exynos5422/5800, not exynos5420. Define gate clk for exynos5420 to
handle the bit only on exynos5420.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
[m.szyprow: rewrote commit subject]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <snawrocki@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index d4f77c4eb277a..ce30862617a6e 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -634,6 +634,7 @@ static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
 };
 
 static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
+	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
 	GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
 			SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
 };
@@ -1163,8 +1164,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	GATE(CLK_TMU, "tmu", "aclk66_psgen", GATE_IP_PERIS, 21, 0, 0),
 	GATE(CLK_TMU_GPU, "tmu_gpu", "aclk66_psgen", GATE_IP_PERIS, 22, 0, 0),
 
-	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
-
 	/* GEN Block */
 	GATE(CLK_ROTATOR, "rotator", "mout_user_aclk266", GATE_IP_GEN, 1, 0, 0),
 	GATE(CLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
-- 
2.20.1



