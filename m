Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A325C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D0121850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="iYb3zXR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDEFoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:44:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:44:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so6368193wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 22:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=QP8ZTOlSoWOuruHYNnfTkjE5mw2cF333iExXd338WeY=;
        b=iYb3zXR5YpstHjnlADyq/3wtQsm9tXmLTIGGPBxM7s0Ir6luERTIBzMp+2fwpIOd0y
         XVoRsA9Z1E/eXwD4gNwiBYCzmc//ZNtKLJOW4Sv73Wq+xxEHrQyTY3loF7xfI7HoMQMR
         dVwDhBwcjvxOHZzq/L/r616/6gtPrcF2hz2I3RO3EwxfoegHtryNqhr0pcV8Vno/rIP3
         W2TEo4k7JjdegW22SQSWVBtdI0jgtwHVjWMxeACQyMq0zYDQSXJ3Dt2ybMpsQg0Brl/R
         tlQRcIS2Sn0xegqk03TOR+JdH2z47oMHZe3HSY9AfFKDzLHfl3X/CWoeX16V3LGSGHZM
         yjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=QP8ZTOlSoWOuruHYNnfTkjE5mw2cF333iExXd338WeY=;
        b=bBfyUgsi8zjmeF0xhjks6c+JhacSOU1oRoZL5aiRWzdGfYTTKxSm520Ut7P8TycNja
         mtFCo+k7/UKzhWkJxhMFEyJ+2CJBeJ7upZp5n6gOnWCON6kCiQdOpuZseezELMHSjuNq
         dyoPmJ8BOZELuwBPMFTvPb4i6S9Jll1cxU9KzQ5j9Sy+r4SM5bGPS4FGDsvT+alOJMtI
         RiDL6XCSV47VPb99if0C4l8m97sjozhUQNdQiGCDxe+8roTNAJUpRn7N0xpOXA8TYG3m
         O7B5y29AJ/NeY+MxRxdc+lsi+wBlaQtGr+ZO8dPEQS1uaav7M80VSs2v+G/nMMWE8uTh
         aa5Q==
X-Gm-Message-State: APjAAAW9q+mHWGVPD9aJwMhkyZx+xUgp34zo8SePT6hxGppziKESnQ5p
        Apes0Dvo6SxlVkG4h/TuVEt3fwpfOUgc4Q==
X-Google-Smtp-Source: APXvYqzuypTebU1Mxvqwhm2tQKUGWxFnK/jtfAcPuZpKQw7z58td5ejsYJtVNcJQXOmZFj2LGvPVsQ==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr3645882wrx.201.1554443043190;
        Thu, 04 Apr 2019 22:44:03 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d11sm933764wmb.19.2019.04.04.22.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 22:44:02 -0700 (PDT)
Message-ID: <5ca6eb22.1c69fb81.188c.421b@mx.google.com>
Date:   Thu, 04 Apr 2019 22:44:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.33-187-g4b338ef616b3
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/187] 4.19.34-stable review
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

stable-rc/linux-4.19.y boot: 120 boots: 13 failed, 90 passed with 16 offlin=
e, 1 untried/unknown (v4.19.33-187-g4b338ef616b3)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.33-187-g4b338ef616b3/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.33-187-g4b338ef616b3/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.33-187-g4b338ef616b3
Git Commit: 4b338ef616b3d99a0c49c952acec89b827db9c1b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 66 unique boards, 23 SoC families, 14 builds out of 206

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-7:
          meson-gxbb-nanopi-k2:
              lab-baylibre: failing since 1 day (last pass: v4.19.32-135-g0=
1a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
          meson-gxbb-odroidc2:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.19.3=
2-135-g01a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
          meson-gxbb-p200:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.19.3=
2-135-g01a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
          meson-gxl-s805x-p241:
              lab-baylibre: failing since 3 days (last pass: v4.19.32-135-g=
64b7b716f98c - first fail: v4.19.32-135-gd6e41cce5aee)
          meson-gxl-s905d-p230:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.19.3=
2-135-g01a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
          meson-gxl-s905x-khadas-vim:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.19.3=
2-135-g01a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
          meson-gxl-s905x-libretech-cc:
              lab-baylibre: failing since 1 day (last pass: v4.19.32-135-g0=
1a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
              lab-baylibre-seattle: failing since 1 day (last pass: v4.19.3=
2-135-g01a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
          meson-gxl-s905x-nexbox-a95x:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.19.3=
2-135-g01a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
          meson-gxl-s905x-p212:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.19.3=
2-135-g01a3983fac4e - first fail: v4.19.32-323-g8822c8438169)
          meson-gxm-nexbox-a1:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.19.3=
2-135-g01a3983fac4e - first fail: v4.19.32-323-g8822c8438169)

Boot Failures Detected:

arm64:

    defconfig:
        gcc-7:
            meson-gxbb-nanopi-k2: 1 failed lab
            meson-gxbb-odroidc2: 1 failed lab
            meson-gxbb-p200: 1 failed lab
            meson-gxl-s805x-p241: 1 failed lab
            meson-gxl-s905d-p230: 1 failed lab
            meson-gxl-s905x-khadas-vim: 1 failed lab
            meson-gxl-s905x-libretech-cc: 1 failed lab
            meson-gxl-s905x-nexbox-a95x: 1 failed lab
            meson-gxl-s905x-p212: 1 failed lab
            meson-gxm-nexbox-a1: 1 failed lab

Offline Platforms:

arm:

    bcm2835_defconfig:
        gcc-7
            bcm2835-rpi-b: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

    sama5_defconfig:
        gcc-7
            at91-sama5d4_xplained: 1 offline lab

    qcom_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
