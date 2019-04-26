Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D9CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E17206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZaYePW6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfDZBhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:37:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:25004 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDZBhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 21:37:53 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x3Q1baMl026223;
        Fri, 26 Apr 2019 10:37:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x3Q1baMl026223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556242657;
        bh=O0qtrKYIpIe7gV+LLpOkDIfO+YUShwi3bTDlZP6f+Mk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZaYePW6FXtZ2WAyQbaT4hqT/yeNXTdKaTfTOiT0O8Hx9L9Cx4GGRl4xE+sVbbFvFa
         ZrqAbuZ8gc4v3pW39wvWUEcBEizn8638aA8bO+iz+7IQdZhhyLUhFzS00Az2P+PJsZ
         BIc31sLYyXVjjsbbFNGmHlO2BqShoUhNoCxRoE0r4Dr0qNwevH/baBIWM7rYjDN8NS
         bCRV+pfAyvYj1nqiVIJOqdx82/oDZo1PmqceWbNjdpT7hdwWZX9O+V098yVsO4jCNI
         AvMGrlFP7F/fWVhYMWi2qTM623Fdoj9mOUmES5cqvleOfyobrjmRBuw2TZfJ1M603M
         8UaYqiwJWiXHg==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id l17so418296vke.7;
        Thu, 25 Apr 2019 18:37:36 -0700 (PDT)
X-Gm-Message-State: APjAAAXl1zG/oFwy3PIeL+GEUpibdRwy+M5uON8IIyug7PfNtsgOd7wd
        xU/wJySoGlx5oJ0PHXYY4B07AjHIh8bHo9ZnLCY=
X-Google-Smtp-Source: APXvYqzDEXMgtrlycT2Fi+pJzCVBZyg7pUCRh57e2jYq3aJETCucZ3BLMlFLrR9UryHRz/URhUy9KXlpnJiFh74sy8Y=
X-Received: by 2002:a1f:c288:: with SMTP id s130mr22999671vkf.0.1556242655887;
 Thu, 25 Apr 2019 18:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 26 Apr 2019 10:36:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR6bT93kmyPCzJg2ZFvk239nz0nyVX5z23G+8Y0Wiba1Q@mail.gmail.com>
Message-ID: <CAK7LNAR6bT93kmyPCzJg2ZFvk239nz0nyVX5z23G+8Y0Wiba1Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm: prefix header search paths with $(srctree)/
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Fri, Mar 29, 2019 at 8:37 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
>
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
>
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
>
> [1]: https://patchwork.kernel.org/patch/9632347/
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>
> I put all gpu/drm changes into a single patch because
> they are trivial conversion.
>
> If you are interested in the big picture of this work,
> the full patch set is available at the following URL.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test


Is somebody taking care of this?



>
> Changes in v2:
>   - fix up the new driver komeda
>   - Add Sam's Reviewed-by
>
>  drivers/gpu/drm/amd/amdgpu/Makefile         | 2 +-
>  drivers/gpu/drm/amd/lib/Makefile            | 2 +-
>  drivers/gpu/drm/arm/display/komeda/Makefile | 4 ++--
>  drivers/gpu/drm/i915/gvt/Makefile           | 2 +-
>  drivers/gpu/drm/msm/Makefile                | 6 +++---
>  drivers/gpu/drm/nouveau/Kbuild              | 8 ++++----
>  6 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 466da59..62bf9da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -23,7 +23,7 @@
>  # Makefile for the drm device driver.  This driver provides support for the
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>
> -FULL_AMD_PATH=$(src)/..
> +FULL_AMD_PATH=$(srctree)/$(src)/..
>  DISPLAY_FOLDER_NAME=display
>  FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>
> diff --git a/drivers/gpu/drm/amd/lib/Makefile b/drivers/gpu/drm/amd/lib/Makefile
> index 6902430..d534992 100644
> --- a/drivers/gpu/drm/amd/lib/Makefile
> +++ b/drivers/gpu/drm/amd/lib/Makefile
> @@ -27,6 +27,6 @@
>  # driver components or later moved to kernel/lib for sharing with
>  # other drivers.
>
> -ccflags-y := -I$(src)/../include
> +ccflags-y := -I $(srctree)/$(src)/../include
>
>  obj-$(CONFIG_CHASH) += chash.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
> index 1b875e5..a72e30c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  ccflags-y := \
> -       -I$(src)/../include \
> -       -I$(src)
> +       -I $(srctree)/$(src)/../include \
> +       -I $(srctree)/$(src)
>
>  komeda-y := \
>         komeda_drv.o \
> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
> index 271fb46..ea8324a 100644
> --- a/drivers/gpu/drm/i915/gvt/Makefile
> +++ b/drivers/gpu/drm/i915/gvt/Makefile
> @@ -5,5 +5,5 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
>         execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
>         fb_decoder.o dmabuf.o page_track.o
>
> -ccflags-y                              += -I$(src) -I$(src)/$(GVT_DIR)
> +ccflags-y                              += -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
>  i915-y                                 += $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 56a70c7..b7b1ebd 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ccflags-y := -Idrivers/gpu/drm/msm
> -ccflags-y += -Idrivers/gpu/drm/msm/disp/dpu1
> -ccflags-$(CONFIG_DRM_MSM_DSI) += -Idrivers/gpu/drm/msm/dsi
> +ccflags-y := -I $(srctree)/$(src)
> +ccflags-y += -I $(srctree)/$(src)/disp/dpu1
> +ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(srctree)/$(src)/dsi
>
>  msm-y := \
>         adreno/adreno_device.o \
> diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
> index ea3035e..4fae728 100644
> --- a/drivers/gpu/drm/nouveau/Kbuild
> +++ b/drivers/gpu/drm/nouveau/Kbuild
> @@ -1,7 +1,7 @@
> -ccflags-y += -I$(src)/include
> -ccflags-y += -I$(src)/include/nvkm
> -ccflags-y += -I$(src)/nvkm
> -ccflags-y += -I$(src)
> +ccflags-y += -I $(srctree)/$(src)/include
> +ccflags-y += -I $(srctree)/$(src)/include/nvkm
> +ccflags-y += -I $(srctree)/$(src)/nvkm
> +ccflags-y += -I $(srctree)/$(src)
>
>  # NVKM - HW resource manager
>  #- code also used by various userspace tools/tests
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
