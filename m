Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3E2C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE4A2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fwWPpCpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfFNHBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:01:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40020 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:01:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so1976340eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dp1vyblI9xZefRu90FfJ0jWsDj4/fBB8QJPOYWovBbI=;
        b=fwWPpCpPZBeSE1P7ePC5OBhIqcznkmjAYvx/PS3OrZlqf801VVRArPVf3vFMlWOC3N
         9/ObSsSqVZ2n2WmYhnWtX50XRsbICTpFRgP+j5xqXjM1Bq+5zgQe/P/bOLyqfBIvp6al
         N2SnYaA7+QEV7K9UOj3IKC8xkfVNuVAJHDj3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dp1vyblI9xZefRu90FfJ0jWsDj4/fBB8QJPOYWovBbI=;
        b=sIv8ptGQ/e4VPxavXpBmIKOrQ4+SWjF3PDk8abgaIkKKgrB/hED4RhUVbXOXMZpYpi
         VFSI1blBOzrkW5+QKKywLuYEWhacN/S7gRzJhe3iG6qB7bkTYVK6Vl7xmezeJmy6a+ML
         DqqqZWgxYTQ8O4X5wknpVU0k9DUbp0jAsyZk90LQ7hPRt+w/5KwLOpJyyBPpqzGMuf23
         ZtL9QQAM1tmPPr+XZXKcPOFSw/VLjeSTvdsyc5O2GrZFxTZiuTPEdGTST8/0XRForL7e
         7jKxRhzOAmehWqnBgA1KgS15a7qg/5vX+J4qUW0X0ATAoHYnPGOSiWvz/RrQ4Eko3crh
         Ni9w==
X-Gm-Message-State: APjAAAUKaqd0GpZvNjl6vlBkr2MxdiFrSBDTqLXoKhdfR2p0oRpXUsWl
        aAz9thOFnX++GS8D1S0SRX8USg==
X-Google-Smtp-Source: APXvYqyHj3CfCntG7I0ardpY6DmhOKCZMJxPu623HYrSHHIW0p/igmeftPUfAOp3Swvnfhtb+ZSaTQ==
X-Received: by 2002:a50:ca84:: with SMTP id x4mr14266458edh.228.1560495676266;
        Fri, 14 Jun 2019 00:01:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r12sm617599eda.39.2019.06.14.00.01.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 00:01:14 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:01:11 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
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
Message-ID: <20190614070111.GT23020@phenom.ffwll.local>
Mail-Followup-To: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
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
 <20190613090814.GJ23020@phenom.ffwll.local>
 <20190613132436.GN4173@e110455-lin.cambridge.arm.com>
 <20190613143008.GO23020@phenom.ffwll.local>
 <20190614054557.GA31993@james-ThinkStation-P300>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614054557.GA31993@james-ThinkStation-P300>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 05:46:04AM +0000, james qian wang (Arm Technology China) wrote:
> On Thu, Jun 13, 2019 at 04:30:08PM +0200, Daniel Vetter wrote:
> > On Thu, Jun 13, 2019 at 02:24:37PM +0100, Liviu Dudau wrote:
> > > On Thu, Jun 13, 2019 at 11:08:14AM +0200, Daniel Vetter wrote:
> > > > On Thu, Jun 13, 2019 at 09:28:13AM +0100, Liviu Dudau wrote:
> > > > > On Thu, Jun 13, 2019 at 10:17:27AM +0200, Daniel Vetter wrote:
> > > > > > On Wed, Jun 12, 2019 at 02:26:24AM +0000, james qian wang (Arm Technology China) wrote:
> > > > > > > On Tue, Jun 11, 2019 at 02:30:38PM +0200, Daniel Vetter wrote:
> > > > > > > > On Tue, Jun 11, 2019 at 11:13:45AM +0000, Lowry Li (Arm Technology China) wrote:
> > > > > > > > > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> > > > > > > > >
> > > > > > > > > The komeda internal resources (pipelines) are shared between crtcs,
> > > > > > > > > and resources release by disable_crtc. This commit is working for once
> > > > > > > > > user forgot disabling crtc like app quit abnomally, and then the
> > > > > > > > > resources can not be used by another crtc. Adds drop_master to
> > > > > > > > > shutdown the device and make sure all the komeda resources have been
> > > > > > > > > released and can be used for the next usage.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 13 +++++++++++++
> > > > > > > > >  1 file changed, 13 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > > > > > > index 8543860..647bce5 100644
> > > > > > > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > > > > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > > > > > > > @@ -54,11 +54,24 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
> > > > > > > > >  return status;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +/* Komeda internal resources (pipelines) are shared between crtcs, and resources
> > > > > > > > > + * are released by disable_crtc. But if user forget disabling crtc like app quit
> > > > > > > > > + * abnormally, the resources can not be used by another crtc.
> > > > > > > > > + * Use drop_master to shutdown the device and make sure all the komeda resources
> > > > > > > > > + * have been released, and can be used for the next usage.
> > > > > > > > > + */
> > > > > > > >
> > > > > > > > No. If we want this, we need to implement this across drivers, not with
> > > > > > > > per-vendor hacks.
> > > > > > > >
> > > > > > > > The kerneldoc should have been a solid hint: "Only used by vmwgfx."
> > > > > > > > -Daniel
> > > > > > >
> > > > > > > Hi Daniel:
> > > > > > > This drop_master is really what we want, can we update the doc and
> > > > > > > add komeda as a user of this hacks like "used by vmwfgx and komeda",
> > > > > > > or maybe directly promote this per-vendor hacks as an optional chip
> > > > > > > function ?
> > > > > >
> > > > > > Still no, because it would mean different behaviour for arm/komeda
> > > > > > compared to everyone else. And we really don't want this, because this
> > > > > > would completely break flicker-less vt-switching.
> > > > > >
> > > > > > Currently the only fallback for this case is the lastclose handler, which
> > > > > > atm just restores fbcon/fbdev. If you want to change/extend that to work
> > > > > > without fbdev, then that's the place to do the change. And across _all_
> > > > > > drm kms drivers, so that we have consistent behaviour.
> > > > >
> > > > > Slightly unrelated, just thinking of a solution and wanted confirmation/double
> > > > > checking: can a CRTC be instantiated without any planes (or without a primary
> > > > > plane)?
> > > >
> > > > Without a primary plane maybe not so recommended, because it would break
> > > > all the legacy userspace. Might even result in some oopses, not sure we
> > > > check for crtc->primary != NULL.
> > > >
> > > > I'm not sure what you mean about instantiating it without any plane at
> > > > all. That would be rather useless.
> > >
> > > Agree, and I think I have one way of solving the scenario Lowry and James are
> > > trying to cover. Basically, komeda has 2 pipelines that are exposed as 2 crtcs.
> > > However, layers (planes in DRM) can be associated with any of the pipelines and
> > > it is possible to have a DRM master open up crtc0 and enable all possible planes,
> > > which would leave crtc1 with no available layer to use (but technically still visible to
> > > userspace, as it has been drm_crtc_init-ed. James and Lowry are trying to give
> > > another master a chance of enabling crtc1 if previous master drops the
> > > ownership of crtc0 without disabling it. So one solution I'm thinking of is to
> > > tie one of the layers/planes to crtc1 regardless if that pipeline is enabled or
> > > not.
> > >
> > > Alternatively, we need a more generic solution for re-allocating resources
> > > between CRTCs that might be enabled at different times. Ideas on how userspace
> > > should handle it first are welcome as well.
> >
> > Uh, you can't have more than one active master. And that other master
> > needs to clean up the mess left behind by the previous one. Generally that
> 
> Yes komeda needs such clean up (disableing all planes is
> enough for such cleanup), but no matter it handles by old master or
> the new master, just before the new master enable the crtc is enouth
> for komeda.
> I think the problem here is which place we should do such cleanup:
> USER or KERNEL mode.
> 
> For kernel: set_master/drop_master is a good place.
> For user: enter_vt and leave_vt.

Well someone else already made that decision for you, userspace needs to
clean up.

If we want to change that, then we need to have a subsystem wide
discussion, and roll out the new behaviour (without breaking any
expectations of current userspace, which your patch does) for everyone.

For more context, I've written up what could all be possible new/existing
solutions in this space quite a while ago:

https://blog.ffwll.ch/2016/01/vt-switching-with-atomic-modeset.html

> Why I decide to add it to kernel:
> - So many users: X/wayland/Android, avoid duplidated code.
> - we also plan to support third-part user. they may not do such
>   cleanup for komeda.

Fix your userspace :-)

Cheers, Daniel

> 
> Thanks
> James
> 
> > means disabling all the planes, like e.g. fbdev emulation does (but
> > there's a lot more we should probably clean up, current code is kinda just
> > good enough).
> >
> > If you want multiple concurrent masters on the same hw, then you need drm
> > leases, and there you can limit the leases to however many planes you
> > think they need.
> > -Daniel
> >
> > >
> > > Best regards,
> > > Liviu
> > >
> > > > -Daniel
> > > >
> > > > >
> > > > > Best regards,
> > > > > Liviu
> > > > >
> > > > > >
> > > > > > kms is a cross-vendor api, vendor hacks are very, very much not cool.
> > > > > > -Daniel
> > > > > >
> > > > > > >
> > > > > > > James
> > > > > > >
> > > > > > > > > +static void komeda_kms_drop_master(struct drm_device *dev,
> > > > > > > > > +   struct drm_file *file_priv)
> > > > > > > > > +{
> > > > > > > > > +drm_atomic_helper_shutdown(dev);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static struct drm_driver komeda_kms_driver = {
> > > > > > > > >  .driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
> > > > > > > > >     DRIVER_PRIME | DRIVER_HAVE_IRQ,
> > > > > > > > >  .lastclose= drm_fb_helper_lastclose,
> > > > > > > > >  .irq_handler= komeda_kms_irq_handler,
> > > > > > > > > +.master_drop= komeda_kms_drop_master,
> > > > > > > > >  .gem_free_object_unlocked= drm_gem_cma_free_object,
> > > > > > > > >  .gem_vm_ops= &drm_gem_cma_vm_ops,
> > > > > > > > >  .dumb_create= komeda_gem_cma_dumb_create,
> > > > > > > > > --
> > > > > > > > > 1.9.1
> > > > > > > > >
> > > > > > > > > _______________________________________________
> > > > > > > > > dri-devel mailing list
> > > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > > > >
> > > > > > > > --
> > > > > > > > Daniel Vetter
> > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > http://blog.ffwll.ch
> > > > > > > IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> > > > > > > _______________________________________________
> > > > > > > dri-devel mailing list
> > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > >
> > > > > > --
> > > > > > Daniel Vetter
> > > > > > Software Engineer, Intel Corporation
> > > > > > http://blog.ffwll.ch
> > > > >
> > > > > --
> > > > > ====================
> > > > > | I would like to |
> > > > > | fix the world,  |
> > > > > | but they're not |
> > > > > | giving me the   |
> > > > >  \ source code!  /
> > > > >   ---------------
> > > > >     ¯\_(ツ)_/¯
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > >
> > > --
> > > ====================
> > > | I would like to |
> > > | fix the world,  |
> > > | but they're not |
> > > | giving me the   |
> > >  \ source code!  /
> > >   ---------------
> > >     ¯\_(ツ)_/¯
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
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
