Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAA9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6B3206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="shY0q7M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfG3Deu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:34:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54427 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfG3Deu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:34:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so55610490wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 20:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ITAb9Kh+5Z6F0+NQKKVK/h+HGnJ9X+X1Youb5YG6uFA=;
        b=shY0q7M1DuyjkoxOtSZ1kqM90Bz5j0c+taUnHbtgVRftZNquLkpPvhXX50FUevOeyq
         d3Q6glEghMeMQwB4L9P1IPwjGvzWHYk01bTz/XCY9yaQCdCrRc/2Nh9rakVPKDpY5xAJ
         QHX4xkamTu9FSNGK89C+weEeWElMS6xbRMvnDVhVEwzPrhkKAFTKMtYePZZoW7kdkjFW
         wF64VB2r/aUzT/5yAYLMTQOyvjd2/9eng2A1WXBgIBDRNMIT/KpXLwTDqyKLz6iwDXy1
         7Xs7edH99SJ9/If+bcSU73T7+J/ctytdqQsBj+bR4UAxfUHPsYl4JgmJOa7u1AsLKQtc
         KKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ITAb9Kh+5Z6F0+NQKKVK/h+HGnJ9X+X1Youb5YG6uFA=;
        b=bnCDQdqEzgnF1LQs7ADPxYHtzO1YuthCxy7MD3hfFzKepkvSeiJsyO5OtG0AVzfTNv
         CzNRaDCOu1U17b2TGPA3HvsF+sFaMUKZ9KjG9H/RXgDIW0RUo0eFBMMa55jhgRlQwoA5
         C6ajzf4W+XKxseRDRO/LfW/e1FWjDrNpERA/1wYDogDxEj6uIWg3TMoBS465GRDccVSb
         KRkdxJRI3+EKPyj4y/weQfH4/IELJ8hVGP6Whny48fdCzjK9yW42PbWaJ+wU9xVO2tBP
         M0fOWOqhiHbL2fMhDz4tonjV24PZjCVOmoxQwnbJESgkAWqHQH35wcDUNEEoXkt7ty5/
         IX2w==
X-Gm-Message-State: APjAAAV1+UfF88JVRUesJUu39tFt43+6KlhDZvWkGBRrcaIsO503x6tP
        srU3UF4R68KzoG5lrlFRoiw=
X-Google-Smtp-Source: APXvYqxHjpWZ6lbdOaDIjgGwrVu0M0EByg6DD/YpsoOzVxCEqZk9wRd3o5wvEKLkUPeJKP+z00njBw==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr102216492wmf.139.1564457687872;
        Mon, 29 Jul 2019 20:34:47 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id m7sm51589968wrx.65.2019.07.29.20.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 20:34:47 -0700 (PDT)
Message-ID: <5d3fbad7.1c69fb81.b7831.6bf7@mx.google.com>
Date:   Mon, 29 Jul 2019 20:34:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.2.4-216-g0c4d120e771a
X-Kernelci-Branch: linux-5.2.y
X-Kernelci-Report-Type: boot
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
Subject: Re: [PATCH 5.2 000/215] 5.2.5-stable review
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

stable-rc/linux-5.2.y boot: 122 boots: 0 failed, 75 passed with 45 offline,=
 2 untried/unknown (v5.2.4-216-g0c4d120e771a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.4-216-g0c4d120e771a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.4-216-g0c4d120e771a/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.4-216-g0c4d120e771a
Git Commit: 0c4d120e771a048ef7ae9a4130169b1cf03c36da
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 72 unique boards, 27 SoC families, 17 builds out of 209

Offline Platforms:

riscv:

    defconfig:
        gcc-8
            sifive_fu540: 1 offline lab

arm64:

    defconfig:
        gcc-8
            meson-axg-s400: 1 offline lab
            meson-g12a-u200: 1 offline lab
            meson-g12a-x96-max: 1 offline lab
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

    exynos_defconfig:
        gcc-8
            exynos5250-arndale: 1 offline lab
            exynos5420-arndale-octa: 1 offline lab
            exynos5800-peach-pi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
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
            qcom-apq8064-ifc6410: 1 offline lab
            stih410-b2120: 1 offline lab
            sun4i-a10-cubieboard: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab
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
