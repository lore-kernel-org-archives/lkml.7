Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B51C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7826F21D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfJDK1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:27:46 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:47845 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbfJDK1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:27:46 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud7.xs4all.net with ESMTPA
        id GKoHiwFTCjZ8vGKoKitNSB; Fri, 04 Oct 2019 12:27:45 +0200
Subject: Re: [PATCH v9 7/8] media: v4l2-ctrl: Add new helper
 v4l2_ctrl_ptr_create
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>
References: <20191001112421.2778-1-ribalda@kernel.org>
 <20191001112421.2778-8-ribalda@kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <0af2cee9-4594-d696-4acd-325ba72c74bd@xs4all.nl>
Date:   Fri, 4 Oct 2019 12:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001112421.2778-8-ribalda@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIjMX5Y9KoX3vy20S+N9TryNPvFtJcjrR7U4X9KDmMNJYTaDie5xyK6ojhASGyolYqtlO0/ZQO/2qU1YisrwEBGRumEDJrJKDDZjTTTDmNeDS0mPH2c7
 enKbs1OyJ4A94rqQVbe4PzsvKlwiRutCjaxfcCphxJDhAtqFEL3kcM1ngibikyw093Xbjtodn9n/JQOHO04txkv6Aikl4JTttU2+4mSJW0QLwu5CDKwdWU+j
 m6RSWno49KexjRfRRIDaqiw8EhAjcIdEmEc2iiAMs/xVX53tjNUxfDwrr6sPDVBO7EJSdIkBcw2NR/aw9Xyh8pgErRvKvSRiYaVPUIMSq5KPwFt/fNlRKDNW
 qjdGg4ZD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 1:24 PM, Ricardo Ribalda Delgado wrote:
> This helper function simplifies the code by not needing a union
> v4l2_ctrl_ptr and an assignment every time we need to use
> a ctrl_ptr.
> 
> Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> ---
>  include/media/v4l2-ctrls.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
> index c42f164e2c9e..51d74fa7c7e2 100644
> --- a/include/media/v4l2-ctrls.h
> +++ b/include/media/v4l2-ctrls.h
> @@ -73,6 +73,18 @@ union v4l2_ctrl_ptr {
>  	void *p;
>  };
>  
> +/**
> + * v4l2_ctrl_ptr_create() - Helper function to return a v4l2_ctrl_ptr from a
> + * void pointer
> + * @ptr:	The void pointer
> + */
> +static inline union v4l2_ctrl_ptr v4l2_ctrl_ptr_create(void *ptr)
> +{
> +	union v4l2_ctrl_ptr p = {.p = ptr};

Nitpick: add space after { and before }

Regards,

	Hans

> +
> +	return p;
> +}
> +
>  /**
>   * struct v4l2_ctrl_ops - The control operations that the driver has to provide.
>   *
> 

