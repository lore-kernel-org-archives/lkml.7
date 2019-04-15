Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4788C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6882220684
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="au2i07l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfDOQEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:04:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39933 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfDOQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:04:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id k45so15177616edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tGLBZWP5CXRLK+Kp3DeCDIiMD+kvtL4Oy1cNPUHhImM=;
        b=au2i07l+BH5G6hauFkZj6L5aemQddnsks8qXaKQZhKed6mkNoNwa5YGt9h12NhOa4G
         0y/kBCoklawMqX2SVFUbrB+9yvmfHAnyT8BuOREMseZnIuL/T1/uALktFvvqUlaMTqs/
         8JJ4jo9VR4fDoLwUIoI/kvm0GUldJ/Pwrz2tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tGLBZWP5CXRLK+Kp3DeCDIiMD+kvtL4Oy1cNPUHhImM=;
        b=mUavRtYBzz3oBgWNkEX3HdvZEmg+hN1tpM4Mbs2/qlklktFuWQlG5qFllLzuizlg4u
         H/03E7ctzLDCUxUoMThMhF0YmXlsOvSOhk2Cl5O0hZ0bs+x50dYlJ5Iuin+/RxLgERCL
         1UDYK0Lst458+1AHNhR0Q9UrPB4L4G9mcGcyMnIZp20UK9S8T290byxaYQQdyn0+LjDP
         61DC1DbekNVWf1yMKbnXatwvWXpAOgLUGkKbeGdzgv7kJXeiPnQ4d6ldFKP8kEUAaxAp
         X1niGoQ2WjCu5g9HIFJWcy//ClbmtTO4TslUxEhYarmJyLCW/N+kp5JLtjhLzd2PNYFt
         ZTSA==
X-Gm-Message-State: APjAAAWFLwKamPHxnJwrlH4TMrSEGKiWFDs26Rx17uwEzb4/5BQt0h/P
        8WChtvbNHW22jekMDbjoVjt0Ag==
X-Google-Smtp-Source: APXvYqzs0ChClUmXAn/RBb3VUCtx6B3qBGte1kdDH1D2N1ZvBiC8bjP6ljwqmr4t5ap5En15pyzeSw==
X-Received: by 2002:a17:906:7f93:: with SMTP id f19mr22082642ejr.75.1555344251297;
        Mon, 15 Apr 2019 09:04:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y12sm3726607edh.29.2019.04.15.09.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 09:04:10 -0700 (PDT)
Date:   Mon, 15 Apr 2019 18:04:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Eric Engestrom <eric.engestrom@intel.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH libdrm] headers: Sync with drm-next
Message-ID: <20190415160408.GD2665@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
References: <20190408205422.dj7z4dl36nauwlk7@intel.com>
 <1554809706-15389-1-git-send-email-ayan.halder@arm.com>
 <20190409115913.hvyjxlda4wtzm75t@intel.com>
 <20190409122710.k2bh25xg43lrqzvq@intel.com>
 <CAF6AEGvUsWF+_dZzGBM1BYnwvZRY9T0P7OGq30KJLohFU3soKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGvUsWF+_dZzGBM1BYnwvZRY9T0P7OGq30KJLohFU3soKg@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:49:33PM -0400, Rob Clark wrote:
> On Tue, Apr 9, 2019 at 8:27 AM Eric Engestrom <eric.engestrom@intel.com> wrote:
> >
> > On Tuesday, 2019-04-09 12:59:13 +0100, Eric Engestrom wrote:
> > > On Tuesday, 2019-04-09 11:35:14 +0000, Ayan Halder wrote:
> > > > Generated using make headers_install from the drm-next
> > > > tree - git://anongit.freedesktop.org/drm/drm
> > > > branch - drm-next
> > > > commit - 14d2bd53a47a7e1cb3e03d00a6b952734cf90f3f
> > > >
> > > > The changes were as follows :-
> > > >
> > > > core: (drm.h, drm_fourcc.h, drm_mode.h)
> > > > - Added 'struct drm_syncobj_transfer', 'struct drm_syncobj_timeline_wait' and 'struct drm_syncobj_timeline_array'
> > > > - Added various DRM_IOCTL_SYNCOBJ_ ioctls
> > > > - Added some new RGB and YUV formats
> > > > - Added 'DRM_FORMAT_MOD_VENDOR_ALLWINNER'
> > > > - Added 'SAMSUNG' and Arm's 'AFBC' and 'ALLWINNER' format modifiers
> > > > - Added 'struct drm_mode_rect'
> > > >
> > > > i915:
> > > > - Added struct 'struct i915_user_extension' and various 'struct drm_i915_gem_context_'
> > > > - Added different modes of per-process Graphics Translation Table
> > > >
> > > > msm:
> > > > - Added various get or set GEM buffer info flags
> > > > - Added some MSM_SUBMIT_BO_ macros
> > > > - Modified 'struct drm_msm_gem_info'
> > > >
> > > > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > >
> > > This looks sane, and applies cleanly :)
> > > Acked-by: Eric Engestrom <eric.engestrom@intel.com>
> >
> > Actually, revoking that, as this patch breaks the build; see below.
> >
> > >
> > > > ---
> > > >  include/drm/drm.h        |  36 +++++++
> > > >  include/drm/drm_fourcc.h | 136 +++++++++++++++++++++++++++
> > > >  include/drm/drm_mode.h   |  23 ++++-
> > > >  include/drm/i915_drm.h   | 237 ++++++++++++++++++++++++++++++++++++++++-------
> > > >  include/drm/msm_drm.h    |  25 +++--
> > > >  5 files changed, 415 insertions(+), 42 deletions(-)
> > > >
> > [snip]
> > > > diff --git a/include/drm/msm_drm.h b/include/drm/msm_drm.h
> > > > index c06d0a5..91a16b3 100644
> > > > --- a/include/drm/msm_drm.h
> > > > +++ b/include/drm/msm_drm.h
> > > > @@ -105,14 +105,24 @@ struct drm_msm_gem_new {
> > > >     __u32 handle;         /* out */
> > > >  };
> > > >
> > > > -#define MSM_INFO_IOVA      0x01
> > > > -
> > > > -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> > > > +/* Get or set GEM buffer info.  The requested value can be passed
> > > > + * directly in 'value', or for data larger than 64b 'value' is a
> > > > + * pointer to userspace buffer, with 'len' specifying the number of
> > > > + * bytes copied into that buffer.  For info returned by pointer,
> > > > + * calling the GEM_INFO ioctl with null 'value' will return the
> > > > + * required buffer size in 'len'
> > > > + */
> > > > +#define MSM_INFO_GET_OFFSET        0x00   /* get mmap() offset, returned by value */
> > > > +#define MSM_INFO_GET_IOVA  0x01   /* get iova, returned by value */
> > > > +#define MSM_INFO_SET_NAME  0x02   /* set the debug name (by pointer) */
> > > > +#define MSM_INFO_GET_NAME  0x03   /* get debug name, returned by pointer */
> > > >
> > > >  struct drm_msm_gem_info {
> > > >     __u32 handle;         /* in */
> > > > -   __u32 flags;          /* in - combination of MSM_INFO_* flags */
> > > > -   __u64 offset;         /* out, mmap() offset or iova */
> > > > +   __u32 info;           /* in - one of MSM_INFO_* */
> > > > +   __u64 value;          /* in or out */
> > > > +   __u32 len;            /* in or out */
> > > > +   __u32 pad;
> >
> > freedreno/msm/msm_bo.c needs to be updated to reflect those changes.
> 
> 
> I think you can just rename flags->info and offset->value, the rest of
> the struct should be zero-initialized.. if in doubt you can check
> $mesa/src/freedreno/drm/msm_bo.c
> 
> side-note:  the libdrm_freedreno code was folded into mesa in 19.0, so
> at *some* point we can probably disable libdrm_freedreno build by
> default.  (I'd kinda still like to keep the code around for some misc
> standalone tools I have, but that is the sort of thing where I can fix
> libdrm if it gets broken).  When to switch to disabled by default I
> guess comes down to how long we want to support mesa 18.x with latest
> libdrm??  Maybe after 19.1, since (selfishly motivated) that gives me
> a long enough window back in case I find myself needing to bisect for
> some regression..

Sidenote: renaming fields breaks uapi (but not uabi), so not really great.
Even if it doesn't matter for you since you copypasted the headers into
mesa ... Dont do this, it's regrets :-)

If you want to do rename uapi without breaking stuff, create a new
structure with new field names, that happens to match the old one. Plus
add a comment. So

struct drm_msm_gem_info2 {
   __u32 handle;         /* in */
   __u32 info;           /* in - one of MSM_INFO_* */
   __u64 value;          /* in or out */
   __u32 len;            /* in or out */
   __u32 pad;
};

You can just use that struct in the IOCTL number define, stuff will work
out correctly (we don't typecheck these in userspace, and lenght
mismatches are handled by the kernel automatically anyway).

-Daniel

> 
> BR,
> -R
> 
> >
> > > >  };
> > > >
> > > >  #define MSM_PREP_READ        0x01
> > > > @@ -188,8 +198,11 @@ struct drm_msm_gem_submit_cmd {
> > > >   */
> > > >  #define MSM_SUBMIT_BO_READ             0x0001
> > > >  #define MSM_SUBMIT_BO_WRITE            0x0002
> > > > +#define MSM_SUBMIT_BO_DUMP             0x0004
> > > >
> > > > -#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | MSM_SUBMIT_BO_WRITE)
> > > > +#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
> > > > +                                   MSM_SUBMIT_BO_WRITE | \
> > > > +                                   MSM_SUBMIT_BO_DUMP)
> > > >
> > > >  struct drm_msm_gem_submit_bo {
> > > >     __u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
> > > > --
> > > > 2.7.4
> > > >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
