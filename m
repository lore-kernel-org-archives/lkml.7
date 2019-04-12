Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C670C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520A520818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfDLIuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:50:18 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:42825 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbfDLIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:50:17 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id ErsxhzLFANG8zErsyhBrn9; Fri, 12 Apr 2019 10:50:13 +0200
Subject: Re: [PATCH v9 1/4] cx25840: add pin to pad mapping and output format
 configuration
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
References: <cover.1553903063.git.mail@maciej.szmigiero.name>
 <ca0822b126978220ac72215e08524b6f81292b6a.1553903063.git.mail@maciej.szmigiero.name>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <37d3242d-79f8-ada1-59ac-c69d095f55da@xs4all.nl>
Date:   Fri, 12 Apr 2019 10:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ca0822b126978220ac72215e08524b6f81292b6a.1553903063.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJHgJ4KEFH8WkuZrN+JiQnRVBCsO0j67fwQbxxgtuHCsDL5JV4y9C0PFySe3vllzYSQeStiaIrVilwAixAauvF8VusVG1HcE0OAVhC7XQ6Djjzn1Je1u
 GJVYtEZfrsesPZsoS/+8m/hK8lzRDhJ1IIodtdX6jOuJzP72jLRKAznkwi2DiTQaSShl3qijXDIDXyhOS4Q6ctokVCBOqnmMOg/jeVXdF9+ePdiHcJQQu68a
 yEiz4Ht5OADdZg+tBe0HSqHhdj76lP1CN13aJQPwwtWOXBlCUyTU1KgKug21MBDMtfFsgHtxN7OiH9RMVD4FOPB2xumA9o9zPRo7k3pwzunlf7aOLr7xb+pK
 dS3ZlmqWPI9/vgl0nk7tJ/B/id4dMHtiPzP3n0S+M7ZILUj28oK2W2imtdKkGGLryRSEb+6A0FVZERTP9LrsbBWvteR1dowFLmlyIVsQkAifCmV9qj0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

Yes, I know, I have been ignoring this patch series for too long, mostly because
reviewing this is time consuming and because it is so easy to break existing
functionality.

But I finally have some time to do a review and I do think it is close to being
ready for merging.

Some comments below:

On 3/30/19 12:51 AM, Maciej S. Szmigiero wrote:
> This commit adds pin to pad mapping and output format configuration support
> in CX2584x-series chips to cx25840 driver.
> 
> This functionality is then used to allow disabling ivtv-specific hacks
> (called a "generic mode"), so cx25840 driver can be used for other devices
> not needing them without risking compatibility problems.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  drivers/media/i2c/cx25840/cx25840-core.c | 376 ++++++++++++++++++++++-
>  drivers/media/i2c/cx25840/cx25840-core.h |  12 +
>  drivers/media/i2c/cx25840/cx25840-vbi.c  |   3 +
>  include/media/drv-intf/cx25840.h         |  66 +++-
>  4 files changed, 455 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/cx25840/cx25840-core.c b/drivers/media/i2c/cx25840/cx25840-core.c
> index 8b0b8b5aa531..3269cde280e6 100644
> --- a/drivers/media/i2c/cx25840/cx25840-core.c
> +++ b/drivers/media/i2c/cx25840/cx25840-core.c
> @@ -21,6 +21,9 @@
>   * CX23888 DIF support for the HVR1850
>   * Copyright (C) 2011 Steven Toth <stoth@kernellabs.com>
>   *
> + * CX2584x pin to pad mapping and output format configuration support are
> + * Copyright (C) 2011 Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> + *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
>   * as published by the Free Software Foundation; either version 2
> @@ -316,6 +319,217 @@ static int cx23885_s_io_pin_config(struct v4l2_subdev *sd, size_t n,
>  	return 0;
>  }
>  
> +static u8 cx25840_function_to_pad(struct i2c_client *client, u8 function)
> +{
> +	if (function > CX25840_PAD_VRESET) {
> +		v4l_err(client, "invalid function %u, assuming default\n",
> +			(unsigned int)function);
> +		return 0;
> +	}
> +
> +	return function;
> +}
> +
> +static void cx25840_set_invert(u8 *pinctrl3, u8 *voutctrl4, u8 function,
> +			       u8 pin, bool invert)
> +{
> +	switch (function) {
> +	case CX25840_PAD_IRQ_N:
> +		if (invert)
> +			*pinctrl3 &= ~2;
> +		else
> +			*pinctrl3 |= 2;
> +		break;
> +
> +	case CX25840_PAD_ACTIVE:
> +		if (invert)
> +			*voutctrl4 |= BIT(2);
> +		else
> +			*voutctrl4 &= ~BIT(2);
> +		break;
> +
> +	case CX25840_PAD_VACTIVE:
> +		if (invert)
> +			*voutctrl4 |= BIT(5);
> +		else
> +			*voutctrl4 &= ~BIT(5);
> +		break;
> +
> +	case CX25840_PAD_CBFLAG:
> +		if (invert)
> +			*voutctrl4 |= BIT(4);
> +		else
> +			*voutctrl4 &= ~BIT(4);
> +		break;
> +
> +	case CX25840_PAD_VRESET:
> +		if (invert)
> +			*voutctrl4 |= BIT(0);
> +		else
> +			*voutctrl4 &= ~BIT(0);
> +		break;
> +	}
> +
> +	if (function != CX25840_PAD_DEFAULT)
> +		return;
> +
> +	switch (pin) {
> +	case CX25840_PIN_DVALID_PRGM0:
> +		if (invert)
> +			*voutctrl4 |= BIT(6);
> +		else
> +			*voutctrl4 &= ~BIT(6);
> +		break;
> +
> +	case CX25840_PIN_HRESET_PRGM2:
> +		if (invert)
> +			*voutctrl4 |= BIT(1);
> +		else
> +			*voutctrl4 &= ~BIT(1);
> +		break;
> +	}
> +}
> +
> +static int cx25840_s_io_pin_config(struct v4l2_subdev *sd, size_t n,
> +				   struct v4l2_subdev_io_pin_config *p)
> +{
> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
> +	unsigned int i;
> +	u8 pinctrl[6], pinconf[10], voutctrl4;
> +
> +	for (i = 0; i < 6; i++)
> +		pinctrl[i] = cx25840_read(client, 0x114 + i);
> +
> +	for (i = 0; i < 10; i++)
> +		pinconf[i] = cx25840_read(client, 0x11c + i);
> +
> +	voutctrl4 = cx25840_read(client, 0x407);
> +
> +	for (i = 0; i < n; i++) {
> +		u8 strength = p[i].strength;
> +
> +		if (strength != CX25840_PIN_DRIVE_SLOW &&
> +		    strength != CX25840_PIN_DRIVE_MEDIUM &&
> +		    strength != CX25840_PIN_DRIVE_FAST) {
> +
> +			v4l_err(client,
> +				"invalid drive speed for pin %u (%u), assuming fast\n",
> +				(unsigned int)p[i].pin,
> +				(unsigned int)strength);
> +
> +			strength = CX25840_PIN_DRIVE_FAST;
> +		}
> +
> +		switch (p[i].pin) {
> +		case CX25840_PIN_DVALID_PRGM0:
> +			if (p[i].flags & BIT(V4L2_SUBDEV_IO_PIN_DISABLE))
> +				pinctrl[0] &= ~BIT(6);
> +			else
> +				pinctrl[0] |= BIT(6);
> +
> +			pinconf[3] &= 0xf0;
> +			pinconf[3] |= cx25840_function_to_pad(client,
> +							      p[i].function);
> +
> +			cx25840_set_invert(&pinctrl[3], &voutctrl4,
> +					   p[i].function,
> +					   CX25840_PIN_DVALID_PRGM0,
> +					   p[i].flags &
> +					   BIT(V4L2_SUBDEV_IO_PIN_ACTIVE_LOW));
> +
> +			pinctrl[4] &= ~(3 << 2); /* CX25840_PIN_DRIVE_MEDIUM */
> +			switch (strength) {
> +			case CX25840_PIN_DRIVE_SLOW:
> +				pinctrl[4] |= 1 << 2;
> +				break;
> +
> +			case CX25840_PIN_DRIVE_FAST:
> +				pinctrl[4] |= 2 << 2;
> +				break;
> +			}
> +
> +			break;
> +
> +		case CX25840_PIN_HRESET_PRGM2:
> +			if (p[i].flags & BIT(V4L2_SUBDEV_IO_PIN_DISABLE))
> +				pinctrl[1] &= ~BIT(0);
> +			else
> +				pinctrl[1] |= BIT(0);
> +
> +			pinconf[4] &= 0xf0;
> +			pinconf[4] |= cx25840_function_to_pad(client,
> +							      p[i].function);
> +
> +			cx25840_set_invert(&pinctrl[3], &voutctrl4,
> +					   p[i].function,
> +					   CX25840_PIN_HRESET_PRGM2,
> +					   p[i].flags &
> +					   BIT(V4L2_SUBDEV_IO_PIN_ACTIVE_LOW));
> +
> +			pinctrl[4] &= ~(3 << 2); /* CX25840_PIN_DRIVE_MEDIUM */
> +			switch (strength) {
> +			case CX25840_PIN_DRIVE_SLOW:
> +				pinctrl[4] |= 1 << 2;
> +				break;
> +
> +			case CX25840_PIN_DRIVE_FAST:
> +				pinctrl[4] |= 2 << 2;
> +				break;
> +			}
> +
> +			break;
> +
> +		case CX25840_PIN_PLL_CLK_PRGM7:
> +			if (p[i].flags & BIT(V4L2_SUBDEV_IO_PIN_DISABLE))
> +				pinctrl[2] &= ~BIT(2);
> +			else
> +				pinctrl[2] |= BIT(2);
> +
> +			switch (p[i].function) {
> +			case CX25840_PAD_XTI_X5_DLL:
> +				pinconf[6] = 0;
> +				break;
> +
> +			case CX25840_PAD_AUX_PLL:
> +				pinconf[6] = 1;
> +				break;
> +
> +			case CX25840_PAD_VID_PLL:
> +				pinconf[6] = 5;
> +				break;
> +
> +			case CX25840_PAD_XTI:
> +				pinconf[6] = 2;
> +				break;
> +
> +			default:
> +				pinconf[6] = 3;
> +				pinconf[6] |=
> +					cx25840_function_to_pad(client,
> +								p[i].function)
> +					<< 4;
> +			}
> +
> +			break;
> +
> +		default:
> +			v4l_err(client, "invalid or unsupported pin %u\n",
> +				(unsigned int)p[i].pin);
> +			break;
> +		}
> +	}
> +
> +	cx25840_write(client, 0x407, voutctrl4);
> +
> +	for (i = 0; i < 6; i++)
> +		cx25840_write(client, 0x114 + i, pinctrl[i]);
> +
> +	for (i = 0; i < 10; i++)
> +		cx25840_write(client, 0x11c + i, pinconf[i]);
> +
> +	return 0;
> +}
> +
>  static int common_s_io_pin_config(struct v4l2_subdev *sd, size_t n,
>  				      struct v4l2_subdev_io_pin_config *pincfg)
>  {
> @@ -323,6 +537,8 @@ static int common_s_io_pin_config(struct v4l2_subdev *sd, size_t n,
>  
>  	if (is_cx2388x(state))
>  		return cx23885_s_io_pin_config(sd, n, pincfg);
> +	else if (is_cx2584x(state))
> +		return cx25840_s_io_pin_config(sd, n, pincfg);
>  	return 0;
>  }
>  
> @@ -389,6 +605,91 @@ static void cx25840_work_handler(struct work_struct *work)
>  	wake_up(&state->fw_wait);
>  }
>  
> +#define CX25840_VCONFIG_SET_BIT(state, opt_msk, voc, idx, bit, oneval)	\
> +	do {								\
> +		if ((state)->vid_config & (opt_msk)) {			\
> +			if (((state)->vid_config & (opt_msk)) ==	\
> +			    (oneval))					\
> +				(voc)[idx] |= BIT(bit);		\
> +			else						\
> +				(voc)[idx] &= ~BIT(bit);		\
> +		}							\
> +	} while (0)
> +
> +/* apply current vconfig to hardware regs */
> +static void cx25840_vconfig_apply(struct i2c_client *client)
> +{
> +	struct cx25840_state *state = to_state(i2c_get_clientdata(client));
> +	u8 voutctrl[3];
> +	unsigned int i;
> +
> +	for (i = 0; i < 3; i++)
> +		voutctrl[i] = cx25840_read(client, 0x404 + i);
> +
> +	if (state->vid_config & CX25840_VCONFIG_FMT_MASK)
> +		voutctrl[0] &= ~3;
> +	switch (state->vid_config & CX25840_VCONFIG_FMT_MASK) {
> +	case CX25840_VCONFIG_FMT_BT656:
> +		voutctrl[0] |= 1;
> +		break;
> +
> +	case CX25840_VCONFIG_FMT_VIP11:
> +		voutctrl[0] |= 2;
> +		break;
> +
> +	case CX25840_VCONFIG_FMT_VIP2:
> +		voutctrl[0] |= 3;
> +		break;
> +
> +	case CX25840_VCONFIG_FMT_BT601:
> +		/* zero */
> +	default:
> +		break;
> +	}
> +
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_RES_MASK, voutctrl,
> +				0, 2, CX25840_VCONFIG_RES_10BIT);
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_VBIRAW_MASK, voutctrl,
> +				0, 3, CX25840_VCONFIG_VBIRAW_ENABLED);
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_ANCDATA_MASK, voutctrl,
> +				0, 4, CX25840_VCONFIG_ANCDATA_ENABLED);
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_TASKBIT_MASK, voutctrl,
> +				0, 5, CX25840_VCONFIG_TASKBIT_ONE);
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_ACTIVE_MASK, voutctrl,
> +				1, 2, CX25840_VCONFIG_ACTIVE_HORIZONTAL);
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_VALID_MASK, voutctrl,
> +				1, 3, CX25840_VCONFIG_VALID_ANDACTIVE);
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_HRESETW_MASK, voutctrl,
> +				1, 4, CX25840_VCONFIG_HRESETW_PIXCLK);
> +
> +	if (state->vid_config & CX25840_VCONFIG_CLKGATE_MASK)
> +		voutctrl[1] &= ~(3 << 6);
> +	switch (state->vid_config & CX25840_VCONFIG_CLKGATE_MASK) {
> +	case CX25840_VCONFIG_CLKGATE_VALID:
> +		voutctrl[1] |= 2;
> +		break;
> +
> +	case CX25840_VCONFIG_CLKGATE_VALIDACTIVE:
> +		voutctrl[1] |= 3;
> +		break;
> +
> +	case CX25840_VCONFIG_CLKGATE_NONE:
> +		/* zero */
> +	default:
> +		break;
> +	}
> +
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_DCMODE_MASK, voutctrl,
> +				2, 0, CX25840_VCONFIG_DCMODE_BYTES);
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_IDID0S_MASK, voutctrl,
> +				2, 1, CX25840_VCONFIG_IDID0S_LINECNT);
> +	CX25840_VCONFIG_SET_BIT(state, CX25840_VCONFIG_VIPCLAMP_MASK, voutctrl,
> +				2, 4, CX25840_VCONFIG_VIPCLAMP_ENABLED);
> +
> +	for (i = 0; i < 3; i++)
> +		cx25840_write(client, 0x404 + i, voutctrl[i]);
> +}
> +
>  static void cx25840_initialize(struct i2c_client *client)
>  {
>  	DEFINE_WAIT(wait);
> @@ -455,6 +756,9 @@ static void cx25840_initialize(struct i2c_client *client)
>  	/* (re)set input */
>  	set_input(client, state->vid_input, state->aud_input);
>  
> +	if (state->generic_mode)
> +		cx25840_vconfig_apply(client);
> +
>  	/* start microcontroller */
>  	cx25840_and_or(client, 0x803, ~0x10, 0x10);
>  }
> @@ -1403,7 +1707,9 @@ static int cx25840_set_fmt(struct v4l2_subdev *sd,
>  		Hsrc |= (cx25840_read(client, 0x471) & 0xf0) >> 4;
>  	}
>  
> -	Vlines = fmt->height + (is_50Hz ? 4 : 7);
> +	Vlines = fmt->height;
> +	if (!state->generic_mode)
> +		Vlines += is_50Hz ? 4 : 7;
>  
>  	/*
>  	 * We keep 1 margin for the Vsrc < Vlines check since the
> @@ -1647,8 +1953,70 @@ static void log_audio_status(struct i2c_client *client)
>  	}
>  }
>  
> +#define CX25840_VCONFIG_OPTION(state, cfg_in, opt_msk)			\
> +	do {								\
> +		if ((cfg_in) & (opt_msk)) {				\
> +			(state)->vid_config &= ~(opt_msk);		\
> +			(state)->vid_config |= (cfg_in) & (opt_msk);	\
> +		}							\
> +	} while (0)
> +
> +/* apply incoming options to the current vconfig */
> +static void cx25840_vconfig_add(struct cx25840_state *state, u32 cfg_in)
> +{
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_FMT_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_RES_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_VBIRAW_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_ANCDATA_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_TASKBIT_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_ACTIVE_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_VALID_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_HRESETW_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_CLKGATE_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_DCMODE_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_IDID0S_MASK);
> +	CX25840_VCONFIG_OPTION(state, cfg_in, CX25840_VCONFIG_VIPCLAMP_MASK);
> +}
> +
>  /* ----------------------------------------------------------------------- */
>  
> +/*
> + * Initializes the device in the generic mode.
> + * For cx2584x chips also adds additional video output settings provided
> + * in @val parameter (CX25840_VCONFIG_*).
> + *
> + * The generic mode disables some of the ivtv-related hacks in this driver.
> + * For cx2584x chips it also enables setting video output configuration while
> + * setting it according to datasheet defaults by default.
> + */
> +static int cx25840_init(struct v4l2_subdev *sd, u32 val)
> +{
> +	struct cx25840_state *state = to_state(sd);
> +
> +	state->generic_mode = true;
> +
> +	if (is_cx2584x(state)) {
> +		/* set datasheet video output defaults */
> +		state->vid_config = CX25840_VCONFIG_FMT_BT656 |
> +			CX25840_VCONFIG_RES_8BIT |
> +			CX25840_VCONFIG_VBIRAW_DISABLED |
> +			CX25840_VCONFIG_ANCDATA_ENABLED |
> +			CX25840_VCONFIG_TASKBIT_ONE |
> +			CX25840_VCONFIG_ACTIVE_HORIZONTAL |
> +			CX25840_VCONFIG_VALID_NORMAL |
> +			CX25840_VCONFIG_HRESETW_NORMAL |
> +			CX25840_VCONFIG_CLKGATE_NONE |
> +			CX25840_VCONFIG_DCMODE_DWORDS |
> +			CX25840_VCONFIG_IDID0S_NORMAL |
> +			CX25840_VCONFIG_VIPCLAMP_DISABLED;
> +
> +		/* add additional settings */
> +		cx25840_vconfig_add(state, val);
> +	}
> +
> +	return 0;
> +}
> +
>  /* This load_fw operation must be called to load the driver's firmware.
>     Without this the audio standard detection will fail and you will
>     only get mono.
> @@ -1836,6 +2204,11 @@ static int cx25840_s_video_routing(struct v4l2_subdev *sd,
>  	if (is_cx23888(state))
>  		cx23888_std_setup(client);
>  
> +	if (is_cx2584x(state) && state->generic_mode && config) {
> +		cx25840_vconfig_add(state, config);
> +		cx25840_vconfig_apply(client);
> +	}
> +
>  	return set_input(client, input, state->aud_input);
>  }
>  
> @@ -5059,6 +5432,7 @@ static const struct v4l2_ctrl_ops cx25840_ctrl_ops = {
>  static const struct v4l2_subdev_core_ops cx25840_core_ops = {
>  	.log_status = cx25840_log_status,
>  	.reset = cx25840_reset,

I would like to see a small comment here along the lines of:

	/* calling the init op will turn on generic mode */

> +	.init = cx25840_init,
>  	.load_fw = cx25840_load_fw,
>  	.s_io_pin_config = common_s_io_pin_config,
>  #ifdef CONFIG_VIDEO_ADV_DEBUG
> diff --git a/drivers/media/i2c/cx25840/cx25840-core.h b/drivers/media/i2c/cx25840/cx25840-core.h
> index e3ff1d7ec770..c630a95ff4b9 100644
> --- a/drivers/media/i2c/cx25840/cx25840-core.h
> +++ b/drivers/media/i2c/cx25840/cx25840-core.h
> @@ -53,10 +53,12 @@ enum cx25840_media_pads {
>   * @mute:		audio mute V4L2 control (non-cx2583x devices only)
>   * @pvr150_workaround:	whether we enable workaround for Hauppauge PVR150
>   *			hardware bug (audio dropping out)
> + * @generic_mode:	whether we disable ivtv-specific hacks

Also mention here that generic mode is turned on when the bridge driver calls
the init op.

>   * @radio:		set if we are currently in the radio mode, otherwise
>   *			the current mode is non-radio (that is, video)
>   * @std:		currently set video standard
>   * @vid_input:		currently set video input
> + * @vid_config:	currently set video output configuration

Mention that this is only used in generic mode.

>   * @aud_input:		currently set audio input
>   * @audclk_freq:	currently set audio sample rate
>   * @audmode:		currently set audio mode (when in non-radio mode)
> @@ -83,9 +85,11 @@ struct cx25840_state {
>  		struct v4l2_ctrl *mute;
>  	};
>  	int pvr150_workaround;
> +	bool generic_mode;
>  	int radio;
>  	v4l2_std_id std;
>  	enum cx25840_video_input vid_input;
> +	u32 vid_config;
>  	enum cx25840_audio_input aud_input;
>  	u32 audclk_freq;
>  	int audmode;
> @@ -118,6 +122,14 @@ static inline bool is_cx2583x(struct cx25840_state *state)
>  	       state->id == CX25837;
>  }
>  
> +static inline bool is_cx2584x(struct cx25840_state *state)
> +{
> +	return state->id == CX25840 ||
> +	       state->id == CX25841 ||
> +	       state->id == CX25842 ||
> +	       state->id == CX25843;
> +}
> +
>  static inline bool is_cx231xx(struct cx25840_state *state)
>  {
>  	return state->id == CX2310X_AV;
> diff --git a/drivers/media/i2c/cx25840/cx25840-vbi.c b/drivers/media/i2c/cx25840/cx25840-vbi.c
> index 8c99a79fb726..e3779b336326 100644
> --- a/drivers/media/i2c/cx25840/cx25840-vbi.c
> +++ b/drivers/media/i2c/cx25840/cx25840-vbi.c
> @@ -95,6 +95,7 @@ int cx25840_g_sliced_fmt(struct v4l2_subdev *sd, struct v4l2_sliced_vbi_format *
>  	memset(svbi->service_lines, 0, sizeof(svbi->service_lines));
>  	svbi->service_set = 0;
>  	/* we're done if raw VBI is active */
> +	/* TODO: this will have to be changed for generic_mode VBI */
>  	if ((cx25840_read(client, 0x404) & 0x10) == 0)
>  		return 0;
>  
> @@ -137,6 +138,7 @@ int cx25840_s_raw_fmt(struct v4l2_subdev *sd, struct v4l2_vbi_format *fmt)
>  		cx25840_write(client, 0x54f, vbi_offset);
>  	else
>  		cx25840_write(client, 0x47f, vbi_offset);
> +	/* TODO: this will have to be changed for generic_mode VBI */
>  	cx25840_write(client, 0x404, 0x2e);
>  	return 0;
>  }
> @@ -157,6 +159,7 @@ int cx25840_s_sliced_fmt(struct v4l2_subdev *sd, struct v4l2_sliced_vbi_format *
>  	cx25840_std_setup(client);
>  
>  	/* Sliced VBI */
> +	/* TODO: this will have to be changed for generic_mode VBI */
>  	cx25840_write(client, 0x404, 0x32);	/* Ancillary data */
>  	cx25840_write(client, 0x406, 0x13);
>  	if (is_cx23888(state))
> diff --git a/include/media/drv-intf/cx25840.h b/include/media/drv-intf/cx25840.h
> index 783c5bdd63eb..19a0b66e033b 100644
> --- a/include/media/drv-intf/cx25840.h
> +++ b/include/media/drv-intf/cx25840.h
> @@ -88,6 +88,70 @@ enum cx25840_video_input {
>  	CX25840_DIF_ON = 0x80000400,
>  };
>  
> +/* settings for core init op @val and video s_routing @config parameters */

Here especially you need to expand the comment explaining that these
defines are for the generic mode and that it is enabled by calling init.
It would also be good to refer to the corresponding section in the datasheet
that explains these defines.

> +#define CX25840_VCONFIG_FMT_SHIFT 0
> +#define CX25840_VCONFIG_FMT_MASK GENMASK(2, 0)
> +#define CX25840_VCONFIG_FMT_BT601 BIT(0)
> +#define CX25840_VCONFIG_FMT_BT656 BIT(1)
> +#define CX25840_VCONFIG_FMT_VIP11 GENMASK(1, 0)
> +#define CX25840_VCONFIG_FMT_VIP2 BIT(2)
> +
> +#define CX25840_VCONFIG_RES_SHIFT 3
> +#define CX25840_VCONFIG_RES_MASK GENMASK(4, 3)
> +#define CX25840_VCONFIG_RES_8BIT BIT(3)
> +#define CX25840_VCONFIG_RES_10BIT BIT(4)
> +
> +#define CX25840_VCONFIG_VBIRAW_SHIFT 5
> +#define CX25840_VCONFIG_VBIRAW_MASK GENMASK(6, 5)
> +#define CX25840_VCONFIG_VBIRAW_DISABLED BIT(5)
> +#define CX25840_VCONFIG_VBIRAW_ENABLED BIT(6)
> +
> +#define CX25840_VCONFIG_ANCDATA_SHIFT 7
> +#define CX25840_VCONFIG_ANCDATA_MASK GENMASK(8, 7)
> +#define CX25840_VCONFIG_ANCDATA_DISABLED BIT(7)
> +#define CX25840_VCONFIG_ANCDATA_ENABLED BIT(8)
> +
> +#define CX25840_VCONFIG_TASKBIT_SHIFT 9
> +#define CX25840_VCONFIG_TASKBIT_MASK GENMASK(10, 9)
> +#define CX25840_VCONFIG_TASKBIT_ZERO BIT(9)
> +#define CX25840_VCONFIG_TASKBIT_ONE BIT(10)
> +
> +#define CX25840_VCONFIG_ACTIVE_SHIFT 11
> +#define CX25840_VCONFIG_ACTIVE_MASK GENMASK(12, 11)
> +#define CX25840_VCONFIG_ACTIVE_COMPOSITE BIT(11)
> +#define CX25840_VCONFIG_ACTIVE_HORIZONTAL BIT(12)
> +
> +#define CX25840_VCONFIG_VALID_SHIFT 13
> +#define CX25840_VCONFIG_VALID_MASK GENMASK(14, 13)
> +#define CX25840_VCONFIG_VALID_NORMAL BIT(13)
> +#define CX25840_VCONFIG_VALID_ANDACTIVE BIT(14)
> +
> +#define CX25840_VCONFIG_HRESETW_SHIFT 15
> +#define CX25840_VCONFIG_HRESETW_MASK GENMASK(16, 15)
> +#define CX25840_VCONFIG_HRESETW_NORMAL BIT(15)
> +#define CX25840_VCONFIG_HRESETW_PIXCLK BIT(16)
> +
> +#define CX25840_VCONFIG_CLKGATE_SHIFT 17
> +#define CX25840_VCONFIG_CLKGATE_MASK GENMASK(18, 17)
> +#define CX25840_VCONFIG_CLKGATE_NONE BIT(17)
> +#define CX25840_VCONFIG_CLKGATE_VALID BIT(18)
> +#define CX25840_VCONFIG_CLKGATE_VALIDACTIVE GENMASK(18, 17)
> +
> +#define CX25840_VCONFIG_DCMODE_SHIFT 19
> +#define CX25840_VCONFIG_DCMODE_MASK GENMASK(20, 19)
> +#define CX25840_VCONFIG_DCMODE_DWORDS BIT(19)
> +#define CX25840_VCONFIG_DCMODE_BYTES BIT(20)
> +
> +#define CX25840_VCONFIG_IDID0S_SHIFT 21
> +#define CX25840_VCONFIG_IDID0S_MASK GENMASK(22, 21)
> +#define CX25840_VCONFIG_IDID0S_NORMAL BIT(21)
> +#define CX25840_VCONFIG_IDID0S_LINECNT BIT(22)
> +
> +#define CX25840_VCONFIG_VIPCLAMP_SHIFT 23
> +#define CX25840_VCONFIG_VIPCLAMP_MASK GENMASK(24, 23)
> +#define CX25840_VCONFIG_VIPCLAMP_ENABLED BIT(23)
> +#define CX25840_VCONFIG_VIPCLAMP_DISABLED BIT(24)
> +
>  enum cx25840_audio_input {
>  	/* Audio inputs: serial or In4-In8 */
>  	CX25840_AUDIO_SERIAL,
> @@ -115,7 +179,7 @@ enum cx25840_io_pin {
>  };
>  
>  enum cx25840_io_pad {
> -	/* Output pads */
> +	/* Output pads, these must match the actual chip register values */
>  	CX25840_PAD_DEFAULT = 0,
>  	CX25840_PAD_ACTIVE,
>  	CX25840_PAD_VACTIVE,
> 

In other words, the code is good, but the documentation needs improvement.

Regards,

	Hans
