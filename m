Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E55C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F79206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfGXS7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:59:38 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48966 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfGXS7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:59:38 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C6393804C5;
        Wed, 24 Jul 2019 20:59:34 +0200 (CEST)
Date:   Wed, 24 Jul 2019 20:59:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        secalert@redhat.com, Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: check failure cases in the probe func
Message-ID: <20190724185933.GE22640@ravnborg.org>
References: <20190724051700.GA22730@ravnborg.org>
 <20190724144845.4791-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724144845.4791-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=ONRsVvzFGko7FBthncQA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid.

Thanks for your patch.

On Wed, Jul 24, 2019 at 09:48:44AM -0500, Navid Emamdoost wrote:
> The following function calls may fail and return NULL, so the null check
> is added.
> of_graph_get_next_endpoint
> of_graph_get_remote_port_parent
> of_graph_get_remote_port
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> index 28c0620dfe0f..9484fdb60f68 100644
> --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> @@ -399,7 +399,13 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
>  
>  	/* Look up the DSI host.  It needs to probe before we do. */
>  	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
> +	if (!endpoint)
> +		return -ENODEV;
> +
>  	dsi_host_node = of_graph_get_remote_port_parent(endpoint);
> +	if (!dsi_host_node)
> +		return -ENODEV;
> +
If we return here we will leak endpoint - a of_node_put() is missing.
Use goto to rewind the allocations in the bottom of this function.

>  	host = of_find_mipi_dsi_host_by_node(dsi_host_node);
>  	of_node_put(dsi_host_node);
>  	if (!host) {
> @@ -408,6 +414,9 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
>  	}
>  
>  	info.node = of_graph_get_remote_port(endpoint);
> +	if (!info.node)
> +		return -ENODEV;
Here we also leak endpoint, but not dsi_host_node as we already did a
put above.

> +
>  	of_node_put(endpoint);
>  
>  	ts->dsi = mipi_dsi_device_register_full(host, &info);

	Sam
