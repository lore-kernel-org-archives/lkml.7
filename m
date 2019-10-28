Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999D1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 05:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEBD20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 05:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="k7uSJzTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfJ1Ffm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 01:35:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41350 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfJ1Ffm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 01:35:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id p4so8437972wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 22:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=rzLHlZoYGoBkmiTzE56K1uPGO2KAEAPsBpdpBbsSlK0=;
        b=k7uSJzTxc/eFANwBB6RFA7WU3ofFDux0ezlXbM3gNn6tqWV2bAgse88Es78oy+Jpzr
         bi2+CTpna86Cvf72iFnTTgBSlgJgdPCdjbp31zyBLLQtsaRtU6kdIHHPZYf8r4OZVo4D
         TmesDNmvFnZd/dkkoVd1c5tHufw2ttD3qEjSuobUKZJjneiOv91n7DDL74JOzEJ3+yNa
         2BtzEEpPeKFg4X8SU6Vma7vyFgYKHzwxHL5d5qETrMfwdEmGsIJrc9VIg0esYeBa8QRC
         s0J6FSPVOr/IXCAxNmsNd2+tq3B7VKC9OntuOab/qC8ngrAXDNq1a2CvgZW6rDfQCVE4
         S25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=rzLHlZoYGoBkmiTzE56K1uPGO2KAEAPsBpdpBbsSlK0=;
        b=a0Ytkd+p41g/ieV/j1DUeYuQFrZ4tL5+iOXzHg9iRO/kssi99a8qtx4xgFeo9gToDa
         tIL3PjIcN2ToytuAqcm0+o+oda8Cet98M59JKijSc474YuaOCnRD+XL9R9xcX2JiNnDG
         NN8ODeMCS9ieCZun4dZNxTJw62o3/JuikLesR0xy5sZa093i3/4XHCQFpGr54tpcA8kl
         OByIpF1GyfeYpdo5/+v4Fz6rXZ8IwAqp1SWqqA+zQ28CwfZ2JifbEw0cZEGwgwZtryK9
         Ai3c8vIkT2VIL704rVUcimAOzJxY34qrF/wjzHPDX64vN1hPhEpBI718FVtlW2/kob6j
         7KAQ==
X-Gm-Message-State: APjAAAV4ShLKx9691yBeUkQ6LG8uxrl+BXoVBZl1s8lrTRrUhcck+DnQ
        f3GHsCy1MUEh7LwJ9rmkBZ31pyggrC4=
X-Google-Smtp-Source: APXvYqx6e96bMK9fU8+KQ4p5EcH/neqzo4PNjwx2fgPv8Ag5C8Wcqr7bKKXgWkqG3CoH5R/QSjNu4w==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr12083251wro.299.1572240940074;
        Sun, 27 Oct 2019 22:35:40 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a13sm10497802wrf.73.2019.10.27.22.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 22:35:39 -0700 (PDT)
Message-ID: <5db67e2b.1c69fb81.8738d.45b0@mx.google.com>
Date:   Sun, 27 Oct 2019 22:35:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.9.197-50-g55a89a78f76e
X-Kernelci-Report-Type: boot
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
References: <20191027203119.468466356@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/49] 4.9.198-stable review
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

stable-rc/linux-4.9.y boot: 101 boots: 0 failed, 94 passed with 7 offline (=
v4.9.197-50-g55a89a78f76e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.197-50-g55a89a78f76e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.197-50-g55a89a78f76e/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.197-50-g55a89a78f76e
Git Commit: 55a89a78f76e92ca9b2045c8dac71ff64e0eb03d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 50 unique boards, 19 SoC families, 14 builds out of 197

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

---
For more info write to <info@kernelci.org>
