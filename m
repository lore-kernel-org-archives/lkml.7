Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5794C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2132B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Du835c+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDLJ4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:56:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41010 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfDLJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:56:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190412095611euoutp024b3980b6be3d1438a8c2ce3eccd90a82~UsYh9Ps-K0234102341euoutp023
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 09:56:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190412095611euoutp024b3980b6be3d1438a8c2ce3eccd90a82~UsYh9Ps-K0234102341euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555062971;
        bh=NSSqhkAcHY0E907x9ZLCXHVrkEHvTfMMDI/QSelWdyk=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Du835c+ao+VN58zsQSp5C9deet4TBG6VSz0o2Dbityg6AqPBw6ST+VhcN6GC8V6P4
         5l6Wbi41+P4vtebPPZwwOpchZElt6mQ9qfGHZdZu/hv2HrIU0dEp7T8DWIgFhj2HqF
         8s/jewT0BV8u4bl2TMtWLfJ9gOc64daPhXz3gh+s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190412095609eucas1p16ad73a333263fa5e2d46463936b81eec~UsYgR7iul1919719197eucas1p1J;
        Fri, 12 Apr 2019 09:56:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 61.3A.04377.9B060BC5; Fri, 12
        Apr 2019 10:56:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190412095608eucas1p29bce9e8a81c58c72c4b45c27138a826a~UsYfmQK930563305633eucas1p2d;
        Fri, 12 Apr 2019 09:56:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412095608eusmtrp218a83b541d66693ee521f75e74ad3fa3~UsYfX4qpr1366713667eusmtrp2h;
        Fri, 12 Apr 2019 09:56:08 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-bb-5cb060b9e70d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.B0.04140.8B060BC5; Fri, 12
        Apr 2019 10:56:08 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190412095607eusmtip29de73ea5780ba44392b02f653d2661e1~UsYeYXGx-0497204972eusmtip2a;
        Fri, 12 Apr 2019 09:56:07 +0000 (GMT)
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] drm: remove redundant 'default n' from Kconfig
Message-ID: <78400d66-a1c7-3688-0ffa-3e8c34cec34c@samsung.com>
Date:   Fri, 12 Apr 2019 11:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3t379WaXDejY6bFoKKgt8ivjMrSuH8UWBlkGrrqoqZT29Sy
        B1T0sIXmJpTNZUoPa2azMtdmJvhozDIzs7IsBxU5Hw3R7IFWbteo/875vu+c853DYQjpRWo6
        k5SawatSFSlyypusfvSjdYElvjJ28ZcfBM59ahfhc101YnzVdJTGzrIchAe6x9Pf1VoCXxlu
        FeMXX10UNnxuQVjXnU/iovy7IlzWbkK4tlSEe963kbjlWD+NtXUtNG63GihcOniPxA5nHcLf
        8vLE+HPpdwLX6V/S+F1BI8KFBU4Kmy69odb4cyeej1Fc8c2DXO1ICclZ9O9o7vIDp4gzjzjE
        XLF9E9d9xibibNY3NOd62EFxeVVGxNlem0Xc0J2gSMl275W7+ZSkLF61aFW8d2KXvQel/0zZ
        P9b3SXwE1WzVIIYBNhhONwRokDcjZa8jaGo20BrkNZ4MI6i8HSwQQwj6izuRm3AXPLNcpAWi
        DIHRfJQQkgEEvTe0pFvlx4aD3dFKuQmCNdDwdnTQ05diV4D2lNHTSsauhtOd9R5cwq6Cny0u
        D06ys6HJ+oV0+5vKboOzT+YKEl+wX/jo6U+wM8E8YPAMBraRgaru7xP2wqGisIEUYhn02qpo
        IZ4Bvy2XRELBLQRjOT0T1WYEZQW/KEEVCg22NrF7MsHOA5N1kQCHQZ9jkBAO5gOvB3wFEz6g
        qz4/AUsg56RUUM+BymuV1N+xGssNQog5cNScFAvn3QHluqdkPpql/281/X+r6f95KEGEEU3j
        M9XKBF69NJXft1CtUKozUxMW7kpT3kHjT/v4l234PrKO7qxHLIPkUyTbwkyxUrEiS52trEfA
        EHI/SRQ5Dkl2K7IP8Kq0OFVmCq+uRwEMKZ8mOTjJESNlExQZfDLPp/Oqv6yI8Zp+BM2439wZ
        Rzh9ISza9fw4xGq9VHebotI/cNn+Sl3xq9olM2+v3TIS0x4RtFwWcWr95ECQlW/sH8J+Afjw
        5tUQ0uivXNcRmVze5R/6JG5X354AY3xg1KuQokQFs6JC77PhfG5hdEibTlMScfispOZc+bL0
        lcHJe5VfD5krfJKaR7/JSXWiYsl8QqVW/AENF0acsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOzjmGq1czehOxWEiQOt287FW8FPThEH0o7F6WKw8qOWc7
        czQjUKOyZcMLmC1dXopKioV5XdlgmGOFmZdu5i0qdJgOqSxNs00J/PZ7nv/vgefDnyF8i4T+
        TEaWhlNnKTLF1Gry5V/7cGhryqNj4eUDEF975RDg8sEnQnzHnE9j591CgCdH3ONicwmBb//o
        FuL+ny4KV451AVw6Ukzim8WPBfhunxng9hoBHh/uIXFXwTcal1i7aNxnqaRwzXQTiUedVoB/
        GQxCPFbzm8BW41saD5V1AFxR5qSw+dYAtX0je7F3gWJND86x7TPVJNtmHKLZuqdOAdsyMypk
        TY697MhVu4C1WwZo1vXsDcUaGusBa3/fImC/NwTuER2RxKlVORpuc7qK18SLj0qxTCKNwRJZ
        ZIxEGiFPjpVFicMS4lK5zAwtpw5LSJGkDzrGQfZc5tmFia/CPPBkvx54MQhGotdtVbQerGZ8
        4R2A/rR/BHrAuIMAZDdrl511aP6tnlp2JgDqznMJPIEf3Ikco91LAQGraWRp8gxeDAVjUcnl
        euDhdTARXflgoz0sgglorsu1tCdhEHpumSI9vB4eQgOfCsllxwc5bnxZYgJuRfOmXmKZN6GW
        yUqiGKw1rtCMKzTjCq0aEPXAj8vhlWlKXibhFUo+JytNckqlbADuJjR3zja2Av1Ukg1ABoi9
        RXtizcd8hQotr1PaAGIIsZ9oH+leiVIVulxOrTqhzsnkeBuIcj9eQvivP6Vy9ypLc0IaJZXj
        GKk8Qh4RjcUbRN3huiO+ME2h4U5zXDan/n8nYLz884BM97ApuOdFfGQVnbh1tnYKUIZ7UJUf
        fD+xcJehIDTZCkXfDuptnzVnDl+CtbuDnDG5a0IWs8eTdKsCzwd2Xgj2rk3GD8v7pZV51++N
        609GTGs7qIo6uc9xYchEkquuYsvcjvCCA4d9HO+ia+LLe6sCTEXx+U5tQwdrju4thWKST1dI
        txFqXvEP1l6/gx8DAAA=
X-CMS-MailID: 20190412095608eucas1p29bce9e8a81c58c72c4b45c27138a826a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412095608eucas1p29bce9e8a81c58c72c4b45c27138a826a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412095608eucas1p29bce9e8a81c58c72c4b45c27138a826a
References: <CGME20190412095608eucas1p29bce9e8a81c58c72c4b45c27138a826a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/gpu/drm/Kconfig             |    5 -----
 drivers/gpu/drm/amd/amdgpu/Kconfig  |    1 -
 drivers/gpu/drm/arm/Kconfig         |    1 -
 drivers/gpu/drm/exynos/Kconfig      |    2 --
 drivers/gpu/drm/i915/Kconfig        |    3 ---
 drivers/gpu/drm/i915/Kconfig.debug  |   13 -------------
 drivers/gpu/drm/msm/Kconfig         |    2 --
 drivers/gpu/drm/nouveau/Kconfig     |    2 --
 drivers/gpu/drm/omapdrm/Kconfig     |    1 -
 drivers/gpu/drm/omapdrm/dss/Kconfig |    6 ------
 10 files changed, 36 deletions(-)

Index: b/drivers/gpu/drm/Kconfig
===================================================================
--- a/drivers/gpu/drm/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/Kconfig	2019-04-12 11:42:30.066095359 +0200
@@ -37,7 +37,6 @@ config DRM_DP_AUX_CHARDEV
 
 config DRM_DEBUG_MM
 	bool "Insert extra checks and debug info into the DRM range managers"
-	default n
 	depends on DRM=y
 	depends on STACKTRACE_SUPPORT
 	select STACKDEPOT
@@ -56,7 +55,6 @@ config DRM_DEBUG_SELFTEST
 	select PRIME_NUMBERS
 	select DRM_LIB_RANDOM
 	select DRM_KMS_HELPER
-	default n
 	help
 	  This option provides kernel modules that can be used to run
 	  various selftests on parts of the DRM api. This option is not
@@ -113,7 +111,6 @@ config DRM_FBDEV_OVERALLOC
 config DRM_FBDEV_LEAK_PHYS_SMEM
 	bool "Shamelessly allow leaking of fbdev physical address (DANGEROUS)"
 	depends on DRM_FBDEV_EMULATION && EXPERT
-	default n
 	help
 	  In order to keep user-space compatibility, we want in certain
 	  use-cases to keep leaking the fbdev physical address to the
@@ -247,7 +244,6 @@ config DRM_VKMS
 	tristate "Virtual KMS (EXPERIMENTAL)"
 	depends on DRM
 	select DRM_KMS_HELPER
-	default n
 	help
 	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
 	  running GPU in a headless machines. Choose this option to get
@@ -424,4 +420,3 @@ config DRM_PANEL_ORIENTATION_QUIRKS
 
 config DRM_LIB_RANDOM
 	bool
-	default n
Index: b/drivers/gpu/drm/amd/amdgpu/Kconfig
===================================================================
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig	2019-04-12 11:42:30.066095359 +0200
@@ -35,7 +35,6 @@ config DRM_AMDGPU_GART_DEBUGFS
 	bool "Allow GART access through debugfs"
 	depends on DRM_AMDGPU
 	depends on DEBUG_FS
-	default n
 	help
 	  Selecting this option creates a debugfs file to inspect the mapped
 	  pages. Uses more memory for housekeeping, enable only for debugging.
Index: b/drivers/gpu/drm/arm/Kconfig
===================================================================
--- a/drivers/gpu/drm/arm/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/arm/Kconfig	2019-04-12 11:42:30.066095359 +0200
@@ -16,7 +16,6 @@ config DRM_HDLCD
 config DRM_HDLCD_SHOW_UNDERRUN
 	bool "Show underrun conditions"
 	depends on DRM_HDLCD
-	default n
 	help
 	  Enable this option to show in red colour the pixels that the
 	  HDLCD device did not fetch from framebuffer due to underrun
Index: b/drivers/gpu/drm/exynos/Kconfig
===================================================================
--- a/drivers/gpu/drm/exynos/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/exynos/Kconfig	2019-04-12 11:42:30.066095359 +0200
@@ -46,7 +46,6 @@ config DRM_EXYNOS_DPI
 	bool "Parallel output"
 	depends on DRM_EXYNOS_FIMD
 	select DRM_PANEL
-	default n
 	help
 	  This enables support for Exynos parallel output.
 
@@ -55,7 +54,6 @@ config DRM_EXYNOS_DSI
 	depends on DRM_EXYNOS_FIMD || DRM_EXYNOS5433_DECON || DRM_EXYNOS7_DECON
 	select DRM_MIPI_DSI
 	select DRM_PANEL
-	default n
 	help
 	  This enables support for Exynos MIPI-DSI device.
 
Index: b/drivers/gpu/drm/i915/Kconfig
===================================================================
--- a/drivers/gpu/drm/i915/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/i915/Kconfig	2019-04-12 11:42:30.066095359 +0200
@@ -45,7 +45,6 @@ config DRM_I915
 config DRM_I915_ALPHA_SUPPORT
 	bool "Enable alpha quality support for new Intel hardware by default"
 	depends on DRM_I915
-	default n
 	help
 	  Choose this option if you have new Intel hardware and want to enable
 	  the alpha quality i915 driver support for the hardware in this kernel
@@ -99,7 +98,6 @@ config DRM_I915_GVT
         bool "Enable Intel GVT-g graphics virtualization host support"
         depends on DRM_I915
         depends on 64BIT
-        default n
         help
 	  Choose this option if you want to enable Intel GVT-g graphics
 	  virtualization technology host support with integrated graphics.
@@ -123,7 +121,6 @@ config DRM_I915_GVT_KVMGT
 	depends on DRM_I915_GVT
 	depends on KVM
 	depends on VFIO_MDEV && VFIO_MDEV_DEVICE
-	default n
 	help
 	  Choose this option if you want to enable KVMGT support for
 	  Intel GVT-g.
Index: b/drivers/gpu/drm/i915/Kconfig.debug
===================================================================
--- a/drivers/gpu/drm/i915/Kconfig.debug	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/i915/Kconfig.debug	2019-04-12 11:42:30.066095359 +0200
@@ -6,7 +6,6 @@ config DRM_I915_WERROR
         # We use the dependency on !COMPILE_TEST to not be enabled in
         # allmodconfig or allyesconfig configurations
         depends on !COMPILE_TEST
-        default n
         help
           Add -Werror to the build flags for (and only for) i915.ko.
           Do not enable this unless you are writing code for the i915.ko module.
@@ -31,7 +30,6 @@ config DRM_I915_DEBUG
 	select DRM_I915_SW_FENCE_DEBUG_OBJECTS
 	select DRM_I915_SELFTEST
 	select DRM_I915_DEBUG_RUNTIME_PM
-        default n
         help
           Choose this option to turn on extra driver debugging that may affect
           performance but will catch some internal issues.
@@ -42,7 +40,6 @@ config DRM_I915_DEBUG
 
 config DRM_I915_DEBUG_GEM
         bool "Insert extra checks into the GEM internals"
-        default n
         depends on DRM_I915_WERROR
         help
           Enable extra sanity checks (including BUGs) along the GEM driver
@@ -54,7 +51,6 @@ config DRM_I915_DEBUG_GEM
 
 config DRM_I915_ERRLOG_GEM
 	bool "Insert extra logging (very verbose) for common GEM errors"
-	default n
 	depends on DRM_I915_DEBUG_GEM
 	help
 	  Enable additional logging that may help track down the cause of
@@ -68,7 +64,6 @@ config DRM_I915_TRACE_GEM
 	bool "Insert extra ftrace output from the GEM internals"
 	depends on DRM_I915_DEBUG_GEM
 	select TRACING
-	default n
 	help
 	  Enable additional and verbose debugging output that will spam
 	  ordinary tests, but may be vital for post-mortem debugging when
@@ -82,7 +77,6 @@ config DRM_I915_SW_FENCE_DEBUG_OBJECTS
         bool "Enable additional driver debugging for fence objects"
         depends on DRM_I915
         select DEBUG_OBJECTS
-        default n
         help
           Choose this option to turn on extra driver debugging that may affect
           performance but will catch some internal issues.
@@ -94,7 +88,6 @@ config DRM_I915_SW_FENCE_DEBUG_OBJECTS
 config DRM_I915_SW_FENCE_CHECK_DAG
         bool "Enable additional driver debugging for detecting dependency cycles"
         depends on DRM_I915
-        default n
         help
           Choose this option to turn on extra driver debugging that may affect
           performance but will catch some internal issues.
@@ -106,7 +99,6 @@ config DRM_I915_SW_FENCE_CHECK_DAG
 config DRM_I915_DEBUG_GUC
         bool "Enable additional driver debugging for GuC"
         depends on DRM_I915
-        default n
         help
           Choose this option to turn on extra driver debugging that may affect
           performance but will help resolve GuC related issues.
@@ -118,7 +110,6 @@ config DRM_I915_DEBUG_GUC
 config DRM_I915_SELFTEST
 	bool "Enable selftests upon driver load"
 	depends on DRM_I915
-	default n
 	select FAULT_INJECTION
 	select PRIME_NUMBERS
 	help
@@ -135,7 +126,6 @@ config DRM_I915_SELFTEST_BROKEN
 	bool "Enable broken and dangerous selftests"
 	depends on DRM_I915_SELFTEST
 	depends on BROKEN
-	default n
 	help
 	  This option enables the execution of selftests that are "dangerous"
 	  and may trigger unintended HW side-effects as they break strict
@@ -148,7 +138,6 @@ config DRM_I915_SELFTEST_BROKEN
 config DRM_I915_LOW_LEVEL_TRACEPOINTS
         bool "Enable low level request tracing events"
         depends on DRM_I915
-        default n
         help
           Choose this option to turn on low level request tracing events.
           This provides the ability to precisely monitor engine utilisation
@@ -159,7 +148,6 @@ config DRM_I915_LOW_LEVEL_TRACEPOINTS
 config DRM_I915_DEBUG_VBLANK_EVADE
 	bool "Enable extra debug warnings for vblank evasion"
 	depends on DRM_I915
-	default n
 	help
 	  Choose this option to turn on extra debug warnings for the
 	  vblank evade mechanism. This gives a warning every time the
@@ -172,7 +160,6 @@ config DRM_I915_DEBUG_VBLANK_EVADE
 config DRM_I915_DEBUG_RUNTIME_PM
 	bool "Enable extra state checking for runtime PM"
 	depends on DRM_I915
-	default n
 	select STACKDEPOT
 	help
 	  Choose this option to turn on extra state checking for the
Index: b/drivers/gpu/drm/msm/Kconfig
===================================================================
--- a/drivers/gpu/drm/msm/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/msm/Kconfig	2019-04-12 11:42:30.066095359 +0200
@@ -24,7 +24,6 @@ config DRM_MSM
 config DRM_MSM_REGISTER_LOGGING
 	bool "MSM DRM register logging"
 	depends on DRM_MSM
-	default n
 	help
 	  Compile in support for logging register reads/writes in a format
 	  that can be parsed by envytools demsm tool.  If enabled, register
@@ -33,7 +32,6 @@ config DRM_MSM_REGISTER_LOGGING
 config DRM_MSM_GPU_SUDO
 	bool "Enable SUDO flag on submits"
 	depends on DRM_MSM && EXPERT
-	default n
 	help
 	  Enable userspace that has CAP_SYS_RAWIO to submit GPU commands
 	  that are run from RB instead of IB1.  This essentially gives
Index: b/drivers/gpu/drm/nouveau/Kconfig
===================================================================
--- a/drivers/gpu/drm/nouveau/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/nouveau/Kconfig	2019-04-12 11:43:25.998096767 +0200
@@ -60,7 +60,6 @@ config NOUVEAU_DEBUG_DEFAULT
 config NOUVEAU_DEBUG_MMU
 	bool "Enable additional MMU debugging"
 	depends on DRM_NOUVEAU
-	default n
 	help
 	  Say Y here if you want to enable verbose MMU debug output.
 
@@ -79,7 +78,6 @@ config DRM_NOUVEAU_SVM
 	depends on STAGING
 	select HMM_MIRROR
 	select DEVICE_PRIVATE
-	default n
 	help
 	  Say Y here if you want to enable experimental support for
 	  Shared Virtual Memory (SVM).
Index: b/drivers/gpu/drm/omapdrm/Kconfig
===================================================================
--- a/drivers/gpu/drm/omapdrm/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/omapdrm/Kconfig	2019-04-12 11:42:30.070095359 +0200
@@ -4,7 +4,6 @@ config DRM_OMAP
 	depends on ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
 	select OMAP2_DSS
 	select DRM_KMS_HELPER
-	default n
 	help
 	  DRM display driver for OMAP2/3/4 based boards.
 
Index: b/drivers/gpu/drm/omapdrm/dss/Kconfig
===================================================================
--- a/drivers/gpu/drm/omapdrm/dss/Kconfig	2019-04-12 11:42:30.070095359 +0200
+++ b/drivers/gpu/drm/omapdrm/dss/Kconfig	2019-04-12 11:42:30.070095359 +0200
@@ -17,7 +17,6 @@ if OMAP2_DSS
 
 config OMAP2_DSS_DEBUG
 	bool "Debug support"
-	default n
 	help
 	  This enables printing of debug messages. Alternatively, debug messages
 	  can also be enabled by setting CONFIG_DYNAMIC_DEBUG and then setting
@@ -26,7 +25,6 @@ config OMAP2_DSS_DEBUG
 config OMAP2_DSS_DEBUGFS
 	bool "Debugfs filesystem support"
 	depends on DEBUG_FS
-	default n
 	help
 	  This enables debugfs for OMAPDSS at <debugfs>/omapdss. This enables
 	  querying about clock configuration and register configuration of dss,
@@ -35,7 +33,6 @@ config OMAP2_DSS_DEBUGFS
 config OMAP2_DSS_COLLECT_IRQ_STATS
 	bool "Collect DSS IRQ statistics"
 	depends on OMAP2_DSS_DEBUGFS
-	default n
 	help
 	  Collect DSS IRQ statistics, printable via debugfs.
 
@@ -75,7 +72,6 @@ config OMAP4_DSS_HDMI_CEC
 
 config OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
-	default n
 	select OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI Interface for OMAP5 and similar cores. This adds the High
@@ -84,7 +80,6 @@ config OMAP5_DSS_HDMI
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-        default n
 	help
 	  SDI (Serial Display Interface) support.
 
@@ -93,7 +88,6 @@ config OMAP2_DSS_SDI
 
 config OMAP2_DSS_DSI
 	bool "DSI support"
-        default n
 	help
 	  MIPI DSI (Display Serial Interface) support.
 
