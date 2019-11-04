Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730BFCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AC021929
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfKDJoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:44:01 -0500
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:55309 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfKDJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:44:01 -0500
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud9.xs4all.net with ESMTPA
        id RYtwia7EU9P9bRYtziVTKn; Mon, 04 Nov 2019 10:43:59 +0100
Subject: Re: [PATCH v3 3/5] media: vivid: Add an area control
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191101112358.29538-1-ribalda@kernel.org>
 <20191101112358.29538-3-ribalda@kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <f024d7cd-0e96-b05b-5681-cd3254885e64@xs4all.nl>
Date:   Mon, 4 Nov 2019 10:43:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101112358.29538-3-ribalda@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHza/vZSb2Pmcsx8i2q9SjX9EgtTGDZ3UvGTKluaiZF5BmmfXrn8wVjmLqfjmTEmI3LZ/xwMRxXwAsAjqV1t0JMmFscHeI9jHpttz6aEYQvYKs4mN7HG
 aqF1oYTBIzDEQdlrzAYwmW2lIElhekajkakw9rtVRaP24hcc7kL69NBQ08xgJ6Myp5OdLhQPU8NZkQaUH3LTXCoglMkPsPoepOSDBJN0g6qcsU7mqeKKpAlD
 o+0tgKXN9LbK+ursJUq4HQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/19 12:23 PM, Ricardo Ribalda Delgado wrote:
> This control represents a generic read/write area.
> 
> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> ---
>  drivers/media/platform/vivid/vivid-ctrls.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/media/platform/vivid/vivid-ctrls.c b/drivers/media/platform/vivid/vivid-ctrls.c
> index b250fc3764e2..fd35863798a7 100644
> --- a/drivers/media/platform/vivid/vivid-ctrls.c
> +++ b/drivers/media/platform/vivid/vivid-ctrls.c
> @@ -32,6 +32,7 @@
>  #define VIVID_CID_U32_ARRAY		(VIVID_CID_CUSTOM_BASE + 8)
>  #define VIVID_CID_U16_MATRIX		(VIVID_CID_CUSTOM_BASE + 9)
>  #define VIVID_CID_U8_4D_ARRAY		(VIVID_CID_CUSTOM_BASE + 10)
> +#define VIVID_CID_AREA			(VIVID_CID_CUSTOM_BASE + 11)
>  
>  #define VIVID_CID_VIVID_BASE		(0x00f00000 | 0xf000)
>  #define VIVID_CID_VIVID_CLASS		(0x00f00000 | 1)
> @@ -266,6 +267,18 @@ static const struct v4l2_ctrl_config vivid_ctrl_disconnect = {
>  	.type = V4L2_CTRL_TYPE_BUTTON,
>  };
>  
> +static const struct v4l2_area area = {
> +	.width = 0xcafe,
> +	.height = 0xb1b1d,

I don't think there is any need for these weird values. Just set this to
e.g. 1000x2000. Just as long as width and height are different.

Regards,

	Hans

> +};
> +
> +static const struct v4l2_ctrl_config vivid_ctrl_area = {
> +	.ops = &vivid_user_gen_ctrl_ops,
> +	.id = VIVID_CID_AREA,
> +	.name = "Area",
> +	.type = V4L2_CTRL_TYPE_AREA,
> +	.p_def.p_const = &area,
> +};
>  
>  /* Framebuffer Controls */
>  
> @@ -1574,6 +1587,7 @@ int vivid_create_controls(struct vivid_dev *dev, bool show_ccs_cap,
>  	dev->string = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_string, NULL);
>  	dev->bitmask = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_bitmask, NULL);
>  	dev->int_menu = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_int_menu, NULL);
> +	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_area, NULL);
>  	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u32_array, NULL);
>  	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u16_matrix, NULL);
>  	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u8_4d_array, NULL);
> 

