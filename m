Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75671CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407A021744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfKDJoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:44:10 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34957 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:44:10 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iRYu8-0001Yt-Fu; Mon, 04 Nov 2019 10:44:08 +0100
Message-ID: <4de1163ecdf66464f504342ba9faafb0c48a7721.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: correct ETNA_MAX_PIPE define
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, stable@vger.kernel.org,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Mon, 04 Nov 2019 10:44:05 +0100
In-Reply-To: <20191101101110.10105-1-christian.gmeiner@gmail.com>
References: <20191101101110.10105-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-11-01 at 11:10 +0100, Christian Gmeiner wrote:
> etnaviv supports the following pipe types:
> 
> ETNA_PIPE_3D      0x00
> ETNA_PIPE_2D      0x01
> ETNA_PIPE_VG      0x02
> 
> The current used value of 4 for ETNA_MAX_PIPES is wrong and
> caueses some troubles in the combination with perf counters.
> 
> Lets have a look at the function etnaviv_pm_query_dom(..):
> If domain->pipe is 3 then we are one element beyond the end
> of the array.
> 
> The easiest way to fix this issue is to provide a correct value
> for ETNA_MAX_PIPES.

No, this is not a correct fix. The ETNA_MAX_PIPES define does not
correspond to the pipe types, it's the number of maximum possible GPU
cores. Any code in the driver needs to deal with less GPU cores being
available than this maximum number. If it doesn't, please fix the code
instead of messing with this define.

Regards,
Lucas

> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  include/uapi/drm/etnaviv_drm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/etnaviv_drm.h
> b/include/uapi/drm/etnaviv_drm.h
> index 09d0df8b71c5..5a62228298d1 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -75,7 +75,7 @@ struct drm_etnaviv_timespec {
>  #define ETNAVIV_PARAM_GPU_NUM_VARYINGS              0x1a
>  #define ETNAVIV_PARAM_SOFTPIN_START_ADDR            0x1b
>  
> -#define ETNA_MAX_PIPES 4
> +#define ETNA_MAX_PIPES 3
>  
>  struct drm_etnaviv_param {
>  	__u32 pipe;           /* in */

