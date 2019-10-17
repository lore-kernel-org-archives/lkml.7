Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CCFA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32397218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="q9ScnrdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436884AbfJQBmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:42:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37148 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394939AbfJQBmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:42:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so378411wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=UUOQhFwr8XzMVrTp5WYR+uVp2yT904FvoCVCdJDFvGM=;
        b=q9ScnrdZlFUWYcFWzPZoBxjo9JOX74Rhx33HhrvZ/OwIE3eQbMhlugH3HLY9OVmlyW
         6nMdbcyyofKs2L7ZZBDFPWgaUPl7eTLWHOmnB8ibCNva+r5tbrGEDqF59X0Pj9HltiXZ
         qZt5I/DokGqRY0T1PfmKFHKz7W+EOUk5vDiLHq5EpGY7946GFq73KeWPjJdL58H73f0J
         H6xXvDHbWDJJ9bdturyE4ty13iTX43g+tfF6H/nj4a+a5m2/KvR29zPc6VdSKLHZWPvM
         YdP9DRTtG4cjOQEmOu0QROdqMcFnROaEADzAtvz12o2mJo2kZwpwAFF1dNfA5e7DrzYx
         qcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=UUOQhFwr8XzMVrTp5WYR+uVp2yT904FvoCVCdJDFvGM=;
        b=PP032qxisjbXBq5FsQYEdm/tDmtUcfxUEMBegsqK1FpQUgDKfLJeHo2jfLXoxnr+Uw
         XGXzXskbudkzVv1a2J8CzAE1ZxI/ZRTMQ3GK3m5cX3+LyyYbh38xdogm7UPyrF91uYU4
         sVRTfMUJ0MpLAVWWivvvbRHHD9Y9aZCevwjOSZ07RZbTQo3OtkPgLfpiAHZvprrR8Xdp
         yH1P2+8qk3UizaWjj4yKGhAfJsan/jNBMbsJN1VBRPPOnNLi5sjmh6C2vG+UsBnBkqnf
         Ju67NKQHp3JQZqo/0zbFowTUGxbzYIvNWWPdbMKKMAWpad9tg1cjNTxyp4RPlu7tqqEu
         uosw==
X-Gm-Message-State: APjAAAXWxah9U5tD/h33w9a8D0bBwOOzz1UsNTmBAga470O3Klt+3mAG
        GmJBd8skE/IoEEoRjlUFzJ88vA==
X-Google-Smtp-Source: APXvYqz8wqjoxKq8JxhHgEq2LneKmf05grXk0v8wuaqMUqcnh8CDVJ0vHFB/GImEEBAHBJRHk5C/1A==
X-Received: by 2002:a5d:4691:: with SMTP id u17mr625679wrq.41.1571276531817;
        Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id q22sm650554wmj.5.2019.10.16.18.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
Message-ID: <5da7c6f3.1c69fb81.ba999.2ff8@mx.google.com>
Date:   Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.149-65-gb29fcefccab6
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/65] 4.14.150-stable review
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

stable-rc/linux-4.14.y boot: 104 boots: 1 failed, 97 passed with 6 offline =
(v4.14.149-65-gb29fcefccab6)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.149-65-gb29fcefccab6/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.149-65-gb29fcefccab6/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.149-65-gb29fcefccab6
Git Commit: b29fcefccab67589bcd5b49b74967d723e708013
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 60 unique boards, 21 SoC families, 13 builds out of 201

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxbb-p200: 1 failed lab

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
