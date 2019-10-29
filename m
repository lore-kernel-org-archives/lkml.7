Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E76BCA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DEE20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="zKKLohZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfJ2FK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 01:10:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40842 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfJ2FK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:10:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so12149850wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=b1LVw1i492IKoNYo8KXLm+bZ3dkK0vQqyiVvn/U4gVk=;
        b=zKKLohZq0CcBoAjOWY5QRe7BEUFk0gkSxHu3m637kxlB8Sp190GrQZo/rHSt9ErT8v
         qAvm7dslCBPnsYnCCEQfeJw3RKpjbP6pEz1RQAN9wKO8bsaXun0c38C5Pr1JC/sVsMRX
         tlcJZD1drS+rqu1NMdcQab2UNOhR35z4wdc7uXIYlJ4luAQyu5VYsbJ2cb+6F9v6k0Jl
         Q7IEUomGwpSraqHjWxtYEt2jdPLsyuIPZPB20xyPrvnBar++8SMMAap2mFjAPaVtktG6
         7NwC2YKRf4z+5NCnTJR6Hg5cEwfIDWsdJAoh+cWtTyR0hWg4Hc0P7J6xociECbczgikU
         JguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=b1LVw1i492IKoNYo8KXLm+bZ3dkK0vQqyiVvn/U4gVk=;
        b=tSbn3aFiyOIDFIwG5rc8PIvNbyA1valNUmx4D8noKazf2NK1cu4ZbhjjJqiqrXV3LB
         mY6f2fXBZ94dbDccnuFrmPGN+03gBDr4q8qYShWm8ABwHW/21pBQD7Zn+2UpivtZVZTT
         hZSRf4vKmD0ll3N8gPnCWCs11poZIFV+B53eu3iu31HhncH3XpzIS2ZgH5y0v0+rtIRS
         HhGAA5Z4v6394cm9ihB9YupF/LVtyb8GjPTl6ZukeuKwrVMR3RcMKlnYsPLlftSUBW4b
         xo271Lca44MQ2UMlSK4hJeyAq2M55CYxy1BgbOCsLDcA3cMO7cPC+1Lv3bMpmUqZ+Ln6
         5vYA==
X-Gm-Message-State: APjAAAUREMsTSQNwHxoHJ6WCi6kf+Jrau726Nv0a6/looZ3B1Tm9S1AG
        l9ksPGy3j+3Q463i0qyqFjYYmQ==
X-Google-Smtp-Source: APXvYqxqzjm2s6EfnuipxXg4t4ULKlfyYgyw4xvDzuLzhYcf5stB679VI/VFszN3hrXA71B8mIDMiQ==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr16990269wrn.110.1572325854801;
        Mon, 28 Oct 2019 22:10:54 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f14sm1795746wmc.22.2019.10.28.22.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 22:10:54 -0700 (PDT)
Message-ID: <5db7c9de.1c69fb81.84d61.99dc@mx.google.com>
Date:   Mon, 28 Oct 2019 22:10:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: for-next
X-Kernelci-Tree: tegra
X-Kernelci-Kernel: v5.4-rc1-43-g564c032098ad
X-Kernelci-Report-Type: bisect
Subject: tegra/for-next boot bisection: v5.4-rc1-43-g564c032098ad on
 tegra124-nyan-big
To:     tomeu.vizoso@collabora.com, Thierry Reding <treding@nvidia.com>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

tegra/for-next boot bisection: v5.4-rc1-43-g564c032098ad on tegra124-nyan-b=
ig

Summary:
  Start:      564c032098ad Merge branch for-5.5/clk into for-next
  Details:    https://kernelci.org/boot/id/5db73d0459b514ce1360ee73
  Plain log:  https://storage.kernelci.org//tegra/for-next/v5.4-rc1-43-g564=
c032098ad/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/boot-te=
gra124-nyan-big.txt
  HTML log:   https://storage.kernelci.org//tegra/for-next/v5.4-rc1-43-g564=
c032098ad/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/boot-te=
gra124-nyan-big.html
  Result:     03fcfdabb05e clk: tegra: Reimplement SOR clock on Tegra124

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       tegra
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.g=
it
  Branch:     for-next
  Target:     tegra124-nyan-big
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 03fcfdabb05ea8d63f571649c4f8fc6840750c69
Author: Thierry Reding <treding@nvidia.com>
Date:   Thu Jul 25 18:19:00 2019 +0200

    clk: tegra: Reimplement SOR clock on Tegra124
    =

    In order to allow the display driver to deal uniformly with all SOR
    generations, implement the SOR clocks in a way that is compatible with
    Tegra186 and later.
    =

    Signed-off-by: Thierry Reding <treding@nvidia.com>

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra=
124.c
index 7d231529c3a5..b3110d5b5a6c 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1005,20 +1005,24 @@ static struct tegra_devclk devclks[] __initdata =3D=
 {
 	{ .con_id =3D "hda2hdmi", .dt_id =3D TEGRA124_CLK_HDA2HDMI },
 };
 =

-static const char *mux_pllp_pllm_plld_plla_pllc_plld2_clkm[] =3D {
-	"pll_p", "pll_m", "pll_d_out0", "pll_a_out0", "pll_c",
-	"pll_d2_out0", "clk_m"
+static const char * const sor0_parents[] =3D {
+	"pll_p_out0", "pll_m_out0", "pll_d_out0", "pll_a_out0", "pll_c_out0",
+	"pll_d2_out0", "clk_m",
 };
-#define mux_pllp_pllm_plld_plla_pllc_plld2_clkm_idx NULL
 =

-static const char *mux_clkm_plldp_sor0out[] =3D {
-	"clk_m", "pll_dp", "sor0_out",
+static const char * const sor0_out_parents[] =3D {
+	"clk_m", "sor0_pad_clkout",
 };
-#define mux_clkm_plldp_sor0out_idx NULL
 =

 static struct tegra_periph_init_data tegra124_periph[] =3D {
-	MUX8_NOGATE_LOCK("sor0_out", mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK=
_SOURCE_SOR0, tegra_clk_sor0_out, &sor0_lock),
-	NODIV("sor0", mux_clkm_plldp_sor0out, CLK_SOURCE_SOR0, 14, 3, 182, 0, teg=
ra_clk_sor0, &sor0_lock),
+	TEGRA_INIT_DATA_TABLE("sor0", NULL, NULL, sor0_parents,
+			      CLK_SOURCE_SOR0, 29, 0x7, 0, 0, 0, 0,
+			      0, 182, 0, tegra_clk_sor0, NULL, 0,
+			      &sor0_lock),
+	TEGRA_INIT_DATA_TABLE("sor0_out", NULL, NULL, sor0_out_parents,
+			      CLK_SOURCE_SOR0, 14, 0x1, 0, 0, 0, 0,
+			      0, 0, TEGRA_PERIPH_NO_GATE, tegra_clk_sor0_out,
+			      NULL, 0, &sor0_lock),
 };
 =

 static struct clk **clks;
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c] Linux 5.4-rc1
git bisect good 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c
# bad: [564c032098ad56372b69ad19d9c92167d8e0e0f4] Merge branch for-5.5/clk =
into for-next
git bisect bad 564c032098ad56372b69ad19d9c92167d8e0e0f4
# good: [23939968c9d885c4b467f49b84deadf96bd3cadf] arm64: tegra: Enable Dis=
playPort on Jetson AGX Xavier
git bisect good 23939968c9d885c4b467f49b84deadf96bd3cadf
# good: [811ec063dc042065bc0fad83c374202c436f660f] Merge branch for-5.5/soc=
 into for-next
git bisect good 811ec063dc042065bc0fad83c374202c436f660f
# bad: [c7dd92281a822e3d1072cd6c0a2e5d4e90cf1e38] clk: tegra: Reimplement S=
OR clocks on Tegra210
git bisect bad c7dd92281a822e3d1072cd6c0a2e5d4e90cf1e38
# good: [bbcaaf40ed81b4f9326f57dddd4b4a86dc763493] clk: tegra: Move SOR0 im=
plementation to Tegra124
git bisect good bbcaaf40ed81b4f9326f57dddd4b4a86dc763493
# bad: [03fcfdabb05ea8d63f571649c4f8fc6840750c69] clk: tegra: Reimplement S=
OR clock on Tegra124
git bisect bad 03fcfdabb05ea8d63f571649c4f8fc6840750c69
# good: [b761e39ee45cd51f2f0d506ee998c1d9cc03d8cd] clk: tegra: Rename sor0_=
lvds to sor0_out
git bisect good b761e39ee45cd51f2f0d506ee998c1d9cc03d8cd
# first bad commit: [03fcfdabb05ea8d63f571649c4f8fc6840750c69] clk: tegra: =
Reimplement SOR clock on Tegra124
---------------------------------------------------------------------------=
----
