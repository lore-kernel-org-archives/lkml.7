Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F31AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9252064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="2FFXm8I4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbfHBPzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:55:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44179 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbfHBPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:55:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so77673753wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Lv7QFpyym32Y81fdJu6NtFzt1x5OEGeU7A8SCvtyPV8=;
        b=2FFXm8I4VD5uaQN81j1OMi5u0WnGE8PTuWf5JAiJObC4EnSBHuad/ez/QFFa5Z7hew
         oizk+WxcDAsLURnD91ZgNQagiecbUR6WuLoE0vQFtm61XYyGVMMnELNCP8InkBB7aH0/
         CYAOPOj2Gpz8oLI3BmjPaVSddfAKRxDhSwKzQkLaQXoBFh+4lAh68IKv03Pw/CRFnI6O
         lpT3W+WFGYwT5juPs2JuNFYRnAPY5B4XHzktaZif3RU/eDiDL45QllhH28hIPhR7s4dm
         jKH2la6XA6Nzri3ablBBzf/ew5YDdErYimQ6FAgpmBk8Ge13jaXWu6sykmtPQgxRcB7D
         XcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Lv7QFpyym32Y81fdJu6NtFzt1x5OEGeU7A8SCvtyPV8=;
        b=aUVgY9JQO14M/Oo2C9b7XHPUrRhjd8NN6G9pD45AoaqBwd9cdhZwp3EiNqkAEybGHY
         nOe4n23+6I0urH8v1YkeH7b2TL7Rf6yQJHbFPHmtcBZEHUtwgqrPk6NEW0sgagtul9Pb
         VimYOzDLSNIeQOaYLL4jK/dVX18b7S4MpXlS6rmuRcQbjt7wWzvZJIFHvbM1+qlFwH5n
         REcy3P5Zjx2uRZSOxYg95+2A2ORuEX3OZvuYlknYfABQVlkYAHEVbck/l6bCYbsDnG9r
         cCs4iR+UFaPUxjp3m0ODZjM7nsr6fDXSy42KrycpSUm5oZb3bzheMD3N/hGXkm91Vnr2
         NEAA==
X-Gm-Message-State: APjAAAXU/FLgAheobQUse2jiGHIBPFoFaUNFbnm3Qx0Sqa7Ly1ZKT0x8
        yJPdpXNLCAY7BFjiinQEfI8=
X-Google-Smtp-Source: APXvYqylL0rKZCAV/G/jL13mt//zVAvsHbc1xM+R450FX7x1CBo+F3awrZdbYcjPVPsJaUHEm8HCkQ==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr55392866wrn.37.1564761298369;
        Fri, 02 Aug 2019 08:54:58 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x11sm53685384wmi.26.2019.08.02.08.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 08:54:57 -0700 (PDT)
Message-ID: <5d445cd1.1c69fb81.714e6.c928@mx.google.com>
Date:   Fri, 02 Aug 2019 08:54:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.4.186-159-gc4286991ea44
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Report-Type: boot
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/158] 4.4.187-stable review
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

stable-rc/linux-4.4.y boot: 92 boots: 1 failed, 59 passed with 32 offline (=
v4.4.186-159-gc4286991ea44)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.186-159-gc4286991ea44/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.186-159-gc4286991ea44/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.186-159-gc4286991ea44
Git Commit: c4286991ea44309c9b2dcf717fd7d04270809eae
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 44 unique boards, 20 SoC families, 14 builds out of 190

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        gcc-8
            tegra20-iris-512: 1 offline lab

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
            meson8b-odroidc1: 1 offline lab
            omap3-beagle: 1 offline lab
            omap4-panda: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            stih410-b2120: 1 offline lab
            sun4i-a10-cubieboard: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab
            tegra20-iris-512: 1 offline lab
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
            vf610-colibri-eval-v3: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun4i-a10-cubieboard: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

---
For more info write to <info@kernelci.org>
