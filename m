Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03773C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5962189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="zwnC/Wlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfH1ERe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 00:17:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40403 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfH1ERd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:17:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so946645wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 21:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=WZUECIFBeRtT+xP+S9WlDdtALHliIxx1WeADt4yn5yk=;
        b=zwnC/WlrsP1eFq7JfVD6LrXtgg0N3basgEbWdbugiirVrBmMPVAzjr2+CcpWnazejk
         +m9dafUsIST1nK2S3HIECpHMwk9BwClzdNekS+Ca4MTJhn9TZarwggctkhQulFyXLtWC
         rBe6tNsGYMr9PdIkdzCUDZCWKC3hz0u0Na1eQ2U9g/dM2Rs9ifYy4DP2QIVzvpg0sPfO
         MFYgikq30kjx7+4WwOoqeHL3JDRTIpP2msB8zg/OiMxzJcGRalx+1ueKP/X98kJTBUMm
         r7NBuduJPtWr00PEXmqRY5bt2/Z00KoYcJUd3W674QlNKZPX6vx0GpK8O8V8/SO8m6kb
         PXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=WZUECIFBeRtT+xP+S9WlDdtALHliIxx1WeADt4yn5yk=;
        b=tMsKTR/wahNQJMtRGCG5Iel2BwAbcBmmf7oQS+gxEzQ+sdgo8c2i9auFNWLpEgsitk
         ryHKGXDGmPWNe429Z3MPziIZ/JXtjofMn5z48cel9/VZBk9gmekBYoqXfS7HSuNgSYKA
         dLbbBb9A166Mjs0Zn+rbcCVlouJPLsR+jzlfWnAu3BGn1pKeI3xj5Yikrgth7H16dIJm
         vLXugGSqkP+hCWYDquoPrBpuoDi4EwAiYslTRRjqKXqLf5KDJzON9cGJ5p3/912qzHPn
         RIrKubKGjk9jsfP/rn4tpOW/dhYI9SPiKPp/Q8q6u+bQbeU95AxyXYBGtRDFrAJF8Uj6
         IrDQ==
X-Gm-Message-State: APjAAAXACQ/pH0B9upMv6jouXL2ZmxZbM79BBLSl3RAqgh/yzUFjg/gk
        dcDcNEp8jCT9XNm3oQ3cPG+DiQ==
X-Google-Smtp-Source: APXvYqxvLMpz8CCQEMINDJkpwebK6uZ/ULNbYxGLJEkr9Cr5JmGfOEH4BENAO4dr/aMiKyjATlJ5Ww==
X-Received: by 2002:adf:e452:: with SMTP id t18mr1741262wrm.0.1566965851088;
        Tue, 27 Aug 2019 21:17:31 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b136sm2158048wme.18.2019.08.27.21.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 21:17:30 -0700 (PDT)
Message-ID: <5d66005a.1c69fb81.35b79.af5c@mx.google.com>
Date:   Tue, 27 Aug 2019 21:17:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.140-63-g4e1a19d20000
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/62] 4.14.141-stable review
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

stable-rc/linux-4.14.y boot: 125 boots: 2 failed, 112 passed with 10 offlin=
e, 1 untried/unknown (v4.14.140-63-g4e1a19d20000)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.140-63-g4e1a19d20000/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.140-63-g4e1a19d20000/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.140-63-g4e1a19d20000
Git Commit: 4e1a19d20000330e767ddc9c64317d7d576a8f31
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 64 unique boards, 24 SoC families, 14 builds out of 201

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905x-nexbox-a95x: 1 failed lab

arm:
    sama5_defconfig:
        gcc-8:
            at91-sama5d4_xplained: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab

arm:

    tegra_defconfig:
        gcc-8
            tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra20-iris-512: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

---
For more info write to <info@kernelci.org>
