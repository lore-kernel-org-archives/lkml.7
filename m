Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B1C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FF32081B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="SUD42aeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbfIMTjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:39:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38847 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388919AbfIMTjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:39:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so33137226wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ZyJCNuOAdc3HwIafydT/ebM1uCX5N3TqLtB8kuskFZs=;
        b=SUD42aeXFnXHJaLyp51bT2MlmQEQ7QDV+2hi6y6yEdBaCsF/RmmxIXgMfFYZUCXS1B
         q4mup8CXz8RuwNf2zHrEHuaaJpSljgp61OSA/KlEeIUGKeJs5tnIN8slNL4g/yVfdRSA
         9tYSsVaA3TUic1zQBoHfuwvfAwPhcBhGz3oS6HXyEPY4DqPjy5b+JGr8cC+Pknobzwv0
         6huBoHtQ6SzVrsNKzwpXTS4vLRdc/DrNP5Gqp7KycHe+kAmLl8thsU5t5MdWfJJ+sREP
         QXtr/+z0tdM0pqnzjHp//Ru2ZZytRJk6tePRB5Rk2G/u9E6AxgsrweW1UVegJ4qTnzeg
         zWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ZyJCNuOAdc3HwIafydT/ebM1uCX5N3TqLtB8kuskFZs=;
        b=iiaTsx/DaxctuXb87MYSvGx2HN2RjnYYDob92MsPLPzK+wFLz4S6okOBjorX8TsSW3
         CHEOOGijXEkUFmBrXybSsalTU1L4AglzK9ljzBsC4MjLr2suUbHgwNgdysWBnljrDAS5
         geDRFVVf8jXg5RGrbnF6icjK5kdomLfcJBMGg6cuhnt6whvidVEbp2PHepo/PefMayup
         TJ5WDpV4NBNjkuG9sEZVQWXohIYkhyD8aPKXlMRZZ0oYIlVgqdSmlhOgOub6elxfUcnd
         jtV3EoD+57pHWQVob3p5FloIjyg5oCZyHGIXL7w5NuF/3Pogipk+GIVzjCl527KbEyCF
         XFyg==
X-Gm-Message-State: APjAAAXPdLyLwpn5Mer50yP+FAQzRw829YKRkoxxBj1YVf0zohk19qHp
        OL0BOUAduA+BvVHARwurPwfsYI9HumDW1A==
X-Google-Smtp-Source: APXvYqz8Wu/Nfp31mYpgGuNcvvmcgL3pdExhbyEzWv4bt55l/lu5dxmPgYsU/ZULUZTH536sQo5yew==
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr3373655wrr.343.1568403546055;
        Fri, 13 Sep 2019 12:39:06 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id g15sm2523966wmk.17.2019.09.13.12.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 12:39:05 -0700 (PDT)
Message-ID: <5d7bf059.1c69fb81.b7fb2.bc5b@mx.google.com>
Date:   Fri, 13 Sep 2019 12:39:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.2.14-38-gda2614d2744a
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
References: <20190913130510.727515099@linuxfoundation.org>
Subject: Re: [PATCH 5.2 00/37] 5.2.15-stable review
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

stable-rc/linux-5.2.y boot: 146 boots: 2 failed, 136 passed with 8 offline =
(v5.2.14-38-gda2614d2744a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.14-38-gda2614d2744a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.14-38-gda2614d2744a/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.14-38-gda2614d2744a
Git Commit: da2614d2744ab16514a2288de2039732935749d9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 83 unique boards, 28 SoC families, 17 builds out of 209

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905d-p230: 1 failed lab
            rk3399-firefly: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab

arm:

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

---
For more info write to <info@kernelci.org>
