Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5453BC3A5AA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B73621881
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PtzQ86lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfIEAi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:38:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43488 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIEAi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:38:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so390161pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DVY4kpFPkpbcHQ9NAk49JOazH2N2FonoDOdWz04IiHo=;
        b=PtzQ86lXn7C+yDBHRJ0jHmYnma1VFTuU6wVHR269sP/KRDxZ97XH9fxVzaCGSmDLEY
         L7R+9ARrtkaaRQOdsCgUxNvCiBVlwN51D6YZNFDdb0mww58iwfp1rpXpBvt0/rjd6+3F
         y7vv6BgiT7cYoNMdiWGwsPhh9e4FxM79wvUifJOOmrZ4UX79YXdZiqCJtDVf7GSgEEgg
         UdrMOXQ0XCiGx6rOKwtxohUaYh7qqB3agA55e84UUkEjeJV0tqJIkeL9AfmUlEQSK4Wk
         VR+e6jndIMPJqlAeUKyEb0PAMDD8aDQ8zFTzT+UVZZmADiJiyFrgBKkRboqCCl/e+Cqk
         Xv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DVY4kpFPkpbcHQ9NAk49JOazH2N2FonoDOdWz04IiHo=;
        b=rrfl8T/zu7pYPfkXXbfxYUDrZNESXt7CJava2qiyM9NKfiZP1Kv8Ws2dPozCyvHFsm
         Ry8X74zzk7B35yojPReUgdFJ36t9oJ2s3Di+LKDM6JFrqhJbGvfwuvkJyVF8NZCX/C0M
         Jwr6Bnbm6rAGjA9Sk+fXY+rT/qS61CAbogO8+BLHF0sMfhz90teqULtIjPhoDb84QdXE
         8yr0Cmp3RSdvwR29CJq2ZsupQ1TL0PfKNjcW532p/AZPGLsQw+x/q3LbybPSZ2RkpmOh
         Foya8x0Xn65b2cIAOQzA4eNkqZTQ3h2ETbAMWSZhRiWqdLUa4VzG7Cx/mC2J9DnlVn7F
         Z43A==
X-Gm-Message-State: APjAAAV5WRAL/yQENPlE0uZhwn1v3/1J9caOsxkljP9sDSmS+5UDjUVE
        yV+8DtbCX5oqd/zJc83cJR2gNA==
X-Google-Smtp-Source: APXvYqw1YBLv+apopZTVFjiJBpcYNNpIx9+SE/LIGS1HxCffXdm+0GlrhcfziABNqxx+Imc0YLlkPA==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr509672plr.201.1567643936245;
        Wed, 04 Sep 2019 17:38:56 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w11sm262656pfd.116.2019.09.04.17.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 17:38:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/57] 4.14.142-stable review
In-Reply-To: <5d705444.1c69fb81.c4927.1cd1@mx.google.com>
References: <20190904175301.777414715@linuxfoundation.org> <5d705444.1c69fb81.c4927.1cd1@mx.google.com>
Date:   Wed, 04 Sep 2019 17:38:55 -0700
Message-ID: <7hlfv3shk0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> stable-rc/linux-4.14.y boot: 144 boots: 5 failed, 131 passed with 8 offline (v4.14.141-58-g39a17ab1edd4)
>
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.14.y/kernel/v4.14.141-58-g39a17ab1edd4/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.141-58-g39a17ab1edd4/
>
> Tree: stable-rc
> Branch: linux-4.14.y
> Git Describe: v4.14.141-58-g39a17ab1edd4
> Git Commit: 39a17ab1edd4adb3fb732726a36cb54a21cc570d
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 68 unique boards, 23 SoC families, 14 builds out of 201
>
> Boot Failures Detected:
>
> arm:
>     vexpress_defconfig:
>         gcc-8:
>             qemu_arm-virt-gicv3: 5 failed labs

All 5 failures are for this same QEMU target in multiple labs

It is also failing in linux-next and on several other stable versions.

Under investigation, but smells like an actual regression.

Kevin
