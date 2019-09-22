Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E483BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD50208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbfIVWxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:53:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:43447 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388766AbfIVWxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:53:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Sep 2019 15:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,538,1559545200"; 
   d="scan'208";a="182339433"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2019 15:52:59 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iCAix-0002dh-6t; Mon, 23 Sep 2019 06:52:59 +0800
Date:   Mon, 23 Sep 2019 06:52:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     kbuild-all@01.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 2/2] drm/bridge: Add NWL MIPI DSI host controller
 support
Message-ID: <201909230644.qfSKbNf9%lkp@intel.com>
References: <c0ac0b203fb65ae7efd1b9b54664b491ca2fb157.1569170717.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ac0b203fb65ae7efd1b9b54664b491ca2fb157.1569170717.git.agx@sigxcpu.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Guido,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3 next-20190920]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Guido-G-nther/drm-bridge-Add-NWL-MIPI-DSI-host-controller-support/20190923-005010

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

smatch warnings:
drivers/gpu/drm/bridge/nwl-dsi.c:272 nwl_dsi_config_dpi() warn: unsigned 'color_format' is never less than zero.

vim +/color_format +272 drivers/gpu/drm/bridge/nwl-dsi.c

   245	
   246	static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
   247	{
   248		u32 color_format, mode;
   249		bool burst_mode;
   250		int hfront_porch, hback_porch, vfront_porch, vback_porch;
   251		int hsync_len, vsync_len;
   252	
   253		hfront_porch = dsi->mode.hsync_start - dsi->mode.hdisplay;
   254		hsync_len = dsi->mode.hsync_end - dsi->mode.hsync_start;
   255		hback_porch = dsi->mode.htotal - dsi->mode.hsync_end;
   256	
   257		vfront_porch = dsi->mode.vsync_start - dsi->mode.vdisplay;
   258		vsync_len = dsi->mode.vsync_end - dsi->mode.vsync_start;
   259		vback_porch = dsi->mode.vtotal - dsi->mode.vsync_end;
   260	
   261		DRM_DEV_DEBUG_DRIVER(dsi->dev, "hfront_porch = %d\n", hfront_porch);
   262		DRM_DEV_DEBUG_DRIVER(dsi->dev, "hback_porch = %d\n", hback_porch);
   263		DRM_DEV_DEBUG_DRIVER(dsi->dev, "hsync_len = %d\n", hsync_len);
   264		DRM_DEV_DEBUG_DRIVER(dsi->dev, "hdisplay = %d\n", dsi->mode.hdisplay);
   265		DRM_DEV_DEBUG_DRIVER(dsi->dev, "vfront_porch = %d\n", vfront_porch);
   266		DRM_DEV_DEBUG_DRIVER(dsi->dev, "vback_porch = %d\n", vback_porch);
   267		DRM_DEV_DEBUG_DRIVER(dsi->dev, "vsync_len = %d\n", vsync_len);
   268		DRM_DEV_DEBUG_DRIVER(dsi->dev, "vactive = %d\n", dsi->mode.vdisplay);
   269		DRM_DEV_DEBUG_DRIVER(dsi->dev, "clock = %d kHz\n", dsi->mode.clock);
   270	
   271		color_format = nwl_dsi_get_dpi_pixel_format(dsi->format);
 > 272		if (color_format < 0) {
   273			DRM_DEV_ERROR(dsi->dev, "Invalid color format 0x%x\n",
   274				      dsi->format);
   275			return color_format;
   276		}
   277		DRM_DEV_DEBUG_DRIVER(dsi->dev, "pixel fmt = %d\n", dsi->format);
   278	
   279		nwl_dsi_write(dsi, NWL_DSI_INTERFACE_COLOR_CODING, NWL_DSI_DPI_24_BIT);
   280		nwl_dsi_write(dsi, NWL_DSI_PIXEL_FORMAT, color_format);
   281		/*
   282		 * Adjusting input polarity based on the video mode results in
   283		 * a black screen so always pick active low:
   284		 */
   285		nwl_dsi_write(dsi, NWL_DSI_VSYNC_POLARITY,
   286			      NWL_DSI_VSYNC_POLARITY_ACTIVE_LOW);
   287		nwl_dsi_write(dsi, NWL_DSI_HSYNC_POLARITY,
   288			      NWL_DSI_HSYNC_POLARITY_ACTIVE_LOW);
   289	
   290		burst_mode = (dsi->dsi_mode_flags & MIPI_DSI_MODE_VIDEO_BURST) &&
   291			     !(dsi->dsi_mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE);
   292	
   293		if (burst_mode) {
   294			nwl_dsi_write(dsi, NWL_DSI_VIDEO_MODE, NWL_DSI_VM_BURST_MODE);
   295			nwl_dsi_write(dsi, NWL_DSI_PIXEL_FIFO_SEND_LEVEL, 256);
   296		} else {
   297			mode = ((dsi->dsi_mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) ?
   298					NWL_DSI_VM_BURST_MODE_WITH_SYNC_PULSES :
   299					NWL_DSI_VM_NON_BURST_MODE_WITH_SYNC_EVENTS);
   300			nwl_dsi_write(dsi, NWL_DSI_VIDEO_MODE, mode);
   301			nwl_dsi_write(dsi, NWL_DSI_PIXEL_FIFO_SEND_LEVEL,
   302				      dsi->mode.hdisplay);
   303		}
   304	
   305		nwl_dsi_write(dsi, NWL_DSI_HFP, hfront_porch);
   306		nwl_dsi_write(dsi, NWL_DSI_HBP, hback_porch);
   307		nwl_dsi_write(dsi, NWL_DSI_HSA, hsync_len);
   308	
   309		nwl_dsi_write(dsi, NWL_DSI_ENABLE_MULT_PKTS, 0x0);
   310		nwl_dsi_write(dsi, NWL_DSI_BLLP_MODE, 0x1);
   311		nwl_dsi_write(dsi, NWL_DSI_USE_NULL_PKT_BLLP, 0x0);
   312		nwl_dsi_write(dsi, NWL_DSI_VC, 0x0);
   313	
   314		nwl_dsi_write(dsi, NWL_DSI_PIXEL_PAYLOAD_SIZE, dsi->mode.hdisplay);
   315		nwl_dsi_write(dsi, NWL_DSI_VACTIVE, dsi->mode.vdisplay - 1);
   316		nwl_dsi_write(dsi, NWL_DSI_VBP, vback_porch);
   317		nwl_dsi_write(dsi, NWL_DSI_VFP, vfront_porch);
   318	
   319		return 0;
   320	}
   321	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
