Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A246C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7122133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="bzEXD4sB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbfJDHBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:01:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37736 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfJDHBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:01:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so4733730wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 00:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Jc/WrDTffdzMOLmQCIoEtNdtkjgf6yNFeVahnwheomA=;
        b=bzEXD4sBdyP+iLfO9xnq99BYTVpfWbDxhxam3qyEl4lk175w0CrsdanhXfss7flWcN
         zEdYLo4Pt9WjuimTbDv+ovi8OIkosoNROOGJkj0d24LcruisVbBYPxd3qh0so9IJk8Ea
         5nrrH38DjiBGIR3npe4mttmKntA7BpNRyZkuXzLWjTnscqAXMrx/fO2T/8CHbGHwqAEB
         3BsYrW/H8ZT0gswQwBmZjhYyhfXsWjceE8dU1afoNs1kdcyEXXqCwXIwTjfVyFrYLe9i
         hFdsteRWALu18gwJ6PJ3V0euEXBv39WTSUf78rci9aF1mHEeTinhPwfd/9XCjRU6DW9a
         h2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Jc/WrDTffdzMOLmQCIoEtNdtkjgf6yNFeVahnwheomA=;
        b=Z9+CyFTnXdixOAz0ed94IXEf5PM4LMu1beSNWfZ9rlXALk8R1qKyn+RjvhsUy7Rgjo
         IAb5s6ZYseRzsZs4vQTlcvG5hAObbs51siCUJK6RIwsb2wFQvpOi2+/CuaQTqLRxV5fl
         JzShF3niS8YpkApK8Gk8mbTiKL7Odl6Tbl5w5O37VuDFMFeeULGGwRjLtRfv6Y8aml52
         q3LAIrd0voo/KrQ9IaoTNJH3GPuftG0tn2uN3BLbZBkmsHSTHVN3p+fpAUlDCN1ZQMrI
         y757eNiHubqGzqnUcjg8W9e1LXXYGAJkTRdsfIFQq03h4FzeMuawJAiz85ATeFbGP5hb
         m0Ug==
X-Gm-Message-State: APjAAAWX9Z74z915DetR6hcOmiVu64dJCfn3b+bvwE1hUKybQ20uSufV
        4eLups7JCJeEfuZGjZhqVkXJag==
X-Google-Smtp-Source: APXvYqwhYCcMQldMQo77du5ARRj7J5UzwBdXjn6Laoh7sQAzd4HRTmI+vGvm/uz69ancRxlG0jDaQQ==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr10656378wrc.105.1570172462271;
        Fri, 04 Oct 2019 00:01:02 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id w125sm8566712wmg.32.2019.10.04.00.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 00:01:01 -0700 (PDT)
Message-ID: <5d96ee2d.1c69fb81.6b8e2.7a8e@mx.google.com>
Date:   Fri, 04 Oct 2019 00:01:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.194-130-gc1fc11455620
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
Subject: Re: [PATCH 4.9 000/129] 4.9.195-stable review
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

stable-rc/linux-4.9.y boot: 99 boots: 0 failed, 86 passed with 13 offline (=
v4.9.194-130-gc1fc11455620)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.194-130-gc1fc11455620/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.194-130-gc1fc11455620/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.194-130-gc1fc11455620
Git Commit: c1fc114556201dc059e2c202e99eac038af8495e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 51 unique boards, 20 SoC families, 13 builds out of 197

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab

---
For more info write to <info@kernelci.org>
