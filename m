Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4285A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="eudjB1x9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfCZKXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:23:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38823 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCZKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:23:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so6228376wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=B/XU/aVRTl/nhhXr7u3qGKAsBDGIywkps16bjkANzsA=;
        b=eudjB1x9f3Ctq8nzfMXAqqNoWyaWlmLFxGZn8gFUuFG3tKiSXaCSLQ+sv+pJqkbzhn
         g4ue2oOnQ+5bm4N9pNu1y7APB0IrGGv38U64hajplEebbLcLy8aKrznMALqnyPlZKOlR
         QmcqHO7DEWONZqNHmXpmoWr3kzxgamDCBLGvc7CmNCjJTlhLOZju981qniYKh7Pf3l5b
         l87XzGOVFKFhh7DYoI+4c/n4OjfUuUkhJv6wOjXS3tQZH4ntXaPV6w0nxXcM9WUwRvs6
         lw+VGjRjUOFfuwZtVQTNa8Tt7CWY91jXJK8DZcdWejvZfmaOH2lhtI9Z6mTrmdiRJ28U
         VYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=B/XU/aVRTl/nhhXr7u3qGKAsBDGIywkps16bjkANzsA=;
        b=dGuhgwID6Ah/pvJj4RZ6mS5OZRSo9cyYAU1Q1075z1Aya+VNc2qzAjHjJWkJqmb4P/
         SYeFaxxTVIHIhx7rf+npw94rjQayHwYIAm0aB2dOS+K+KkStkrDZtjfiZBLljzCAKikm
         Tm3qYHK8BtN9QWbNaLJW9/y5hCWt7ke6jj+wtT8apDQe+2bZkv74Kye2BlcIs7cFdjZU
         eoYvRYgp/6NGj9sGbD14+E8NpySz9r8q7XE7pjudD83avPmu9Og8DKQSXnI2LMIkzUxB
         8OjwEiJMuR5LlpuK9gb25yZiqDXvhfv4C1wDvLKJWPzsV4Azei8XAkXqKCL4NFAU5Kon
         v5Qw==
X-Gm-Message-State: APjAAAWDhkgyMF0N6RaHHOxl8cqmLcE6iVhTJZweqJ9ZR2KBSABE4NAV
        YFwHQ/Yd6sH/hlS+anFpbX7ZsQ==
X-Google-Smtp-Source: APXvYqz0OFldp5sm1aNNplQcBmnFt9qpNdmCKVRANvXbNSnE9DPjjCB+YHE/fw75ygzQyeRx4Np90Q==
X-Received: by 2002:adf:afd7:: with SMTP id y23mr18391481wrd.254.1553595815605;
        Tue, 26 Mar 2019 03:23:35 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v14sm24105214wrr.20.2019.03.26.03.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:23:34 -0700 (PDT)
Message-ID: <5c99fda6.1c69fb81.c4a8a.62e1@mx.google.com>
Date:   Tue, 26 Mar 2019 03:23:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.31-45-ge47f4c0ee31a
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/45] 4.19.32-stable review
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

stable-rc/linux-4.19.y boot: 94 boots: 0 failed, 82 passed with 12 offline =
(v4.19.31-45-ge47f4c0ee31a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.31-45-ge47f4c0ee31a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.31-45-ge47f4c0ee31a/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.31-45-ge47f4c0ee31a
Git Commit: e47f4c0ee31a24ecdab103f2d57cbdd5ed345804
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 58 unique boards, 24 SoC families, 14 builds out of 206

Offline Platforms:

arm:

    tegra_defconfig:
        gcc-7
            tegra124-jetson-tk1: 1 offline lab

    bcm2835_defconfig:
        gcc-7
            bcm2835-rpi-b: 1 offline lab

    sunxi_defconfig:
        gcc-7
            sun5i-r8-chip: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            alpine-db: 1 offline lab
            at91-sama5d4_xplained: 1 offline lab
            socfpga_cyclone5_de0_sockit: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            tegra124-jetson-tk1: 1 offline lab

    sama5_defconfig:
        gcc-7
            at91-sama5d4_xplained: 1 offline lab

arm64:

    defconfig:
        gcc-7
            apq8016-sbc: 1 offline lab
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

---
For more info write to <info@kernelci.org>
