Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7063DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E442054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TeJLtrEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfEFOnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:43:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37840 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfEFOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:43:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so15584677edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vaAPp8PyjYHsdP1CZGhOGZcNrdzUmU4mz1az3gjIEag=;
        b=TeJLtrEe4JxAY6kU+FgDMqxxH774q5OmDnPgF4z1LCxJ0gA2hydu8AIgwxknkumsP+
         w+p3KFDudzEwfTQwrebwzQ8H7AFC6XnqlApAqm6znxrbNtpsSorAwrpuQTF7daJEPSte
         JtoM1vJiuvvMaYngrNIWUOuj8SndGJQPvePfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vaAPp8PyjYHsdP1CZGhOGZcNrdzUmU4mz1az3gjIEag=;
        b=iDd9kV18T+38PdJC5C9R5/xoEHV1uSkDcRy0LVptMBglOFoJ96lOLSA3RuJFKDJnJ4
         7ewjNcZLcwPsfb/Ry5e/tnsnG6sY1uuic102EhJdiXl1VEmeDg3IELdA4lJImWnPkThK
         FhuTssYhPx0lJJr0UhQ5glJ+FwHp4VBMi4Kl1/EOjbXEPWbgLr71+S0jqXlc4zz3BIS2
         msa9xr0e3i/dJRa6Ohzjoj2d+5eeShdFBv0KK0z5nDLJcpSVdHlPbWPIfEuTtPxJq3Yp
         6QO4pNgd1y7gYv8TG5skHPcUfe/rYE+gO9wKLmikXhsnaRH4XWu8zRj/sgTwo6IHfEqe
         2ylQ==
X-Gm-Message-State: APjAAAV0nP5nzTd6BlqEnf4lOXuJA6BIDQq+VRIYXiY5LCGOUqtvJUHI
        51gdOk8rIZAzed6zRfQiHcineQ==
X-Google-Smtp-Source: APXvYqwtl5T/MpDTj7LbNirYR1SvYe+WhzHms3LVnX/pzSNP1kZnlocJBCYDhRieEoZXTXVwEMT6xg==
X-Received: by 2002:a50:be42:: with SMTP id b2mr27581867edi.228.1557153817556;
        Mon, 06 May 2019 07:43:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q18sm1602623ejp.56.2019.05.06.07.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 07:43:36 -0700 (PDT)
Date:   Mon, 6 May 2019 16:43:34 +0200
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
Message-ID: <20190506144334.GH17751@phenom.ffwll.local>
Mail-Followup-To: jagdsh.linux@gmail.com, robdclark@gmail.com,
        sean@poorly.run, airlied@linux.ie, bskeggs@redhat.com,
        hierry.reding@gmail.com, jcrouse@codeaurora.org,
        jsanka@codeaurora.org, skolluku@codeaurora.org,
        paul.burton@mips.com, jrdr.linux@gmail.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
References: <1556906293-128921-1-git-send-email-jagdsh.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556906293-128921-1-git-send-email-jagdsh.linux@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 11:28:13PM +0530, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> 
> Remove duplicate headers which are included twice.
> 
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

I collected some acks for the msm and nouveau parts and pushed this. For
next time around would be great if you split these up along driver/module
boundaries, so that each maintainer can pick this up directly.

Thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c             | 1 -
>  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c        | 2 --
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 -
>  3 files changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> index 018df2c..45a5bc6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> @@ -15,7 +15,6 @@
>  #include "dpu_hwio.h"
>  #include "dpu_hw_lm.h"
>  #include "dpu_hw_mdss.h"
> -#include "dpu_kms.h"
>  
>  #define LM_OP_MODE                        0x00
>  #define LM_OUT_SIZE                       0x04
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
> index c80b967..2b44ba5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
> @@ -26,8 +26,6 @@
>  
>  #include <subdev/gpio.h>
>  
> -#include <subdev/gpio.h>
> -
>  static void
>  nv04_bus_intr(struct nvkm_bus *bus)
>  {
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> index 2c9c972..cacf2e0 100644
> --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> @@ -53,7 +53,6 @@
>  #include <linux/of_graph.h>
>  #include <linux/pm.h>
>  
> -#include <drm/drm_panel.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_mipi_dsi.h>
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
