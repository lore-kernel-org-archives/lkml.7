Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D47C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2B12175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="vAvXIxPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbfEXF2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:28:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40414 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388445AbfEXF2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:28:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id 15so7822248wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=RFTpgKRph5hKN4zTxKUj6Kr/SwTVEIL9u2TwViKkFZk=;
        b=vAvXIxPjSSPQJ/jwSn2ql0sbGOYI+N9VsW1Ov6qe4KCrNHZL+o9rxlzGT+/kO/9vv8
         fxT5wSHIue1K8T9gju+d306IKXguLY6K/oHFG2hOZ4YTyvM5KLKetDw38ifnvIXPeY00
         E7vh6XelLoC7w0/PepM6VagNMQWUmgm6hZtrvaFxeleMIueJycikrA3Inp30/sbsTdil
         MgAUPo4EQIQfhZFmR47yw9QFlE0TTwOuNZ6UUTWXuMddKUa3Nc+/Zr0K8K2r0n2oGPfR
         vAwpnZmiuDkKt2XNPTpezDxjn/B/ZRQM3GEJQ5APBE6NxvLrjPyjg7ZAY5PIqZHGikWI
         SYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=RFTpgKRph5hKN4zTxKUj6Kr/SwTVEIL9u2TwViKkFZk=;
        b=pNpSKOHoyXw8piv5DB1nPltrBaIY4/8hEuRRFFiNWF+MmXOU/i6qi2YTJLy4P16PfT
         pyLagbPdutuN7LRnxmkVp+3rxNtOC+/BVOSDeHC6Rga4frDHBZo1dSlHpDO6BHvB3SlJ
         CTAsPsOLB9M0rQhcOaL3g+V900hGR99eHoHectR3D92sSfM9uviNASfvgEQYzxJ2mY4S
         PSMF6IOHFe2eph7XJYT3ay2TtZ7cF39r9bl+Z0SB1OCr/bAeArpqituCmYx8U9rRrQLD
         YXoPngtwxILWV8LoZH5TnZS6d3FpqlsfHD3T9ZUh6ATvuJL8OJUbJMTHIcm+lmTDL9DW
         iyQA==
X-Gm-Message-State: APjAAAWxmplfX6E04jPGulcpidxtyhXlSLfCenMVzauER0U9aoGnvXGj
        JaP92zfO8AGTs+mN35KavAXHew==
X-Google-Smtp-Source: APXvYqzwao2EN7hiFW+Tv6d4/ftSGcUlI1GVkPFKcrwoS6nS6JeY/tv8y/IfU//6RKQQsqjoAAQqmg==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr14376002wmd.43.1558675713578;
        Thu, 23 May 2019 22:28:33 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a5sm1058730wrt.10.2019.05.23.22.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 22:28:33 -0700 (PDT)
Message-ID: <5ce78101.1c69fb81.69b72.5337@mx.google.com>
Date:   Thu, 23 May 2019 22:28:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.178-54-gf6bc31d8c3be
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/53] 4.9.179-stable review
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

stable-rc/linux-4.9.y boot: 107 boots: 0 failed, 94 passed with 13 offline =
(v4.9.178-54-gf6bc31d8c3be)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.178-54-gf6bc31d8c3be/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.178-54-gf6bc31d8c3be/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.178-54-gf6bc31d8c3be
Git Commit: f6bc31d8c3be3e5ab957341b3f99f8b45fcc646e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 52 unique boards, 22 SoC families, 15 builds out of 197

Offline Platforms:

arm:

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

    tegra_defconfig:
        gcc-8
            tegra124-jetson-tk1: 1 offline lab

    sama5_defconfig:
        gcc-8
            at91-sama5d4_xplained: 1 offline lab

    socfpga_defconfig:
        gcc-8
            socfpga_cyclone5_de0_sockit: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            stih410-b2120: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab

---
For more info write to <info@kernelci.org>
