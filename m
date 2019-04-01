Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40088208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="dmWr3la+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfDAVD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:03:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40094 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfDAVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:03:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so13812516wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=2nxIur07qRSrCufnIZOnpKn2oo4k7gr5GzIMGWVZcEM=;
        b=dmWr3la+ef/dqM9sJY4seuU1OCCXzeIfipfq+KD1oZoDNfUROn3JK7D5wXleZnKW8Z
         baGPOOLhFs8UBsaLPokJ1E1JvQEY7Pj1tjWmJdk3H6xb8VT/vqxAVE/vvIPids2OIqXY
         SPHFVpXQ0USRUodDBG2Y2WIHg/CmugmRtdZoGowK8G+VOUUwv8iLfI9bxQ0ohgOAJT4h
         WvZMCG+tMl0j+6/GKddyJA75tW7aBrQ7OENuoT6U/RsLUBFyJNxv1SGkyVwcjvdM8k8+
         O4m/h/YGyeAWuL9tyI1biG6oalFP+EphTe+nziaY3UIYeupsNpHr/hQHLvysi0V4XAnz
         4uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=2nxIur07qRSrCufnIZOnpKn2oo4k7gr5GzIMGWVZcEM=;
        b=hYvR/5wXnBnoFKZnRQIA5WlLAJ9zfRJ2HOjUO7k26cdnXUoondvCyKgN854mxywmSw
         LwJ6NZ1Tq69JEGT4EPbJXLzg6oFxA+ZA1NMtp6mzPpezsmN8zCYfywmi8CdKQCpkbYwx
         hoPS8GhDkYCpbLT5vy1yLdVM11zsC3QdrLHKceQTEzxokCp9x1p6dMvR7ToG30BPwZPM
         6Qy+Y6CbxMdWrjugC9QuEAP2ktbIccYp4aUTV60FgZkRhhRIM57zMP5YmSmWMsIWmmUY
         qppWPV/7mk3WqoCNew38Qhy20zMpYGGz3tzHWg+byZhAqf4P8+TLRiFYMoubD4BGqaqa
         +Beg==
X-Gm-Message-State: APjAAAVEcwF4dzuat+o1Tv2cYeyR11SW5ZZ1PCwQwmoZOh5F5eZ0+wU/
        /kEUib+suQyoFE6lQu4kHlHE5A==
X-Google-Smtp-Source: APXvYqzJA2BJRsJeu908ezoDV/xXxXSCEcrcfukhfuWO2K6h9dRtQGdfNJ36kOyougJrW/Bz42TdpQ==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr26026797wro.40.1554152624580;
        Mon, 01 Apr 2019 14:03:44 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s203sm22405890wmf.14.2019.04.01.14.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:03:43 -0700 (PDT)
Message-ID: <5ca27caf.1c69fb81.55d3f.5194@mx.google.com>
Date:   Mon, 01 Apr 2019 14:03:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.32-135-g64b7b716f98c
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/134] 4.19.33-stable review
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

stable-rc/linux-4.19.y boot: 119 boots: 0 failed, 101 passed with 16 offlin=
e, 2 untried/unknown (v4.19.32-135-g64b7b716f98c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.32-135-g64b7b716f98c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.32-135-g64b7b716f98c/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.32-135-g64b7b716f98c
Git Commit: 64b7b716f98c53b01d6f52f160cd50a281fc0612
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 66 unique boards, 24 SoC families, 14 builds out of 206

Offline Platforms:

arm:

    bcm2835_defconfig:
        gcc-7
            bcm2835-rpi-b: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
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

    qcom_defconfig:
        gcc-7
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
