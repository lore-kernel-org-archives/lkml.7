Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7550C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F4C20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="DOLVP6G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbfDXW0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:26:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42766 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbfDXWZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:25:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so27278646wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=krxqUk2AJFh2JoQBHcfUkOARW6PX1EGVkUooC7cLk1M=;
        b=DOLVP6G+vDBSbGXldf/tH6AlTt7/BFhaczmIoSmyfR2dE85HETc3OVGrcpSFaBLRAb
         EEiTwkySMO/njWa4YsVgz/yQFkp8T2Yo91LGKxrRu/owO/bQe9i1rXrT6yPnhMtUNPzv
         ejc5WgUE0GLEZpUY8Z/enB8VAkgA35gZVoe5JSGuLAA9KznBK4SDh/BeYzvkV7Zmbf1h
         OaD4tZmpKBvOS0lbeiiO72PmPzSorzvTnPcNqzsaYPe0a8VnJeysA++tc92+c4/Nw9NG
         5i1v5RrClqNaKok15c+vdYVaj0ddRuBGnsXFG3kgLrNuvWMxbJ1pGkCrUJKffZYZSaaH
         lX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=krxqUk2AJFh2JoQBHcfUkOARW6PX1EGVkUooC7cLk1M=;
        b=c1cWpgw7vfrcCDH7ONtchKe9L83JkP6E2VbZNpoXzHUAdsNbdKjySRfJ/XAOEi9/s0
         2DKeLieNsh+CoiCwKm+Gdp0wEVS/izrN63caXyvW1dXT4RpAVgig2QTIKAlwLzjJ4V5c
         i1v+GyEvLquawxrX7X2MuRIvc52zkyqbsZGGBWU/lpCeJGKj5T8/kBcgSgTtAk1hnNOW
         5Aoo7eL724kbP68OtxEafsTfbVnGiOjTXPol2uzlmxrizrjZ1bom/ELbYGUb1CbmKfqd
         AKvUwvDg+MtaFj+GAm/ViGy2GgVRNmbogYY2P+6i9VuddRqH8HG6ZNiTjcaBHEJxCSW8
         utkw==
X-Gm-Message-State: APjAAAVhPq8XMm1nEntFMAVGX7XmoXeRW/0Iw4V2syeXBAADjNF6ThPU
        jQCu0QU8Qa2PDoriECyiV9vXFe+jtVIXDw==
X-Google-Smtp-Source: APXvYqy6qwe78iF/XMv3gnFvpWzmHxFD5zzN09qLSHi99TU+SX8j3Fyxafyj75LA3eIHBXAtyk3YUA==
X-Received: by 2002:a5d:424e:: with SMTP id s14mr1122946wrr.77.1556144757228;
        Wed, 24 Apr 2019 15:25:57 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x192sm31490875wmf.48.2019.04.24.15.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:25:56 -0700 (PDT)
Message-ID: <5cc0e274.1c69fb81.75660.63a2@mx.google.com>
Date:   Wed, 24 Apr 2019 15:25:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.36-96-g16ede5319518
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/96] 4.19.37-stable review
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

stable-rc/linux-4.19.y boot: 112 boots: 0 failed, 101 passed with 10 offlin=
e, 1 untried/unknown (v4.19.36-96-g16ede5319518)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.36-96-g16ede5319518/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.36-96-g16ede5319518/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.36-96-g16ede5319518
Git Commit: 16ede5319518ed5379e1b00dc6f928d0aaccfc4b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 66 unique boards, 24 SoC families, 14 builds out of 206

Offline Platforms:

arm:

    davinci_all_defconfig:
        gcc-7
            da850-lcdk: 1 offline lab

    imx_v6_v7_defconfig:
        gcc-7
            vf610-colibri-eval-v3: 1 offline lab

    multi_v7_defconfig:
        gcc-7
            meson8b-odroidc1: 1 offline lab
            vf610-colibri-eval-v3: 1 offline lab

arm64:

    defconfig:
        gcc-7
            meson-gxbb-odroidc2: 1 offline lab
            meson-gxl-s905d-p230: 1 offline lab
            meson-gxl-s905x-nexbox-a95x: 1 offline lab
            meson-gxl-s905x-p212: 1 offline lab
            meson-gxm-nexbox-a1: 1 offline lab
            rk3399-firefly: 1 offline lab

---
For more info write to <info@kernelci.org>
