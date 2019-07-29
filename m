Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC52C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2265F217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfG2QBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:01:12 -0400
Received: from foss.arm.com ([217.140.110.172]:46406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfG2QBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:01:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940CA337;
        Mon, 29 Jul 2019 09:01:10 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57F393F694;
        Mon, 29 Jul 2019 09:01:10 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 19E4E682408; Mon, 29 Jul 2019 17:01:09 +0100 (BST)
Date:   Mon, 29 Jul 2019 17:01:09 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH 1/2] drm/komeda: Use drm_display_mode "crtc_" prefixed
 hardware timings
Message-ID: <20190729160108.hpllmaojdohe3b3e@e110455-lin.cambridge.arm.com>
References: <20190618081013.13638-1-james.qian.wang@arm.com>
 <20190618081013.13638-2-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190618081013.13638-2-james.qian.wang@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:10:40AM +0100, james qian wang (Arm Technology China) wrote:
> struct drm_display_mode contains two copies of timings.
> - plain timings.
> - hardware timings, the ones with "crtc_" prefix.
> According to the definition, update komeda to use the hardware timing.
> 
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  .../arm/display/komeda/d71/d71_component.c    | 36 ++++++++++++-------
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 ++++++-----
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 --
>  3 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 87248babca1f..049e8bfac27b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -937,7 +937,7 @@ static int d71_downscaling_clk_check(struct komeda_pipeline *pipe,
>  		denominator = (mode->htotal - 1) * v_out -  2 * v_in;
>  	}
> 
> -	return aclk_rate * denominator >= mode->clock * 1000 * fraction ?
> +	return aclk_rate * denominator >= mode->crtc_clock * 1000 * fraction ?
>  	       0 : -EINVAL;
>  }
> 
> @@ -1056,21 +1056,31 @@ static void d71_timing_ctrlr_update(struct komeda_component *c,
>  				    struct komeda_component_state *state)
>  {
>  	struct drm_crtc_state *crtc_st = state->crtc->state;
> +	struct drm_display_mode *mode = &crtc_st->adjusted_mode;
>  	u32 __iomem *reg = c->reg;
> -	struct videomode vm;
> +	u32 hactive, hfront_porch, hback_porch, hsync_len;
> +	u32 vactive, vfront_porch, vback_porch, vsync_len;
>  	u32 value;
> 
> -	drm_display_mode_to_videomode(&crtc_st->adjusted_mode, &vm);
> -
> -	malidp_write32(reg, BS_ACTIVESIZE, HV_SIZE(vm.hactive, vm.vactive));
> -	malidp_write32(reg, BS_HINTERVALS, BS_H_INTVALS(vm.hfront_porch,
> -							vm.hback_porch));
> -	malidp_write32(reg, BS_VINTERVALS, BS_V_INTVALS(vm.vfront_porch,
> -							vm.vback_porch));
> -
> -	value = BS_SYNC_VSW(vm.vsync_len) | BS_SYNC_HSW(vm.hsync_len);
> -	value |= vm.flags & DISPLAY_FLAGS_VSYNC_HIGH ? BS_SYNC_VSP : 0;
> -	value |= vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ? BS_SYNC_HSP : 0;
> +	hactive = mode->crtc_hdisplay;
> +	hfront_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
> +	hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
> +	hback_porch = mode->crtc_htotal - mode->crtc_hsync_end;
> +
> +	vactive = mode->crtc_vdisplay;
> +	vfront_porch = mode->crtc_vsync_start - mode->crtc_vdisplay;
> +	vsync_len = mode->crtc_vsync_end - mode->crtc_vsync_start;
> +	vback_porch = mode->crtc_vtotal - mode->crtc_vsync_end;
> +
> +	malidp_write32(reg, BS_ACTIVESIZE, HV_SIZE(hactive, vactive));
> +	malidp_write32(reg, BS_HINTERVALS, BS_H_INTVALS(hfront_porch,
> +							hback_porch));
> +	malidp_write32(reg, BS_VINTERVALS, BS_V_INTVALS(vfront_porch,
> +							vback_porch));
> +
> +	value = BS_SYNC_VSW(vsync_len) | BS_SYNC_HSW(hsync_len);
> +	value |= mode->flags & DRM_MODE_FLAG_PVSYNC ? BS_SYNC_VSP : 0;
> +	value |= mode->flags & DRM_MODE_FLAG_PHSYNC ? BS_SYNC_HSP : 0;
>  	malidp_write32(reg, BS_SYNC, value);
> 
>  	malidp_write32(reg, BS_PROG_LINE, D71_DEFAULT_PREPRETCH_LINE - 1);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 1b4ea8ab41fa..98e36e1fb2ad 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -27,7 +27,7 @@ static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc_st)
>  		return;
>  	}
> 
> -	pxlclk = kcrtc_st->base.adjusted_mode.clock * 1000;
> +	pxlclk = kcrtc_st->base.adjusted_mode.crtc_clock * 1000;
>  	aclk = komeda_calc_aclk(kcrtc_st) << 32;
> 
>  	do_div(aclk, pxlclk);
> @@ -78,9 +78,9 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
>  unsigned long komeda_calc_aclk(struct komeda_crtc_state *kcrtc_st)
>  {
>  	struct komeda_dev *mdev = kcrtc_st->base.crtc->dev->dev_private;
> -	unsigned long pxlclk = kcrtc_st->base.adjusted_mode.clock;
> +	unsigned long aclk = kcrtc_st->base.adjusted_mode.crtc_clock;
> 
> -	return clk_round_rate(mdev->aclk, pxlclk * 1000);
> +	return clk_round_rate(mdev->aclk, aclk * 1000);
>  }
> 
>  /* For active a crtc, mainly need two parts of preparation
> @@ -93,7 +93,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  	struct komeda_dev *mdev = kcrtc->base.dev->dev_private;
>  	struct komeda_pipeline *master = kcrtc->master;
>  	struct komeda_crtc_state *kcrtc_st = to_kcrtc_st(kcrtc->base.state);
> -	unsigned long pxlclk_rate = kcrtc_st->base.adjusted_mode.clock * 1000;
> +	struct drm_display_mode *mode = &kcrtc_st->base.adjusted_mode;
>  	u32 new_mode;
>  	int err;
> 
> @@ -127,7 +127,7 @@ komeda_crtc_prepare(struct komeda_crtc *kcrtc)
>  			DRM_ERROR("failed to enable aclk.\n");
>  	}
> 
> -	err = clk_set_rate(master->pxlclk, pxlclk_rate);
> +	err = clk_set_rate(master->pxlclk, mode->crtc_clock * 1000);
>  	if (err)
>  		DRM_ERROR("failed to set pxlclk for pipe%d\n", master->id);
>  	err = clk_prepare_enable(master->pxlclk);
> @@ -380,10 +380,14 @@ static bool komeda_crtc_mode_fixup(struct drm_crtc *crtc,
>  				   struct drm_display_mode *adjusted_mode)
>  {
>  	struct komeda_crtc *kcrtc = to_kcrtc(crtc);
> -	struct komeda_pipeline *master = kcrtc->master;
> -	long mode_clk = m->clock * 1000;
> +	unsigned long clk_rate;
> +
> +	drm_mode_set_crtcinfo(adjusted_mode, 0);
> 
> -	adjusted_mode->clock = clk_round_rate(master->pxlclk, mode_clk) / 1000;
> +	clk_rate = adjusted_mode->crtc_clock * 1000;
> +	/* crtc_clock will be used as the komeda output pixel clock */
> +	adjusted_mode->crtc_clock = clk_round_rate(kcrtc->master->pxlclk,
> +						   clk_rate) / 1000;
> 
>  	return true;
>  }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> index 219fa3f0c336..af6af1d55643 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -14,8 +14,6 @@
>  #include <drm/drm_device.h>
>  #include <drm/drm_writeback.h>
>  #include <drm/drm_print.h>
> -#include <video/videomode.h>
> -#include <video/display_timing.h>
> 
>  /**
>   * struct komeda_plane - komeda instance of drm_plane
> --
> 2.17.1

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
