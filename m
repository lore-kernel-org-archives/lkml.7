Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC6AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C420520644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392568AbfFMQbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:31:13 -0400
Received: from foss.arm.com ([217.140.110.172]:36110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730890AbfFMI2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:28:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B48C6367;
        Thu, 13 Jun 2019 01:28:14 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 784543F694;
        Thu, 13 Jun 2019 01:28:14 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 3A02F682574; Thu, 13 Jun 2019 09:28:13 +0100 (BST)
Date:   Thu, 13 Jun 2019 09:28:13 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
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
Message-ID: <20190613082813.GM4173@e110455-lin.cambridge.arm.com>
References: <1560251589-31827-1-git-send-email-lowry.li@arm.com>
 <1560251589-31827-3-git-send-email-lowry.li@arm.com>
 <20190611123038.GC2458@phenom.ffwll.local>
 <20190612022617.GA8595@james-ThinkStation-P300>
 <20190613081727.GE23020@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613081727.GE23020@phenom.ffwll.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:17:27AM +0200, Daniel Vetter wrote:
> On Wed, Jun 12, 2019 at 02:26:24AM +0000, james qian wang (Arm Technology China) wrote:
> > On Tue, Jun 11, 2019 at 02:30:38PM +0200, Daniel Vetter wrote:
> > > On Tue, Jun 11, 2019 at 11:13:45AM +0000, Lowry Li (Arm Technology China) wrote:
> > > > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> > > >
> > > > The komeda internal resources (pipelines) are shared between crtcs,
> > > > and resources release by disable_crtc. This commit is working for once
> > > > user forgot disabling crtc like app quit abnomally, and then the
> > > > resources can not be used by another crtc. Adds drop_master to
> > > > shutdown the device and make sure all the komeda resources have been
> > > > released and can be used for the next usage.
> > > >
> > > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > > ---
> > > >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > index 8543860..647bce5 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > @@ -54,11 +54,24 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
> > > >  return status;
> > > >  }
> > > >
> > > > +/* Komeda internal resources (pipelines) are shared between crtcs, and resources
> > > > + * are released by disable_crtc. But if user forget disabling crtc like app quit
> > > > + * abnormally, the resources can not be used by another crtc.
> > > > + * Use drop_master to shutdown the device and make sure all the komeda resources
> > > > + * have been released, and can be used for the next usage.
> > > > + */
> > >
> > > No. If we want this, we need to implement this across drivers, not with
> > > per-vendor hacks.
> > >
> > > The kerneldoc should have been a solid hint: "Only used by vmwgfx."
> > > -Daniel
> > 
> > Hi Daniel:
> > This drop_master is really what we want, can we update the doc and
> > add komeda as a user of this hacks like "used by vmwfgx and komeda",
> > or maybe directly promote this per-vendor hacks as an optional chip
> > function ?
> 
> Still no, because it would mean different behaviour for arm/komeda
> compared to everyone else. And we really don't want this, because this
> would completely break flicker-less vt-switching.
> 
> Currently the only fallback for this case is the lastclose handler, which
> atm just restores fbcon/fbdev. If you want to change/extend that to work
> without fbdev, then that's the place to do the change. And across _all_
> drm kms drivers, so that we have consistent behaviour.

Slightly unrelated, just thinking of a solution and wanted confirmation/double
checking: can a CRTC be instantiated without any planes (or without a primary
plane)?

Best regards,
Liviu

> 
> kms is a cross-vendor api, vendor hacks are very, very much not cool.
> -Daniel
> 
> > 
> > James
> > 
> > > > +static void komeda_kms_drop_master(struct drm_device *dev,
> > > > +   struct drm_file *file_priv)
> > > > +{
> > > > +drm_atomic_helper_shutdown(dev);
> > > > +}
> > > > +
> > > >  static struct drm_driver komeda_kms_driver = {
> > > >  .driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
> > > >     DRIVER_PRIME | DRIVER_HAVE_IRQ,
> > > >  .lastclose= drm_fb_helper_lastclose,
> > > >  .irq_handler= komeda_kms_irq_handler,
> > > > +.master_drop= komeda_kms_drop_master,
> > > >  .gem_free_object_unlocked= drm_gem_cma_free_object,
> > > >  .gem_vm_ops= &drm_gem_cma_vm_ops,
> > > >  .dumb_create= komeda_gem_cma_dumb_create,
> > > > --
> > > > 1.9.1
> > > >
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
