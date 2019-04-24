Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ECDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E959921773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="so4xyIPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbfDXWF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:05:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54523 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbfDXWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:05:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so6504957wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Se/ahrvzYJzQ0LWUReLMYUlIDmggKvO9NZyWjOCsifM=;
        b=so4xyIPj6MyKEUssrJl1jS52qwftoto6SMd6QHN3/gnpUPE8eb3EHktisEpNRKPts6
         GPov4wnFgL/mizO+rbIl6f3kK9AutunpiugO9F79TCCoKvWWZWI7/zFubjaY/ckut33c
         6TTSPQ2cvnqA1ZOV9He2+MPrjELKhJPtcOR/jp95FCM7mwEZF2ShRyjpwo3nvOCtlZut
         o3Aqp+E5c0I/Dgft7zA1g/2VGfgbULRvzkGHDNgO8hXJt997c63l+7MEy0FYxROBew1D
         +f45DbxpVkMCaG2jivnZWWTehl7HndrCNxXfcpB9BOoxWLdbYFvO/f/Rz1trsdIsMQdP
         7a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Se/ahrvzYJzQ0LWUReLMYUlIDmggKvO9NZyWjOCsifM=;
        b=KONn94A1u9QX84ULCkWBOjdhmThQ6vbzT9hfVU3ezZZVGdo2tc6/plLIK+STPbPAcT
         TKq6bPKr80S9vcBURD2S/+YfNcsDHNWfejG4DcmVtSKll8S2bJxmB4zy+Du8Vi/oE+3b
         fOfAHreWhTnOlRm0SnFXPuC34y4zNFO61VGKABaVg+JmiCRzMvjOfamVqWROAqb6MbKr
         xh0doLQe9fjvhB4uwkONlyv1001p88n786s5imPUsEHGutPCOaVgRF44TWadvdMgGjj6
         Z+Gs4xgQ1GTOziLeSxj6gx8knNRU9RCV+SSB9gOjeB+hDgc22MVo3ik8h6UdRvel5/hs
         vdFQ==
X-Gm-Message-State: APjAAAW4TAziRKuDlseB6Lepeg+Obz7tMEUKv0IY4boIxft1Z0xR7RZC
        9V0ZOGfwynTPiTJ2htaeiGnu1g==
X-Google-Smtp-Source: APXvYqxXRMtibcO25gV/bpcVr9rJlOq1HPhC+V4LO89MrSEZGVNxqybH7ZhAZJGL0SJNV8SF8gYYuw==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr975909wmb.7.1556143556813;
        Wed, 24 Apr 2019 15:05:56 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id r16sm17180919wrx.37.2019.04.24.15.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:05:56 -0700 (PDT)
Message-ID: <5cc0ddc4.1c69fb81.3cbe4.0249@mx.google.com>
Date:   Wed, 24 Apr 2019 15:05:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.113-70-g00b06633f871
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/70] 4.14.114-stable review
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

stable-rc/linux-4.14.y boot: 110 boots: 0 failed, 98 passed with 12 offline=
 (v4.14.113-70-g00b06633f871)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.113-70-g00b06633f871/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.113-70-g00b06633f871/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.113-70-g00b06633f871
Git Commit: 00b06633f871b84af0a75354a6fc525b309a82a4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 64 unique boards, 24 SoC families, 14 builds out of 201

Offline Platforms:

arm:

    davinci_all_defconfig:
        gcc-7
            da850-lcdk: 1 offline lab

    imx_v6_v7_defconfig:
        gcc-7
            vf610-colibri-eval-v3: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            meson8b-odroidc1: 1 offline lab
            tegra20-iris-512: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra20-iris-512: 1 offline lab

arm64:

    defconfig:
        gcc-7
            meson-gxbb-odroidc2: 1 offline lab
            meson-gxl-s905d-p230: 1 offline lab
            meson-gxl-s905x-nexbox-a95x: 1 offline lab
            meson-gxl-s905x-p212: 1 offline lab
            meson-gxm-nexbox-a1: 1 offline lab
            rk3399-firefly: 1 offline lab

---
For more info write to <info@kernelci.org>
