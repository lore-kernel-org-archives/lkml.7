Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1389C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754E227F11
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfFCKDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:03:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:53005 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfFCKDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:03:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 03:03:47 -0700
Received: from jkrzyszt-desk.ger.corp.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 03:03:45 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [RFC PATCH 1/1] drm/i915: Split off pci_driver.remove() tail to drm_driver.release()
Date:   Mon, 03 Jun 2019 12:03:39 +0200
Message-ID: <2282457.v6vtYRPrDg@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20190603072818.GA21222@phenom.ffwll.local>
References: <20190530092426.23880-1-janusz.krzysztofik@linux.intel.com> <155920920944.2224.169121808439828849@skylake-alporthouse-com> <20190603072818.GA21222@phenom.ffwll.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 3, 2019 9:28:18 AM CEST Daniel Vetter wrote:
> On Thu, May 30, 2019 at 10:40:09AM +0100, Chris Wilson wrote:
> > Quoting Janusz Krzysztofik (2019-05-30 10:24:26)
> > > In order to support driver hot unbind, some cleanup operations, now
> > > performed on PCI driver remove, must be called later, after all device
> > > file descriptors are closed.
> > > 
> > > Split out those operations from the tail of pci_driver.remove()
> > > callback and put them into drm_driver.release() which is called as soon
> > > as all references to the driver are put.  As a result, those cleanups
> > > will be now run on last drm_dev_put(), either still called from
> > > pci_driver.remove() if all device file descriptors are already closed,
> > > or on last drm_release() file operation.
> > > 
> > > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_drv.c | 17 +++++++++++++----
> > >  drivers/gpu/drm/i915/i915_drv.h |  1 +
> > >  drivers/gpu/drm/i915/i915_gem.c | 10 +++++++++-
> > >  3 files changed, 23 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/
i915_drv.c
> > > index 83d2eb9e74cb..8be69f84eb6d 100644
> > > --- a/drivers/gpu/drm/i915/i915_drv.c
> > > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > > @@ -738,6 +738,7 @@ static int i915_load_modeset_init(struct drm_device 
*dev)
> > >  
> > >  cleanup_gem:
> > >         i915_gem_suspend(dev_priv);
> > > +       i915_gem_fini_hw(dev_priv);
> > >         i915_gem_fini(dev_priv);
> > >  cleanup_modeset:
> > >         intel_modeset_cleanup(dev);
> > > @@ -1685,7 +1686,6 @@ static void i915_driver_cleanup_hw(struct 
drm_i915_private *dev_priv)
> > >                 pci_disable_msi(pdev);
> > >  
> > >         pm_qos_remove_request(&dev_priv->pm_qos);
> > > -       i915_ggtt_cleanup_hw(dev_priv);
> > >  }
> > >  
> > >  /**
> > > @@ -1909,6 +1909,7 @@ int i915_driver_load(struct pci_dev *pdev, const 
struct pci_device_id *ent)
> > 
> > Would it make sense to rename load/unload from the legacy drm stubs over
> > to match the pci entry points?
> 
> +1 on that rename, load/unload is really terribly confusing and has
> horrible semantics in the dri1 shadow attach world ...
> -Daniel

I've not responded to that comment, sorry, but I agree too.  I've assumed 
that's a candidate for a separate patch or series.  I'm willing to work on 
that as time permits.

Thanks,
Janusz

> > 
> > >  out_cleanup_hw:
> > >         i915_driver_cleanup_hw(dev_priv);
> > > +       i915_ggtt_cleanup_hw(dev_priv);
> > >  out_cleanup_mmio:
> > >         i915_driver_cleanup_mmio(dev_priv);
> > >  out_runtime_pm_put:
> > > @@ -1960,21 +1961,29 @@ void i915_driver_unload(struct drm_device *dev)
> > >         cancel_delayed_work_sync(&dev_priv->gpu_error.hangcheck_work);
> > >         i915_reset_error_state(dev_priv);
> > >  
> > > -       i915_gem_fini(dev_priv);
> > > +       i915_gem_fini_hw(dev_priv);
> > >  
> > >         intel_power_domains_fini_hw(dev_priv);
> > >  
> > >         i915_driver_cleanup_hw(dev_priv);
> > > -       i915_driver_cleanup_mmio(dev_priv);
> > >  
> > >         enable_rpm_wakeref_asserts(dev_priv);
> > > -       intel_runtime_pm_cleanup(dev_priv);
> > >  }
> > >  
> > >  static void i915_driver_release(struct drm_device *dev)
> > >  {
> > >         struct drm_i915_private *dev_priv = to_i915(dev);
> > >  
> > > +       disable_rpm_wakeref_asserts(dev_priv);
> > > +
> > > +       i915_gem_fini(dev_priv);
> > > +
> > > +       i915_ggtt_cleanup_hw(dev_priv);
> > > +       i915_driver_cleanup_mmio(dev_priv);
> > > +
> > > +       enable_rpm_wakeref_asserts(dev_priv);
> > > +       intel_runtime_pm_cleanup(dev_priv);
> > 
> > We should really propagate the release nomenclature down and replace our
> > mixed fini/cleanup. Consistency is helpful when trying to work out which
> > phase the code is in.
> > 
> > >         i915_driver_cleanup_early(dev_priv);
> > >         i915_driver_destroy(dev_priv);
> > >  }
> > > diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/
i915_drv.h
> > > index a2664ea1395b..d08e7bd83544 100644
> > > --- a/drivers/gpu/drm/i915/i915_drv.h
> > > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > > @@ -3047,6 +3047,7 @@ void i915_gem_init_mmio(struct drm_i915_private 
*i915);
> > >  int __must_check i915_gem_init(struct drm_i915_private *dev_priv);
> > >  int __must_check i915_gem_init_hw(struct drm_i915_private *dev_priv);
> > >  void i915_gem_init_swizzling(struct drm_i915_private *dev_priv);
> > > +void i915_gem_fini_hw(struct drm_i915_private *dev_priv);
> > >  void i915_gem_fini(struct drm_i915_private *dev_priv);
> > >  int i915_gem_wait_for_idle(struct drm_i915_private *dev_priv,
> > >                            unsigned int flags, long timeout);
> > > diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/
i915_gem.c
> > > index 7cafd5612f71..c6a8e665a6ba 100644
> > > --- a/drivers/gpu/drm/i915/i915_gem.c
> > > +++ b/drivers/gpu/drm/i915/i915_gem.c
> > > @@ -4667,7 +4667,7 @@ int i915_gem_init(struct drm_i915_private 
*dev_priv)
> > >         return ret;
> > >  }
> > >  
> > > -void i915_gem_fini(struct drm_i915_private *dev_priv)
> > > +void i915_gem_fini_hw(struct drm_i915_private *dev_priv)
> > >  {
> > >         GEM_BUG_ON(dev_priv->gt.awake);
> > >  
> > > @@ -4681,6 +4681,14 @@ void i915_gem_fini(struct drm_i915_private 
*dev_priv)
> > >         intel_uc_fini_hw(dev_priv);
> > >         intel_uc_fini(dev_priv);
> > 
> > >         intel_engines_cleanup(dev_priv);
> > 
> > intel_engines_cleanup -> i915_gem_fini -- that is in principle just
> > freeing structs. One side effect it does have is to make all engines
> > unavailable (but it doesn't update the engine_mask so the inconsistency
> > might catch us out if it is not one of the last cleanup actions).
> > 
> > intel_uc_fini() is a bit of a mixed bag. It looks like it flushes
> > runtime state, so preferrably that flush should be moved to the 
> > _fini_hw so that _fini is pure cleanup. So for the time being, best to
> > leave intel_uc_fini() here.
> > 
> > > +       mutex_unlock(&dev_priv->drm.struct_mutex);
> > > +
> > > +       i915_gem_drain_freed_objects(dev_priv);
> > > +}
> > > +
> > > +void i915_gem_fini(struct drm_i915_private *dev_priv)
> > > +{
> > > +       mutex_lock(&dev_priv->drm.struct_mutex);
> > >         i915_gem_contexts_fini(dev_priv);
> > >         i915_gem_fini_scratch(dev_priv);
> > >         mutex_unlock(&dev_priv->drm.struct_mutex);
> > 
> > That split looks sensible to me, with the consideration as to whether
> > defer intel_engines_cleanup() as well,
> > Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> > -Chris
> 
> 




