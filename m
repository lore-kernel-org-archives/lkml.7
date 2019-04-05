Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A07C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDAD217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfDEHlc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:41:32 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52974 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729142AbfDEHlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:41:32 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16139798-1500050 
        for multiple; Fri, 05 Apr 2019 08:41:19 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190405072657.9997-1-janusz.krzysztofik@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
References: <20190405072657.9997-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <155445007634.8259.18397004914881394541@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Use drm_dev_unplug()
Date:   Fri, 05 Apr 2019 08:41:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-04-05 08:26:57)
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
> the device.
> 
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 9df65d386d11..66163378c481 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -1596,7 +1596,7 @@ static void i915_driver_unregister(struct drm_i915_private *dev_priv)
>         i915_pmu_unregister(dev_priv);
>  
>         i915_teardown_sysfs(dev_priv);
> -       drm_dev_unregister(&dev_priv->drm);
> +       drm_dev_unplug(&dev_priv->drm);

I think we may have our onion inverted here. We want to stop the users
as the first step, then start removing the entries. (That will also
nicely invert the order from register, which is what we typically
expect).

After calling i915_driver_unregister(); call i915_gem_set_wedged() to
immediately (give or take external fences) cancel inflight operations.
-Chris
