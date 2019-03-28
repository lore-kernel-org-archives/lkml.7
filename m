Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C665C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B862075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfC1O5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:57:25 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:51642 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfC1O5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:57:25 -0400
Received: from [IPv6:2001:420:44c1:2579:7126:11db:5076:31b1] ([IPv6:2001:420:44c1:2579:7126:11db:5076:31b1])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 9WT0h78xJNG8z9WT3hpefR; Thu, 28 Mar 2019 15:57:22 +0100
Subject: Re: [PATCH] media: v4l-ctrl: add control for variable frame rate
To:     Fish Lin <linfish@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Smitha T Murthy <smitha.t@samsung.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190320031022.174052-1-linfish@google.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <0aaba609-1551-e09d-a39f-111dbe99288e@xs4all.nl>
Date:   Thu, 28 Mar 2019 15:57:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320031022.174052-1-linfish@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN3T1JwF0DmMOjFvGykGubVOKkDNI9/gMP6lrUZNFpTCsbhaLlCZkm4cTqEYyS9o8GQg/x3jzOevMg/ekfYt9njhPqYTgbFJg11KrqF5DWcQo+Q1dgKx
 11dffnzfiUaBJSvV2T10Rci6edHnyhPxmnqUTJ+huwdwdLEdhjcq8RQFm/dFk/G1NSyjqlWogCBF/7ydCay9P67Rarer2+aleVskxOpNuMfoFmNM2pONKDR2
 UvZsIFE47zNH/W76zA2NPmwEKE22ypS8IRW+WSb81yS0DscqYle6wzLIQIl8uxi0bC5SelUf+RsPfR+ZLWFefbJAtzcCN3S/m5MPWm1E5FwM1L1dXm22J8CL
 z1aRVAfhldfz9Ps5vfW9c4gh6+ZHgOjCmVSYqU/BRXqN0HGI/zo9F5j1F0w2RKLJrtsN9YnpRpISGsXW6Ft39BCuMouJwtvCgMUOZHzhzofdRNIpKkQVRY/O
 ePIQRtquAGma7Tor/qznW5pdVtNOye9JhxHBLWFFNrBFyze083SwxltLZmCJDblZ8lmIr4GtpejokR1aLOSjJDQchdaCtOyN8myGi8a9j62uds8HS3dpOYmk
 dOBxAgjFrMVjGtTCcn3dUw4xZlysj2he0P5bmhV6UUWMYH8VWrOGcAsnDQmk7NnYwh8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/19 4:10 AM, Fish Lin wrote:
> These flag are added
> * V4L2_CID_MPEG_VIDEO_VFR_ENABLE
> * V4L2_CID_MPEG_VIDEO_VFR_MIN_FRAMERATE
> One is to set variable frame rate enable or not, another is to control
> minimal frame rate that video encoder should keep per second.
> 
> Signed-off-by: Fish Lin <linfish@google.com>
> ---
>  Documentation/media/uapi/v4l/ext-ctrls-codec.rst | 9 +++++++++
>  drivers/media/v4l2-core/v4l2-ctrls.c             | 3 +++
>  include/uapi/linux/v4l2-controls.h               | 3 +++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> index c97fb7923be5..4bc013d71b67 100644
> --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> @@ -620,7 +620,16 @@ enum v4l2_mpeg_video_bitrate_mode -
>      * - Bit 24:31
>        - Must be zero.
>  
> +.. _v4l2-mpeg-video-variable-framerate:
>  
> +``V4L2_CID_MPEG_VIDEO_VFR_ENABLE (boolean)``
> +    Set variable framerate enable or not. When enabled, video encoder is able
> +    to drop frames based on some mechanism, like frame similarity or bitrate
> +    control (default disable).
> +
> +``V4L2_CID_MPEG_VIDEO_VFR_MIN_FRAMERATE (integer)``
> +    Minimal kept frame per second when variable framerate is enabled (default
> +    is input framerate).

You don't really have a concept of frames per second when encoding. What you
are probably trying to say is something like: "don't drop more than one frame for
every X frames" or something like that.

Which codecs support this? A decoder needs to know that a frame is missing, right?

What's the use-case for this?

Sorry, just trying to understand this better.

Regards,

	Hans

>  
>  .. _v4l2-mpeg-video-dec-pts:
>  
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index b79d3bbd8350..566c6552c9a0 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -786,6 +786,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264 MB Level Rate Control";
>  	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:			return "Sequence Header Mode";
>  	case V4L2_CID_MPEG_VIDEO_MAX_REF_PIC:			return "Max Number of Reference Pics";
> +	case V4L2_CID_MPEG_VIDEO_VFR_ENABLE:			return "Variable Frame Rate Enable";
> +	case V4L2_CID_MPEG_VIDEO_VFR_MIN_FRAMERATE:		return "VFR Minimal Frame Rate";
>  	case V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP:		return "H263 I-Frame QP Value";
>  	case V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP:		return "H263 P-Frame QP Value";
>  	case V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP:		return "H263 B-Frame QP Value";
> @@ -1108,6 +1110,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:
>  	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
>  	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:
> +	case V4L2_CID_MPEG_VIDEO_VFR_ENABLE:
>  	case V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM:
>  	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE:
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_QPEL:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 06479f2fb3ae..f1bf52eb0152 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -404,6 +404,9 @@ enum v4l2_mpeg_video_multi_slice_mode {
>  #define V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE		(V4L2_CID_MPEG_BASE+228)
>  #define V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME		(V4L2_CID_MPEG_BASE+229)
>  
> +#define V4L2_CID_MPEG_VIDEO_VFR_ENABLE (V4L2_CID_MPEG_BASE + 250)
> +#define V4L2_CID_MPEG_VIDEO_VFR_MIN_FRAMERATE (V4L2_CID_MPEG_BASE + 251)
> +
>  #define V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP		(V4L2_CID_MPEG_BASE+300)
>  #define V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP		(V4L2_CID_MPEG_BASE+301)
>  #define V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP		(V4L2_CID_MPEG_BASE+302)
> 

