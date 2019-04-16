Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FEEC10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED14A2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="HGmhxTuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfDPAZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:25:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40281 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfDPAZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:25:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so22842017wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=yLRFYCPOAY6AH9/2pEnj0Urnaxdt25ksLC3P/L807p8=;
        b=HGmhxTuKtMqASENv9TeMvX7re7p3+c8H72B2pnVdoTzuNrtCn/F+r8v6OFbmn/gpLG
         3YAo3kttq3vETtpp685sqvrExiZyokyo9OnUK6vJ0SzDAzNLz76Q55/L9vAwYtf59Muc
         keGe4WBXd+aJ6V8m8p4Hu/ZN97MjI2C3q8/ptjGLNhcjKEJ8USOZL/3NEAdaF2qd6RWL
         dUm1NY5AgyOZA6Na3d+H7pj8fgDXnBlzRlu0blFnVcLphdqc2WVZa1Tx/SbN8XJYq7Xn
         ZmEh0hEJyBh1o+l7/5L8BNXWKfaMJkPx4Lmhwl+UPZOF+Ai2HE4n4axeFZ8/u8vRL37s
         Qm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=yLRFYCPOAY6AH9/2pEnj0Urnaxdt25ksLC3P/L807p8=;
        b=D1mr7KCxQMgoCJGv3sdIZFmm7NYeHS12UVMJGtGYRAKcdmzfWdfXg5PxDxHTAkguul
         BdrUCxKgN9BHjQfQzbejnqVdjVtiLn79xCbj2sX+JxUU7nuHtz53ejAau9c5Ym41aaZY
         UJ+Nusin8d5js/siPFjYHuUe1TgeVlQKNLVUC5qcPF9pHu3t4nD9NLKYHK10VzhdBjyb
         EsyoMTJUOG7TQRQSFjljdWASqgH51UwIHZRQAot2yXR0+oblo0RD9t35F2l8Wnf3ihvt
         RMPYVROvvxU0oShjmXycNGuuo2s2UonkZipbHIXLiOmirNGpW62h0M3mA12IE5Na5834
         haqA==
X-Gm-Message-State: APjAAAVM7kBlnx2bBJiyHcLNVTsinwhyJxj6yAfrigYHIu1OBCrg7HvN
        K6Y6SNNvqiiaZQzr7Dxxr+bKwA==
X-Google-Smtp-Source: APXvYqzY7Xg52ze2bjpsnLYFStnkk88sQCq5BvBlPbJCvPbl3EuctEVowUEey1ZyWNtAi3Y4wzewRA==
X-Received: by 2002:a1c:cb0f:: with SMTP id b15mr23085486wmg.88.1555374298084;
        Mon, 15 Apr 2019 17:24:58 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d16sm42449295wrs.68.2019.04.15.17.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 17:24:57 -0700 (PDT)
Message-ID: <5cb520d9.1c69fb81.34de0.8323@mx.google.com>
Date:   Mon, 15 Apr 2019 17:24:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.34-102-ge4f859c2cd83
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/101] 4.19.35-stable review
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

stable-rc/linux-4.19.y boot: 110 boots: 1 failed, 102 passed with 7 offline=
 (v4.19.34-102-ge4f859c2cd83)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.34-102-ge4f859c2cd83/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.34-102-ge4f859c2cd83/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.34-102-ge4f859c2cd83
Git Commit: e4f859c2cd83c05fc968871175b2a2ed5e43eb49
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 65 unique boards, 24 SoC families, 14 builds out of 206

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-7:
          apq8016-sbc:
              lab-mhart: new failure (last pass: v4.19.34)

Boot Failure Detected:

arm64:

    defconfig:
        gcc-7:
            apq8016-sbc: 1 failed lab

Offline Platforms:

arm:

    qcom_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab

---
For more info write to <info@kernelci.org>
