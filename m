Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C174CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F16B2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfDJO1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:27:04 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:54185 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731557AbfDJO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:27:03 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EEBnhlPxiNG8zEEBoh1ZaM; Wed, 10 Apr 2019 16:27:00 +0200
Subject: Re: [PATCH 4/7] media: atmel: atmel-isc: add support for
 DO_WHITE_BALANCE
To:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        Nicolas.Ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
Cc:     ksloat@aampglobal.com
References: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
 <1554807715-2353-5-git-send-email-eugen.hristev@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <08d1bf29-326b-7a8c-51c4-088d0effc4b6@xs4all.nl>
Date:   Wed, 10 Apr 2019 16:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554807715-2353-5-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKWAm2Zeo//0D0gTVO5lFbrWJNVsXMoXtGIzaisPdMlkN4g+8WoUJm1u8xcPTjsHsqLGIG8Fzn6ObINpf/591frm2OpztnwCEnZjxs/kaSaRyyfclT6z
 7uvRXTeJ/Iid+XLUCYqJsbWNrUUSrwci4dwLI9RHBk4D70R0bnXBk48+6Vp5MzQdeC+SWsQfgknWiIafzJN1EFAcG2+PZmWNc6gFmAke18TT36kyDRvXQzrs
 Cqls3s1PeULvtPLZSHNZ3jgxg0tPuUakrcxL6DcRBgRldjWk0Bbge6ExFgzt/h3dZx89Cak1VK2/8eEhW0nWJDx/YmObHpoRTA2RxsBL3TslAlA285+oOD8M
 AdfA1rZ5a/6731/aqrUTonvje18SPWudA4Ul1TMMhfMQmKufJ2xHPhlGhHSnWyfvi4BogAZ8FfLAZprRPupVevQVqYpStC1F50kvyFXUqFdmy7tXaHjWJa1R
 PeKVuooH6JhEV6Sd8i6g873Tq5Zl74L/ArHUsJxZ2nDMqLZ/0Ttbf3p9zJU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 1:07 PM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> This adds support for the 'button' control DO_WHITE_BALANCE
> This feature will enable the ISC to compute the white balance coefficients
> in a one time shot, at the user discretion.
> This can be used if a color chart/grey chart is present in front of the camera.
> The ISC will adjust the coefficients and have them fixed until next balance
> or until sensor mode is changed.
> This is particularly useful for white balance adjustment in different
> lighting scenarios, and then taking photos to similar scenery.
> The old auto white balance stays in place, where the ISC will adjust every
> 4 frames to the current scenery lighting, if the scenery is approximately
> grey in average, otherwise grey world algorithm fails.
> One time white balance adjustments needs streaming to be enabled, such that
> capture is enabled and the histogram has data to work with.
> Histogram without capture does not work in this hardware module.
> 
> To disable auto white balance feature (first step)
> v4l2-ctl --set-ctrl=white_balance_automatic=0
> 
> To start the one time white balance procedure:
> v4l2-ctl --set-ctrl=do_white_balance=1
> 
> User controls now include the do_white_balance ctrl:
> User Controls
> 
>                      brightness 0x00980900 (int)    : min=-1024 max=1023 step=1 default=0 value=0 flags=slider
>                        contrast 0x00980901 (int)    : min=-2048 max=2047 step=1 default=256 value=256 flags=slider
>         white_balance_automatic 0x0098090c (bool)   : default=1 value=1
>                do_white_balance 0x0098090d (button) : flags=write-only, execute-on-write
>                           gamma 0x00980910 (int)    : min=0 max=2 step=1 default=2 value=2 flags=slider
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/media/platform/atmel/atmel-isc.c | 74 +++++++++++++++++++++++++++++---
>  1 file changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
> index f6b8b00e..e516805 100644
> --- a/drivers/media/platform/atmel/atmel-isc.c
> +++ b/drivers/media/platform/atmel/atmel-isc.c
> @@ -167,6 +167,9 @@ struct isc_ctrls {
>  	u32 brightness;
>  	u32 contrast;
>  	u8 gamma_index;
> +#define ISC_WB_NONE	0
> +#define ISC_WB_AUTO	1
> +#define ISC_WB_ONETIME	2
>  	u8 awb;
>  
>  	/* one for each component : GR, R, GB, B */
> @@ -210,6 +213,7 @@ struct isc_device {
>  	struct fmt_config	try_config;
>  
>  	struct isc_ctrls	ctrls;
> +	struct v4l2_ctrl	*do_wb_ctrl;
>  	struct work_struct	awb_work;
>  
>  	struct mutex		lock;
> @@ -809,7 +813,7 @@ static void isc_set_pipeline(struct isc_device *isc, u32 pipeline)
>  
>  	bay_cfg = isc->config.sd_format->cfa_baycfg;
>  
> -	if (!ctrls->awb)
> +	if (ctrls->awb == ISC_WB_NONE)
>  		isc_reset_awb_ctrls(isc);
>  
>  	regmap_write(regmap, ISC_WB_CFG, bay_cfg);
> @@ -1928,7 +1932,7 @@ static void isc_awb_work(struct work_struct *w)
>  	baysel = isc->config.sd_format->cfa_baycfg << ISC_HIS_CFG_BAYSEL_SHIFT;
>  
>  	/* if no more auto white balance, reset controls. */
> -	if (!ctrls->awb)
> +	if (ctrls->awb == ISC_WB_NONE)
>  		isc_reset_awb_ctrls(isc);
>  
>  	pm_runtime_get_sync(isc->dev);
> @@ -1937,7 +1941,7 @@ static void isc_awb_work(struct work_struct *w)
>  	 * only update if we have all the required histograms and controls
>  	 * if awb has been disabled, we need to reset registers as well.
>  	 */
> -	if (hist_id == ISC_HIS_CFG_MODE_GR || !ctrls->awb) {
> +	if (hist_id == ISC_HIS_CFG_MODE_GR || ctrls->awb == ISC_WB_NONE) {
>  		/*
>  		 * It may happen that DMA Done IRQ will trigger while we are
>  		 * updating white balance registers here.
> @@ -1947,6 +1951,16 @@ static void isc_awb_work(struct work_struct *w)
>  		spin_lock_irqsave(&isc->awb_lock, flags);
>  		isc_update_awb_ctrls(isc);
>  		spin_unlock_irqrestore(&isc->awb_lock, flags);
> +
> +		/*
> +		 * if we are doing just the one time white balance adjustment,
> +		 * we are basically done.
> +		 */
> +		if (ctrls->awb == ISC_WB_ONETIME) {
> +			v4l2_info(&isc->v4l2_dev,
> +				  "Completed one time white-balance adjustment.\n");
> +			ctrls->awb = ISC_WB_NONE;
> +		}
>  	}
>  	regmap_write(regmap, ISC_HIS_CFG, hist_id | baysel | ISC_HIS_CFG_RAR);
>  	isc_update_profile(isc);
> @@ -1974,10 +1988,56 @@ static int isc_s_ctrl(struct v4l2_ctrl *ctrl)
>  		ctrls->gamma_index = ctrl->val;
>  		break;
>  	case V4L2_CID_AUTO_WHITE_BALANCE:
> -		ctrls->awb = ctrl->val;
> +		if (ctrl->val == 1) {
> +			ctrls->awb = ISC_WB_AUTO;
> +			v4l2_ctrl_activate(isc->do_wb_ctrl, false);
> +		} else {
> +			ctrls->awb = ISC_WB_NONE;
> +			v4l2_ctrl_activate(isc->do_wb_ctrl, true);
> +		}
> +		/* we did not configure ISC yet */
> +		if (!isc->config.sd_format)
> +			break;
> +
> +		if (!ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code)) {
> +			v4l2_err(&isc->v4l2_dev,
> +				 "White balance adjustments available only if sensor is in RAW mode.\n");

This isn't an error, instead if the format isn't raw, then deactivate
the control (see v4l2_ctrl_activate()). That way the control framework
will handle this.

> +			return 0;
> +		}
> +
>  		if (ctrls->hist_stat != HIST_ENABLED) {
>  			isc_reset_awb_ctrls(isc);
>  		}
> +
> +		if (isc->ctrls.awb && vb2_is_streaming(&isc->vb2_vidq) &&
> +		    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
> +			isc_set_histogram(isc, true);
> +
> +		break;
> +	case V4L2_CID_DO_WHITE_BALANCE:
> +		/* we did not configure ISC yet */
> +		if (!isc->config.sd_format)
> +			break;
> +
> +		if (ctrls->awb == ISC_WB_AUTO) {
> +			v4l2_err(&isc->v4l2_dev,
> +				 "To use one time white-balance adjustment, disable auto white balance first.\n");

I'd do this differently: if auto whitebalance is already on, then just do
nothing for V4L2_CID_DO_WHITE_BALANCE.

> +			return -EAGAIN;
> +		}
> +		if (!vb2_is_streaming(&isc->vb2_vidq)) {
> +			v4l2_err(&isc->v4l2_dev,
> +				 "One time white-balance adjustment requires streaming to be enabled.\n");

This too should use v4l2_ctrl_activate(): activate the control in start_streaming,
deactivate in stop_streaming (and when the control is created).

> +			return -EAGAIN;
> +		}
> +
> +		if (!ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code)) {
> +			v4l2_err(&isc->v4l2_dev,
> +				 "White balance adjustments available only if sensor is in RAW mode.\n");

Same note as above: use v4l2_ctrl_activate() for this.

> +			return -EAGAIN;
> +		}
> +		ctrls->awb = ISC_WB_ONETIME;
> +		isc_set_histogram(isc, true);
> +		v4l2_info(&isc->v4l2_dev, "One time white-balance started.\n");

Make this v4l2_dbg.

>  		break;
>  	default:
>  		return -EINVAL;
> @@ -2000,7 +2060,7 @@ static int isc_ctrl_init(struct isc_device *isc)
>  	ctrls->hist_stat = HIST_INIT;
>  	isc_reset_awb_ctrls(isc);
>  
> -	ret = v4l2_ctrl_handler_init(hdl, 4);
> +	ret = v4l2_ctrl_handler_init(hdl, 5);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2012,6 +2072,10 @@ static int isc_ctrl_init(struct isc_device *isc)
>  	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAMMA, 0, GAMMA_MAX, 1, 2);
>  	v4l2_ctrl_new_std(hdl, ops, V4L2_CID_AUTO_WHITE_BALANCE, 0, 1, 1, 1);
>  
> +	/* do_white_balance is a button, so min,max,step,default are ignored */
> +	isc->do_wb_ctrl = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_DO_WHITE_BALANCE,
> +					    0, 0, 0, 0);
> +
>  	v4l2_ctrl_handler_setup(hdl);
>  
>  	return 0;
> 

Regards,

	Hans
