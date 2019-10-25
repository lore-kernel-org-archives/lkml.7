Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9849ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758D620663
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409149AbfJYKM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:12:28 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:47940 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409097AbfJYKMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:12:24 -0400
X-IronPort-AV: E=Sophos;i="5.68,228,1569276000"; 
   d="scan'208";a="408167341"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 12:12:22 +0200
Date:   Fri, 25 Oct 2019 12:12:23 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Wambui Karuga <wambui.karugax@gmail.com>
cc:     dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [Outreachy][PATCH] drm: use DIV_ROUND_UP
 helper macro for calculations
In-Reply-To: <20191025094907.3582-1-wambui.karugax@gmail.com>
Message-ID: <alpine.DEB.2.21.1910251212070.3307@hadrien>
References: <20191025094907.3582-1-wambui.karugax@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Oct 2019, Wambui Karuga wrote:

> Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> macro for better readability.
> Issue found using coccinelle:
> @@
> expression n,d;
> @@
> (
> - ((n + d - 1) / d)
> + DIV_ROUND_UP(n,d)
> |
> - ((n + (d - 1)) / d)
> + DIV_ROUND_UP(n,d)
> )
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  drivers/gpu/drm/drm_agpsupport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_agpsupport.c b/drivers/gpu/drm/drm_agpsupport.c
> index 6e09f27fd9d6..4c7ad46fdd21 100644
> --- a/drivers/gpu/drm/drm_agpsupport.c
> +++ b/drivers/gpu/drm/drm_agpsupport.c
> @@ -212,7 +212,7 @@ int drm_agp_alloc(struct drm_device *dev, struct drm_agp_buffer *request)
>  	if (!entry)
>  		return -ENOMEM;
>
> -	pages = (request->size + PAGE_SIZE - 1) / PAGE_SIZE;
> +	pages = DIV_ROUND_UP(request->size, PAGE_SIZE);
>  	type = (u32) request->type;
>  	memory = agp_allocate_memory(dev->agp->bridge, pages, type);
>  	if (!memory) {
> @@ -325,7 +325,7 @@ int drm_agp_bind(struct drm_device *dev, struct drm_agp_binding *request)
>  	entry = drm_agp_lookup_entry(dev, request->handle);
>  	if (!entry || entry->bound)
>  		return -EINVAL;
> -	page = (request->offset + PAGE_SIZE - 1) / PAGE_SIZE;
> +	page = DIV_ROUND_UP(request->offset, PAGE_SIZE);
>  	retcode = drm_bind_agp(entry->memory, page);
>  	if (retcode)
>  		return retcode;
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191025094907.3582-1-wambui.karugax%40gmail.com.
>
