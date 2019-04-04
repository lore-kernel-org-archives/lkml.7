Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF6DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D65A20643
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Jxy18nMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfDDPED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:04:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54650 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfDDPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:04:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so3445723wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=jxpm13Cng3LZJ7PL+9i3NZKhEssMeqWPTyTYZlB3WmM=;
        b=Jxy18nMge++oLn+zT1ruo6zJFkKMd45Ma5UBjk3/l2L2FlANcA9tWT42mwYAmjC/Sj
         7ePFCg4pZOqcL8qsfOqiJ7xdfKiZ98iBcTSs+cq0fjAxD90OS/JIaWn2xz04eumGEuha
         RzbISu1sLznsc8DwWN0qQJWpdCZKsgIPdv84a1HO0f47GAlDyD/pIkwaoZaAyAQIlu/k
         jAn4KHfLhjthlJ5Cul1BoMfbDULD6qxDLhACSGv0lE56J5ATQNbNzaxetPU8LFzW74q1
         8rS0pZt3LNsl+e41RxrCk7MtxBdngm15xco8BjItkKScdAWRYWsDRYSAjUEcRtJea7KT
         SNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=jxpm13Cng3LZJ7PL+9i3NZKhEssMeqWPTyTYZlB3WmM=;
        b=fWx4qWeOmD2f7XehP7yHhfuVNZbQO0mFl0KhWmyVa0uCjALPzXvseqDd05MnutYZ4D
         Z8KKa59wKH61HI72HQkzWwmSRvQiH6k1CRzkPrBHdKCXyKzhCNXrRal7l6/Omzdz42AE
         xR2Vu8DaFq62Tken0fMElU9enIqaE08bbfT3pArsJK0voweLjoQQh2yPwTn3BceqdLZu
         YUqK7tTBS4AcUxp3AYisga15cQWhwLfyh/opN6vwhCwB2JHHT5sSgziWcQjasLmLLMtF
         FKIemYOucBZ/OOERelSz6baFcNL5qr8bx5e9oA+qcnjWYK6MckNOuWGy45WSFUS8v/4V
         E/tw==
X-Gm-Message-State: APjAAAXhcu5jWTKlt1wp1EeTQKL5JDYDWq2QuOemBCtyb9LLvS/GsIbF
        hnoOYLTf1I7o5NT3lVSfAc+c5VfcikYS4Q==
X-Google-Smtp-Source: APXvYqxlu+dDfbXbP7olwIjzN2WC9S/9hlBh0DzdMF1APCwc/mP+O0SApNtFxlr+oJCJkHu7JVOKBQ==
X-Received: by 2002:a1c:4cf:: with SMTP id 198mr4340858wme.125.1554390240104;
        Thu, 04 Apr 2019 08:04:00 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t81sm38274234wmb.5.2019.04.04.08.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 08:03:59 -0700 (PDT)
Message-ID: <5ca61cdf.1c69fb81.2aa21.3eb9@mx.google.com>
Date:   Thu, 04 Apr 2019 08:03:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.110-122-g662f0922cca4
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/121] 4.14.111-stable review
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

stable-rc/linux-4.14.y boot: 115 boots: 1 failed, 96 passed with 18 offline=
 (v4.14.110-122-g662f0922cca4)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.110-122-g662f0922cca4/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.110-122-g662f0922cca4/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.110-122-g662f0922cca4
Git Commit: 662f0922cca4c200ee0fc72591d6684e59fa2861
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 62 unique boards, 23 SoC families, 14 builds out of 201

Boot Failure Detected:

arm64:

    defconfig:
        gcc-7:
            rk3399-firefly: 1 failed lab

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
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
