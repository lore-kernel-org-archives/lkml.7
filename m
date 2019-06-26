Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF2DC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDFD2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fuw0xmzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfFZO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:26:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35000 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfFZO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:26:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so3680620edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+Sws+y+jIZZelBzcnrJJ0ZS8ppZIP3b1lsfL6ibj+Hg=;
        b=fuw0xmzWVsvYQ7NHziWwmctpltE/r/OGyFMtcvpw9sv8qBO+YV33n0Mc7j6fQqiqfB
         Ja3+Ej4QXaQx/e8rB+5pVFuvF3r+CMYb/7JrhhKN0WLIG5LsbzDOWiR//ynyAmk2sI5H
         KiJKUjzIa6YTwpMxeeH8JoevX2edcOhSC//Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+Sws+y+jIZZelBzcnrJJ0ZS8ppZIP3b1lsfL6ibj+Hg=;
        b=MHDh6/gHAxXtjzgAkwNaggxZ6IrRx0o3/duSaXfajMqzTQpeZPBG1VXZT7/rVwJ0JF
         wVP79qfNGutbT2XTzjAiVUgHMpJiLTzluARfwcuHjDAbXdJpcxtRVKxO3pApWU2KwQ2R
         4wem5ATMTLqh1VSJImoFqi9sSwFvKKJ87l/Ol2KqK8o9O5dr3ysClxJEdWnkBGHslhdD
         zWYgyl8uot6kHZZvmVp6f2bKQ2FdSWUgzJzvoHo9zdhfMRvYjCo2oWflJfFvDEP0IUov
         2oS8vG/bQN8jrvOFqQfIqgk/WUgQpWOIXneuc80/naIFzjlrXVBWzMbnl5OBoPFkBBVw
         AZGA==
X-Gm-Message-State: APjAAAW9UfPk5EOCBZd919OwNY30IVK9yAH43+59tQpn9c5QqgVZHLvI
        nzh1yfR2Y14UIKa7R6xg7WLA3w==
X-Google-Smtp-Source: APXvYqyp08IXUCIUK4l7d2Jt1o6F4hinDBwuiLEx0381nHzALAYQWsl3wQcRoV43OyBk7eOaVJjQlw==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr4451217ejd.234.1561559215925;
        Wed, 26 Jun 2019 07:26:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j17sm6164900ede.60.2019.06.26.07.26.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 07:26:55 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:26:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH V4] drm/drm_vblank: Change EINVAL by the
 correct errno
Message-ID: <20190626142652.GL12905@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>
References: <20190619020750.swzerehjbvx6sbk2@smtp.gmail.com>
 <20190619074856.GJ12905@phenom.ffwll.local>
 <20190619075059.GK12905@phenom.ffwll.local>
 <20190626020005.vb5gmqcvkyzgcjee@smtp.gmail.com>
 <CAKMK7uEd71XTeuZeu1Km8Vq1K1VJJbgANyaZNWm4v18Qh-OqVw@mail.gmail.com>
 <CADKXj+5+QHr1a0aiVZ1cSiPbtZhUAjmqiTmoQHGyEhodbcA2WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADKXj+5+QHr1a0aiVZ1cSiPbtZhUAjmqiTmoQHGyEhodbcA2WQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:37:11AM -0300, Rodrigo Siqueira wrote:
> On Wed, Jun 26, 2019 at 4:53 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Jun 26, 2019 at 4:00 AM Rodrigo Siqueira
> > <rodrigosiqueiramelo@gmail.com> wrote:
> > >
> > > On 06/19, Daniel Vetter wrote:
> > > > On Wed, Jun 19, 2019 at 09:48:56AM +0200, Daniel Vetter wrote:
> > > > > On Tue, Jun 18, 2019 at 11:07:50PM -0300, Rodrigo Siqueira wrote:
> > > > > > For historical reason, the function drm_wait_vblank_ioctl always return
> > > > > > -EINVAL if something gets wrong. This scenario limits the flexibility
> > > > > > for the userspace make detailed verification of the problem and take
> > > > > > some action. In particular, the validation of “if (!dev->irq_enabled)”
> > > > > > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > > > > > support vblank or not. If the driver does not support VBlank, the
> > > > > > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > > > > > the real issue; this patch changes this behavior by return EOPNOTSUPP.
> > > > > > Additionally, some operations are unsupported by this function, and
> > > > > > returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> > > > > > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> > > > > > libdrm, which is used by many compositors; because of this, it is
> > > > > > important to check if this change breaks any compositor. In this sense,
> > > > > > the following projects were examined:
> > > > > >
> > > > > > * Drm-hwcomposer
> > > > > > * Kwin
> > > > > > * Sway
> > > > > > * Wlroots
> > > > > > * Wayland-core
> > > > > > * Weston
> > > > > > * Xorg (67 different drivers)
> > > > > >
> > > > > > For each repository the verification happened in three steps:
> > > > > >
> > > > > > * Update the main branch
> > > > > > * Look for any occurrence "drmWaitVBlank" with the command:
> > > > > >   git grep -n "drmWaitVBlank"
> > > > > > * Look in the git history of the project with the command:
> > > > > >   git log -SdrmWaitVBlank
> > > > > >
> > > > > > Finally, none of the above projects validate the use of EINVAL which
> > > > > > make safe, at least for these projects, to change the return values.
> > > > > >
> > > > > > Change since V3:
> > > > > >  - Return EINVAL for _DRM_VBLANK_SIGNAL (Daniel)
> > > > > >
> > > > > > Change since V2:
> > > > > >  Daniel Vetter and Chris Wilson
> > > > > >  - Replace ENOTTY by EOPNOTSUPP
> > > > > >  - Return EINVAL if the parameters are wrong
> > > > > >
> > > > >
> > > > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > >
> > > > > Apologies for the confusion on the last time around. btw if someone tells
> > > > > you "r-b (or a-b) with these changes", then just apply the r-b/a-b tag
> > > > > next time around. Otherwise people will re-review the same thing over and
> > > > > over again.
> > > >
> > > > btw when resending patches it's good practice to add anyone who commented
> > > > on it (or who commented on the igt test for the same patch and other way
> > > > round) onto the explicit Cc: list of the patch. That way it's easier for
> > > > them to follow the patch evolution and do a quick r-b once they're happy.
> > >
> > > Thanks for these valuable tips.
> > > Do you think that is a good idea to resend this patch CC's everybody? Or
> > > is it ok if I just apply it?
> >
> > Hm I thought I answered that on irc ... but just today I realized that
> > we missed 2 ioctls. There's also drm_crtc_get_sequence_ioctl and
> > drm_crtc_queue_sequence_ioctl which have the same dev->irq_enabled
> > check and I think should be treated the same.
> 
> Hi,
> 
> I reexamined all the composers described in the commit message (latest
> versions) to check if any project use and validate the return value
> from  drm_crtc_get_sequence_ioctl and drm_crtc_queue_sequence_ioctl. I
> noticed that mesa and xserver use them. FWIU replace EINVAL by
> EOPNOTSUPP is harmless for mesa project, however it is not the same
> for xserver.
> 
> Take a look at line 189 and 238 of hw/xfree86/drivers/modesetting/vblank.c
> 
> * https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/drivers/modesetting/vblank.c#L238
> * https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/drivers/modesetting/vblank.c#L189
> 
> A little bit below the above lines, you can see a validation like that:
> 
>   if (ret != -1 || (errno != ENOTTY && errno != EINVAL))
> 
> In other words, if we change the EINVAL by EOPNOTSUPP
> drm_crtc_[get|queue]_sequence_ioctl we could break xserver. I noticed
> that Keith Packard introduced these ioctls to the kernel and also to
> the xserver, I will prepare a new version and CC Keith. Should I do
> another thing to notify xserver developers?

If you want cc: xorg-devel or so, but I think they all moved to gitlab and
the m-l is pretty dead. Cc'ing Keith should be enough.

I looked at the code and I think we're fine. Better than fine actually,
because if dev->irq_enabled == false then we really shouldn't use vblank
ioctl, no matter whether the new or old version.

So for drivers without vblank support, all that will happen is that we
leave ->has_queue_sequence as false and then fail a bit later on with the
legacy ioctl. Should be all harmless.

Note that the idea behind filtering out EINVAL is that if you do a
QueueSequence on a crtc that's currently off, then it'll fail with EINVAL.
But the ioctl still works, hence why we want to accept that. Setting
has_queue_sequence = TRUE for the case where there's actually no vblank
might trigger a bug somewhere later on.
-Daniel

> 
> Thanks
> 
> > Can you pls resend with those addressed too? Then you can also resend
> > with the cc's all added.
> > -Daniel
> >
> > >
> > > > If you don't do that then much bigger chances your patch gets ignored.
> > > > -Daniel
> > > > >
> > > > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/drm_vblank.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > > > > > index 603ab105125d..bed233361614 100644
> > > > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > > > @@ -1582,7 +1582,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> > > > > >   unsigned int flags, pipe, high_pipe;
> > > > > >
> > > > > >   if (!dev->irq_enabled)
> > > > > > -         return -EINVAL;
> > > > > > +         return -EOPNOTSUPP;
> > > > > >
> > > > > >   if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > > > > >           return -EINVAL;
> > > > > > --
> > > > > > 2.21.0
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > >
> > > --
> > > Rodrigo Siqueira
> > > https://siqueira.tech
> > > _______________________________________________
> > > Intel-gfx mailing list
> > > Intel-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> 
> 
> 
> -- 
> 
> Rodrigo Siqueira
> https://siqueira.tech

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
