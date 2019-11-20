Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB37C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904CB22461
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ov0DGKKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfKTFZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:25:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52691 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKTFZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:25:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so5605088wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 21:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=v+uBk5IEyaYZ7IF/b+w4lvOtghz7YVivbgrg50na0fw=;
        b=ov0DGKKWFfs9XQfFjYgGbG8mvNWdUX0PZJC5FicSFBTO+iQBnzhDBYDf0xfmRuuOBr
         NH2BkVXbo2lWyCvfeEiGRw02G5cV770g6ATNSrTxDBSrdPpvQp1L85Uz7nT/qQxJW5IT
         xyhtRNPhTqG8zfeU/BCM0G3v0+A3UXpnfHUmdcSugqJ3k5LAmAsa9Q+SgcQAhGHjZ04L
         EbhorRGcgpqvPHItV7Lsd4FN0lJdIMnjiMPgjXAUFeed0SxhsrEJJfJXJ2TCmg3Slhn4
         ehgDN3mBkccZSvgglZnOre1cpxyoKkowLiR/7oCYcHl1Nj25tfUFuuA2Q2ODmhNAgSg0
         5LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=v+uBk5IEyaYZ7IF/b+w4lvOtghz7YVivbgrg50na0fw=;
        b=V0K+WMkumjM/mujrWn3Td7AwsWjuA5kSl0qYJkjqsD0VmDtcCoFtZ4wfPhthX4GA1P
         LEnzi+3Bn3dCGtUexXYPn3lKAiP1DUX9BdiU7nCjTMCXbPu8/uaceAWdR0wyqMGqLCRZ
         mEXlRE7RbdHdXjTxRq6zr5HiZu6GloxyYCGjrEiZ27YHc1E6kumjXKRnSI9K3qLuGNGl
         z0+nMdF0CHebyGVLqjMuuH9JW8NT+MTZwgdvS6A2OIjht1BzF+6gWwXRMzTORBaf2y3p
         eb0kJUgOQqSRGPgiI3HHc6ZrngQK83VCv0yD2APoqIlyKbYD1LHzzRLgBWzp+3vZbtVz
         Njnw==
X-Gm-Message-State: APjAAAU8HJQxkjv1C5kFyxeNNiQx+T27V2Vc5NuFKUuqkCtueEpKEjJa
        aRZncELM/etyZ96izkweXdQiEg==
X-Google-Smtp-Source: APXvYqwhgSeFCVt1Z3whNFWM5gl6+qPpSEDUXk3HkahrF6XUVFw/zq5QHpMA127VV0d2Ihak5OT+CQ==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr894882wmf.173.1574227520777;
        Tue, 19 Nov 2019 21:25:20 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id q15sm29863955wrs.91.2019.11.19.21.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 21:25:20 -0800 (PST)
Message-ID: <5dd4ce40.1c69fb81.548f8.e723@mx.google.com>
Date:   Tue, 19 Nov 2019 21:25:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: clk-next
X-Kernelci-Tree: clk
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: clk-fixes-for-linus-196-gcd89054e321a
Subject: clk/clk-next bisection: boot on tegra124-nyan-big
To:     tomeu.vizoso@collabora.com, Stephen Boyd <sboyd@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Thierry Reding <treding@nvidia.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org,
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

clk/clk-next bisection: boot on tegra124-nyan-big

Summary:
  Start:      cd89054e321a Merge branch 'clk-init-leak' into clk-next
  Details:    https://kernelci.org/boot/id/5dd486b059b514415acf54bd
  Plain log:  https://storage.kernelci.org//clk/clk-next/clk-fixes-for-linu=
s-196-gcd89054e321a/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-n=
yan-big.txt
  HTML log:   https://storage.kernelci.org//clk/clk-next/clk-fixes-for-linu=
s-196-gcd89054e321a/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-n=
yan-big.html
  Result:     25175c806a68 clk: tegra: Reimplement SOR clock on Tegra124

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       clk
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
  Branch:     clk-next
  Target:     tegra124-nyan-big
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     tegra_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 25175c806a6841149abe46168e0af12593141612
Author: Thierry Reding <treding@nvidia.com>
Date:   Thu Jul 25 18:19:00 2019 +0200

    clk: tegra: Reimplement SOR clock on Tegra124
    =

    In order to allow the display driver to deal uniformly with all SOR
    generations, implement the SOR clocks in a way that is compatible with
    Tegra186 and later.
    =

    Acked-by: Stephen Boyd <sboyd@kernel.org>
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
# good: [dafbb1e6473788cb3068eaeddc58f9d88e9c7a62] Merge branch 'clk-ti' in=
to clk-next
git bisect good dafbb1e6473788cb3068eaeddc58f9d88e9c7a62
# bad: [cd89054e321a893073de7bb50f48b524a4ff675b] Merge branch 'clk-init-le=
ak' into clk-next
git bisect bad cd89054e321a893073de7bb50f48b524a4ff675b
# bad: [097064b841b74b137a7672e8daccd1384574ec9c] Merge tag 'tegra-for-5.5-=
clk-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into c=
lk-tegra
git bisect bad 097064b841b74b137a7672e8daccd1384574ec9c
# bad: [bc0b3a60fe19610d649a62879dd318d133ed10c0] clk: tegra: pll: Save and=
 restore pll context
git bisect bad bc0b3a60fe19610d649a62879dd318d133ed10c0
# good: [991a051ea5f15266903f52acb5832a596dd3da51] clk: tegra: Remove last =
remains of TEGRA210_CLK_SOR1_SRC
git bisect good 991a051ea5f15266903f52acb5832a596dd3da51
# bad: [25175c806a6841149abe46168e0af12593141612] clk: tegra: Reimplement S=
OR clock on Tegra124
git bisect bad 25175c806a6841149abe46168e0af12593141612
# good: [da8d1a3555406275650b366460c6235f1696bf8b] clk: tegra: Rename sor0_=
lvds to sor0_out
git bisect good da8d1a3555406275650b366460c6235f1696bf8b
# first bad commit: [25175c806a6841149abe46168e0af12593141612] clk: tegra: =
Reimplement SOR clock on Tegra124
---------------------------------------------------------------------------=
----
