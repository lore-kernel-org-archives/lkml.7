Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC4FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D25218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfDXQgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:36:06 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:59628 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfDXQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:36:05 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 36838200A9;
        Wed, 24 Apr 2019 18:35:59 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:35:57 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Da Lv <lvda3@hisilicon.com>, Yidong Lin <linyidong@huawei.com>
Subject: Re: [PATCH 01/25] drm: kirin: Fix for hikey620 display offset problem
Message-ID: <20190424163557.GA20110@ravnborg.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-2-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556061656-1733-2-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=BTeA3XvPAAAA:8
        a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8
        a=RKH4bx07Hjnu1yHLGE4A:9 a=CjuIK1q_8ugA:10 a=tafbbOV3vt1XuEhzTjGK:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

On Tue, Apr 23, 2019 at 04:20:32PM -0700, John Stultz wrote:
> From: Da Lv <lvda3@hisilicon.com>
> 
> The original HiKey (620) board has had a long running issue
> where when using a 1080p montior, the display would occasionally
> blink and come come back with a horizontal offset (usually also
> shifting the colors, depending on the value of the offset%4).
> 
> After lots of analysis by HiSi developers, they found the issue
> was due to when running at 1080p, it was possible to hit the
> device memory bandwidth limits, which could cause the DSI signal
> to get out of sync.
> 
> Unfortunately the DSI logic doesn't have the ability to
> automatically recover from this situation, but we can get a an
> LDI underflow interrupt when it happens.
> 
> To then correct the issue, when we get an LDI underflow irq, we
> we can simply suspend and resume the display, which resets the
> hardware.
> 
> Thus, this patch enables the ldi underflow interrupt, and
> initializes a workqueue that is used to suspend/resume the
> display to recover. Then when the irq occurs we clear it and
> schedule the workqueue to reset display engine.
> 
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Signed-off-by: Da Lv <lvda3@hisilicon.com>
> Signed-off-by: Yidong Lin <linyidong@huawei.com>
> [jstultz: Reworded the commit message, checkpatch cleanups]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Minor cleanups
> ---
>  drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h |  6 ++++++
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> index 4cf281b7..ced40c6 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> @@ -87,6 +87,7 @@
>  #define VSIZE_OFST			20
>  #define LDI_INT_EN			0x741C
>  #define FRAME_END_INT_EN_OFST		1
> +#define UNDERFLOW_INT_EN_OFST		2
>  #define LDI_CTRL			0x7420
>  #define BPP_OFST			3
>  #define DATA_GATE_EN			BIT(2)
> @@ -97,6 +98,11 @@
>  #define LDI_HDMI_DSI_GT			0x7434
>  
>  /*
> + *BIT_LDI_UNFLOW
> + */
> +#define BIT_LDI_UNFLOW         BIT(2)

The definition of this bit looks not like anything surrounding it.
And it is not obvious that this bit is part of LDI_MSK_INT.
Consider to reformat this so it is obvious where this bit belongs
when reading the .h file.


> +
> +/*
>   * ADE media bus service regs
>   */
>  #define ADE0_QOSGENERATOR_MODE		0x010C
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 73611a9..beb2a3c 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -58,6 +58,7 @@ struct ade_hw_ctx {
>  struct ade_crtc {
>  	struct drm_crtc base;
>  	struct ade_hw_ctx *ctx;
> +	struct work_struct drm_device_wq;
>  	bool enable;
>  	u32 out_format;
>  };
> @@ -176,6 +177,7 @@ static void ade_init(struct ade_hw_ctx *ctx)
>  	 */
>  	ade_update_bits(base + ADE_CTRL, FRM_END_START_OFST,
>  			FRM_END_START_MASK, REG_EFFECTIVE_IN_ADEEN_FRMEND);
> +	ade_update_bits(base + LDI_INT_EN, UNDERFLOW_INT_EN_OFST, MASK(1), 1);
>  }
>  
>  static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
> @@ -345,6 +347,17 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
>  			MASK(1), 0);
>  }
>  
> +static void drm_underflow_wq(struct work_struct *work)
> +{
> +	struct ade_crtc *acrtc = container_of(work, struct ade_crtc,
> +					      drm_device_wq);
> +	struct drm_device *drm_dev = (&acrtc->base)->dev;
> +	struct drm_atomic_state *state;
> +
> +	state = drm_atomic_helper_suspend(drm_dev);
> +	drm_atomic_helper_resume(drm_dev, state);
> +}
> +
>  static irqreturn_t ade_irq_handler(int irq, void *data)
>  {
>  	struct ade_crtc *acrtc = data;
> @@ -362,6 +375,12 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
>  				MASK(1), 1);
>  		drm_crtc_handle_vblank(crtc);
>  	}
> +	if (status & BIT_LDI_UNFLOW) {
> +		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
> +				MASK(1), 1);
A general comment here.
It is not obvious from reading this code that the code will clear
LDI_UNFLOW bit in the LDI_INT_CLR register.

I think this driver could see readability improvements
if converted to use regmaps.

	Sam
