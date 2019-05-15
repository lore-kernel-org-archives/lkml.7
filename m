Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40E5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BD02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="W26Ml9HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfEOS1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:27:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39826 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEOS1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:27:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so628122wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=28QOsUrkOtQ3+F3AZF6tvz0XZ0x3E0XcKQguFdoMZBs=;
        b=W26Ml9HIpacgp0bgPVcY17gxP8xNSnXCf+QlN5vEgiUdbU5UWU4xwSipKVCXC1l67u
         f4X/GH2Z1ktU+q04rxjtyjlIjMa9x85/L1heKfYjDqzcmbawbowHu9tFzNApVWyNi81i
         5A6lZM7wdGXQNBmDGGMJxQFsyMx8N7mILxU30mpbel/DSVFydPOso1bmD05004BksxZ6
         K95e71l0J2wrM+5DZgcxxu34CoUgvsS2gf19ctr3/hxO0XdZwaAmdtgI/YadBjNcYt0i
         5zlhcWGOs5ogl9+97EWHIz+AM/uzNK6xb9GR9jq4kWUeC7pf1Jxjoo8XzGQxEWqNWwHD
         Zq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=28QOsUrkOtQ3+F3AZF6tvz0XZ0x3E0XcKQguFdoMZBs=;
        b=ncxw/8Ylfjf7L4R1AQ4ozXxhiMaJ65aIVI5kFJKxPprKWSThf9qez3/9rE9+mSAYTN
         //Vp69QVVkORnwxx55PDxKoStWEXHB1svy7n6XlPOJUM6l8/v8I5w7IWKizLmzvTdIye
         n/ZW/VenlI+s15MGHZiTNk9nK/smQHSjqQTKXmaeozjhryn7GCSVTEs3hBLQCKlkJJew
         mZWyuH2aBntYRuQ8AIZKvTv+JHHRuHP9a0VfxmXu1I5MibNbdbmitnCA0+A88ZvtCf2O
         zRxCPexOSXuKoCTTq9xHo8vR1tp8NJGOLEivK8YAlBGAir9kBuqQ1Op3IA+xCPRGFEY5
         cecw==
X-Gm-Message-State: APjAAAWuwS/9+lirUki+ULX+FfFGTBduB9zmz+r2gd/kS+n3xeFoTRl2
        MOiegzSwG5Na4eX6ZXf8ZgPcgZapLaXRdA==
X-Google-Smtp-Source: APXvYqyOwGKXoVHywbP2QgQPeYcfGt1mh8KczoQzAuOcR5M63NiPGuTCtgaNYm+yxC21Hg4fT5wpnw==
X-Received: by 2002:a1c:2c89:: with SMTP id s131mr23814243wms.142.1557944867290;
        Wed, 15 May 2019 11:27:47 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id d9sm3648814wro.26.2019.05.15.11.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 11:27:46 -0700 (PDT)
Message-ID: <5cdc5a22.1c69fb81.b2944.58c9@mx.google.com>
Date:   Wed, 15 May 2019 11:27:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.176-52-g2647f24152a7
In-Reply-To: <20190515090616.669619870@linuxfoundation.org>
References: <20190515090616.669619870@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/51] 4.9.177-stable review
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

stable-rc/linux-4.9.y boot: 112 boots: 0 failed, 106 passed with 3 offline,=
 1 untried/unknown, 2 conflicts (v4.9.176-52-g2647f24152a7)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.176-52-g2647f24152a7/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.176-52-g2647f24152a7/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.176-52-g2647f24152a7
Git Commit: 2647f24152a78a686e9e2c8382f5b292cc31b99a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 52 unique boards, 22 SoC families, 15 builds out of 197

Boot Regressions Detected:

arm:

    omap2plus_defconfig:
        gcc-8:
          omap4-panda:
              lab-baylibre: new failure (last pass: v4.9.176-35-g6194f35e77=
9b)

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
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: FAIL (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)

    davinci_all_defconfig:
        da850-lcdk:
            lab-baylibre: PASS (gcc-8)
            lab-baylibre-seattle: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
