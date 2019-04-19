Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A6A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfDSS2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:28:53 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37123 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfDSS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:28:51 -0400
Received: by mail-ed1-f49.google.com with SMTP id f53so5027258ede.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOqks1j+bXZCpedikQrIMl/mE0JryKYZl3iqTaQ4Bds=;
        b=Gdd27XS9XQM7uy5XIAt0T7CipZG/cwLdGmSvKGYN2BJu8yBg7y33bb8xeKWul9Abm2
         v8L8QK2wnkZQhQ1gc/Pe3V5dioboHGYK9B+8oA3VBYSb9cXr+C1IpwulR032zdrGX3Tf
         8oq5PqaCmMQYogI0eT1kO4Oa8DF2Inc4UDMC2E8mzUA90Imn5C7Qfk9i/aFaO7dBHsxk
         skq+81df8KMywTD++eNnouFm+VXtXyYqWPB+hUgPgCPlP/0p5erbYACLZoCDOG8Gl5FA
         VwJ1BTWoPfto7CL7oHqlERpggtNOpvitr8T24eRfetAvjI7ijvhRiuLav37Tzj0l5dg2
         yUhQ==
X-Gm-Message-State: APjAAAW2RaLOTSuxiOiGO+tP+lvGhqy+Auk/TT0K99P21J+Cd/LLieRR
        MQGF2x633i2t+W8JB6ZeO+ChofsY
X-Google-Smtp-Source: APXvYqz9leZu8ZUzftcf7+hiTuJXgMEFPspqZ/1x3tRzL5f8VIN/38NHuR0eKfS7AfVjF5EoByQOzA==
X-Received: by 2002:a50:b144:: with SMTP id l4mr2947732edd.195.1555689771704;
        Fri, 19 Apr 2019 09:02:51 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id lw14sm935605ejb.24.2019.04.19.09.02.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 09:02:51 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id h18so6853646wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 09:02:51 -0700 (PDT)
X-Received: by 2002:a1c:2394:: with SMTP id j142mr3142039wmj.111.1555689770644;
 Fri, 19 Apr 2019 09:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190419080235.24396-1-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190419080235.24396-1-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 19 Apr 2019 09:02:38 -0700
X-Gmail-Original-Message-ID: <CAGb2v64iFwqPJ-me2KOWUjGuObg2brjRNvD_pkPw98Y60hnwQg@mail.gmail.com>
Message-ID: <CAGb2v64iFwqPJ-me2KOWUjGuObg2brjRNvD_pkPw98Y60hnwQg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] drm/sun4i: Unbind components before
 releasing DRM and mem at master unbind
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 1:03 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Our components may still be using the DRM device driver (if only to
> access our driver's private data), so make sure to unbind them before
> the final drm_dev_put.
>
> Also release our resserved memory adter unbind to match reverse

typos...

> creation order.
>
> Fixes: f5a9ed867c83 ("drm/sun4i: Fix component unbinding and component master deletion")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 843b86661833..29258b404e54 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -149,10 +149,11 @@ static void sun4i_drv_unbind(struct device *dev)
>         drm_kms_helper_poll_fini(drm);
>         drm_atomic_helper_shutdown(drm);
>         drm_mode_config_cleanup(drm);
> -       of_reserved_mem_device_release(dev);
> -       drm_dev_put(drm);
>
>         component_unbind_all(dev, NULL);
> +       of_reserved_mem_device_release(dev);

You should probably mention this change in the commit log as well.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +
> +       drm_dev_put(drm);
>  }
>
>  static const struct component_master_ops sun4i_drv_master_ops = {
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
