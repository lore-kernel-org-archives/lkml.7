Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE56C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E502E20828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="zBoL95lC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfG0COZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 22:14:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38301 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfG0COY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:14:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so56165042wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=u+EbFX8sFMH8pWi0TV6CAS/I0F4j3WfAGkd0Fx8VVEw=;
        b=zBoL95lCC+VPdvja/4U3V2lbyo+rh1+Ywr6tM8ToiBqfYr50a1L3W0Wmcm8Yf0LJHW
         4BTe5kOSQ8ejvEvR0HRYlApjrwck4XBXt4nZ4VDlbDDoWWIY1MiZA460du9N8iHS/B9Y
         QFzMye2hhlZ/ak0bZ5zb9VnE78TMQZC7WAdxBvV0cdsncpazOsUsxLh1P/ck6fCafYVO
         ZQZNQibz9TH2gfp5FOyiyyIrVozR6V6I58YIyLEHHCqrV396M216kBuHf9faWYEuVVfJ
         Z5pY0MxO0tsijOoLrKlg4lr+NdDbcDNvbp6jlSCgwvviX9yC4Zz0+qCqOdQi0TGCYVvl
         dfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=u+EbFX8sFMH8pWi0TV6CAS/I0F4j3WfAGkd0Fx8VVEw=;
        b=ssFPOs307cr1PnzLVD0dE2aCoyPx/FfrqP6lt+jdGIM4rdoHzNJBinEt0L4Z4hJDPE
         RlqPszqjNj8RhVWpB5UjVPByw8zcVry6MP4rUHamD98/EOq7s+tNzzQOU/K9eegUEve8
         mF+DuhREBUO2BYIvtbXNFFL3ZlYPNQlwSceOGuAARx8Eq+eA7afwn6V+XchivHNkHrmM
         q5YFotFg+e+CaP6W0HPGVNtX+YYsBfDAWJ+pSahKJOD0u8VtA1Bvs4UfEsPeliFqXoYn
         LF+SpCgk1nBctwpXHRp12lgwmVAMQ2qI2TFURysvYKGCrHAvFodXpm+y5RtVSTrdkMx3
         C8eA==
X-Gm-Message-State: APjAAAW12ol4a9LavoHN8RNs9oAqJZA4vV7db+2TuROLIgLe7kvvgETK
        w2iqNJT/sIZQulT18RxOAcs=
X-Google-Smtp-Source: APXvYqyaqxBdIkPi7LwPrV8eaLuJGxamLn3RtSnWkdi79t72OjyC4pvuq/SwA80ws8UqaVjoL9fs3w==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr32743341wro.190.1564193662879;
        Fri, 26 Jul 2019 19:14:22 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s15sm35146778wrw.21.2019.07.26.19.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 19:14:22 -0700 (PDT)
Message-ID: <5d3bb37e.1c69fb81.33e47.f6a6@mx.google.com>
Date:   Fri, 26 Jul 2019 19:14:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.2.3-67-gd61e440a1852
X-Kernelci-Branch: linux-5.2.y
X-Kernelci-Report-Type: boot
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
Subject: Re: [PATCH 5.2 00/66] 5.2.4-stable review
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

stable-rc/linux-5.2.y boot: 129 boots: 1 failed, 83 passed with 45 offline =
(v5.2.3-67-gd61e440a1852)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.3-67-gd61e440a1852/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.3-67-gd61e440a1852/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.3-67-gd61e440a1852
Git Commit: d61e440a1852a64d8a2d0d358b9582b19157e039
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 76 unique boards, 28 SoC families, 17 builds out of 209

Boot Failure Detected:

arm:
    omap2plus_defconfig:
        gcc-8:
            omap4-panda: 1 failed lab

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
