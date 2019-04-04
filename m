Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E11BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166F020882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nSup6QjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfDDNZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:25:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50940 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:25:42 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5717B54B;
        Thu,  4 Apr 2019 15:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554384340;
        bh=gX3KE0fH9D/gM+ThqeFbAnwXk3fqUR85ELXYbSkZiOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSup6QjU1pWFDX0N9tUrELISP71KWqBEz4kRW+uWS6TBSlHEUxNVw/tO70HC53LKc
         /j1fofcGfA75royPFi1bXcekScrLAJBhCPWe3P7BCZq8qmdnE9O/ctFZHvk3NtEZpq
         g7G8znDINLXJgeKeS4JPD8sQvJwq1DzQicymexz4=
Date:   Thu, 4 Apr 2019 16:25:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/7] drm/omap: fix possible object reference leak
Message-ID: <20190404132529.GB7817@pendragon.ideasonboard.com>
References: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
 <1554307455-40361-5-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554307455-40361-5-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wen,

Thank you for the patch.

On Thu, Apr 04, 2019 at 12:04:12AM +0800, Wen Yang wrote:
> The call to of_find_matching_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c:212:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 209, but without a corresponding object release within this function.
> drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c:237:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 209, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Would you like to get the series merged in one go, or individual patches
picked by the respective maintainer ?

> ---
>  drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> index 2b41c75..60067e8 100644
> --- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> +++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> @@ -208,8 +208,10 @@ static int __init omapdss_boot_init(void)
>  
>  	dss = of_find_matching_node(NULL, omapdss_of_match);
>  
> -	if (dss == NULL || !of_device_is_available(dss))
> +	if (dss == NULL || !of_device_is_available(dss)) {
> +		of_node_put(dss);
>  		return 0;
> +	}
>  
>  	omapdss_walk_device(dss, true);
>  
> @@ -234,6 +236,7 @@ static int __init omapdss_boot_init(void)
>  		kfree(n);
>  	}
>  
> +	of_node_put(dss);
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
