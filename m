Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B581C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231E9208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="peRmulcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCDMRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:17:36 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36174 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfCDMRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:17:36 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF900322;
        Mon,  4 Mar 2019 13:17:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551701853;
        bh=LsFcCNnJoqG/tlN1gCjZ/t+T331xBSULgwvxjln7LBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peRmulcS5zoO6c81DYWnUz5pGCrHDSynNYTVXAgybpZ23G0YYO0y2kaACIlwA9/MI
         gdvM7IpwGl46JiSfcJWiTFV2VDS0XZdwZm/vsjGJ0WvQrdzyx05VE7yHX8bO0Y/1F9
         kj8PIFTGv71XKudwJxdG/c012xwTkZD/L4jpIaxc=
Date:   Mon, 4 Mar 2019 14:17:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] drm/bridge: tc358767: Simplify tc_poll_timeout()
Message-ID: <20190304121728.GC6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226193609.9862-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thank you for the patch.

On Tue, Feb 26, 2019 at 11:36:01AM -0800, Andrey Smirnov wrote:
> Implementation of tc_poll_timeout() is almost a 100% copy-and-paste of
> the code for regmap_read_poll_timeout(). Replace copied code with a
> call to the original. No functional change intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/tc358767.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index e6403b9549f1..b0f8264a1285 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -252,24 +252,11 @@ static inline int tc_poll_timeout(struct regmap *map, unsigned int addr,
>  				  unsigned int cond_value,
>  				  unsigned long sleep_us, u64 timeout_us)
>  {
> -	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
>  	unsigned int val;
> -	int ret;
>  
> -	for (;;) {
> -		ret = regmap_read(map, addr, &val);
> -		if (ret)
> -			break;
> -		if ((val & cond_mask) == cond_value)
> -			break;
> -		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
> -			ret = regmap_read(map, addr, &val);
> -			break;
> -		}
> -		if (sleep_us)
> -			usleep_range((sleep_us >> 2) + 1, sleep_us);
> -	}
> -	return ret ?: (((val & cond_mask) == cond_value) ? 0 : -ETIMEDOUT);
> +	return regmap_read_poll_timeout(map, addr, val,
> +					(val & cond_mask) == cond_value,
> +					sleep_us, timeout_us);
>  }
>  
>  static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)

-- 
Regards,

Laurent Pinchart
