Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A10C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0025221871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfDELis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:38:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:50163 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730642AbfDELis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:38:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 04:38:47 -0700
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; 
   d="scan'208";a="131720024"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2019 04:38:45 -0700
Message-ID: <f5b2d3d661c9a19b4e354ed525c054af467de557.camel@linux.intel.com>
Subject: Re: [PATCH] drm/i915: Use drm_dev_unplug()
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        michal.wajdeczko@intel.com
Date:   Fri, 05 Apr 2019 13:38:43 +0200
In-Reply-To: <155445268803.8259.16095445514284244974@skylake-alporthouse-com>
References: <20190405072657.9997-1-janusz.krzysztofik@linux.intel.com>
         <155445007634.8259.18397004914881394541@skylake-alporthouse-com>
         <51c51c4d1a2facbc1dfb240b94377027e263872e.camel@linux.intel.com>
         <155445268803.8259.16095445514284244974@skylake-alporthouse-com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-05 at 09:24 +0100, Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-04-05 09:11:54)
> > On Fri, 2019-04-05 at 08:41 +0100, Chris Wilson wrote:
> > > Quoting Janusz Krzysztofik (2019-04-05 08:26:57)
> > > > From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > > > 
> > > > The driver does not currently support unbinding from a device
> > > > which
> > > > is
> > > > in use.  Since open file descriptors may still be pointing into
> > > > kernel
> > > > memory where the device structures used to be, entirely correct
> > > > kernel
> > > > panics protect the driver from being unbound as we should not
> > > > be
> > > > unbinding it before those dangling pointers have been made
> > > > safe.
> > > > 
> > > > According to the documentation found inside
> > > > drivers/gpu/drm/drm_drv.c,
> > > > drm_dev_unplug() should be used instead of drm_dev_unregister()
> > > > in
> > > > order to make a device inaccessible to users as soon as it is
> > > > unpluged.
> > > > Follow that advice to make those possibly dangling pointers
> > > > safe,
> > > > protected by DRM layer from a user who is otherwise left
> > > > pointing
> > > > into
> > > > possibly reused kernel memory after the driver has been unbound
> > > > from
> > > > the device.
> > > > 
> > > > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com
> > > > >
> > > > ---
> > > >  drivers/gpu/drm/i915/i915_drv.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/i915/i915_drv.c
> > > > b/drivers/gpu/drm/i915/i915_drv.c
> > > > index 9df65d386d11..66163378c481 100644
> > > > --- a/drivers/gpu/drm/i915/i915_drv.c
> > > > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > > > @@ -1596,7 +1596,7 @@ static void i915_driver_unregister(struct
> > > > drm_i915_private *dev_priv)
> > > >         i915_pmu_unregister(dev_priv);
> > > >  
> > > >         i915_teardown_sysfs(dev_priv);
> > > > -       drm_dev_unregister(&dev_priv->drm);
> > > > +       drm_dev_unplug(&dev_priv->drm);
> > > 
> > > I think we may have our onion inverted here. We want to stop the
> > > users
> > > as the first step, then start removing the entries. (That will
> > > also
> > > nicely invert the order from register, which is what we typically
> > > expect).
> > > 
> > > After calling i915_driver_unregister(); call
> > > i915_gem_set_wedged() to
> > > immediately (give or take external fences) cancel inflight
> > > operations.
> > 
> > OK, thanks.  Do you prefer them squashed or as serparate patches?
> 
> Quite happy to do the s/unregister/unplug/ and move in one go. Have a
> pre-emptive
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> on that as that seems to be the right thing to do.
> 
> And there should be no issues in placing a i915_gem_set_wedged()
> immediately after the call to i915_driver_unregister, so if you
> include
> a line of commentary about why, for example
> 
> /*
>  * After unregistering the device to prevent any new users, cancel
>  * all in-flight requests so that we can quickly unbind the active
>  * resources.
>  */
> i915_gem_set_wedged(dev_priv);
> 
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

I've given it some testing, no side effects with test workloads I've
tried, and looks like it at least helps to prevent from making the
device actually wedged.

With these two patches, plus the one we discussed yesterday, and yet
another one I'm going to submit soon, I'm now able to unbind the driver
from a device while a workload is running on it, unload the module,
reload it and successfully perform basic GEM health checks, all in a
quick succession :-).

Unfortunately, not 100% reproducible, as well as not the case with
device unplug simulated by writing 1 to device/remove sysfs file.
Surely that needs the work you describe below to be done first.

Thanks for your cooperation,
Janusz


> 
> I think overall though, we need to go through i915_driver_unload()
> and
> push the module cleanup operations to i915_driver_release -- that
> will
> take a bit of surgery to separate the different phases that are
> currently smashed together.
> -Chris
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

