Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299CAC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC60C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="hgwsxbSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfEOTru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:47:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38300 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOTrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:47:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so794563wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=0WW703pVcAi5qG/en5h0bzayogRvn6kb9J/fL/xA7i0=;
        b=hgwsxbStiVDb528o2+wADxrHQlduzvmbNkKq33XGSpnYq1K5MmrStbajrs/r+GxnkK
         nvoPfGVWfbWi3+MSlNDnYond7MBuT5WcqnOqzbUT873nxQXPWgUWPg8QdBw0MRtDnfGK
         VKlntyKwXjSSbe/RGb1z0k30lwHSngWk+yUcebsGUSUWCo5Nh/MwOxftxuSjlec6xA5d
         oe8ohPRWJtG/xqi5392ohxVJQDsSibqu2+UmRFwCgf7Uj1DoeOKu9izEiaRecPxCeqsx
         2kwRKZDJ/oHzxjGAptRmekPQ3PaJOrFRpNazgYLl8t7ZnTm/phRnpjEogUKVFpYLZUyg
         M+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=0WW703pVcAi5qG/en5h0bzayogRvn6kb9J/fL/xA7i0=;
        b=bStFFpX4J8IPFTnvLz6sEpls9D5mIh/KTUJ1vv4nn7OjBAJ3sONCg3RTzGhA05aA6T
         RAeeNi1PFt+8pKDBUna1H93Ku92Y+0AdGzmP0v7L54zbZLwk6ms3IhrKWl3WuagJ/XWK
         knEh0vNMXraerjTjwDys/1p8iis9KPy4/XslVwhmUExlXjSZOuXxAYbuZNQ/mrAAEA2s
         KaEZiIH6/gEWbVv3V6HmbpYnm7s7MPiVSzM2U8OCRGsBbn9oQc0FFnV6kP8try3OpOPd
         Kbg02OO3pxcJ4/JpofPZ4qg+mNH/VHUD4vs31ulUYQVLXDYgkYyxFS+Vy/vachU2RKDN
         qLww==
X-Gm-Message-State: APjAAAXcehImllLKU+dUHigFcEm6jsknByZOuqrxBYuOGQpOP1elseYb
        Mw3rZavR74WkZvRUui/3bKcbhA==
X-Google-Smtp-Source: APXvYqzw8lU7qs8baxSFI/CULQBQ7pVqFe2bLV5JK/UwtwEXby6jNw+QeBun6jsp8KUKs54GIDjQlw==
X-Received: by 2002:adf:81a2:: with SMTP id 31mr27186734wra.165.1557949667875;
        Wed, 15 May 2019 12:47:47 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o8sm4199362wra.4.2019.05.15.12.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 12:47:47 -0700 (PDT)
Message-ID: <5cdc6ce3.1c69fb81.41d83.893b@mx.google.com>
Date:   Wed, 15 May 2019 12:47:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.0.y
X-Kernelci-Kernel: v5.0.16-138-g174f1e44d016
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
Subject: Re: [PATCH 5.0 000/137] 5.0.17-stable review
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

stable-rc/linux-5.0.y boot: 139 boots: 0 failed, 136 passed with 1 offline,=
 1 untried/unknown, 1 conflict (v5.0.16-138-g174f1e44d016)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.0.y/kernel/v5.0.16-138-g174f1e44d016/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.0.y=
/kernel/v5.0.16-138-g174f1e44d016/

Tree: stable-rc
Branch: linux-5.0.y
Git Describe: v5.0.16-138-g174f1e44d016
Git Commit: 174f1e44d0165ce68f4e520718847304556717e3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 74 unique boards, 23 SoC families, 14 builds out of 208

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: new failure (last pass: v5.0.16-105-gcedd923508=
e9)

Offline Platforms:

arm:

    multi_v7_defconfig:
        gcc-8
            stih410-b2120: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

---
For more info write to <info@kernelci.org>
