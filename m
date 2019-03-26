Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B2CC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071A820857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Y4Ic/WhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfCZKXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:23:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33034 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:23:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so2033317wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=jJLlhnDqvDbSGuKszT2yDktYDvv/jgO0pJ6vOc3ZBRk=;
        b=Y4Ic/WhE3GdJ/qeNUbSh0IEi2VDAYwwHCmLS1TljN42EE7aPk/6VcXV4v6Owuf+IB3
         2fGzMFgmTV3GkD7sNrmLAh0B2q9RQHN3979hnh6K3M6vcjy7ntPNHLBXj47V3poP2wJk
         im35OK8l6fqDDcMVkWEXPKl/McXNKeD4XfVMFsPj2dCmucrPadeddynOs5XlhBImNn7n
         7Z4NX8wPbrLb7GVMQ5cuwR34f9AKkdflSoeyO2xirOtmF0ZmVccVAiZF3nW3d1fnTG7v
         clNpAJvjvAACHf+Zmc6rOUoHjVLDZzSI2vBWfNl75Z/jrniZ5RW2+KOPZxr0MLRUMous
         4abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=jJLlhnDqvDbSGuKszT2yDktYDvv/jgO0pJ6vOc3ZBRk=;
        b=DqhRxzP3YuG7Yv+j9HiELG79YGxHXwoTI6SBa+NU3BXsE4KPsmho13IvicPieMj3g1
         WGzk7nJ5/F7/2tBL54l5iO5W5AUdr6Vr665GMzUq5H9D4QzTiZVx8C4LYi1mxHk3LJ6V
         nQchrcX/mTp25lP/iL+CTHcUuMVzRPJg7fbXrwiEsG9wzd7kraqBRGFffE950zyc4tml
         nSGoHz9fTXclCykDieizGYqUdoef4oKcIXVfzWFBFEfD0hxyoQbR7bOUCmD+7kRB1BHP
         ULy+RYbekOS9JqI3pG6D8xr71lf4P8sLkGcncmhRKgcALFXl83rxhY75AAHlf373Czak
         j2Eg==
X-Gm-Message-State: APjAAAXGNLu9gmeiioUYIWZ70RyJrm8gz1ydyGKN5RxIooDdyW8DtXoN
        CFjTrJbrFJKwrAoUrd1JlG2CrwNHpp9VIA==
X-Google-Smtp-Source: APXvYqytPoYI0zQqMI2FhJ15g2DveDZqk9Mv9nOUkIA0qF5zxEIFDdOJVS5/fG+eZW53PbMOAao9JQ==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr8233827wml.34.1553595815108;
        Tue, 26 Mar 2019 03:23:35 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s12sm18682693wmj.42.2019.03.26.03.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:23:34 -0700 (PDT)
Message-ID: <5c99fda6.1c69fb81.ecdb5.c834@mx.google.com>
Date:   Tue, 26 Mar 2019 03:23:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.108-42-g4bb6d9c67e49
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/41] 4.14.109-stable review
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

stable-rc/linux-4.14.y boot: 110 boots: 1 failed, 97 passed with 12 offline=
 (v4.14.108-42-g4bb6d9c67e49)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.108-42-g4bb6d9c67e49/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.108-42-g4bb6d9c67e49/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.108-42-g4bb6d9c67e49
Git Commit: 4bb6d9c67e49d5301e6341b32ab5d72354e821d6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 61 unique boards, 24 SoC families, 14 builds out of 201

Boot Failure Detected:

arm64:

    defconfig:
        gcc-7:
            rk3399-firefly: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        gcc-7
            bcm2835-rpi-b: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab

    sama5_defconfig:
        gcc-7
            at91-sama5d4_xplained: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
