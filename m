Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D1C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752FB20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1ykHWXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfFLShF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:37:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39833 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfFLShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:37:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so10179381pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DXItd4QKKcMyTRkmGL6RVgljzEiWFbcFIOw7FfH00GY=;
        b=V1ykHWXuVctHxVCMZR31Lhf3ekEW5RMkXg6I05eaOkPCMQsvEUB1GVZaePVtkB/AkR
         bWSJpUjVq7yRTAKhi/PaorCVoSomgKPHQvsWCaE+dw/19ArzU5MGJLobYMvq1YBz3bCg
         CaZVseF+pNS62h+aqbO+KjLTbqJwEe1uqAAfLm39CR4/eXxMhNmm0pN471EUwlAs+qhh
         leT90bOaEEsVRv/62wmo+FKl1YZoiEhxSA+DsweI4ZqY6+So33HOn5cK68e3IKzNWBAp
         JcPEAhEDlISCS4ivdeUEp8kSAGLMQzJI513eyyHD1dHe8C150IH+AaURoTChf1U7GI+R
         M53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXItd4QKKcMyTRkmGL6RVgljzEiWFbcFIOw7FfH00GY=;
        b=p7KopVlq8LrqXTJgT9hXWY1KWqaZnVgvSWbQkMjHvIxSpXtwaHk8GJv07Zp46OdDXK
         diwrBmaDJ4FNEUmxTUvCw3odpC7VLO2UtAWEBFOyCHhliwKHV1X1sRhGKLlXrxHm44ZA
         s4Yojdb1TTyEEl4tiYU0e1cVN2ifJrzRni6a5bblIuGagJSIkgc21gDWhIBsIvS6Eh/3
         Vg0SJoI9Qopvf/aa8VDnh1w6uIxJca8STBOckO4qIshOJHBffYUYHJtgrlSpKAii/M7i
         dUQYdggL3+rhljwKpUaOXTHYVRdKRXP03YiaTkEtqqbbAxEzWLzb8LUejdn+sT73c0uB
         U2Rw==
X-Gm-Message-State: APjAAAVY2P0Bh43tEbz+aMoQnq+Gqsoe7wwlNJeP+4DCqIG3khgxWeTi
        P6Ge/mV6Y+jXR6CepP3wQ+c=
X-Google-Smtp-Source: APXvYqzjdoMxCVuEJbHHk09NkgKkEkrFSeajkMZcGBlMNFEnpUY9Mfd7qwmsZB2dZpGscl2+DABZMA==
X-Received: by 2002:a62:4d04:: with SMTP id a4mr87702880pfb.177.1560364621102;
        Wed, 12 Jun 2019 11:37:01 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id 3sm250910pfp.114.2019.06.12.11.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 11:37:00 -0700 (PDT)
Date:   Thu, 13 Jun 2019 00:06:55 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: remove duplicate entry of trace
Message-ID: <20190612183654.GA16750@hari-Inspiron-1545>
References: <20190526075633.GA9245@hari-Inspiron-1545>
 <20190612032236.GH9684@zhen-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612032236.GH9684@zhen-hp.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:22:36AM +0800, Zhenyu Wang wrote:
> On 2019.05.26 13:26:33 +0530, Hariprasad Kelam wrote:
> > Remove duplicate include of trace.h
> > 
> > Issue identified by includecheck
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gvt/trace_points.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gvt/trace_points.c b/drivers/gpu/drm/i915/gvt/trace_points.c
> > index a3deed69..569f5e3 100644
> > --- a/drivers/gpu/drm/i915/gvt/trace_points.c
> > +++ b/drivers/gpu/drm/i915/gvt/trace_points.c
> > @@ -32,5 +32,4 @@
> >  
> >  #ifndef __CHECKER__
> >  #define CREATE_TRACE_POINTS
> > -#include "trace.h"
> >  #endif
> > -- 
> 
> This actually caused build issue like
> ERROR: "__tracepoint_gma_index" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_render_mmio" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_gvt_command" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_spt_guest_change" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_gma_translate" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_spt_alloc" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_spt_change" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_oos_sync" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_write_ir" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_propagate_event" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_inject_msi" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_spt_refcount" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_spt_free" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_oos_change" [drivers/gpu/drm/i915/i915.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> 
> Looks we need fix like below.
> 
> Subject: [PATCH] drm/i915/gvt: remove duplicate include of trace.h
> 
> This removes duplicate include of trace.h. Found by Hariprasad Kelam
> with includecheck.
> 
> Reported-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gvt/trace_points.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/trace_points.c b/drivers/gpu/drm/i915/gvt/trace_points.c
> index a3deed692b9c..fe552e877e09 100644
> --- a/drivers/gpu/drm/i915/gvt/trace_points.c
> +++ b/drivers/gpu/drm/i915/gvt/trace_points.c
> @@ -28,8 +28,6 @@
>   *
>   */
>  
> -#include "trace.h"
> -
>  #ifndef __CHECKER__
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> -- 
> 2.20.1
> 
> -- 
> Open Source Technology Center, Intel ltd.
> 
> $gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

Hi Zhenyu Wang,
Thanks for correcting the patch.
It seems we should first define CREATE_TRACE_POINTS and include trace.h as per documentation.

Thanks,
Hariprasad k
