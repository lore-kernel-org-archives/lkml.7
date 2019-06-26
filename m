Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B4C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7744D2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="AZdX9lcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfFZNve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:51:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33398 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfFZNvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:51:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so2876125wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=lQ+kH+8OcyY0c8JYG72kvfeQsmfca58t7L4uorcaVGM=;
        b=AZdX9lcI5pjztVWxh656eaPnCtDHPZIem9X1kHLHfQTwUBsdYtK5oOQI27PKLVQBAG
         tGieFaS3NaXfIKUVngX/yG7F/MsF1abmxcDVGjGl8LtqM4Ft4xNanGFiOHur+L4fMzni
         4SIBrex/1DpF4X2ieQFR18ORpZDkUZZ4/jJG51g1n8a2DCXWxXWBNEUO445g+xvQxG3r
         ZYGKpOSi3j251UPTv+4v3y99LtOniPLV79FBnhV0kgk+vLzFe/lBc68p0GIGg+MC3MDK
         /Yi0ArFLRfUh9HOjNNsOgtueVIVs3NDhdJ2k97FNPxB1vvF8xcCGiI8tD9XmwbeSlfTc
         coYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=lQ+kH+8OcyY0c8JYG72kvfeQsmfca58t7L4uorcaVGM=;
        b=mO1FwS43FftOBizBz60Sq6RnPUhZjddA2K9tHncKzryIYOXcCQI3Lx7wmtWO2enw/w
         mAEEnMaV2z9uImfRamYPGnnFTpoY8uhfxR6RkBK23WclmHiVp8NJVvxA62s7AQ6pRCM9
         NbuhiPN67BlZe9IjkHKW+WFuttVkZg1IyPAl0qyApd7mysMgxms/5y24jN9T8SCJAwK9
         D2tH7X+4IKxI1511KM3sxJo8kFOZCaoYizxzVm8McP1DViluslmVQ8hhfWbVLdFEeTk8
         7YzqzNy82iiCEn9eHuQSk56cLsADFUnQMuTxQDUzNsB8BbDDk+OPugpgmFhrpA1pnokp
         l1Cg==
X-Gm-Message-State: APjAAAVhtGzwA8vu//jHATK4kFWUePxpMQIdvvCAKkuMqUqGVlqPVNcZ
        WCbvFhGxHp58wAbnTWaeiyPcFw==
X-Google-Smtp-Source: APXvYqyBmr+Lzsm4/mh9XTKT8ZZbwyUyCiiwkdjHz6yVHf2At2LeK/udBwT33alRB5RzAif+CCgxqA==
X-Received: by 2002:adf:d081:: with SMTP id y1mr4067653wrh.34.1561557091538;
        Wed, 26 Jun 2019 06:51:31 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id h21sm2991135wmb.47.2019.06.26.06.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 06:51:30 -0700 (PDT)
Message-ID: <5d137862.1c69fb81.609f3.fa81@mx.google.com>
Date:   Wed, 26 Jun 2019 06:51:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.130-2-g2f84eb215456
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20190626083606.248422423@linuxfoundation.org>
References: <20190626083606.248422423@linuxfoundation.org>
Subject: Re: [PATCH 4.14 0/1] 4.14.131-stable review
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

stable-rc/linux-4.14.y boot: 129 boots: 2 failed, 127 passed (v4.14.130-2-g=
2f84eb215456)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.130-2-g2f84eb215456/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.130-2-g2f84eb215456/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.130-2-g2f84eb215456
Git Commit: 2f84eb215456bfd772fc0d9efc8446a66a3faa1b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 68 unique boards, 24 SoC families, 15 builds out of 201

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          sun7i-a20-bananapi:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.14.1=
29-52-g57f3c9aebc30 - first fail: v4.14.130)

    sunxi_defconfig:
        gcc-8:
          sun7i-a20-bananapi:
              lab-baylibre-seattle: failing since 1 day (last pass: v4.14.1=
29-52-g57f3c9aebc30 - first fail: v4.14.130)

Boot Failures Detected:

arm:
    sunxi_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

    multi_v7_defconfig:
        gcc-8:
            sun7i-a20-bananapi: 1 failed lab

---
For more info write to <info@kernelci.org>
