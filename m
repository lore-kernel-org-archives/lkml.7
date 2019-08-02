Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87476C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D73D2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="NNFWM0oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfHBQfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:35:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41824 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730828AbfHBQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:35:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so74591880wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=8jC0z1URQ1H0xyCXJDkfPMve8cjcGKBfDhT0uA7E2TE=;
        b=NNFWM0oiXe3g6Tvx832q3/DBNG02GtBddw+kxX1llCJb6LxKU1n/Z12IJayyJmwQh+
         ioSvXI2JhwCCpA+Bac8E8FCRPFVXcM2ynwZt3JBpWummRyWWVxNcD/kPgWBuT08TI2uR
         37bP/6Kwn/b/ZawR10nz2Q/4B35trsqTn/YvPDYJPq5iWXyPsXkmk/iBKAzttuT8JtJl
         PbAV96hUimt9te6/4ZgsVl9enJolBKcBVsURes7sQCsGB0BVwAi0180ZKO1bb2PHVysr
         8r/gjoUrp0RgADrvQVTHWstLp94XuCRCRAghBCeRIwRj7+m2Cfdft/Lh4cfp2g+zFf+J
         JVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=8jC0z1URQ1H0xyCXJDkfPMve8cjcGKBfDhT0uA7E2TE=;
        b=B6AJSzYLSokh+ZD8dhuVjreuwSfqE9zK+4ACJGf9ZujVR2OYp2Df/8CZx8wbxDUbrx
         XNePFBRTVUXiQsYgeqdgzCLPTmfaN2lemTudAIY+4iTScCmaY16cwUXiC5gjrBrwI+az
         5N12cCJp+TDd1seser/ahJYRRRCD5Us9VnPpxji3b3niqaCxFM/Flm7mfMc2h7Uh7E1r
         Bqza1xrmICce7XS9vS61xaSYRLpL2ijUm6joTQDmAyPeeK3+Jfa5mWaXXvSgc1apUep1
         AQLQvH9NK3wS3XktGNNfYq4QySf7FhcC3jJNLYEOmuPs4ywFw+FEJWFvGK5jJu9ZNyx3
         OabA==
X-Gm-Message-State: APjAAAXUsGazkGiZ6sF8r1Vael/p2Wjwgj8oNQmTH+Ga7MnrZD6Jg2vk
        Ib8nZ0EivK19KfHmLXPudd8=
X-Google-Smtp-Source: APXvYqyWWjzH2TRcQ0z7dDiznv1D2CaqThzDnGFdT7KCn0cU0KREvikpfdYkHrnSYM1MoarafBqWjw==
X-Received: by 2002:adf:b195:: with SMTP id q21mr3999407wra.2.1564763698721;
        Fri, 02 Aug 2019 09:34:58 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j10sm134938738wrd.26.2019.08.02.09.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 09:34:58 -0700 (PDT)
Message-ID: <5d446632.1c69fb81.e9bbc.28ff@mx.google.com>
Date:   Fri, 02 Aug 2019 09:34:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.9.186-224-g5380ded2525d
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Report-Type: boot
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/223] 4.9.187-stable review
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

stable-rc/linux-4.9.y boot: 101 boots: 0 failed, 66 passed with 35 offline =
(v4.9.186-224-g5380ded2525d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.186-224-g5380ded2525d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.186-224-g5380ded2525d/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.186-224-g5380ded2525d
Git Commit: 5380ded2525da1be5103e3f0f33129dcbffa3add
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 50 unique boards, 23 SoC families, 15 builds out of 197

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            meson-gxbb-odroidc2: 1 offline lab

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
            imx7s-warp: 1 offline lab
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
            imx7s-warp: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun4i-a10-cubieboard: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

---
For more info write to <info@kernelci.org>
