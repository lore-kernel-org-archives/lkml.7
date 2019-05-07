Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C77C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376B22053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="evcWe3qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEGKFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:05:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39727 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGKFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:05:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so18145748edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UswE8rrHo9QpkEQ1cscUjaFrFCZrjR7SNVgDCehnvY4=;
        b=evcWe3qnR8Rs0GV0G6oQdOzN5VRQ17f1mfCNnZ9T5cwXYFQu5vI/OWowa9isuK8GqL
         QiGcByLmeamZ+oKRnXjqbUESbqdxOo9QEXFaGsfwcrbTH+NQXTgP9nJoGFTUpDLOyQfO
         eC1QYbRlJ3m1l2rTnX0em5lxT2P5wp6dw+Mik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UswE8rrHo9QpkEQ1cscUjaFrFCZrjR7SNVgDCehnvY4=;
        b=RKWqix/gP+7nsXas0AfBWKE7xOKjc38YpAU/7bOCn+aZYaCl5EsAx02YTXFmsiB/v1
         FgMHF+q2vVAN02WQXtDnEjDyk8BGeQkVZ9mLYlKUHwcU5e4yeGjtl32eoVcRYW9yyiWf
         aC24/AFBxB1oVOJmyfEyybPyRowyGdgTUyvjtAfXkR7pXoSLVUwwANpOjBnlZrsfSDO7
         KITLi+S7C8dxnV04viHtoOHUeY3onPdJi4xV+FYv8nOUFROsr+4WsM3DGexzJ43poWOj
         byuO+h7bNwNec4vQPTvBjXIFOZ0hFEKBI48PCEk+vrz0bxVppp4Dv/8fcAOh1R0tz9Nn
         53yQ==
X-Gm-Message-State: APjAAAUOOnkx2SD5hWVgTfmazxvJXyNxkQw3J4zv6lGUDPEtrlIwyVa4
        0CdLRCOgXtmg7AygnnXhgBQzGg==
X-Google-Smtp-Source: APXvYqx10Oa/B2xszv1CzqJEyltgTlabbZu4UqLNgz7sqW1XDMCvuYWJUPrIGYjfWLlE2v4gSY7QxA==
X-Received: by 2002:a50:be05:: with SMTP id a5mr22512407edi.75.1557223536438;
        Tue, 07 May 2019 03:05:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b48sm1072765edb.28.2019.05.07.03.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 03:05:35 -0700 (PDT)
Date:   Tue, 7 May 2019 12:05:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     jagdsh.linux@gmail.com
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, bskeggs@redhat.com, hierry.reding@gmail.com,
        jcrouse@codeaurora.org, jsanka@codeaurora.org,
        skolluku@codeaurora.org, paul.burton@mips.com,
        jrdr.linux@gmail.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH] gpu/drm: Remove duplicate headers
Message-ID: <20190507100532.GP17751@phenom.ffwll.local>
Mail-Followup-To: jagdsh.linux@gmail.com, robdclark@gmail.com,
        sean@poorly.run, airlied@linux.ie, bskeggs@redhat.com,
        hierry.reding@gmail.com, jcrouse@codeaurora.org,
        jsanka@codeaurora.org, skolluku@codeaurora.org,
        paul.burton@mips.com, jrdr.linux@gmail.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
References: <1556906293-128921-1-git-send-email-jagdsh.linux@gmail.com>
 <20190506144334.GH17751@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506144334.GH17751@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:43:34PM +0200, Daniel Vetter wrote:
> On Fri, May 03, 2019 at 11:28:13PM +0530, jagdsh.linux@gmail.com wrote:
> > From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> > 
> > Remove duplicate headers which are included twice.
> > 
> > Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> 
> I collected some acks for the msm and nouveau parts and pushed this. For
> next time around would be great if you split these up along driver/module
> boundaries, so that each maintainer can pick this up directly.
> 
> Thanks for your patch.
> -Daniel
> 
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c             | 1 -
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c        | 2 --
> >  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 -

Correction, this didn't compile, so I dropped the changes to panel-rpi.
Another reason to split patches more for next time around. Also, needs
more compile testing (you need cross compilers for at least arm to test
this stuff).
-Daniel

> >  3 files changed, 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> > index 018df2c..45a5bc6 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> > @@ -15,7 +15,6 @@
> >  #include "dpu_hwio.h"
> >  #include "dpu_hw_lm.h"
> >  #include "dpu_hw_mdss.h"
> > -#include "dpu_kms.h"
> >  
> >  #define LM_OP_MODE                        0x00
> >  #define LM_OUT_SIZE                       0x04
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
> > index c80b967..2b44ba5 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
> > @@ -26,8 +26,6 @@
> >  
> >  #include <subdev/gpio.h>
> >  
> > -#include <subdev/gpio.h>
> > -
> >  static void
> >  nv04_bus_intr(struct nvkm_bus *bus)
> >  {
> > diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> > index 2c9c972..cacf2e0 100644
> > --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> > +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> > @@ -53,7 +53,6 @@
> >  #include <linux/of_graph.h>
> >  #include <linux/pm.h>
> >  
> > -#include <drm/drm_panel.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_mipi_dsi.h>
> > -- 
> > 1.8.3.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
