Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDAEC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58FC20644
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="s5P+1l62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfIRMAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:00:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIRMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:00:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so6586806wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=l5SPa7LkaGBpWjiTffXKsIaeS0FMurpSoHV4KYencAA=;
        b=s5P+1l62L0ys2bfaVEO78JSjHjn1KL7PCA5FdIuBo3EEdXsSp7DfW0Mp+jInDwiMDp
         5FsHbD2NHrYRLiOhCc4WQTBi4WWCXLwT2pAzKD3RC51S/5Wgiqs1lg3a8Y8vK1hcreEu
         rzK+piSb7qwz7YI823J/qUdV51dklew2aMu2Od8EfQvvk/25/xttDtM1qVhxmyc4P4cv
         GdD0cnHzhKh32Ql6Lb1MkYX8dSqvS7qF6wkk+61qKaHcrLix9nPKwKSuC7f0muICvGNJ
         3P9qh+xjCRvFNgwyu7OUGbxxbwiJLuVwN64ekVBy/KpJfXk3cpzMISC2El+ZH6bkq5sN
         3ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=l5SPa7LkaGBpWjiTffXKsIaeS0FMurpSoHV4KYencAA=;
        b=ow2aWxS97FKW77avbVjeNBZM+BNNs58MVgYpXl7aUi8XgbN8qGCP1f5iypuNiRtACD
         HJ9vzHnVMmuTCWaB2Q9L26sNebrOoB1L7zkc6L7OHxRatJjI7mj5TXe5UApIBeLcSkB6
         wds4SvgniA5461pgLWxRCSJvpc1u2HfJsmrjz6QapJIPD/394Y/MKmHcF8Stf/Zw/KK+
         +g7gP2bKgQoGuo1FRMdKW6Eq+Ib6QdrUAz69viSsu97YI8Vn6SUhE0nmUew9qmOvhRrt
         jQ8H5/PCeByMDalqzma3RSZI9xm0SvGhSLlnE/zLGxIqSV2E5rqTKaKGJWDocBI+XmJt
         /81Q==
X-Gm-Message-State: APjAAAXALP9yAeesbxGxoe1QwEGvK6PdRq1XuovaS+XKvXLUrwqi4PrZ
        JAMB1Npnqdr6F+MhxRx0HFmNTw==
X-Google-Smtp-Source: APXvYqzVBKhWPgXWTx96fiSNX60cpUxdc8vWrPZc2mMMLTGyybAXyEFjGbayKqCxL9pUyq5Vp1kMnw==
X-Received: by 2002:adf:e350:: with SMTP id n16mr2523271wrj.99.1568808000366;
        Wed, 18 Sep 2019 05:00:00 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id q19sm10123609wra.89.2019.09.18.04.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 04:59:59 -0700 (PDT)
Message-ID: <5d821c3f.1c69fb81.31796.e5fd@mx.google.com>
Date:   Wed, 18 Sep 2019 04:59:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.73-51-gddb7a3337506
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
References: <20190918061223.116178343@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/50] 4.19.74-stable review
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

stable-rc/linux-4.19.y boot: 133 boots: 0 failed, 124 passed with 9 offline=
 (v4.19.73-51-gddb7a3337506)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.73-51-gddb7a3337506/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.73-51-gddb7a3337506/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.73-51-gddb7a3337506
Git Commit: ddb7a3337506cd5de6d52906c5291fcd90b955d2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 72 unique boards, 24 SoC families, 14 builds out of 206

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
