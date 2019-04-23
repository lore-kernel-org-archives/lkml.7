Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E45C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B61520843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDWGnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:43:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:53247 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDWGnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:43:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 23:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; 
   d="scan'208";a="225839400"
Received: from dixitsau-mobl.gar.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.63.40])
  by orsmga001.jf.intel.com with ESMTP; 22 Apr 2019 23:43:29 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 2E6D621E9B; Tue, 23 Apr 2019 09:43:27 +0300 (EEST)
Date:   Tue, 23 Apr 2019 09:43:27 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] v4l: Add source event change for bit-depth
Message-ID: <20190423064326.lbi3gfprfegqecu4@kekkonen.localdomain>
References: <20190415152723.2481-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415152723.2481-1-stanimir.varbanov@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stan,

On Mon, Apr 15, 2019 at 06:27:23PM +0300, Stanimir Varbanov wrote:
> This event indicate that the source bit-depth is changed during
> run-time. The client must get the new format and re-allocate buffers
> for it. This can usually happens with video decoder (encoders) when
> the bit-stream depth is changed from 8 to 10bits or vice versa.

Thanks for the patch.

How about adding an event for pixelformat change, instead of bit depth? The
application presumably knows the formats it can work with, and can adapt to
that as well as a change to the bit depth.

> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  Documentation/media/uapi/v4l/vidioc-dqevent.rst | 7 +++++++
>  Documentation/media/videodev2.h.rst.exceptions  | 1 +
>  include/uapi/linux/videodev2.h                  | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> index dea9c0cc00ab..92573d7c3e05 100644
> --- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> +++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> @@ -397,6 +397,13 @@ call.
>  	that many devices are not able to recover from a temporary loss of
>  	signal and so restarting streaming I/O is required in order for the
>  	hardware to synchronize to the video signal.
> +    * - ``V4L2_EVENT_SRC_CH_BITDEPTH``
> +      - 0x0002
> +      - This event gets triggered when bit-depth change is detected from a
> +	video decoder. Applications will have to query the new pixel format
> +	and re-negotiate the queue. In most cases the streaming must be stopped
> +	and restarted (:ref:`VIDIOC_STREAMOFF <VIDIOC_STREAMON>` followed by
> +	:ref:`VIDIOC_STREAMON <VIDIOC_STREAMON>`).
>  
>  
>  Return Value
> diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
> index 64d348e67df9..b4c35b347983 100644
> --- a/Documentation/media/videodev2.h.rst.exceptions
> +++ b/Documentation/media/videodev2.h.rst.exceptions
> @@ -478,6 +478,7 @@ replace define V4L2_EVENT_CTRL_CH_FLAGS ctrl-changes-flags
>  replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
>  
>  replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
> +replace define V4L2_EVENT_SRC_CH_BITDEPTH src-changes-flags
>  
>  replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
>  
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 496e6453450c..7398f42eac7d 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -2271,6 +2271,7 @@ struct v4l2_event_frame_sync {
>  };
>  
>  #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
> +#define V4L2_EVENT_SRC_CH_BITDEPTH		(1 << 1)
>  
>  struct v4l2_event_src_change {
>  	__u32 changes;

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
