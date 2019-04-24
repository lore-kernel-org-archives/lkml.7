Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14ADC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAEE20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Q3W9tpfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbfDXW0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:26:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53441 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbfDXWZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:25:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id 26so746455wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=zO4dpW4OlJCGJXojMpGvthYi97pMDJD871G93opIqYo=;
        b=Q3W9tpfFkgllBPgK9ZVoILopphOQTuoeb8Lo/CXvJfABhfl9r8ZeCN2u49mC2yuB6N
         0TgIMpZhID8W+PWI4tEwZYUFSoG/PPQRplfEZDlQ/fjDcPpI36GFjC+Rqm7U+MMf6QX+
         OoEy1XVyITn63iEkFvC9P8jRm7T1apt3SWvJOpl49f7Iys7ZCNYMro4e3edIcZeZ1ZC5
         eYpkmklrHy95jDMizMKi1NKHQ7wIiG654vaVXC8XhAkxU0t2y79/eGtDsmr2CEBJ07ve
         F7nTY6yYiTd9/0glUM/+Y5ATHpsmnzI73byj95ziCbn9x3UuvCkJHqJ5OSAVG498Lx1h
         OF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=zO4dpW4OlJCGJXojMpGvthYi97pMDJD871G93opIqYo=;
        b=pgztXHwMS0l0Ogb1el/UVd31xcz2mTitfY//oii2bx/xakY6p5qrPognKa3eyRaVBV
         4oaXrPfpqwwOLRtOnqdj3BZ3faMcLvCRPj9R/sbksZfKHQfd60rmI2g2Azi0qkLrt/Rm
         IzUCruM3p0ktcbd4QCVfC37QuiS8ZJFuoli5eT+AMKD4k8CEt366fEVlwE1dq4GDP/3E
         VpD1tN3lY0wnOHft3XYVVuEot82ku6KOC8JzsslNZEWQdWKj4ozRO0DBJIErRXSqVpT9
         Kg3vfGYCZoDratZSy8Ou0YJP4F26d1nbSRvDrbrh5poMi+t/eNB5+A05oNQn3H1Kd1uY
         N9Fw==
X-Gm-Message-State: APjAAAXYMHcqJULcbnusC4yuYZIdbpaUGhObTpu+huem2Jh9v9FHRBVw
        /hjSf7XfZ666cLUDSjueVOOmpw==
X-Google-Smtp-Source: APXvYqw/USHMY0tOAaThKxaNmRba7/7hiOAwblmXWdC69z914UMyF7mdZa8D6sznjMmogYLwTVkBAw==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr950772wml.73.1556144756865;
        Wed, 24 Apr 2019 15:25:56 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l21sm16936622wme.4.2019.04.24.15.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:25:56 -0700 (PDT)
Message-ID: <5cc0e274.1c69fb81.28831.ecc6@mx.google.com>
Date:   Wed, 24 Apr 2019 15:25:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.178-169-ge340a9c1b725
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/168] 4.4.179-stable review
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

stable-rc/linux-4.4.y boot: 83 boots: 2 failed, 73 passed with 8 offline (v=
4.4.178-169-ge340a9c1b725)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.178-169-ge340a9c1b725/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.178-169-ge340a9c1b725/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.178-169-ge340a9c1b725
Git Commit: e340a9c1b725b0f93827ba2f4947bf276ec5a97c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 43 unique boards, 21 SoC families, 14 builds out of 190

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
          exynos5422-odroidxu3:
              lab-baylibre: new failure (last pass: v4.4.178-98-g93a1a2b3b0=
35)

Boot Failures Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
            exynos5422-odroidxu3: 1 failed lab

arm64:

    defconfig:
        gcc-7:
            qcom-qdf2400: 1 failed lab

Offline Platforms:

arm:

    imx_v6_v7_defconfig:
        gcc-7
            vf610-colibri-eval-v3: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            bcm72521-bcm97252sffe: 1 offline lab
            bcm7445-bcm97445c: 1 offline lab
            meson8b-odroidc1: 1 offline lab
            stih410-b2120: 1 offline lab
            tegra20-iris-512: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

---
For more info write to <info@kernelci.org>
