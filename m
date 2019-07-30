Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC0EC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084E9206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="sJFSAdWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfG3Dev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:34:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38081 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfG3Deu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:34:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so64046497wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 20:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=3H8HzMsuloNzCatYKYD2aCuZ4wdUjxBb7w2vguXBYNI=;
        b=sJFSAdWaTTM8mnhej8+UbIZFyZd1Yuw2wR5qXpqXCgEwq8pi6eFX2uoWjew63Eaxs0
         SiqAS8M7Hiqk7+/RrmCILMzS8s3Q6AQ2Q38eIQWtk6bXZOgqDy6i7t+fqsrcPDvpaWu8
         blY8629kH3qiVlb4CE1QZHP1AvJ9P3tfPeidLUjRg3TYCspFNt3ivmeQNhytW6B45aZj
         oxYceDdQZew4Q2Zdj40tc1xepoiaT3TtPGO4rxIT2SuYtboTyqi46EE4JPTJe8tAkH8Q
         zU1ny9XCr9gytS40UE5N6X81n9/sBrNGLGZnaSZd/PPIYjytYCsXFa86famWo2S2SWr3
         XZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=3H8HzMsuloNzCatYKYD2aCuZ4wdUjxBb7w2vguXBYNI=;
        b=pF86ApuYOgwKJyasxr8PA2MvRl3AbKSamWPxHjESAvil7ng2iX6+1iHTqavb6DwadO
         rga0D3sU6fXpXalf7cFwUEAyCjqPaMCa7bc1si+jPWv07D8BDxM9xbQrjYxcNaro/8IM
         ntQO0rguWz8Nk4cL2ui80fQtyUnyuMrE/oJ8u/Rb96lfuMS+V9xDeBaRd9ORaQQsTuRH
         4OiCuNOdG1ucOTyRuIQgUxGlj8wnm7YELiG+YEYHE6oNsyS68p7vHk77nPHrzqGqBWe6
         AYG+5UHWZAeKahZpZEVtwdi94Lc6B5OHlx4vscatbVdcKwfAHuCl/aNzLB/BNoRgRmwI
         tpxA==
X-Gm-Message-State: APjAAAWI5mFcNY2KgwrRh3/8rOOASI1X7I8YUfZWVCX/H+oY/IanJVm6
        TlKXk+ioVGdnpMLYNIlNaao=
X-Google-Smtp-Source: APXvYqwkFBwCAF6njBkjdYcr/wmNKupVcX30EILoQC/j7SuXfRrm3XoAxvKv75OkB0FVjpj2NjwgLg==
X-Received: by 2002:a5d:56cb:: with SMTP id m11mr1634121wrw.255.1564457688218;
        Mon, 29 Jul 2019 20:34:48 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id p7sm39473699wrs.6.2019.07.29.20.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 20:34:47 -0700 (PDT)
Message-ID: <5d3fbad7.1c69fb81.d66f7.548d@mx.google.com>
Date:   Mon, 29 Jul 2019 20:34:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.14.134-294-gf6ba73a2e356
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Report-Type: boot
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/293] 4.14.135-stable review
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

stable-rc/linux-4.14.y boot: 106 boots: 1 failed, 64 passed with 41 offline=
 (v4.14.134-294-gf6ba73a2e356)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.134-294-gf6ba73a2e356/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.134-294-gf6ba73a2e356/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.134-294-gf6ba73a2e356
Git Commit: f6ba73a2e356d3f40ed298dbf4097561f2cd9973
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 58 unique boards, 25 SoC families, 16 builds out of 201

Boot Failure Detected:

arc:
    hsdk_defconfig:
        gcc-8:
            hsdk: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            meson-gxbb-odroidc2: 1 offline lab
            meson-gxl-s905d-p230: 1 offline lab
            meson-gxl-s905x-libretech-cc: 1 offline lab
            meson-gxl-s905x-nexbox-a95x: 1 offline lab
            meson-gxl-s905x-p212: 1 offline lab
            meson-gxm-nexbox-a1: 1 offline lab
            rk3399-firefly: 1 offline lab
            sun50i-a64-pine64-plus: 1 offline lab

mips:

    pistachio_defconfig:
        gcc-8
            pistachio_marduk: 1 offline lab

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
            qcom-apq8064-ifc6410: 1 offline lab
            stih410-b2120: 1 offline lab
            sun4i-a10-cubieboard: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab
            tegra20-iris-512: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    omap2plus_defconfig:
        gcc-8
            omap3-beagle: 1 offline lab
            omap4-panda: 1 offline lab

    qcom_defconfig:
        gcc-8
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
            sun7i-a20-bananapi: 1 offline lab

---
For more info write to <info@kernelci.org>
