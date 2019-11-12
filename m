Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D955BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD75021783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="YZ+8M0RH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKLBjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:39:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfKLBjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:39:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so5117871wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=lp+rjsn167C3lmtCe6z3qS3tIVfXOT/rrM9f7kFPRTI=;
        b=YZ+8M0RHIzmdHlAGYOAvTxZOoeDVpZHRgZ89hVxKT4t6R+2JdLlah32oH0wl93yfV8
         R1Rh/dsZc3emYfh4rUjbLHZ/fT5RBbcATgEZ7xSF43idD22qCiLJ/QB4AbK02gTMB7fw
         cbpFZv2o1nsZAKhyxlaaGxfnYnXFQgW5C6SrrTZS2QQC5g4n6kgoHAaSg0I50hXEcaYG
         mGNootWCuWZ87DWA9w0B2bLMBryq6UraGt27gmTtKNWkQDYSirLad2jx041GIeQ19jiG
         nyHHe/PYQvB/Ks73mmlvubBSrwlsUIiuIhlw4Ae+93e2VJfBHZTDEHRiW8S/5g4spmxW
         1IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=lp+rjsn167C3lmtCe6z3qS3tIVfXOT/rrM9f7kFPRTI=;
        b=fnmmic0MVJ8OLctuYWjJ2EZ3KLiL7rcbov1r4elO/NHxhAC9Uj0sv3bwaLrF+RYpiq
         6e1REKt8PSJ5vQqzqkELwAvTuLHPZS/fnXpGUHyJyhttmYQc9mXP+TUVQ6PR30tigXWr
         VDm6EE6M+BqBC9VZBargRHQbxaSgAK45E03u/q+Yzn6I5SmMmN1dm8LI0WIUUE53sfnw
         HNuyxxDN3Ghytfxzrq3UJOCcpfMW8P2yIVS/eBvX1D7e/ZubkG2/yKZ2TF+IzrLkZHOI
         0+zVTXLol6oacxFe/mKPruoRGHVy1EIkKJUsJ1JwgVt3098h+kT1QIfB0ZwTHqYzHTxs
         jq+g==
X-Gm-Message-State: APjAAAVadrn2n82lBK8bwrrh6d2HsBKMOvlEJkk5w2YRO2d4CzaeEFt1
        Vcx4UrC/jrMKscOWuxkLgfCR/vR0MJiC2w==
X-Google-Smtp-Source: APXvYqx5IKJpOyjgqwQIy8+eEzp96ylq9hr4vtUpzWTCHYSiEC/zyz/yKZBSPz5utCMo4QzDLzo6eA==
X-Received: by 2002:adf:de0a:: with SMTP id b10mr2161236wrm.268.1573522742552;
        Mon, 11 Nov 2019 17:39:02 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a7sm18766652wrr.89.2019.11.11.17.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:39:02 -0800 (PST)
Message-ID: <5dca0d36.1c69fb81.9d3b3.bf52@mx.google.com>
Date:   Mon, 11 Nov 2019 17:39:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.200-44-g92b9901ba23d
In-Reply-To: <20191111181246.772983347@linuxfoundation.org>
References: <20191111181246.772983347@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/43] 4.4.201-stable review
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

stable-rc/linux-4.4.y boot: 84 boots: 7 failed, 68 passed with 7 offline, 2=
 conflicts (v4.4.200-44-g92b9901ba23d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.200-44-g92b9901ba23d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.200-44-g92b9901ba23d/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.200-44-g92b9901ba23d
Git Commit: 92b9901ba23dbd26e916a393e557a5ffec117124
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 42 unique boards, 17 SoC families, 13 builds out of 190

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            exynos4412-odroidx2: 1 failed lab
            exynos5422-odroidxu3: 2 failed labs
            rk3288-rock2-square: 1 failed lab
            rk3288-veyron-jaq: 1 failed lab
            tegra124-jetson-tk1: 1 failed lab
            tegra124-nyan-big: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm:
    multi_v7_defconfig:
        exynos5800-peach-pi:
            lab-collabora: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

x86_64:
    x86_64_defconfig:
        qemu_x86_64:
            lab-collabora: PASS (gcc-8)
            lab-baylibre: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
