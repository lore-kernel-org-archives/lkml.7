Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D93C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6154920811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfC1PBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:01:07 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:37136 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfC1PBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:01:07 -0400
Received: from [IPv6:2001:420:44c1:2579:7126:11db:5076:31b1] ([IPv6:2001:420:44c1:2579:7126:11db:5076:31b1])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 9WWbh7AbnNG8z9WWehpgZf; Thu, 28 Mar 2019 16:01:04 +0100
Subject: Re: [PATCH v6] [media] v4l: add I / P frame min max QP definitions
To:     Fish Lin <linfish@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Smitha T Murthy <smitha.t@samsung.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190128072948.45788-1-linfish@google.com>
 <20190321022052.164967-1-linfish@google.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <a6eaaf4e-9645-9cd8-8a2e-94a4ee6c52ce@xs4all.nl>
Date:   Thu, 28 Mar 2019 16:01:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321022052.164967-1-linfish@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBl6mfc927VuTpbVZWAzYp+Wfl03uwuaNgDU9bTbZVcySDrz1zsVBtfGBypwJ/4OiIFpyGtLQUqy3MbuB0DK4Z9As+4sv8b44sS2BXNThyFuvAfe75x9
 b3c5d4RMrEgGoL8+AtsPA5dweeGxH9B2igDqea6rF7G/9UctOihdv//m1xlPuPbysIJl3iBwKOrJgR19+t8O5nE7n/+y8vx0P8smwO3g1j6uOqWeoRrr07IB
 5ZpjiZM7C9MV2V7xmbGxqMhxAhzkCcT1YPoZmXy4Qryhmnj2jKeQy/ItIB8UxrbbXnvIycOFDzwsN202/7/tWeY8mSj3tuQKDW8iHt4V04JqIJqSrNAQf280
 6ePIN9Ps3TTsbw/BOJVRnl0VHVbXGirvhzVUoPQhVhnzn8fGHFfdGWUL9FCjq9pbhE7+QmTefe8hIIKD65WsQzV2AAz8JadB0tgU+I4FenKO/9tb721RsFAr
 fNLEZj2BBOtkjK0/61lLpyC3eGtrdaEHZ1CaTEk1d99iuvDuSW4UhaL0FQTuW3ajc72hIrTHz4SjJg1M1gQ2gMk4UEiUmi/q1CBrIiv93oFhlQIPKOXD7OkX
 530=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 3:20 AM, Fish Lin wrote:
> Add following V4L2 QP parameters for H.264:
> * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP
> * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP
> * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP
> * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP
> 
> These controls will limit QP range for intra and inter frame,
> provide more manual control to improve video encode quality.
> 
> Signed-off-by: Fish Lin <linfish@google.com>
> ---
> Changelog since v5:
> - Adjust documentation wording.
> 
> Changelog since v4:
> - Fix patch subject and send again.
> 
> Changelog since v3:
> - Put document in ext-ctrls-codec.rst instead of extended-controls.rst
>   (which was previous version).
> 
> Changelog since v2:
> - Add interaction with V4L2_CID_MPEG_VIDEO_H264_MIN/MAX_QP
>   description in the document.
> 
> Changelog since v1:
> - Add description in document.
> 
>  .../media/uapi/v4l/ext-ctrls-codec.rst        | 24 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls.c          |  4 ++++
>  include/uapi/linux/v4l2-controls.h            |  6 +++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> index c97fb7923be5..5b2db52d3b4e 100644
> --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> @@ -1048,6 +1048,30 @@ enum v4l2_mpeg_video_h264_entropy_mode -
>      Quantization parameter for an B frame for H264. Valid range: from 0
>      to 51.
> 
> +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP (integer)``
> +    Minimum quantization parameter for the H264 I frame to limit I frame
> +    quality to a range. Valid range: from 0 to 51. If
> +    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is also set, the quantization parameter
> +    should be chosen to meet both requirements.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP (integer)``
> +    Maximum quantization parameter for the H264 I frame to limit I frame
> +    quality to a range. Valid range: from 0 to 51. If
> +    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is also set, the quantization parameter
> +    should be chosen to meet both requirements.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP (integer)``
> +    Minimum quantization parameter for the H264 P frame to limit P frame
> +    quality to a range. Valid range: from 0 to 51. If
> +    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is also set, the quantization parameter
> +    should be chosen to meet both requirements.
> +
> +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP (integer)``
> +    Maximum quantization parameter for the H264 P frame to limit P frame
> +    quality to a range. Valid range: from 0 to 51. If
> +    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is also set, the quantization parameter
> +    should be chosen to meet both requirements.
> +
>  ``V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP (integer)``
>      Quantization parameter for an I frame for MPEG4. Valid range: from 1
>      to 31.
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index b79d3bbd8350..115fb8debe23 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -828,6 +828,10 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION:
>  								return "H264 Constrained Intra Pred";
>  	case V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET:	return "H264 Chroma QP Index Offset";
> +	case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP:		return "H264 I-Frame Minimum QP Value";
> +	case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP:		return "H264 I-Frame Maximum QP Value";
> +	case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP:		return "H264 P-Frame Minimum QP Value";
> +	case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP:		return "H264 P-Frame Maximum QP Value";
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:		return "MPEG4 I-Frame QP Value";
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:		return "MPEG4 P-Frame QP Value";
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:		return "MPEG4 B-Frame QP Value";
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 06479f2fb3ae..4421baa84177 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -535,6 +535,12 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type {
>  #define V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP	(V4L2_CID_MPEG_BASE+382)
>  #define V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION	(V4L2_CID_MPEG_BASE+383)
>  #define V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET		(V4L2_CID_MPEG_BASE+384)
> +
> +#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP	(V4L2_CID_MPEG_BASE+390)

There is no need for a gap in numbering. Just start with +385.

Sorry for this, I missed that in the previous reviews. Everything else looks good
to me, so if you post a v7 I'll take it.

Thanks!

	Hans

> +#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP	(V4L2_CID_MPEG_BASE+391)
> +#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP	(V4L2_CID_MPEG_BASE+392)
> +#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP	(V4L2_CID_MPEG_BASE+393)
> +
>  #define V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP	(V4L2_CID_MPEG_BASE+400)
>  #define V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP	(V4L2_CID_MPEG_BASE+401)
>  #define V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP	(V4L2_CID_MPEG_BASE+402)
> --
> 2.21.0.225.g810b269d1ac-goog
> 

