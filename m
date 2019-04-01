Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A146CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7CA2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="D/vk/3O2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfDAVDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:03:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34264 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDAVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:03:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so13862676wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=jIu4y7cNQAYIsvWhRxS0GoX6Efawu9aLjve6KGH4XXg=;
        b=D/vk/3O2PGcCN4j8QUg6jvCo3Agz6qmhI9ZDIMhOtVsl3T+HUbjaGnRbNo2gBmpNUs
         f50WNpd+YmNxC2EnZwWmVNxffzhc4dkkZodGozIzHEU3o3DkzreRKXbhlLNxUK1B3f7U
         Sgt2XA8neFE1hNH140uhnCHcEOvTiwj6tLYvq/NLtVh1LqXA+YaJfLkTRfhD65BbPGmz
         nD1uWBMFdBe26bAYWe+22jSZ1FlD3IGDmIhx3d5WZvvTWKdrBxtvbH+GzByYPgAauYv/
         7/c3BDnv2l6D66G3VH/yjHnSC5RL+nDdApO3jPK18GNlJp1FBakYGeBM3uJpgeKDicP4
         a6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=jIu4y7cNQAYIsvWhRxS0GoX6Efawu9aLjve6KGH4XXg=;
        b=pUGzxejk+xr4eB0vcPTDd/AX0pZQueZn+eLPC7XXKxxvGPnejtoNSgm5AmHYIBf2v7
         YDaOOzgdqI83k1MvKpWSHriN149C9hsswnuqMJlNdLwUFGUZH8YVRobA7QLmkYF3oggm
         5Lo/N+qbP62a6Ei5M4lNQwUqPWjktOOd6Cv7S4+EY4Vrj/6egKUZErJTjN8PJCuU3uyJ
         FaAZCf+rmc3sVfZ5LkevjXInzZUtMpnXy5jXBvzmSqns1l1aRS8x83cf2hLn3RWLh/wn
         Psi9wda7pFbYIg77YEk9C7ZHkH7wFwHuDScaIbNcPGYCOC6scwT3nVdvLWDx88zgcSc0
         KoHA==
X-Gm-Message-State: APjAAAXLaFZWU/igjLk+B8gcL+cywFZnC6TrlKyDfBUZJkW+apjmx75z
        Y2xeAKVtQtLDPN5E1uAoJqDRJw==
X-Google-Smtp-Source: APXvYqwsc5jbmkAu49rz5WE3nZn9C+XgLLhp0jz1Zq8RgKCoWP4mgiNLZMiksk25NY/b37RK5Mg5yA==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr14366390wrn.51.1554152625395;
        Mon, 01 Apr 2019 14:03:45 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 204sm23237794wmc.1.2019.04.01.14.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:03:44 -0700 (PDT)
Message-ID: <5ca27cb0.1c69fb81.cb9c3.a45d@mx.google.com>
Date:   Mon, 01 Apr 2019 14:03:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.166-56-g32a26a3187dd
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/56] 4.9.167-stable review
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

stable-rc/linux-4.9.y boot: 103 boots: 0 failed, 84 passed with 18 offline,=
 1 untried/unknown (v4.9.166-56-g32a26a3187dd)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.166-56-g32a26a3187dd/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.166-56-g32a26a3187dd/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.166-56-g32a26a3187dd
Git Commit: 32a26a3187dd6e6e91800f4505da332baca61deb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 51 unique boards, 22 SoC families, 15 builds out of 197

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
            tegra20-iris-512: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

    socfpga_defconfig:
        gcc-7
            socfpga_cyclone5_de0_sockit: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab

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

---
For more info write to <info@kernelci.org>
