Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFDDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7E92067D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="bDUy7rKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfKSLmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:42:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40849 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfKSLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:42:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id q15so10623215wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=OOyHNGhYPbszP/8mSnotR0PXb3SjUUMEabHp4ztAP6I=;
        b=bDUy7rKbtjb6NpkeAFRGodcB7dkbrHjpJsxRfk0aHVSrFoE+DCl6H6I3Kc9o1ZHn0W
         AyuGpf+gv2fMRJVaajRmdMjjS/6grmflXFTTsJARUx2lhzGwpa41aIfU5kCev9WlE3/a
         FmD/DT66q8pTC2IcGNjsRJfBV8oLejbcmUSpER6nfD/7mEL100n+L7habdjQGU6YxUkG
         BI3YcAJmhR2sH5OPIryLfrtuWuvxhb2bsEg8nVZfA/0AzELbYcfULVHXwA1+PDosC4T1
         J6MDikCO72wizzIVVsnhrFjlGJaIGoYBQGRsw/rVMxEe5L7ifwbky2HZI2f7uGQ8Gj/W
         lhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=OOyHNGhYPbszP/8mSnotR0PXb3SjUUMEabHp4ztAP6I=;
        b=hy1cbxcWIKoKJFGoWJvDH6OX6+xaHB4c0RmZjqG2t4JBwj6eNxoDfZQRVfG5CzIJMd
         qTp31qoP0mCj8lxN+rzq4AE7KadCmh5h3C23O7Ot8pjh9hS3xy38jAcp8sKQJmymLG1u
         cGlZ1sMjuiBbgYjMO0HY1YzDoofbuFj6LYKDIxt1BTI7/S7tTh0HhZ6TZJpadPUk0JI7
         8ERN/cTlANKYVJaoxOhuJpqbWHnVH4v869ZRCBmDLIbygcCWyK+UfntsuyIfx7tcTuXC
         j6Ys8o0kkDpksJQQJ2QoBCCikE1/i8vPUn1JcQMDIpdsGPPmvPcU1BV93ULEJ4wL1N8E
         l9jw==
X-Gm-Message-State: APjAAAVpLQ9DLBlpQXHFZvDpBz/h3lBIbMJFGDd5W8OFAEY0h20HQFhR
        O1puLS2yZVP9zKQfdQfvkr7HiQ==
X-Google-Smtp-Source: APXvYqzZywequrqvYbutTtA8C6sH4Cqaze2jel3AuBlQqZj7i+42V1CSFgF0EG1wuu3Wy7K4iqz5Jg==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr18671988wrq.134.1574163728828;
        Tue, 19 Nov 2019 03:42:08 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y2sm2959327wmy.2.2019.11.19.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 03:42:08 -0800 (PST)
Message-ID: <5dd3d510.1c69fb81.33d46.e295@mx.google.com>
Date:   Tue, 19 Nov 2019 03:42:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.3.11-49-g0a89ac54e7d5
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
Subject: Re: [PATCH 5.3 00/48] 5.3.12-stable review
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

stable-rc/linux-5.3.y boot: 116 boots: 2 failed, 99 passed with 14 offline,=
 1 untried/unknown (v5.3.11-49-g0a89ac54e7d5)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.3.y/kernel/v5.3.11-49-g0a89ac54e7d5/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.3.y=
/kernel/v5.3.11-49-g0a89ac54e7d5/

Tree: stable-rc
Branch: linux-5.3.y
Git Describe: v5.3.11-49-g0a89ac54e7d5
Git Commit: 0a89ac54e7d5ea976ee9de1725c056faa5ba526f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 76 unique boards, 23 SoC families, 17 builds out of 208

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        gcc-8:
          bcm2835-rpi-b:
              lab-baylibre-seattle: new failure (last pass: v5.3.11)

    multi_v7_defconfig:
        gcc-8:
          sun8i-h2-plus-orangepi-r1:
              lab-baylibre: new failure (last pass: v5.3.11)

    sama5_defconfig:
        gcc-8:
          at91-sama5d4ek:
              lab-baylibre-seattle: new failure (last pass: v5.3.11)

    socfpga_defconfig:
        gcc-8:
          socfpga_cyclone5_de0_sockit:
              lab-baylibre-seattle: new failure (last pass: v5.3.11)

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905d-p230: 1 failed lab
            meson-gxm-khadas-vim2: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

arm:

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        gcc-8
            at91-sama5d4ek: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab
            at91-sama5d4ek: 1 offline lab
            bcm4708-smartrg-sr400ac: 1 offline lab
            mt7623n-bananapi-bpi-r2: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    socfpga_defconfig:
        gcc-8
            socfpga_cyclone5_de0_sockit: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

---
For more info write to <info@kernelci.org>
