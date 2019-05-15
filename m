Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387D8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BC720873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="wXrr8sCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfEOSHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:07:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33431 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfEOSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:07:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so559894wrx.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=8a0Ne4dNSZVwjHUcXcSPoak6AY4jKew3Xjufj621ND0=;
        b=wXrr8sCcejr0Sn5P42P7EREL6isxTX27F1XE5Ee8AJaQxQNI5CgunlVJb57CoD2rXl
         IBT7eqq4OtTkutBPtV2HM7UEnraymUDCXGEnfknCLekAj0Wz+0Jv7VpD0azbH4KR2vVj
         P+F7mdwtoYqJjQVJg6Dqgz+q4AvQQdGdtIJQH2XSp6odv2SJ/6q5vRLKMjQ+qfdbZbAC
         jT+QK91WiZo0a1dZsZ2GqUrfZrTpg7CkDiXcFuMtC1LQtPs8PjubgRAvh+Y7+yoMq+xo
         bujFGr/Bk0lcqtFXtg7eTNqaR6HsLhb8CPSGzSkYoD0q9WD7sNsG/3wjS3P19Atgzw+W
         q+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=8a0Ne4dNSZVwjHUcXcSPoak6AY4jKew3Xjufj621ND0=;
        b=ijtyugON1VTM3ZwQNXEs7KJDwG5Gj+V41NnJETqBbKDjdIyZSW14aBWLUD0BTUh5Wr
         QgUzhA1RVKZ1M1OC00L2AV9DbDIw8Ct7zBB0EHoPfX9u4NWQgFtjO5OVievXNnm6nPsO
         uE/3kJpJ/UOsDXLRgJCvNl0IaP0jscqRlZjjqmD6kqEjHMdAE3kot8Wfy1RO37yB5ixj
         YMn2z8p11i61Y8CJLnvb4UnXy9WvhXLbE6OY0hRRJCpRXzlCPy9A9AsDoBfed5EBVSWp
         SnvGB/Y6SVvszZKs7dBriJQMov8bM3gQeC7f84sUWUUg2fVDhEBPcE3DTCr4MghRKHoX
         PQ2g==
X-Gm-Message-State: APjAAAUW0sBT8+vs3QB3MyA0Bh2DcOVlZJCrxj835CmwApO7b3OEsOcj
        7WxGpWv/ftgDxVymnMJhq3glBw==
X-Google-Smtp-Source: APXvYqwd+fZ372FY962ClZLlouA2RJtuhiS2tWYmp0FxdAbIVFhEtHVlJZJTNskXwPFnO8h/ICF98w==
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr29130196wrd.284.1557943667392;
        Wed, 15 May 2019 11:07:47 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d9sm3560590wro.26.2019.05.15.11.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 11:07:46 -0700 (PDT)
Message-ID: <5cdc5572.1c69fb81.b2944.5072@mx.google.com>
Date:   Wed, 15 May 2019 11:07:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.119-116-g7b9ae876e241
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/115] 4.14.120-stable review
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

stable-rc/linux-4.14.y boot: 128 boots: 1 failed, 122 passed with 3 offline=
, 2 conflicts (v4.14.119-116-g7b9ae876e241)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.119-116-g7b9ae876e241/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.119-116-g7b9ae876e241/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.119-116-g7b9ae876e241
Git Commit: 7b9ae876e2410f72fbc14db54f141d516adeabca
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 65 unique boards, 23 SoC families, 14 builds out of 201

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: new failure (last pass: v4.14.119-98-g8d3df192f=
d69)

Boot Failure Detected:

arm64:
    defconfig:
        gcc-8:
            rk3399-firefly: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        gcc-8
            tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            stih410-b2120: 1 offline lab
            tegra20-iris-512: 1 offline lab

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm:
    multi_v7_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

    davinci_all_defconfig:
        da850-lcdk:
            lab-baylibre: PASS (gcc-8)
            lab-baylibre-seattle: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
