Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D72CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC3820851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640947;
	bh=2yOBiJ/ADzN5mUmjQMi39EZs/vsECzak1Apuewu9mss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wOqefvOfHWtr8VOEfoDkHq6oIYXnGA1w+JfSTLp7hhx0dViWfLDrKtinMg/A4f1gK
	 7Ops4jYKDhcTjdJ7xDOJQDZXxYzR700sAMn6KTaKEHtFIXqDazERfCq/SdDNeP1pjb
	 gnp9ybDf3KHgv0Tk1DkjKqjc/Uu0aos+gsj8s204=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbfEWTL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387399AbfEWTLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:11:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35E2217D9;
        Thu, 23 May 2019 19:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638683;
        bh=2yOBiJ/ADzN5mUmjQMi39EZs/vsECzak1Apuewu9mss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wBNgIM9mM7BSWH+v13WCaonbyAHWST5L7mgDtIXlA4fsGRWN2aOhhwHD+W8ssTth7
         JgxZ9G8XUWanxFeGmJISez6WacmLYQd66fQktWkpOXbI1n/gtLpayjdb+raJk9Q7x6
         14IFNYvFSUea42mpuOvvCTpnK7pU+yCpPjrggTv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.14 26/77] clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides divider
Date:   Thu, 23 May 2019 21:05:44 +0200
Message-Id: <20190523181723.899390135@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

commit 40db569d6769ffa3864fd1b89616b1a7323568a8 upstream.

There are wrongly set parenthesis in the code that are resulting in a
wrong configuration being programmed for PLLM. The original fix was made
by Danny Huang in the downstream kernel. The patch was tested on Nyan Big
Tegra124 chromebook, PLLM rate changing works correctly now and system
doesn't lock up after changing the PLLM rate due to EMC scaling.

Cc: <stable@vger.kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/tegra/clk-pll.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -662,8 +662,8 @@ static void _update_pll_mnp(struct tegra
 		pll_override_writel(val, params->pmc_divp_reg, pll);
 
 		val = pll_override_readl(params->pmc_divnm_reg, pll);
-		val &= ~(divm_mask(pll) << div_nmp->override_divm_shift) |
-			~(divn_mask(pll) << div_nmp->override_divn_shift);
+		val &= ~((divm_mask(pll) << div_nmp->override_divm_shift) |
+			(divn_mask(pll) << div_nmp->override_divn_shift));
 		val |= (cfg->m << div_nmp->override_divm_shift) |
 			(cfg->n << div_nmp->override_divn_shift);
 		pll_override_writel(val, params->pmc_divnm_reg, pll);


