Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7250C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901C22075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="egBMB9rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfCZMDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:03:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36317 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731435AbfCZMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:03:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so14046697wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ieT1G8e1H0sAJvPT0a91cFfjHNOjq4XXFJK6kjAcqew=;
        b=egBMB9rWaRpUIiB2Uv1Pu937O2SKmI3th7MksI8D4Z1NrvpF7uJsSkUFZlURMCEnWz
         N3/P4hR8Jfv3BuaMYcU0MI2PPWlmXKoOMxHi8KxRaUxVgTWX7jO8kfWTPouPKxlOhFRU
         bzzHTjBx8uTRLwFoDL9qU/QBI2PuinqiA+/DSPAIHSddSY23FiM6mcpmZUr/zMVgnSmJ
         kAGZVSuawW5Cr329VlRGIxkKur0ZggktkMuBnyKCBrblIJGohXdyCUgswnQOc30/JJh+
         69XREfpgUmE+HnGMd/1FHbmR0k7ixsyYQ9jlRa1nlacwPapuSDZ9psjyPZ+81YqfH7XF
         Nx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ieT1G8e1H0sAJvPT0a91cFfjHNOjq4XXFJK6kjAcqew=;
        b=mQmYBHuZXMzrZBqorgazsoCxDRnttQ1xIvJdDD/hsiGk5vm22UmdF1zhDShYKeGbe4
         cBstDZAnouOFrkSDAM+f0ozrutMUy+nyts0cZBz6JDyAx4m4gDQ0VBbCMEWKDmewRIge
         CJuPBl6G0bsIvRplgLiMNsBZp0ZYc7Q5EWcQDvYjT0zWT9+gHmwe/t0om4oEPhu75SYL
         /+mCBn7YaOobu915D03BGBm6DtetkJojjgrEOCItHoViAplPdvzrwmPL1nZiImD5kzyI
         P1h0BIhDqvR2Tr9bq6pM/synyZ9vQeg7PXO0ctP1a4+CUOzOT5G+jB5iENPEIijrUrP7
         7IrA==
X-Gm-Message-State: APjAAAXQnZwgmjsBDb6iVmCOAL46gSdkPeCyHs17vSoQ35/3BcAPDVma
        jzZcYDHtlUaf4yqJcqZj46Kl1dBxXSvahA==
X-Google-Smtp-Source: APXvYqwN0aepGvz7jNcNZ6EHASrQGkNjbmToaq7/pPZoWYNVPwFeg94CcncnGbDOKwIb/kFNM/06Pw==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr18744967wrj.75.1553601792483;
        Tue, 26 Mar 2019 05:03:12 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h2sm35353537wro.11.2019.03.26.05.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 05:03:11 -0700 (PDT)
Message-ID: <5c9a14ff.1c69fb81.82d17.a43b@mx.google.com>
Date:   Tue, 26 Mar 2019 05:03:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.165-31-gb7e63ff5d9f9
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/30] 4.9.166-stable review
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

stable-rc/linux-4.9.y boot: 98 boots: 0 failed, 86 passed with 12 offline (=
v4.9.165-31-gb7e63ff5d9f9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.165-31-gb7e63ff5d9f9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.165-31-gb7e63ff5d9f9/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.165-31-gb7e63ff5d9f9
Git Commit: b7e63ff5d9f9f1ae13c633d2b98e6b180398ff5f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 50 unique boards, 22 SoC families, 15 builds out of 197

Offline Platforms:

arm:

    bcm2835_defconfig:
        gcc-7
            bcm2835-rpi-b: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

    sama5_defconfig:
        gcc-7
            at91-sama5d4_xplained: 1 offline lab

    socfpga_defconfig:
        gcc-7
            socfpga_cyclone5_de0_sockit: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab

---
For more info write to <info@kernelci.org>
