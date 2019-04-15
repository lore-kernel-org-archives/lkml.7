Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6344DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F70820675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dBqaVp2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDOJca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:32:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43283 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:32:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so3846066edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2qQwhdB421Qs0uWk8Slq+6JwlD5A2OSiEdeM5YjOvIs=;
        b=dBqaVp2zfsW7DxkosP1fho0b5Em13Dj6agL8htiwaqz+z1attu13/AdwJvLnweJdmJ
         kmQMRTwDBee5x9gVksSxL5KqJl4mTuEE8b8UmGERvbjLQg72g0YLXiPhF4KpPOY7mQTO
         VU1Krg0R/2xeR/Gprs4jRq/R64rGrPfbm80Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2qQwhdB421Qs0uWk8Slq+6JwlD5A2OSiEdeM5YjOvIs=;
        b=ezMFyGGZaHstOb5CBrsAQcHI9yVK5gMW1sqERQxn0+NN4d66lI48aiBdAWnRYYWd3i
         C4yIAmsTWxk7MnBAscfIVpaNtn3nuwpuulCInyxBpeLOpFEOsK+elfJZUxZbUuqi8wv+
         dD2XuDebSV6/0tjVT6mq9pnlzBnZtOysguR61N+Y00I93K+VUftQJdk6/STAnSnsWyDv
         uM2brfres4JSBKF98eqp6fB+i1RKUgI1+jMESOiCmsGbogA6Gd4oyi2zXAlXMlMnk7eQ
         UdJOabVb6s/pqOxeH5EKGJpn58EzONkiC81b3HNI0mfS7RUy3Uw5/TOeaH6NJTJ3lHrz
         6f2w==
X-Gm-Message-State: APjAAAVSX3VmB69rlVwS+IZuCV73AY44OrmdlxPGMSFQTcVOyh978sbX
        B5g4I3yuRNDe0POvm02Z9uAKag==
X-Google-Smtp-Source: APXvYqxSc/ieUzmXRnqpiI+n6o3raieNWkWwM2zAJzFQvocJf2ip+F4N2nwUEO7fyMKa+eYkrJSTjw==
X-Received: by 2002:a50:82a6:: with SMTP id 35mr22620089edg.15.1555320748955;
        Mon, 15 Apr 2019 02:32:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p1sm7187077ejf.40.2019.04.15.02.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 02:32:27 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:32:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
Subject: Re: [PATCH 1/2] drm/i915: Use drm_dev_unplug()
Message-ID: <20190415093225.GZ2665@phenom.ffwll.local>
Mail-Followup-To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>, michal.wajdeczko@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
References: <20190405130235.7707-1-janusz.krzysztofik@linux.intel.com>
 <20190405130235.7707-2-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405130235.7707-2-janusz.krzysztofik@linux.intel.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 03:02:34PM +0200, Janusz Krzysztofik wrote:
> From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> 
> The driver does not currently support unbinding from a device which is
> in use.  Since open file descriptors may still be pointing into kernel
> memory where the device structures used to be, entirely correct kernel
> panics protect the driver from being unbound as we should not be
> unbinding it before those dangling pointers have been made safe.
> 
> According to the documentation found inside drivers/gpu/drm/drm_drv.c,
> drm_dev_unplug() should be used instead of drm_dev_unregister() in
> order to make a device inaccessible to users as soon as it is unpluged.
> Follow that advice to make those possibly dangling pointers safe,
> protected by DRM layer from a user who is otherwise left pointing into
> possibly reused kernel memory after the driver has been unbound from
> the device.  Once done, also cancel inflight operations immediately by
> calling i915_gem_set_wedged().
> 
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/i915/i915_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 9df65d386d11..66163378c481 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -1596,7 +1596,7 @@ static void i915_driver_unregister(struct drm_i915_private *dev_priv)
>  	i915_pmu_unregister(dev_priv);
>  
>  	i915_teardown_sysfs(dev_priv);
> -	drm_dev_unregister(&dev_priv->drm);
> +	drm_dev_unplug(&dev_priv->drm);
>  
>  	i915_gem_shrinker_unregister(dev_priv);
>  }
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
