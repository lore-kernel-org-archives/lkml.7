Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348E6C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C9420879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="e7Ha0g8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbfEWXId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 19:08:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387705AbfEWXIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 19:08:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so4093576wrn.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=bPH3BKB6YMkWMTZRYGJlA8guuTm5AAVhzev7JKBdXCo=;
        b=e7Ha0g8xc9v1LTknRwftMng/lhlKb2iA9bKmL87JD13f3YFWnxQGyk7tPRBzHBW4Nu
         bsz4O9nIFnWtmc4rPFgeWSgluPiHWx8E09fg+15v6wSO3Iyw1OzQuJYUx6ugl+IJS1LX
         o0vURM3AGLSNqWolOpKAN0teLr5ec/kWxp9DFT2vOXn+clAFh/k8rH9lbOYhROcD7Qyp
         iz7Oog9NxvOePWkp7hoGFAAsijNURr5x7tM8NioaXyh5RHE7WNNdEGkk7qUYp7+4FJve
         XWl0t1Wjc383i6m1Ue4G8u3++u2s6Inzn1YXSBD/FXh2/ic3PK8qvCG7GkHsEU/iCm+R
         rACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=bPH3BKB6YMkWMTZRYGJlA8guuTm5AAVhzev7JKBdXCo=;
        b=TVCnkFo6t+PEZJq6L4gVXD7ResfPmjiyycxyecboyr2db+tQDqS505qg5lu6RErfja
         tBIt9u3ABfAfy4+FCLZ72yvrEHPKU5/SJVsm/9C0lACBK/nZT/BDRetZ0aYUFX2BeeI7
         upKJ9sIB/heLRIRCE0qxItd8Epi+5NLEtXGTPWqg3RafjM96JSWNhF1tQLy3n7DCqxVd
         EqBelJ9ny6zicqKpI9yrTaGaEJTCsnTNbEMjyuojbvV/6GnrAzrsRvU5Wr5a/aENTwes
         zgdVFfcZd3TWrRrTmO5QUuSPd7yH++ACMAqZ4uI8ky9upurgAA5sSwPb2Dogs+QUfLBv
         oqbw==
X-Gm-Message-State: APjAAAU85fbAHyMVZJAdDkoe2mWL7wkK0ftTuTSowoJF2mu44MObWtWh
        iw2JOpSYfkBH6mnS/l+SK95vnw==
X-Google-Smtp-Source: APXvYqz/rwj1NpP2dQVZSlxWek0GWv4coeZZgk8975XxJoLAVYxqJg1vpVhFR8CTjwa8i5ihvZNk2w==
X-Received: by 2002:adf:f7c8:: with SMTP id a8mr3447844wrq.148.1558652911164;
        Thu, 23 May 2019 16:08:31 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id s13sm464813wrw.17.2019.05.23.16.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 16:08:30 -0700 (PDT)
Message-ID: <5ce727ee.1c69fb81.fbeca.2a40@mx.google.com>
Date:   Thu, 23 May 2019 16:08:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.1.y
X-Kernelci-Kernel: v5.1.4-123-gad8ad5ad6200
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
Subject: Re: [PATCH 5.1 000/122] 5.1.5-stable review
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

stable-rc/linux-5.1.y boot: 138 boots: 1 failed, 121 passed with 14 offline=
, 2 untried/unknown (v5.1.4-123-gad8ad5ad6200)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.4-123-gad8ad5ad6200/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.4-123-gad8ad5ad6200/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.4-123-gad8ad5ad6200
Git Commit: ad8ad5ad6200a933bc774415620bb31dd8b2da66
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 76 unique boards, 24 SoC families, 14 builds out of 209

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab

Offline Platforms:

arm:

    sama5_defconfig:
        gcc-8
            at91-sama5d4_xplained: 1 offline lab
            at91-sama5d4ek: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            at91-sama5d4ek: 1 offline lab
            stih410-b2120: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab

    tegra_defconfig:
        gcc-8
            tegra124-jetson-tk1: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

arm64:

    defconfig:
        gcc-8
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
