Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8DDC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C2F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfD2IFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:05:11 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:50255 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfD2IFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:05:11 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id L1Hchs8f2ZVjxL1Hfhs7bk; Mon, 29 Apr 2019 10:05:08 +0200
Subject: Re: [PATCH v11 2/7] cx25840: g_std operation really implements
 querystd operation
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
References: <cover.1556365459.git.mail@maciej.szmigiero.name>
 <9490ba236364690f582815c125b3e5208a4778a2.1556365459.git.mail@maciej.szmigiero.name>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7ae66245-e524-cecd-70dd-be33fe6589d9@xs4all.nl>
Date:   Mon, 29 Apr 2019 10:05:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9490ba236364690f582815c125b3e5208a4778a2.1556365459.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI9Rv6q+sgeqT+VGiOXwCHTCy888i2t8Eb6TvSpFWyCsB1GCJxUAGfxc8qJSztCCsAxfSETghHqei8YAkK2x0YfWclHYd2fPh4+XXj2M4Hrv7hMHHbtY
 23zJiaF2QMQYnI9ZyR7GCx9hq+kNCn9YJhaG2DIyd9px7Tutt1CvgAlP0f0GXz9wxd5KDH2xsIQzgn8ei5tWNQ9VBVqYHXIw8f+Jz3coEUJP+1gfi6NlBnFJ
 4W0STczAH/Zst64XVwVlf0uLfPlhLKsc5+na4dtdLrDri7xjCodHOM/fWoVMofbvaGdq35k1rwPjFrDJdGme0HRMfu7ijypMkoWLISoVsRB6F8jwK564BOyx
 tGJ1mit8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/19 4:50 PM, Maciej S. Szmigiero wrote:
> cx25840 driver g_std operation queries the currently detected video signal,
> however this is what querystd operation should do, so let's rename the
> handler.
> 
> None of the existing cx25840 driver users ever called the g_std operation,
> one of them calls querystd on each of its subdevs but then the result is
> only used to implement VIDIOC_QUERYSTD (as it should).
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  drivers/media/i2c/cx25840/cx25840-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/cx25840/cx25840-core.c b/drivers/media/i2c/cx25840/cx25840-core.c
> index 0bf30222cf93..2bcaf239b0d2 100644
> --- a/drivers/media/i2c/cx25840/cx25840-core.c
> +++ b/drivers/media/i2c/cx25840/cx25840-core.c
> @@ -1772,7 +1772,7 @@ static int cx25840_s_stream(struct v4l2_subdev *sd, int enable)
>  }
>  
>  /* Query the current detected video format */
> -static int cx25840_g_std(struct v4l2_subdev *sd, v4l2_std_id *std)
> +static int cx25840_querystd(struct v4l2_subdev *sd, v4l2_std_id *std)
>  {
>  	struct i2c_client *client = v4l2_get_subdevdata(sd);
>  
> @@ -1800,8 +1800,9 @@ static int cx25840_g_std(struct v4l2_subdev *sd, v4l2_std_id *std)
>  	u32 fmt = (cx25840_read4(client, 0x40c) >> 8) & 0xf;
>  	*std = stds[ fmt ];
>  
> -	v4l_dbg(1, cx25840_debug, client, "g_std fmt = %x, v4l2_std_id = 0x%x\n",
> -		fmt, (unsigned int)stds[ fmt ]);
> +	v4l_dbg(1, cx25840_debug, client,
> +		"querystd fmt = %x, v4l2_std_id = 0x%x\n",
> +		fmt, (unsigned int)stds[fmt]);
>  
>  	return 0;
>  }
> @@ -5081,7 +5082,7 @@ static const struct v4l2_subdev_audio_ops cx25840_audio_ops = {
>  
>  static const struct v4l2_subdev_video_ops cx25840_video_ops = {
>  	.s_std = cx25840_s_std,
> -	.g_std = cx25840_g_std,
> +	.querystd = cx25840_querystd,
>  	.s_routing = cx25840_s_video_routing,
>  	.s_stream = cx25840_s_stream,
>  	.g_input_status = cx25840_g_input_status,
> 

Hmm, you are right, g_std really implements querystd. I wondered why this wasn't
noticed before, and it appears that no bridge driver ever calls the g_std op of the
cx25840 driver. It's all handled inside the bridge driver itself.

Can you add a new cx25840_g_std() op here that just returns state->std?

That would make much more sense.

You also need to use g_std in patch 6/7 (see my comments there)

Regards,

	Hans
