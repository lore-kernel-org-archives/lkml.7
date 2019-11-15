Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBCDC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3499F20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="aA0SMJqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKOMUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:20:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34885 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfKOMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:20:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so10783853wrw.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=NBITj17KIDDQ/wzdId3cQD3bmEwVbK2XADeS/shNAmE=;
        b=aA0SMJqxZ5qcVRg+Rexn4IUDhZEFaMChYd9AwPuKUGLa9qL+xmKhDupbAKhCCvks4o
         fCOKnxLnPDDOw/51wdM8v81Q2bCibCu6/z/9U2K8fnvi42KWtW0siAoAzx4s8j7aCIuU
         0VCQRonwNfB0R2bQvytQKWcaeM7x8H3NwFQ8mw1BEx5T1Jv+hFDLAhbPQldkreXTshHC
         FyrGdYBd17ZKus/LpSAsH9zscydFiIwAfcr3MR190/DirJIBMCtPeNyi+z+mLd0pDAIL
         cFepH6QXLOvJmi3sDRtfqBdqQx76aZDwfKHAm6gxOGqpdQc02xqpuX6I+NoW2YMW0877
         kk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=NBITj17KIDDQ/wzdId3cQD3bmEwVbK2XADeS/shNAmE=;
        b=E/qduidx1caxUbGEwIz83ynLf7RUDqjfQvesKz/A/J2qomfVR3MrWbxTLLFB3n7eL3
         eULO9oHnMZYjgUjfAMDUznbiM1IpV2AszN0ssej0cazNFfCDIU/tI7LnjtLFDt5LN2w7
         vsoXN3NhJHh2sH+zUpmKV3SxM3Sb/21N4RulNcb7wYLAisHEVfN95syqEBGDnof+Er/E
         TO3mhaeFD9S45vhZv3a99y57TuGkQPP3oci2s2yG/nizAU32K3htRzg8ld5DqzDMbwfu
         qIddyMgVMzqtbpYuAvR+IlivPwlzS5xI5bq2/3pFC+fOoD4K9l+ujWV6cfjsnfXtEMC+
         KFDQ==
X-Gm-Message-State: APjAAAUbXViDWfFc/qcRUrNvWIfIOdadbHURdp04cbXOxUKAd/o/UfWt
        ikT3RZDYiqEL/JdHT3qeJma2/Q==
X-Google-Smtp-Source: APXvYqyHejg2wpDCQ5Xb/fga24iRY4A1buPXc45rZpw01kmq5mw3Gd43YdLn2qDVw5DFt6a2GDzDmA==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr15982979wrm.249.1573820404646;
        Fri, 15 Nov 2019 04:20:04 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y16sm11276365wro.25.2019.11.15.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:20:03 -0800 (PST)
Message-ID: <5dce97f3.1c69fb81.6633c.685c@mx.google.com>
Date:   Fri, 15 Nov 2019 04:20:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.201-21-gb0074e36d782
In-Reply-To: <20191115062006.854443935@linuxfoundation.org>
References: <20191115062006.854443935@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/20] 4.4.202-stable review
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

stable-rc/linux-4.4.y boot: 80 boots: 1 failed, 75 passed with 3 offline, 1=
 conflict (v4.4.201-21-gb0074e36d782)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.201-21-gb0074e36d782/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.201-21-gb0074e36d782/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.201-21-gb0074e36d782
Git Commit: b0074e36d782e84e6a2e08910103642762949d2b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 41 unique boards, 17 SoC families, 13 builds out of 190

Boot Regressions Detected:

arm:

    exynos_defconfig:
        gcc-8:
          exynos5422-odroidxu3:
              lab-collabora: new failure (last pass: v4.4.201)

Boot Failure Detected:

arm:
    exynos_defconfig:
        gcc-8:
            exynos5422-odroidxu3: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            bcm4708-smartrg-sr400ac: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

i386:
    i386_defconfig:
        qemu_i386:
            lab-baylibre: FAIL (gcc-8)
            lab-collabora: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
