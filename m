Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223A8C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3492086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfI3NFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:05:16 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:46753 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731349AbfI3NFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:05:14 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud9.xs4all.net with ESMTPA
        id EvMSilZaKz6EAEvMViNgY3; Mon, 30 Sep 2019 15:05:12 +0200
Subject: Re: [PATCH v8 7/8] media: v4l2-ctrl: Add new helper
 v4l2_ctrl_ptr_from_void
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>
References: <20190930101841.19630-1-ribalda@kernel.org>
 <20190930101841.19630-8-ribalda@kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <e1c4618d-4adf-98f6-77ff-b7fc96617a14@xs4all.nl>
Date:   Mon, 30 Sep 2019 15:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930101841.19630-8-ribalda@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK0gxg17lJkcq7mwa9uMANVkLhq46/18+Ai/S06mG6taCJODn5/Hv+eEaba8pDOGJTp3V+bEHKs+HavX+Mmai5yem3gyaDDRLknhQQGZKAepvPrLg5t4
 VbeIuS5GOr5uBpxqLQyFMz0xdT19dYSLArO3oz7mW/vcMQma4KyzqNlc1yC/MXxi2tW/M4H6OKDVAyl83JLfCxoFHhB0G2ekCVkOLrJ+FNbV6zGOyyHUhwwX
 XwaTudOX2u1K+uFI1qfqDPuFDPVfmyb7iY2nsWCLV/khWZdgp8thAX7fZ5drW5IAbzeYwClfmeVErZaKDI/Z9LEfjeiXD8emQcMpFlHgMvTJpbt8rGdt9Dkz
 hI/RxaHt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 12:18 PM, Ricardo Ribalda Delgado wrote:
> This helper function simplifies the code by not needing a union
> v4l2_ctrl_ptr and an assignment every time we need to use
> a ctrl_ptr.
> 
> Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> ---
>  include/media/v4l2-ctrls.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
> index c42f164e2c9e..d69cfdffd41d 100644
> --- a/include/media/v4l2-ctrls.h
> +++ b/include/media/v4l2-ctrls.h
> @@ -73,6 +73,17 @@ union v4l2_ctrl_ptr {
>  	void *p;
>  };
>  
> +/**
> + * v4l2_ctrl_ptr() - Helper function to return a v4l2_ctrl_ptr from a
> + * void pointer
> + * @ptr:	The void pointer
> + */
> +static inline union v4l2_ctrl_ptr v4l2_ctrl_ptr_from_void(void *ptr)
> +{
> +	BUILD_BUG_ON(sizeof(union v4l2_ctrl_ptr) != sizeof(void *));
> +	return (union v4l2_ctrl_ptr) ptr;

Huh? Why not just do:

	union v4l2_ctrl_ptr p = { .p = ptr; };

	return p;

Or even shorter (not tested): return (union v4l2_ctrl_ptr) { .p = ptr; };

No need for BUILD_BUG_ON that way, which is rather ugly.

Regards,

	Hans

> +}
> +
>  /**
>   * struct v4l2_ctrl_ops - The control operations that the driver has to provide.
>   *
> 

