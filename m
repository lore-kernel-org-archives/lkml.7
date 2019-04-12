Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2E4C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F67B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XxDjUFxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfDLK1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:27:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51578 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDLK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:27:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190412102742euoutp0256f6a9a15bd08733c7bfd00fe75f9505~Us0DxLCm21891718917euoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:27:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190412102742euoutp0256f6a9a15bd08733c7bfd00fe75f9505~Us0DxLCm21891718917euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555064862;
        bh=vJyta+R5/dOSxK4OJywP3eb1lbKNKXjCcUE/+GvX1yY=;
        h=To:Cc:From:Subject:Date:References:From;
        b=XxDjUFxiqcca0gmShCvS/ga3UqRUSVMU4FOMfqX95KX1Pzsq23mwAgYMeA2pY6/Pw
         sJIxNC1n7KLnOxAA4qxkwdXrKYQBg3SSvlZnpE8SXPuaT2kXzfxcpbeyVQu8xURmYV
         fGIZzE8o+8hyf/XoNk5hcDkee5qdDOmtsUzi192I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190412102742eucas1p2fbf2b5b540af1e9cd1c6ba3392dd06a7~Us0DZRvsY1570415704eucas1p2h;
        Fri, 12 Apr 2019 10:27:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AC.4E.04377.E1860BC5; Fri, 12
        Apr 2019 11:27:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190412102741eucas1p23e82bc2210b44b826279a47ffb2901cd~Us0CuEUbX1751617516eucas1p2I;
        Fri, 12 Apr 2019 10:27:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412102741eusmtrp2f97653661df2ce28abf7f0a266ca3d08~Us0CfzlLe3151731517eusmtrp2W;
        Fri, 12 Apr 2019 10:27:41 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-5c-5cb0681edbc3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 55.B6.04146.D1860BC5; Fri, 12
        Apr 2019 11:27:41 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190412102741eusmtip27229e04b4f059a6fd5784ead550b6d4c~Us0CLhLOg2776027760eusmtip2M;
        Fri, 12 Apr 2019 10:27:41 +0000 (GMT)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Andy Walls <awalls@md.metrocast.net>,
        Helen Koike <helen.koike@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] media: remove redundant 'default n' from Kconfig-s
Message-ID: <5dfae2c1-b3fa-fc6f-16c3-270f4e43b270@samsung.com>
Date:   Fri, 12 Apr 2019 12:27:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87pyGRtiDFbO4bR4055kcar7HbvF
        qcnPmCwu75rDZtGzYSurxbJNf5gc2Dx23F3C6LFpVSebx6wLm9k9Pm+S8zj19TN7AGsUl01K
        ak5mWWqRvl0CV8aVadfYCs5kVCzr62JqYJwc2sXIySEhYCLxZt0Pxi5GLg4hgRWMEm87vjFD
        OF8YJV7P6mCFcD4zSsyZcpUFpmX5nH0sEInljBLbph6E6n/LKDFl/mV2kCoRAT2J55svglUx
        C2xmlHiz6TMzSIJNwEpiYvsqRhBbWMBZ4vvhXrCxvAJ2ElOufwSzWQRUJS7MOQM0iINDVCBC
        ov+MOkSJoMTJmU/ASpgF5CW2v50DdquEwH82iRXLG1hA6iUEXCSafsRDXCos8er4FnYIW0bi
        /875TBD16xgl/na8gGreziixfPI/Nogqa4nDxy+yggxiFtCUWL9LHyLsKLHyRSc7xHw+iRtv
        BSFu4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3auZIawPSTmPn4I9rmQQKxEe+dXxgmMCrOQ
        fDYLyWezEG5YwMi8ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDBnP53/MsOxl1/kg4x
        CnAwKvHwRjiujxFiTSwrrsw9xCjBwawkwhvCAhTiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83w
        IFpIID2xJDU7NbUgtQgmy8TBKdXA2MTy66DeQ5aZNxkcgyxqZOyf7Mi4qszqd8d+8hHNW945
        72ZnJ9q7M6ZJTnuUOm3tB57Ov1GLjs859Wzp9WlcuQUet8tdX0WcnXV00u+vN3QUhTfFtl/X
        tWFurcndx9BqbJH6of+wQLChfUx/5Z4rD/8GlDM+1A3tN3KuK+v3CXXP9JuZmamsxFKckWio
        xVxUnAgATCoXdiwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4PV3ZjA0xBlOuyFi8aU+yONX9jt3i
        1ORnTBaXd81hs+jZsJXVYtmmP0wObB477i5h9Ni0qpPNY9aFzewenzfJeZz6+pk9gDVKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PKtGtsBWcy
        Kpb1dTE1ME4O7WLk5JAQMJFYPmcfSxcjF4eQwFJGic+7z7J1MXIAJWQkjq8vg6gRlvhzrYsN
        ouY1o8SME5vYQBIiAnoSzzdfBGtmFtjMKPHoyhEWkASbgJXExPZVjCC2sICzxPfDvWBxXgE7
        iSnXP4LZLAKqEhfmnGEHsUUFIiRuPeyAqhGUODnzCZjNLKAu8WfeJWYIW15i+9s5zBMY+Wch
        KZuFpGwWkrIFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNh27Gfm3cwXtoYfIhRgINR
        iYc3wGp9jBBrYllxZe4hRgkOZiUR3hAWoBBvSmJlVWpRfnxRaU5q8SFGU6DDJzJLiSbnA6M0
        ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDYxQPU4Z4+63A8i3W
        DrvWH3+i7ha3eZUz652iy5ZbjMw335mh0DSrT26x+jm9+VKMXEX+Lj7Ov/wrxcPexR09WV/2
        sV78amy4AMc7CdNva+tDzt/beLmcqcFY6lT+24Tn7/PNv/8+mHttRp5P2K9Dyy23tFSVVJ5n
        VToYwKlgtDtqQSmTvtteJZbijERDLeai4kQAS2SekJoCAAA=
X-CMS-MailID: 20190412102741eucas1p23e82bc2210b44b826279a47ffb2901cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412102741eucas1p23e82bc2210b44b826279a47ffb2901cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412102741eucas1p23e82bc2210b44b826279a47ffb2901cd
References: <CGME20190412102741eucas1p23e82bc2210b44b826279a47ffb2901cd@eucas1p2.samsung.com>
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
 drivers/media/Kconfig                  |    3 ---
 drivers/media/dvb-core/Kconfig         |    3 ---
 drivers/media/dvb-frontends/Kconfig    |    1 -
 drivers/media/pci/ddbridge/Kconfig     |    1 -
 drivers/media/pci/dt3155/Kconfig       |    1 -
 drivers/media/pci/ivtv/Kconfig         |    2 --
 drivers/media/platform/Kconfig         |   12 ------------
 drivers/media/platform/omap/Kconfig    |    1 -
 drivers/media/platform/vicodec/Kconfig |    1 -
 drivers/media/platform/vimc/Kconfig    |    1 -
 drivers/media/platform/vivid/Kconfig   |    1 -
 drivers/media/radio/Kconfig            |    1 -
 drivers/media/usb/s2255/Kconfig        |    1 -
 drivers/media/v4l2-core/Kconfig        |    2 --
 14 files changed, 31 deletions(-)

Index: b/drivers/media/Kconfig
===================================================================
--- a/drivers/media/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/Kconfig	2019-04-12 12:18:15.474149388 +0200
@@ -113,7 +113,6 @@ config MEDIA_CONTROLLER_DVB
 config MEDIA_CONTROLLER_REQUEST_API
 	bool "Enable Media controller Request API (EXPERIMENTAL)"
 	depends on MEDIA_CONTROLLER && STAGING_MEDIA
-	default n
 	help
 	  DO NOT ENABLE THIS OPTION UNLESS YOU KNOW WHAT YOU'RE DOING.
 
@@ -163,7 +162,6 @@ config DVB_MMAP
 	depends on DVB_CORE
 	depends on VIDEO_V4L2=y || VIDEO_V4L2=DVB_CORE
 	select VIDEOBUF2_VMALLOC
-	default n
 	help
 	  This option enables DVB experimental memory-mapped API, which
 	  reduces the number of context switches to read DVB buffers, as
@@ -189,7 +187,6 @@ config DVB_NET
 config TTPCI_EEPROM
 	tristate
 	depends on I2C
-	default n
 
 source "drivers/media/dvb-core/Kconfig"
 
Index: b/drivers/media/dvb-core/Kconfig
===================================================================
--- a/drivers/media/dvb-core/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/dvb-core/Kconfig	2019-04-12 12:17:55.898148895 +0200
@@ -18,7 +18,6 @@ config DVB_MAX_ADAPTERS
 config DVB_DYNAMIC_MINORS
 	bool "Dynamic DVB minor allocation"
 	depends on DVB_CORE
-	default n
 	help
 	  If you say Y here, the DVB subsystem will use dynamic minor
 	  allocation for any device that uses the DVB major number.
@@ -31,7 +30,6 @@ config DVB_DYNAMIC_MINORS
 config DVB_DEMUX_SECTION_LOSS_LOG
 	bool "Enable DVB demux section packet loss log"
 	depends on DVB_CORE
-	default n
 	help
 	  Enable extra log messages meant to detect packet loss
 	  inside the Kernel.
@@ -44,7 +42,6 @@ config DVB_DEMUX_SECTION_LOSS_LOG
 config DVB_ULE_DEBUG
 	bool "Enable DVB net ULE packet debug messages"
 	depends on DVB_CORE
-	default n
 	help
 	  Enable extra log messages meant to detect problems while
 	  handling DVB network ULE packet loss inside the Kernel.
Index: b/drivers/media/dvb-frontends/Kconfig
===================================================================
--- a/drivers/media/dvb-frontends/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/dvb-frontends/Kconfig	2019-04-12 12:17:55.914148895 +0200
@@ -945,5 +945,4 @@ comment "Tools to develop new frontends"
 config DVB_DUMMY_FE
 	tristate "Dummy frontend driver"
 	depends on DVB_CORE
-	default n
 endmenu
Index: b/drivers/media/pci/ddbridge/Kconfig
===================================================================
--- a/drivers/media/pci/ddbridge/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/pci/ddbridge/Kconfig	2019-04-12 12:21:18.146153988 +0200
@@ -35,7 +35,6 @@ config DVB_DDBRIDGE_MSIENABLE
 	bool "Enable Message Signaled Interrupts (MSI) per default (EXPERIMENTAL)"
 	depends on DVB_DDBRIDGE
 	depends on PCI_MSI
-	default n
 	help
 	  Use PCI MSI (Message Signaled Interrupts) per default. Enabling this
 	  might lead to I2C errors originating from the bridge in conjunction
Index: b/drivers/media/pci/dt3155/Kconfig
===================================================================
--- a/drivers/media/pci/dt3155/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/pci/dt3155/Kconfig	2019-04-12 12:21:01.678153573 +0200
@@ -2,7 +2,6 @@ config VIDEO_DT3155
 	tristate "DT3155 frame grabber"
 	depends on PCI && VIDEO_DEV && VIDEO_V4L2
 	select VIDEOBUF2_DMA_CONTIG
-	default n
 	help
 	  Enables dt3155 device driver for the DataTranslation DT3155 frame grabber.
 	  Say Y here if you have this hardware.
Index: b/drivers/media/pci/ivtv/Kconfig
===================================================================
--- a/drivers/media/pci/ivtv/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/pci/ivtv/Kconfig	2019-04-12 12:21:37.202154468 +0200
@@ -31,7 +31,6 @@ config VIDEO_IVTV
 config VIDEO_IVTV_DEPRECATED_IOCTLS
 	bool "enable the DVB ioctls abuse on ivtv driver"
 	depends on VIDEO_IVTV
-	default n
 	help
 	  Enable the usage of the a DVB set of ioctls that were abused by
 	  IVTV driver for a while.
@@ -76,7 +75,6 @@ config VIDEO_FB_IVTV
 config VIDEO_FB_IVTV_FORCE_PAT
 	bool "force cx23415 framebuffer init with x86 PAT enabled"
 	depends on VIDEO_FB_IVTV && X86_PAT
-	default n
 	help
 	  With PAT enabled, the cx23415 framebuffer driver does not
 	  utilize write-combined caching on the framebuffer memory.
Index: b/drivers/media/platform/Kconfig
===================================================================
--- a/drivers/media/platform/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/platform/Kconfig	2019-04-12 12:19:20.390151022 +0200
@@ -5,7 +5,6 @@
 menuconfig V4L_PLATFORM_DRIVERS
 	bool "V4L platform devices"
 	depends on MEDIA_CAMERA_SUPPORT
-	default n
 	help
 	  Say Y here to enable support for platform-specific V4L drivers.
 
@@ -154,7 +153,6 @@ config VIDEO_TI_CAL
 	depends on SOC_DRA7XX || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_FWNODE
-	default n
 	help
 	  Support for the TI CAL (Camera Adaptation Layer) block
 	  found on DRA72X SoC.
@@ -167,7 +165,6 @@ menuconfig V4L_MEM2MEM_DRIVERS
 	bool "Memory-to-memory multimedia devices"
 	depends on VIDEO_V4L2
 	depends on MEDIA_CAMERA_SUPPORT
-	default n
 	help
 	  Say Y here to enable selecting drivers for V4L devices that
 	  use system memory for both source and destination buffers, as opposed
@@ -235,7 +232,6 @@ config VIDEO_MEDIATEK_MDP
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	select VIDEO_MEDIATEK_VPU
-	default n
 	help
 	    It is a v4l2 driver and present in Mediatek MT8173 SoCs.
 	    The driver supports for scaling and color space conversion.
@@ -251,7 +247,6 @@ config VIDEO_MEDIATEK_VCODEC
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	select VIDEO_MEDIATEK_VPU
-	default n
 	help
 	    Mediatek video codec driver provides HW capability to
 	    encode and decode in a range of video formats
@@ -275,7 +270,6 @@ config VIDEO_SAMSUNG_S5P_G2D
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
-	default n
 	help
 	  This is a v4l2 driver for Samsung S5P and EXYNOS4 G2D
 	  2d graphics accelerator.
@@ -295,7 +289,6 @@ config VIDEO_SAMSUNG_S5P_MFC
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
-	default n
 	help
 	    MFC 5.1 and 6.x driver for V4L2
 
@@ -458,7 +451,6 @@ config VIDEO_ROCKCHIP_RGA
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select VIDEOBUF2_DMA_SG
 	select V4L2_MEM2MEM_DEV
-	default n
 	help
 	  This is a v4l2 driver for Rockchip SOC RGA 2d graphics accelerator.
 	  Rockchip RGA is a separate 2D raster graphic acceleration unit.
@@ -476,7 +468,6 @@ config VIDEO_TI_VPE
 	select VIDEO_TI_VPDMA
 	select VIDEO_TI_SC
 	select VIDEO_TI_CSC
-	default n
 	help
 	  Support for the TI VPE(Video Processing Engine) block
 	  found on DRA7XX SoC.
@@ -529,7 +520,6 @@ config VIDEO_VIM2M
 	depends on VIDEO_DEV && VIDEO_V4L2
 	select VIDEOBUF2_VMALLOC
 	select V4L2_MEM2MEM_DEV
-	default n
 	help
 	  This is a virtual test device for the memory-to-memory driver
 	  framework.
@@ -541,7 +531,6 @@ endif #V4L_TEST_DRIVERS
 menuconfig DVB_PLATFORM_DRIVERS
 	bool "DVB platform devices"
 	depends on MEDIA_DIGITAL_TV_SUPPORT
-	default n
 	help
 	  Say Y here to enable support for platform-specific Digital TV drivers.
 
@@ -661,7 +650,6 @@ endif #CEC_PLATFORM_DRIVERS
 menuconfig SDR_PLATFORM_DRIVERS
 	bool "SDR platform devices"
 	depends on MEDIA_SDR_SUPPORT
-	default n
 	help
 	  Say Y here to enable support for platform-specific SDR Drivers.
 
Index: b/drivers/media/platform/omap/Kconfig
===================================================================
--- a/drivers/media/platform/omap/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/platform/omap/Kconfig	2019-04-12 12:19:52.510151831 +0200
@@ -13,6 +13,5 @@ config VIDEO_OMAP2_VOUT
 	select VIDEOBUF_DMA_CONTIG
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
 	select FRAME_VECTOR
-	default n
 	help
 	  V4L2 Display driver support for OMAP2/3 based boards.
Index: b/drivers/media/platform/vicodec/Kconfig
===================================================================
--- a/drivers/media/platform/vicodec/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/platform/vicodec/Kconfig	2019-04-12 12:17:55.926148895 +0200
@@ -3,7 +3,6 @@ config VIDEO_VICODEC
 	depends on VIDEO_DEV && VIDEO_V4L2
 	select VIDEOBUF2_VMALLOC
 	select V4L2_MEM2MEM_DEV
-	default n
 	help
 	  Driver for a Virtual Codec
 
Index: b/drivers/media/platform/vimc/Kconfig
===================================================================
--- a/drivers/media/platform/vimc/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/platform/vimc/Kconfig	2019-04-12 12:21:54.838154912 +0200
@@ -3,7 +3,6 @@ config VIDEO_VIMC
 	depends on VIDEO_DEV && VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_VMALLOC
 	select VIDEO_V4L2_TPG
-	default n
 	help
 	  Skeleton driver for Virtual Media Controller
 
Index: b/drivers/media/platform/vivid/Kconfig
===================================================================
--- a/drivers/media/platform/vivid/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/platform/vivid/Kconfig	2019-04-12 12:22:10.306155301 +0200
@@ -10,7 +10,6 @@ config VIDEO_VIVID
 	select VIDEOBUF2_VMALLOC
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEO_V4L2_TPG
-	default n
 	help
 	  Enables a virtual video driver. This driver emulates a webcam,
 	  TV, S-Video and HDMI capture hardware, including VBI support for
Index: b/drivers/media/radio/Kconfig
===================================================================
--- a/drivers/media/radio/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/radio/Kconfig	2019-04-12 12:20:31.598152816 +0200
@@ -232,7 +232,6 @@ source "drivers/media/radio/wl128x/Kconf
 menuconfig V4L_RADIO_ISA_DRIVERS
 	bool "ISA radio devices"
 	depends on ISA || COMPILE_TEST
-	default n
 	help
 	  Say Y here to enable support for these ISA drivers.
 
Index: b/drivers/media/usb/s2255/Kconfig
===================================================================
--- a/drivers/media/usb/s2255/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/usb/s2255/Kconfig	2019-04-12 12:17:55.942148896 +0200
@@ -2,7 +2,6 @@ config USB_S2255
 	tristate "USB Sensoray 2255 video capture device"
 	depends on VIDEO_V4L2
 	select VIDEOBUF2_VMALLOC
-	default n
 	help
 	  Say Y here if you want support for the Sensoray 2255 USB device.
 	  This driver can be compiled as a module, called s2255drv.
Index: b/drivers/media/v4l2-core/Kconfig
===================================================================
--- a/drivers/media/v4l2-core/Kconfig	2019-04-12 12:17:55.946148896 +0200
+++ b/drivers/media/v4l2-core/Kconfig	2019-04-12 12:20:48.182153233 +0200
@@ -12,7 +12,6 @@ config VIDEO_V4L2
 
 config VIDEO_ADV_DEBUG
 	bool "Enable advanced debug functionality on V4L2 drivers"
-	default n
 	help
 	  Say Y here to enable advanced debugging functionality on some
 	  V4L devices.
@@ -20,7 +19,6 @@ config VIDEO_ADV_DEBUG
 
 config VIDEO_FIXED_MINOR_RANGES
 	bool "Enable old-style fixed minor ranges on drivers/video devices"
-	default n
 	help
 	  Say Y here to enable the old-style fixed-range minor assignments.
 	  Only useful if you rely on the old behavior and use mknod instead of udev.
