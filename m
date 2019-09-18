Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0B5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818D22067B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="VJ3XXKhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfIRNTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:19:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37247 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfIRNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:19:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so6900179wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=8yWSaq1SPkhAnGKUElxNjUPCl80FK7UQ5LA6iTbaJZo=;
        b=VJ3XXKhY5Aw2z+D4yk/YHnjv1QX4QXrcPX5ZYFOW3nKaK5h3r5Ve95yzGQFnxSiEhA
         xR09LirpYG7hNKi7xVD5XHbDQM0NLh1r+Ej33ncGU0Q6vCsywkbKQAneSMjqMn64DU+3
         T+y0+r+Q5EPLArptumYr90CfWPqwWxTdHGVY56RsTNVr/eVSvdUCDW+JiW8LBZNk3L79
         UU0+ak/HU9r+O5r/o+vharVGWAZvglZXr0yg+2hNN/h4rKvuTVIy3yrfIE2Z8eT3r36i
         XwY/HDom/W0q1aesJjGtvR8vLgDbb5TqQxONcx9k+SbtOAKc9il03VA2gk9wef/dWSPM
         GSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=8yWSaq1SPkhAnGKUElxNjUPCl80FK7UQ5LA6iTbaJZo=;
        b=fSZkJMOC5S+PbfR/4DyUM2nHVg3+C2nIE4vku1OF5q0wpCQ5C5IzGMPgpBuwcICKNR
         G4dIozHpdrI/ijMEJL7y39N7dzTPWAzeXnfPBa+AbXaScXJj6qr8MhYEegV2zh/tYyrO
         UXQlsz6mS/jQIPInByFTK/XyHwb+93bTxP2MZRx7sJrztT8zezeOE2H/5v9DkQmv18Tp
         cA0laYoohhjD2GwzHC1roZ2dQjkRa/uagQ9V+UFXc6ZomGMVwyP2G4HWmjNF5dUNk44i
         Ngh+x3DsHGNiRdx8HMkjR58PPqo1yh+BJUb6Kpuo1hIjP7tCE6xttigfPlbF634qt2Ca
         mJ4A==
X-Gm-Message-State: APjAAAW0G92fk43M4+dEgr12XCbPbG+qBdU/Njw9L/Udt94hTbR2HOr0
        c14lKcKUZ8q9EldqSGbfbI85fg==
X-Google-Smtp-Source: APXvYqzJjheHXn4H9Pi/aVsdA/2XvIBwrDIHXOMM/+4tXFXAPcqqhMQelVjfgXCH5omPtGuWxmHKRw==
X-Received: by 2002:adf:a350:: with SMTP id d16mr2970112wrb.326.1568812772484;
        Wed, 18 Sep 2019 06:19:32 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y72sm3124512wmc.26.2019.09.18.06.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 06:19:31 -0700 (PDT)
Message-ID: <5d822ee3.1c69fb81.464de.db03@mx.google.com>
Date:   Wed, 18 Sep 2019 06:19:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.144-46-g187d767985cf
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/45] 4.14.145-stable review
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

stable-rc/linux-4.14.y boot: 131 boots: 0 failed, 121 passed with 10 offlin=
e (v4.14.144-46-g187d767985cf)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.144-46-g187d767985cf/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.144-46-g187d767985cf/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.144-46-g187d767985cf
Git Commit: 187d767985cf878208592ce3ca667e5021abf2f6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 66 unique boards, 23 SoC families, 13 builds out of 201

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

arm:

    multi_v7_defconfig:
        gcc-8
            exynos5800-peach-pi: 1 offline lab
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
