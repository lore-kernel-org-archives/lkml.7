Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1CCC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A135F20644
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="tDTrFG9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfIRMAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:00:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39554 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfIRMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:00:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so2256478wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ADDEHritjAAyr1Uf8VLuPhIliMxd6VsivOVJPdhBhS8=;
        b=tDTrFG9OO0SQ/j4VPPw82dJXvs/LchdfBItGZfh+YI65BJkwxeV5YeeQzZ69Hj0fqM
         oGBWGO75/1RCTKLJ5QISvrPTZR/Ukl1M13hfBaLptFu089jOyG1dTijDHJtg0krv/9CD
         zl/TQrSoHZpCqaIRxREzZfIMzngi3O4gsuOxtTs4iJtODcaky2erBKiJ2ysuC1ApwALh
         yck/Gagf6Iw+VmHxRpwLSLvOqaTh26/5tModzOBX6RBhuT8eo6PKhjyTycR5uw6zaL/F
         SniRRkdpdUJIn3K/y2zaWdZN0FLEweV7OuhfXTAj9jXGbVW6/AZv+C+qz0B7pSuWyU8Y
         lVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ADDEHritjAAyr1Uf8VLuPhIliMxd6VsivOVJPdhBhS8=;
        b=QVVsGLShtzVs8ZYgRCYWReohygwBcRNue6DwHwZCF0KJeAJaysyOQmgzgaGwhLzJbH
         67fUdXUpdBXb91WNAERlSjbBZMpMf6CiUv2hAkjLGpqhY1kMCr51fQRFEqOmb4yRd9ow
         Nb6N3TCWzOz8P+AthwTCGP4K253iZdKHYLYXMmeiJsXAT5StX8ckvTRAA3Cs9BS6l/OQ
         +Mj4GNP+y1und8yr1zS2pfiJLr7oQMn1r4ALQE1tQkBaK/7h2R4SGl3Zc+as9csdpHSh
         FbTaGBt32eTU2w4lRy8yBT9IqJi8PXrt2eMTapI/uY7zOKVVLGiSIhRJk+Wwdn5jlhnK
         nzbA==
X-Gm-Message-State: APjAAAU6tJx3qVvmmRtfFACT7Pt0NxA1B43Kc1fhdCAjdQk1UCUQz3lg
        TP2i95jg0vRP6g7SI9byEhR9WA==
X-Google-Smtp-Source: APXvYqyOf9bAl2LHcY6EVznBmlNQTlzJOxTHOTgqToVP1jNH0xrcB5vTOsxeGodHednmXUrv+jtx8g==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr2314538wmk.148.1568808000676;
        Wed, 18 Sep 2019 05:00:00 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z189sm2945227wmc.25.2019.09.18.04.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 04:59:59 -0700 (PDT)
Message-ID: <5d821c3f.1c69fb81.2b5f2.cc58@mx.google.com>
Date:   Wed, 18 Sep 2019 04:59:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.2.15-86-g2f63f02ef506
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
Subject: Re: [PATCH 5.2 00/85] 5.2.16-stable review
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

stable-rc/linux-5.2.y boot: 145 boots: 1 failed, 135 passed with 8 offline,=
 1 conflict (v5.2.15-86-g2f63f02ef506)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.15-86-g2f63f02ef506/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.15-86-g2f63f02ef506/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.15-86-g2f63f02ef506
Git Commit: 2f63f02ef5061324ba168b1cb01c89fd89a0c593
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 82 unique boards, 28 SoC families, 17 builds out of 209

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            rk3399-firefly: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

arm:

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)
            lab-collabora: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
