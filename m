Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD270CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A827420679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="giNNnQgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfJVIhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:37:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36035 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731242AbfJVIha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:37:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so16466888wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xuCgV4YUFYa6Caw2Y7xISyDpnVmWYzdkWcO2116lWE4=;
        b=giNNnQgAjHNft/0FgO/AAhey9WyM3sxbadX7UZAgHpUwSifwzOZJ53L+/otOLfZy1b
         HbgoaElE/oR4BlnRE2UoC/++L7XXQOdCTshf8W5PhHihnq/lRnMl+sepQsVLnOMqPfuc
         Fn5Pj1o0zLvx9mlVr+ApFuiwJwEmfTyGh9RRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xuCgV4YUFYa6Caw2Y7xISyDpnVmWYzdkWcO2116lWE4=;
        b=fH9GLxYjr+wFVYi0vBmOzhMq2Jm5Zlu6FZJfD95UNIhtKI3WanuDG3mEUNMwvfyOJI
         kda+DBnEFpTknAswaeRbansClfXpYDF5auJHPO3nD5a9cB3aaU1KZ/yHnAcJYzmcSIl0
         UFAqAcW/PDlRlilLDmLb5ukWXsY08x0qdkAOViujFiQFDqjJ8mimpSoIrnYtTSgfVFo4
         SoDgz5dXVc+Bp7722D6UwsISx/LCtL1sJ3aQWEZDYZ8dWEQHxcFrMD5WXPr/4Mb+FHSa
         yfMl4sdlu1V1FAVp0TNFfgCC9d0qOCSonYIagZ/1vSgFnFkVowhPV4jrMusdThecIUlG
         CyNw==
X-Gm-Message-State: APjAAAUlIj0yFjDq3HOEdlAbKPN6JEBaZT6Pjuh/BpLTBNExYohSPICv
        mbAdF6B0aW+CA3d/44oHbEUFpg==
X-Google-Smtp-Source: APXvYqzn4oehIGnlOKvsXHpvbPtT9iSU1nTJNoBE2XJUwT2ImOHs2/TzhEOV5ZcOXZEqgAMK7GYnPw==
X-Received: by 2002:a5d:6a03:: with SMTP id m3mr420075wru.90.1571733447653;
        Tue, 22 Oct 2019 01:37:27 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id p12sm4910430wrt.7.2019.10.22.01.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:37:26 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:37:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, ville.syrjala@linux.intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm: atomic helper: fix W=1 warnings
Message-ID: <20191022083725.GW11828@phenom.ffwll.local>
Mail-Followup-To: Benjamin Gaignard <benjamin.gaignard@st.com>,
        airlied@linux.ie, ville.syrjala@linux.intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20191008124254.2144-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008124254.2144-1-benjamin.gaignard@st.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 02:42:54PM +0200, Benjamin Gaignard wrote:
> Few for_each macro set variables that are never used later which led
> to generate unused-but-set-variable warnings.
> Add (void)(foo) inside the macros to remove these warnings
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

OCD in me would lean towards annotating all of them, unconditionally, and
be done. But I guess this works too. Either way:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  include/drm/drm_atomic.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 927e1205d7aa..b6c73fd9f55a 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -693,6 +693,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i)++)								\
>  		for_each_if ((__state)->connectors[__i].ptr &&			\
>  			     ((connector) = (__state)->connectors[__i].ptr,	\
> +			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
>  			     (old_connector_state) = (__state)->connectors[__i].old_state,	\
>  			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
>  
> @@ -714,6 +715,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i)++)								\
>  		for_each_if ((__state)->connectors[__i].ptr &&			\
>  			     ((connector) = (__state)->connectors[__i].ptr,	\
> +			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
>  			     (old_connector_state) = (__state)->connectors[__i].old_state, 1))
>  
>  /**
> @@ -734,7 +736,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i)++)								\
>  		for_each_if ((__state)->connectors[__i].ptr &&			\
>  			     ((connector) = (__state)->connectors[__i].ptr,	\
> -			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
> +			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
> +			     (new_connector_state) = (__state)->connectors[__i].new_state, \
> +			     (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic update
> @@ -754,7 +758,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i)++)							\
>  		for_each_if ((__state)->crtcs[__i].ptr &&		\
>  			     ((crtc) = (__state)->crtcs[__i].ptr,	\
> +			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
>  			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
> +			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
>  			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
>  
>  /**
> @@ -793,7 +799,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i)++)							\
>  		for_each_if ((__state)->crtcs[__i].ptr &&		\
>  			     ((crtc) = (__state)->crtcs[__i].ptr,	\
> -			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
> +			     (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
> +			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
> +			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update
> @@ -813,6 +821,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i)++)							\
>  		for_each_if ((__state)->planes[__i].ptr &&		\
>  			     ((plane) = (__state)->planes[__i].ptr,	\
> +			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
>  			      (old_plane_state) = (__state)->planes[__i].old_state,\
>  			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
>  
> @@ -873,7 +882,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i)++)							\
>  		for_each_if ((__state)->planes[__i].ptr &&		\
>  			     ((plane) = (__state)->planes[__i].ptr,	\
> -			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
> +			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
> +			      (new_plane_state) = (__state)->planes[__i].new_state, \
> +			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_oldnew_private_obj_in_state - iterate over all private objects in an atomic update
> -- 
> 2.15.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
