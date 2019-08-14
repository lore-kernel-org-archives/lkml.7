Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE02FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8939F214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="KSGPqM76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfHNVgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:36:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52520 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfHNVgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:36:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id o4so1712wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=XWwAylDLr1ewfARUebkjg//6gCYbw06NtLYokdWmek0=;
        b=KSGPqM76DveV79q1yTio02HLMvbtGr9oo/BtXzHUK+aso46xCrKV67SmkjxzbisiE9
         sGu/lbFIU/QlmxGAX3YpnZUyJx3C6+r+FUyqbetev+q4OyOjAaZ1WH6FoM2m+AWHVefL
         4rCOl0MWVzfgjFl2dgtxQufU8602yfwGcKUyTLmKHS/UcxA7+oCeRhMf9/qw6Y0ZW8kU
         Qn4Gc6GxNFBb7u4tA5HQvOfi3Xsla5kqVM7Rvcm/8I/etSeYynlsM9o5O/NflrNE2+L+
         seloSevQeozaOfD4j1Aci8tOsCC5uleWTCsbqH9HWtKLilVWxAYERgF6e3MuCnZswHlE
         0UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=XWwAylDLr1ewfARUebkjg//6gCYbw06NtLYokdWmek0=;
        b=s7vlh+8CDuWIZEXS1rboBYkVAoR0UcL8gewmFdGWm7qy/nRCZm3FEuPes6rF7WUU0P
         8Ofi6OMXA9t3felCH3t5AAJvTNMr27F/jQsqRViWMqBsnQVfyB+jCQe0u8y1/WkD2d0Y
         PNB1ivX86pONq0USKLWQgvlvxlpBi5gl3qZMmMsY3FZxuedAy7kWCMLgGvm/a4Mi/2nW
         pDb9kYIsiojfVTkRXqYPlyvBntUciV3ZRQ0hYyfLU73eg0rMdTk55yy+L7aoK/GBute5
         GZq4Es8oKGBxu2NohAyJ6Uqt7467Y9wbqiFymkRYwhIHPm/1I9rPYQo9knnxSqoeepe5
         jAcA==
X-Gm-Message-State: APjAAAWHIOE4cA/D2oYEcfP5NMXo8GcQUH00wWk3y3I18PnIwWRMeP0U
        F9G9i9mctPWNuR60zWOa55TRyg==
X-Google-Smtp-Source: APXvYqwP4DtXoYWeVm/3r36krjGhXKkjcp6Hm5I7BClJcBTppUcOxX5xSkXAWroLNI/EGGvh/iXoqg==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr6576wmc.6.1565818576956;
        Wed, 14 Aug 2019 14:36:16 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f70sm806504wme.22.2019.08.14.14.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 14:36:16 -0700 (PDT)
Message-ID: <5d547ed0.1c69fb81.14f04.42bf@mx.google.com>
Date:   Wed, 14 Aug 2019 14:36:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.66-92-gf777613d3df0
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/91] 4.19.67-stable review
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

stable-rc/linux-4.19.y boot: 138 boots: 0 failed, 126 passed with 12 offlin=
e (v4.19.66-92-gf777613d3df0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.66-92-gf777613d3df0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.66-92-gf777613d3df0/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.66-92-gf777613d3df0
Git Commit: f777613d3df0e7226d30d0e0ba97e9419e3064f2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 76 unique boards, 26 SoC families, 17 builds out of 206

Boot Regressions Detected:

arm:

    qcom_defconfig:
        gcc-8:
          qcom-apq8064-cm-qs600:
              lab-baylibre-seattle: new failure (last pass: v4.19.66)
          qcom-apq8064-ifc6410:
              lab-baylibre-seattle: new failure (last pass: v4.19.66)

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
