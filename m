Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7318CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EE920833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483055;
	bh=GNrThHvp51OQUW6thM0FBK86TAxOtmVirBWYAuPFsDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1OSPCkEBtroQk6sO6bw1raR1HQSRk8wDM1ryA9PHkCZ4o8U0mCsfcI6FQxAnw1Ogc
	 Y2ST6B3ig3nR+t6DRu2ezYfGoKmBAFFq0UTXlUqvkGsxIMVOlG4YhpWkGB+eDYS7YH
	 WMKaQZ1dDo4UupeSE6DysrM/1U5nriNdHwXnQxtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfLDSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731325AbfLDSKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:10:48 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54C9120833;
        Wed,  4 Dec 2019 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483047;
        bh=GNrThHvp51OQUW6thM0FBK86TAxOtmVirBWYAuPFsDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeqAPmI+A8yJmeFpIU4VjpsLHdg2W86VahPFY1bn+ZcPIKLg8B4BDhUkShCUSmkGz
         YCwfzVn3SkAKdnODVyFuLzEF8cLlZb7fKoSGTPBqU5TwtSK5bTFBmizS3i75c5JbqU
         uZrwPADCkh3cppkdHXFJ2eawNgrJL1tloxUMAC9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Reported-by: Marian Mihailescu" <mihailescu2m@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 003/125] clk: samsung: exynos5420: Preserve PLL configuration during suspend/resume
Date:   Wed,  4 Dec 2019 18:55:08 +0100
Message-Id: <20191204175310.136962421@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit e9323b664ce29547d996195e8a6129a351c39108 ]

Properly save and restore all top PLL related configuration registers
during suspend/resume cycle. So far driver only handled EPLL and RPLL
clocks, all other were reset to default values after suspend/resume cycle.
This caused for example lower G3D (MALI Panfrost) performance after system
resume, even if performance governor has been selected.

Reported-by: Reported-by: Marian Mihailescu <mihailescu2m@gmail.com>
Fixes: 773424326b51 ("clk: samsung: exynos5420: add more registers to restore list")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 13c09a740840b..2bb88d1251136 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -170,12 +170,18 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
 	GATE_BUS_CPU,
 	GATE_SCLK_CPU,
 	CLKOUT_CMU_CPU,
+	CPLL_CON0,
+	DPLL_CON0,
 	EPLL_CON0,
 	EPLL_CON1,
 	EPLL_CON2,
 	RPLL_CON0,
 	RPLL_CON1,
 	RPLL_CON2,
+	IPLL_CON0,
+	SPLL_CON0,
+	VPLL_CON0,
+	MPLL_CON0,
 	SRC_TOP0,
 	SRC_TOP1,
 	SRC_TOP2,
-- 
2.20.1



