Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF27C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEB020855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lgtjTV/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfDDNfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:35:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50990 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDNfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:35:37 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6534654B;
        Thu,  4 Apr 2019 15:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554384935;
        bh=Dfb43C7ywqP9eNq/jvM/N8I+ZX+/5hIN2hHb/tZ7a7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgtjTV/D3G2MeRDJqcMX4eCWkDXhS1M8Aa5ePxNZKg8DID7VwyoqGRqkCWWokGYyu
         O1k1UDrkADaTFBmfEp0daBubK06HPsTBbaonikWwaa1qWBxDcBAlGiMuEIbXQQxpx1
         y8Ra6/Gb/U3F+HeCvy6lH6pD9o3xZie+m6rwAjsA=
Date:   Thu, 4 Apr 2019 16:35:24 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 6/7] drm: rcar-du: fix possible object reference leak
Message-ID: <20190404133524.GC7817@pendragon.ideasonboard.com>
References: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
 <1554307455-40361-7-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554307455-40361-7-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

Thank you for the patch.

On Thu, Apr 04, 2019 at 12:04:14AM +0800, Wen Yang wrote:
> The call to of_get_parent returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> drivers/gpu/drm/rcar-du/rcar_du_of.c:235:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 216, but without a corresponding object release within this function.
> drivers/gpu/drm/rcar-du/rcar_du_of.c:236:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 209, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org (open list)
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_of.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_of.c b/drivers/gpu/drm/rcar-du/rcar_du_of.c
> index afef696..30bceca 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_of.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_of.c
> @@ -232,6 +232,8 @@ static void __init rcar_du_of_lvds_patch(const struct of_device_id *of_ids)
>  	lvds_node = of_find_compatible_node(NULL, NULL, compatible);
>  	if (lvds_node) {
>  		of_node_put(lvds_node);
> +		of_node_put(soc_node);
> +		of_node_put(du_node);
>  		return;

Wouldn't it be simpler to just turn the return into a goto done ?

>  	}
>  

-- 
Regards,

Laurent Pinchart
