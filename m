Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2DBC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911B32063F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="afRoLu+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbfFMPwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:52:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33100 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbfFMJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:08:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so2148293edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oGEIi8ZbA4ElBKoNoWg8Zqmm+0W4iEZ9Wl2E4vqqzu4=;
        b=afRoLu+5c04elHJ9uSoU2wVJnLiY9rPJ9vYsrVBioEbs51ckV/BunuGGpEgJFvzl0l
         I1R/fsNKud2MVuDRx41d91f6KvBM1srcUoi9bm980sFG3jlIS6+Yl9Iz3IW2NPNrv+dJ
         GarwtuEbHx4dlM9c/5rvuXuCEdW7ReVjVeu8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oGEIi8ZbA4ElBKoNoWg8Zqmm+0W4iEZ9Wl2E4vqqzu4=;
        b=uand4xJSYhEgL1t5M6jU3Kha0diRRTgSlfOKMu+Mv/4vvgMdGjaG2y4OpWzYThoYYz
         P40glqhqYmAggmnUL74YEa4JzQHrsMlnbdHGvqazc1U9Lj7IgwkQO1tK8O4yLCrg1ndz
         30BUcTkjaJe0c4bptm/p6az6ORPZaVntWhR6R1ILBtqTR6Vwjf+1cTA0ddt6VSQanGg6
         a4hQUPyPjbeHyUKT73yLwNN/fz+NZVh66/zkFcqV19HPw/iDR4oK8JncXQMIR6wq56Fv
         hrbLDYAdhRT+LwfojBaQNW8Rz+QZCXtJkYm+1zVXaS4O+uoaO02Jg5c+/Knh+dwdi6D0
         BJYg==
X-Gm-Message-State: APjAAAVt0uuOpLbhuJ08hmsta7f59rlAXHgf3gOU1hybCH8fYUywxRCM
        aYZ3z3F02WjrrGLtYFm5GvcFvA==
X-Google-Smtp-Source: APXvYqydkA6pzT/U0/NpSQ7oV3DnmdRZaVFlX0FJYEsGCpXnNScbZQ+PXN4JLY8tF6ss3+ZxAaGP9g==
X-Received: by 2002:a50:aa7c:: with SMTP id p57mr44549776edc.179.1560416898007;
        Thu, 13 Jun 2019 02:08:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w7sm436487ejn.92.2019.06.13.02.08.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 02:08:16 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:08:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 2/2] drm/komeda: Adds komeda_kms_drop_master
Message-ID: <20190613090814.GJ23020@phenom.ffwll.local>
Mail-Followup-To: Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
References: <1560251589-31827-1-git-send-email-lowry.li@arm.com>
 <1560251589-31827-3-git-send-email-lowry.li@arm.com>
 <20190611123038.GC2458@phenom.ffwll.local>
 <20190612022617.GA8595@james-ThinkStation-P300>
 <20190613081727.GE23020@phenom.ffwll.local>
 <20190613082813.GM4173@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613082813.GM4173@e110455-lin.cambridge.arm.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 09:28:13AM +0100, Liviu Dudau wrote:
> On Thu, Jun 13, 2019 at 10:17:27AM +0200, Daniel Vetter wrote:
> > On Wed, Jun 12, 2019 at 02:26:24AM +0000, james qian wang (Arm Technology China) wrote:
> > > On Tue, Jun 11, 2019 at 02:30:38PM +0200, Daniel Vetter wrote:
> > > > On Tue, Jun 11, 2019 at 11:13:45AM +0000, Lowry Li (Arm Technology China) wrote:
> > > > > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> > > > >
> > > > > The komeda internal resources (pipelines) are shared between crtcs,
> > > > > and resources release by disable_crtc. This commit is working for once
> > > > > user forgot disabling crtc like app quit abnomally, and then the
> > > > > resources can not be used by another crtc. Adds drop_master to
> > > > > shutdown the device and make sure all the komeda resources have been
> > > > > released and can be used for the next usage.
> > > > >
> > > > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 13 +++++++++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > > index 8543860..647bce5 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > > @@ -54,11 +54,24 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
> > > > >  return status;
> > > > >  }
> > > > >
> > > > > +/* Komeda internal resources (pipelines) are shared between crtcs, and resources
> > > > > + * are released by disable_crtc. But if user forget disabling crtc like app quit
> > > > > + * abnormally, the resources can not be used by another crtc.
> > > > > + * Use drop_master to shutdown the device and make sure all the komeda resources
> > > > > + * have been released, and can be used for the next usage.
> > > > > + */
> > > >
> > > > No. If we want this, we need to implement this across drivers, not with
> > > > per-vendor hacks.
> > > >
> > > > The kerneldoc should have been a solid hint: "Only used by vmwgfx."
> > > > -Daniel
> > > 
> > > Hi Daniel:
> > > This drop_master is really what we want, can we update the doc and
> > > add komeda as a user of this hacks like "used by vmwfgx and komeda",
> > > or maybe directly promote this per-vendor hacks as an optional chip
> > > function ?
> > 
> > Still no, because it would mean different behaviour for arm/komeda
> > compared to everyone else. And we really don't want this, because this
> > would completely break flicker-less vt-switching.
> > 
> > Currently the only fallback for this case is the lastclose handler, which
> > atm just restores fbcon/fbdev. If you want to change/extend that to work
> > without fbdev, then that's the place to do the change. And across _all_
> > drm kms drivers, so that we have consistent behaviour.
> 
> Slightly unrelated, just thinking of a solution and wanted confirmation/double
> checking: can a CRTC be instantiated without any planes (or without a primary
> plane)?

Without a primary plane maybe not so recommended, because it would break
all the legacy userspace. Might even result in some oopses, not sure we
check for crtc->primary != NULL.

I'm not sure what you mean about instantiating it without any plane at
all. That would be rather useless.
-Daniel

> 
> Best regards,
> Liviu
> 
> > 
> > kms is a cross-vendor api, vendor hacks are very, very much not cool.
> > -Daniel
> > 
> > > 
> > > James
> > > 
> > > > > +static void komeda_kms_drop_master(struct drm_device *dev,
> > > > > +   struct drm_file *file_priv)
> > > > > +{
> > > > > +drm_atomic_helper_shutdown(dev);
> > > > > +}
> > > > > +
> > > > >  static struct drm_driver komeda_kms_driver = {
> > > > >  .driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
> > > > >     DRIVER_PRIME | DRIVER_HAVE_IRQ,
> > > > >  .lastclose= drm_fb_helper_lastclose,
> > > > >  .irq_handler= komeda_kms_irq_handler,
> > > > > +.master_drop= komeda_kms_drop_master,
> > > > >  .gem_free_object_unlocked= drm_gem_cma_free_object,
> > > > >  .gem_vm_ops= &drm_gem_cma_vm_ops,
> > > > >  .dumb_create= komeda_gem_cma_dumb_create,
> > > > > --
> > > > > 1.9.1
> > > > >
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > > IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
