Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855AC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516F821655
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OgIJGFb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfG0Cv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 22:51:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53250 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfG0Cv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:51:59 -0400
Received: from pendragon.ideasonboard.com (om126200118163.15.openmobile.ne.jp [126.200.118.163])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 711622E7;
        Sat, 27 Jul 2019 04:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564195917;
        bh=let5ORoniAHJEKYglIYJqD/D6mDARxa9CO3R2asqtA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgIJGFb5yr5PqP1+iroljmI1MG7Oaw1kCFt95u00pFPp0q8CGOmpzKOxwh+8QQhSk
         mw653DnnjwSqKr5dPcw+XdU0jlRm+faXrkvB31s1+6VpaeOKQsi/U/L1hPLEB4WZPv
         uRKGVNDXCmRwRYIjc7lgIL4IQeMfeI7ChPb/ngwo=
Date:   Sat, 27 Jul 2019 05:51:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] video: of: display_timing: Add of_node_put() in
 of_get_display_timing()
Message-ID: <20190727025151.GE4902@pendragon.ideasonboard.com>
References: <20190722182439.44844-1-dianders@chromium.org>
 <20190722182439.44844-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722182439.44844-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

Thank you for the patch.

On Mon, Jul 22, 2019 at 11:24:36AM -0700, Douglas Anderson wrote:
> From code inspection it can be seen that of_get_display_timing() is
> lacking an of_node_put().  Add it.
> 
> Fixes: ffa3fd21de8a ("videomode: implement public of_get_display_timing()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/video/of_display_timing.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
> index f5c1c469c0af..5eedae0799f0 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -119,6 +119,7 @@ int of_get_display_timing(const struct device_node *np, const char *name,
>  		struct display_timing *dt)
>  {
>  	struct device_node *timing_np;
> +	int ret;
>  
>  	if (!np)
>  		return -EINVAL;
> @@ -129,7 +130,11 @@ int of_get_display_timing(const struct device_node *np, const char *name,
>  		return -ENOENT;
>  	}
>  
> -	return of_parse_display_timing(timing_np, dt);
> +	ret = of_parse_display_timing(timing_np, dt);
> +
> +	of_node_put(timing_np);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_get_display_timing);
>  

-- 
Regards,

Laurent Pinchart
