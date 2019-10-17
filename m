Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C61FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8B721A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="fbOwqr3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437539AbfJQBmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:42:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37995 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391704AbfJQBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:42:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so709227wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=2/BQE6F3y5aL1teTaZDy6buval4vv3GU9ONSJI6xLxU=;
        b=fbOwqr3f1yonOH0EUAEULr/cF8ezgOzn2jzCFjy4f/1dnYN3YPGJ0h4MznGJUcqkXI
         eQ9LR/fOaQ9P2OIhHYgBc9bohUXOp03hGTevE8Nsb4xTg1eAZPk/emaMjE9lJDDqtmfr
         MuGbQPzjdzBcFIwGZKKhugymzu0tyOtP6FE7nVg56JV4YtqjJ/5XjYFPC5PPA8vTkBUq
         Yg8Szh+OLHCrSSeK1mKgPlRtPzRF/WhkhG6cxZjJLr2Ic6PI1G6sMU3V+s4qk2N5WGjZ
         QDXSp+Uo4PQlHK0L/tqwwn+fgNRpUSktDho+PSHTMInJctudfZui4v6vF2C3bTKJnfe2
         3qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=2/BQE6F3y5aL1teTaZDy6buval4vv3GU9ONSJI6xLxU=;
        b=qSwuLom5t2AgoU6rSRpuG+lu0xSclPaZYXyBA9i/Q2rqS2GYtqeATLbuwpyhmrRPtb
         ipEkJneBSUrhuzAq5HeYbCRSS8epzwMILchp0l1krgZLC1Y+uvBt5ndaPnGp35oSmHyl
         EQcaC+wzKH7KC6PjYuArEyLj5wsZM4DQNKbkooVLm/Q89OETx/CF+zYH6FmdJoO7FTYY
         C0jPnUm9iS+7BtI7NIXPnBcaQUDIFlgKnDDB4IyWb2jhh3pwrotqcjZfHZ7hX0ES1cH6
         Tu/2W1TDn2Nyyvcr/GMolSPwWI92ziuPNCF3rB6dUlatHNlrz/XfUUqr5IaFUz/HvhJe
         xL3g==
X-Gm-Message-State: APjAAAX8pbboG6pE2anzEbBgz9bKXTaxsOMXyNPTCZ8uoWRXKqBmLFrT
        etH4lpfnmlGoBwWfYWO+YjStgIPQ1Ws=
X-Google-Smtp-Source: APXvYqyeK3Q8YOSiK/Dd4vFWZkX9WpxTOHBZZQ3hhBCsHHGgkJNZamlZGeW8O7+ksYCrhLcXPI592w==
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr505817wml.95.1571276530678;
        Wed, 16 Oct 2019 18:42:10 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o18sm726884wrm.11.2019.10.16.18.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 18:42:10 -0700 (PDT)
Message-ID: <5da7c6f2.1c69fb81.51d2b.325e@mx.google.com>
Date:   Wed, 16 Oct 2019 18:42:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.196-80-g645def690295
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/79] 4.4.197-stable review
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

stable-rc/linux-4.4.y boot: 80 boots: 2 failed, 72 passed with 6 offline (v=
4.4.196-80-g645def690295)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.196-80-g645def690295/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.196-80-g645def690295/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.196-80-g645def690295
Git Commit: 645def69029558d1f5833e6b95e81180671da907
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 42 unique boards, 17 SoC families, 13 builds out of 190

Boot Failures Detected:

x86_64:
    x86_64_defconfig:
        gcc-8:
            qemu_x86_64: 1 failed lab

i386:
    i386_defconfig:
        gcc-8:
            qemu_i386: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
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
