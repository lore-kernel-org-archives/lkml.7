Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C06C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847A021479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfDTBKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 21:10:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfDTBKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 21:10:43 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 95CADB52F90959D4F936;
        Sat, 20 Apr 2019 09:10:39 +0800 (CST)
Received: from [127.0.0.1] (10.57.77.74) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Sat, 20 Apr 2019
 09:10:29 +0800
Subject: Re: [PATCH] drm: kirin: Fix for hikey620 display offset problem
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1555696800-15961-1-git-send-email-john.stultz@linaro.org>
CC:     Da Lv <lvda3@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>,
        "Xinwei Kong" <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yidong Lin <linyidong@huawei.com>
From:   xinliang <z.liuxinliang@hisilicon.com>
Message-ID: <5CBA7185.8000900@hisilicon.com>
Date:   Sat, 20 Apr 2019 09:10:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1555696800-15961-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.77.74]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/20 2:00, John Stultz wrote:
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
Thanks for the patch John,
Reviewed-by:  Xinliang Liu <z.liuxinliang@hisilicon.com>

Xinliang
> Change-Id: I792ce0b50a1c941d94d8cbec6b52c0f838d967bd
> ---
>   drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h |  6 ++++++
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 23 +++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> index 4cf281b7..ced40c6 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> @@ -87,6 +87,7 @@
>   #define VSIZE_OFST			20
>   #define LDI_INT_EN			0x741C
>   #define FRAME_END_INT_EN_OFST		1
> +#define UNDERFLOW_INT_EN_OFST		2
>   #define LDI_CTRL			0x7420
>   #define BPP_OFST			3
>   #define DATA_GATE_EN			BIT(2)
> @@ -97,6 +98,11 @@
>   #define LDI_HDMI_DSI_GT			0x7434
>   
>   /*
> + *BIT_LDI_UNFLOW
> + */
> +#define BIT_LDI_UNFLOW         BIT(2)
> +
> +/*
>    * ADE media bus service regs
>    */
>   #define ADE0_QOSGENERATOR_MODE		0x010C
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 73611a9..1d935ab 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -58,6 +58,7 @@ struct ade_hw_ctx {
>   struct ade_crtc {
>   	struct drm_crtc base;
>   	struct ade_hw_ctx *ctx;
> +	struct work_struct drm_device_wq;
>   	bool enable;
>   	u32 out_format;
>   };
> @@ -176,6 +177,7 @@ static void ade_init(struct ade_hw_ctx *ctx)
>   	 */
>   	ade_update_bits(base + ADE_CTRL, FRM_END_START_OFST,
>   			FRM_END_START_MASK, REG_EFFECTIVE_IN_ADEEN_FRMEND);
> +	ade_update_bits(base + LDI_INT_EN, UNDERFLOW_INT_EN_OFST, MASK(1), 1);
>   }
>   
>   static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
> @@ -345,6 +347,18 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
>   			MASK(1), 0);
>   }
>   
> +static void drm_underflow_wq(struct work_struct *work)
> +{
> +	struct ade_crtc *acrtc = container_of(work, struct ade_crtc,
> +					      drm_device_wq);
> +	struct drm_device *drm_dev = (&acrtc->base)->dev;
> +	void __iomem *base = acrtc->ctx->base;
> +	struct drm_atomic_state *state;
> +
> +	state = drm_atomic_helper_suspend(drm_dev);
> +	drm_atomic_helper_resume(drm_dev, state);
> +}
> +
>   static irqreturn_t ade_irq_handler(int irq, void *data)
>   {
>   	struct ade_crtc *acrtc = data;
> @@ -362,6 +376,12 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
>   				MASK(1), 1);
>   		drm_crtc_handle_vblank(crtc);
>   	}
> +	if (status & BIT_LDI_UNFLOW) {
> +		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
> +				MASK(1), 1);
> +		DRM_ERROR("LDI underflow!");
> +		schedule_work(&acrtc->drm_device_wq);
> +	}
>   
>   	return IRQ_HANDLED;
>   }
> @@ -1038,6 +1058,9 @@ static int ade_drm_init(struct platform_device *pdev)
>   	/* vblank irq init */
>   	ret = devm_request_irq(dev->dev, ctx->irq, ade_irq_handler,
>   			       IRQF_SHARED, dev->driver->name, acrtc);
> +
> +	INIT_WORK(&acrtc->drm_device_wq, drm_underflow_wq);
> +
>   	if (ret)
>   		return ret;
>   


