Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3265C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814FA21530
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RlYKMGzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbfGOMo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:44:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49709 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfGOMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124448euoutp02c315c9e4f4adc8918993e181cda5e0fc~xlUlxowTW0599205992euoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124448euoutp02c315c9e4f4adc8918993e181cda5e0fc~xlUlxowTW0599205992euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194688;
        bh=rfp9DgQhY51JkaM7dDI4cfxRpTkOLy+J/a8uenktk2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlYKMGzALSYkueqgSLTxGIYIdtwJUyLyUE5gsrbfa7dudMUxIkfqqJMb8FZIkWoZE
         3Vwx0SPTYy8jKuL67AGU2kGl0Gfoy2O+PxOQ9t1nq3L7nrc8nOxNMRGHj+DqZm3wfm
         DHngelo98u7gyCoj8E619PuBAdGGWU8/kxzaegkA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124447eucas1p2eeb720d39764acd64daefb38d5632c62~xlUkoFje43211132111eucas1p2J;
        Mon, 15 Jul 2019 12:44:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6E.A0.04325.E357C2D5; Mon, 15
        Jul 2019 13:44:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124446eucas1p1de55fe42ed5555c7a09b10f8c3ec3c3e~xlUjtOC950154701547eucas1p1E;
        Mon, 15 Jul 2019 12:44:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124445eusmtrp1f2b258c6fb4fd864e1acb9f01f0eca8e~xlUjfB8V10462004620eusmtrp1Q;
        Mon, 15 Jul 2019 12:44:45 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-c6-5d2c753e9561
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.40.04146.D357C2D5; Mon, 15
        Jul 2019 13:44:45 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124445eusmtip2849cde4b0347e975236d81591710da8d~xlUiteKn10518605186eusmtip2i;
        Mon, 15 Jul 2019 12:44:45 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v1 15/50] clk: samsung: add MPLL rate table in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:42 +0200
Message-Id: <20190715124417.4787-16-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURjAO7u7D1fT25Q8mGiMAi0fPdQOaGZkcAusoCispFbeVPLVro8s
        LR/4SCxFcQ01H5Voy8ecMlI0TEUhWXNGTg1fKUg1DVFDK6zNq/Xf7/u+3/fgcChM0o47UBHR
        caw8WhYpJURCbe+q3t0/3i1kf3nlQTTa8B5HTcpGHBmXZnFU0WMO86e/YUivV5NIl24i0Wiq
        I9JMD+FoIW8cRx/aygik1L8RoPqeMRJVGw0CZHh3An1KqyVQZkcPibpN2ThaG2oSBtgydeV1
        gPk+nEkyGtVDgml+8YB5O98uYB63qACzqHE6S14S+YWykREJrNzT/5oovEv5i4htsrkzb1KD
        VJAtzgVWFKS9YPYXHZELRJSErgVwtlpB8sESgFklRgEfLAJYv/IM32zJaJ3F+UINgLqXU8J/
        LYULH80ViiJoD/haddvSYEe/ALBn9brFwegRAWyfaV13bOmTsLMoxeII6T0wo6GAsLCYPgpH
        ynKE/DJn+ErdiVnYypxfVQys3wrpQRIqZxQbUiBcyezAeLaFX/taSJ4dYX9R3obDwdRHVYDn
        ZDid/3TD8YXdfYb1ezDaFTa2eVoQ0sdgpcKdR2s4PLfdImNmLNQ+wfi0GOZkSfgZLrAlb0DA
        8w5YU6fYmM1AfasW4x+nEMDitMdkAXAu+b+rEgAVsGfjuagwljsUzSZ6cLIoLj46zONGTJQG
        mP9U/1rf8mvw5vf1LkBTQLpNHBC6L0SCyxK4pKguAClMaic+smxOiUNlSXdZecxVeXwky3WB
        nZRQai++t2XysoQOk8Wxt1g2lpVvVgWUlUMq6A4uPROjQSN9abplzbUZ3Z9ig9a76bOLU/HE
        +JgxJVHrWj5Z7Th1pbco6GYg8fzC4C7r+l1Gb3WyId29YXYi8IdLYL6vau7+6RhH2bmQPBtp
        2OFw/6ILESWngoOaV022FUxvuGjsfLDBxw1e3LpYOlTmUyUk/RTFx3d7ef8cn5MKuXDZgb2Y
        nJP9BfpuMx5PAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7q2pTqxBr1Nxha31p1jtdg4Yz2r
        xfUvz1kt5h8Bcvsfv2a2OH9+A7vF2aY37Ba3GmQsNj2+xmrxseceq8XlXXPYLGac38dksfbI
        XXaLpdcvMllcPOVqcbtxBZtF694j7BaH37SzWvy7tpHFQdhjzbw1jB7vb7Sye2xa1cnmsXlJ
        vcfBd3uYPPq2rGL0+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ
        384mJTUnsyy1SN8uQS/j0IzfbAUb+SvevdnA2MDYztvFyMkhIWAi0bzzOWsXIxeHkMBSRolz
        rbsYIRJiEpP2bWeHsIUl/lzrYoMo+sQosfbVXSCHg4NNQE9ix6pCkBoRgRWMEpNPeIPUMAu8
        ZpI4cvQdK0iNsICnxIHJtSA1LAKqEs3rJrCB2LwC9hI353SwQMyXl1i94QAziM0JFP857QJY
        jZCAncTioz+ZJjDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYOduO/dy8g/HSxuBD
        jAIcjEo8vA4p2rFCrIllxZW5hxglOJiVRHhtvwKFeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0
        OR8Y1Xkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhgj32wUPf5r
        LdNW1uqJTLHX32R3XioJ7tt57twjzYCv04O3KK6+lbj+/nK75dkvTj7yll9XwJOw8bLXwybb
        WSG/Wo7q5Z/1ZvAT+v7I3Ca9TPn63ALZdWFnnH5Mqnl/WFCnp+p0UO25md62Ge5rP928w7lW
        Ytk0b81zXxkM67PfTQpaZOGQsU1YiaU4I9FQi7moOBEAeaHc3LICAAA=
X-CMS-MailID: 20190715124446eucas1p1de55fe42ed5555c7a09b10f8c3ec3c3e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124446eucas1p1de55fe42ed5555c7a09b10f8c3ec3c3e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124446eucas1p1de55fe42ed5555c7a09b10f8c3ec3c3e
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124446eucas1p1de55fe42ed5555c7a09b10f8c3ec3c3e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPLL has fixed frequency left by the bootloader and it is not possible
to change it. With this patch the MPLL gets rate table the same for the
whole PLL family (similar as APLL, KPLL according to RM) so the frequency
might be changed to one of the values defined there.
It is needed for further patches which change the MPLL frequency to feed
the clocks with proper base.
It also sets CLK_IS_CRITICAL for SCLK_MPLL due to some drivers which could
disable master clock, which is then populated higher and tries to disable
PLL, which casues system crash. The flag is needed for this kind of use
cases.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 6d1a0ef9172e..cded46f360f1 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -687,7 +687,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_USER_ACLK300_GSCL, "mout_user_aclk300_gscl",
 			mout_user_aclk300_gscl_p, SRC_TOP5, 28, 1),
 
-	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
+	MUX_F(CLK_MOUT_SCLK_MPLL, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1,
+			CLK_IS_CRITICAL, 0),
 	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
 	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
 	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
@@ -1518,6 +1519,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[dpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[mpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 	}
 
 	if (soc == EXYNOS5420)
-- 
2.17.1

