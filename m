Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BFDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1816206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfDXQqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:46:50 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:60004 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730997AbfDXQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:46:50 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8A9D720090;
        Wed, 24 Apr 2019 18:46:46 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:46:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [PATCH 10/25] drm: kirin: Move workqueue to ade_hw_ctx structure
Message-ID: <20190424164645.GC20110@ravnborg.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-11-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556061656-1733-11-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=BTeA3XvPAAAA:8
        a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=MpCnRSpsgUjHPVZ81QoA:9
        a=CjuIK1q_8ugA:10 a=tafbbOV3vt1XuEhzTjGK:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

On Tue, Apr 23, 2019 at 04:20:41PM -0700, John Stultz wrote:
> The workqueue used to reset the display when we hit an LDI
> underflow error is ADE specific, so since this patch series
> works to make the kirin_crtc structure more generic, move the
> workqueue to the ade_hw_ctx structure instead.
> 
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 94dcad0..f54cf99 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -52,6 +52,7 @@ struct ade_hw_ctx {
>  	struct clk *media_noc_clk;
>  	struct clk *ade_pix_clk;
>  	struct reset_control *reset;
> +	struct work_struct drm_device_wq;

The comment probarly belongs to 01/25...
The name drm_device_wq is not at all descriptive.
Consider something like: display_reset_wq

Then when the workqueue is started it is much more obvious what it does.

>  	bool power_on;
>  	int irq;
>  
> @@ -61,7 +62,6 @@ struct ade_hw_ctx {
>  struct kirin_crtc {
>  	struct drm_crtc base;
>  	void *hw_ctx;
> -	struct work_struct drm_device_wq;
>  	bool enable;
>  };
>  
> @@ -349,9 +349,9 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
>  
>  static void drm_underflow_wq(struct work_struct *work)
>  {
> -	struct kirin_crtc *acrtc = container_of(work, struct kirin_crtc,
> +	struct ade_hw_ctx *ctx = container_of(work, struct ade_hw_ctx,
>  					      drm_device_wq);
> -	struct drm_device *drm_dev = (&acrtc->base)->dev;
> +	struct drm_device *drm_dev = ctx->crtc->dev;
>  	struct drm_atomic_state *state;
>  
>  	state = drm_atomic_helper_suspend(drm_dev);
> @@ -362,7 +362,6 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
>  {
>  	struct ade_hw_ctx *ctx = data;
>  	struct drm_crtc *crtc = ctx->crtc;
> -	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
>  	void __iomem *base = ctx->base;
>  	u32 status;
>  
> @@ -379,7 +378,7 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
>  		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
>  				MASK(1), 1);
>  		DRM_ERROR("LDI underflow!");
> -		schedule_work(&kcrtc->drm_device_wq);

Compare:
> +		schedule_work(&ctx->drm_device_wq);

With
> +		schedule_work(&ctx->display_reset_wq);

The latter wins in readability.

	Sam
