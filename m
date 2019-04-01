Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D12C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BB920700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="eY8k+8gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDAWnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:43:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51919 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDAWnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:43:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so1119078wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 15:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=C2VEMa/JsjF1gq2Nd6Z19qL0Vl4NGr2Rxx8XOOZsIg8=;
        b=eY8k+8gxAXTlJpqhNULiFJKHnGwkf7H2aS92v5Zbhyk5vvbGELzudkou1ZMOo6vblt
         lF0jXov5XovufJShfyDxC1jP85T5ir7Pl1DJL7ZL7gHYbx8gZ+ARzwWpnXaa5fHEicsD
         b9bcrUDLObHR9MPQqpwdgDpda+gQceYTAkW1TAmxWWa0nj4ss+cY+fdgiMPqbr34spcM
         VU13Mff1kHpYDonbJs0xdwmPJTNRtspQ4ojrUmHkJySNMM2sZ2G1pazw8bbAxrGP1fJG
         uqDAFN1/3/AqY6Vc3C/VBg6gghO2GHO+XyTJ3CQp/gGKMiCIV8lyuXOlWKKd19Ol+cUz
         brpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=C2VEMa/JsjF1gq2Nd6Z19qL0Vl4NGr2Rxx8XOOZsIg8=;
        b=p/NfAzUWkwtNqPwufvnCtbg6gvbMzwWb246mkQqxaWNGQHo5MaUjk0/72TWObvybrR
         8U2un48OtBTEDK0YfpFtda6snrSMF7ZlaRF5F19ApDFG9lxrqBsfZQkuGDhir2Abzade
         yKToPueNfoq+4W8ZhA7O1ZTUi3E+GMW2xtvK7szjYDxG2RvSI1TwE7cXbUCX64390UQD
         qc3vQZF/afKUT4uBY463iUVbaLJLq/cTSdLsrL9eRVYLgw/Yg2d9212VOlW8nvlVmEyc
         qvsv+z9UfsmUUxlze89LnQ+seYLN9GtRE7vs5XPcswyLXVSsG10ADU1UzbwWHVnKaTy/
         hapA==
X-Gm-Message-State: APjAAAWly061iE4mXNE1qSQ4iqKxlJ03O8vht/Z0kgSse8UhlSN2RopE
        Fijx0OiwPNM72iM0z71xR8+VRw==
X-Google-Smtp-Source: APXvYqzAmMieOySJKvdoD3Ux1zf/kAGQXxjoLfROa8ZHdLH32Wz8P6FnDPXBmsLm3CKhCy6Vcd4AJw==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr1273522wmb.7.1554158624955;
        Mon, 01 Apr 2019 15:43:44 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x5sm18556148wmi.37.2019.04.01.15.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 15:43:44 -0700 (PDT)
Message-ID: <5ca29420.1c69fb81.eef62.16d2@mx.google.com>
Date:   Mon, 01 Apr 2019 15:43:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.177-132-gd83f26e3dc56
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/131] 4.4.178-stable review
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

stable-rc/linux-4.4.y boot: 92 boots: 2 failed, 74 passed with 16 offline (=
v4.4.177-132-gd83f26e3dc56)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.177-132-gd83f26e3dc56/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.177-132-gd83f26e3dc56/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.177-132-gd83f26e3dc56
Git Commit: d83f26e3dc56e1998cf85b7d35bf5c5819f03215
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 44 unique boards, 21 SoC families, 14 builds out of 190

Boot Failures Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
            stih410-b2120: 1 failed lab

arm64:

    defconfig:
        gcc-7:
            qcom-qdf2400: 1 failed lab

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
            tegra20-iris-512: 1 offline lab

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab
            tegra20-iris-512: 1 offline lab

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

---
For more info write to <info@kernelci.org>
