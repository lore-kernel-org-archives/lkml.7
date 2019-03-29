Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B79C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9651B2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfC2OYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:24:42 -0400
Received: from foss.arm.com ([217.140.101.70]:33062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfC2OYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:24:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31C75A78;
        Fri, 29 Mar 2019 07:24:38 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D18143F557;
        Fri, 29 Mar 2019 07:24:37 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 326E06822CD; Fri, 29 Mar 2019 14:24:36 +0000 (GMT)
Date:   Fri, 29 Mar 2019 14:24:36 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Sean Paul <sean@poorly.run>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2] drm: prefix header search paths with $(srctree)/
Message-ID: <20190329142436.GQ21747@e110455-lin.cambridge.arm.com>
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 08:32:41PM +0900, Masahiro Yamada wrote:
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
> 
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
> -	-I$(src)/../include \
> -	-I$(src)
> +	-I $(srctree)/$(src)/../include \
> +	-I $(srctree)/$(src)
>  
>  komeda-y := \
>  	komeda_drv.o \

For komeda:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I'm assuming the series in going to be merged into one go, so I don't
have to take the individual patch in my tree, but if I'm wrong please
let me know.

Best regards,
Liviu

> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
> index 271fb46..ea8324a 100644
> --- a/drivers/gpu/drm/i915/gvt/Makefile
> +++ b/drivers/gpu/drm/i915/gvt/Makefile
> @@ -5,5 +5,5 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
>  	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
>  	fb_decoder.o dmabuf.o page_track.o
>  
> -ccflags-y				+= -I$(src) -I$(src)/$(GVT_DIR)
> +ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
>  i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
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
>  	adreno/adreno_device.o \
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
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
