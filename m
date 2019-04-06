Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21979C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 03:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB9621738
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 03:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="TEgfoxzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDFDm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 23:42:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFDm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 23:42:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so10104989wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=ys2IsLJ1PvhlZKBx420jkP3TGrV2rTELbRBFIog6p54=;
        b=TEgfoxzZ1+NJEbPF601bOhR3XSbnA3qNoEG42OAMIWcLeApd7FJlNusbnw/S+nVb/y
         WK8d4zmAZRo3onYt6+SpMPADqv0Umn/hu/IV+n+6s1Bvql+EWwXwRP/gEB3Gsvk7fARP
         KRVrk2kf49queWBuPdMnrbpBz5eCAhxTqSFkOCyFyNmdhwPcsZn3droWGpvP31REfON+
         szkQVi43ltaU8SGUHwoZWkiWzvjm2qhi44R7Vdz84GDuiYNZQHU7V+bpCVy88tqfVx+J
         Jcxp2zsIWAKYPDFJAj8RR9pTuyjaZfJKCwn/HVBfiakj5cNFUKTsu9KeDAgnmTwcD7Aj
         6cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=ys2IsLJ1PvhlZKBx420jkP3TGrV2rTELbRBFIog6p54=;
        b=oBz1eFtEXUdwmL4bq9YMscv9v9oOPdj6ED3cNYGkHvZ1yNPgYhnwyDd19Cs/yHrx/h
         fDIyf3DRYz6jqB/v8aBlQwI/PIahlnkHRAZ2GbvfCTSsj4IpaEkz/w7t53cyREdoq72h
         6LmuEypDyi8MeMhT84XsKGBHVQcS0z9jVEQOT09AceN4k239tkh/JVpymMYMyTjktUyC
         3OMWyM1jm6nHnm03OZ0O+ajwG3Vbz0zINJNVfz+FVXVYZTvg7pdeTcta/GKeQ/7uu2+R
         qp85MTSqiK6ZDFAGAv4GlOer1rTMN1DeQFODL9osV8jd3OOUdW9IBmzrJ4Y5XP+7n13f
         rbSQ==
X-Gm-Message-State: APjAAAWTsW1QNsmiQaoSZ+i9jNiGRb2w01lubQJTZP/RUHEZleMFGzrs
        pN4rUC9QyUeGjVBgQnOFkBZukA==
X-Google-Smtp-Source: APXvYqwMEFIY7Sy/YXMXfRtb1EKad76xq1Qu/T9Dd0BklGz1SMP+t7KlNc4KS9/FefQzbIxJCXGgxQ==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr11066388wru.33.1554522176822;
        Fri, 05 Apr 2019 20:42:56 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z74sm11703671wmc.2.2019.04.05.20.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 20:42:56 -0700 (PDT)
Message-ID: <5ca82040.1c69fb81.ab86d.b4f9@mx.google.com>
Date:   Fri, 05 Apr 2019 20:42:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.34
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: stable
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: linux-4.19.y
Subject: stable/linux-4.19.y boot bisection: v4.19.34 on
 meson-gxl-s905x-libretech-cc
To:     tomeu.vizoso@collabora.com, Sasha Levin <sashal@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Jerome Brunet <jbrunet@baylibre.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
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

stable/linux-4.19.y boot bisection: v4.19.34 on meson-gxl-s905x-libretech-cc

Summary:
  Start:      4d552acf3370 Linux 4.19.34
  Details:    https://kernelci.org/boot/id/5ca7d18659b51406b8fe6019
  Plain log:  https://storage.kernelci.org//stable/linux-4.19.y/v4.19.34/ar=
m64/defconfig/gcc-7/lab-baylibre/boot-meson-gxl-s905x-libretech-cc.txt
  HTML log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.34/ar=
m64/defconfig/gcc-7/lab-baylibre/boot-meson-gxl-s905x-libretech-cc.html
  Result:     c8e4f8406842 clk: meson: clean-up clock registration

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       stable
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable.git
  Branch:     linux-4.19.y
  Target:     meson-gxl-s905x-libretech-cc
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-7
  Config:     defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit c8e4f8406842332fb55cd792016e5dac266f6354
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
# good: [4b3a3ab00fa7a951eb1d7568c71855e75fd5af85] Linux 4.19.33
git bisect good 4b3a3ab00fa7a951eb1d7568c71855e75fd5af85
# bad: [4d552acf337038028f7e2f63a927afb7adf65fc1] Linux 4.19.34
git bisect bad 4d552acf337038028f7e2f63a927afb7adf65fc1
# good: [b13eb5245f9f730e79ab17593c4e3c8a62fee3b4] HID: intel-ish-hid: avoi=
d binding wrong ishtp_cl_device
git bisect good b13eb5245f9f730e79ab17593c4e3c8a62fee3b4
# good: [30d503bae9673ff6b0c67c6fa61b95db66319088] ARM: avoid Cortex-A9 liv=
elock on tight dmb loops
git bisect good 30d503bae9673ff6b0c67c6fa61b95db66319088
# good: [c55f4a6e798dad7383f4e4f99d351d6016e943a2] dmaengine: qcom_hidma: a=
ssign channel cookie correctly
git bisect good c55f4a6e798dad7383f4e4f99d351d6016e943a2
# good: [52cd9e0e43c7bda1621a2ce66765a4a369967caf] wlcore: Fix memory leak =
in case wl12xx_fetch_firmware failure
git bisect good 52cd9e0e43c7bda1621a2ce66765a4a369967caf
# bad: [986a2bb54a31179b0c99b94743723d49388ad900] Input: soc_button_array -=
 fix mapping of the 5th GPIO in a PNP0C40 device
git bisect bad 986a2bb54a31179b0c99b94743723d49388ad900
# bad: [c8e4f8406842332fb55cd792016e5dac266f6354] clk: meson: clean-up cloc=
k registration
git bisect bad c8e4f8406842332fb55cd792016e5dac266f6354
# good: [6251c1db04f2ac1ef799763da0f2fa1821dde403] drm/fb-helper: fix leaks=
 in error path of drm_fb_helper_fbdev_setup
git bisect good 6251c1db04f2ac1ef799763da0f2fa1821dde403
# first bad commit: [c8e4f8406842332fb55cd792016e5dac266f6354] clk: meson: =
clean-up clock registration
---------------------------------------------------------------------------=
----
