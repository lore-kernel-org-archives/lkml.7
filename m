Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10EAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C9E214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ePF0aeJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfJJOll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:41:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40025 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfJJOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:41:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so7064960wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=WvpcapkJx8ulBJzj4PJvqG7ZVPifCPQ0JR/mWjZ/O3U=;
        b=ePF0aeJ8i2wRFfX68Bj0lleBItCXI1E7kyXzLaREUNWaIje2xgTAtyy87DEbAU0FXo
         69a121/5zq6kSsNsdfzzntJ6LaR8QbkFaS38rzT/FTwm0uGa6RDvxd0qHy7SKrrbdJsH
         Vx/OTSShDI2hzUPiRMm1NC9tX1qyfBZrmKYHVb7NJ8h2/LTwawjqGXHGHtnut519aL8Y
         ncqH3+7vJOA6d13IFQ2cM9z1sUH3LAIQ7POp8BNzXIzExw6PMp3fTABJGLtu8hfcXBzF
         2jqv0LSny1yWgiuEbke38H2z+7d26tAxTFdZ95V+Q7vLpOs8WiOFzlhP+hIKGm5na6EK
         6oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=WvpcapkJx8ulBJzj4PJvqG7ZVPifCPQ0JR/mWjZ/O3U=;
        b=No8pu4y08oBmvqc0SOcW8qJNmf7QkMfKFGS5yqA+CF1ubg8q6Pk6dfa1jybeXqagw8
         RYhHc7vCOZSIgq6cq5tXb6cmWzLP6CMumYKP0dRLF62kPXC5KkDH4lhWZQWhM0B7cGRv
         UGE/M6um9CBB7j9FE4gMHegU8Nw6DLQKNvYMqJpisIaLYMQmrvrWIIZ2frR/OFy/4HaM
         U0swOislLgoR/P67xGAYaEuR4uMSn2oOznY9spovd45XyoTPeiNNr1wQfyjX0YrcjcK8
         2qbLrAuhCx2jHfeIupixZZMcAzYmPbEAIyH23LdwqhzxrnuL85IyznSsBqfcVh+AIjcG
         G1Ag==
X-Gm-Message-State: APjAAAWNObAML4LyQeFm5R+d2m+xFTcHaQc5pjkuzhfh2yzAnT5lDqlx
        n8n5V9DM6IT73/txMfLbjhgTzA==
X-Google-Smtp-Source: APXvYqzUIiSDxzC9sMSlK0uERGT2OaXsOObyUMqZGbyT1xJTSaDjErh3SKgv1hWBPGWSzzFO4YeXig==
X-Received: by 2002:a7b:c4cf:: with SMTP id g15mr7453778wmk.122.1570718497368;
        Thu, 10 Oct 2019 07:41:37 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y18sm11027830wro.36.2019.10.10.07.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 07:41:36 -0700 (PDT)
Message-ID: <5d9f4320.1c69fb81.dd898.69fb@mx.google.com>
Date:   Thu, 10 Oct 2019 07:41:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.78-115-g4d84b0bb68d4
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/114] 4.19.79-stable review
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

stable-rc/linux-4.19.y boot: 117 boots: 0 failed, 107 passed with 10 offlin=
e (v4.19.78-115-g4d84b0bb68d4)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.78-115-g4d84b0bb68d4/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.78-115-g4d84b0bb68d4/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.78-115-g4d84b0bb68d4
Git Commit: 4d84b0bb68d49edd179af2b16d4b912c1568a182
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 70 unique boards, 22 SoC families, 16 builds out of 206

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

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
