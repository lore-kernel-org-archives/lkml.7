Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27540C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D06216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="mco3O4Au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfIHQig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:38:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37097 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfIHQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:38:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id r195so12010829wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=S0kAixsv5Ss9XN3UyIhqxUQ8a9FRU1URaKsRKak3iyc=;
        b=mco3O4AuUtrzllXE8Bh5xiCHvbD2JVaFjPgxUjlijVVMYFbpQ7bK47a6BYlP/akBVE
         aftJ7z39dfNApRBhxJPxwGLlXZAGV3X9h5QMjB+6t0JUOV555rSa11jl2XPmz13V1buP
         V6RSti7/074OIuteZ/ayNSq3O4J1H/Eovg2w74oVPRhfknWDUEKfcz82epiP43hIyO4D
         yFlIOpb2cyMmx9HEQq6s83ob2m4L774G2b85rQh4215u6hufbo4iW4aMo8BnHEl3Ixp9
         66YVRRHptnLzkxmfJq/1WF1ysX7Di/wlNGS5WaNEe7GGCjfMaym1LmQVyX+sKVQIG667
         tQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=S0kAixsv5Ss9XN3UyIhqxUQ8a9FRU1URaKsRKak3iyc=;
        b=BUb6yaSNJR/D/FwRXPeeqkK8Pd33E7zlXhaJub9sNP0errIwuXd1ACb3Knvm8lGirC
         QHeM3PqpDf6YNZR71kxYZpQDCIic3aeXNI9fjZAMYH1vS+zC06fnSsujwbR1wO3HY8BT
         2vWbMkUxn76nJ5YZ7tw4RDFctc+A3G+MQW5lbXiVVErDMgwNnfR1YAQJ2OVbm12jAWlp
         J2N5SM441ctxA7ThaWHLK4NxVzEH0GFWFU8WGOk6Pvs2uvNg9IoPyAD5GojFLOWQGv/S
         zuuC/3vHXHVJAFykQJZB/OSULh50gayak28SyUvowK+faqYfdO+2+26ydKKZr3jaeDEc
         vsHg==
X-Gm-Message-State: APjAAAW/JSZz/W+7eCpbgwsQv2h5jOQ+3xLLXVyCxxorZ5o8yhhJwk4N
        Qi2Zf8MM4pOowNEOvPJ471zE38hUAPo=
X-Google-Smtp-Source: APXvYqy84UX29Uj6iuydnGdjhA5g40N+4Rch6z8ykezovnkN/Kuna23znHDqNj9Bu5rO2WDr7PFWqg==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr16087769wme.16.1567960713191;
        Sun, 08 Sep 2019 09:38:33 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id e20sm22902354wrc.34.2019.09.08.09.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 09:38:32 -0700 (PDT)
Message-ID: <5d752e88.1c69fb81.0f33.990b@mx.google.com>
Date:   Sun, 08 Sep 2019 09:38:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.191-24-g6128caa0e308
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190908121052.898169328@linuxfoundation.org>
References: <20190908121052.898169328@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/23] 4.4.192-stable review
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

stable-rc/linux-4.4.y boot: 106 boots: 3 failed, 93 passed with 8 offline, =
2 conflicts (v4.4.191-24-g6128caa0e308)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.191-24-g6128caa0e308/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.191-24-g6128caa0e308/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.191-24-g6128caa0e308
Git Commit: 6128caa0e3089f1c7c5ca695cb9e4737f77ad413
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 48 unique boards, 18 SoC families, 13 builds out of 190

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

arm:
    tegra_defconfig:
        gcc-8:
            tegra124-nyan-big: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            exynos5250-snow: 1 failed lab

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

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu_x86_64:
            lab-linaro-lkft: PASS (gcc-8)
            lab-baylibre: FAIL (gcc-8)
            lab-mhart: PASS (gcc-8)
            lab-drue: PASS (gcc-8)
            lab-collabora: PASS (gcc-8)

arm:
    multi_v7_defconfig:
        imx6q-sabrelite:
            lab-baylibre: PASS (gcc-8)
            lab-collabora: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
