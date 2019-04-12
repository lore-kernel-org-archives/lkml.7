Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F2C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301212084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfDLKLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:11:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:28922 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfDLKL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:11:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 03:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="163768664"
Received: from zhenggu-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.46.180])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2019 03:11:21 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH] drm: remove redundant 'default n' from Kconfig
In-Reply-To: <78400d66-a1c7-3688-0ffa-3e8c34cec34c@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CGME20190412095608eucas1p29bce9e8a81c58c72c4b45c27138a826a@eucas1p2.samsung.com> <78400d66-a1c7-3688-0ffa-3e8c34cec34c@samsung.com>
Date:   Fri, 12 Apr 2019 13:11:35 +0300
Message-ID: <87tvf3h6so.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:
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
> ---
>  drivers/gpu/drm/Kconfig             |    5 -----
>  drivers/gpu/drm/amd/amdgpu/Kconfig  |    1 -
>  drivers/gpu/drm/arm/Kconfig         |    1 -
>  drivers/gpu/drm/exynos/Kconfig      |    2 --
>  drivers/gpu/drm/i915/Kconfig        |    3 ---
>  drivers/gpu/drm/i915/Kconfig.debug  |   13 -------------

For i915,

Acked-by: Jani Nikula <jani.nikula@intel.com>

and can be merged through whichever tree you like.

>  drivers/gpu/drm/msm/Kconfig         |    2 --
>  drivers/gpu/drm/nouveau/Kconfig     |    2 --
>  drivers/gpu/drm/omapdrm/Kconfig     |    1 -
>  drivers/gpu/drm/omapdrm/dss/Kconfig |    6 ------
>  10 files changed, 36 deletions(-)
>
> Index: b/drivers/gpu/drm/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/Kconfig	2019-04-12 11:42:30.066095359 +0200
> @@ -37,7 +37,6 @@ config DRM_DP_AUX_CHARDEV
>  
>  config DRM_DEBUG_MM
>  	bool "Insert extra checks and debug info into the DRM range managers"
> -	default n
>  	depends on DRM=y
>  	depends on STACKTRACE_SUPPORT
>  	select STACKDEPOT
> @@ -56,7 +55,6 @@ config DRM_DEBUG_SELFTEST
>  	select PRIME_NUMBERS
>  	select DRM_LIB_RANDOM
>  	select DRM_KMS_HELPER
> -	default n
>  	help
>  	  This option provides kernel modules that can be used to run
>  	  various selftests on parts of the DRM api. This option is not
> @@ -113,7 +111,6 @@ config DRM_FBDEV_OVERALLOC
>  config DRM_FBDEV_LEAK_PHYS_SMEM
>  	bool "Shamelessly allow leaking of fbdev physical address (DANGEROUS)"
>  	depends on DRM_FBDEV_EMULATION && EXPERT
> -	default n
>  	help
>  	  In order to keep user-space compatibility, we want in certain
>  	  use-cases to keep leaking the fbdev physical address to the
> @@ -247,7 +244,6 @@ config DRM_VKMS
>  	tristate "Virtual KMS (EXPERIMENTAL)"
>  	depends on DRM
>  	select DRM_KMS_HELPER
> -	default n
>  	help
>  	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
>  	  running GPU in a headless machines. Choose this option to get
> @@ -424,4 +420,3 @@ config DRM_PANEL_ORIENTATION_QUIRKS
>  
>  config DRM_LIB_RANDOM
>  	bool
> -	default n
> Index: b/drivers/gpu/drm/amd/amdgpu/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig	2019-04-12 11:42:30.066095359 +0200
> @@ -35,7 +35,6 @@ config DRM_AMDGPU_GART_DEBUGFS
>  	bool "Allow GART access through debugfs"
>  	depends on DRM_AMDGPU
>  	depends on DEBUG_FS
> -	default n
>  	help
>  	  Selecting this option creates a debugfs file to inspect the mapped
>  	  pages. Uses more memory for housekeeping, enable only for debugging.
> Index: b/drivers/gpu/drm/arm/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/arm/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/arm/Kconfig	2019-04-12 11:42:30.066095359 +0200
> @@ -16,7 +16,6 @@ config DRM_HDLCD
>  config DRM_HDLCD_SHOW_UNDERRUN
>  	bool "Show underrun conditions"
>  	depends on DRM_HDLCD
> -	default n
>  	help
>  	  Enable this option to show in red colour the pixels that the
>  	  HDLCD device did not fetch from framebuffer due to underrun
> Index: b/drivers/gpu/drm/exynos/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/exynos/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/exynos/Kconfig	2019-04-12 11:42:30.066095359 +0200
> @@ -46,7 +46,6 @@ config DRM_EXYNOS_DPI
>  	bool "Parallel output"
>  	depends on DRM_EXYNOS_FIMD
>  	select DRM_PANEL
> -	default n
>  	help
>  	  This enables support for Exynos parallel output.
>  
> @@ -55,7 +54,6 @@ config DRM_EXYNOS_DSI
>  	depends on DRM_EXYNOS_FIMD || DRM_EXYNOS5433_DECON || DRM_EXYNOS7_DECON
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL
> -	default n
>  	help
>  	  This enables support for Exynos MIPI-DSI device.
>  
> Index: b/drivers/gpu/drm/i915/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/i915/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/i915/Kconfig	2019-04-12 11:42:30.066095359 +0200
> @@ -45,7 +45,6 @@ config DRM_I915
>  config DRM_I915_ALPHA_SUPPORT
>  	bool "Enable alpha quality support for new Intel hardware by default"
>  	depends on DRM_I915
> -	default n
>  	help
>  	  Choose this option if you have new Intel hardware and want to enable
>  	  the alpha quality i915 driver support for the hardware in this kernel
> @@ -99,7 +98,6 @@ config DRM_I915_GVT
>          bool "Enable Intel GVT-g graphics virtualization host support"
>          depends on DRM_I915
>          depends on 64BIT
> -        default n
>          help
>  	  Choose this option if you want to enable Intel GVT-g graphics
>  	  virtualization technology host support with integrated graphics.
> @@ -123,7 +121,6 @@ config DRM_I915_GVT_KVMGT
>  	depends on DRM_I915_GVT
>  	depends on KVM
>  	depends on VFIO_MDEV && VFIO_MDEV_DEVICE
> -	default n
>  	help
>  	  Choose this option if you want to enable KVMGT support for
>  	  Intel GVT-g.
> Index: b/drivers/gpu/drm/i915/Kconfig.debug
> ===================================================================
> --- a/drivers/gpu/drm/i915/Kconfig.debug	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/i915/Kconfig.debug	2019-04-12 11:42:30.066095359 +0200
> @@ -6,7 +6,6 @@ config DRM_I915_WERROR
>          # We use the dependency on !COMPILE_TEST to not be enabled in
>          # allmodconfig or allyesconfig configurations
>          depends on !COMPILE_TEST
> -        default n
>          help
>            Add -Werror to the build flags for (and only for) i915.ko.
>            Do not enable this unless you are writing code for the i915.ko module.
> @@ -31,7 +30,6 @@ config DRM_I915_DEBUG
>  	select DRM_I915_SW_FENCE_DEBUG_OBJECTS
>  	select DRM_I915_SELFTEST
>  	select DRM_I915_DEBUG_RUNTIME_PM
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
>  	bool "Insert extra logging (very verbose) for common GEM errors"
> -	default n
>  	depends on DRM_I915_DEBUG_GEM
>  	help
>  	  Enable additional logging that may help track down the cause of
> @@ -68,7 +64,6 @@ config DRM_I915_TRACE_GEM
>  	bool "Insert extra ftrace output from the GEM internals"
>  	depends on DRM_I915_DEBUG_GEM
>  	select TRACING
> -	default n
>  	help
>  	  Enable additional and verbose debugging output that will spam
>  	  ordinary tests, but may be vital for post-mortem debugging when
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
>  	bool "Enable selftests upon driver load"
>  	depends on DRM_I915
> -	default n
>  	select FAULT_INJECTION
>  	select PRIME_NUMBERS
>  	help
> @@ -135,7 +126,6 @@ config DRM_I915_SELFTEST_BROKEN
>  	bool "Enable broken and dangerous selftests"
>  	depends on DRM_I915_SELFTEST
>  	depends on BROKEN
> -	default n
>  	help
>  	  This option enables the execution of selftests that are "dangerous"
>  	  and may trigger unintended HW side-effects as they break strict
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
>  	bool "Enable extra debug warnings for vblank evasion"
>  	depends on DRM_I915
> -	default n
>  	help
>  	  Choose this option to turn on extra debug warnings for the
>  	  vblank evade mechanism. This gives a warning every time the
> @@ -172,7 +160,6 @@ config DRM_I915_DEBUG_VBLANK_EVADE
>  config DRM_I915_DEBUG_RUNTIME_PM
>  	bool "Enable extra state checking for runtime PM"
>  	depends on DRM_I915
> -	default n
>  	select STACKDEPOT
>  	help
>  	  Choose this option to turn on extra state checking for the
> Index: b/drivers/gpu/drm/msm/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/msm/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/msm/Kconfig	2019-04-12 11:42:30.066095359 +0200
> @@ -24,7 +24,6 @@ config DRM_MSM
>  config DRM_MSM_REGISTER_LOGGING
>  	bool "MSM DRM register logging"
>  	depends on DRM_MSM
> -	default n
>  	help
>  	  Compile in support for logging register reads/writes in a format
>  	  that can be parsed by envytools demsm tool.  If enabled, register
> @@ -33,7 +32,6 @@ config DRM_MSM_REGISTER_LOGGING
>  config DRM_MSM_GPU_SUDO
>  	bool "Enable SUDO flag on submits"
>  	depends on DRM_MSM && EXPERT
> -	default n
>  	help
>  	  Enable userspace that has CAP_SYS_RAWIO to submit GPU commands
>  	  that are run from RB instead of IB1.  This essentially gives
> Index: b/drivers/gpu/drm/nouveau/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/nouveau/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/nouveau/Kconfig	2019-04-12 11:43:25.998096767 +0200
> @@ -60,7 +60,6 @@ config NOUVEAU_DEBUG_DEFAULT
>  config NOUVEAU_DEBUG_MMU
>  	bool "Enable additional MMU debugging"
>  	depends on DRM_NOUVEAU
> -	default n
>  	help
>  	  Say Y here if you want to enable verbose MMU debug output.
>  
> @@ -79,7 +78,6 @@ config DRM_NOUVEAU_SVM
>  	depends on STAGING
>  	select HMM_MIRROR
>  	select DEVICE_PRIVATE
> -	default n
>  	help
>  	  Say Y here if you want to enable experimental support for
>  	  Shared Virtual Memory (SVM).
> Index: b/drivers/gpu/drm/omapdrm/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/omapdrm/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/omapdrm/Kconfig	2019-04-12 11:42:30.070095359 +0200
> @@ -4,7 +4,6 @@ config DRM_OMAP
>  	depends on ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
>  	select OMAP2_DSS
>  	select DRM_KMS_HELPER
> -	default n
>  	help
>  	  DRM display driver for OMAP2/3/4 based boards.
>  
> Index: b/drivers/gpu/drm/omapdrm/dss/Kconfig
> ===================================================================
> --- a/drivers/gpu/drm/omapdrm/dss/Kconfig	2019-04-12 11:42:30.070095359 +0200
> +++ b/drivers/gpu/drm/omapdrm/dss/Kconfig	2019-04-12 11:42:30.070095359 +0200
> @@ -17,7 +17,6 @@ if OMAP2_DSS
>  
>  config OMAP2_DSS_DEBUG
>  	bool "Debug support"
> -	default n
>  	help
>  	  This enables printing of debug messages. Alternatively, debug messages
>  	  can also be enabled by setting CONFIG_DYNAMIC_DEBUG and then setting
> @@ -26,7 +25,6 @@ config OMAP2_DSS_DEBUG
>  config OMAP2_DSS_DEBUGFS
>  	bool "Debugfs filesystem support"
>  	depends on DEBUG_FS
> -	default n
>  	help
>  	  This enables debugfs for OMAPDSS at <debugfs>/omapdss. This enables
>  	  querying about clock configuration and register configuration of dss,
> @@ -35,7 +33,6 @@ config OMAP2_DSS_DEBUGFS
>  config OMAP2_DSS_COLLECT_IRQ_STATS
>  	bool "Collect DSS IRQ statistics"
>  	depends on OMAP2_DSS_DEBUGFS
> -	default n
>  	help
>  	  Collect DSS IRQ statistics, printable via debugfs.
>  
> @@ -75,7 +72,6 @@ config OMAP4_DSS_HDMI_CEC
>  
>  config OMAP5_DSS_HDMI
>  	bool "HDMI support for OMAP5"
> -	default n
>  	select OMAP2_DSS_HDMI_COMMON
>  	help
>  	  HDMI Interface for OMAP5 and similar cores. This adds the High
> @@ -84,7 +80,6 @@ config OMAP5_DSS_HDMI
>  
>  config OMAP2_DSS_SDI
>  	bool "SDI support"
> -        default n
>  	help
>  	  SDI (Serial Display Interface) support.
>  
> @@ -93,7 +88,6 @@ config OMAP2_DSS_SDI
>  
>  config OMAP2_DSS_DSI
>  	bool "DSI support"
> -        default n
>  	help
>  	  MIPI DSI (Display Serial Interface) support.
>  

-- 
Jani Nikula, Intel Open Source Graphics Center
