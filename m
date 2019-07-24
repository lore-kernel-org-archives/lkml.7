Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F21C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D08A218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfGXFRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:17:05 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:49202 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGXFRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:17:04 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 940CD200CD;
        Wed, 24 Jul 2019 07:17:01 +0200 (CEST)
Date:   Wed, 24 Jul 2019 07:17:00 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpi_touchscreen_probe: check for failure case
Message-ID: <20190724051700.GA22730@ravnborg.org>
References: <20190724025644.17163-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724025644.17163-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=ONRsVvzFGko7FBthncQA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid.

Thanks for your patch.
On Tue, Jul 23, 2019 at 09:56:43PM -0500, Navid Emamdoost wrote:
> of_graph_get_next_endpoint may return NULL, so null check is needed.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

The patch looks fine, but could you please audit the other calls in the
probe function. For example of_graph_get_remote_port_parent() may also
return NULL.
If you do this then we can have the error handling reviewed in one go,
and fixed in one patch.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> index 28c0620dfe0f..2e0977e26fab 100644
> --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> @@ -399,6 +399,8 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
>  
>  	/* Look up the DSI host.  It needs to probe before we do. */
>  	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
> +	if (!endpoint)
> +		return -ENODEV;
>  	dsi_host_node = of_graph_get_remote_port_parent(endpoint);
>  	host = of_find_mipi_dsi_host_by_node(dsi_host_node);
>  	of_node_put(dsi_host_node);
> -- 
> 2.17.1
