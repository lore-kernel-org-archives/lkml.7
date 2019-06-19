Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA05C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A4E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AAfkTTSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfFSKyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:54:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39181 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfFSKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:54:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so26552502edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QY2cB/ek3avil0WWVbVVUp42tC+bZPNjHndcUKtP3qg=;
        b=AAfkTTSiH6c1JRF/U9BXAPYQmnuSUgznCkWJYDCdQebjNfukOYWC120SrbYT7IRxOV
         bW19TTY2OKSPu9JZ12Rr7AtmuyV2LB6T0s28ZkNCtWeir9LM0NmS6P0t0hipx4qkOpI8
         2NJUGONFFitG7UgLK3tblNDyuwoYNBdl6rKiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QY2cB/ek3avil0WWVbVVUp42tC+bZPNjHndcUKtP3qg=;
        b=TZnhbESWhWeyUk5+Q6Dliqm+gSm6uBjjForW1Qm9sQFXXzeufzAa1diDF0ORentpsi
         SE2eaYsoIjmHeZlZZszoEuIirR9F//RMrj5UGBIiBcBODadRH7YqgJchNXdN04Oqwh9N
         5/r37j9N1gJUpooqgfuGBZYxOic391ilxFqI2MEj9rK7skBEU8GxcmU9m7p6WJwx0AHc
         zaWmvRXCIic/0xjbctzAXdvnoLfL5Clpckl34n0Dy3UiUUOqrue6Dctvn/z7GirkZEFG
         DTxJs6udx+BKv4ooyOXWaxKIkB3Wdt2Yd+SGMTGuzBkd4SHWyPrNm/9jr6XF1WL0w5aa
         JCTg==
X-Gm-Message-State: APjAAAU7QWYlk2w8W/NaD6naHUOMVKmvV8WKBTfmWXVajigiC7im8kPR
        az8AxTj+LxsgNfqEN1pq89rrRw==
X-Google-Smtp-Source: APXvYqyjDOhGM7UY5Pp/TBcr8l28U3dy70TTDpAaWsnHZq6PjKPSWlG6BOuIN5nCESWIBNDh5FiXQQ==
X-Received: by 2002:a50:b104:: with SMTP id k4mr105010717edd.75.1560941646113;
        Wed, 19 Jun 2019 03:54:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c8sm3203014ejm.55.2019.06.19.03.54.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 03:54:05 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:54:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/12] drm: add gem array helpers
Message-ID: <20190619105401.GM12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190619090420.6667-1-kraxel@redhat.com>
 <20190619090420.6667-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619090420.6667-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:04:09AM +0200, Gerd Hoffmann wrote:
> Add struct and helper functions to manage an array of gem objects.
> See added kernel docs for details.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Hm, feels like jumping ahead here, I think there's too much still
in-flight:
- Christian is pondering some improved ww_mutex lock/unlock helpers.
  That'll probably change a lot of this code too.
- If we do more helpers, then I think we should have a consistent story
  across everything. These here don't really fit into the existing gem
  lock/unlock helpers.
- We probably want to design something coherent to replace all the ttm
  execbuf utils, i.e. bo lookup, locking, updating reservation objects,
  all that.
- I think this needs more than one driver to proof itself.

Maybe long-term we could have a drm_gem_eu_helper.c or so which contains
all that. But that's still some ways off.

I'd go back to the virtio-only conversion, and once we have more of this
stuff settled, we can look at how to properly design some nice&consistent
helpers.

Cheers, Daniel
> ---
>  include/drm/drm_gem_array_helper.h     | 15 +++++
>  drivers/gpu/drm/drm_gem_array_helper.c | 76 ++++++++++++++++++++++++++
>  drivers/gpu/drm/Makefile               |  3 +-
>  3 files changed, 93 insertions(+), 1 deletion(-)
>  create mode 100644 include/drm/drm_gem_array_helper.h
>  create mode 100644 drivers/gpu/drm/drm_gem_array_helper.c
> 
> diff --git a/include/drm/drm_gem_array_helper.h b/include/drm/drm_gem_array_helper.h
> new file mode 100644
> index 000000000000..adf7961247b3
> --- /dev/null
> +++ b/include/drm/drm_gem_array_helper.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DRM_GEM_ARRAY_HELPER_H__
> +#define __DRM_GEM_ARRAY_HELPER_H__
> +
> +struct drm_gem_object_array {
> +	u32 nents;
> +	struct drm_gem_object *objs[];
> +};
> +
> +struct drm_gem_object_array *drm_gem_array_alloc(u32 nents);
> +struct drm_gem_object_array *
> +drm_gem_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents);
> +void drm_gem_array_put_free(struct drm_gem_object_array *objs);
> +
> +#endif /* __DRM_GEM_ARRAY_HELPER_H__ */
> diff --git a/drivers/gpu/drm/drm_gem_array_helper.c b/drivers/gpu/drm/drm_gem_array_helper.c
> new file mode 100644
> index 000000000000..d35c77c4a02d
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_gem_array_helper.c
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <drm/drm_gem.h>
> +#include <drm/drm_gem_array_helper.h>
> +
> +/**
> + * drm_gem_array_alloc -- allocate gem object array of the given size.
> + *
> + * @nents: number of entries needed.
> + *
> + * Returns: An array of gem objects on success, NULL on failure.
> + */
> +struct drm_gem_object_array *drm_gem_array_alloc(u32 nents)
> +{
> +	struct drm_gem_object_array *objs;
> +	size_t size = sizeof(*objs) + sizeof(objs->objs[0]) * nents;
> +
> +	objs = kzalloc(size, GFP_KERNEL);
> +	if (!objs)
> +		return NULL;
> +
> +	objs->nents = nents;
> +	return objs;
> +}
> +EXPORT_SYMBOL(drm_gem_array_alloc);
> +
> +static void drm_gem_array_free(struct drm_gem_object_array *objs)
> +{
> +	kfree(objs);
> +}
> +
> +/**
> + * drm_gem_array_from_handles -- lookup an array of gem handles.
> + *
> + * @drm_file: drm file-private structure to use for the handle look up
> + * @handles: the array of handles to lookup.
> + * @nents: the numer of handles.
> + *
> + * Returns: An array of gem objects on success, NULL on failure.
> + */
> +struct drm_gem_object_array*
> +drm_gem_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents)
> +{
> +	struct drm_gem_object_array *objs;
> +	u32 i;
> +
> +	objs = drm_gem_array_alloc(nents);
> +	if (!objs)
> +		return NULL;
> +
> +	for (i = 0; i < nents; i++) {
> +		objs->objs[i] = drm_gem_object_lookup(drm_file, handles[i]);
> +		if (!objs->objs[i]) {
> +			drm_gem_array_put_free(objs);
> +			return NULL;
> +		}
> +	}
> +	return objs;
> +}
> +
> +/**
> + * drm_gem_array_put_free -- put gem objects and free array.
> + *
> + * @objs: the gem object array.
> + */
> +void drm_gem_array_put_free(struct drm_gem_object_array *objs)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < objs->nents; i++) {
> +		if (!objs->objs[i])
> +			continue;
> +		drm_gem_object_put_unlocked(objs->objs[i]);
> +	}
> +	drm_gem_array_free(objs);
> +}
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 9d630a28a788..d32e7de0937b 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -43,7 +43,8 @@ drm_kms_helper-y := drm_crtc_helper.o drm_dp_helper.o drm_dsc.o drm_probe_helper
>  		drm_simple_kms_helper.o drm_modeset_helper.o \
>  		drm_scdc_helper.o drm_gem_framebuffer_helper.o \
>  		drm_atomic_state_helper.o drm_damage_helper.o \
> -		drm_format_helper.o drm_self_refresh_helper.o
> +		drm_format_helper.o drm_self_refresh_helper.o \
> +		drm_gem_array_helper.o
>  
>  drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
>  drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
