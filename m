Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE4BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB582084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="QTPkIcZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfEOPHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:07:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33915 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfEOPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:07:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so3116065wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=5lBv90kLsk53rZLDfAQHyn3ShZ1PpcnXQ3v0oMND3b0=;
        b=QTPkIcZ1z+8hoWEGAvyi9ND+W029BwubEVAis8pFEFn/ZSSxREdce/6P4bfBYBuzqy
         F5dJUCxS6a3W3BxeP4dw3AFf97di/qfPhZyMtNP9Ns+ui/K850CwpkJZt75dzxyohaEN
         4O3E2Z7/EHDpxyhlAC/LxP2iVoK4Bl7qAKA0TZEg5aVACQ74uxOB0c8Drh7rR7C2Ypbz
         T22AZ1XZ3pzZjw7NNmfAAOcry2i1rhkHBRqvGML2Z1MrdIvfNPFWmNZBxruBAm6wZNqB
         PKm7GNgA0qmKC5AsgUS6JrOOiU7Nl1GCbuQ5m2M3yUPHZeYdR6Bg/pGtlPoKjdYsx4GM
         qmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=5lBv90kLsk53rZLDfAQHyn3ShZ1PpcnXQ3v0oMND3b0=;
        b=An9RqdbxayyBvigPMtHHMU/Cv4ZJHUdtoFXVXLv5rEqAtBHz7znuzXJwyFCC0Z3NpG
         bkAo/7/wwvBPpKSUlFbkS7sTcy/tcTaFdvXmlQ/7kiU5PrRVhVj2bhySnpB+J1w+9wX5
         28ldu+nm+QfrDvx65A9ZQSTXxTaVs/iLA6ADdnQlEwu7kJPT0/FC5WCj4qek9jNf2Kss
         lw0LE0XMS+DCo81XbPf4vn4h6XUWCnX5Mgswdi1ucDbr6Jntu8k59rATBids8v3zhzaR
         e8kKZH8/tCakLj5R6GnwYk8MTIimWM2DwmbgWymkH/CPgKH8CwItdE5V8AzvouttRHDe
         RGNA==
X-Gm-Message-State: APjAAAXNhu4pOqN3hx3533iDAfPw4xLC/FVo4hH6bbS0GIQ/t1+QlgH8
        By0k20UCnaNRzczeUWE5GsIotQ==
X-Google-Smtp-Source: APXvYqx3nCrB4dzwOMjfhWbaLWjKZs9iaYWj9RGWDJADeqLcmifDM9sScPiPNkZ/yYo8vdecbQA9qA==
X-Received: by 2002:adf:a202:: with SMTP id p2mr26373584wra.166.1557932866001;
        Wed, 15 May 2019 08:07:46 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g6sm3015951wro.29.2019.05.15.08.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 08:07:45 -0700 (PDT)
Message-ID: <5cdc2b41.1c69fb81.5fa5b.1734@mx.google.com>
Date:   Wed, 15 May 2019 08:07:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.139-87-g06310902672a
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/86] 3.18.140-stable review
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

stable-rc/linux-3.18.y boot: 59 boots: 5 failed, 51 passed with 2 offline, =
1 conflict (v3.18.139-87-g06310902672a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.139-87-g06310902672a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.139-87-g06310902672a/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.139-87-g06310902672a
Git Commit: 06310902672a635a9042eb91b9f696da27d731eb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 24 unique boards, 12 SoC families, 13 builds out of 189

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: new failure (last pass: v3.18.139-76-gd3d7f4845=
dc0)

Boot Failures Detected:

x86_64:
    x86_64_defconfig:
        gcc-8:
            minnowboard-turbot-E3826: 1 failed lab
            qemu: 4 failed labs

Offline Platforms:

arm:

    tegra_defconfig:
        gcc-8
            tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            tegra20-iris-512: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
