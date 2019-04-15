Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F8520848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zk/+2s7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDOJ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:29:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36288 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfDOJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:29:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id u57so13410926edm.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jMxz7hHKfuHRoflFdmAJmTInyev5A5dOaMV+8dmSbgk=;
        b=Zk/+2s7TWKZJRvN/e7qUqG6iAl0u9JtiPb3sanIUWBTNY775JTRoBF6xJ+b9CsMGki
         xLYVKFOjYRQgOQJVx9gvmxNyiEHdSHS346nQpY//CW8Y6BR+4Ns0BxO7zaut2R5Plf6v
         IQILhg+b+zwPnBy3XF8F9a7D/V3hxq2ly+LAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jMxz7hHKfuHRoflFdmAJmTInyev5A5dOaMV+8dmSbgk=;
        b=YdEW8yhypayk1Xf8JfXrIUZUpCPf5mRBbuSrqowMTfYc0ViXyRe/nIXwQk2BXAUB2p
         Wg5jAWrOp9DOUQzIRo+CnOZIrap2UPBmqMYFfts085/q7FYi2xsUkiw1As0cFxl8gSbb
         Qm1n6gYWxygC4Sqhm8GAibmkgqVXB7Go/Ms3PDoB9oWXtwvKVuyyDKlxZpRHD9RmmxWx
         D+KeoksSWXgdqWZeHYrox/CDuyoKXXvu7ioc0WhtrJ/LkR0BNtLHR2AuQKEfDg5DUS7A
         cxhh1+sW1UfR24MhKDDscrvwHvn+p6XnzdOMVxYJvh3N/MR6fwLvbjRVcdQyeJwKRDGD
         i/lg==
X-Gm-Message-State: APjAAAXBMr743HC2vazwzI83p2VQBPOpKrSy2ln1/AUletoDCEBV1GXd
        U5iBuB98g346GBOmWELxQdtMkQ==
X-Google-Smtp-Source: APXvYqyzgD3aKdlkr4ZLMAov5HvYxAciXj1muLxZOJSgGK7iSfzJnlF7Z2e2GcqoFQzrWTasLFal/Q==
X-Received: by 2002:a50:9179:: with SMTP id f54mr45567670eda.207.1555320569959;
        Mon, 15 Apr 2019 02:29:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n2sm3202707edr.41.2019.04.15.02.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 02:29:29 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:29:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, michal.wajdeczko@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
Subject: Re: [PATCH] drm/i915: Use drm_dev_unplug()
Message-ID: <20190415092926.GW2665@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, michal.wajdeczko@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
References: <20190405072657.9997-1-janusz.krzysztofik@linux.intel.com>
 <155445007634.8259.18397004914881394541@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155445007634.8259.18397004914881394541@skylake-alporthouse-com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 08:41:16AM +0100, Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-04-05 08:26:57)
> > From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > 
> > The driver does not currently support unbinding from a device which is
> > in use.  Since open file descriptors may still be pointing into kernel
> > memory where the device structures used to be, entirely correct kernel
> > panics protect the driver from being unbound as we should not be
> > unbinding it before those dangling pointers have been made safe.
> > 
> > According to the documentation found inside drivers/gpu/drm/drm_drv.c,
> > drm_dev_unplug() should be used instead of drm_dev_unregister() in
> > order to make a device inaccessible to users as soon as it is unpluged.
> > Follow that advice to make those possibly dangling pointers safe,
> > protected by DRM layer from a user who is otherwise left pointing into
> > possibly reused kernel memory after the driver has been unbound from
> > the device.
> > 
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> > ---
> >  drivers/gpu/drm/i915/i915_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> > index 9df65d386d11..66163378c481 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.c
> > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > @@ -1596,7 +1596,7 @@ static void i915_driver_unregister(struct drm_i915_private *dev_priv)
> >         i915_pmu_unregister(dev_priv);
> >  
> >         i915_teardown_sysfs(dev_priv);
> > -       drm_dev_unregister(&dev_priv->drm);
> > +       drm_dev_unplug(&dev_priv->drm);
> 
> I think we may have our onion inverted here. We want to stop the users
> as the first step, then start removing the entries. (That will also
> nicely invert the order from register, which is what we typically
> expect).
> 
> After calling i915_driver_unregister(); call i915_gem_set_wedged() to
> immediately (give or take external fences) cancel inflight operations.

I think we still need the above patch, since drm_dev_unplug ==
drm_dev_unregister + "make sure userspace can't get at us anymore". We
could/should probably drop drm_dev_unplug and move that additional code to
drm_dev_unregister, but there's some minutea in how we refcount the
drm_device between the two. So not quite as clean a job.

There's also drm_put_dev (not to be mistaken with drm_dev_put), for added
confusion. I think ideally we'd unify all three of drm_dev_unregister,
drm_dev_unplug and drm_put_dev to one, deprecating all the others. But
that's work :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
