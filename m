Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A0FC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C9D21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Uek8QpIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbfEXDIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:08:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32962 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbfEXDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:08:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so168797wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 20:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=FrWVceI3LtR5FXxB8VcRvYsptOYTyMCHoGS31s3o9rQ=;
        b=Uek8QpISTDvAmO2k7+vMVSMUzvpm5mjQvrPO36Wwy6wxPZ6LweTdmpAKzUkXhr6KQk
         +WwaUejc3kWfFjGfJknTwbUX1gSMvvHHrmVafhoRv9GlA/2ERpbLlboxYOcwMUNTn+tA
         /fQluHtzwxB8Lr0xsf4J+p8UomkBIrLAPlF4KQPRSOTJj0wi6+u+CqpePHjTEBVN+yX5
         OSGCJLvgK9rdwbeluEs737ScCstUwnOus5+Tu06uVOZYbo5Pqsr5OJcf/f741J+oJnpF
         1xsNdV+J4cNvby+8uRQUDFOTdQxAfdz4kobsHzB3lphJfVODF4fsDDv//0Am0Hs/XSZl
         n7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=FrWVceI3LtR5FXxB8VcRvYsptOYTyMCHoGS31s3o9rQ=;
        b=UVh0ty/ypqDGlM63e7dGXzfgH8fmtdQFn/N+5qEP2kK7nIDVAOzB2yZGQ2F6O8nnUZ
         CgX0RaXBIjA4GNFCvHFJNpql0k2oBAGh45c4JSlFw7I1uD6uH/eBdTv5ios+mcXqyAD8
         2ZX1WsVe3QZyrOfTMHsxLTbwGarQXQreafxFhk8fjo6dcytA5cXIHnDbVfSLVNz3hGDh
         IaW/SZU7aPrkJfAnqApYXRDmTqc5Zp6LcQdp1VzshiPE44MxOW7ZYRTwQBngssn1PIHe
         ZQakg+/zIOYV9+if7mEBBIzDFBo+/oroiEn1riqpym8RcugKLPp66GVsayfq+yP1mLaK
         LsMw==
X-Gm-Message-State: APjAAAV7D2uK6INZGXXARpc2K4kZFB77oFuoT4Vx1yRCs39tVU/wIQap
        cmqz0u0X56SsHosYr0aQx16LXUJHS/5ENw==
X-Google-Smtp-Source: APXvYqwlnCCV/zlDEy4EC5XnWE5afnhbVOSr22yWh6gUWydCLhKkB/mh0Mfc06dm7kNpUe6/5yTDrA==
X-Received: by 2002:a1c:be0b:: with SMTP id o11mr14605446wmf.63.1558667313538;
        Thu, 23 May 2019 20:08:33 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t7sm890736wrq.76.2019.05.23.20.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 20:08:33 -0700 (PDT)
Message-ID: <5ce76031.1c69fb81.9ce3a.4a71@mx.google.com>
Date:   Thu, 23 May 2019 20:08:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.121-78-g64cb9b0bb7de
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/77] 4.14.122-stable review
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

stable-rc/linux-4.14.y boot: 125 boots: 2 failed, 108 passed with 15 offlin=
e (v4.14.121-78-g64cb9b0bb7de)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.121-78-g64cb9b0bb7de/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.121-78-g64cb9b0bb7de/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.121-78-g64cb9b0bb7de
Git Commit: 64cb9b0bb7de34fd893ee96ecf613039130de9a6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 66 unique boards, 24 SoC families, 14 builds out of 201

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap3-beagle-xm:
              lab-baylibre: new failure (last pass: v4.14.121)

Boot Failures Detected:

arm:
    omap2plus_defconfig:
        gcc-8:
            omap3-beagle-xm: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            rk3399-firefly: 1 failed lab

Offline Platforms:

arm:

    sama5_defconfig:
        gcc-8
            at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            stih410-b2120: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab

    tegra_defconfig:
        gcc-8
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
