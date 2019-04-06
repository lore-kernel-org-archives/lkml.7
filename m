Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58CDC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786052173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="zK3sf5ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDFGYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:24:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36723 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDFGYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:24:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so9238858wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=Z2ZMBmLf5H7LCVZIEoHGY0nbwwyjgL/lWhAJjSfUtaM=;
        b=zK3sf5eyo3xRdsPPJ/62NdCo0f4jC9MIU08rhhdZpegZD/CX2Wzml01F097nqVW2D+
         zrNcvZdeLu2Tibf0wPge3bhfPo+orOIn1njT5M8XvAyc1jH1pWNPxoZUhxMAhuWHS4CZ
         Y4AHwKehQQwYNSZ2ru3PPBz+KVAm6aaY05aUl1oi8WsyORyf+FYoc/3vYD7pi7jTrg1g
         46r6YTyDFRSB31ZvS0UsaqoBsfDuQcmPIeioaYhBRt9njfcZQF/3CVX74hkA47GJHudV
         YwCqYfaNwJsqdRExlC0AwTrei6T3W8f3IRGC/ZBGIcOiXrfmK0LyP1dLCMKyYYM7jum1
         N9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=Z2ZMBmLf5H7LCVZIEoHGY0nbwwyjgL/lWhAJjSfUtaM=;
        b=OxBMZtc67BMEla1fLMP9bqqdqtvVKwPxYCEd4aOPhMP6ap9QiVNT9kJhYMdo+m4C/I
         nbGC/gN/KnnYVSxnb7c1lLJECC5tga7RWsBPYWr8t4MSouOGMoC2D6E4JG5XcEkfE16o
         gOcOTyELZZFdNKgn8ZhWmcK0BVCQRa2yiLamREASAO9Lr10jMEEb+afNmwv1qeYfFyY0
         te51P8ZoMaHMVv0IlxdQPYSptUddDbTMc61dM+ywlU+CaZTDbPGkoTosFta5JURIBxS5
         829L2rX33Sor5XC+SCNaVcnk+8I/Ck7gnuvIbxs6G+l3/X2sM7os+SkmLUfGXhfa9JiC
         i1jA==
X-Gm-Message-State: APjAAAXATjbtj/Lrq9tGAswNdGPtqlL8Uf5ayCxexBt8qa151kNl5a/G
        TrD7Sg5DNSKSDas854VeMmckUw==
X-Google-Smtp-Source: APXvYqx84WcrdCZw7xcJcBhhnwS+nDR++bNRGswqBKQnYvX38PPMzk3gKvt0OMDCmhAIDhWY/Eh6rQ==
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr10692405wme.46.1554531861469;
        Fri, 05 Apr 2019 23:24:21 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z140sm7394764wmc.27.2019.04.05.23.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 23:24:20 -0700 (PDT)
Message-ID: <5ca84614.1c69fb81.e2ab3.2e61@mx.google.com>
Date:   Fri, 05 Apr 2019 23:24:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.0.7
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: stable
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: linux-5.0.y
Subject: stable/linux-5.0.y boot bisection: v5.0.7 on meson-gxl-s805x-p241
To:     tomeu.vizoso@collabora.com, Sasha Levin <sashal@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Jerome Brunet <jbrunet@baylibre.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

stable/linux-5.0.y boot bisection: v5.0.7 on meson-gxl-s805x-p241

Summary:
  Start:      8b298d3a0bd5 Linux 5.0.7
  Details:    https://kernelci.org/boot/id/5ca7df3959b5141abafe6036
  Plain log:  https://storage.kernelci.org//stable/linux-5.0.y/v5.0.7/arm64=
/defconfig/gcc-7/lab-baylibre/boot-meson-gxl-s805x-p241.txt
  HTML log:   https://storage.kernelci.org//stable/linux-5.0.y/v5.0.7/arm64=
/defconfig/gcc-7/lab-baylibre/boot-meson-gxl-s805x-p241.html
  Result:     9b0f430450cf clk: meson: clean-up clock registration

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       stable
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable.git
  Branch:     linux-5.0.y
  Target:     meson-gxl-s805x-p241
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-7
  Config:     defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 9b0f430450cf230e736bc40f95bf34fbdb99cead
Author: Jerome Brunet <jbrunet@baylibre.com>
Date:   Fri Dec 21 17:02:36 2018 +0100

    clk: meson: clean-up clock registration
    =

    [ Upstream commit 8d9981efbcab066d17af4d3c85c169200f6f78df ]
    =

    Order, ids and size  between the table of regmap clocks and the onecell
    data table could be different.
    =

    Set regmap pointer in all the regmap clocks before starting the
    registration using the onecell data, to make sure we don't
    get into an incoherent situation.
    =

    Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
    Acked-by: Neil Armstrong <narmstrong@baylibre.com>
    Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
    Link: https://lkml.kernel.org/r/20181221160239.26265-3-jbrunet@baylibre=
.com
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aocl=
k.c
index f965845917e3..258c8d259ea1 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -65,15 +65,20 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		return ret;
 	}
 =

-	/*
-	 * Populate regmap and register all clks
-	 */
-	for (clkid =3D 0; clkid < data->num_clks; clkid++) {
+	/* Populate regmap */
+	for (clkid =3D 0; clkid < data->num_clks; clkid++)
 		data->clks[clkid]->map =3D regmap;
 =

+	/* Register all clks */
+	for (clkid =3D 0; clkid < data->hw_data->num; clkid++) {
+		if (!data->hw_data->hws[clkid])
+			continue;
+
 		ret =3D devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
-		if (ret)
+		if (ret) {
+			dev_err(dev, "Clock registration failed\n");
 			return ret;
+		}
 	}
 =

 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [820c1fa515010d280551075da59fc2668ba8b3ae] Linux 5.0.6
git bisect good 820c1fa515010d280551075da59fc2668ba8b3ae
# bad: [8b298d3a0bd5feeb47129c4889356b38b78ab231] Linux 5.0.7
git bisect bad 8b298d3a0bd5feeb47129c4889356b38b78ab231
# good: [55d7152d37dccfa9add45df82fd45c373e032f46] cgroup, rstat: Don't flu=
sh subtree root unless necessary
git bisect good 55d7152d37dccfa9add45df82fd45c373e032f46
# good: [8b3b22aa7c558e713a179710a6f1e2fdbef44b20] block, bfq: fix queue re=
moval from weights tree
git bisect good 8b3b22aa7c558e713a179710a6f1e2fdbef44b20
# good: [ebd0f3066c35bd27d3a4b224135e638eeaf70b8d] netfilter: physdev: rela=
x br_netfilter dependency
git bisect good ebd0f3066c35bd27d3a4b224135e638eeaf70b8d
# bad: [9b0f430450cf230e736bc40f95bf34fbdb99cead] clk: meson: clean-up cloc=
k registration
git bisect bad 9b0f430450cf230e736bc40f95bf34fbdb99cead
# good: [bfb59eabe2c940c6869f128200f2047d46215845] drm: Auto-set allow_fb_m=
odifiers when given modifiers at plane init
git bisect good bfb59eabe2c940c6869f128200f2047d46215845
# good: [ab79dc3ef0244c9b3d712d0cef17b74c363d6069] brcmfmac: Use firmware_r=
equest_nowarn for the clm_blob
git bisect good ab79dc3ef0244c9b3d712d0cef17b74c363d6069
# good: [c8a8dd1d85ca715ec65169feac54a7a06b8d2a29] x86/build: Mark per-CPU =
symbols as absolute explicitly for LLD
git bisect good c8a8dd1d85ca715ec65169feac54a7a06b8d2a29
# good: [a644d2d28baf8472368903b28823cf85c9a13a1d] drm/fb-helper: fix leaks=
 in error path of drm_fb_helper_fbdev_setup
git bisect good a644d2d28baf8472368903b28823cf85c9a13a1d
# first bad commit: [9b0f430450cf230e736bc40f95bf34fbdb99cead] clk: meson: =
clean-up clock registration
---------------------------------------------------------------------------=
----
