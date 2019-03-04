Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46881C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A8320830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MluJKSn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCDMjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:39:25 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36496 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCDMjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:39:25 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF029322;
        Mon,  4 Mar 2019 13:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551703164;
        bh=sIH5EjSllMVNYN+V+L/NGixBorINB4B/xN3lCjrIMeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MluJKSn92rAesRz3hRFerjbx01vV81fKvaxcfMp8uJIgXI1Cg3+cvok57ZAVcdRqq
         jboPtUU4b9UaxJsToLlcCPxAl6otWhdycIjBpLApONb4ymKeNJWJJRnBnJMmOL1p3e
         cChJ5RmCorxS4dIA/6C5nJBm+xYLhD/cxAyp6chc=
Date:   Mon, 4 Mar 2019 14:39:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] drm/bridge: tc358767: Drop tc_read() macro
Message-ID: <20190304123918.GK6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-10-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226193609.9862-10-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thank you for the patch.

On Tue, Feb 26, 2019 at 11:36:09AM -0800, Andrey Smirnov wrote:
> There's only one place where tc_read() is used, so it doesn't save us
> much. Drop it. No functional change intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 239b3aaa255d..3c574f1569aa 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -240,12 +240,6 @@ static inline struct tc_data *connector_to_tc(struct drm_connector *c)
>  		if (ret)					\
>  			goto err;				\
>  	} while (0)
> -#define tc_read(reg, var)					\
> -	do {							\
> -		ret = regmap_read(tc->regmap, reg, var);	\
> -		if (ret)					\
> -			goto err;				\
> -	} while (0)

While I really like removing the goto from the macro, I think we should
either have accessors for both read and write, or remove them
completely. How about just dropping the goto in this patch, and decide
separately whether to keep accessors or remove them ?

>  static inline int tc_poll_timeout(struct regmap *map, unsigned int addr,
>  				  unsigned int cond_mask,
> @@ -337,8 +331,13 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	if (request == DP_AUX_I2C_READ || request == DP_AUX_NATIVE_READ) {
>  		/* Read data */
>  		while (i < size) {
> -			if ((i % 4) == 0)
> -				tc_read(DP0_AUXRDATA(i >> 2), &tmp);
> +			if ((i % 4) == 0) {
> +				ret = regmap_read(tc->regmap,
> +						  DP0_AUXRDATA(i >> 2),
> +						  &tmp);
> +				if (ret)
> +					goto err;

You can return ret directly here.

> +			}
>  			buf[i] = tmp & 0xff;
>  			tmp = tmp >> 8;
>  			i++;

-- 
Regards,

Laurent Pinchart
