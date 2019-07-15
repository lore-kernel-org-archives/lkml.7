Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE6DC76192
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD732086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EhhHS3Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfGOMoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:44:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60182 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfGOMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124448euoutp01ec00aa8f27e971e0442ce98f13f09bce~xlUmEiEGJ1960819608euoutp01Y
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124448euoutp01ec00aa8f27e971e0442ce98f13f09bce~xlUmEiEGJ1960819608euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194688;
        bh=EsxerzHQ4ZXYQ6jsCCnM/GUgNUB7wTJMtvJQYjBnbJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EhhHS3Ec3UqntgFT90v4IHg8kkXgOdlO1spElEwhNkS3zuedBAFYOYUgIXt7UKXGb
         CJIcI1it2PFSvYjwE5Eh1rWtTG2Db/YCwUunGAoVTEoxQWeklwJr540bncCOnv5GIB
         z7MnCJwlK88Z34ukwG5GkwrSyVXry1ObIMeeePJE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124447eucas1p2fac5d54d14ae1c6ac361c15054fda7b4~xlUlRW4NU1544915449eucas1p26;
        Mon, 15 Jul 2019 12:44:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CF.D1.04377.F357C2D5; Mon, 15
        Jul 2019 13:44:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124446eucas1p1b9b7ec3235fdd887bf5a253a4e223df0~xlUkfJ2t60147201472eucas1p19;
        Mon, 15 Jul 2019 12:44:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124446eusmtrp1ef8567d88b2f386d22a61ddf0c6634e7~xlUkRC-ub0462004620eusmtrp1W;
        Mon, 15 Jul 2019 12:44:46 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-ed-5d2c753f1e01
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.07.04140.E357C2D5; Mon, 15
        Jul 2019 13:44:46 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124445eusmtip2c1626aa59bd058113658502445456c66~xlUjeAhEE1115211152eusmtip2K;
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
Subject: [PATCH v1 16/50] clk: samsung: add SPLL rate table in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:43 +0200
Message-Id: <20190715124417.4787-17-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djP87r2pTqxBtNvylrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6M5o0vWAve81ecvLCAsYFxL28XIyeH
        hICJRNvrz6xdjFwcQgIrGCUWb33CBuF8YZS4t2s5lPOZUeLqn0mMMC2bJv6GSixnlDi4/DYj
        XMucD2uBMhwcbAJ6EjtWFYI0iAgsYZQ48jMJpIZZ4CaTxJ4nO1lBEsICnhI9i3qYQWwWAVWJ
        RT9us4PYvAL2Eq8W72KH2CYvsXrDAbAaTqD4z2kXwDZLCJxjl5jR38cKUeQisfT0YyYIW1ji
        1fEtUM0yEqcn97BA2MUSDb0LoV6okXjcPxeqxlri8PGLrCBHMwtoSqzfpQ8RdpT41TidGSQs
        IcAnceOtIEiYGcictA0mzCvR0SYEUa0hsaXnAtQBYhLL10yDGu4hsWbRaRZI8ExilHjfMYdt
        AqP8LIRlCxgZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgSmqtP/jn/ZwbjrT9IhRgEO
        RiUeXocU7Vgh1sSy4srcQ4wSHMxKIry2X4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQL
        CaQnlqRmp6YWpBbBZJk4OKUaGOUFVpRF5h8V3XP6bZNu9tPDlv2KPI5BNseO3ui0E1ZsmOhl
        l32XbdVsk3nq1odq30TVKvftUFarM9nktkz0yLaaB59dMz6bPmkx2Vcu+Z89Y8KSb8UOn9aH
        BJzgLWePmtXCO7/3euCPny0CAq4P4lbmPN7sU9ky6fTM1wtW6ivGmO2+s/OblhJLcUaioRZz
        UXEiAPtb1JxRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7p2pTqxBmt3qlvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2M5o0vWAve81ecvLCAsYFxL28XIyeHhICJxKaJv9lAbCGBpYwSj68Z
        Q8TFJCbt284OYQtL/LnWBVTDBVTziVHiz/vdrF2MHBxsAnoSO1YVgtSICKxglJh8whukhlng
        NZPEkaPvWEESwgKeEj2LephBbBYBVYlFP26DDeUVsJd4tXgX1AJ5idUbDoDVcALFf067AHWQ
        ncTioz+ZJjDyLWBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYOduO/dyyg7HrXfAhRgEO
        RiUeXocU7Vgh1sSy4srcQ4wSHMxKIry2X4FCvCmJlVWpRfnxRaU5qcWHGE2BjprILCWanA+M
        6rySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwTznxzdFyx6O/p
        CavOO3pWa2cq2R+4dE5Ep1Z576JuqfuXdgovUirR2HSQeemMqVnp/hn+IWtORZhu2jpTbY7i
        3Wdl21kPZStsPTNhhspOV98lR1vFlD1Kyg2kY1Nz9966fnufbfiiuwpXbVbuWxHYuD+hNueN
        7HmbK1EXY+yztuXkzzq6+GuLEktxRqKhFnNRcSIAqCYO3rICAAA=
X-CMS-MailID: 20190715124446eucas1p1b9b7ec3235fdd887bf5a253a4e223df0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124446eucas1p1b9b7ec3235fdd887bf5a253a4e223df0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124446eucas1p1b9b7ec3235fdd887bf5a253a4e223df0
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124446eucas1p1b9b7ec3235fdd887bf5a253a4e223df0@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPLL has fixed frequency left by the bootloader and it is not possible
to change it. With this patch the SPLL gets rate table the same for the
whole PLL family (similar as APLL, KPLL according to RM) so the frequency
might be changed to one of the values defined there.
It is needed for further patches which change the MPLL frequency to feed
the clocks with proper base.
It also sets CLK_IS_CRITICAL for SCLK_SPLL due to some drivers which could
disable master clock, which is then populated higher and tries to disable
PLL, which casues system crash. The flag is needed for this kind of use
cases.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index cded46f360f1..ead569a164cf 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -690,7 +690,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX_F(CLK_MOUT_SCLK_MPLL, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1,
 			CLK_IS_CRITICAL, 0),
 	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
-	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
+	MUX_F(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1,
+			CLK_IS_CRITICAL, 0),
 	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
 	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
@@ -1520,6 +1521,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[mpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[spll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 	}
 
 	if (soc == EXYNOS5420)
-- 
2.17.1

