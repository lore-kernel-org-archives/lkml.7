Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413FDC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 19:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1839B2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 19:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Z5LKGHGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfI2TAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 15:00:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52640 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfI2TAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 15:00:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so10885198wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=dq1noghuki3s05Ms2hjQ2tq/heCYmToBu8e3a/R//7k=;
        b=Z5LKGHGid/K7epxcforaYglsNnSUaV8lnCarCN9CdgBD4Qatjnn9cnsZytP9ky59ba
         qB9zPJu0h2qcPHVPL/J+51KdrPOytzAmwLR1/kHWJoyMCVPB8zGLrGdrLha1im3vXMSg
         bz56XJ9ykAdYr6o6krDqocZlt6CEkWarxKRKRuII1wjLcsvSHgzpq/DNx7NukuC9vPB/
         dv1II0TaVlwLAYf8Tw/YP0Tp8ELv6SYSj12mFGgXU0mFgLiMgzMTqQHzlzxPunwLBWiY
         NH3/sEHN0XioDah1YTnGvYnNKb+j73/N9L1sP5/Xjuoa2FyGy2aPWuRGUKIDs6fpHKwn
         sHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=dq1noghuki3s05Ms2hjQ2tq/heCYmToBu8e3a/R//7k=;
        b=a2Bc4Fmz0LmgMAvxSKPDgEz98gMa92s/J0SbEpDfdQSFKbnT//6lVDXEATiW1cFYhT
         swoRoZkoZGKIfKgV00d3h1AYXGaEXqjufxWgTBfeCh1SdUyB+KAMyT7zBSWVStxQe2B8
         ly8T2bQIUXFI4fluaYYsAFpyHPg0YLjvsIlzA3Ro4LJ6LzUxAzwnWFUmTrV2NRvS8rZV
         sdLRPBxOleT6jesCz/uA12N/Q56SfBi+tGwY3M+TuNgsf8qjQuPT7gUGQYN0QhnoV87f
         TyubIBn3unGjE6C7gFz/16Ft0hyfLU01X2L/4dFHD9J8liMGc7MzQu9niTb1F4YPFOl4
         X0rw==
X-Gm-Message-State: APjAAAXJDiewPv2z7g1ItzweuuMm6fEa8Id9Wl5r9n/wWdn35EDGc3jl
        7DjqmOw+4kqBxF1H9KQR01x7Cw==
X-Google-Smtp-Source: APXvYqyFtlLEZu69YPYh3aY2ZYV4LXZ+eLcytsMIjpAYY/55CwRALUe4eIvg9U+aZQRlgfBnYgDa2g==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr15397343wmm.66.1569783631912;
        Sun, 29 Sep 2019 12:00:31 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o9sm26711912wrh.46.2019.09.29.12.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 12:00:31 -0700 (PDT)
Message-ID: <5d90ff4f.1c69fb81.12517.7d4b@mx.google.com>
Date:   Sun, 29 Sep 2019 12:00:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.75-64-gb52c75f7b978
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/63] 4.19.76-stable review
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

stable-rc/linux-4.19.y boot: 80 boots: 1 failed, 78 passed with 1 conflict =
(v4.19.75-64-gb52c75f7b978)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.75-64-gb52c75f7b978/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.75-64-gb52c75f7b978/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.75-64-gb52c75f7b978
Git Commit: b52c75f7b9785d0d0e6bf145787ed2fc99f5483c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 43 unique boards, 15 SoC families, 13 builds out of 206

Boot Regressions Detected:

arm:

    tegra_defconfig:
        gcc-8:
          tegra124-nyan-big:
              lab-collabora: new failure (last pass: v4.19.75-33-gdab8e08e7=
087)

Boot Failure Detected:

arm:
    tegra_defconfig:
        gcc-8:
            tegra124-nyan-big: 1 failed lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    exynos_defconfig:
        exynos5422-odroidxu3:
            lab-collabora: PASS (gcc-8)
            lab-baylibre: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
