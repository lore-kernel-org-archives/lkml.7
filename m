Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B8BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D28F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="MBXOG5zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfHNXQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:16:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36743 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfHNXQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:16:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so656526wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=YcOnCRhvASOCE8YHTM3+3xNRALgdjiXsHUDG2PLCBIc=;
        b=MBXOG5zR0vSOnBQd8KhlfxhuDJRdNNhNdQuxq4VR47SeVIK8plGbloHybugYfeC6sW
         sZ0plL2KJc/gBchjIqetxtk59qRutv9NdsPsBxckBXtXuyJTc7lGPAt0wKglFcer9bhw
         NQtp0espcSecKhuE6zHv6HhiIrBVJhz7gmgzPph5RBbR3M4Z9i7zGCJLvwO53uFz0Xxs
         IJEXvQbv607P1qJttaD65eeJcr9msCbGwIPEmcizpWyH7rnrCSdcJ5sP9enTpJeFUTu2
         Y8BVG0Q5xmg1voqbgmm+KSwbTQBEny9txbcUnzZPbCM6cish6GylB4ehi7Ly3DRcYB12
         eNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=YcOnCRhvASOCE8YHTM3+3xNRALgdjiXsHUDG2PLCBIc=;
        b=B9pNWdmdk3jngyULyDXAE3+kCAYqTUiF25g9XIlnh0fi6G0MPFxdRPe7V2lEwMM3FO
         q8avcMA/WQYqp+7KATO/N/9n7GkhyXzGxXusSm1yQzwZUyNty5/xXWYOBfHqpjyP9f25
         DMdMedBVmrZylmauRUg3BytpQ4/Ur0sTnxfs0ieXih5BotYgqc0ZEG2GKjujUQzKjkgE
         zBK6n5/JiNsrAr8PU1/OEGkL1rOA/52SKiphuh8vJX6i0WQ5UWWIIwM3v2kHjZ8N+Kv6
         gaf5QM55+BNqgyCnZv1IBaeZ+WkgQHkxUFla1pjbdL9ITT+iNxSWiKmgsmpdmKqpgQ9h
         7rlQ==
X-Gm-Message-State: APjAAAUhovdT4oVf3VZGyP+vvwUSw70NJTdJbaabCxJjUAej08jTyQP+
        bs2kyCUBrsvel16xt9XY5Y2a0nzde8OBlA==
X-Google-Smtp-Source: APXvYqxGRi9k5bfRHmF+C8w3CIbOc1lfBEBImYS+ceILTAduPDTNYG8oNogTwAyMuUN1kV1rf2s9Ww==
X-Received: by 2002:adf:f507:: with SMTP id q7mr1937660wro.210.1565824578258;
        Wed, 14 Aug 2019 16:16:18 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 39sm3070962wrc.45.2019.08.14.16.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 16:16:17 -0700 (PDT)
Message-ID: <5d549641.1c69fb81.a2cd7.0209@mx.google.com>
Date:   Wed, 14 Aug 2019 16:16:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.2.8-145-g2440e485aeda
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
Subject: Re: [PATCH 5.2 000/144] 5.2.9-stable review
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

stable-rc/linux-5.2.y boot: 134 boots: 1 failed, 119 passed with 12 offline=
, 2 untried/unknown (v5.2.8-145-g2440e485aeda)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.8-145-g2440e485aeda/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.8-145-g2440e485aeda/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.8-145-g2440e485aeda
Git Commit: 2440e485aeda5f36eaf2050eb1bb61be46275b39
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 81 unique boards, 27 SoC families, 17 builds out of 208

Boot Regressions Detected:

arm:

    qcom_defconfig:
        gcc-8:
          qcom-apq8064-cm-qs600:
              lab-baylibre-seattle: new failure (last pass: v5.2.8)
          qcom-apq8064-ifc6410:
              lab-baylibre-seattle: new failure (last pass: v5.2.8)

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
            meson-gxbb-odroidc2: 1 offline lab

arm:

    multi_v7_defconfig:
        gcc-8
            imx6dl-wandboard_solo: 1 offline lab
            imx6q-wandboard: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    imx_v6_v7_defconfig:
        gcc-8
            imx6dl-wandboard_solo: 1 offline lab
            imx6q-wandboard: 1 offline lab

---
For more info write to <info@kernelci.org>
