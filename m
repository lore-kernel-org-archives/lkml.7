Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D67FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD3020640
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="G9sSCpQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391290AbfJPPE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:04:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50206 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfJPPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:04:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so3326731wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gy9Mqvz7ViVsHcvjshcUIFjm83FQXB1FgFTRQgeKnZg=;
        b=G9sSCpQWzfSQ2lgVJZuH2GvIMH7I+v+Zsriz4Mk7x7se0mK/ibhKOqMtCpv5XjWRYN
         kf0LTGEoWRMYsmzpfbDDPxPB+1Ad+s+dopUEQWWsPHir9iUGVUOzQYDUSr7c8F+0nKBu
         fzHiqkv6+OUkT0snZt+o1rhuuIsfYcsLuLtag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Gy9Mqvz7ViVsHcvjshcUIFjm83FQXB1FgFTRQgeKnZg=;
        b=AymuIr4/e+TQAjhTwC/GEhseAFrXq9Ei3gLO3ApPNLi55lcUGcGognBZp0Wwc3OS2V
         Zcha0l4lUJBdeoPzgH/GQOsbR6VRd/EvE6rN0tlkhHHRQZ202FueEqU+kFZQQUCtDFKb
         ofqzwWwJHwmtXNqer8skFfPMF2X89lBkYXpruljPOxGpWKTmnprmnKh2OO22PeGlI2G7
         flRytDE7iB15AHiao8Lk/SseYfSfInQRbcJAv8qfXPxTGrqhQ1c8A+8zfWhyTpByar6h
         2BGLhs4IBx/DgPTtBe4efkvoZtcMDiINF3PvGMe1wmAg43VRdVBWYM/P5ve8bIHdd2xs
         10FQ==
X-Gm-Message-State: APjAAAXUgEnX9newSIGt9jxoK6PrBVD8DLSykV5XbfPRjiqQuaTFoSxB
        FWwpt9JJkgBvaULKllsYZMHTxw==
X-Google-Smtp-Source: APXvYqwENQa0ZhP9R+YaODjOskIqVrhbRbWPHKcsVMTitFlrbg4jiwWjBaF/eiyfcZK+zwBUTq+a6g==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr3630959wmj.22.1571238296595;
        Wed, 16 Oct 2019 08:04:56 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id m62sm2553828wmm.35.2019.10.16.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 08:04:55 -0700 (PDT)
Date:   Wed, 16 Oct 2019 17:04:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/11] drm/ttm: add drm_gem_ttm_mmap()
Message-ID: <20191016150453.GS11828@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20191016115203.20095-1-kraxel@redhat.com>
 <20191016115203.20095-9-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016115203.20095-9-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 01:52:00PM +0200, Gerd Hoffmann wrote:
> Add helper function to mmap ttm bo's using &drm_gem_object_funcs.mmap().
> 
> Note that with this code path access verification is done by
> drm_gem_mmap() (which calls drm_vma_node_is_allowed(()).
> The &ttm_bo_driver.verify_access() callback is is not used.
> 
> v3: use ttm_bo_mmap_obj instead of ttm_bo_mmap_vma_setup
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Also on the entire series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> ---
>  include/drm/drm_gem_ttm_helper.h     |  2 ++
>  drivers/gpu/drm/drm_gem_ttm_helper.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
> index 6268f89c5a48..118cef76f84f 100644
> --- a/include/drm/drm_gem_ttm_helper.h
> +++ b/include/drm/drm_gem_ttm_helper.h
> @@ -15,5 +15,7 @@
>  
>  void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
>  			    const struct drm_gem_object *gem);
> +int drm_gem_ttm_mmap(struct drm_gem_object *gem,
> +		     struct vm_area_struct *vma);
>  
>  #endif
> diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
> index a534104d8bee..7412bfc5c05a 100644
> --- a/drivers/gpu/drm/drm_gem_ttm_helper.c
> +++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
> @@ -52,5 +52,22 @@ void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
>  }
>  EXPORT_SYMBOL(drm_gem_ttm_print_info);
>  
> +/**
> + * drm_gem_ttm_mmap() - mmap &ttm_buffer_object
> + * @gem: GEM object.
> + * @vma: vm area.
> + *
> + * This function can be used as &drm_gem_object_funcs.mmap
> + * callback.
> + */
> +int drm_gem_ttm_mmap(struct drm_gem_object *gem,
> +		     struct vm_area_struct *vma)
> +{
> +	struct ttm_buffer_object *bo = drm_gem_ttm_of_gem(gem);
> +
> +	return ttm_bo_mmap_obj(vma, bo);
> +}
> +EXPORT_SYMBOL(drm_gem_ttm_mmap);
> +
>  MODULE_DESCRIPTION("DRM gem ttm helpers");
>  MODULE_LICENSE("GPL");
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
