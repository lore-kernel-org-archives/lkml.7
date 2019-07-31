Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0963C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE05C206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfGaG0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:26:37 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:48876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbfGaG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:26:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D38943811;
        Wed, 31 Jul 2019 06:26:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: error57_395f5308c0426
X-Filterd-Recvd-Size: 2802
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 06:26:34 +0000 (UTC)
Message-ID: <29b3741ca8a9e94d64dba213059abb2296c30936.camel@perches.com>
Subject: Re: [PATCH v2] drm: use trace_printk rather than printk in drm_dbg.
From:   Joe Perches <joe@perches.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Jul 2019 23:26:32 -0700
In-Reply-To: <20190731062416.26238-1-huangfq.daxian@gmail.com>
References: <20190731062416.26238-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 14:24 +0800, Fuqian Huang wrote:
> In drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c,
> amdgpu_ih_process calls DRM_DEBUG which calls drm_dbg and
> finally calls printk.
> As amdgpu_ih_process is called from an interrupt handler,
> and interrupt handler should be short as possible.
> 
> As printk may lead to bogging down the system or can even
> create a live lock. printk should not be used in IRQ context.
> Instead, trace_printk is recommended in IRQ context.
> Link: https://lwn.net/Articles/365835
> 
> Reviewed-by: Joe Perches <joe@perches.com> 

I made a suggestion.  I did not review this.

Please do not add signatures like this if
not specifically given by someone.


> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Only make the interrupt uses the trace_printk to avoid
>     all 4000+ drm_dbg/DRM_DEBUG uses emitting a trace_printk.
> 
>  drivers/gpu/drm/drm_print.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index a17c8a14dba4..747835d16fa6 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -236,9 +236,13 @@ void drm_dbg(unsigned int category, const char *format, ...)
>  	vaf.fmt = format;
>  	vaf.va = &args;
>  
> -	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> -	       __builtin_return_address(0), &vaf);
> -
> +	if (in_interrupt()) {
> +		trace_printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> +		       __builtin_return_address(0), &vaf);
> +	} else {
> +		printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> +		       __builtin_return_address(0), &vaf);
> +	}
>  	va_end(args);
>  }
>  EXPORT_SYMBOL(drm_dbg);

