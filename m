Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B17C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2931F21670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="y2fGzrIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfIDWSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:18:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36396 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfIDWSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:18:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so433885wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=TZPdAUlA7qNN6+jQmsqssp5ULo7w+saDdp63nLUEMIE=;
        b=y2fGzrIs50cZip7cAIKE9aecdC3tuGcGvKZ72RLSINAb47s5+pg0IRpAv88jVm/CsK
         lb0R2+FuzoZT1ZjpcZCdVGj2mmJ4qEHIevHazm50DXmiuW0Ly40GYsRHSEsDTElp+9vX
         kpmkgepHrFEQNHpDnzs1Nzz6OOPDegomj5fKZZ63qS9l12vwW6dO5IeSoPe+I5QR5KG5
         +boFfoQXg7zSmiFD27tzqWjL+Br9muAgPlG0Nph62KFXSJpD5yUOVbZXolGHx+JYDdGG
         SyORBZYMxHT6enIivjX8Cqp2ic/x7n8s0iFUZboQApl0sh82mV0M1yY9su4WWPJcakjg
         UkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=TZPdAUlA7qNN6+jQmsqssp5ULo7w+saDdp63nLUEMIE=;
        b=EuErsmrEg7dmLEGfbzzAQ2F1coBJXUlYV891fffRWTDZa6OVCjY+4BxLMitPnXo4Zx
         3pqf1d3IaVDhP77aSuTFZ1xReobCSi09xprmJ11XUMxglKNObU8c29lNvouvjPXM+oHP
         5Yx2LGkft/7WutARtbLEykKrZYUJPN1mL4N3kUTj8XuwQ2+2wlG5fPOLq2jDoeIi9Lrj
         Wy7iLsMxMIp8pAX79pZCoT2QSfCqrM7InR62WNJkEg/gU9J2qF3JPoMXXiUkARJEVKcX
         JT8Jol+lCVnqEsaZdoeLpqstjBGF0WbIolS0uy4h44PJXH9pYsBEPltV050NZG7IhvxP
         oNeg==
X-Gm-Message-State: APjAAAV9Nv0PJwMLd/3cwGH/4AJ1QwBhye24b8LHpioVw+aaoFtO60Qx
        39GlA8ybjL+5SuNKFs0ImFNsQfuVuyeNCw==
X-Google-Smtp-Source: APXvYqx5qP6ThXwf9hTY7IR6rPWqHtzAPFyAeKPQ1CJY59Bn3YKiccfWu5dAwK+8B0sUoKDwnJV2VQ==
X-Received: by 2002:a05:6000:1632:: with SMTP id v18mr396841wrb.233.1567635493684;
        Wed, 04 Sep 2019 15:18:13 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t13sm371541wra.70.2019.09.04.15.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 15:18:12 -0700 (PDT)
Message-ID: <5d703824.1c69fb81.90644.1c1a@mx.google.com>
Date:   Wed, 04 Sep 2019 15:18:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.69-94-gb755ab504136
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/93] 4.19.70-stable review
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

stable-rc/linux-4.19.y boot: 149 boots: 5 failed, 133 passed with 9 offline=
, 2 untried/unknown (v4.19.69-94-gb755ab504136)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.69-94-gb755ab504136/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.69-94-gb755ab504136/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.69-94-gb755ab504136
Git Commit: b755ab5041366b954c39bd97caa982539e0d1223
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 77 unique boards, 25 SoC families, 16 builds out of 206

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            hip07-d05: 1 failed lab

arm:
    vexpress_defconfig:
        gcc-8:
            qemu_arm-virt-gicv3: 4 failed labs

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
            sun7i-a20-bananapi: 1 offline lab

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

---
For more info write to <info@kernelci.org>
