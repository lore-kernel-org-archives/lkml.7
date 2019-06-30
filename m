Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897CFC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595F32089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfF3ISi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 04:18:38 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:38632 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3ISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:18:38 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8F5C220065;
        Sun, 30 Jun 2019 10:18:34 +0200 (CEST)
Date:   Sun, 30 Jun 2019 10:18:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] DRM: ingenic: Use devm_platform_ioremap_resource
Message-ID: <20190630081833.GC5081@ravnborg.org>
References: <20190627182114.27299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627182114.27299-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=7gkXJVJtAAAA:8 a=aVMsacSFOT9BCqWdKMAA:9 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Thu, Jun 27, 2019 at 08:21:12PM +0200, Paul Cercueil wrote:
> Simplify a bit the probe function by using the newly introduced
> devm_platform_ioremap_resource(), instead of having to call
> platform_get_resource() followed by devm_ioremap_resource().
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index a069579ca749..02c4788ef1c7 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -580,7 +580,6 @@ static int ingenic_drm_probe(struct platform_device *pdev)
>  	struct drm_bridge *bridge;
>  	struct drm_panel *panel;
>  	struct drm_device *drm;
> -	struct resource *mem;
>  	void __iomem *base;
>  	long parent_rate;
>  	int ret, irq;
> @@ -614,8 +613,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
>  	drm->mode_config.max_height = 600;
>  	drm->mode_config.funcs = &ingenic_drm_mode_config_funcs;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, mem);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base)) {
>  		dev_err(dev, "Failed to get memory resource");
Consider to include the error code in the error message here.
>  		return PTR_ERR(base);

With the above fixed/considered:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
