Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E78C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FEC20673
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="h1YHFFXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393045AbfHVVRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:17:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51616 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389823AbfHVVRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:17:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so6980392wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=JXgFg85dZHZEnnD7WQXs9gXAOtdzngXWL4jdrsUNdbM=;
        b=h1YHFFXFi8ALbP9egCdFztrE9LZDcjw/p5F0eUuteQdHs6JbW+tFO2XL0kR1A1lxa4
         sWKdxIsAYfWNgjhdHi74a62EHBKpeuyT7lxL/8LE2ba7gD6u27/+A+4LK+08YTjIg7id
         XQUkZ/yZwTL5xzxHq3Xwko8FYl3NKk1GNaAG1ECwZmyTfkmsM4bM6g1GS12m9U4IpumC
         BcyKbHVCy/0YVwePoBVTui4r6mbAR8ZBZgrVSKUfJX7KnwFMagcewyMJzOucavTx+mhN
         eSLDq7X8OEvl7gtIR753kmKZRzfkfYHN/MwjKM1JnoFrZHZloNqEwagS78Rc0zQE3JMm
         mbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=JXgFg85dZHZEnnD7WQXs9gXAOtdzngXWL4jdrsUNdbM=;
        b=CrB4I7lqhCviHgDzYwPNEI6+2pZlRx7YhMQotzn3A/uf8qJwWtTJF3O0Rd+k8/mluJ
         Yca99JBJi5SKbDYZ5cvJPxhBdCzA2YiPSDg8jXVZZv2aN8J2Kaa6Mxgb4dO7OvIpS5TK
         JQmSQeMrzZGFv7Z2jhMwZ2i2F2thdQAJermjt8iZZO/AxPgQBtX4x9YTAwtzbE00Tc2U
         a6ouAknKSmf6c8Rr2IuYNoNBifuf27yZp3GZnUf8uyysP+tlXQ/urxTr/JSZdPFMlrNm
         vuFVYh7WrROmLmW24pcDBIVogOsHWmFtJg1owjW4ekzfYtRAvNMZsu/iPbGoG+ureD/X
         CS0w==
X-Gm-Message-State: APjAAAWL4kvn5ciIRX6ULcp9WXhIEqFXkWZ7ILEWDzIFm3B6PY2D+mUQ
        QaXz6KsPj/7hjhTxaRLBQm9ioA==
X-Google-Smtp-Source: APXvYqx3PCJSGg2+eWoDByCx1D7/6ErcnO+3iKn+jMdbY4uSJ1R+r1sawrf+9GfMc6258/Q5IisFDg==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr1141538wmb.116.1566508620876;
        Thu, 22 Aug 2019 14:17:00 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id e3sm1849035wrs.37.2019.08.22.14.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 14:17:00 -0700 (PDT)
Message-ID: <5d5f064c.1c69fb81.f049d.97cb@mx.google.com>
Date:   Thu, 22 Aug 2019 14:17:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.189-104-gfefc589434fc
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/103] 4.9.190-stable review
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

stable-rc/linux-4.9.y boot: 110 boots: 0 failed, 94 passed with 15 offline,=
 1 untried/unknown (v4.9.189-104-gfefc589434fc)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.189-104-gfefc589434fc/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.189-104-gfefc589434fc/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.189-104-gfefc589434fc
Git Commit: fefc589434fcd4cf95d9dc24271b21e7913ef6e4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 54 unique boards, 21 SoC families, 15 builds out of 197

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        gcc-8:
          bcm2835-rpi-b:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
9-96-g4cd56b7fcd6f - first fail: v4.9.189-97-g6971d2d959e5)

    omap2plus_defconfig:
        gcc-8:
          am335x-boneblack:
              lab-drue: new failure (last pass: v4.9.189-105-g9c965ba1a288)

    sama5_defconfig:
        gcc-8:
          at91-sama5d4_xplained:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
9-96-g4cd56b7fcd6f - first fail: v4.9.189-97-g6971d2d959e5)

    socfpga_defconfig:
        gcc-8:
          socfpga_cyclone5_de0_sockit:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
9-96-g4cd56b7fcd6f - first fail: v4.9.189-97-g6971d2d959e5)

arm64:

    defconfig:
        gcc-8:
          apq8016-sbc:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
9-96-g4cd56b7fcd6f - first fail: v4.9.189-97-g6971d2d959e5)
          juno-r2:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
9-96-g4cd56b7fcd6f - first fail: v4.9.189-97-g6971d2d959e5)
          meson-gxbb-odroidc2:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.9.18=
9-96-g4cd56b7fcd6f - first fail: v4.9.189-97-g6971d2d959e5)

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab

arm:

    sama5_defconfig:
        gcc-8
            at91-sama5d4_xplained: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    socfpga_defconfig:
        gcc-8
            socfpga_cyclone5_de0_sockit: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

---
For more info write to <info@kernelci.org>
