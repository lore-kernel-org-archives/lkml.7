Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA7C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B5E20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="X+b6N9AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392191AbfFMQcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:32:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33527 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbfFMIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:17:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so1947456edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BQUUVEbQBU82PrsMmM0DVRQxiyyQyaOoAc/ZkL7aGuo=;
        b=X+b6N9AQTQnv51mbGk3cs5WE9bgrZHoAhFo/kUpYWZ5C1X+XPaJBiRSZKXyXhgfLAB
         FquWhUU5SR0q1mI/n9p3wd5IYCOydO54EL5R4arx/NUINxsBTIzuZTrrx5APCrgoL6ng
         2M72ZA4ZKI9vl4v+mSrRECRt2QmkMtBH1G6Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BQUUVEbQBU82PrsMmM0DVRQxiyyQyaOoAc/ZkL7aGuo=;
        b=W5roHRgDMLEtNy77BYFKjbQhpLaTqaJORUTgAeEwTcIP/V7JwydrbdP62W7WJuwroX
         +zL6PK+KB6gOa8YfYy961w4fIpFx1tU9rSZVleCs3/O3D9KgPUhnpsCwPq2AzPoNluz1
         BZ2fpAHIpRqB0eTecGiSv2OHWP5OToK6ScArj29rO0q6p+0jKelgJ7tWqC2XOVkKprLy
         +Phi93nGCrwPK8Chx9zy0joBxgJDbgHR0xLlNAa6aqhWriOOy9F9Ov9bZVZRj835vixE
         D5kNTWIksTwWCGifdTeWP255Ri8tTzBPWsck/hP5kxkdRCrLtJaci9fEiqj03y7ClaWZ
         GxkA==
X-Gm-Message-State: APjAAAU4RxCm/CS6H/+VYNp6uKIn2FdB29fEpENLdp/7169dsWEYfx8E
        yqRubEuNthkDlfb/jscbXu3l3g==
X-Google-Smtp-Source: APXvYqzgj3ZvvCytyIQC8/KS9smhGXs83JUHZmiFa8ECETskNRubggCMXyfzSoJlw0thCAu3tcjhGg==
X-Received: by 2002:a17:906:610:: with SMTP id s16mr74446842ejb.108.1560413851058;
        Thu, 13 Jun 2019 01:17:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t54sm681937edd.17.2019.06.13.01.17.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 01:17:30 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:17:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
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
Message-ID: <20190613081727.GE23020@phenom.ffwll.local>
Mail-Followup-To: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612022617.GA8595@james-ThinkStation-P300>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 02:26:24AM +0000, james qian wang (Arm Technology China) wrote:
> On Tue, Jun 11, 2019 at 02:30:38PM +0200, Daniel Vetter wrote:
> > On Tue, Jun 11, 2019 at 11:13:45AM +0000, Lowry Li (Arm Technology China) wrote:
> > > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> > >
> > > The komeda internal resources (pipelines) are shared between crtcs,
> > > and resources release by disable_crtc. This commit is working for once
> > > user forgot disabling crtc like app quit abnomally, and then the
> > > resources can not be used by another crtc. Adds drop_master to
> > > shutdown the device and make sure all the komeda resources have been
> > > released and can be used for the next usage.
> > >
> > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > ---
> > >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > index 8543860..647bce5 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > @@ -54,11 +54,24 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
> > >  return status;
> > >  }
> > >
> > > +/* Komeda internal resources (pipelines) are shared between crtcs, and resources
> > > + * are released by disable_crtc. But if user forget disabling crtc like app quit
> > > + * abnormally, the resources can not be used by another crtc.
> > > + * Use drop_master to shutdown the device and make sure all the komeda resources
> > > + * have been released, and can be used for the next usage.
> > > + */
> >
> > No. If we want this, we need to implement this across drivers, not with
> > per-vendor hacks.
> >
> > The kerneldoc should have been a solid hint: "Only used by vmwgfx."
> > -Daniel
> 
> Hi Daniel:
> This drop_master is really what we want, can we update the doc and
> add komeda as a user of this hacks like "used by vmwfgx and komeda",
> or maybe directly promote this per-vendor hacks as an optional chip
> function ?

Still no, because it would mean different behaviour for arm/komeda
compared to everyone else. And we really don't want this, because this
would completely break flicker-less vt-switching.

Currently the only fallback for this case is the lastclose handler, which
atm just restores fbcon/fbdev. If you want to change/extend that to work
without fbdev, then that's the place to do the change. And across _all_
drm kms drivers, so that we have consistent behaviour.

kms is a cross-vendor api, vendor hacks are very, very much not cool.
-Daniel

> 
> James
> 
> > > +static void komeda_kms_drop_master(struct drm_device *dev,
> > > +   struct drm_file *file_priv)
> > > +{
> > > +drm_atomic_helper_shutdown(dev);
> > > +}
> > > +
> > >  static struct drm_driver komeda_kms_driver = {
> > >  .driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
> > >     DRIVER_PRIME | DRIVER_HAVE_IRQ,
> > >  .lastclose= drm_fb_helper_lastclose,
> > >  .irq_handler= komeda_kms_irq_handler,
> > > +.master_drop= komeda_kms_drop_master,
> > >  .gem_free_object_unlocked= drm_gem_cma_free_object,
> > >  .gem_vm_ops= &drm_gem_cma_vm_ops,
> > >  .dumb_create= komeda_gem_cma_dumb_create,
> > > --
> > > 1.9.1
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
