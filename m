Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BBC208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="NY74VucY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfDAVDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:03:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35997 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfDAVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:03:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so995763wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=uiMJ/B5sAIdAbJ9ZeqU/ZQXF519EvcL5psk83/6SkxY=;
        b=NY74VucYVJg/T2Pg4nSAZJCoZnDBfqAIW2a+Ge1DkH7CozCvofFH4nBKEBSgTE8a+9
         ZdWpmI4Ph1jMtTsF4YcNQjkfm0UkaQRLN2gyQIEyFf+RnGpw0vYuXJbTuSYih4XjFWW6
         Pdqg//+Q7cpxMETd0ZAyF3dY9Zq7dhF5JYN4+Zi0OQ0Gzb3QsHNCA7TLwYwT/vFOgV6y
         x4gNgm41ZTbFLOLdhm1ND2VjnNLABKUBim5mxoqfKIo3zumPYbWClEGXSJKWow9xBCyg
         k4Q1kMgVkAnL12KPmtw0BtjPEfFc34EN3Vy/LZUpXyME7LMDeF8fn1pxu5MUvtohCiLa
         RqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=uiMJ/B5sAIdAbJ9ZeqU/ZQXF519EvcL5psk83/6SkxY=;
        b=aG30JlXuyWurAeDygElJZlweTg+RVxVb0Jhh0/AZeUHX4sJswucCn5jfGAVsN+tb5r
         HebIa2MFjfni7GTHu67n7bIQd5/ccOOoplWtw1koeH9W564hGoWNB0T1SEp6nQCIENyc
         oPboGHb977jngp9zA6I24QxaO6Vw1cRUQC0qgZqAgAbXq0VtTsWH6deU8CoPCy5en0SI
         6dJkb+EcNkXcqdXVUpYyespmRVpDcTBbAk6VMPHciO5vGJk3EsVs427pEWtCIoTjfwYs
         fUMBsrBuWtbz9JUtIkHtbj33cWLsn7vLtZdeOJDbnRpuO66iwv5AO4ecNa+9Db4A60/K
         K9ug==
X-Gm-Message-State: APjAAAX5OauAIvGjqoYuN7MGr5HQWwAfIxYVugluuiDlrhN6EfLjI8ID
        MDqUw2fReCmCdfl+BUUXe1GSBlosI1od9g==
X-Google-Smtp-Source: APXvYqwH5j4GKsGY1gYa0lOuOf0f7UFNDK9qltNnGDR9FVvSDeiRhMw875785eY7O4CaWIwIYiLRbg==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr1051594wmd.36.1554152624174;
        Mon, 01 Apr 2019 14:03:44 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 84sm19794450wme.43.2019.04.01.14.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:03:43 -0700 (PDT)
Message-ID: <5ca27caf.1c69fb81.980f2.841b@mx.google.com>
Date:   Mon, 01 Apr 2019 14:03:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.109-108-g9f663733559c
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/107] 4.14.110-stable review
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

stable-rc/linux-4.14.y boot: 116 boots: 1 failed, 94 passed with 18 offline=
, 3 untried/unknown (v4.14.109-108-g9f663733559c)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.109-108-g9f663733559c/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.109-108-g9f663733559c/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.109-108-g9f663733559c
Git Commit: 9f663733559cbf742da52d17c9554df7b028c5f6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 63 unique boards, 24 SoC families, 14 builds out of 201

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
