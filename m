Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A89C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBEA217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfDEIZH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:25:07 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:58208 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730392AbfDEIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:25:06 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16140366-1500050 
        for multiple; Fri, 05 Apr 2019 09:24:51 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <51c51c4d1a2facbc1dfb240b94377027e263872e.camel@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        michal.wajdeczko@intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20190405072657.9997-1-janusz.krzysztofik@linux.intel.com>
 <155445007634.8259.18397004914881394541@skylake-alporthouse-com>
 <51c51c4d1a2facbc1dfb240b94377027e263872e.camel@linux.intel.com>
Message-ID: <155445268803.8259.16095445514284244974@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Use drm_dev_unplug()
Date:   Fri, 05 Apr 2019 09:24:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-04-05 09:11:54)
> On Fri, 2019-04-05 at 08:41 +0100, Chris Wilson wrote:
> > Quoting Janusz Krzysztofik (2019-04-05 08:26:57)
> > > From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > > 
> > > The driver does not currently support unbinding from a device which
> > > is
> > > in use.  Since open file descriptors may still be pointing into
> > > kernel
> > > memory where the device structures used to be, entirely correct
> > > kernel
> > > panics protect the driver from being unbound as we should not be
> > > unbinding it before those dangling pointers have been made safe.
> > > 
> > > According to the documentation found inside
> > > drivers/gpu/drm/drm_drv.c,
> > > drm_dev_unplug() should be used instead of drm_dev_unregister() in
> > > order to make a device inaccessible to users as soon as it is
> > > unpluged.
> > > Follow that advice to make those possibly dangling pointers safe,
> > > protected by DRM layer from a user who is otherwise left pointing
> > > into
> > > possibly reused kernel memory after the driver has been unbound
> > > from
> > > the device.
> > > 
> > > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_drv.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_drv.c
> > > b/drivers/gpu/drm/i915/i915_drv.c
> > > index 9df65d386d11..66163378c481 100644
> > > --- a/drivers/gpu/drm/i915/i915_drv.c
> > > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > > @@ -1596,7 +1596,7 @@ static void i915_driver_unregister(struct
> > > drm_i915_private *dev_priv)
> > >         i915_pmu_unregister(dev_priv);
> > >  
> > >         i915_teardown_sysfs(dev_priv);
> > > -       drm_dev_unregister(&dev_priv->drm);
> > > +       drm_dev_unplug(&dev_priv->drm);
> > 
> > I think we may have our onion inverted here. We want to stop the
> > users
> > as the first step, then start removing the entries. (That will also
> > nicely invert the order from register, which is what we typically
> > expect).
> > 
> > After calling i915_driver_unregister(); call i915_gem_set_wedged() to
> > immediately (give or take external fences) cancel inflight
> > operations.
> 
> OK, thanks.  Do you prefer them squashed or as serparate patches?

Quite happy to do the s/unregister/unplug/ and move in one go. Have a
pre-emptive
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
on that as that seems to be the right thing to do.

And there should be no issues in placing a i915_gem_set_wedged()
immediately after the call to i915_driver_unregister, so if you include
a line of commentary about why, for example

/*
 * After unregistering the device to prevent any new users, cancel
 * all in-flight requests so that we can quickly unbind the active
 * resources.
 */
i915_gem_set_wedged(dev_priv);

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

I think overall though, we need to go through i915_driver_unload() and
push the module cleanup operations to i915_driver_release -- that will
take a bit of surgery to separate the different phases that are
currently smashed together.
-Chris
