Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0B0C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 10:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC1924670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 10:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLGKli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 05:41:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33448 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfLGKli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 05:41:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id A4916283C82
Message-ID: <79cb93108abc1f0a11f41ad3ab02cc5535b3e784.camel@collabora.com>
Subject: Re: [PATCH v2] media: v4l2-device.h: Explicitly compare grpmask to
 zero in v4l2_device_mask_call_all
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 07 Dec 2019 07:41:27 -0300
In-Reply-To: <20191105045907.26123-1-natechancellor@gmail.com>
References: <20191024201240.49063-1-natechancellor@gmail.com>
         <20191105045907.26123-1-natechancellor@gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Hans)

Hi Nathan, Nick,

Thanks for the patch (and the patience).

On Mon, 2019-11-04 at 21:59 -0700, Nathan Chancellor wrote:
> When building with Clang + -Wtautological-constant-compare, several of
> the ivtv drivers warn along the lines of:
> 

Nitpick: s/ivtv/ivtv and cx18

>  drivers/media/pci/cx18/cx18-driver.c:1005:21: warning: converting the
>  result of '<<' to a boolean always evaluates to true
>  [-Wtautological-constant-compare]
>                          cx18_call_hw(cx, CX18_HW_GPIO_RESET_CTRL,
>                                          ^
>  drivers/media/pci/cx18/cx18-cards.h:18:37: note: expanded from macro
>  'CX18_HW_GPIO_RESET_CTRL'
>  #define CX18_HW_GPIO_RESET_CTRL         (1 << 6)
>                                            ^
>  1 warning generated.
> 
> This is because the shift operation is implicitly converted to a boolean
> in v4l2_device_mask_call_all before being negated. This can be solved by
> just comparing the mask result to 0 explicitly so that there is no
> boolean conversion.
> 

Perhaps it's interesting to mention the reason for this change,
which you mentioned as a comment before:

"""
 The ultimate goal is to get
-Wtautological-compare enabled because there are several subwarnings
that would be helpful to have and right now they are all disabled.
"""

> Link: https://github.com/ClangBuiltLinux/linux/issues/752
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2: https://lore.kernel.org/lkml/20191024201240.49063-1-natechancellor@gmail.com/
> 
> * Fix typo in commit message
> * Add Nick's Reviewed-by.
> 
>  include/media/v4l2-device.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/media/v4l2-device.h b/include/media/v4l2-device.h
> index e0b8f2602670..8564b3227887 100644
> --- a/include/media/v4l2-device.h
> +++ b/include/media/v4l2-device.h
> @@ -431,8 +431,8 @@ static inline bool v4l2_device_supports_requests(struct v4l2_device *v4l2_dev)
>  		struct v4l2_subdev *__sd;				\
>  									\
>  		__v4l2_device_call_subdevs_p(v4l2_dev, __sd,		\
> -			!(grpmsk) || (__sd->grp_id & (grpmsk)), o, f ,	\
> -			##args);					\
> +			(grpmsk) == 0 || (__sd->grp_id & (grpmsk)), o,	\
> +			f , ##args);					\
>  	} while (0)
>  
>  /**

The change is small enough and if it helps enabling helpful
warnings, then it seems a good idea.

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

For consistency, it would be good to also patch the other case(s).

Thanks,
Ezequiel

