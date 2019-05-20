Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FFAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8A5206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="eBhoX0pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfETRsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:48:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37280 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfETRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:48:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so222802wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ASi4P+vK/BY4xARlAX5okcCkAi7jUwOKEr1mT66lsfQ=;
        b=eBhoX0ptMhFEvGDGd4CD7W4J15ef0bRB51zZwfEEyLbRH3a8MaLiUGeq7ElGJ7nTAB
         zGjH2NhWOo1PEnqsPXkKCrCmTiQqIijjGexUgk1wl2QcMqH1hjhzp4q+TV3jhTpZKsDE
         4cMBjwvC3X4twDv8atsVikKEX5U5lZG2Ylbvqqr+2OL1MpH2F/J1GJpIt6xTvYgnmos0
         hTMjqK37n5yyFp1r06W1MLCXq2XxmbndM6igwCGS+190iPSQ1nfdCiKjeRyaKBsxRbCD
         ROdFAoWkPHDDx+TwQIGw6Uyl/yFyJ0neIWTzvIjiTH1FMy70Pb45A/zOi+rMMLYWYrmO
         uMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ASi4P+vK/BY4xARlAX5okcCkAi7jUwOKEr1mT66lsfQ=;
        b=M3b9Ukh4QYnrg1cwn5xj8F6GD9t6C67Nxhoxb1NEGB8ZPgF9E3j4P3BECqI3tIiWu9
         SzQ7LyAKNfEGb8b5S2c53Ihf95dUIZNU/QowkCrTQiEy9hqnebSSTnZTdflE+Pu0j9B3
         dqcoXut6HaosyWLA7lkArWWvXlCa77b8ne/eFUnJcKlJJX1FdF4UjdUcVDQcs5w+JLBX
         RzYNm8pyMbi0JOSi951nhK9J7Tm0SBO3tU8VFu+2SkvQPtEx2e4GBunoHXmd3yi89DJw
         xDBjhDE5/giFbABrt2cSBG+B0Onz7EDqx0HgJXcp+StdC+YRWmBMdn773dGyHbltp6KF
         ZWXA==
X-Gm-Message-State: APjAAAUkvlxK1BZQ0989HAdsSZU1wVyM6asMsmz7dU6uD9lPWy39HLXh
        milO6q6qJU2eVkrJ2kbyCn5slQ==
X-Google-Smtp-Source: APXvYqxhBojFsH32AKHeR1/kcB+5hpefssYLMXmgAYWw+YhxdLjndpVzpLs5H+/mfdRcv66/Ozhw9w==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr214333wme.95.1558374495158;
        Mon, 20 May 2019 10:48:15 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b18sm16167146wrx.75.2019.05.20.10.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:48:14 -0700 (PDT)
Message-ID: <5ce2e85e.1c69fb81.1cae4.71c9@mx.google.com>
Date:   Mon, 20 May 2019 10:48:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.44-106-g6b27ffd29c43
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
References: <20190520115247.060821231@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/105] 4.19.45-stable review
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

stable-rc/linux-4.19.y boot: 120 boots: 0 failed, 118 passed with 1 offline=
, 1 conflict (v4.19.44-106-g6b27ffd29c43)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.44-106-g6b27ffd29c43/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.44-106-g6b27ffd29c43/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.44-106-g6b27ffd29c43
Git Commit: 6b27ffd29c43f07e11cc906154745c4e9b3d71c3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 66 unique boards, 24 SoC families, 14 builds out of 206

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: failing since 3 days (last pass: v4.19.43-114-g=
b5001f5eab58 - first fail: v4.19.44)

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
