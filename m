Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B23C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F2627CCD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Brcy2jdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFCH3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:29:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42728 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFCH3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:29:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id g24so15882028eds.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jjN+IUXsOjHIptTOl5JWqEKPtVcuNlnHwmJuoFFIww=;
        b=Brcy2jdPXUAzNpiEHrfV7UeyzBi4k5q2V6K/4n/RcfPFRfyPDu1FGaFz9ButcF9Ecn
         OxvAJIQsgvIfxJbFPlOxKyfZ04aAKLq6g0Wf/x9TzIdDelElJSTqVQXLME4RycN+/78e
         143aME4tWkLnlJLuI1vcJ8nZs3tZ5tY2TA2Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3jjN+IUXsOjHIptTOl5JWqEKPtVcuNlnHwmJuoFFIww=;
        b=FHcs3o61gnJG3OpYV0JokNSJg/sZUo2IiJVi7Hatq1Rw15uj01g3w9PG9gDMiWDsCB
         0ixnv36S56yzW9kp1GlVIe/qDirVgxsHeqgqgPIGYS3QU9g51y9597JtpOXrP7X30wXi
         Fkn6qaxod46odBqcUkDipMcQiUb1/mZHTTe3Zr+THqpgDCF2yG9cXBp/fNo0gano6xdr
         /1pWCRuClD/kHY5OPJb8H+6+PPRB2XGJ/T/RXNZJHosZUa4FARCrvsP4Sg/FgXdgw04q
         vwhN/g+aLQuUrEjV7SAVMEVkuTqaQ6SfNsh0zb1QvIe6nrWJouPTV0NHXUObhgnm8wFy
         R8uQ==
X-Gm-Message-State: APjAAAVtp6GpNUR4QaBCjo36Y3Mht8uk7OkEdUDEZtd6jkcHdyWyyAWR
        fWXDF43ry3Iwseqrvwp0P6OlFw==
X-Google-Smtp-Source: APXvYqx3sgMz6isfXSPFfSZ90atRyyDeM1LUCGOlEAqarIgjvzoyFkaaWodXBPPETDhK+b+5MajKBA==
X-Received: by 2002:a50:ba1b:: with SMTP id g27mr7172413edc.18.1559546956944;
        Mon, 03 Jun 2019 00:29:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c12sm3503859edt.38.2019.06.03.00.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 00:29:16 -0700 (PDT)
Date:   Mon, 3 Jun 2019 09:29:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915: Split off pci_driver.remove() tail to
 drm_driver.release()
Message-ID: <20190603072914.GB21222@phenom.ffwll.local>
Mail-Followup-To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190530133105.30467-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530133105.30467-1-janusz.krzysztofik@linux.intel.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 03:31:05PM +0200, Janusz Krzysztofik wrote:
> In order to support driver hot unbind, some cleanup operations, now
> performed on PCI driver remove, must be called later, after all device
> file descriptors are closed.
> 
> Split out those operations from the tail of pci_driver.remove()
> callback and put them into drm_driver.release() which is called as soon
> as all references to the driver are put.  As a result, those cleanups
> will be now run on last drm_dev_put(), either still called from
> pci_driver.remove() if all device file descriptors are already closed,
> or on last drm_release() file operation.
> 
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> ---
> Changelog:
> v1 -> v2:
> - defer intel_engines_cleanup() as well. (Chris)

Just an aside, we generally keep the changelog in the commit message on
dri-devel, it's occasionally useful to reference in the future. Yes that's
different from some other areas of the kernel.
-Daniel

> 
>  drivers/gpu/drm/i915/i915_drv.c | 17 +++++++++++++----
>  drivers/gpu/drm/i915/i915_drv.h |  1 +
>  drivers/gpu/drm/i915/i915_gem.c | 10 +++++++++-
>  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 83d2eb9e74cb..8be69f84eb6d 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -738,6 +738,7 @@ static int i915_load_modeset_init(struct drm_device *dev)
>  
>  cleanup_gem:
>  	i915_gem_suspend(dev_priv);
> +	i915_gem_fini_hw(dev_priv);
>  	i915_gem_fini(dev_priv);
>  cleanup_modeset:
>  	intel_modeset_cleanup(dev);
> @@ -1685,7 +1686,6 @@ static void i915_driver_cleanup_hw(struct drm_i915_private *dev_priv)
>  		pci_disable_msi(pdev);
>  
>  	pm_qos_remove_request(&dev_priv->pm_qos);
> -	i915_ggtt_cleanup_hw(dev_priv);
>  }
>  
>  /**
> @@ -1909,6 +1909,7 @@ int i915_driver_load(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  out_cleanup_hw:
>  	i915_driver_cleanup_hw(dev_priv);
> +	i915_ggtt_cleanup_hw(dev_priv);
>  out_cleanup_mmio:
>  	i915_driver_cleanup_mmio(dev_priv);
>  out_runtime_pm_put:
> @@ -1960,21 +1961,29 @@ void i915_driver_unload(struct drm_device *dev)
>  	cancel_delayed_work_sync(&dev_priv->gpu_error.hangcheck_work);
>  	i915_reset_error_state(dev_priv);
>  
> -	i915_gem_fini(dev_priv);
> +	i915_gem_fini_hw(dev_priv);
>  
>  	intel_power_domains_fini_hw(dev_priv);
>  
>  	i915_driver_cleanup_hw(dev_priv);
> -	i915_driver_cleanup_mmio(dev_priv);
>  
>  	enable_rpm_wakeref_asserts(dev_priv);
> -	intel_runtime_pm_cleanup(dev_priv);
>  }
>  
>  static void i915_driver_release(struct drm_device *dev)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(dev);
>  
> +	disable_rpm_wakeref_asserts(dev_priv);
> +
> +	i915_gem_fini(dev_priv);
> +
> +	i915_ggtt_cleanup_hw(dev_priv);
> +	i915_driver_cleanup_mmio(dev_priv);
> +
> +	enable_rpm_wakeref_asserts(dev_priv);
> +	intel_runtime_pm_cleanup(dev_priv);
> +
>  	i915_driver_cleanup_early(dev_priv);
>  	i915_driver_destroy(dev_priv);
>  }
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index a2664ea1395b..d08e7bd83544 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -3047,6 +3047,7 @@ void i915_gem_init_mmio(struct drm_i915_private *i915);
>  int __must_check i915_gem_init(struct drm_i915_private *dev_priv);
>  int __must_check i915_gem_init_hw(struct drm_i915_private *dev_priv);
>  void i915_gem_init_swizzling(struct drm_i915_private *dev_priv);
> +void i915_gem_fini_hw(struct drm_i915_private *dev_priv);
>  void i915_gem_fini(struct drm_i915_private *dev_priv);
>  int i915_gem_wait_for_idle(struct drm_i915_private *dev_priv,
>  			   unsigned int flags, long timeout);
> diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
> index 7cafd5612f71..20d3f7532cef 100644
> --- a/drivers/gpu/drm/i915/i915_gem.c
> +++ b/drivers/gpu/drm/i915/i915_gem.c
> @@ -4667,7 +4667,7 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
>  	return ret;
>  }
>  
> -void i915_gem_fini(struct drm_i915_private *dev_priv)
> +void i915_gem_fini_hw(struct drm_i915_private *dev_priv)
>  {
>  	GEM_BUG_ON(dev_priv->gt.awake);
>  
> @@ -4680,6 +4680,14 @@ void i915_gem_fini(struct drm_i915_private *dev_priv)
>  	mutex_lock(&dev_priv->drm.struct_mutex);
>  	intel_uc_fini_hw(dev_priv);
>  	intel_uc_fini(dev_priv);
> +	mutex_unlock(&dev_priv->drm.struct_mutex);
> +
> +	i915_gem_drain_freed_objects(dev_priv);
> +}
> +
> +void i915_gem_fini(struct drm_i915_private *dev_priv)
> +{
> +	mutex_lock(&dev_priv->drm.struct_mutex);
>  	intel_engines_cleanup(dev_priv);
>  	i915_gem_contexts_fini(dev_priv);
>  	i915_gem_fini_scratch(dev_priv);
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
