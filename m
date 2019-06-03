Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A3EC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF16D25D06
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c3r2VBDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfFCH2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:28:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43288 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfFCH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:28:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so25476874edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OBEcUSBuSXIEvv5YvVgrfg8sH2Ivurz6vfRZ/RbnW8s=;
        b=c3r2VBDOcjk/IaoS1iEhdnBHs0a2Os6YL6UFYKEI8rzefd59imwg2qAw7zk4Xx1a4y
         wXrbqPurvCbQaQIeDSV4qLR69dILNEj5dgavlAWWYSiH+jfoSh4kCg2CP7IhOVtfIhvB
         2mKh2BMDOiYB8g3NYojM92OqHDEvev8cNy7MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=OBEcUSBuSXIEvv5YvVgrfg8sH2Ivurz6vfRZ/RbnW8s=;
        b=KQYM7KKR+L6KNcKUi5jCQAJvsSEXpRzoOnfo4AAWDruK6YkMsEwTv5rueFfjF6Ccsz
         kAhsT3HfXdaNT2DlZVyf6/iX+MDBnnFw57zB0W/P9A7Rdn+Wka89tVPkAnQRhLektPkV
         KW4iOuITsTILRyWesrZV14k1ItjrTAMrTMCTmxmD9s194k9VA14s6WEuOI5mUjIeDuGh
         t24cBlJZfJ48zMJuIxzheHb0by0Uf4Qg4W14PxsJjKEA+iMUBG22GJW2aIc+tekxBHpF
         oqCWq5jIzvO4s96gFKKOHfKAKGy4WcWwmAr8uRUqT9Vfx0vQmi3tRqDD7TE0T/dhly3y
         r4vQ==
X-Gm-Message-State: APjAAAW5ju+rskzL2lHxRvEL6sickaIiMLWTux6RNaGKXhqeVI/Y/KjL
        +QgZqA5qAtQZ37yZf4RyMN59ow==
X-Google-Smtp-Source: APXvYqyBPSX29cqPOPt/QB2oz4hi1/Nm9Tvnhc9MJe4Rav1TBrusDemBkpOE68SXQcXSqWTuAHxgRQ==
X-Received: by 2002:a17:906:f0d7:: with SMTP id dk23mr1922389ejb.232.1559546901731;
        Mon, 03 Jun 2019 00:28:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i13sm3756347edq.58.2019.06.03.00.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 00:28:21 -0700 (PDT)
Date:   Mon, 3 Jun 2019 09:28:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] drm/i915: Split off pci_driver.remove() tail to
 drm_driver.release()
Message-ID: <20190603072818.GA21222@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190530092426.23880-1-janusz.krzysztofik@linux.intel.com>
 <20190530092426.23880-2-janusz.krzysztofik@linux.intel.com>
 <155920920944.2224.169121808439828849@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155920920944.2224.169121808439828849@skylake-alporthouse-com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:40:09AM +0100, Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-05-30 10:24:26)
> > In order to support driver hot unbind, some cleanup operations, now
> > performed on PCI driver remove, must be called later, after all device
> > file descriptors are closed.
> > 
> > Split out those operations from the tail of pci_driver.remove()
> > callback and put them into drm_driver.release() which is called as soon
> > as all references to the driver are put.  As a result, those cleanups
> > will be now run on last drm_dev_put(), either still called from
> > pci_driver.remove() if all device file descriptors are already closed,
> > or on last drm_release() file operation.
> > 
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/i915_drv.c | 17 +++++++++++++----
> >  drivers/gpu/drm/i915/i915_drv.h |  1 +
> >  drivers/gpu/drm/i915/i915_gem.c | 10 +++++++++-
> >  3 files changed, 23 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> > index 83d2eb9e74cb..8be69f84eb6d 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.c
> > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > @@ -738,6 +738,7 @@ static int i915_load_modeset_init(struct drm_device *dev)
> >  
> >  cleanup_gem:
> >         i915_gem_suspend(dev_priv);
> > +       i915_gem_fini_hw(dev_priv);
> >         i915_gem_fini(dev_priv);
> >  cleanup_modeset:
> >         intel_modeset_cleanup(dev);
> > @@ -1685,7 +1686,6 @@ static void i915_driver_cleanup_hw(struct drm_i915_private *dev_priv)
> >                 pci_disable_msi(pdev);
> >  
> >         pm_qos_remove_request(&dev_priv->pm_qos);
> > -       i915_ggtt_cleanup_hw(dev_priv);
> >  }
> >  
> >  /**
> > @@ -1909,6 +1909,7 @@ int i915_driver_load(struct pci_dev *pdev, const struct pci_device_id *ent)
> 
> Would it make sense to rename load/unload from the legacy drm stubs over
> to match the pci entry points?

+1 on that rename, load/unload is really terribly confusing and has
horrible semantics in the dri1 shadow attach world ...
-Daniel

> 
> >  out_cleanup_hw:
> >         i915_driver_cleanup_hw(dev_priv);
> > +       i915_ggtt_cleanup_hw(dev_priv);
> >  out_cleanup_mmio:
> >         i915_driver_cleanup_mmio(dev_priv);
> >  out_runtime_pm_put:
> > @@ -1960,21 +1961,29 @@ void i915_driver_unload(struct drm_device *dev)
> >         cancel_delayed_work_sync(&dev_priv->gpu_error.hangcheck_work);
> >         i915_reset_error_state(dev_priv);
> >  
> > -       i915_gem_fini(dev_priv);
> > +       i915_gem_fini_hw(dev_priv);
> >  
> >         intel_power_domains_fini_hw(dev_priv);
> >  
> >         i915_driver_cleanup_hw(dev_priv);
> > -       i915_driver_cleanup_mmio(dev_priv);
> >  
> >         enable_rpm_wakeref_asserts(dev_priv);
> > -       intel_runtime_pm_cleanup(dev_priv);
> >  }
> >  
> >  static void i915_driver_release(struct drm_device *dev)
> >  {
> >         struct drm_i915_private *dev_priv = to_i915(dev);
> >  
> > +       disable_rpm_wakeref_asserts(dev_priv);
> > +
> > +       i915_gem_fini(dev_priv);
> > +
> > +       i915_ggtt_cleanup_hw(dev_priv);
> > +       i915_driver_cleanup_mmio(dev_priv);
> > +
> > +       enable_rpm_wakeref_asserts(dev_priv);
> > +       intel_runtime_pm_cleanup(dev_priv);
> 
> We should really propagate the release nomenclature down and replace our
> mixed fini/cleanup. Consistency is helpful when trying to work out which
> phase the code is in.
> 
> >         i915_driver_cleanup_early(dev_priv);
> >         i915_driver_destroy(dev_priv);
> >  }
> > diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> > index a2664ea1395b..d08e7bd83544 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.h
> > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > @@ -3047,6 +3047,7 @@ void i915_gem_init_mmio(struct drm_i915_private *i915);
> >  int __must_check i915_gem_init(struct drm_i915_private *dev_priv);
> >  int __must_check i915_gem_init_hw(struct drm_i915_private *dev_priv);
> >  void i915_gem_init_swizzling(struct drm_i915_private *dev_priv);
> > +void i915_gem_fini_hw(struct drm_i915_private *dev_priv);
> >  void i915_gem_fini(struct drm_i915_private *dev_priv);
> >  int i915_gem_wait_for_idle(struct drm_i915_private *dev_priv,
> >                            unsigned int flags, long timeout);
> > diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
> > index 7cafd5612f71..c6a8e665a6ba 100644
> > --- a/drivers/gpu/drm/i915/i915_gem.c
> > +++ b/drivers/gpu/drm/i915/i915_gem.c
> > @@ -4667,7 +4667,7 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
> >         return ret;
> >  }
> >  
> > -void i915_gem_fini(struct drm_i915_private *dev_priv)
> > +void i915_gem_fini_hw(struct drm_i915_private *dev_priv)
> >  {
> >         GEM_BUG_ON(dev_priv->gt.awake);
> >  
> > @@ -4681,6 +4681,14 @@ void i915_gem_fini(struct drm_i915_private *dev_priv)
> >         intel_uc_fini_hw(dev_priv);
> >         intel_uc_fini(dev_priv);
> 
> >         intel_engines_cleanup(dev_priv);
> 
> intel_engines_cleanup -> i915_gem_fini -- that is in principle just
> freeing structs. One side effect it does have is to make all engines
> unavailable (but it doesn't update the engine_mask so the inconsistency
> might catch us out if it is not one of the last cleanup actions).
> 
> intel_uc_fini() is a bit of a mixed bag. It looks like it flushes
> runtime state, so preferrably that flush should be moved to the 
> _fini_hw so that _fini is pure cleanup. So for the time being, best to
> leave intel_uc_fini() here.
> 
> > +       mutex_unlock(&dev_priv->drm.struct_mutex);
> > +
> > +       i915_gem_drain_freed_objects(dev_priv);
> > +}
> > +
> > +void i915_gem_fini(struct drm_i915_private *dev_priv)
> > +{
> > +       mutex_lock(&dev_priv->drm.struct_mutex);
> >         i915_gem_contexts_fini(dev_priv);
> >         i915_gem_fini_scratch(dev_priv);
> >         mutex_unlock(&dev_priv->drm.struct_mutex);
> 
> That split looks sensible to me, with the consideration as to whether
> defer intel_engines_cleanup() as well,
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> -Chris

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
