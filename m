Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C73C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7212087E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="pa98sFTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfIEBSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:18:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37985 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIEBSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:18:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id o184so765807wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 18:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=kw6lFi6Ppv2LkDSXe0CgFi5cYCvUwq431DN1kesmg38=;
        b=pa98sFTknLNcM/+bnoK79ewzDm+c+Xw37c8o5A8Px29TrA4HC+0ZfWQt+aDqdVnMhz
         qW+GfqaD2XP3Oio39y8X7+GRNL1t5jCzKDqpcgfMRzqm7lIAh6wsCNtxlByEba/APvOP
         +EgJvXLq+Dh4YsMytrmy14ZdkIGZebudpziceiZTpTEaufZxv6yLwCjxqqd4lUP2zSuD
         Hiv8DzKc9j58LCoES2zwmhkNgzmFdNxW9EB/lloXxSbEKXtCDlYnFap3GxyVGSvOymj6
         ifJFClHI54w1a556lVelgSlbY5wCIGsUyURoNd5f03uZICfecCUg+N+eR+cQ47qe2Vbj
         h7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=kw6lFi6Ppv2LkDSXe0CgFi5cYCvUwq431DN1kesmg38=;
        b=tzVNxWYJMXTnH6vMLZ/8GW2dM2yKvHXZXshTRFim5DZ1ennpYuqCgkm6VhWkL43R5L
         j94rlM0mlOdDwOQ6xRYm8fJ2zfui4Z03vSffOHJOOBf+WoqGOu6m+kczK65sjs2YEvSJ
         2KOuhg3bPUQsqKaSf3n/UgXmknWNSEm0spByqaOoCx1QwVroAX4F95iBLqzAY7MCBlov
         /HdJExQXPcTfxmbirLKfgu0mRFGyrXE1OUjQpRQsOC2fgKh92xLdZup+7eGoSr3ICX1s
         CIIWc674lhzf8PASjdZ+7sdFUvjYkRvUuDJPtzsmIG7XBiP4kPwR9trb7V/NpjhWSyOJ
         DbYw==
X-Gm-Message-State: APjAAAU+3XKk33RGgEzxiaGD7u6bEDEhSrw6bqYIenIa5M3AzTyIPhm0
        NuN0OTcSExVwajbpSYc9mWA3lg==
X-Google-Smtp-Source: APXvYqwLN5/MBhiK5F1JfFPWR9MPbSRTjX2v2Z6hw7o8FBLfSOuYgXu14nQuL5kw/RZR6/Cyr3KJLA==
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr741494wmf.176.1567646293498;
        Wed, 04 Sep 2019 18:18:13 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f6sm960751wrh.30.2019.09.04.18.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 18:18:13 -0700 (PDT)
Message-ID: <5d706255.1c69fb81.6e7e1.4473@mx.google.com>
Date:   Wed, 04 Sep 2019 18:18:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.190-78-gfab7823b08aa
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190904175303.317468926@linuxfoundation.org>
References: <20190904175303.317468926@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/77] 4.4.191-stable review
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

stable-rc/linux-4.4.y boot: 118 boots: 6 failed, 102 passed with 9 offline,=
 1 conflict (v4.4.190-78-gfab7823b08aa)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.190-78-gfab7823b08aa/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.190-78-gfab7823b08aa/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.190-78-gfab7823b08aa
Git Commit: fab7823b08aae873a7ab1918c9a0a5125dc89754
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 49 unique boards, 18 SoC families, 14 builds out of 190

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

arm:
    vexpress_defconfig:
        gcc-8:
            qemu_arm-virt-gicv3: 5 failed labs

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
            sun7i-a20-bananapi: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu_x86_64:
            lab-baylibre: FAIL (gcc-8)
            lab-mhart: PASS (gcc-8)
            lab-linaro-lkft: PASS (gcc-8)
            lab-drue: PASS (gcc-8)
            lab-collabora: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
