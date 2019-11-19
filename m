Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF1AC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A70222DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="vl42dBQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKSLWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:22:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56122 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKSLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:22:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2738175wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 03:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=pmLBujEphKkpDcEb0Ulnil8Cqx256T7mYb2KwVCXUZI=;
        b=vl42dBQKYDjSfDyRA/HVj2+uy5YggEsI+0RQ6UtXy45HvXgAtT7YQ2npGF0FfPsAI4
         Q/p6I8C588eauvw0xLAXWiwcUgN4rdLk8DwwYart78yvP6IeKEqVCgR0KrJyyimjMkHL
         CIyDEPS+e5PLqjHAt4YSDrgITY/fDzSD6cUppzGSNtI1IJexlz8VH97x2dl1Cd109pt4
         jrXfwB//9q4b33VoDjZqjkWVgzVHpfLZAY8O6iGy0tSRWJI2rgZD1fC1Kon2veCfmCGG
         e2GhZ0wQKouoif2zcO1E5oa8OwRVviuB1TspLWv/XnGw2Enr/SdsK4/BPUG4lLHjYU6O
         wmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=pmLBujEphKkpDcEb0Ulnil8Cqx256T7mYb2KwVCXUZI=;
        b=eRBKv9b1BnVfgOxdeeNccTFQ6A67tWMOKGyfbzXHZs7w7jR+crM9MoFEarq80aGHc/
         tnjnCJ5cocY2Eb6qXbAL2tv9gC6L9S3V9wFAaXz+qY+cMR0JBEBoHWHZfeUFgLUERe9D
         yQIGN+c9JO+a/ub3ZdbJ0FiCu6i8vrJPkkg9Z+x+VoJ1NOWs+JvJd3smPET6CC8pCUll
         bbMQ0DsQ+64V513cgOrRQGKbGWNpsCVXi2QUOoTV5jR99WvaBqIidMHTH1KjZrBSMMej
         as17wr8ite9+SkAzSvWIFQqAl5pGr/xBPB0Gpqw2ff9GcwEsldgeFNc0xN2rAVm2KuSo
         uJiQ==
X-Gm-Message-State: APjAAAWvR58U7NdPKpNanVg7Tfx1gqccsEF8T+sxTbglNKZSnSD3WCM7
        n7xDXzKcYvXjLOvEAMjhtPfwBw==
X-Google-Smtp-Source: APXvYqwpHVkGmy5mYbEF/1vPIupdk3wNqWnfSPJkIyBAp8kYqvKuQhzCbShpmVnZuC5yANB3k/+mVA==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr4684620wmi.109.1574162526503;
        Tue, 19 Nov 2019 03:22:06 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z15sm1839749wmi.12.2019.11.19.03.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 03:22:05 -0800 (PST)
Message-ID: <5dd3d05d.1c69fb81.6955e.7fff@mx.google.com>
Date:   Tue, 19 Nov 2019 03:22:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.154-240-gab050cd3bb84
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/239] 4.14.155-stable review
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

stable-rc/linux-4.14.y boot: 83 boots: 1 failed, 73 passed with 9 offline (=
v4.14.154-240-gab050cd3bb84)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.154-240-gab050cd3bb84/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.154-240-gab050cd3bb84/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.154-240-gab050cd3bb84
Git Commit: ab050cd3bb84dbcaf833a1abd102e5814a2112cd
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 50 unique boards, 18 SoC families, 13 builds out of 201

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        gcc-8:
          bcm2835-rpi-b:
              lab-baylibre-seattle: new failure (last pass: v4.14.154)

    exynos_defconfig:
        gcc-8:
          exynos5422-odroidxu3:
              lab-baylibre: new failure (last pass: v4.14.154)

Boot Failure Detected:

arm:
    exynos_defconfig:
        gcc-8:
            exynos5422-odroidxu3: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            mt7622-rfb1: 1 offline lab

arm:

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            mt7623n-bananapi-bpi-r2: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

---
For more info write to <info@kernelci.org>
