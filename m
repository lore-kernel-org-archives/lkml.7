Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94181C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A932081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="yCeZj362"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfEBXGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 19:06:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33033 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfEBXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 19:06:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id b188so4473295wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=0E50fivlvhtJbA/C1wWaK+JHqMSweUK9UeAr3comb18=;
        b=yCeZj3621KuN4oceXlPvAU0hpwT3SAzPwE/LsTRc8wgpNDpP17Iq/2bg9HxaUk5tub
         JIMm5qFTFG8yy5eVKtF3BQq1cGQq4V2McQI6K+6wHqFE5UMp1P/ZC1cRI2NLQSCe+myc
         FTm0ui66nwopkjz+vxP30XLAfbgB2pJUk05dUidId4vVxV6vm9nzgLOdoDRetgby2Tyz
         OVxx5ASBK/xcfD9o+DKwtyP6bHibnHJsQTnvrXUqNAre1muUdJmz5NqchN4NX2hEUEsp
         Ht0Lj76lvSfi5EA0jAQ6RFUFp0ME37reQwPz2iCVRbtKL12GFjPR697RWf3uMDxGzsZy
         HAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=0E50fivlvhtJbA/C1wWaK+JHqMSweUK9UeAr3comb18=;
        b=fLx1relZbDXvbuUV8551Nrd76CJ9oU+pfUTpKjjPz/zRY7hmS7T+RHIsE8JZ8Bh82A
         iUbcG5j7J0mHIjPT6UJ1MfYD8CMxtHlM40QvBRg1dQorC1zclbpNTaBvv+gNb0D911Sk
         OFO7uRDlIa6meF+jRbtbyy0eBTEoiiksfivDLwSVbL8D3bzNN4WtOXKLT4w0lo22IOCy
         ZS6E0LzlBQKW+ubY6PPthtbu0PQyJdFcaR5jAJMSlNn9PlZLgTfgFLqi8xjP4mCmEsp5
         l+H2KxDy/ivD+FI85XUt8706GOB6LQl/B+EzBErywcGczycsPyD4ErmjyifQtc7+L9rD
         tLeg==
X-Gm-Message-State: APjAAAWESub3nImRlWn9AXuSgtdKwknKcmBnmIXDGJIbRQyXioOsaTJg
        Beoq7PjOkR79/LgLtGrZ3V3gPw==
X-Google-Smtp-Source: APXvYqx/LYGheLToLCWG1PrctCZkgw0sgdA0aFsSXmkQUQpa9E4GkeLsY67rMgbfN0lOKS2XwOf6ww==
X-Received: by 2002:a1c:7005:: with SMTP id l5mr4068452wmc.149.1556838389957;
        Thu, 02 May 2019 16:06:29 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s17sm906627wra.94.2019.05.02.16.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 16:06:29 -0700 (PDT)
Message-ID: <5ccb77f5.1c69fb81.aa068.57b6@mx.google.com>
Date:   Thu, 02 May 2019 16:06:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.172-33-gd35bcd092304
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190502143314.649935114@linuxfoundation.org>
References: <20190502143314.649935114@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/32] 4.9.173-stable review
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

stable-rc/linux-4.9.y boot: 104 boots: 2 failed, 99 passed with 3 offline (=
v4.9.172-33-gd35bcd092304)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.172-33-gd35bcd092304/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.172-33-gd35bcd092304/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.172-33-gd35bcd092304
Git Commit: d35bcd0923041bd98c18947041f8929b2fb12674
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 51 unique boards, 22 SoC families, 15 builds out of 197

Boot Regressions Detected:

arm:

    exynos_defconfig:
        gcc-7:
          exynos5250-snow:
              lab-collabora: new failure (last pass: v4.9.172)

    multi_v7_defconfig:
        gcc-7:
          stih410-b2120:
              lab-baylibre-seattle: new failure (last pass: v4.9.172)

Boot Failures Detected:

arm:
    exynos_defconfig:
        gcc-7:
            exynos5250-snow: 1 failed lab

    multi_v7_defconfig:
        gcc-7:
            stih410-b2120: 1 failed lab

Offline Platforms:

arm:

    davinci_all_defconfig:
        gcc-7
            dm365evm,legacy: 1 offline lab

    exynos_defconfig:
        gcc-7
            exynos5800-peach-pi: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            exynos5800-peach-pi: 1 offline lab

---
For more info write to <info@kernelci.org>
