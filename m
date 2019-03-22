Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B05C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372DA218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="fDLw1WDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfCVXW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:22:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35379 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfCVXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:22:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so4060403wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=Wd4eaCbCiMs7rDRY9UBa1NMPCUaT4K+x8fNO/rkvMqQ=;
        b=fDLw1WDDYTBaY7IkjoO1j96I9OtE3EZRb3JfqtFsekqPDo89EoUvXviV5vVp6gVVwh
         I4+ixOpz7sOBgqdI5r4ZIM7VYrnuqks0jhVbkvty87IQT0YLuNiibVSra19iNO3qtiiW
         Ww1Y2mEH8dhsZveoUF/rBx37Pgf3xiuptzOiwpWuJ7gUDZULfmg8zyevABP5gWC+zYs5
         lJRI64eE7M27OeV4UiUEiFHmgdLs6807H4fQh8nmqOZ22G0sNICaKlcCRA5RIWwlnbgy
         YTho7tGRUmE2k1qZGbNwRUrqf+7/BjDQjj0vEuErcZipWX9MkSmSKdnMH0zS64AweLFS
         o/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=Wd4eaCbCiMs7rDRY9UBa1NMPCUaT4K+x8fNO/rkvMqQ=;
        b=IePGgupmGp6AxnO3lP8Lf7L2PypEshiS1CbtDpPJ4uBFTNTZyMA8mbzR3w2adVlX0/
         Tn5WJgPXO4GyHwWF/14uGkdibpFr/MqqbTrjugMcgVgOcYYB50MLDZ9FLhFvkiyN49po
         Lnn9VbofvvlxAy+wEAr0mPINxw5hPKwv+pRfscf6M7B1J4AQGs9xkoGIadGyeZJbuTf8
         n8j/KN9QcGDlNl35X1rzrRaseAnhcfDP9EFrJU3PtgWODKOldgplwaekkHQ63CyqaIK5
         XUjznmvndNRB3saiZpak4+F/hqDF1+VVFKANNLtKWc0JJQf3RhyE+kgvZgMPrT2mEBOd
         HVag==
X-Gm-Message-State: APjAAAXOpDEOaVrzM2+0ayRUrZuElNbNEsHwVy9KUU0iUNUMq7ZG4NAD
        kBOESfa+LdxYmWey3V7v3eZutVl6nApp0A==
X-Google-Smtp-Source: APXvYqwBMk98GcpCQ4wfURk35nF9lml5rg5rxxEdB9rx2bQg6ZOMnI5HTEgjT6Q8gK40rbJYdMqBSw==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr7768658wru.150.1553296974571;
        Fri, 22 Mar 2019 16:22:54 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a204sm12084531wmf.12.2019.03.22.16.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:22:53 -0700 (PDT)
Message-ID: <5c956e4d.1c69fb81.ae3e8.c03d@mx.google.com>
Date:   Fri, 22 Mar 2019 16:22:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.176-231-g6926dee23fa0
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
Subject: Re: [PATCH 4.4 000/230] 4.4.177-stable review
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

stable-rc/linux-4.4.y boot: 42 boots: 3 failed, 39 passed (v4.4.176-231-g69=
26dee23fa0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.176-231-g6926dee23fa0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.176-231-g6926dee23fa0/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.176-231-g6926dee23fa0
Git Commit: 6926dee23fa096361e7d170c7fa21a8b51eb7673
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 20 unique boards, 11 SoC families, 8 builds out of 190

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
          tegra124-nyan-big:
              lab-collabora: failing since 24 days (last pass: v4.4.174-119=
-gf5fe3003919f - first fail: v4.4.176-30-ge577ed472fce)

    tegra_defconfig:
        gcc-7:
          tegra124-nyan-big:
              lab-collabora: failing since 24 days (last pass: v4.4.174-119=
-gf5fe3003919f - first fail: v4.4.176-30-ge577ed472fce)

Boot Failures Detected:

arm:

    multi_v7_defconfig:
        gcc-7:
            tegra124-nyan-big: 1 failed lab

    tegra_defconfig:
        gcc-7:
            tegra124-nyan-big: 1 failed lab

arm64:

    defconfig:
        gcc-7:
            qcom-qdf2400: 1 failed lab

---
For more info write to <info@kernelci.org>
