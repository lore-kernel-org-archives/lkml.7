Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1325EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC458206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="JDVGL6bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfIMQ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:59:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50989 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfIMQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:59:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so3521575wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=lzFpEdzJTfJtDcINELB3kb/7PITZ5S/QwoQ5BQ4qJo0=;
        b=JDVGL6bl9tE0gy0gxg/Fx9Hg897528k08RlbZF63141rVcTW9y6J5+rz4+z48fGqK+
         kp6UyAWdMd2yoMwr0pa+9WAqnQurbf1txouVLclE9Oot0xkig2yE2RcbMwCZW60l9Pxs
         ErwHtGRm9HU+ENaEyCjYR2JXhVXLQeEqS1/t+gTzd99KQCMKZ+A7FqjtdOgpAhTsidQs
         A+hCDZmP8u04pPzh01a9UIf5zC6S5Is/v1Krqp4tIe0q91JKWa7LAMA3fgH07fiOfQjT
         X0T/Gdp8DGE4UZrRjsWQUd38UhNAmhALYfzjC899SW8oqk/DoyOtbhoyawh5TRqJn7js
         oXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=lzFpEdzJTfJtDcINELB3kb/7PITZ5S/QwoQ5BQ4qJo0=;
        b=ep6bbmB8bCk+zb/Hyv1pfIzilEsIN8GYI+wQ6ItHTQCVEI1cZlU+s4To3k8G/vuGQq
         lWVtWZH5MgCG8w4Ix6XjywK8FYUyZuyhBlngf9VNMXYcKD+CpW0B1RjGoGXdIU6YYnv2
         KeudnTywMDi8DqRhEd/Ac8JYZkrCEcsGajlDGKENzPtlnTeoegYim/9eiRx89+QQCIjB
         MiolI2WF/qG+w9Hf/1jdcoX2ox12NdJP66j82CCM0ZWmRd9+dAXJPRbAyRsJQ8y2jeyk
         EwyPhkqPj/fxxdP49jOPE15ktYfobYAllS2CSf7JA3RslgM9bgvWHTffKGg9LPkwudiT
         2lxA==
X-Gm-Message-State: APjAAAXwtoUye+PMX0ZO1w1d8gxmEg9RHJ0YxmDOd2tqIXT19jlCN7rc
        5lYxB+bZJD6i3nSnpeivsKObEQ==
X-Google-Smtp-Source: APXvYqwX9u1LBn7QaY7u1MssmhdIDa2JkX91FzjJFdYwZwO2K2l0HmELoBRQh4Cs7kWH5yE9tmAOsg==
X-Received: by 2002:a1c:7d03:: with SMTP id y3mr4117931wmc.71.1568393944275;
        Fri, 13 Sep 2019 09:59:04 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f24sm2641376wmb.16.2019.09.13.09.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 09:59:03 -0700 (PDT)
Message-ID: <5d7bcad7.1c69fb81.db13a.c7b2@mx.google.com>
Date:   Fri, 13 Sep 2019 09:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.192-9-g160225f8cfe2
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190913130424.160808669@linuxfoundation.org>
References: <20190913130424.160808669@linuxfoundation.org>
Subject: Re: [PATCH 4.4 0/9] 4.4.193-stable review
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

stable-rc/linux-4.4.y boot: 102 boots: 1 failed, 92 passed with 9 offline (=
v4.4.192-9-g160225f8cfe2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.192-9-g160225f8cfe2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.192-9-g160225f8cfe2/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.192-9-g160225f8cfe2
Git Commit: 160225f8cfe282fb0b3ce73c781139b521b4b979
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 46 unique boards, 18 SoC families, 13 builds out of 190

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            qcom-qdf2400: 1 failed lab

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

---
For more info write to <info@kernelci.org>
