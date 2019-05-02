Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354BBC04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05696206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="twO8KFQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEBWqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:46:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34486 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:46:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id b67so7562913wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=2xX1DTWDMMg4NiNeilKXOGy/BGadjxHNrX+2mYxFkMo=;
        b=twO8KFQIFxs4OxXm2U8wzP/vEdqkIPCn6+KgrvFnGRHqArF5Ez7cSbJOPoNPCqUlvD
         VIqFnOdPHpFFvGxuZifxbGFZM+TMgQhpREFL2w4Auh6Svd9fopo8BTatFKxTVyWIdQFu
         x4pGiKgeRFi66cJGRoK6HH6BINmWFjiWS5v56bOlc1Hu0g7ixoMquMmD6K3Og2fquUKL
         zRYumOfaqslLchUfexmz4H1C6s/dTiaaNRIoVn8ZiNQARHZ+F4kYol8KlvxkiV1DwWgu
         5m+xSyb0n8ril6/GcIg8GlcL4hZnS8Xbnc8Zfrs46H8lQZnI5gMnLbX1GxmKV3n8sEEm
         8c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=2xX1DTWDMMg4NiNeilKXOGy/BGadjxHNrX+2mYxFkMo=;
        b=dWNdoilcxY8vFOMgyfgqQ8U3aCYFXvIjDQacRJDyFiE6R0qlQSoE7QT+8yLcc1ZahB
         UcyooCccDYMaDz4R89PhBOzq916F99IgaXYkZISRzM5XxO/h6kmI2IgngH7rR+s4QW90
         oDtiq1JRK8MWKK+d1GUtQZnWaLRQM9meCn/OpegWnogUPVs7GzVhMHCshpdZum089uMM
         Cm5uYZP1ptOtWvqySwvGsLATaRBtBdQFSdZDRU0wB0gu4x6dfggMOIRgQGqxllT4CyXI
         4XYmyMcQy8BTJ9i5ZDrAPY1MmtNiZO5sPifIU1u1hcBosK0l5ipzZC5e5ZmQwGgo8CpL
         XUPA==
X-Gm-Message-State: APjAAAW/uCZjkMefeKPy5fBb9bjozyDF3auE1K1oWKHiDoBQ2a73M7fx
        HyX6LU4UwFK72qatfKvq7hDoBw==
X-Google-Smtp-Source: APXvYqw+OfEEyB3xfAI37oaK29RA9mDOKTLFw5nj3JKGiort/AyaMdl7y16Gqto4M+I0KVjNmb6jKg==
X-Received: by 2002:a1c:a509:: with SMTP id o9mr4232367wme.6.1556837190231;
        Thu, 02 May 2019 15:46:30 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t27sm1017030wrb.27.2019.05.02.15.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 15:46:29 -0700 (PDT)
Message-ID: <5ccb7345.1c69fb81.f4fd8.64b5@mx.google.com>
Date:   Thu, 02 May 2019 15:46:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.38-73-gdb2d00a74567
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/72] 4.19.39-stable review
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

stable-rc/linux-4.19.y boot: 123 boots: 1 failed, 119 passed with 3 offline=
 (v4.19.38-73-gdb2d00a74567)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.38-73-gdb2d00a74567/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.38-73-gdb2d00a74567/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.38-73-gdb2d00a74567
Git Commit: db2d00a74567be6e93472fcc4bfa8ada96cc6397
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 69 unique boards, 24 SoC families, 14 builds out of 206

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
          stih410-b2120:
              lab-baylibre-seattle: new failure (last pass: v4.19.38)

Boot Failure Detected:

arm:
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
