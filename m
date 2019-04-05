Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C1C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9745721850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfDEIMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:12:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:62751 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEIL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:11:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 01:11:59 -0700
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; 
   d="scan'208";a="133178609"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2019 01:11:56 -0700
Message-ID: <51c51c4d1a2facbc1dfb240b94377027e263872e.camel@linux.intel.com>
Subject: Re: [PATCH] drm/i915: Use drm_dev_unplug()
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        michal.wajdeczko@intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Fri, 05 Apr 2019 10:11:54 +0200
In-Reply-To: <155445007634.8259.18397004914881394541@skylake-alporthouse-com>
References: <20190405072657.9997-1-janusz.krzysztofik@linux.intel.com>
         <155445007634.8259.18397004914881394541@skylake-alporthouse-com>
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

On Fri, 2019-04-05 at 08:41 +0100, Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-04-05 08:26:57)
> > From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > 
> > The driver does not currently support unbinding from a device which
> > is
> > in use.  Since open file descriptors may still be pointing into
> > kernel
> > memory where the device structures used to be, entirely correct
> > kernel
> > panics protect the driver from being unbound as we should not be
> > unbinding it before those dangling pointers have been made safe.
> > 
> > According to the documentation found inside
> > drivers/gpu/drm/drm_drv.c,
> > drm_dev_unplug() should be used instead of drm_dev_unregister() in
> > order to make a device inaccessible to users as soon as it is
> > unpluged.
> > Follow that advice to make those possibly dangling pointers safe,
> > protected by DRM layer from a user who is otherwise left pointing
> > into
> > possibly reused kernel memory after the driver has been unbound
> > from
> > the device.
> > 
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > ---
> >  drivers/gpu/drm/i915/i915_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_drv.c
> > b/drivers/gpu/drm/i915/i915_drv.c
> > index 9df65d386d11..66163378c481 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.c
> > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > @@ -1596,7 +1596,7 @@ static void i915_driver_unregister(struct
> > drm_i915_private *dev_priv)
> >         i915_pmu_unregister(dev_priv);
> >  
> >         i915_teardown_sysfs(dev_priv);
> > -       drm_dev_unregister(&dev_priv->drm);
> > +       drm_dev_unplug(&dev_priv->drm);
> 
> I think we may have our onion inverted here. We want to stop the
> users
> as the first step, then start removing the entries. (That will also
> nicely invert the order from register, which is what we typically
> expect).
> 
> After calling i915_driver_unregister(); call i915_gem_set_wedged() to
> immediately (give or take external fences) cancel inflight
> operations.

OK, thanks.  Do you prefer them squashed or as serparate patches?

Thanks,
Janusz

> -Chris
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

