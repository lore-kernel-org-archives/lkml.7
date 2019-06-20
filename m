Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC683C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931AC2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="dehBH4Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFTXvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:51:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51526 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTXvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 19:51:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so4669276wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=1rEMOSLkLXhmvZY5HuOSKmGg6oZ+XQwBc/8alhmFjh0=;
        b=dehBH4TbaSbSAM3l/AEQFz+Nj1rLe9ojlXVsMo5GAj2QvYCJ4xwuzMTdAAw/pt9e8u
         MIuW2kCJdgb2N8R90uW9yolFdk9x48y985y9KoqXh3wrNJf4r08ZwVKCU72uyHaWkHp0
         SpzgWcqUC04UzOg8MfxXvoDvFtQ0HG6Q4axiSzgLTIjy4BrvF6VtphvkvVfFZkEMjYT/
         fiCvcLDGHR415AmoRF8Ihl73cQSjruEijemaYruGhZ7phsoXs0GHtRje+wf1cWr8jFfR
         GiKMCcWL+NfGjNbHKVKz/Lpvxnt5APE7BrbgQVsIRUxu1JqWpL9KPN72dJTq6wx7yBBR
         CnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=1rEMOSLkLXhmvZY5HuOSKmGg6oZ+XQwBc/8alhmFjh0=;
        b=CKDsUnz/Iclw48LzQxvTgsdB1dYcKiscAYbgjGefUqJ8vm2BRxKZKRFdiAsUHknZoU
         o+9Qmf2o4Kk5Ut6owCBtWR/TESMbtOcGIUzJZM/QrGOXFGrMsrfBstGGBE0VR3CIFo8R
         JnQbJJOsBs1owZvg5Q9lYHMGy/mufoP20kaGtUNmSX6Z1OatXcT/x+1+E3w1EVA9/SAx
         9MgoUoz8uXCi+7s10jIESyNKj+H+zHq7D4WKPjpDs4HbB23dTP69VGGbkmfdzjsNQTL1
         NQKdJO/jq+yf7ESP5sXDh7aIHiu5FDWgMpyaIlId9bffwmPlQxgDEwXJHOAuivKs+npe
         zLZg==
X-Gm-Message-State: APjAAAUoTE1H18ff/GVW/UU9BkFgq4V+jXHcdyzccDQJDvPOjxmJ1LtT
        F9HwHUxfQDSZ59u+OP2NTCbkcw==
X-Google-Smtp-Source: APXvYqzFmvVgAN18qhuyNeerBYANF025YE/t7cDogEO1quoMGEgsjXUVnUBSC1dpR3k7aoI4BkKlpA==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr1283805wmg.112.1561074663868;
        Thu, 20 Jun 2019 16:51:03 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y44sm920377wrd.13.2019.06.20.16.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 16:51:03 -0700 (PDT)
Message-ID: <5d0c1be7.1c69fb81.2f196.5979@mx.google.com>
Date:   Thu, 20 Jun 2019 16:51:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.1.12-99-g10bbe23e94c5
X-Kernelci-Branch: linux-5.1.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
Subject: Re: [PATCH 5.1 00/98] 5.1.13-stable review
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

stable-rc/linux-5.1.y boot: 130 boots: 1 failed, 127 passed with 2 offline =
(v5.1.12-99-g10bbe23e94c5)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.12-99-g10bbe23e94c5/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.12-99-g10bbe23e94c5/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.12-99-g10bbe23e94c5
Git Commit: 10bbe23e94c5975292d0a3ff74893d1625c1e07c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 76 unique boards, 25 SoC families, 16 builds out of 209

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        gcc-8
            tegra30-beaver: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            tegra30-beaver: 1 offline lab

---
For more info write to <info@kernelci.org>
