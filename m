Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6171C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B020320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="dcRXeC4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfHERf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:35:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38199 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHERfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:35:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so52466389wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=RzHMiOnu0E/vzeqnz6OQSYCDgnQPYk0slkQPna4Gc9I=;
        b=dcRXeC4P4bg4MZ6xn2ewYUn+G+pK61xfRimdyccb7cXr+icAUCd9xS7C8atFXiS95z
         WDfqMRFa3tmEqPSjGSK5mya4DRHH3k6n0cU88P9TNKqC4JKBaFW3s2h5/tVrxMOhWRZJ
         hlx3/nwHqJUqOk4rGtz+plboLvnKMvSyckbCf0+W5D/pIxTIe/5XM0yVdVuOQDYlmcLV
         2jjzO9XzmQnmS6DNkfl6+OkxhfBrOwkkPII+vlsG6VxuESvPYEfsHRgHcCMzG2IkTWpX
         GsKIs17AMkJvicDFs8WBB6yxq0bcXKW4I2XIc5GKldjuujm1dxPvJybJ2uWkkdHbsLSs
         kdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=RzHMiOnu0E/vzeqnz6OQSYCDgnQPYk0slkQPna4Gc9I=;
        b=phe6fmQEh+0Rvhyylvll8VVsh3BBFlzLnFwrQxMFioBWLHavVwfT/2bjsuqKYhgYmw
         pTH5fbgKsfBWpXqIkKcDwqUEVVdTRPX79U0nQCygIBKSw+RlJXDo5jdncMzBx0Xbii54
         y/rHfjG0zKFpo1MXfZdgCyJUydJ9Vgs88mS9DJ9Ag9Zj7kyjjJEH2CCCDDVQ7wJoj8ya
         Ytu2gGosbZOHHKyIX4gKHvSjLSjpvJapjQmX/tS5b7bkJwwp0FoHcv3xBIDcU9LS2qnt
         gJpybldAFHBqN4pAxcfHnnVZmT/GItAmH6m0M18tPJP3VnA6tv/KUuWbrnNGoKK0MlL1
         fMmg==
X-Gm-Message-State: APjAAAUdfAIYH8kZcBYJqUX65sbyHWTEUzJpRO7CjkVmcg6MCiY3oW5r
        0HAVx0+aO/PWo3l6g4AEofJgMg==
X-Google-Smtp-Source: APXvYqzX8VV4h2PU6dSAOR8cpdLWYsk0rioH6pr8LO8E1BgH4ZY4/Oh0bFQbJYHxOX/ftnExuhdDjA==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr20798548wmg.92.1565026519241;
        Mon, 05 Aug 2019 10:35:19 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id k124sm146235069wmk.47.2019.08.05.10.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:35:18 -0700 (PDT)
Message-ID: <5d4868d6.1c69fb81.9f97b.d309@mx.google.com>
Date:   Mon, 05 Aug 2019 10:35:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.9.187-43-g78dd396df223
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Report-Type: boot
In-Reply-To: <20190805124924.788666484@linuxfoundation.org>
References: <20190805124924.788666484@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/42] 4.9.188-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc/linux-4.9.y boot: 101 boots: 0 failed, 60 passed with 41 offline =
(v4.9.187-43-g78dd396df223)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.187-43-g78dd396df223/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.187-43-g78dd396df223/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.187-43-g78dd396df223
Git Commit: 78dd396df223345521dd977f3974e6418c078296
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 49 unique boards, 22 SoC families, 15 builds out of 197

Boot Regressions Detected:

arm:

    sunxi_defconfig:
        gcc-8:
          sun4i-a10-cubieboard:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
6-224-g5380ded2525d - first fail: v4.9.187)
          sun5i-r8-chip:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
6-224-g5380ded2525d - first fail: v4.9.187)
          sun7i-a20-bananapi:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
6-224-g5380ded2525d - first fail: v4.9.187)

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab

arm:

    tegra_defconfig:
        gcc-8
            tegra20-iris-512: 1 offline lab

    exynos_defconfig:
        gcc-8
            exynos5250-arndale: 1 offline lab
            exynos5420-arndale-octa: 1 offline lab
            exynos5800-peach-pi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            bcm4708-smartrg-sr400ac: 1 offline lab
            bcm72521-bcm97252sffe: 1 offline lab
            bcm7445-bcm97445c: 1 offline lab
            exynos5250-arndale: 1 offline lab
            exynos5420-arndale-octa: 1 offline lab
            exynos5800-peach-pi: 1 offline lab
            imx6dl-wandboard_dual: 1 offline lab
            imx6dl-wandboard_solo: 1 offline lab
            imx6q-wandboard: 1 offline lab
            imx7s-warp: 1 offline lab
            meson8b-odroidc1: 1 offline lab
            omap3-beagle: 1 offline lab
            omap4-panda: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            stih410-b2120: 1 offline lab
            sun4i-a10-cubieboard: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab
            tegra20-iris-512: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    omap2plus_defconfig:
        gcc-8
            omap3-beagle: 1 offline lab
            omap4-panda: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            da850-evm: 1 offline lab
            dm365evm,legacy: 1 offline lab

    imx_v6_v7_defconfig:
        gcc-8
            imx6dl-wandboard_dual: 1 offline lab
            imx6dl-wandboard_solo: 1 offline lab
            imx6q-wandboard: 1 offline lab
            imx7s-warp: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun4i-a10-cubieboard: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

---
For more info write to <info@kernelci.org>
