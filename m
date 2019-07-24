Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5869EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B17920665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998450;
	bh=LnJ/zuDzd0vpU1UgBAZNCiNM5VuklKsneqiGYSo0EL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D0IQzwSs92bGoj6rrKSDz5qvnAbn28C6HoIcaQXhXe8+S5zGqUYVzv7CS+VET0Ww+
	 xatATsP016CfvbE3hGDmYE4hJAT4WQdYwXucbzGPe0LLVKXbO2qW3BxNAwYmShdloF
	 ytBoL97SoLzA6egmwDOUPE3GihtBg8xG7kNbijL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404978AbfGXUAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405236AbfGXUAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:00:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37AB1206BA;
        Wed, 24 Jul 2019 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998437;
        bh=LnJ/zuDzd0vpU1UgBAZNCiNM5VuklKsneqiGYSo0EL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9eOyaqCVD0t67RxnLXi5aMUFYZS6tgMM7wiWstpGiC4jwY41Zqc1bn8qaX4W+KPC
         hac1irij0SJAKAmt3do5ZuA5t+dmFD+RmXkwXekg8Mqj+yy+f26KPZpTGQlRUkDzRu
         G5V1ws68Jp+h6F9Oti+ZU1CuRXfW+50V0gpoIrkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.1 365/371] clk: imx: imx8mm: correct audio_pll2_clk to audio_pll2_out
Date:   Wed, 24 Jul 2019 21:21:57 +0200
Message-Id: <20190724191751.675122633@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 5b933e28d8b1fbdc7fbac4bfc569f3b152c3dd59 upstream.

There is no audio_pll2_clk registered, it should be audio_pll2_out.

Cc: <stable@vger.kernel.org>
Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/imx/clk-imx8mm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -325,7 +325,7 @@ static const char *imx8mm_dsi_dbi_sels[]
 					    "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll1_out", };
 
 static const char *imx8mm_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
-					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_clk", "sys_pll1_100m", };
+					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
 
 static const char *imx8mm_csi1_core_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m", "sys_pll1_800m",
 					      "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll1_out", };
@@ -361,11 +361,11 @@ static const char *imx8mm_pdm_sels[] = {
 					"sys_pll2_1000m", "sys_pll3_out", "clk_ext3", "audio_pll2_out", };
 
 static const char *imx8mm_vpu_h1_sels[] = {"osc_24m", "vpu_pll_out", "sys_pll1_800m", "sys_pll2_1000m",
-					   "audio_pll2_clk", "sys_pll2_125m", "sys_pll3_clk", "audio_pll1_out", };
+					   "audio_pll2_out", "sys_pll2_125m", "sys_pll3_clk", "audio_pll1_out", };
 
 static const char *imx8mm_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
 
-static const char *imx8mm_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "osc_27m", "sys_pll1_200m", "audio_pll2_clk",
+static const char *imx8mm_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "osc_27m", "sys_pll1_200m", "audio_pll2_out",
 					 "vpu_pll", "sys_pll1_80m", };
 
 static struct clk *clks[IMX8MM_CLK_END];


