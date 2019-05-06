Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F12C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695A82053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U26zmtyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfEFPNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:13:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49987 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfEFPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:12:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151214euoutp027e947e002ad8f7c3bb6fcd49d25d998c~cILVnP4DL3068630686euoutp02L
        for <linux-kernel@vger.kernel.org>; Mon,  6 May 2019 15:12:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151214euoutp027e947e002ad8f7c3bb6fcd49d25d998c~cILVnP4DL3068630686euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155534;
        bh=hPNvzPLxEElWXeyVcdLNco7UTtzNFFZJYf9Hjs/r5uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U26zmtypdYZIIOwIzr0twW0btjUJdwBEaGqs8JmYMokClZ4hUz1MtOtC25LSNj+Dr
         17LrVjgE/bbNanouDL3gRHop3oSkDaTETYzX/cGD558TXomU76ReltJDPNToiunYOJ
         9lKZQqdP8/Wf1+YlGQKdVRJSsCHt3e1ZDXAh88wQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190506151213eucas1p1a0a14760fcc1d30dd7499712a8bfdc7b~cILUwXjuS1902819028eucas1p1n;
        Mon,  6 May 2019 15:12:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.E1.04325.DCE40DC5; Mon,  6
        May 2019 16:12:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d~cILTwiXvi1039910399eucas1p27;
        Mon,  6 May 2019 15:12:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151212eusmtrp2c4603c7dc1bc97f5ec8aef608ba9cb4a~cILTig_Wk0409004090eusmtrp2M;
        Mon,  6 May 2019 15:12:12 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-75-5cd04ecd9585
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.5D.04146.CCE40DC5; Mon,  6
        May 2019 16:12:12 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151211eusmtip1f08905385bac1e46c15540d1ed08a3a7~cILSsOB4H3138931389eusmtip1z;
        Mon,  6 May 2019 15:12:11 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v7 03/13] clk: samsung: add BPLL rate table for Exynos 5422
 SoC
Date:   Mon,  6 May 2019 17:11:51 +0200
Message-Id: <1557155521-30949-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHPbu72500OV1Df9gyHAQVNIsijvQgI+KmGWWPP0qoVTeV3Kxd
        LU2FqfgsU5ReavmI0pZRmY0smzRHWurcKlKzVWoYmEmhadnTeRf99znfx+93OByGYlvoACZW
        n8Ab9No4tcxban783b6kc4sjammdBcjt8zdp0j3+gSYVNjtNrn8ZRKTk6UUJ6TipI4WDHynS
        1XVLTjozRuTklVFFnt8vl5GxAhsi57ssEnLD5pKTvvRaGWkZyaFJ84sw0vfDh0y0DaB1vtzE
        12IpV2Z0SrnGUpecqzflybiCzFEZ92i0ScKdbjAh7k57CjdWH7hVsdt79UE+LvYYbwheu887
        xuUyS49k4qThz3m0EfUq85GCAbwCCieGJPnIm2FxLQJzmVnuNlg8juBlR7jIYwiyXkf+K2Q0
        ujyFGgRORzYlHqYLw/250w7DyLAG7pmOugtzcAq87m6eyVB4RAKdU9+kbsMXbwPn0MAMS/EC
        KK/+MLNZicMg50mlTNwWCL32PMrNChwOv3KtyD0I8Bs5VFubaTG0ASxTzyQi+8Jwa4NcZBX8
        aazw6AIYC6qQyKkwWHjRk1kFLa1O2n1pCi+Cm/eDRTkUel7dnpEB+0DPp9lumZrGYvM5SpSV
        kJvNiumF0HDK4VnkBzV1Zz3DOXhguuZ5z0sIJopVRWh+6f9dlQiZkD+fKOiieWG5nj+uEbQ6
        IVEfrTkQr6tH01+r/Xfr13vI8nO/FWEGqWcpi9Y7olhae0xI1lkRMJR6jlI7ZI9ilQe1ySd4
        Q/xeQ2IcL1jRXEaq9lemeL3bw+JobQJ/mOeP8IZ/roRRBBjRekNNfJvP58a+0Guq7Y7lQbGD
        EZvrwlObmE1mTVa2PuHC2q21ubu9bLsC/Vj+fZDqbkRFyHhe5MY1e69c2amcl3xopLb1uzMt
        yD4525B2V4EzfmlKH/aWvmHPJOHy4LK3/mPpJcK+qv56fU6klyVmx6FvK0OqJ3uazsJVy+Vg
        OaeWCjHaZYspg6D9C0XnGjFWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7pn/C7EGCyeJmyxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJext2721gKmgUqXn3oZG1gvMnbxcjJISFgItG08y4T
        iC0ksJRRYs4yEYi4mMSkfdvZIWxhiT/Xutggaj4xSiyabNHFyMHBJqAnsWNVIUhYRKBeov/N
        JaASLg5mgQZmiTXbr7KCJIQF/CW2vPkBZrMIqErMWfQcbCavgJdE+8kFbBDz5SRunutkBrE5
        Bbwl/nYcYoTY5SWx7+NvlgmMfAsYGVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExtG2Yz83
        72C8tDH4EKMAB6MSD+8D2wsxQqyJZcWVuYcYJTiYlUR4E5+dixHiTUmsrEotyo8vKs1JLT7E
        aAp01ERmKdHkfGCM55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRq
        YCy3cD4dUXEvsnTqS9/nd0UPPj+87MfVxB8y5sesZ8tdZSjZVs7Nxvtyqhhv6UvmruU61uvb
        Z/693mJy7kZK9ETVN2c+HewOm8m7/fiDgzEfP25zmvrg5gp9j08XLU9f72wJ/XBxQZ7Vw/zu
        fRc2n2ATK9mk+CNiwRXmT4sTP+8XqvP+8eBotWSMEktxRqKhFnNRcSIAt2X4ibkCAAA=
X-CMS-MailID: 20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
Controller frequencies for driver's DRAM timings.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index af62b6d..23c60a5 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1335,6 +1335,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
 	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
 };
 
+static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
+	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
+	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
+};
+
 static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
 	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
@@ -1477,9 +1488,13 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
-		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 	}
 
+	if (soc == EXYNOS5420)
+		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+	else
+		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
+
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
 					reg_base);
 	samsung_clk_register_fixed_rate(ctx, exynos5x_fixed_rate_clks,
-- 
2.7.4

