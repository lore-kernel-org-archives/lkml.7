Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D6CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CDD218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCqbjvp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDLQ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:57:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36440 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:57:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so11832966wml.1;
        Fri, 12 Apr 2019 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lol+bU6xO8uE7RpO7FHJ2Mp7ebUeOBS/qYPks3uFmxY=;
        b=bCqbjvp8vlTCOWsLreH0CcCqI1fngu72Srjq8ogzX4uCtZ+WvDbaM4vSTtLIDqzLow
         Z9YthnybrZoM4f92Db+F3au1PuU4jZjhhtIlc6ub0JKzk2yuHLOa+cGyCs55QkCIbyED
         xMYbxjiqn9kWI9t43lWalrBE5MsTEkmJj2dxGzWmcWijWWkUy0cGWK6W0iDtkRnVcJ/E
         HiVYLJQxzHvxTUsKvspLT6whsVigDsxKTYiDNxZqyk5eInxI/r04cOq/C9KqZw6Ii0Ht
         /Z6EKkykrnKLCDHgUeTQvr6qho8zGCyDKne+MGwoG8gTV4DL/wEXcqFTIfaz1gjgUJvF
         IByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lol+bU6xO8uE7RpO7FHJ2Mp7ebUeOBS/qYPks3uFmxY=;
        b=QBBtdg/te2XLky1lR9/pLilnRCQxUi3abjE42Fq8SX7DhyqoN73Y8vl8/ZAttP9rsH
         ZqpAW+fbPGCd1JVOdYw+wyodW9J1fspDq+t36TZN58i+FKiJL+gzKK32+4Ic1lZmeTNa
         3FbiDwuLNHzirMNKQx1wlxlCGtz9FP9ViwoOoy6zTs2u2rXKuoR/2Bv568Sa+gpSs1CW
         rjMm1/VhfDSvjz+MlphY/mHC39ZURkLmpKDNdkvH2tugxUHdNvqkOnm43zicFlVJ3UYv
         iRn96zWKoSz5CtgKxxEVncNUGlQ+gN1m4DrtjKfX9zHO6kwaLqLZYpfUb43usJEMp+M6
         s/xw==
X-Gm-Message-State: APjAAAWKFIc6BsK7UGHmMDLao6u6SnFvLKWkcoC2oaUWmrRjBA2ddedD
        ZW79n9vmqEIOnno4g9SqF3ihhU+12ax5zBtduN8=
X-Google-Smtp-Source: APXvYqywq09olsVg2XcpYgnLyZQChWWmv/TwwYHygzgwQMhoTC/T7rPmtlQJ57hHzy0gXCbbWH82xdNMVjeOZDb9I9A=
X-Received: by 2002:a1c:7e55:: with SMTP id z82mr10909307wmc.11.1555088222401;
 Fri, 12 Apr 2019 09:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190412095608eucas1p29bce9e8a81c58c72c4b45c27138a826a@eucas1p2.samsung.com>
 <78400d66-a1c7-3688-0ffa-3e8c34cec34c@samsung.com>
In-Reply-To: <78400d66-a1c7-3688-0ffa-3e8c34cec34c@samsung.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Apr 2019 12:56:50 -0400
Message-ID: <CADnq5_PC7y8xRYVBiW2p99ix4oQW+A2f0Ynoh2ZGQd3QeS7x+Q@mail.gmail.com>
Subject: Re: [PATCH] drm: remove redundant 'default n' from Kconfig
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 5:56 AM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
>
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
>
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>
>         config FOO
>                 bool
>
>         config FOO
>                 bool
>                 default n
>
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>
for amdgpu and drm.

> ---
>  drivers/gpu/drm/Kconfig             |    5 -----
>  drivers/gpu/drm/amd/amdgpu/Kconfig  |    1 -
>  drivers/gpu/drm/arm/Kconfig         |    1 -
>  drivers/gpu/drm/exynos/Kconfig      |    2 --
>  drivers/gpu/drm/i915/Kconfig        |    3 ---
>  drivers/gpu/drm/i915/Kconfig.debug  |   13 -------------
>  drivers/gpu/drm/msm/Kconfig         |    2 --
>  drivers/gpu/drm/nouveau/Kconfig     |    2 --
>  drivers/gpu/drm/omapdrm/Kconfig     |    1 -
>  drivers/gpu/drm/omapdrm/dss/Kconfig |    6 ------
>  10 files changed, 36 deletions(-)
>
> Index: b/drivers/gpu/drm/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/Kconfig   2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/Kconfig   2019-04-12 11:42:30.066095359 +0200
> @@ -37,7 +37,6 @@ config DRM_DP_AUX_CHARDEV
>
>  config DRM_DEBUG_MM
>         bool "Insert extra checks and debug info into the DRM range managers"
> -       default n
>         depends on DRM=y
>         depends on STACKTRACE_SUPPORT
>         select STACKDEPOT
> @@ -56,7 +55,6 @@ config DRM_DEBUG_SELFTEST
>         select PRIME_NUMBERS
>         select DRM_LIB_RANDOM
>         select DRM_KMS_HELPER
> -       default n
>         help
>           This option provides kernel modules that can be used to run
>           various selftests on parts of the DRM api. This option is not
> @@ -113,7 +111,6 @@ config DRM_FBDEV_OVERALLOC
>  config DRM_FBDEV_LEAK_PHYS_SMEM
>         bool "Shamelessly allow leaking of fbdev physical address (DANGEROUS)"
>         depends on DRM_FBDEV_EMULATION && EXPERT
> -       default n
>         help
>           In order to keep user-space compatibility, we want in certain
>           use-cases to keep leaking the fbdev physical address to the
> @@ -247,7 +244,6 @@ config DRM_VKMS
>         tristate "Virtual KMS (EXPERIMENTAL)"
>         depends on DRM
>         select DRM_KMS_HELPER
> -       default n
>         help
>           Virtual Kernel Mode-Setting (VKMS) is used for testing or for
>           running GPU in a headless machines. Choose this option to get
> @@ -424,4 +420,3 @@ config DRM_PANEL_ORIENTATION_QUIRKS
>
>  config DRM_LIB_RANDOM
>         bool
> -       default n
> Index: b/drivers/gpu/drm/amd/amdgpu/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig        2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig        2019-04-12 11:42:30.066095359 +0200
> @@ -35,7 +35,6 @@ config DRM_AMDGPU_GART_DEBUGFS
>         bool "Allow GART access through debugfs"
>         depends on DRM_AMDGPU
>         depends on DEBUG_FS
> -       default n
>         help
>           Selecting this option creates a debugfs file to inspect the mapped
>           pages. Uses more memory for housekeeping, enable only for debugging.
> Index: b/drivers/gpu/drm/arm/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/arm/Kconfig       2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/arm/Kconfig       2019-04-12 11:42:30.066095359 +0200
> @@ -16,7 +16,6 @@ config DRM_HDLCD
>  config DRM_HDLCD_SHOW_UNDERRUN
>         bool "Show underrun conditions"
>         depends on DRM_HDLCD
> -       default n
>         help
>           Enable this option to show in red colour the pixels that the
>           HDLCD device did not fetch from framebuffer due to underrun
> Index: b/drivers/gpu/drm/exynos/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/exynos/Kconfig    2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/exynos/Kconfig    2019-04-12 11:42:30.066095359 +0200
> @@ -46,7 +46,6 @@ config DRM_EXYNOS_DPI
>         bool "Parallel output"
>         depends on DRM_EXYNOS_FIMD
>         select DRM_PANEL
> -       default n
>         help
>           This enables support for Exynos parallel output.
>
> @@ -55,7 +54,6 @@ config DRM_EXYNOS_DSI
>         depends on DRM_EXYNOS_FIMD || DRM_EXYNOS5433_DECON || DRM_EXYNOS7_DECON
>         select DRM_MIPI_DSI
>         select DRM_PANEL
> -       default n
>         help
>           This enables support for Exynos MIPI-DSI device.
>
> Index: b/drivers/gpu/drm/i915/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/i915/Kconfig      2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/i915/Kconfig      2019-04-12 11:42:30.066095359 +0200
> @@ -45,7 +45,6 @@ config DRM_I915
>  config DRM_I915_ALPHA_SUPPORT
>         bool "Enable alpha quality support for new Intel hardware by default"
>         depends on DRM_I915
> -       default n
>         help
>           Choose this option if you have new Intel hardware and want to enable
>           the alpha quality i915 driver support for the hardware in this kernel
> @@ -99,7 +98,6 @@ config DRM_I915_GVT
>          bool "Enable Intel GVT-g graphics virtualization host support"
>          depends on DRM_I915
>          depends on 64BIT
> -        default n
>          help
>           Choose this option if you want to enable Intel GVT-g graphics
>           virtualization technology host support with integrated graphics.
> @@ -123,7 +121,6 @@ config DRM_I915_GVT_KVMGT
>         depends on DRM_I915_GVT
>         depends on KVM
>         depends on VFIO_MDEV && VFIO_MDEV_DEVICE
> -       default n
>         help
>           Choose this option if you want to enable KVMGT support for
>           Intel GVT-g.
> Index: b/drivers/gpu/drm/i915/Kconfig.debug
> ===================================================================
> --- a/drivers/gpu/drm/i915/Kconfig.debug        2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/i915/Kconfig.debug        2019-04-12 11:42:30.066095359 +0200
> @@ -6,7 +6,6 @@ config DRM_I915_WERROR
>          # We use the dependency on !COMPILE_TEST to not be enabled in
>          # allmodconfig or allyesconfig configurations
>          depends on !COMPILE_TEST
> -        default n
>          help
>            Add -Werror to the build flags for (and only for) i915.ko.
>            Do not enable this unless you are writing code for the i915.ko module.
> @@ -31,7 +30,6 @@ config DRM_I915_DEBUG
>         select DRM_I915_SW_FENCE_DEBUG_OBJECTS
>         select DRM_I915_SELFTEST
>         select DRM_I915_DEBUG_RUNTIME_PM
> -        default n
>          help
>            Choose this option to turn on extra driver debugging that may affect
>            performance but will catch some internal issues.
> @@ -42,7 +40,6 @@ config DRM_I915_DEBUG
>
>  config DRM_I915_DEBUG_GEM
>          bool "Insert extra checks into the GEM internals"
> -        default n
>          depends on DRM_I915_WERROR
>          help
>            Enable extra sanity checks (including BUGs) along the GEM driver
> @@ -54,7 +51,6 @@ config DRM_I915_DEBUG_GEM
>
>  config DRM_I915_ERRLOG_GEM
>         bool "Insert extra logging (very verbose) for common GEM errors"
> -       default n
>         depends on DRM_I915_DEBUG_GEM
>         help
>           Enable additional logging that may help track down the cause of
> @@ -68,7 +64,6 @@ config DRM_I915_TRACE_GEM
>         bool "Insert extra ftrace output from the GEM internals"
>         depends on DRM_I915_DEBUG_GEM
>         select TRACING
> -       default n
>         help
>           Enable additional and verbose debugging output that will spam
>           ordinary tests, but may be vital for post-mortem debugging when
> @@ -82,7 +77,6 @@ config DRM_I915_SW_FENCE_DEBUG_OBJECTS
>          bool "Enable additional driver debugging for fence objects"
>          depends on DRM_I915
>          select DEBUG_OBJECTS
> -        default n
>          help
>            Choose this option to turn on extra driver debugging that may affect
>            performance but will catch some internal issues.
> @@ -94,7 +88,6 @@ config DRM_I915_SW_FENCE_DEBUG_OBJECTS
>  config DRM_I915_SW_FENCE_CHECK_DAG
>          bool "Enable additional driver debugging for detecting dependency cycles"
>          depends on DRM_I915
> -        default n
>          help
>            Choose this option to turn on extra driver debugging that may affect
>            performance but will catch some internal issues.
> @@ -106,7 +99,6 @@ config DRM_I915_SW_FENCE_CHECK_DAG
>  config DRM_I915_DEBUG_GUC
>          bool "Enable additional driver debugging for GuC"
>          depends on DRM_I915
> -        default n
>          help
>            Choose this option to turn on extra driver debugging that may affect
>            performance but will help resolve GuC related issues.
> @@ -118,7 +110,6 @@ config DRM_I915_DEBUG_GUC
>  config DRM_I915_SELFTEST
>         bool "Enable selftests upon driver load"
>         depends on DRM_I915
> -       default n
>         select FAULT_INJECTION
>         select PRIME_NUMBERS
>         help
> @@ -135,7 +126,6 @@ config DRM_I915_SELFTEST_BROKEN
>         bool "Enable broken and dangerous selftests"
>         depends on DRM_I915_SELFTEST
>         depends on BROKEN
> -       default n
>         help
>           This option enables the execution of selftests that are "dangerous"
>           and may trigger unintended HW side-effects as they break strict
> @@ -148,7 +138,6 @@ config DRM_I915_SELFTEST_BROKEN
>  config DRM_I915_LOW_LEVEL_TRACEPOINTS
>          bool "Enable low level request tracing events"
>          depends on DRM_I915
> -        default n
>          help
>            Choose this option to turn on low level request tracing events.
>            This provides the ability to precisely monitor engine utilisation
> @@ -159,7 +148,6 @@ config DRM_I915_LOW_LEVEL_TRACEPOINTS
>  config DRM_I915_DEBUG_VBLANK_EVADE
>         bool "Enable extra debug warnings for vblank evasion"
>         depends on DRM_I915
> -       default n
>         help
>           Choose this option to turn on extra debug warnings for the
>           vblank evade mechanism. This gives a warning every time the
> @@ -172,7 +160,6 @@ config DRM_I915_DEBUG_VBLANK_EVADE
>  config DRM_I915_DEBUG_RUNTIME_PM
>         bool "Enable extra state checking for runtime PM"
>         depends on DRM_I915
> -       default n
>         select STACKDEPOT
>         help
>           Choose this option to turn on extra state checking for the
> Index: b/drivers/gpu/drm/msm/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/msm/Kconfig       2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/msm/Kconfig       2019-04-12 11:42:30.066095359 +0200
> @@ -24,7 +24,6 @@ config DRM_MSM
>  config DRM_MSM_REGISTER_LOGGING
>         bool "MSM DRM register logging"
>         depends on DRM_MSM
> -       default n
>         help
>           Compile in support for logging register reads/writes in a format
>           that can be parsed by envytools demsm tool.  If enabled, register
> @@ -33,7 +32,6 @@ config DRM_MSM_REGISTER_LOGGING
>  config DRM_MSM_GPU_SUDO
>         bool "Enable SUDO flag on submits"
>         depends on DRM_MSM && EXPERT
> -       default n
>         help
>           Enable userspace that has CAP_SYS_RAWIO to submit GPU commands
>           that are run from RB instead of IB1.  This essentially gives
> Index: b/drivers/gpu/drm/nouveau/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/nouveau/Kconfig   2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/nouveau/Kconfig   2019-04-12 11:43:25.998096767 +0200
> @@ -60,7 +60,6 @@ config NOUVEAU_DEBUG_DEFAULT
>  config NOUVEAU_DEBUG_MMU
>         bool "Enable additional MMU debugging"
>         depends on DRM_NOUVEAU
> -       default n
>         help
>           Say Y here if you want to enable verbose MMU debug output.
>
> @@ -79,7 +78,6 @@ config DRM_NOUVEAU_SVM
>         depends on STAGING
>         select HMM_MIRROR
>         select DEVICE_PRIVATE
> -       default n
>         help
>           Say Y here if you want to enable experimental support for
>           Shared Virtual Memory (SVM).
> Index: b/drivers/gpu/drm/omapdrm/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/omapdrm/Kconfig   2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/omapdrm/Kconfig   2019-04-12 11:42:30.070095359 +0200
> @@ -4,7 +4,6 @@ config DRM_OMAP
>         depends on ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
>         select OMAP2_DSS
>         select DRM_KMS_HELPER
> -       default n
>         help
>           DRM display driver for OMAP2/3/4 based boards.
>
> Index: b/drivers/gpu/drm/omapdrm/dss/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/omapdrm/dss/Kconfig       2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/omapdrm/dss/Kconfig       2019-04-12 11:42:30.070095359 +0200
> @@ -17,7 +17,6 @@ if OMAP2_DSS
>
>  config OMAP2_DSS_DEBUG
>         bool "Debug support"
> -       default n
>         help
>           This enables printing of debug messages. Alternatively, debug messages
>           can also be enabled by setting CONFIG_DYNAMIC_DEBUG and then setting
> @@ -26,7 +25,6 @@ config OMAP2_DSS_DEBUG
>  config OMAP2_DSS_DEBUGFS
>         bool "Debugfs filesystem support"
>         depends on DEBUG_FS
> -       default n
>         help
>           This enables debugfs for OMAPDSS at <debugfs>/omapdss. This enables
>           querying about clock configuration and register configuration of dss,
> @@ -35,7 +33,6 @@ config OMAP2_DSS_DEBUGFS
>  config OMAP2_DSS_COLLECT_IRQ_STATS
>         bool "Collect DSS IRQ statistics"
>         depends on OMAP2_DSS_DEBUGFS
> -       default n
>         help
>           Collect DSS IRQ statistics, printable via debugfs.
>
> @@ -75,7 +72,6 @@ config OMAP4_DSS_HDMI_CEC
>
>  config OMAP5_DSS_HDMI
>         bool "HDMI support for OMAP5"
> -       default n
>         select OMAP2_DSS_HDMI_COMMON
>         help
>           HDMI Interface for OMAP5 and similar cores. This adds the High
> @@ -84,7 +80,6 @@ config OMAP5_DSS_HDMI
>
>  config OMAP2_DSS_SDI
>         bool "SDI support"
> -        default n
>         help
>           SDI (Serial Display Interface) support.
>
> @@ -93,7 +88,6 @@ config OMAP2_DSS_SDI
>
>  config OMAP2_DSS_DSI
>         bool "DSI support"
> -        default n
>         help
>           MIPI DSI (Display Serial Interface) support.
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
