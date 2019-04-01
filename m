Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F81E213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k94qkIGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbfDAIYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:24:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32798 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731861AbfDAIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:24:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so14906410wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zeQriVBk+3+lOUuU3ew3p0rYdNBjC9AhzUs7EUs8bW8=;
        b=k94qkIGXIMw30xsoa7W7AYcD5wjDmCyrwpYEdbJnVv2SCZE/gMXG6dE4Eftj41hbyj
         JhiswG3D4ct4pZaWimQ9eb38in3++EPDewkravMu5WV5t5J+JHvZOek0S5mVz+ikry9L
         3ttpxWXx+G6ytceZH36QvCgsJSJRlFEI3DApZ4zd3aCy9pMNKK2DqeB29tPCEcjZ8eoe
         S7DYvOFB7dNHMhG/hhiMaXTzUsbZCuIcQHimLhYcgG4Q131EnD4cgvN+Hk/kuBYH7agc
         IuBM7Wr3hhkaefzMcqkilf3X3AiWN37RAXkYcZrRJuyO0ac3W9we/s1IlSQnG6x+Ax6G
         2fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zeQriVBk+3+lOUuU3ew3p0rYdNBjC9AhzUs7EUs8bW8=;
        b=Qult0eof8L0sIxYrh099YG+Vd+L2FIqzAyP0BWePXQrWNC16fPNHeIL7YSUYG3SZBm
         7xDQTuvqu6gIW/91L+YCNZ/UkaSMc7h91VN8L2NPd611nsXhNTfiN/XeBLlpp1MXQQU1
         5shE0HFEeOsVs1j5bC2sh6TgqBDsxX4ELYW3iwaf6mJlNtLZBDQfZxe/RyL34R3Lakns
         n/yLxybVvlmV+N43I9XTWeBPmOTwXMfhWtM2svqQQHuVqhFd28s5QbkolrPaJqSmlUm5
         TOgiI2gWEP7/lrrdrvIx2NIuQWi30QeOciLP92Y3LfMKkViTrDkMCNFfEla5Sp1bY6hP
         cerA==
X-Gm-Message-State: APjAAAWCy0Rz6jHIPx8K5INQ1ZcfftYLlj7XX/mCT4oFtWQ6PLdz0Yap
        AlVhwodqjfVqh/dTbMGVp2vx4A==
X-Google-Smtp-Source: APXvYqw1dS/X2kz/gGC9zyK5QME5Q1LpLHTpOjRQBfMznONj6wlIEDDa7DdL7aYhbpxJb6c83Fy8vQ==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr4353665wma.71.1554107086133;
        Mon, 01 Apr 2019 01:24:46 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a6sm7664956wrp.49.2019.04.01.01.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 01:24:45 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <40a521b3-a99c-2cd3-f3ac-cfec873fc934@baylibre.com>
Date:   Mon, 1 Apr 2019 10:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401074730.12241-4-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 09:47, Rob Herring wrote:
> This adds the initial driver for panfrost which supports Arm Mali
> Midgard and Bifrost family of GPUs. Currently, only the T860 and
> T760 Midgard GPUs have been tested.
> 
> v2:
> - Add GPU reset on job hangs (Tomeu)
> - Add RuntimePM and devfreq support (Tomeu)
> - Fix T760 support (Tomeu)
> - Add a TODO file (Rob, Tomeu)
> - Support multiple in fences (Tomeu)
> - Drop support for shared fences (Tomeu)
> - Fill in MMU de-init (Rob)
> - Move register definitions back to single header (Rob)
> - Clean-up hardcoded job submit todos (Rob)
> - Implement feature setup based on features/issues (Rob)
> - Add remaining Midgard DT compatible strings (Rob)
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Neil, I've kept your reset support separate for now. Let me know if you
> prefer me to squash it or keep it separate.

You can squash all my changes and add my sign-off.

Neil

> 
>  drivers/gpu/drm/Kconfig                      |   2 +
>  drivers/gpu/drm/Makefile                     |   1 +
>  drivers/gpu/drm/panfrost/Kconfig             |  14 +
>  drivers/gpu/drm/panfrost/Makefile            |  12 +
>  drivers/gpu/drm/panfrost/TODO                |  27 +
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c  | 191 +++++++
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h  |  14 +
>  drivers/gpu/drm/panfrost/panfrost_device.c   | 227 ++++++++
>  drivers/gpu/drm/panfrost/panfrost_device.h   | 118 ++++
>  drivers/gpu/drm/panfrost/panfrost_drv.c      | 484 ++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_features.h | 309 +++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gem.c      |  92 +++
>  drivers/gpu/drm/panfrost/panfrost_gem.h      |  29 +
>  drivers/gpu/drm/panfrost/panfrost_gpu.c      | 374 +++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.h      |  19 +
>  drivers/gpu/drm/panfrost/panfrost_issues.h   | 176 ++++++
>  drivers/gpu/drm/panfrost/panfrost_job.c      | 556 +++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_job.h      |  51 ++
>  drivers/gpu/drm/panfrost/panfrost_mmu.c      | 366 ++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_mmu.h      |  17 +
>  drivers/gpu/drm/panfrost/panfrost_regs.h     | 298 ++++++++++
>  include/uapi/drm/panfrost_drm.h              | 140 +++++
>  22 files changed, 3517 insertions(+)
>  create mode 100644 drivers/gpu/drm/panfrost/Kconfig
>  create mode 100644 drivers/gpu/drm/panfrost/Makefile
>  create mode 100644 drivers/gpu/drm/panfrost/TODO
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_features.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_issues.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_regs.h
>  create mode 100644 include/uapi/drm/panfrost_drm.h
> 
[...]
