Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA86FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D7E206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="X7vgQihN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKNE7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 23:59:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33178 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfKNE7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 23:59:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so6521075wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 20:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=egiNHn53AxF6dtodPHEQPaH0Kx6MPPdA1nRSwplfmdU=;
        b=X7vgQihNK7OSrrcHcaz9+b2+bK7wqeYB9vc0qPG2/bx9hdq4oaTaZ8S0BNafadfgxj
         LMqbCga0loCpVfJB/QE5XCJQdoaC7Mb9y0cfw6lu+sD+91Dm7ZvUwnAnHqUHgmsQkp68
         Cr00+t95D+Tfc9iQgpuJOQBBJ0yEwu3d+KB4GefamYCNBzOca2poqjFfk6IHtpvKr9pk
         33CndrErlGHFjZOJYYk6x7e86siMNXHL8UzSEwji+kXCPXhRuiHRYs7MEqH3KdfpUq14
         fZdmYa0/Jut8XF9BNjV7XOyW6j2RyLkkYvSWLh55pRXO5zBun9HKQgkkCkNUbku8OzUh
         sL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=egiNHn53AxF6dtodPHEQPaH0Kx6MPPdA1nRSwplfmdU=;
        b=RaZa+gO02ZikXDIcd+dzlDEz04vxl2FfbBRgabWtfGkx3OpUWAjp7IvSESOgrYnDGY
         Xf599jxBhQCon5g9nproEqJYUyPGoqxPPUyqgPC8OBA//7q3GxbXxseIDKfF2WKJR2KM
         8xMifF7MEjTzI4DJ0TB1zAslZxWT6u5RXaHEcyPfbyvfBZhb5oq5JkBRYcOkhdnqRAvG
         +Hndq3o6v/EZaGD5t9HbBd/VP+brHSJmWLAPpySEXr08/YMUTxLbjXzzr+eEXdQgV/tX
         5IfG4PZ7uG/ABnDnauSub5tKsNOTFeb6kL9T3NvxUCtJulwU7ALVkBD2jFYkUAyNMycz
         qZEg==
X-Gm-Message-State: APjAAAX0+INihZHLyN78Bar5YWKQP0uNiUquvxaK88QkEWNonRCWC7ix
        5NtG4F97Hhyn3RckvCWJtLf/hA==
X-Google-Smtp-Source: APXvYqwDd17kaAOiy5f8H9/6NTgbBYv3WS9x9qLa6e/LvfH38s2SwUw/DMzODEO6qsytv3+v4p0fjA==
X-Received: by 2002:a7b:c445:: with SMTP id l5mr5682751wmi.140.1573707553634;
        Wed, 13 Nov 2019 20:59:13 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id r2sm5620386wrp.64.2019.11.13.20.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 20:59:12 -0800 (PST)
Message-ID: <5dccdf20.1c69fb81.418aa.a71c@mx.google.com>
Date:   Wed, 13 Nov 2019 20:59:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: clk-next
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Tree: clk
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-rc1-201-ga228ae437aa5
Subject: clk/clk-next boot bisection: v5.4-rc1-201-ga228ae437aa5 on
 tegra124-nyan-big
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

clk/clk-next boot bisection: v5.4-rc1-201-ga228ae437aa5 on tegra124-nyan-big

Summary:
  Start:      a228ae437aa5 Merge branch 'clk-unused' into clk-next
  Details:    https://kernelci.org/boot/id/5dcc99e959b514100f138e14
  Plain log:  https://storage.kernelci.org//clk/clk-next/v5.4-rc1-201-ga228=
ae437aa5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big.txt
  HTML log:   https://storage.kernelci.org//clk/clk-next/v5.4-rc1-201-ga228=
ae437aa5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big.html
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
# bad: [a228ae437aa553736058cbbd58d2d0e191635cdc] Merge branch 'clk-unused'=
 into clk-next
git bisect bad a228ae437aa553736058cbbd58d2d0e191635cdc
# bad: [3214be6cb1e487b0f8c3bb2eac9b06df07a07e06] clk: tegra: Share clk and=
 rst register defines with Tegra clock driver
git bisect bad 3214be6cb1e487b0f8c3bb2eac9b06df07a07e06
# bad: [05308d7e7bbc932025f1dafc401c73ce83c6f414] clk: tegra: Reimplement S=
OR clocks on Tegra210
git bisect bad 05308d7e7bbc932025f1dafc401c73ce83c6f414
# good: [d1ee3173a139ed2eb8d87e06216f0426b16084d8] Merge branch 'for-5.5/dt=
-bindings' into for-5.5/clk
git bisect good d1ee3173a139ed2eb8d87e06216f0426b16084d8
# good: [e5f8a107d92db30a7ad7d8d95aee59f5ad76206a] clk: tegra: Move SOR0 im=
plementation to Tegra124
git bisect good e5f8a107d92db30a7ad7d8d95aee59f5ad76206a
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
