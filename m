Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73FCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415C520717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="d7uQ07ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfKEBgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:36:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41326 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbfKEBgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:36:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so19333884wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 17:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=MrOlDfxhgdKSRKUgYFb9Fy5L5HVsLkB9rhBm7iOv9Tc=;
        b=d7uQ07aiPXuLRnZqRphuYrOgGGwk9be/+lzwXyfAd7r6w3ewE0W8ekRvUKKIUYsUUC
         k5nFf9F6vkIFhc8CcxkATHfPcDrczisbZvZPTff3leHc8TnQStUfQu5/RwF45aUyUJ/z
         AWNWxLpGzxb9ojlSvi1Eyo8xAzw2fewniVDExwq6AxGyBVp8dk3nT4s9cQ3vtqPuD7rK
         ksQ8lLF92FhLvQAmPhwh/c/oX+pNVwrFMIouyZ6qaKZOfGTv+ijRbaPkF/lujzDqFIfR
         A7VCEfIYtHLsYtE9abtZPkTLqf5NG2L/P5LAu0BzSBXBd4PDKJVl0NPa/USyhAYbZWjk
         EGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=MrOlDfxhgdKSRKUgYFb9Fy5L5HVsLkB9rhBm7iOv9Tc=;
        b=p2K5HhGL7gjIuCh8b15Nl51uYdEK5rmcUyDwrlzewrdGb49GV6paq/BgBK3aOhjKBj
         ZyMKaJBwQZJ5IQThlHJsbZj4FTWWEL6gutPsNWUaycSWgnJ4bl/s7zCYZ8+wGIdPIfe4
         us2wJv7jnvzlWpZBKS7Ti6NMyW1SxUbv0w0iqnT972CY/CSNJ06uwtj2G+/fQuTGnVCh
         PvhUQlmmQla1/HMbKQNpqOKGHv2bNMvJzPfApEDF7DNiSf87m339HpY4pKZDTuXEZSY8
         xWoYyscKOdNoeG/Jxv37cZ3sN2uCmBnCB75+VmUX/aPLolUvjN2zJHJCOj1oVtkGl0KL
         rvzg==
X-Gm-Message-State: APjAAAURvhNum4sJMyR90+nboN7wLZTNftOppAtD+nSeWj2s4MRuOWrQ
        mmj1DkwUWgUH/xjlNLs0yMzV8g==
X-Google-Smtp-Source: APXvYqyYxfdbh1/9dofrQWkZeO9DSAdg3DoDC7EaKlV4voBui4Gs2YOA9+nsgRIq5eJki5eE+gKJRA==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr11900054wrx.261.1572917801661;
        Mon, 04 Nov 2019 17:36:41 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y78sm11611048wmd.32.2019.11.04.17.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 17:36:40 -0800 (PST)
Message-ID: <5dc0d228.1c69fb81.c2076.47a9@mx.google.com>
Date:   Mon, 04 Nov 2019 17:36:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.198-47-g3849b8fee3c3
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/46] 4.4.199-stable review
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

stable-rc/linux-4.4.y boot: 80 boots: 0 failed, 72 passed with 7 offline, 1=
 conflict (v4.4.198-47-g3849b8fee3c3)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.198-47-g3849b8fee3c3/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.198-47-g3849b8fee3c3/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.198-47-g3849b8fee3c3
Git Commit: 3849b8fee3c31ec2cfef806e0e369ccbd50d0f1e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 41 unique boards, 17 SoC families, 13 builds out of 190

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu_x86_64:
            lab-collabora: PASS (gcc-8)
            lab-baylibre: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>
