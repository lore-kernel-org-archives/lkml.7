Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A02C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 01:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EA52182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 01:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="YsbrPpzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEJB1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 21:27:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37772 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfEJB1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 21:27:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so5554724wrn.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 18:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ftpViN5j8NFAV54qkkJMS7+epm3RTRKzoNYTV0PlOJg=;
        b=YsbrPpzThe4ctLjXBEevMymgL7213QNtGRyA4NrhC/5eFu1pyt3lW/UZ9d17gTCDTe
         cxjxY5wuZvYTvsPg63uXO6fb8U2qf2Z9W6szny5MPL+YlAgyy6ccdGA+ar7+cZFO9McZ
         y41ypt9ziLd8y7qNcRXbWU2h/+PlgGG8U9JSGEoP9VByZ5Jyl2Z8f5aRP22ZUcSrvaRo
         /yFeAYlKjku7bjVMt9rpSbt2hKQj3HXZ20RvInP61VxxC6RQan4LlMUzPdm3e7SIjr7A
         UvGEb/rQyFNedzX+6b7nXTX7TtEWxDu6/K3yp8xoM/5TQBxrcICMrXxYsxTJTmtzLr2k
         zc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ftpViN5j8NFAV54qkkJMS7+epm3RTRKzoNYTV0PlOJg=;
        b=JCLV6AJu3A6MgI1+iqnPWepXWQAu1RO/cKtAzDxafK2e2Ediwo8KXF4bSK6nH7MWTn
         ufthE3vsGBZudCgEwsWTMTj4dy8y4nS10NllfNPHuZULsbR2ZEsSK1cTHokz9f2n79RM
         HRFR/32LDqC9//kGLqb/jcP64TnAhwYlN1gys52Mn+qmb5zG4Ukoynw35GNFg52PhDt8
         juk+w1DDf7neoy1vC0rDfXteM4lCH9k7SOXHMpQfMzd6VQSvAbiCHJjVVYPPCa/aMB2+
         VITajnbAylFdakT+1GT40X9gu19m9cTr9xOB/TZWJcfOgrUWeyJs2r53xZjvHfbsnnHs
         82zg==
X-Gm-Message-State: APjAAAUPQpwklmCwWAbqzf2XKfAjAIRYJKd1etQ3oxv56iRAshQrDr2J
        uMiMPZAyVTvBzIuwXJ/ljqBswQdBq46dsw==
X-Google-Smtp-Source: APXvYqyarNorOi0XwqzYDk1kJrd9ttGSJJRIcSk1u7eamncDsxys6dMt/bwjjnDvEdJygFoWQSRtPA==
X-Received: by 2002:adf:83c6:: with SMTP id 64mr5627489wre.81.1557451634115;
        Thu, 09 May 2019 18:27:14 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x1sm493646wrp.35.2019.05.09.18.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 18:27:13 -0700 (PDT)
Message-ID: <5cd4d371.1c69fb81.c575f.2868@mx.google.com>
Date:   Thu, 09 May 2019 18:27:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.174-29-g50bbfeb1e2a3
In-Reply-To: <20190509181247.647767531@linuxfoundation.org>
References: <20190509181247.647767531@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/28] 4.9.175-stable review
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

stable-rc/linux-4.9.y boot: 112 boots: 0 failed, 107 passed with 2 offline,=
 3 conflicts (v4.9.174-29-g50bbfeb1e2a3)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.174-29-g50bbfeb1e2a3/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.174-29-g50bbfeb1e2a3/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.174-29-g50bbfeb1e2a3
Git Commit: 50bbfeb1e2a357db99ff35681cfa95341b33103a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 52 unique boards, 22 SoC families, 15 builds out of 197

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: new failure (last pass: v4.9.174)

arm64:

    defconfig:
        gcc-8:
          meson-gxbb-p200:
              lab-baylibre: new failure (last pass: v4.9.174)

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-8
            stih410-b2120: 1 offline lab
            tegra20-iris-512: 1 offline lab

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm:
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

    davinci_all_defconfig:
        da850-lcdk:
            lab-baylibre: PASS (gcc-8)
            lab-baylibre-seattle: FAIL (gcc-8)

arm64:
    defconfig:
        meson-gxbb-p200:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
