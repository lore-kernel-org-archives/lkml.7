Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219A421473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfENLKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:10:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:50951 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENLKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:10:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 04:10:10 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2019 04:10:07 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 0289920666; Tue, 14 May 2019 14:10:06 +0300 (EEST)
Date:   Tue, 14 May 2019 14:10:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] media: v4l2-subdev: Verify arguments of
 v4l2_subdev_call()
Message-ID: <20190514111006.chhwvyfem2ngu4oy@paasikivi.fi.intel.com>
References: <20190511101031.4777-1-jmkrzyszt@gmail.com>
 <20190511101031.4777-2-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511101031.4777-2-jmkrzyszt@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Sat, May 11, 2019 at 12:10:30PM +0200, Janusz Krzysztofik wrote:
> Correctness of format type (try or active) and pad number parameters
> passed to subdevice operation callbacks is now verified only for IOCTL
> calls.  However, those callbacks are also used by drivers, e.g., V4L2
> host interfaces.
> 
> Since both subdev_do_ioctl() and drivers are using v4l2_subdev_call()
> macro while calling subdevice operations, move those parameter checks
> from subdev_do_ioctl() to v4l2_subdev_call() so we can avoid taking care
> of those checks inside drivers.

I have to say I really like this patch!

> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 222 +++++++++++++++-----------
>  include/media/v4l2-subdev.h           |   6 +
>  2 files changed, 139 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index d75815ab0d7b..cd50fcb86c47 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -120,56 +120,165 @@ static int subdev_close(struct file *file)
>  	return 0;
>  }
>  
> +static inline int check_which(__u32 which)
> +{
> +	return which != V4L2_SUBDEV_FORMAT_TRY &&
> +	       which != V4L2_SUBDEV_FORMAT_ACTIVE ? -EINVAL : 0;
> +}
> +
>  #if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
> +static inline int check_pad(struct v4l2_subdev *sd, __u32 pad)
> +{
> +	return pad >= sd->entity.num_pads ? -EINVAL : 0;
> +}
> +#else
> +#define check_pad(...) 0

This should be an inline function as well. Or just have one function; the
prototype is the same anyway.

> +#endif
> +
>  static int check_format(struct v4l2_subdev *sd,

inline?

>  			struct v4l2_subdev_format *format)
>  {
> -	if (format->which != V4L2_SUBDEV_FORMAT_TRY &&
> -	    format->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> -		return -EINVAL;
> +	return check_which(format->which) ? : check_pad(sd, format->pad);
> +}

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
