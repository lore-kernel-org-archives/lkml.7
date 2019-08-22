Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E946C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0945F233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="MQoTf0CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbfHVU5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:57:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35129 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbfHVU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:57:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so7082219wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=0i/B4N1uUKn39gW6CKzddRGMqMAE8IUJXmHV1krCefk=;
        b=MQoTf0CNTOfPpdGgQIw1Qoa+j5lhFoCBD3FnKzfD8v9JyT36iEpe0vazfsyD6UUUoT
         6Q/NAX3Ga5cxiidDc7eULxB6fRG19wLt2M5qTHiQAt0PhSyvvKfuh7eC1Baphrk7vuJY
         huwpDUC+sHCKF1uStl0+NEvcPLpvhk5MptS7KtkiRO7jqKphWeHfEwYnOsJjGI5oK9KA
         iGTsKg7OXyZXJStVjTrw0tlOKVGlrs8c7FHGsYn2p0HJFTOm7ERvG45Khz45mwxLV30R
         2R1ukYfgI0FFidF+laS2B2W63Nn7HN7CkxpTMr5paytJ5t31Zm2khmQKDLu10n/Fvqkw
         QMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=0i/B4N1uUKn39gW6CKzddRGMqMAE8IUJXmHV1krCefk=;
        b=fpVVQcFPwEOI/jFuyxaxAZtYeL3DQCGIQNj8Olc9odaJEjIxQVJoGlu9GPrzb3ZUhq
         aN9Xjonw6SaJNenLj/yiFoSgPF3Bd6hLfros14dRtkLYynrWm9vri9ZCSYVRpX7wRJAL
         kje+to0sDpS43D4K3ab/gCjSua0cce8g/ui+fTJcIj11aUDECipstbONsuy4Sn1UjuXx
         13OtRD5751ekZt3I+o1zTtyJ+TmUI3xBCx8bdtxHqjFppUxHRZNJOlviF2Wk1Uayy33n
         pgvXiBZYbhwHJPHmAkKOmsIT0ftMhDj78BJZuxAmf58sUmCwA2jK44y8Qo6n+svH3vXd
         MFqg==
X-Gm-Message-State: APjAAAUPxWYJ4xmZqDc++GJ8ckEQTKKcOriMRtQHGUm/3xZ05ljdr//d
        nll8c4mN4OTZ+fNwUGTho46LkjCLrvdP4w==
X-Google-Smtp-Source: APXvYqzB7f93pdfLt5YiBg84OdSMi/XbAxwmp7RD70TCXmIntNUoS9bbCF97+nQKjlJzM5DmAdAQIQ==
X-Received: by 2002:a1c:541e:: with SMTP id i30mr1043918wmb.54.1566507421427;
        Thu, 22 Aug 2019 13:57:01 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 39sm2019758wrc.45.2019.08.22.13.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 13:57:00 -0700 (PDT)
Message-ID: <5d5f019c.1c69fb81.b6100.a526@mx.google.com>
Date:   Thu, 22 Aug 2019 13:57:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.2.9-136-g6451706234b4
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-5.2.y
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
Subject: Re: [PATCH 5.2 000/135] 5.2.10-stable review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc/linux-5.2.y boot: 134 boots: 0 failed, 114 passed with 18 offline=
, 1 untried/unknown, 1 conflict (v5.2.9-136-g6451706234b4)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.2.y/kernel/v5.2.9-136-g6451706234b4/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y=
/kernel/v5.2.9-136-g6451706234b4/

Tree: stable-rc
Branch: linux-5.2.y
Git Describe: v5.2.9-136-g6451706234b4
Git Commit: 6451706234b494afc737f64c0b442d6594c4ccf9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 77 unique boards, 27 SoC families, 17 builds out of 209

Boot Regressions Detected:

arm:

    qcom_defconfig:
        gcc-8:
          qcom-apq8064-cm-qs600:
              lab-baylibre-seattle: failing since 6 days (last pass: v5.2.8=
 - first fail: v5.2.8-145-g2440e485aeda)
          qcom-apq8064-ifc6410:
              lab-baylibre-seattle: failing since 6 days (last pass: v5.2.8=
 - first fail: v5.2.8-145-g2440e485aeda)

Offline Platforms:

mips:

    pistachio_defconfig:
        gcc-8
            pistachio_marduk: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            meson-g12a-x96-max: 1 offline lab
            meson-gxbb-odroidc2: 1 offline lab
            mt7622-rfb1: 1 offline lab

arm:

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        gcc-8
            at91-sama5d4_xplained: 1 offline lab
            at91-sama5d4ek: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            at91-sama5d4ek: 1 offline lab
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab
            sun5i-r8-chip: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            qcom-apq8064-ifc6410: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:
    omap2plus_defconfig:
        omap4-panda:
            lab-baylibre: PASS (gcc-8)
            lab-baylibre-seattle: PASS (gcc-8)
            lab-collabora: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
