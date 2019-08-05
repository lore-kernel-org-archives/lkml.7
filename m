Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C07C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABAB216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ToBmiZLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfHESfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:35:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51636 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfHESfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:35:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so75720176wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=LIQ+BTAfYOlvy4ObHsv0M1Pyx3cDYno+rPPuaXC9he0=;
        b=ToBmiZLN8G6wG/0ZmXhdBJlFqG3+sKRKOE8Hf6FxGuLbGvhGEggYPt1TOOHLUlqhlh
         TmDptKo24MMJYJayiX2Ckrtj5Sd9d9CjSl4B00Wq102v/ItE7D50ICPLtJzosCIXuRSG
         Bbem8NAmuvLCSkhc6wuE1KG62695eIrGVz9RiCL1DzcDhhfc9V8Po7SyLFY4AvyxMpXR
         ApLkYHMbasAcOUU5dZmMRCuQxZD0L0KNUxQlcfp9hP9NOtXfttprfKI8Hzn9b1+FLJqC
         tAOjcaOHdJFlrgXkL1+Hf4s4t9qCmFcJkwBXViceRXjOYBHptfPsNvYpqBMWp52aNjuQ
         EKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=LIQ+BTAfYOlvy4ObHsv0M1Pyx3cDYno+rPPuaXC9he0=;
        b=RNI+uRDEvi3BMGD4EJDX23sm+tspYFq2kI7Rf9nfsL+mRc2eGkXzos4xmmPYmZCuUd
         eWs9dzeF3QDRMOnhunZrJavwJ81k8Wrc7k4CPE49zh1tLABVTuexMiUT1gTzEy2hvY+X
         Pv2wg2ddWuYIdu6UpXfO+T1wZGlSjiiG8hNxCj83LJ7xJIxftqGiGVU9+UR609Px9HIc
         U9XAOcC1NHDM972BZs3TW3nChMrdEc30Bc+sWfMzcku47NVEfLTTTGKAITieb6kTrpTP
         W4vPX2hdL0xV7wuaHLRv7aartauI+4OpPpLb+mabyTCZgw9sdbgFN+nxn7TyVli9xSPH
         EqwQ==
X-Gm-Message-State: APjAAAV8TH9HIs0zZQYy1E9tAloUrOULStA5KxyDp7sGQYvAn20rW8cR
        n/Rv9jjZCnWUJ39ff6kHzNlYbg==
X-Google-Smtp-Source: APXvYqyQ3VexThjnsplma7MZFmT4vvpaUDOBKoX/36H+nBgw69e+lqWtToeT24+ydGZiDw54NFGH1A==
X-Received: by 2002:a1c:968c:: with SMTP id y134mr18568665wmd.122.1565030119747;
        Mon, 05 Aug 2019 11:35:19 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z5sm61084189wmf.48.2019.08.05.11.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 11:35:18 -0700 (PDT)
Message-ID: <5d4876e6.1c69fb81.23787.eab7@mx.google.com>
Date:   Mon, 05 Aug 2019 11:35:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.2.6-132-ga312bfbb74da
X-Kernelci-Branch: linux-5.2.y
X-Kernelci-Report-Type: boot
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
Subject: Re: [PATCH 5.2 000/131] 5.2.7-stable review
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

stable-rc/linux-5.2.y boot: 134 boots: 0 failed, 93 passed with 41 offline =
(v5.2.6-132-ga312bfbb74da)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.6-132-ga312bfbb74da/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.6-132-ga312bfbb74da/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.6-132-ga312bfbb74da
Git Commit: a312bfbb74da87b0c6822845b2cb9932d43c9208
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 77 unique boards, 28 SoC families, 17 builds out of 209

Boot Regressions Detected:

arm:

    qcom_defconfig:
        gcc-8:
          qcom-apq8064-cm-qs600:
              lab-baylibre-seattle: failing since 1 day (last pass: v5.2.4-=
235-g44397d30b22d - first fail: v5.2.6)
          qcom-apq8064-ifc6410:
              lab-baylibre-seattle: failing since 1 day (last pass: v5.2.4-=
235-g44397d30b22d - first fail: v5.2.6)

    sunxi_defconfig:
        gcc-8:
          sun4i-a10-cubieboard:
              lab-baylibre-seattle: failing since 1 day (last pass: v5.2.4-=
235-g44397d30b22d - first fail: v5.2.6)
          sun5i-r8-chip:
              lab-baylibre-seattle: failing since 1 day (last pass: v5.2.4-=
235-g44397d30b22d - first fail: v5.2.6)
          sun7i-a20-bananapi:
              lab-baylibre-seattle: failing since 1 day (last pass: v5.2.4-=
235-g44397d30b22d - first fail: v5.2.6)

Offline Platforms:

riscv:

    defconfig:
        gcc-8
            sifive_fu540: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            meson-axg-s400: 1 offline lab
            meson-g12a-u200: 1 offline lab
            meson-g12a-x96-max: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab
            meson-gxl-s905d-p230: 1 offline lab
            meson-gxl-s905x-libretech-cc: 1 offline lab
            meson-gxl-s905x-nexbox-a95x: 1 offline lab
            meson-gxl-s905x-p212: 1 offline lab
            meson-gxm-nexbox-a1: 1 offline lab
            rk3399-firefly: 1 offline lab
            sun50i-a64-pine64-plus: 1 offline lab

mips:

    pistachio_defconfig:
        gcc-8
            pistachio_marduk: 1 offline lab

arm:

    exynos_defconfig:
        gcc-8
            exynos5250-arndale: 1 offline lab
            exynos5800-peach-pi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            bcm4708-smartrg-sr400ac: 1 offline lab
            bcm72521-bcm97252sffe: 1 offline lab
            bcm7445-bcm97445c: 1 offline lab
            exynos5800-peach-pi: 1 offline lab
            imx6dl-wandboard_solo: 1 offline lab
            imx6q-wandboard: 1 offline lab
            imx7s-warp: 1 offline lab
            meson8b-odroidc1: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            stih410-b2120: 1 offline lab
            sun4i-a10-cubieboard: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            da850-evm: 1 offline lab
            dm365evm,legacy: 1 offline lab

    imx_v6_v7_defconfig:
        gcc-8
            imx6dl-wandboard_solo: 1 offline lab
            imx7s-warp: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun4i-a10-cubieboard: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

---
For more info write to <info@kernelci.org>
