Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83CC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4B121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="chLvDLoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfDXVZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:25:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51501 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfDXVZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:25:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so6413099wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=4RtXf1LeBAKFtEx+X9Trrw3Hud+7SC4qxAoui5Y2GPY=;
        b=chLvDLoVJ9Nj/RLf+b7TwmveeZtdjG/76NrANOt0yBpUH0rpZkjLK0M+i+dYCdV+hN
         wd2+CW+df12yBhlrGZ+WX4FgqbOAqL9siAKeDBpgqzD9q9Eu0wGhxqvpXgRRvqd1fVv0
         XWptaOh8fo2FmaesPsD4CakkXyNlpG9nHM9/gpj7t91yDfW6ud3/ibGvQUajYRezvi8Z
         X0frcBFOO0a1cV/RCqtiealoO5y+O1VR4Uan4aR+nfXGjmo6rwyZneuP3emjYiaXBkiR
         o9K6E7dmOk9rYZPFHvkHFhXeXe728vyWQHRciiEHZk8q00YYBJg19gtsceRBuigoi7VY
         9Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=4RtXf1LeBAKFtEx+X9Trrw3Hud+7SC4qxAoui5Y2GPY=;
        b=ha6GA+dB3Sa/jO9DNkoogE/w9CSkqMtTAOGz0ZwKda0Z3AS/Y3X31rA4a1INrA+hlo
         928BdzMDl73jfpjGQu4iOQl/EL3OXI/6oQ8KTJ4h0xkM6uFZ9/yTMlG9wPN8AZHbDW2c
         xwxbCEBB3GXaQdtWsNnSvXag9w/Z34MT81E3RBygRPvKGM3CK2dAFNmAczjpyFjvbmJr
         jbHCswTF6kIk/oMX8E0lPAORNYCqW/0KE3JS8w3RMlRjbHKwmD1jwLbn3pe1NJWTgfJZ
         GjkqairGV7YU9/Q0rca5Vgh17QjMZakqDRrKxExIYixKyz/BBi5rTM2hBVMFRzC63cHw
         AM/g==
X-Gm-Message-State: APjAAAWZFAdaZqIIfJ2cOhMstgtIOo7XbBeyLIYVKpuizCAf5/VBlAXX
        PnnH5Tqf3hlreNT9N1o61iK///oK1EOUNQ==
X-Google-Smtp-Source: APXvYqxErt0pkAejFx66RTB864Wbeowknb181M7Vra+M6qeqVYSTu0c6pbCv1H50d/xsZHIc9DNXuQ==
X-Received: by 2002:a1c:a7c5:: with SMTP id q188mr800523wme.126.1556141148994;
        Wed, 24 Apr 2019 14:25:48 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id e3sm3503621wro.35.2019.04.24.14.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:25:48 -0700 (PDT)
Message-ID: <5cc0d45c.1c69fb81.df38b.4f8e@mx.google.com>
Date:   Wed, 24 Apr 2019 14:25:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.170-44-gaf8107419442
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/44] 4.9.171-stable review
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

stable-rc/linux-4.9.y boot: 95 boots: 0 failed, 86 passed with 9 offline (v=
4.9.170-44-gaf8107419442)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.170-44-gaf8107419442/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.170-44-gaf8107419442/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.170-44-gaf8107419442
Git Commit: af810741944203a4530f9af53806d321ca8eb9d1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 51 unique boards, 22 SoC families, 15 builds out of 197

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
            bcm72521-bcm97252sffe: 1 offline lab
            bcm7445-bcm97445c: 1 offline lab
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

---
For more info write to <info@kernelci.org>
